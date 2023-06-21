Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB07EB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjFUUOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUUOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:14:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BC19A3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:14:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56ff81be091so88783827b3.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687378454; x=1689970454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kX+wk/fiuviDmTx4GHP0TlhxmaUnKd8dbKlWoDUjxGs=;
        b=4OqTs92C+rZtT/4QZvpgg0H+QQBsD/vqAvQTBJZPFWp1NrmjBcizJlFBbgG7Mhlnxu
         qeBZYVSBsPAU1CKjGuGT3t5XH4jS8NvXMib/2XqGJIZ+JwAbnWQ8iRXaSq+TQKwh1rs+
         o4fevtwgHu5J/FOR4nv9LMQ3yb6b+euOshkclpFP1rQZCq6VRyey2yaO6zXIDlB7+Wjy
         4rTQLT79z7ud2kXQ3JfT1HFvtsXrdTIjjgKo0LYCLbidHBOrCocfxRZRavdeFNeMut/2
         CILAbSUIaHKSjrxd26kofKMHKZcFksDqZqLMWBPu2NQRUQ2xEjA58v1hIgPwr/BWjDYo
         i/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378454; x=1689970454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kX+wk/fiuviDmTx4GHP0TlhxmaUnKd8dbKlWoDUjxGs=;
        b=Kvgpi2a7OyEz00v/nrGgBZ3tNhQGSfL2d7bOSbBA6L5OlTPjenQfoZAYyNp/NJBeT9
         oQ/MJ/GlocpA7CX9+Cvyp75IEDQCCoRNv1sRFM6+65eyBQo6TndtNWYu8xHfg1EsRpBz
         IfFDYnzHgzFvKHSjOHdq7/UeSYvxWWGrOP6DNYyQIJD8OEQpaUlWtJVX+bmyFZ5mtHGp
         YXOLzTXs3LXU0Y9jLIq+jNbp0lWb5haOUGSKYaTITlgLD5GRFPVtGUrvuKUSznu5JFLK
         2zLotuNDke5hpjd1cfE5z9Fj3oN6fbbLFKGWHlplcicdad/FVh2mRnej6e4exsoDAQy8
         YoMw==
X-Gm-Message-State: AC+VfDxWtkOdV+nShEmsSTPvICiVuyQJCwN0JDzi03GYljI9xxEVIovf
        uHr3Q2/hm+uTT6xJAm0VZTqA91IU3bubkQ==
X-Google-Smtp-Source: ACHHUZ6emOrQxKExKlFdGk9gwHiQbaQ9I+K3JhgkqJSBPKmG+TDFwWWYimxDhqeHsQazspNkD0b5+uPfui8bAQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:ac42:0:b0:56d:ca1:cd6c with SMTP id
 z2-20020a81ac42000000b0056d0ca1cd6cmr2890523ywj.2.1687378454034; Wed, 21 Jun
 2023 13:14:14 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:14:12 -0700
In-Reply-To: <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
Message-ID: <kl6lsfakr2sr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict resolution
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -3490,7 +3495,6 @@ static int make_patch(struct repository *r,
>  		return -1;
>  	res |= write_rebase_head(&commit->object.oid);
>  
> -	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>  	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
>  	repo_init_revisions(r, &log_tree_opt, NULL);
>  	log_tree_opt.abbrev = 0;

I was checking to see if we could remove buf or whether we are reusing
it for unrelated reasons (which is a common Git-ism). We can't remove it
because we reuse it, however...

> @@ -3498,7 +3502,7 @@ static int make_patch(struct repository *r,
>  	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
>  	log_tree_opt.disable_stdin = 1;
>  	log_tree_opt.no_commit_id = 1;
> -	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
> +	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
>  	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
>  	if (!log_tree_opt.diffopt.file)
>  		res |= error_errno(_("could not open '%s'"), buf.buf);

this buf.buf was supposed to be the value we populated earlier - this
should be rebase_path_patch() instead.

As an aside, I have a mild distaste the Git-ism of reusing "struct
strbuf buf" - using a variable for just a single purpose and naming it
as such makes these sorts of errors much easier to spot. That isn't
something we need to fix here, I'm just venting a little :)
