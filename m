Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3DC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 10:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiD0LCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiD0LCE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 07:02:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1C40665C
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 03:46:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id be20so1425918edb.12
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CcbgIQW93RS0rnOKw8hKogMlBgh89+SaQTxUgylyRoM=;
        b=aaoZkvFGvD0bJwz5A21x3CbWZ4UnMNlskFqXdprmB8BRwOmMyzAB8cXR6+m1acX9Gr
         3dUEVfjcUSwnq0rdjf0YiDm9JCeyPwnGIhhIjU9ZKqGcxdB3NoPQZBiqAUxP2E9prHHS
         zzL/iOJW+rjBgDIcu4Bdu8h3UerK/zXRVvS83b7e3DzsvAGOPt6m3ph1OxMbUe0fXggg
         sNDGPOukAvwy4y0FCoLZzWaXgHxdOmOvL2N9e9jC6PIX1O1m/tB0sUUDqy7bhIWJMY5E
         xpbdvmnpkZJbkpuJhnJXfXsi7sxw9AKFkwyVsmSmAzHPvukS7c/dhFEqg13PmRXYSMPW
         PsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CcbgIQW93RS0rnOKw8hKogMlBgh89+SaQTxUgylyRoM=;
        b=wt0URJSSEbRTxAjgWBohBGlGWnDyf1LrLAJKFjGYd6p7Y2Z2nOBsJo2ABfBmaiNM9Y
         C9B+F5ZkMt2xXwl3drD7zFc3m9rG6jxkLxXSH3TnAaOiPg5KNh0Qi2VcY8hDKReh6rRd
         fu0NHh1JqvBLXUnlTckRpOxqAzrTRgnOStCLVsttvdzaECfLyf2dARmkK7I6y8Y/FmeD
         YGJ8UJD9pR/CpsuQc7Q6FqLvQTbLTmVU2Rke5ac8rPdCsQ2Y+j5aoGT1680FjPsM3iNI
         iUTYlseKV+v4yY24yTgSr2PnjYLKKAuZIEis/KIBzI85tAGLJ/3h2k1XRFs5jwXyPBCG
         0vuQ==
X-Gm-Message-State: AOAM531BzplgavYYFDWe2GdMnHLCJMGRZRfplmxZjl0yqan/IZeGfMz5
        g6GXzoms+BlNJKK2W15Co8ANAiimA4w=
X-Google-Smtp-Source: ABdhPJxcHU9sR/vAy/OCGqmn4YeDsasU2w60AhI86odjqTp8h/RUa1T+k0nxdxLcTtxL/qK3Uh3GWw==
X-Received: by 2002:a05:6000:1c16:b0:207:bc18:d0c2 with SMTP id ba22-20020a0560001c1600b00207bc18d0c2mr20903267wrb.533.1651051988310;
        Wed, 27 Apr 2022 02:33:08 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0039082eeff53sm1147383wms.22.2022.04.27.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 02:33:07 -0700 (PDT)
Message-ID: <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
Date:   Wed, 27 Apr 2022 10:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220427000522.15637-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 27/04/2022 01:05, Carlo Marcelo Arenas Belón wrote:
> bdc77d1d685 (Add a function to determine whether a path is owned by the
> current user, 2022-03-02) checks for the effective uid of the running
> process using geteuid() but didn't account for cases where that uid was
> root (because git was invoked through sudo or a compatible tool) and the
> original user that repository trusted for its config was different,
> therefore failing the following common use case:
> 
>    guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>    [sudo] password for guy:
>    fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)
> 
> Attempt to detect those cases by using the environment variables that
> sudo or compatible tools create to keep track of the original user id,
> and do the ownership check using that instead.
> 
> This assumes the environment the user is running with after going
> privileged can't be tampered with, and also does the check only for
> root to keep the most common case less complicated, but as a side effect
> will miss cases where sudo (or an equivalent) was used to change to
> another unprivileged user or where the equivalent tool used to raise
> privileges didn't track the original id in a sudo compatible way.
> 
> Reported-by: Guy Maurel <guy.j@maurel.de>
> Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Randall Becker <rsbecker@nexbridge.com>
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Changes since RFC
> * Addresses all spelling errors, even the ones not reported and even if I
>    am sure "priviledged" is a nicer sounding word even if obsoleted.
> * Uses strtol instead of atoi as suggested by Randall and Junio, the extra
>    error checking was too much to handle inline so a new helper function
>    was added.
> * Removes checks for DOAS_UID, in an attempt to make the change smaller
>    and because that is part of an extention that might not be that common.
>    This means `doas` is still broken, but that was punted for now.
> * Has been tested a little more, but is still missing a test case, but
>    as Derrick pointed out doing so is not trivial, so punted for now.
> 
>   git-compat-util.h | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58fd813bd01..9bb0eb5087a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -437,12 +437,48 @@ static inline int git_offset_1st_component(const char *path)
>   #endif
>   
>   #ifndef is_path_owned_by_current_user
> +
> +#ifdef __TANDEM
> +#define ROOT_UID 65535
> +#else
> +#define ROOT_UID 0
> +#endif
> +
> +/*
> + * this helper function overrides a ROOT_UID with the one provided by
> + * an environment variable, do not use unless the original uid is
> + * root
> + */
> +static inline int extract_id_from_env(const char *env, uid_t *id)

Do we really want this living in git-compat-util.h?

> +{
> +	const char *real_uid = getenv(env);
> +
> +	if (real_uid && *real_uid) {
> +		char *error;
> +		long extracted_id = strtol(real_uid, &error, 10);
> +		if (!*error && LONG_MIN < extracted_id &&
> +				extracted_id < LONG_MAX) {

strtol() returns a long so the last two checks are redundant. The 
standard is silent on what happens to error when the value is out of 
range. The way to check that all the string was consumed without 
underflow/overflow is

	errno = 0;
	val = strtol(str, &endp, 10);
	if (errno || !*endp)
		error(...)

In this case I think negative values make no sense as I believe uids are 
always positive integers so we should add a check for "extracted_id < 0"

> +			*id = (uid_t)extracted_id;

There is a potential integer truncation here which could lead to false 
positives. I'm not sure that there is a way to query the maximum valid 
uid but we could do

	#if sizeof(uid_t) == sizeof(int)
		if (extracted_id > INT_MAX)
			error(...)
	#endif

Unfortunately I think we need to use #if rather than if to prevent 
compilers complaining that the condition is always true or always false.

Checking the real user id from an environment variable makes me feel a 
bit queasy but as others have pointed out if an attacker can mess with 
the users environment then they can already override $PATH.

Best Wishes

Phillip

> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>   static inline int is_path_owned_by_current_uid(const char *path)
>   {
>   	struct stat st;
> +	uid_t euid;
> +
>   	if (lstat(path, &st))
>   		return 0;
> -	return st.st_uid == geteuid();
> +
> +	euid = geteuid();
> +	if (euid == ROOT_UID) {
> +		/* we might have raised our privileges with sudo */
> +		extract_id_from_env("SUDO_UID", &euid);
> +	}
> +	return st.st_uid == euid;
>   }
>   
>   #define is_path_owned_by_current_user is_path_owned_by_current_uid

