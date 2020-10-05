Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B5C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E683D207F7
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfL9Q/E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJEXY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJEXYX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:24:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C9C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:24:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so6913398pgf.12
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQVNh0gNRdraQU35hCCcqS0nI8ZG2r6egVUM6TCf2RY=;
        b=WfL9Q/E119KNUz7Rh78bFEW0u2XgenEQbfdosAWHTJR0jp9CW/MBWZ+MOoMJ1xgjt5
         wpFDQosSy0fLC5PzEJ86JD2WG5EDlpwPkRE2wvUiKeQhHz6SsD2VitJU8Hq6toUMJMua
         x6VW8RnuTTMFobgKH54y/BGfTFm+DcJsAE0RqYJAtdkjRDJ+75MPzdEEapzJcnDJHaWJ
         aPZKazM1/6HiGj0OkEn1bleOXcYokK5E2jUTpqsvk6LsrhjWxeMeQYhH+JtCetdOTlnq
         Pjtql6cTrc+/UVox9VsHBOU/ninsZXHgsehPaQ6495HoMVJnVkWWP5QDbXHgMpDsND/Q
         +X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQVNh0gNRdraQU35hCCcqS0nI8ZG2r6egVUM6TCf2RY=;
        b=JL0qlX1yXqjYghTaiRu+joOuIf3wZyw6R8jww8GfIQftMC1gAnk1kSqgFdRXzZ1Y6k
         93etWFC27r91UEYDWmazSw2IcuK34YI+SsapueEaWbxMZfUffMRcmExp1nVOgn+loCnN
         t3AnPpx16gIlaixMy2jX9VJl5FOtddnxUOAXwYvkgA4YigGr8DrK/mYQVnrAJ8moUYWg
         wSMHFLB/B2Towd2qdbx8IYf/P3nmaFfam7fw4U9FTNPDoVrEe2AXdhuVlcsIXzfEXdfk
         UtEG990SdJBJmRzmZ8iTmwyd4HSzKZxSjPFEaMPxOIW04DzilX0WxcHiq4r/Vc89P2h4
         o5hg==
X-Gm-Message-State: AOAM531T6Ldv8zFyZa5A+ODvGgeN0FECLJKExh9+Afh/iaFtbkOKzCNQ
        ROhZKsch2irj1APrRg7o34g=
X-Google-Smtp-Source: ABdhPJyZy5L9B+t3qe9KLJuglKkVTcPg3UcXCOdt1oJCvbflICrxnSwyKT1LV1wp1/aW4Iudcg4yUg==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr2137658pfc.15.1601940261026;
        Mon, 05 Oct 2020 16:24:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id e21sm712809pgi.91.2020.10.05.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:24:20 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:24:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/9] hook: scaffolding for git-hook subcommand
Message-ID: <20201005232418.GA1393696@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-3-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> Introduce infrastructure for a new subcommand, git-hook, which will be
> used to ease config-based hook management. This command will handle
> parsing configs to compose a list of hooks to run for a given event, as
> well as adding or modifying hook configs in an interactive fashion.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .gitignore                    |  1 +
>  Documentation/git-hook.txt    | 19 +++++++++++++++++++
>  Makefile                      |  1 +
>  builtin.h                     |  1 +
>  builtin/hook.c                | 21 +++++++++++++++++++++
>  git.c                         |  1 +
>  t/t1360-config-based-hooks.sh | 11 +++++++++++
>  7 files changed, 55 insertions(+)
>  create mode 100644 Documentation/git-hook.txt
>  create mode 100644 builtin/hook.c
>  create mode 100755 t/t1360-config-based-hooks.sh

optional: I could imagine this being squashed into patch 3 --- that way,
the command has functionality as soon as it exists.  Alternatively:

[...]
> --- /dev/null
> +++ b/Documentation/git-hook.txt
> @@ -0,0 +1,19 @@
> +git-hook(1)
> +===========
> +
> +NAME
> +----
> +git-hook - Manage configured hooks
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git hook'
> +
> +DESCRIPTION
> +-----------
> +You can list, add, and modify hooks with this command.

This could say something like "This is a placeholder command that will
gain functionality in subsequent patches" to make the current state
clear.

[...]
> --- a/git.c
> +++ b/git.c
> @@ -519,6 +519,7 @@ static struct cmd_struct commands[] = {
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>  	{ "hash-object", cmd_hash_object },
>  	{ "help", cmd_help },
> +	{ "hook", cmd_hook, RUN_SETUP },

This makes the command require that it run within a git repository,
but I can imagine wanting to list hooks outside of any.  Should it use
RUN_SETUP_GENTLY instead?

Thanks,
Jonathan
