Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED7FC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBOR4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOR4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:56:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691C1B54D
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:56:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bt4-20020a17090af00400b002341621377cso3016910pjb.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEWZM7lXajUeqNNG0MREht0rUy5CBZNntgh1ZeOa+wk=;
        b=T1Hvd6T5mJ/VLAvQI8ohADElmwkRIQ4zRGBjmLas0D+crTPqU5Oos8tV8q0Bf5/47c
         Q1xF94JEx5LbOxRFDEghW24bqGjxQODPb9SXcF/p/4Gp18RLpc6cKcFMYD0IHPb1tpiw
         ZyW3QHaYSDYKI+y7b2VkV5sZb/ihs6kb6luug0Cu4AarEQp9tHFG+OPTeqXTkqHciUyy
         gdfJHZpe3uHFKjedKu5Y7A+XSJJVtPnfCk2GRlmy3zn/DUnE+KaRXzQKkNCoNL4x7wy/
         +AzCUHqGsrQiFdAeoIlmDbAThh9+5oI8/IycPRNpst0dDnZv+K8PIqBWy2eQ1SX+Xz0P
         hTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QEWZM7lXajUeqNNG0MREht0rUy5CBZNntgh1ZeOa+wk=;
        b=zYLJNQSYvujxz9MKjfBFb93AzJoTDMf9YUyH12p40URiMCFZw9UiNLu9a+AHR/IoJD
         a9S1tFXBHHTbEDgoqCD5VUC/j5o+yQdbWeEOmh1mEyimGNdZ71DGCPUNpF3j0FDtElrQ
         KZxjpWEo1tgyqFkkwE2BiqJvpJ9M3QWphJba23oxFFWaoz85TNzFmgwPmzDJN/gGfYu4
         YY+15tjvSkve++eTobQUMaAJdCikdBK5Y3batKI8LZL9X9o7hKIsX7Gv/eIDoaB5Bx8w
         2Rl1Jb0Js9bglbDWnMsf8ruxdNXnLCtKXCKJXFExSe6zncVm5qDFHk4tAUOna60Bx/Zd
         QKIw==
X-Gm-Message-State: AO0yUKVvyl6kWbtvRe8KRGYV8b8I6bCZk10llDUcOhfyNQPTJc+gaKHK
        Ws9iAFcrY2Tv+1xt5vBEd/s=
X-Google-Smtp-Source: AK7set+dz1qfZnxeub2L+TlJ++DDaxQE9F157KiZZAjyfZg3h06Mkioaf2pBgPRRFj8xDYpZPPKVfw==
X-Received: by 2002:a17:90a:1a5c:b0:230:c9f7:1afe with SMTP id 28-20020a17090a1a5c00b00230c9f71afemr3603363pjl.49.1676483793689;
        Wed, 15 Feb 2023 09:56:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090aa39300b002311c4596f6sm1743251pjp.54.2023.02.15.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:56:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Idriss Fekir <mcsm224@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] remove parameter (prefix) from trace_repo_setup
References: <20230215104246.8919-1-mcsm224@gmail.com>
        <20230215104246.8919-2-mcsm224@gmail.com>
Date:   Wed, 15 Feb 2023 09:56:32 -0800
In-Reply-To: <20230215104246.8919-2-mcsm224@gmail.com> (Idriss Fekir's message
        of "Wed, 15 Feb 2023 11:42:46 +0100")
Message-ID: <xmqqh6vmzub3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Idriss Fekir <mcsm224@gmail.com> writes:

> From: idriss fekir <mcsm224@gmail.com>

This blank space is for you to explain why this is a good thing to
do, which is missing here.

> diff --git a/trace.c b/trace.c
> index 794a087c21..316070a43e 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -292,9 +292,9 @@ static const char *quote_crnl(const char *path)
>  }
>  
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */

I do not think this comment was meant as an instruction to BLINDLY
remove the parameter and instead use from startup_info.  Instead,
the "FIX" in "FIXME" would involve that whoever does the fix checks
the caller that reaches this function and makes sure that "prefix"
value the caller passes exactly matches what is in the prefix member
of the startup_info.  Documenting that work should become a major
part of the proposed log message.  After doing that, this comment
is no longer valid and needs to be removed.

> -void trace_repo_setup(const char *prefix)
> +void trace_repo_setup()

"void trace_repo_setup(void)"

> -void trace_repo_setup(const char *prefix);
> +void trace_repo_setup();

"void trace_repo_setup(void);"

Thanks.
