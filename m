Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D48C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383F460E97
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbhHJPwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhHJPwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 11:52:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E4C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 08:51:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s184so32910447ios.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0uqfweOMlYM9QGz4wM07C/43qcI+aQ/vqFNF39rOkc=;
        b=SmwT08kYaKAuvPPQEruzxYgEBtJTMuhs4gMkMcewmchR2GO5QURWa9TNu9BlXn8eRC
         rZ/r0ncdE3ngQws5GaiMxLR6UidrD6qH+1pwUqAA9MVKo0x8zNgt3PTBWY8R4ZC1TefJ
         4dxVCAfrBWgwH4z++ih5hWtJp2N8eQgqZYewa59hsXOwMSTdIeCdejnto29QVy9BiEZc
         ApjMc4Wmk57ClxVYYQimXwp8UCki69X9uOT4kz1UQf8Uc54OYPVIrgz+UyrpQ1eEFKCT
         lJdjNm/8nQ+CSPq7X0aL99lrnTSCog224Zd++gx+icA9VU/7002D0Q0JjRVVaEIk/xTJ
         9wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0uqfweOMlYM9QGz4wM07C/43qcI+aQ/vqFNF39rOkc=;
        b=L0CbFSXXQxehlmAvIL79uWdEfq/cnnQ0VQHMD6NDBmT+POCdOBBabC6km2WEwzGe8Q
         OaA8fvrfXFdY6I8z1KZF4iSsiaXhfCts0lANlYSizax7zsvrb8MyTvQxyEbQJLh1x7dC
         yuM7ddBMINfd9dF7xBbXqTO0tbznVXVxF+g4ucQuHlTmmt3IBcddrOK9XeHe9Y5A16XU
         gFPHVlTvZWi9mNNiXn773I11b5a8I8SvNw1IZINk4fLqTiNy3mC82OwmhBzxQ9mHoLX6
         gzPEmnn4ZMaZphKJUBda2rdXZBC01VPeYo6ppXzjQ9KfCelmXymBwj/BHaNar0BKu0x3
         vlzw==
X-Gm-Message-State: AOAM530jj7m3/Ur4wIYoansV6Xp2sWh+gIJoqwvbUeRdDiZcRiJCDyZJ
        0H/U1lU3a4k2bCsGkWtOEr4j4TVi61rb7HhMADk=
X-Google-Smtp-Source: ABdhPJyMTio5yNXKJTYbcM7d97i62G2hcMoy5ezmcmlfj7KTaDIiyc9OiQ4tOTxjpXJcecCGK8o7ZOfftNG6PcSvJi8=
X-Received: by 2002:a6b:c305:: with SMTP id t5mr289580iof.123.1628610717720;
 Tue, 10 Aug 2021 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
 <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com> <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com>
In-Reply-To: <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Tue, 10 Aug 2021 18:51:40 +0300
Message-ID: <CAPkN8xLN_fKdbU8ugxLYJ1YeCJ8CxBWh+kdhAq1mR8hfAe-NAA@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 9:15 PM Elijah Newren <newren@gmail.com> wrote:
>
> The author wasn't interested in implementing that
> suggestion (and it's a low priority for me that I may never get around
> to).  The series also wasn't pushed through and eventually was
> dropped.

What it takes to validate the commit signature? Isn't it the same as
validating commit tag? Is it possible to merge at least the `--fast-export`
part? The effect of roundtrip would be the same, but at least external
tools would be able to detect signed commits and warn users.

> [1] https://lore.kernel.org/git/20210430232537.1131641-1-lukeshu@lukeshu.com/

> Yes, and I mentioned several other reasons why a round-trip from
> fast-export through fast-import cannot be relied upon to preserve
> object hashes.

Yes, I understand that. What would be the recommended way to detect
which commits would change as a result of the round-trip? It will then
be possible to warn users in `reposurgeon` `lint` command.

> (3) fast-export works by looking for the relevant bits it knows how to
> export.  You'd have to redesign it to fully parse every bit of data in
> each object it looks at, throw errors if it didn't recognize any, and
> make sure it exports all the bits.  That might be difficult since it's
> hard to know how to future proof it.  How do you guarantee you've
> printed every field in a commit struct, when that struct might gain
> new fields in the future?  (This is especially challenging since
> fast-export/fast-import might not be considered core tools, or at
> least don't get as much attention as the "truly core" parts of git;
> see https://lore.kernel.org/git/xmqq36mxdnpz.fsf@gitster-ct.c.googlers.com/)

Looks like the only way to make it forward compatible is to introduce
some kind of versioning and a validation schema like protobuf. Otherwise
writing an importer and exporter for each and every thing that may
encounter in a git stream may be unrealistic, yes.

> > P.S. I am resurrecting the old thread, because my problem with editing
> > the history of the repository with an external tool still can not be solved.
>
> Sure it can, just use fast-export's --reference-excluded-parents
> option and don't export commits you know you won't need to change.

How does `--reference-excluded-parents` help to read signed commits?

`reposurgeon` needs all commits to select those that are needed by
different criteria. It is hard to tell which commits are not important without
reading and processing them first.

> Or, if for some reason you are really set on exporting everything and
> then editing, then go ahead and create the full fast-export output,
> including with all your edits, and then post-process it manually
> before feeding to fast-import.  In particular, in the post-processing
> step find the commits that were problematic that you know won't be
> modified, such as your signed commit.  Then go edit that fast-export
> dump and (a) remove the dump of the no-longer-signed signed commit
> (because you don't want it), and (b) replace any references to the
> no-longer-signed-commit (e.g. "from :12") to instead use the hash of
> the actual original signed commit (e.g. "from
> d3d24b63446c7d06586eaa51764ff0c619113f09").  If you do that, then git
> fast-import will just build the new commits on the existing signed
> commit instead of on some new commit that is missing the signature.
> Technically, you can even skip step (a), as all it will do is produce
> an extra commit in your repository that isn't used and thus will be
> garbage collected later.

The problem is to detect problematic signed commits, because as I
understand `fast-export` doesn't give any signs if commits were signed
before the export.
-- 
anatoly t.
