Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2638BC433E5
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0460120729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SucGM0XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgG0Shk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG0Shj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 14:37:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6FCC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:37:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id di22so5715284edb.12
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2QAvAcJ9wSKyP4P7N9GNscGQsPW5oJjPK6pjg6grX8=;
        b=SucGM0XPKxAtOQ8uL58P3qH8+JvWpn8N4J65L4nFRH1d3KUVq3xnMhT48TleUIsLMe
         JPWHeE9sA3wC+h6w0oQiduzjEmw9VIqIyqCnnOhtC+62ZK4n7Qn732M9VNqwlPpsdmcP
         owzMCqj+eWUfztryTAhnRjA7N69zLYnxmuDWhmvw7euk9wnAH/m1EX6j2TXNd4VfQLzO
         20ORz+V18VDxTY2TDLkpMsUYisDMyUdkgty7PsofRTVbDz78wYPWDawbPnn5GY51pcbz
         TFMELYJgR1oXdVX5osMp5gxKSfFcm3XXfMqWFBnKtiMEDZF7yJ17k1ef4371Kra35/MH
         IqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2QAvAcJ9wSKyP4P7N9GNscGQsPW5oJjPK6pjg6grX8=;
        b=JagIk0N4L3SLpLp9IHKvE93yJY8xmQQjcL+tEM2hXCz/eHnB1+XG1xOmDFXY5d4Sfa
         BO75i5np7wxoJkDYA44NEWSSl50i0Uqpiy8RLTT3Pb47rlGYtciO7POqVLD2MZqd5y3k
         E0526yL28J5pI+RTqshzugx3Q2JDFKpzt/bR8VFYnyhNtnn7BNC4BNZ5sfvhuLO+GZyF
         7/QjucpE9cFxifMTlTTnL5kQofWz3UlA7qD16TLJklH907CzQ9tjl2D1tQgMwIqeZnKq
         9tyH1PhAc2FIPUOlKw0LtN2v3s3Cv9l0SYGlqaKUCkTx9gsQMeZD/iTO/6OkfVH0EPJG
         NgnA==
X-Gm-Message-State: AOAM531qRW5gqDVdCFfFO5ZB11HsF+x/anCTftImN3IwgIp3zBMqmWEH
        gSKIInFiTOiXgSi6JBeILSaj1a/9XTO/p7asmRc=
X-Google-Smtp-Source: ABdhPJx4fmmecw4k8Db3km7bLoWfpsvRDtTC/7qBjbn2daSUKdkg1HLLup9kaf6V5fKqcKpfSF74DBogTpXFGVzEfhU=
X-Received: by 2002:aa7:cdd2:: with SMTP id h18mr15644820edw.387.1595875058173;
 Mon, 27 Jul 2020 11:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 27 Jul 2020 20:37:26 +0200
Message-ID: <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
Subject: Re: Questions about trailer configuration semantics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Anders Waldenborg <anders@0x63.nu>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Adding Peff and Jonathan in Cc as they know also about this area of the code]

On Mon, Jul 27, 2020 at 7:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> [Redirecting it to the resident expert of the trailers]

Thanks!

> Anders Waldenborg <anders@0x63.nu> writes:
>
> > I noticed some undocumented and (at least to me) surprising behavior in
> > trailers.c.
> >
> > When configuring a value in trailer.<token>.key it causes the trailer to
> > be normalized to that in "git interpret-trailers --parse".
> > E.g:
> >  $ printf '\naCKed: Zz\n' | \
> >    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
> >  will emit: "Acked: Zz"

Yeah, I think that's nice, as it can make sure that the key appears in
the same way. It's true that it would be better if it would be
documented.

> > but only if "key" is used, other config options doesn't cause it to be
> > normalized.
> > E.g:
> >  $ printf '\naCKed: Zz\n' | \
> >    git -c 'trailer.Acked.ifmissing=doNothing' interpret-trailers --parse
> >  will emit: "aCKed: Zz" (still lowercase a and uppercase CK)

Yeah, in this case we are not sure if "Acked" or "aCKed" is the right
way to spell it.

> > Then there is the replacement by config "trailer.fix.key=Fixes" which
> > expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
> > which seems to be expected and useful behavior (albeit a bit unclear in
> > documentation). But it also happens when parsing incoming trailers, e.g
> > with that config
> >  $ printf "\nFix: 1\n" | git interpret-trailers --parse
> >  will emit: "Fixes: 1"

Yeah, I think it allows for shortcuts and can help with standardizing
the keys in commit messages.

> > (token_from_item prefers order .key, incoming token, .name)
> >
> >
> > The most surprising thing is that it uses prefix matching when finding
> > they key in configuration. If I have "trailer.reviewed.key=Reviewed-By"
> > it is possible to just '--trailer r=XYZ' and it will find the
> > reviewed-by trailer as "r" is a prefix of reviewedby. This also applies
> > to the "--parse".

Yeah, that's also for shortcuts and standardization.

> > This in makes it impossible to have trailer keys that
> > are prefix of each other (e.g: "Acked", "Acked-Tests", "Acked-Docs") if
> > there is multiple matching in configuration it will just pick the one
> > that happens to come first.

That's a downside of the above. I agree that it might seem strange or
bad. Perhaps an option could be added to implement a strict matching,
if people really want it.

Also if you configure trailers in the "Acked", "Acked-Tests",
"Acked-Docs" order, then any common prefix will pick "Acked" which
could be considered ok in my opinion.

> > (token_matches_item uses strncasecmp with token length)
> >
> >
> > I guess these are the questions for the above observations:
> >
> > * Should normalization of spelling happen at all?

Yes, I think it can help.

> > * If so should it only happen when there is a .key config?

Yes, it can help too if that only happens when there is a .key config.

> > * Should replacement to what is in .key happen also in --parse mode, or
> >   only for "--trailer"

I think it's more consistent if it happens in both --parse and
--trailer mode. I didn't implement --parse though.

> > * The prefix matching gotta be a bug, right?

No, it's a feature ;-) Seriously I agree that this could be seen as a
downside, but I think it can be understood that the convenience is
worth it. And in case someone is really annoyed by this, then adding
an option for strict matching should not be very difficult.

> > Here is a patch to the tests showing these things.

Thanks for the patch! I would be ok to add such a patch to the test
suite if it was sent like a regular patch (so with a commit message, a
Signed-off-by: and so on) to the mailing list. While at it some
documentation of the related behavior would also be very nice.
