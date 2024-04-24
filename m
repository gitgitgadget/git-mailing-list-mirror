Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A715AD92
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953779; cv=none; b=iIm8U3Th3thGT+CEEOpH7rn974vwuTTCrbyHpvGW23KX07w5oyhD7/U3hKvzYLXibo5nlKFQ9bj9gf/HCk6C6pYSHn+LODDJV8GLWmUaj/bb7dvlvqcX/7MgqAV2F+tuqyeU1SKLVgDHxpB/qZqJ8fS0sfQZKTmEjMepZ/sb6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953779; c=relaxed/simple;
	bh=/Oui1vj4UqlxL9UaQXeNV0hNtAFZR3n4lk8IHlAIm2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ottc+vkGFkn/c9IC19d088dOO01Fs+p9+/jrPZKCYdJB/ZIFKAPW2rmaAS+BTj4OOO4PbOJJ9TZS18as+TRsneMrdZGm1e+59HKDrFSa6vVWrPY4iFPEarTbsGio60VwFuoMDo1A5E/D0C8oYrkF+K4BsXXQJKCMG5aO1pd/VWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLk44pm6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLk44pm6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b21ed1aaaso62885e9.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713953776; x=1714558576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbJA5dqO9Y6jqrVJnpB/Q8mvQiBrVfxQkTTET5CSVDc=;
        b=jLk44pm6Rs6o+OKaraskMkQFl2f9+fWuIWI4SG+SQWL95aObQMDukWpTuGlLuzihIs
         dZ6QfwPxwEET9ROCO4o/skkgSDNYKNgoYKhTKqIy6M/DBFQ8qrWTLUxNB25e2CtFZ0UQ
         17XueoXhA8cJdgBOhPW5v2pRoS9kTkQDlIv2c0vbADSS+L7BQiHW8tWTDsfdpub02j12
         KSvPc/PfXFx1ns8ZTXbsq2rts3dxTYFSpyTcEcLdMP5CdpcyOoIrlf3pFr+z6js61Nr7
         CDTgjFwR9rW1Oc2ZiDIbeptbGMCs3UCRIrpJYbPyTMdXckdncV2x79r1g1zFi7odHeFK
         CtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953776; x=1714558576;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbJA5dqO9Y6jqrVJnpB/Q8mvQiBrVfxQkTTET5CSVDc=;
        b=Ay3S5bRa313roWMhgfpb/ShbK5PO8tJw22sRJRNukIoeCldbWLqxOK/X8bEEeAG5Lp
         i29ToZX7boXJvMoC4EV3lINz0sO4I2aShyrRaQ727UzsxPX/mfLmT72lNdhuCuEjTSuz
         3dHGxPZpM8XWY5B3ZPmjnzaQLkTZKv+pVEatwpqka6adrdjecguC85SPjU4qUIcHmN73
         +Pr8Y5GM67eR12x3Qz2RAezJY+nBV3PHGPnsf2ZPx6Q0ScdMp9OqROgjohk+6u9iCQFB
         Yxl+OiaY2qRCE5pUHR9+spKYmVkctv5vjSJq8FiodQFZJ9h6+F/MSYK1M3QQtGgLBHg3
         w/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVDPkZL2kzeV5tSQZboVYJ0g8Ewtf9mi/NvmkJDuVd7WxYhMGA3DKqNkgDBsIsCgt/AIwuKUnNjcbgAfQAGc3+lxwGQ
X-Gm-Message-State: AOJu0YzN/f72QBpKL06ROPshk41fyuujNSSsBATMG/nJXu5qXkaIHIjC
	PwXLtUXNhoRIGhIYN5w2LX5+PVw6L7Z/fvaSP0Ka93lHlirZ8/TjucWNTQ==
X-Google-Smtp-Source: AGHT+IHrspA/1Uy2oHRMrqgjUJSBFGz/S4NImIeZmirVuqYB0/e4AR4FNq90Y85n/DflPkCjhPPqdA==
X-Received: by 2002:a05:600c:45ca:b0:419:f533:ef88 with SMTP id s10-20020a05600c45ca00b00419f533ef88mr1448539wmo.11.1713953776083;
        Wed, 24 Apr 2024 03:16:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm23364481wmo.36.2024.04.24.03.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:16:15 -0700 (PDT)
Message-ID: <0664749c-6a85-445f-a794-535024e9fcef@gmail.com>
Date: Wed, 24 Apr 2024 11:16:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] format-patch: allow --rfc to optionally take a
 value, like --rfc=WIP
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
 <20240423175234.170434-2-gitster@pobox.com>
Content-Language: en-US
In-Reply-To: <20240423175234.170434-2-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

This version looks good to me

Best Wishes

Phillip

On 23/04/2024 18:52, Junio C Hamano wrote:
> With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
> string specified with the "--subject-prefix" option, instead of
> "PATCH") that we prefix the title of the commit with into "[RFC
> PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
> option, e.g., "--rfc-lowercase", to support such need every time
> somebody wants to use different strings would lead to insanity of
> accumulating unbounded number of such options.
> 
> Allow an optional value specified for the option, so that users can
> use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
> "--rfc=RFC") if they wanted to.
> 
> This can of course be (ab)used to make the prefix "[WIP PATCH]" by
> passing "--rfc=WIP".  Passing an empty string, i.e., "--rfc=", is
> the same as "--no-rfc" to override an option given earlier on the
> same command line.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/git-format-patch.txt | 15 ++++++++++-----
>   builtin/log.c                      | 23 +++++++++++++++++++----
>   t/t4014-format-patch.sh            | 21 +++++++++++++++++++--
>   3 files changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 728bb3821c..e553810b1e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -20,7 +20,7 @@ SYNOPSIS
>   		   [--in-reply-to=<message-id>] [--suffix=.<sfx>]
>   		   [--ignore-if-in-upstream] [--always]
>   		   [--cover-from-description=<mode>]
> -		   [--rfc] [--subject-prefix=<subject-prefix>]
> +		   [--rfc[=<rfc>]] [--subject-prefix=<subject-prefix>]
>   		   [(--reroll-count|-v) <n>]
>   		   [--to=<email>] [--cc=<email>]
>   		   [--[no-]cover-letter] [--quiet]
> @@ -238,10 +238,15 @@ the patches (with a value of e.g. "PATCH my-project").
>   	value of the `format.filenameMaxLength` configuration
>   	variable, or 64 if unconfigured.
>   
> ---rfc::
> -	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
> -	default). RFC means "Request For Comments"; use this when sending
> -	an experimental patch for discussion rather than application.
> +--rfc[=<rfc>]::
> +	Prepends the string _<rfc>_ (defaults to "RFC") to
> +	the subject prefix.  As the subject prefix defaults to
> +	"PATCH", you'll get "RFC PATCH" by default.
> ++
> +RFC means "Request For Comments"; use this when sending
> +an experimental patch for discussion rather than application.
> +"--rfc=WIP" may also be a useful way to indicate that a patch
> +is not complete yet ("WIP" stands for "Work In Progress").
>   
>   -v <n>::
>   --reroll-count=<n>::
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e9..97ca885b33 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1494,6 +1494,19 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
>   	return 0;
>   }
>   
> +static int rfc_callback(const struct option *opt, const char *arg,
> +			int unset)
> +{
> +	const char **rfc = opt->value;
> +
> +	*rfc = opt->value;
> +	if (unset)
> +		*rfc = NULL;
> +	else
> +		*rfc = arg ? arg : "RFC";
> +	return 0;
> +}
> +
>   static int numbered_cmdline_opt = 0;
>   
>   static int numbered_callback(const struct option *opt, const char *arg,
> @@ -1907,8 +1920,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	struct strbuf rdiff2 = STRBUF_INIT;
>   	struct strbuf rdiff_title = STRBUF_INIT;
>   	struct strbuf sprefix = STRBUF_INIT;
> +	const char *rfc = NULL;
>   	int creation_factor = -1;
> -	int rfc = 0;
>   
>   	const struct option builtin_format_patch_options[] = {
>   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> @@ -1932,7 +1945,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   			    N_("mark the series as Nth re-roll")),
>   		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>   			    N_("max length of output filename")),
> -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
> +		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
> +			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
> +			       PARSE_OPT_OPTARG, rfc_callback),
>   		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
>   			    N_("cover-from-description-mode"),
>   			    N_("generate parts of a cover letter based on a branch's description")),
> @@ -2050,8 +2065,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	if (cover_from_description_arg)
>   		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
>   
> -	if (rfc)
> -		strbuf_insertstr(&sprefix, 0, "RFC ");
> +	if (rfc && rfc[0])
> +		strbuf_insertf(&sprefix, 0, "%s ", rfc);
>   
>   	if (reroll_count) {
>   		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee..645c4189f9 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1368,13 +1368,30 @@ test_expect_success 'empty subject prefix does not have extra space' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success '--rfc' '
> +test_expect_success '--rfc and --no-rfc' '
>   	cat >expect <<-\EOF &&
>   	Subject: [RFC PATCH 1/1] header with . in it
>   	EOF
>   	git format-patch -n -1 --stdout --rfc >patch &&
>   	grep "^Subject:" patch >actual &&
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	git format-patch -n -1 --stdout --rfc --no-rfc >patch &&
> +	sed -e "s/RFC //" expect >expect-raw &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect-raw actual
> +'
> +
> +test_expect_success '--rfc=WIP and --rfc=' '
> +	cat >expect <<-\EOF &&
> +	Subject: [WIP PATCH 1/1] header with . in it
> +	EOF
> +	git format-patch -n -1 --stdout --rfc=WIP >patch &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect actual &&
> +	git format-patch -n -1 --stdout --rfc --rfc= >patch &&
> +	sed -e "s/WIP //" expect >expect-raw &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect-raw actual
>   '
>   
>   test_expect_success '--rfc does not overwrite prefix' '
