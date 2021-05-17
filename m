Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A290C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662A160FDB
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhEQRYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhEQRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:24:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10CDC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:22:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so6210994otc.6
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=14I6rpDKbwv74f8ZbFMXL+nTyv//3yyPnqatoz+6cKo=;
        b=pt4oX+Kr3t3QkstHJOAQPtNybd/nqX7ZGjPGUFoiD1BFntdHPyiZLpmyZtCiWdZeQR
         WV909HV75guixpMD3oSHF5lb6gDIeeYQ7lfSumV8ATEz1sZQuVgteIe9Zq3tKUe2GQm7
         nqli9B1DiaOPBPjoW8kkEZ7gtxv6Paj9jc/78TPECoGM4ZkLUublFP4uECmag1shVHSS
         xfOUapIsXNcKTcGvFfTL1LcSecLze/JI4A6wizfeDZTk+mtJLgwaSJ+9GqrLstznVe+q
         2of45rsU7mbMJcUnx1R8t0DVjSWiO1uw1giselP/jTZjUsjb8676iY99m9725XvxksBM
         rCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=14I6rpDKbwv74f8ZbFMXL+nTyv//3yyPnqatoz+6cKo=;
        b=dnUXg/rKQ6LcTImeuLFqnP2qLponQ5oAyDcD4UbCC9tD9l7hUw9v3g7Un41pUJ6KMN
         7gzA8I25+ZpQvm9mMiZkOi+1AZ8KJO63jDCEmYYjAhT55cJtwgkMXmk2AhoFE9TKmRBZ
         yNWEafykIXzS+butOhH4TqexIbzPwiZI92I5/PuKq45/H60q0jHGdMMLOMWMOZoxiOdc
         UHgbTr0dvWXlkff53KqlOVFgNAFvRAHHwpPbP4i9advYvGtCCbnC/1fWpX8SBPPgNUkz
         BVRf4cKFsSH58LaSNcOB/6Hh2aBMM3ta8GpIZFqmyT7ZiLZZZHmYqjmq8te46MMe57qN
         MpHA==
X-Gm-Message-State: AOAM532DPUnG5et0Bo93n+8YjtXf3NZRcO9b8u+YMP6CncNLJtRPotih
        iJhLNExi8KkWwnZ361Dk42w=
X-Google-Smtp-Source: ABdhPJzOBXsvwXXm07/QwTKPY++DRisZJeZPDxLMsQ+VMIFzWl7j6I1H0qe60Mdk3ngTr1lFt5M2SQ==
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr519103ota.203.1621272178159;
        Mon, 17 May 2021 10:22:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w10sm3174288oou.35.2021.05.17.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:22:57 -0700 (PDT)
Date:   Mon, 17 May 2021 12:22:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a2a670648b1_12801e20895@natae.notmuch>
In-Reply-To: <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 17, 2021 at 05:30:01AM -0500, Felipe Contreras wrote:
> 
> > > As there is no need to spell out HEAD, `master..` would be a better
> > > example.
> > 
> > I don't think so. The description said _starting_ and _ending_ points...
> > `master..` has no ending point.
> > 
> > If we must not use @, then I would rather use `master..mybranch`, or
> > something like that. HEAD seems like a technical accident. But of course
> > I would prefer HEAD to nothing, because at least it qualifies as an
> > ending point.
> 
> I agree that if the purpose is to be illustrative, using shortcuts like
> "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
> you need to have "revision range" defined, there is a good chance that
> you don't know about shortcuts like "@" either.

But they don't need to know what @ means; it's clearly a shortcut for
_something_, and that's all they need to know. In fact, I'd say most
people can quickly realize what a shorcut for it is, which is why it was
picked by the git project, and many Mercurial projects as well.

Sure the same argument applies to HEAD too, but if we are going to pick
a placeholder for _something_ the user doesn't need to know about, then
@ is much simpler than HEAD.

We could do X too (typically used for _whatever_), but I'd argue @ is
much better than X because it actually works, and not just works, but
it's what the user most often would use.

> So I would prefer something more explicit (whether it's "mybranch" or
> "end" or "HEAD" or whatever).

I prefer something less explicit, because it's not relevant what X is,
just that it is an end point.

But if you feel strongly about it, "mybranch" it is.

Actually, I would prefer something more real, like "feature-x".

> In a more fleshed-out description it might be nice to casually introduce
> such shortcuts to let the user pick them up naturally, but in a
> one-liner like a glossary entry, I think clarity is the most important
> thing.

Indeed, but I find `master..@` is a perfectly clear example of a
revision range from something to something.

> > > Especially since most people are downstream consumers, I'd
> > > suggest using `origin..` or `@{u}..` here.
> > 
> > Nobody uses "origin" (what does that even mean?), [...]
> 
> I guess I'm "nobody" then, because I use it all the time.

Language is rarely 100% specific. By "nobody" of course I meant
"virtually nobody".

And yeah, I know you actually use "origin", because you do have correct
"origin/HEAD" for many of your repositories. I don't, and I'd argume
most users don't either.

It's right next in my to-do list to work on fetch.updateHead so I (and
many users) can join you in using "origin". But that's not the case
today.

> The example in Documentation/rev-list-description.txt (which feeds into
> the git-log and git-rev-list manpages) uses "origin..HEAD", as well.

I think it shouldn't, but that's a separate topic.

> IMHO it is a pretty reasonable example, but the examples in
> gitrevisions(7) use made up "r1..r2", and that seems perfectly readable,
> as well.

It is readable, sure, but it's not a real example. When picking an
example of English sentence with subject and predicate I'd pick "Mary
went to the moves" over "Subject predicate" in heartbeat.

An instance that doesn't come from the set of real commands is not
really an example to me.

Cheers.

-- 
Felipe Contreras
