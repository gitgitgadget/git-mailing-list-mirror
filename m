Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8459BC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC0RvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0RvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 13:51:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA61BCE
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:51:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so9193315plo.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679939465;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndycT/POqY0MOO/Dkf+zJlj+5w8bqKzlyI/JKcIhiP4=;
        b=fB8VKJTicF/Rm3aACr905rsL5sKxXGL9GSeLcRbzsRjdwJSh4fEFTe1HP61zLMTNiN
         o/v9gh8VwD8Cy8s7jgyiA2gYCaAYt4MGLzJpxlNDp1jqHE87Gu6pBoNK5Iq4zxV80yLD
         2F58As7Ulo0jiOQny+QKCIs73SUsymgPxa2jdkvd5ETbAsMOubuphQvMxzHHfYAFpqzR
         IsMJYbz9/4uDIcFfdFN++o7N1k8/nIgHsh7ZP/654HoXgF9cn7MNB0IkVKng7eDuVCPk
         TgK6tIM6qukP4tKiVq8gS+Enh0PFbsiZZNhum06RdLmpjm3rpmn2vFejvj+J3SBnmKg5
         lWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939465;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndycT/POqY0MOO/Dkf+zJlj+5w8bqKzlyI/JKcIhiP4=;
        b=2kh6sF0qb0tOxgu2Kh0F/an8iywLBpEB7n3T0gMzX1Q7PxNVFyVdGBQkFdQQIGqbDq
         XQXvMZWOhbMrcerUolraERx00QqHS8lQpptO8pDRU1imX9p7yQaQT2W/KYZqTHQjGAen
         SVzor1OsYwqYxhnabmuD23A+UQttAZkp7merxu2KhLVJ6pHEh0LLAE+aZKcYNglEZALk
         x1rtSZC5KGyNkZlLh3af2Z9y5qV7lZxYehPMWu108w8nVLRpP35mAwx83R+VDLU6W3Iq
         khZvAeyxxXm0pBIu3AfRlGKqVOPyIKNW9p3fuu5ZoVB/5tqhwDwmT6+aPM5aiKSsfoAJ
         5h4A==
X-Gm-Message-State: AO0yUKUYELa1eCoWNJgea+KGePOKOE5178Pre6tOcx2GLq5EitUahJcK
        w7Gmi8XZ+0NuCTJzVKX7yoU=
X-Google-Smtp-Source: AK7set93SywWH3+49Tv//vxVMKO/fW1jPAX8hwoftOmZ42oMbGnMwDLK/18stO10Ii2e7cJQB7lpXw==
X-Received: by 2002:a05:6a20:1e4d:b0:da:144:92a8 with SMTP id cy13-20020a056a201e4d00b000da014492a8mr11556148pzb.37.1679939465556;
        Mon, 27 Mar 2023 10:51:05 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e12-20020a62ee0c000000b005d866d184b5sm19222290pfi.46.2023.03.27.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:51:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
        <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1679903703.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 10:51:04 -0700
In-Reply-To: <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1679903703.git.gitgitgadget@gmail.com>
        (William Sprent via GitGitGadget's message of "Mon, 27 Mar 2023
        07:55:02 +0000")
Message-ID: <xmqqr0taaxrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index c3738154918..5fdc3d9aab5 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -57,6 +57,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
>  	char *sparse_filename;
>  	int res;
>  
> +	setup_work_tree();
>  	if (!core_apply_sparse_checkout)
>  		die(_("this worktree is not sparse"));
> ...
> @@ -898,6 +903,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
>  	 * forcibly return to a dense checkout regardless of initial state.
>  	 */
>  
> +	setup_work_tree();
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_sparse_checkout_disable_options,
>  			     builtin_sparse_checkout_disable_usage, 0);

I am throwing this out not as "we must tackle this ugliness before
this patch can proceed" but as "this is ugly, I wish somebody can
figure it out in a cleaner way", so do not take this as a blocking
comment or objection, but more as something to think about improving
if possible as a bonus point.

It really is a shame that we have a nice "dispatch" table at the
beginning of the single caller:

        int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
        {
                parse_opt_subcommand_fn *fn = NULL;
                struct option builtin_sparse_checkout_options[] = {
                        OPT_SUBCOMMAND("list", &fn, sparse_checkout_list),
                        OPT_SUBCOMMAND("init", &fn, sparse_checkout_init),
                        OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
                        OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
                        OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
                        OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
                        OPT_END(),
                };

yet we have to sprinkle setup_work_tree() to all of these functions'
implementation.  If we were able to describe which selected ones do
not need the setup call, we could let the parse-options API to look
up the function and then before calling "fn" we could make the setup
call.  That would allow us to maintain the subcommands much nicely.

Thanks.
