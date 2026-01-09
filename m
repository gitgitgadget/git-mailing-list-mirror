Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A22BE655
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970586; cv=none; b=HKOxF3pC8dFZTIi1KP/XwwNdmVvefdStqQm6SEwU/MNtsjx50xbNaNki5aEzY7MyHVclyZKEVVthu91IGpQ8DeCjDWFcNRPsUQjeGiw5mggQkCzp+2ZhnpOCrNGhi7rqyENAXzrHxusWQRnUGQJlfoDA8jJ8YABBg+a110TUCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970586; c=relaxed/simple;
	bh=uCEPNgTmNlVA1eCkJESrdeg9DaAkW0nWlnxKUcz2+MU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hx81BP9jlV6jNEME/pjX4rSQAbezXsyXfsh3ktBmhY11rPgi5dwEwdEIrcDgLcmK+B1Lo1UIbjM7hkCZb1lQEHemj2wf5xW5zliyjVRMj0RI7AkgR7CRHCHaFzMptX6zDd0HdX5qTpuBIjiGcHY00yCeGpCaKmiVu1ROXGnsvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgc2yVqq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgc2yVqq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2341381f8f.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767970583; x=1768575383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/IjgaOifP8tMs8u7lOZWPoSGAF+DJ6ISI3SKBSdMwaU=;
        b=Vgc2yVqqkunt/JXdF8LGz7ZBSWOsPOxSgfZMiWsfvXyCDlnZuDiGq6WslkNmrr+mNW
         CHBQreTAyuKqE1V+7jfStT0NjuP4taL9nYQK8BwYtwZfu4HjqRfznSpi69sclpTWe6f0
         /Kn5H0h9Jdzc7u7NmCAMWmSxvUzoGcV/st0SiKUQojaud6JydzlT4I/orQmksfnmsf+a
         bsniqNjFZE+IDIK1GjKoUZ8iwDrwwVjHW+EzXrPvtPf7SQ/nvjyEvDuYdySSnSD1M8Ym
         dlWDlDjFK7mUChrQ+qiG2dYKd2cQ/yj9XRQZ88UKSfjgyKsEGG+QapoZ9s9U7vn6dGUE
         UZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767970583; x=1768575383;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IjgaOifP8tMs8u7lOZWPoSGAF+DJ6ISI3SKBSdMwaU=;
        b=r0D1HsMR7/OxeCzvN/WVeNhibzmCO7ycDPZdmXsM7RMekkSfrP6xAiVBb0GKbdLzCk
         XQPn+j7nkZK+w7LB+VumD31PyCBBr9kjststNAry3MtAoKXgieIpjnI+YxT9ixxdMwMD
         IoIpEQu547JHCjqKe1Oy1ZZerv0AuzkUMDQa5tZzLZJiVdvmo51yjOYUlBNComuRf8cw
         fy6gXjhkG42egQTTT8hE50D4g0z5CNit7xNkjrTk93zm4WEw9filOU8qKzsi07Q2x4CR
         tRZmXObxFZb8IrXcui1l+IduoQv+pJGnzY4fQZ0l8t6lp8XTf/WyPhtkHrzIbKbUZx+q
         xLXg==
X-Forwarded-Encrypted: i=1; AJvYcCWx3HSTU7NtQpGaJ06Yl7YQ6sjckDvCzZbQ3Xf6u8NZHK7GuKcrqtCSwE0CpSaFa24PTWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWHAnEsdFfocusIMSl0o6iw3EjlzIHNhnas6/XG9YY0HZ9Zts
	s+b820Fz0TStk7xDSDhI22ikHgxUO9f4s/eIifDuQTSsYP3H7pikziMQ
X-Gm-Gg: AY/fxX4TlFr93ATY5jSYVxnudBfywF4Jp2pxzG+iR4Krp3uc5OMyKO2n6LwF6RuAWBg
	xDcjNWdofYTYVL0hxiS/gWsYxHyy+BsD5Y7aNMHbm4hiTtVG62oPxAuZzAJ1Tal8mIWz1HKDDIN
	VR1/Rc1gSrDqCZHzvPryqrzWXCLsCLymrjy1RYNseiZrdn7CcbG2dIdEqqUI4e1NyyKIJa48nVs
	NuEcEQyxtulrzBG8VQX3VMozsuAYrFhZUIBbBlzt1K/VXHPNMR3BvVqCmtt23rb8JV1/YHF4Nl6
	WmSG6IdiIhvIhBXxjYH80TFXLqj9t4CbSSlLE+RP9X10eNwxu9p1+4nnUTsXd93HtYGkTZlqTuy
	9mynvAET093CqNJno2r644Lh05oUjSawCLmj+VIyV0bgM9j/NVYSlgCkwUSP24T0V/l5g6GriEu
	j2xhc3If7KrLUbN1hui1m4AMHmJAsQcotYqEepy71jnKsBOG57KH8ygQfzxRlHg9RsOvZIPYYTu
	2yu
X-Google-Smtp-Source: AGHT+IEIgGKoy+tkvSCl3dZqB9fJ09aRaRzjY7G3z27hcxAFFHaoTlDvFDEUMDf8UODZwbCuE0Bsyg==
X-Received: by 2002:a05:6000:2384:b0:431:397:4c45 with SMTP id ffacd0b85a97d-432c37767c2mr10456288f8f.59.1767970582717;
        Fri, 09 Jan 2026 06:56:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm22453563f8f.4.2026.01.09.06.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 06:56:22 -0800 (PST)
Message-ID: <daab4e8f-cd9e-40af-bdfd-c5884d15d852@gmail.com>
Date: Fri, 9 Jan 2026 14:56:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
 <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
 <b62a9feb4ddefb34945a83fd7d76c81c871ea144.1767608269.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <b62a9feb4ddefb34945a83fd7d76c81c871ea144.1767608269.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 05/01/2026 10:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> +static void format_branch_comparison(struct strbuf *sb,
> +				     int sti,

I wondered why we needed to pass sti as well as ours and theirs but it 
is because when we're using AHEAD_BEHIND_QUICK our and theirs are always 
zero and so we need to check sti to see if the branch is up to date. 
Perhaps we could make this a boolean called 'up_to_date' ?

> +				     int ours, int theirs,
> +				     const char *branch_name,
> +				     enum ahead_behind_flags abf,
> +				     int show_divergence_advice)

This could be 'bool' not 'int'

Everything else looks fine - it is a faithful conversion from the 
original and it makes sense to check if the upstream is gone in the caller.

Thanks

Phillip

> +{
> +	if (!sti) {
>   		strbuf_addf(sb,
>   			_("Your branch is up to date with '%s'.\n"),
> -			base);
> +			branch_name);
>   	} else if (abf == AHEAD_BEHIND_QUICK) {
>   		strbuf_addf(sb,
>   			    _("Your branch and '%s' refer to different commits.\n"),
> -			    base);
> +			    branch_name);
>   		if (advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>   				    "git status --ahead-behind");
> @@ -2281,7 +2260,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			Q_("Your branch is ahead of '%s' by %d commit.\n",
>   			   "Your branch is ahead of '%s' by %d commits.\n",
>   			   ours),
> -			base, ours);
> +			branch_name, ours);
>   		if (advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addstr(sb,
>   				_("  (use \"git push\" to publish your local commits)\n"));
> @@ -2292,7 +2271,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			   "Your branch is behind '%s' by %d commits, "
>   			       "and can be fast-forwarded.\n",
>   			   theirs),
> -			base, theirs);
> +			branch_name, theirs);
>   		if (advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addstr(sb,
>   				_("  (use \"git pull\" to update your local branch)\n"));
> @@ -2305,12 +2284,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			       "and have %d and %d different commits each, "
>   			       "respectively.\n",
>   			   ours + theirs),
> -			base, ours, theirs);
> +			branch_name, ours, theirs);
>   		if (show_divergence_advice &&
>   		    advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addstr(sb,
>   				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
>   	}
> +}
> +
> +/*
> + * Return true when there is anything to report, otherwise false.
> + */
> +int format_tracking_info(struct branch *branch, struct strbuf *sb,
> +			 enum ahead_behind_flags abf,
> +			 int show_divergence_advice)
> +{
> +	int ours, theirs, sti;
> +	const char *full_base;
> +	char *base;
> +	int upstream_is_gone = 0;
> +
> +	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
> +	if (sti < 0) {
> +		if (!full_base)
> +			return 0;
> +		upstream_is_gone = 1;
> +	}
> +
> +	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> +					    full_base, 0);
> +
> +	if (upstream_is_gone) {
> +		strbuf_addf(sb,
> +			_("Your branch is based on '%s', but the upstream is gone.\n"),
> +			base);
> +		if (advice_enabled(ADVICE_STATUS_HINTS))
> +			strbuf_addstr(sb,
> +				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
> +	} else {
> +		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
> +	}
> +
>   	free(base);
>   	return 1;
>   }

