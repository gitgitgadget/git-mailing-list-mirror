Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502164086B
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299254; cv=none; b=YAtABjyltpqzee+RmnF0u+9EaIJpzQROOHyy3EBSU93tlbupgBXv5wq3LWQS1l9b7T5Efow/y2giLJvzQ3wwlMIl4IF3Ic/pjuhd/iWSexEcEYCGmAryL9bcEUToKbDftOPDyCsv0Yikl+3KRzjswjAheQzyCopD8ECM/RGOirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299254; c=relaxed/simple;
	bh=/rnzlQZLEgcOY8lAleivHCcrRKDkPvh8IMN3YLI5REU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkasvyCsRS7kbFCWl/XEiQsZ2VAFvh+4XIwYuadhbp4Vw0TMaZ32A3OdvbHkU43ut5N+KSqWVhJetmB+caT79Ov5HR2jVLebqEOBV1ipnDPqXJARyBnPKD+T+1OnnIxM9xBm51FNZBKx7enigs+VAokZeGNHE05ie816HcmoWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnrNvpkb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnrNvpkb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412cbf58fdeso1011385e9.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709299250; x=1709904050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbCEKBceNaJlsyQaGtP4pWZ0sDsq/Lx9BPBhQaBuEUs=;
        b=EnrNvpkbPO/t0HvJDyeNqpA+St59kRujpuNStLGudIMo2yr1gmiJbXkS4s47bO8DcR
         JUgBZUmIb8Ld2OyIHZ1yk+RoErDHET32WJSO6I6a1JcbmP/WtgYntFVeYNcckVURwzsE
         c7DKkuoCvDxxOQMGWaFL4y5dNzcye7Ty63MvX9Nhvw4EJ0W4kAg9mEGE4Ku2oa+CIEKO
         sL8IyIKUMCpjIQMIobkmQSa4hRRkTr+IXPZFrbieJwRV2dVMQqOiUxCRw//y/w5iO4HE
         p2y7AJQOMgmMRTy49fT++KQi99q3p18dYkpvAgfrCiRspYrrdnkpyNu0FP52nU5JSlWL
         GE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299250; x=1709904050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbCEKBceNaJlsyQaGtP4pWZ0sDsq/Lx9BPBhQaBuEUs=;
        b=h82q7fysNkMvbNO17WVD/FKDn8pCHQzr70Vt4kUXx8jQCkCBIgrdR2UO8PBBnJ+cwF
         YxfK7WJgES3bwsmuuvIbyjfFOcbkgsnOqysFC6I+Q8KPnhwy8jONC5OuI13/++M1pzod
         yd6yL2bTpobwaTB59prYgezhvJW/mbQpoW0QFmE96I6A9Vv+NQTlN4fOJ2sTmoyCRK7m
         wTuWfsWyl3Tqxb/1E90iihwJ2JZE6aARN3Nder8XF0HkGSPYFxkmFKSoGyU65tO+qC8N
         eMYMepUu8Nf9deoxV5vbeuxpZcIswVB7iznNfdQ7af1ZEG3JZIb2kJ/fjTqkITmQ9vS3
         wzpA==
X-Gm-Message-State: AOJu0YySgHbWSL4LGtGl34ZcYMTwptjmlS4Cmn9A4KYyPk+RY3h7hmdP
	DNJK4AWjlFJGxVRG1ar/g7op6Ad/LjJ9Ii+vSs1O6zV4U/l5zDVWtiWiU3MxXgU=
X-Google-Smtp-Source: AGHT+IGoMUOGmXNBZhMmUR5zMfFyxJMxJN12Pjty77rgJjC4Ym6aVq5yXPeCGK2xLloKY7asLObV5g==
X-Received: by 2002:a05:600c:1c07:b0:412:b818:d136 with SMTP id j7-20020a05600c1c0700b00412b818d136mr1425278wms.29.1709299250150;
        Fri, 01 Mar 2024 05:20:50 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id l22-20020a05600c4f1600b004128f41a13fsm5488044wmq.38.2024.03.01.05.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:20:49 -0800 (PST)
Message-ID: <51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
Date: Fri, 1 Mar 2024 14:20:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
Content-Language: fr
To: Sergey Organov <sorganov@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <875xy76qe1.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Putting my documentation/translator hat:

Le 29/02/2024 à 20:07, Sergey Organov a écrit :
> What -n actually does in addition to its documented behavior is
> ignoring of configuration variable clean.requireForce, that makes
> sense provided -n prevents files removal anyway.
> 
> So, first, document this in the manual, and then modify implementation
> to make this more explicit in the code.
> 
> Improved implementation also stops to share single internal variable
> 'force' between command-line -f option and configuration variable
> clean.requireForce, resulting in more clear logic.
> 
> The error messages now do not mention -n as well, as it seems
> unnecessary and does not reflect clarified implementation.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-clean.txt |  2 ++
>  builtin/clean.c             | 26 +++++++++++++-------------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 69331e3f05a1..662eebb85207 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -49,6 +49,8 @@ OPTIONS
>  -n::
>  --dry-run::
>  	Don't actually remove anything, just show what would be done.
> +	Configuration variable clean.requireForce is ignored, as
> +	nothing will be deleted anyway.

Please use backticks for options, configuration and environment names:
`clean.requireForce`
>  
>  -q::
>  --quiet::
> diff --git a/builtin/clean.c b/builtin/clean.c
> index d90766cad3a0..fcc50d08ee9b 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -25,7 +25,7 @@
>  #include "help.h"
>  #include "prompt.h"
>  
> -static int force = -1; /* unset */
> +static int require_force = -1; /* unset */
>  static int interactive;
>  static struct string_list del_list = STRING_LIST_INIT_DUP;
>  static unsigned int colopts;
> @@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "clean.requireforce")) {
> -		force = !git_config_bool(var, value);
> +		require_force = git_config_bool(var, value);
>  		return 0;
>  	}
>  
> @@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  {
>  	int i, res;
>  	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
> -	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
> +	int ignored_only = 0, force = 0, errors = 0, gone = 1;
>  	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
>  	struct strbuf abs_path = STRBUF_INIT;
>  	struct dir_struct dir = DIR_INIT;
> @@ -946,21 +946,21 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	git_config(git_clean_config, NULL);
> -	if (force < 0)
> -		force = 0;
> -	else
> -		config_set = 1;
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>  			     0);
>  
> -	if (!interactive && !dry_run && !force) {
> -		if (config_set)
> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
> +	/* Dry run won't remove anything, so requiring force makes no sense */
> +	if(dry_run)
> +		require_force = 0;
> +
> +	if (!force && !interactive) {
> +		if (require_force > 0)
> +			die(_("clean.requireForce set to true and neither -f, nor -i given; "
> +				  "refusing to clean"));
> +		else if (require_force < 0)
> +			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "
>  				  "refusing to clean"));
> -		else
> -			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
> -				  " refusing to clean"));
>  	}
>  

The last two cases can be coalesced into a single case (the last one),
because the difference in the messages does not bring more information
to the user.



>  	if (force > 1)
> 
> base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d

