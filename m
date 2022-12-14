Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC52C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLNXjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLNXjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:39:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1530F73
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:39:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso999415pjt.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3c3T0L2WpPqJpZqFxMk9RVb4r1+nLPbr/1cG8c08C1k=;
        b=ZvFpwhqVBtLL/b/H9D/bm5Af5nvfAr5nMrnIfQfS+KzG6W2n5RmwstXb+C5j06BivI
         lNuUIEM/Jl+BK5B2i940SAt6wqUhQicg7V3XJSaH0gOU6mbaBOcOtHipwccWWMv8qFBp
         Nd2WWO8QJmdcCg41M0jGFbHTVyRnJwYW15crGFnPn3hyjabrgPz96IBSxBXpvFkWSvPZ
         cYbZRdtH8pavckBxhir9JGIhBWmzJpVBLC3nt4MS6qwsOWl1eV9ZIubRAUVzrznX0IUy
         vVwi/YVZJFbLtHzGX5ndx4IbqZhCZoBUT6KN1Q1OK64V7iOg2sdb3kgupKYXtgwP8SrS
         Eezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3c3T0L2WpPqJpZqFxMk9RVb4r1+nLPbr/1cG8c08C1k=;
        b=hCmecpWs1KWmczrQxwxZBQ6lW3gsyW7O8+6uk9D1HKK3eZHhNx+wjtddgZhQ2nf8Dg
         8NJ/XCflJtdQBCH7wsWQtVTZVrgxdYHEuJXUF/BgBUhkliE3+w0HHtTxxVlPFKCgk4ut
         iCv+4XcJVeP5y8VeX1gR6MfkUpUQ2zp22tbFIjJugH1nErWvhOAc/dMWyKogK0nQYByQ
         MeGu79ZtSFvowOGvvGBFn2GvIADAmfTy2UVNrlajHZ4b8Goaple2SFAMPaWezcfX60Bv
         Ya4xY3EJyJ7FsXIX04OFR0bPnx9EIXrwnIDqSl1P6UudQ6LSUfAsb9Ki71KxXv5SAcL+
         nTTg==
X-Gm-Message-State: ANoB5plPkUFn5PiyU473/wykfiQRBYuqVhioLkG0u/RgkCB+Y0DACQnm
        kOQF1YM41QUnMplsXBZ0Y19Os03iNAcbBQ==
X-Google-Smtp-Source: AA0mqf4G1HyZIrX137NERwdo9gvtHg9eDSZWAyDZgr1yEnuT5yrKMXjPZ0fxcK1s3hi3+b39yi6qAg==
X-Received: by 2002:a17:90a:e10d:b0:219:e38b:5079 with SMTP id c13-20020a17090ae10d00b00219e38b5079mr27098553pjz.38.1671061181856;
        Wed, 14 Dec 2022 15:39:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id bw4-20020a17090af60400b00218bedf8739sm1934852pjb.17.2022.12.14.15.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:39:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Niklas Volcz <niklas.volcz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Whitepace parameter for git restore
References: <CAGWBhH7ZiU_tJGj_UAB29v9Eq6C2Q-1_0YxLLN16LaEOcuV1Xw@mail.gmail.com>
Date:   Thu, 15 Dec 2022 08:39:41 +0900
In-Reply-To: <CAGWBhH7ZiU_tJGj_UAB29v9Eq6C2Q-1_0YxLLN16LaEOcuV1Xw@mail.gmail.com>
        (Niklas Volcz's message of "Wed, 14 Dec 2022 14:36:11 +0100")
Message-ID: <xmqqmt7pv9ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Niklas Volcz <niklas.volcz@gmail.com> writes:

> Is there a way to pass apply.whitespace when using "git restore" like
> how it is done for git apply? I believe this might be a bug/missing
> feature.
> I have apply.whitespace=fix in my user git config. This usually works
> fine but I was working on a patch for a project today which is using
> tabs and spaces which messed up the commit. In order to avoid
> cluttering the diff with whitespace changes I tried to remove the
> whitespace changes with "git restore -p
> src/the-file-with-tabs-and-spaces.sh" but it seems that this causes
> git to fix the whitespaces again due to the configuration. I worked
> around this by setting a repo local config with
> "apply.whitespace=warn" but I wonder if there shouldn't be an
> --whitespace flag for git restore like it is for git apply. Is this a
> bug?

It is arguable what should qualify as a "bug", but "restore" or
"checkout" are primarily "grab the recorded blob out of the object
store and materialize its contents as a whole in a file in the
working tree", and there is no place for features that are about
patch application like "apply to fix whitespace" to come in.  So a
command line option --whitespace=warn would not be a very good fit.

Having said that, I wonder if you can cheat by

    $ git -c apply.whitespace=ignore restore -p ...

