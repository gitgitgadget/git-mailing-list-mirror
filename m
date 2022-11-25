Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5086C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKYFtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 00:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYFtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 00:49:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5123169
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 21:48:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mv18so2869585pjb.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 21:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GAzWi19Kuz1KiFb93IoAyflfUijLllEjy85c0MzXTWc=;
        b=SqcROcDBGlUe0aoC5dyB1CxqG4agVUJdL6KK+2YzdjypC69PwemwN8TTbStADJLQPr
         XeAufpgVr7ePTTQ2gDDVtphaaESaMH8OtKSVmXf/w4FgFtYuJbT5I4pz6tBlidG1P2+U
         pIUwL6jckotW/irpapkp65157fzGqKiH0iOkX8OnRO6kUeNBJxa1jtrDOA+gm6WVWF7U
         IYsPELaxa0S7SwMCT+I0kZ3LAdcSSB9wc2iuM/H/882/jNnWNpX1wf9YbS+VdDtCK33e
         rg1z23NdY/jCUL3Pd693Vak7tX136iY2z4V+71ZSWUbHyH59Glmm4LvNRyalMAL7hZZY
         eZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAzWi19Kuz1KiFb93IoAyflfUijLllEjy85c0MzXTWc=;
        b=SdeV7KXICBB66l1b+CU+KRqqHrq22QEQJHgs3oGJ2+99FWJDDYuGEVBJvDLzf0B/vn
         ZWIhqs1L+VmawZJkqYYqRdqK4NZMM3dhKR02u34c8an0FpMsQOb4QUVkYOunNUO3t4Qc
         f8gDnYVVfqKpseqzz7JfnGxW6cI18FduR6Q6FS/coU/0b367lbTo1t1Po7RNZ/pWUu4B
         B/wYRS0QEX5+yUP4gUEdf2dwqsUAL2q8rnl+lvljvqVtyjL0emdZaofIIcisxchzCwXb
         UbZB75vJe+yZezLGYtxHzugXWYrSLq/0IixwtHOJh9rXN36yWwlkR7h3/aIOVeNlQekS
         chxA==
X-Gm-Message-State: ANoB5pnqEPWo+Rs57aep3lujL+eEf1QvSQvZ1Azb5aM80+2kPydevoBZ
        wPL4W/6qcpRUPAf6g5WuBIo=
X-Google-Smtp-Source: AA0mqf7hS1qYyr1T4vs/yFQifZrO0QtLB7zB0yNwG4fxD2xpuMbvme9RELCySvR1wx6kqCvo+ICEwQ==
X-Received: by 2002:a17:902:d4cf:b0:186:80e7:1e1 with SMTP id o15-20020a170902d4cf00b0018680e701e1mr17032550plg.135.1669355336234;
        Thu, 24 Nov 2022 21:48:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u3-20020a63df03000000b00477078686a9sm1906326pgg.42.2022.11.24.21.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 21:48:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH 2/3] var: remove read_var
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
        <905b109b458e291da04d9879cbc6b032bbd9a302.1669321369.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 14:48:55 +0900
Message-ID: <xmqqo7sveg8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> With our target git_var value now available, we no longer need to call
> into read_var() to find its read() function again. This does avoid a
> second loop through git_vars, but mostly it just removes a lot of
> duplicated logic.

If I were doing this series, I would probably have written a single
patch for the steps 1 & 2 from the beginning.  That way, reviewers
can clearly see what the differences in behaviour between
get_git_var() and read_var() in that patch to see that the single
step is a strict improvement.

Other than that, both patches 1 & 2 look good.

Thanks.


> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
>  builtin/var.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/builtin/var.c b/builtin/var.c
> index 776f1778ae1..e215cd3b0c0 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -67,20 +67,6 @@ static const struct git_var *get_git_var(const char *var)
>  	return NULL;
>  }
>  
> -static const char *read_var(const char *var)
> -{
> -	struct git_var *ptr;
> -	const char *val;
> -	val = NULL;
> -	for (ptr = git_vars; ptr->read; ptr++) {
> -		if (strcmp(var, ptr->name) == 0) {
> -			val = ptr->read(IDENT_STRICT);
> -			break;
> -		}
> -	}
> -	return val;
> -}
> -
>  static int show_config(const char *var, const char *value, void *cb)
>  {
>  	if (value)
> @@ -108,7 +94,7 @@ int cmd_var(int argc, const char **argv, const char *prefix)
>  	if (!git_var)
>  		usage(var_usage);
>  
> -	val = read_var(argv[1]);
> +	val = git_var->read(IDENT_STRICT);
>  	if (!val)
>  		return 1;
