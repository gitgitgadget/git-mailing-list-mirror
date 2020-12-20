Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8EC4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6B22DBF
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgLTCUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 21:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgLTCUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 21:20:46 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B6C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 18:20:02 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id x203so1504865ooa.9
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 18:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoePeMkNI64BexQrxqvF8xgNSXFUit0xX9J1FlXztQU=;
        b=iaaRncGM14tftOECr9phcWlGrLs+f/6KR86VBBqwrlMlapLHnhEAHUb0QU1FutONRl
         SOWLODHJVVul+R0/cN8OBVNsw4JTrYPyOtldIYAIZWyc4apmAW8d/C7GL8uLFc7b5o7a
         km2u7CT6izsedyjRYcOoTbM7LkuHop/XqrHPZ9sKjp5CNbYi31VFiYTn0Z40ykUDV8jq
         ixS/kbBCiAtskWtLnBFSCsrACmcx9PV1XR8blaDzEsoo3TNvE6cQAGcbv6JUtWXxDSBp
         vj33oG0pU1/kTqa+acQfZwvyJ0zASRM2tKPeUxN/ZnPkvBJqbPTnKnLDTOoZcUSaqkem
         4cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoePeMkNI64BexQrxqvF8xgNSXFUit0xX9J1FlXztQU=;
        b=jacrWtMbOdPAqm7bFT+/NBf+iRfPbkfBuskIOI9AqSZidPFYlM/rnIvAHBW3bjz8lr
         ynqGrczL43SPKs3mzIMYJK1ShXBJDKUwVNFSbfxrL/dvehLVyVd2sU/PzM5JiqVK9nSx
         yowyxw3HpOxwZfrQTN0DKFVGB22eARko1OmFbgExm14liDtfTjcFVYLtlxAyKJP7Jd55
         wyRADJhu1fYZdxhbhmG3krxA3Ynf5Nu2FziWHeYT1xs41MJ5SM0zkz/0NxvckYOtcUoG
         FmyaXMPvSVhWh+WIVqIqcMH9le8hp8JX3H4SnnOyJEUpIq/nvj+6Ky7Do/wIl6f1m7BC
         RO0g==
X-Gm-Message-State: AOAM532bXnh1CPnXZE0NcXaB96CrLQcewHIrNYmlrCQLIiAyYCgKPvLa
        O3IYl7KFTxVBRwDTNcteFN/O+datKRtCHF41qzrSG8IzxUYFKA==
X-Google-Smtp-Source: ABdhPJznHTYVfD0G70aLsqXriZhNriMAxp5D+4pZbkRCZLOOHSeBsZPGeRLcemdTWcPJkK4uSsxatYx0Q9t4jG1wyfk=
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr7549728oot.32.1608430801299;
 Sat, 19 Dec 2020 18:20:01 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Dec 2020 18:19:50 -0800
Message-ID: <CABPp-BFoSz40-1mNLrxCgMTccYqLOg6ifX5PeLDutbimF9ysPQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 9:37 PM Junio C Hamano <gitster@pobox.com> wrote:

> A release candidate 2.30-rc1 has been tagged; there are too many
> topics in flight, sadly many of which haven't been adequately
> reviewed.  I think there are a couple of topics left in 'next' that
> are obvious candidates for the final, but it would be lovely if we
> can figure out how to get topics in 'seen' that haven't got enough
> love unstuck.

I'll try to post an RFC on the sparse-checkout handling soon; sorry
it's taken me a while.  One question on your labelling for the
merge-ort, stuff, though...

> * en/merge-ort-recursive (2020-12-16) 4 commits
>  - merge-ort: implement merge_incore_recursive()
>  - merge-ort: make clear_internal_opts() aware of partial clearing
>  - merge-ort: copy a few small helper functions from merge-recursive.c
>  - commit: move reverse_commit_list() from merge-recursive
>  (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-3.)

...this comment here is repeated below...

> * en/merge-ort-3 (2020-12-15) 11 commits
>  - merge-ort: add implementation of type-changed rename handling
>  - merge-ort: add implementation of normal rename handling
>  - merge-ort: add implementation of rename collisions
>  - merge-ort: add implementation of rename/delete conflicts
>  - merge-ort: add implementation of both sides renaming differently
>  - merge-ort: add implementation of both sides renaming identically
>  - merge-ort: add basic outline for process_renames()
>  - merge-ort: implement compare_pairs() and collect_renames()
>  - merge-ort: implement detect_regular_renames()
>  - merge-ort: add initial outline for basic rename detection
>  - merge-ort: add basic data structures for handling renames
>  (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-recursive.)

What do you mean when you say these two topics are tangled?  They were
written to avoid all contextual conflicts, and to be allowed to merge
in either order, and I just re-verified that they merge cleanly.  So
I'm not understanding this comment.

If there are any remaining issues in this series, I'd be happy to fix
them up.  I'm not aware of any, and Stollee has reviewed the
series[1].  I was planning on submitting another topic next week,
directory rename detection, that builds on this series.

[1] https://lore.kernel.org/git/6448806f-791b-610a-06de-7be5650334e6@gmail.com/,
note that his comment was on series v2 and I addressed his one
remaining point in v3.
