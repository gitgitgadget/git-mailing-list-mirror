Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B172FC433FE
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbiE0REZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352881AbiE0REY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:04:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FD13B8E5
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:04:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f18so4678063plg.0
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0YKiwkiztUQAAT9xznqjqZg4qw2DCXgWhDaZcpeBa9Q=;
        b=T2OJDaauWUkybeFLUpLbfExebXvpJtmXZsLCXRuUvlnefvroH9TYzrEDlT31eDylbE
         8C10djiUMb22q9JnxoK8aDSm/g2Ogp4SrDg35ZTnQSQ8BlglhJx7jxmNbYXQfkHG4REw
         +SDQR8lh4yZqn9RqxcMur3ka09NygAFOKkrEeJBpkIBAIPyKxTsPFbh4r1eZ8s7iAV+R
         7pWuazJJ4NfJ8KI8JSvpiyqHSQvsQHeX3dlgxEDZvAETvFFV8d5ISXQtd9tt5Xajo4wi
         oeEKXhHYxoV3LmnyeTyQHsVqP9KAxfbwp0AZKh+4c7yK5/mhejO6fD3FnEQBdarlo9zN
         xdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0YKiwkiztUQAAT9xznqjqZg4qw2DCXgWhDaZcpeBa9Q=;
        b=XiITC0KuV7CDJOgTekmul7txWwewfZnrmT4GEwN19lqR2qAqxzcrzRBwhSsrkVLy4W
         /Qv0fWSqjdjds8hTVosaO60iLnRkHY9xP35ppVSk7sJYPujrqgCivsyAsi+LB3JVRZqB
         7vEXoMxZ+jHYsdJ6mWxigAouhMbrw3HutX+iOcgBUGIfR3dnFpWcGr3kbrmR7XC4BG70
         xDSSzIzdzbGJ+oXgb3AHb+qc2O+dvEVCHghPXySgNOreWyjIR/I5orgibQulyxTD88MR
         DspRhlQ00dN1UuheBYFKSyIeDRPDwd+unbec3tINNezouNgMI2xnbHf9c4RMF4qyugUD
         906w==
X-Gm-Message-State: AOAM530EVPh1Y6umHoDwBfe3nPctXD6qhf3oqq3WyUVQdtHDWYufIay0
        DgkvWIDdRWJSWRUMR0wKBFdS3g==
X-Google-Smtp-Source: ABdhPJzeBpIgIi/zG/D08jMYwrLflVz1Uqza/UWtwjHNGHQ6oPqiRfpUHb7TiZbT16hi1bvn2EFRVw==
X-Received: by 2002:a17:90b:3708:b0:1df:56ac:65c6 with SMTP id mg8-20020a17090b370800b001df56ac65c6mr9437224pjb.23.1653671062757;
        Fri, 27 May 2022 10:04:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fbc7:30a9:c3f6:e550])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902b18600b0015ea9aabd19sm3899674plr.241.2022.05.27.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:04:22 -0700 (PDT)
Date:   Fri, 27 May 2022 10:04:16 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/5] receive-pack: use bug() and BUG_if_bug()
Message-ID: <YpEEkEObs0zYmV8v@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.21 19:14, Ævar Arnfjörð Bjarmason wrote:
> Amend code added in a6a84319686 (receive-pack.c: shorten the
> execute_commands loop over all commands, 2015-01-07) and amended to
> hard die in b6a4788586d (receive-pack.c: die instead of error in case
> of possible future bug, 2015-01-07) to the new bug() function instead.
> 
> Let's also rename the warn_if_*() function that code is in to
> BUG_if_*(), its name became outdated in b6a4788586d.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/receive-pack.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index ad20b41e3c8..d1b3e5c419e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1810,21 +1810,17 @@ static int should_process_cmd(struct command *cmd)
>  	return !cmd->error_string && !cmd->skip_update;
>  }
>  
> -static void warn_if_skipped_connectivity_check(struct command *commands,
> +static void BUG_if_skipped_connectivity_check(struct command *commands,
>  					       struct shallow_info *si)
>  {
>  	struct command *cmd;
> -	int checked_connectivity = 1;
>  
>  	for (cmd = commands; cmd; cmd = cmd->next) {
> -		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
> -			error("BUG: connectivity check has not been run on ref %s",
> -			      cmd->ref_name);
> -			checked_connectivity = 0;
> -		}
> +		if (!should_process_cmd(cmd) && si->shallow_ref[cmd->index])

Unless I'm missing something, the logic has flipped here:
- if(should_process_cmd(cmd) && ...
+ if(!should_process_cmd(cmd) && ...

Seems like a mistake, but if this is intentional could you please
describe in the commit message what it was intended to fix?


> +			bug("connectivity check has not been run on ref %s",
> +			    cmd->ref_name);
>  	}
> -	if (!checked_connectivity)
> -		BUG("connectivity check skipped???");
> +	BUG_if_bug();
>  }
>  
>  static void execute_commands_non_atomic(struct command *commands,
> @@ -2005,7 +2001,7 @@ static void execute_commands(struct command *commands,
>  		execute_commands_non_atomic(commands, si);
>  
>  	if (shallow_update)
> -		warn_if_skipped_connectivity_check(commands, si);
> +		BUG_if_skipped_connectivity_check(commands, si);
>  }
>  
>  static struct command **queue_command(struct command **tail,
> -- 
> 2.36.1.960.g7a4e2fc85c9
> 
