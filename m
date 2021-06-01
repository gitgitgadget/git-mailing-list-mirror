Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D5C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 07:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E1860698
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFAHss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAHsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 03:48:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810F3C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 00:47:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q15so10045104pgg.12
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1U7cNMDULVhNV3cMlyOubL4FpZ+6yHzCRPq01EveFEk=;
        b=RP6RSA9QAOnv2WXmBSXqVtNb83UyCfqvtwjb7a0AvvNCuZn1O61d1HgbOcZz0teJ/0
         /+oa2IxXmoqlPvvXlyXQyvQAhLehHFaYfsgR7/j6y7Mgj9TBUKzsQaCNMFguORMuSC7m
         2Nw5HKNg0RDQI15ZdVXP9zOnZcPmOeWGYo+Xy5sys+7AbpS18kUCzmJpClfDxYYs59R4
         d0jkSYMz/AqQCLzduIyGDWZpEdnnEjELqKzX++enh0SyBN2/gg6XsLo34bxRcNso5hHM
         5Y14Ae/hqgiL4XYQvuEEL9xzcn635RwYOM3rHzby9sJcuEkvB/3i05maeQAPmDkoqDOp
         4/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1U7cNMDULVhNV3cMlyOubL4FpZ+6yHzCRPq01EveFEk=;
        b=teovXYmVFNPk1dw23jVsv4zAmbpHre+5dcAYFnW3/RwNNZMWQ4O7ef4bznoN1C5vnT
         mpPR/Xi7/qMcw/fbeyJnoA/nviSB4Iv5juyhaK400qA3v7PVwZI1psmK4scgCPeyLTw2
         9fiWxddK6zSXxTf9q8MYb+yhhmSREsohvoNN+AsRoAbhk/8g8dnrOpi/fvTdaGte/aAJ
         bDxMStY6u2oiY7LvOHhINbtduWO9VcC1F/LeuaefY01Bx8mDkEAbqQoL9lUyssSvmLTg
         VxWWqGJiOG9qskzXJi4Xmuio0ylTAkkKUYGM88RYtM8SGU/AA5Ss1bGPlTSSGPTguCNI
         w9gA==
X-Gm-Message-State: AOAM531KS12dsxj7XGV8uF7RkTmKErmBD3WqcIMUChUHwC0PCp3z2x2T
        LfEdmDya0JZB7nMD4JJy5i8=
X-Google-Smtp-Source: ABdhPJwfvhNok7dREPV1lkHEVQuwfwgUk54iFM12ZLF8pXPz9/3doapfFzdF1dotYLJpPLtll2RSIg==
X-Received: by 2002:a63:af46:: with SMTP id s6mr26972934pgo.446.1622533625081;
        Tue, 01 Jun 2021 00:47:05 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id u21sm12418560pfm.89.2021.06.01.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 00:47:04 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:47:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Message-ID: <YLXl5+ronWhcGh13@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b5d281552d6_e359f20828@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-01 01:24:01-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Hello,
> 
> The premise is simple: git.git developers are experts in git, and therefore
> they have fine-tuned their ~/.gitconfig to a point that is pretty far
> from what any newcomer will experience for a long time.
> 
> How long can you survive with a pristine configuration?
> 
> Plenty of developers take many things in their configuration for
> granted, they forget what the default behavior is, or worse: they forget
> they actually have configured log.decorate, and are surprised when they
> discover the reason they could not reproduce a bug report.

OK, the person that forgot having log.decorate configured is me.

> Now and then I cleanup my configuration to be reminded of that fact.
> 
> Anybody remembers merge.defaultToUpstream, and what `git merge` without
> arguments used to do? [1] What about sendemail.chainReplyTo? [2]
> 
> It's important that we force ourselves to experience what an
> unconfigured git setup looks like, even if it's just for a little bit.
> 
> So the challenge is this:
> 
>   1. Remove all the configuration that is not essential (just leave
>      user.name and user.email or equivalent)

How about alias? It's part of my muscle memory.

>   2. Pick 2 configurations you think you can't live without. You are not
>      allowed to change them afterwards.

Something is essential when working on constantly integration tree,
I don't want to make my life hard:

* rerere.enabled = true
* rerere.autoupdate = true

Something is there to shut up advice, I can live without those
configuration value, though (I don't use git-pull these days, anyway):

* pull.rebase = false

Working with patch based need:

* sendemail.smtpserver
* sendemail.smtpencryption
* sendemail.smtpuser
* credential.helper

My GnuPG key is Ed25519, and gpg v2 in my machine is named gpg2, so:
* gpg.program = gpg2

And I would like to try new shiny features:

* feature.experimental = true

>   3. Every day you can add 1 additional configuration (and update it the
>      next day).
>   4. The moment you add a 4th configuration you lose.

So, my baseline already requires 8 key-value pairs (ignoring alias and
pull.rebase). I'm lost already.

-- 
Danh
