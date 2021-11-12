Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34FC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A0B61029
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKLQYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhKLQYi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:24:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7785C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 08:21:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o8so39689877edc.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LxaIdVT4lJqFgPVQdpBK4a1HimkN+K548PJ++5bh8sc=;
        b=FVqvFUbjLvwt2y8mVF4EQuw/veGGYyAwJW+07UKDwfhHoVB2sYhqXXxTRW47D34WbM
         x9gLosaYLTeeCyVaYXr22gSWPzOY/RgewsGnHQDuCvDjYnqhwMKVZO6h5G6f1h9L0cBl
         gOFNeyIqBuu0om1HwQa3uzJHnKwXK93UEY0sizYcntuoPAgd14X/H2AtM7xk2zu8hmzl
         W1mHtLyqOPOFZlkHPWaPWfShltwpeBbtPb/wUJ7Rq6wp5y4WOGFPgLLrbXuQ8c3HQHl6
         FK8cIa7PTVcw6dfge+qag/OQfOCyJQJ95pSSmtt0uPKxv4SNPupw3EA6W53SOsOzbsRz
         KC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LxaIdVT4lJqFgPVQdpBK4a1HimkN+K548PJ++5bh8sc=;
        b=kqIUu3aR2JO68Wm6K4cY0VjgkViujNb2epv07oaeTiaZac4T+d5KbfBUVVQHf/14B7
         VuKMd2N1EYsfEvNGaJ+akqGsEvsmlEmR7Hd9SWHwU5EN5tPpfPfaN01lC1vNS0cb0t0Y
         s4yg6MymK2OmI/SyEfbiQYThLLiRANskENnAhk/6dUuKiJBhlJmMEjbYmBTWw83vWKs0
         EJMCDkP41U69PhZ2lnH3N2Nl0Pz0Rcfyxgawsoj0jlq8fAVfgtARdhio51l6scOQl9Gq
         GhHDO0cnVmyTGv/owOAgVtZJj5J4SoXvsXQT6+AKlF7PCOoq4ThGMobhMJNxmBW0S6z3
         t5oQ==
X-Gm-Message-State: AOAM532AK8BqgrOvSVRulD+rHGjx8IGJEANZHdNTyRJ+G79/kLMIoX2i
        pBJWjMWu7o9MfiAhoFDn/YB+NogIHa0=
X-Google-Smtp-Source: ABdhPJz+Czsbp8RaXuVgCmk9zYfMNNCpg851BG3z4HM2PkHO84Lq6MJdDfXnll7ulvQaNhZ0VbqhvQ==
X-Received: by 2002:a50:d504:: with SMTP id u4mr22640912edi.52.1636734106229;
        Fri, 12 Nov 2021 08:21:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dk5sm3171963edb.20.2021.11.12.08.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:21:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlZJB-000PLe-7a;
        Fri, 12 Nov 2021 17:21:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eyal Rozenberg <eyalroz1@gmx.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: Ability to edit existing tag's message
Date:   Fri, 12 Nov 2021 17:08:54 +0100
References: <04cbce68-bcbd-dbb2-5d9d-df7dd464fa03@gmx.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <04cbce68-bcbd-dbb2-5d9d-df7dd464fa03@gmx.com>
Message-ID: <211112.86fss1uyxy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 12 2021, Eyal Rozenberg wrote:

> At the moment, one has to go through some hoops to edit a tag's message;
> see discussions here:
>
> https://stackoverflow.com/q/7813194/1593077
>
> It would be nice if:
>
>    git tag --edit my_tag_name
>
> would bring up the editor with the existing text of my_tag_name's
> message, for amendment. And, perhaps,
>
>    git tag --edit my_tag_name -m "new message"
>
> would overwrite the existing message. I've suggested `--edit` since the
> switch already exists, but if you like a different bikeshed then it
> could be --amend like git commit --amend.
>
>
> Just my 2 cents and have a nice day,
> Eyal Rozenberg
>
>
> PS - I'm not on this mailing list, so if you want to reply, please use
> my actual address.

Yes, these should be an easier way to do that.

In the meantime it seems a lot of those suggestions on Stack Overflow
are way too complex, since they're struggling to maintain all the tag
metadata as-is, an easier way is:

    git cat-file tag <tag-name> | sed s/foo/bar/g | git mktag

Which will create and print out the OID of a tag object, if nothing is
changed the OID is the same, then just:

    git tag <tag-name> <that-oid>

Where you'll need a --force if the <tag-name> is the same.

It's not as "safe" as e.g. "git commit --amend", as you can edit the raw
headers, but for people who want this that may be a feature most of the
time.

It will also preserve the inline PGP signature, which if you make any
edits to the tag won't verify anymore.

It also looks like a lot of those SO answers pre-date my not-so-recent
changes to "fetch" where we'll by default error if any existing tags
would be clobbered.

So you can do this, but there's a reason for why it's not
implemented. I.e. you really don't want to edit existing tags in the
general case.

But I can see how it's useful if you've not pushed it out, or if
changing it is OK in your environment even if it was pushed out.
