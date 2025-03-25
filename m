Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A79257AF2
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913350; cv=none; b=G9GDxeppZKgbKYY3RQEdJti6+EUF1y0tjaPhQ3XW0fF7K4NJICnfx1toUK6ZfQDtYGABVujyc0pLgxXDPnCW2nkrPViptHz3LAtXopgWsIVSp8QqIsl/Ss9o/9KtR4TY31fGqMeRF9EG1TP69VHRyuT2HWV7O2kc+MnM9PdIiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913350; c=relaxed/simple;
	bh=5U4EJFlPIhvyVWKU04fuTddQlC7toao26BNxzoKh+no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0V+B5QcYr4jgGJkiJx5CD+bdPbMtir7gzUB6BPBFDbBVeQmmdDR6KnBb9OriqmkseQPN8pMk4csduN7XvFGvZlEj0jIFb4lrcHpszuxFv/Tno/HnOHRPAROiWAhMtF+QvLsmvXKkDCbB+yMVJqT+QPbEZMuGr9eWn8Sy7IWBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzR2a4Oq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzR2a4Oq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39143200ddaso3301351f8f.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913347; x=1743518147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qeeXdsDwL4yAPT63kH0M9kbslm+J4PsydoaTp6gcqyA=;
        b=dzR2a4Oqmp/w8WzWng2odUgKMxzLOR/tLKTT1a+d9r+szPrH5u2j5x9Ls15lp3hFv1
         2QVr4aiwaWnPqWGPu2ZrxoY3Tjk1F3ZhVGIz+dZIVX6W6+2sI7k/Km5VOK+9w1aC/4hr
         txnKIOg5rFwhqW9gZH6JgM6GIpkIcZkanzBbgDgIZB8tuxnmzCB6QVpOvbEbXHsq+omj
         pJiYYmZtpYW2Is8W18sXpRgXEh1qZJlAzb5yR0O3lCAkLUkgsnAPQziRY14pvmaXtsn1
         pq0Qgrmy+yjphT0LQwigiIYeJO8Wv1vfbdvIrnYpnWXT+k3Dq2uQmuRHLGsuDApOpqBX
         hdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913347; x=1743518147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeeXdsDwL4yAPT63kH0M9kbslm+J4PsydoaTp6gcqyA=;
        b=nrqDW6IuLbkNX8O3Q3fWAvvysVeVMiUbXRV0qt6TLC+9zoq99FX7jb5Ju6NuMIlfpI
         6p62EDRujJWgRMJYjNOPUIEcvdcSeBC90YwW0qigAmecQzmkLMMWk+RRa69fua86V9Hj
         i6MFxVcWeZLe+UMAneiD3Z7/19oAWrx0C/Wrx6Q4nDUnUMNBA188ErVKG87UrYrEACKA
         6VJFVsZXPojNoRpfNpY8F1P1vhhM1BO8TLfWNoisC1TXGkeNRnmwx1ACxCTdSkwXRp8i
         2qPi4nO97eHHtMcOnSvxMWgJ02MFK0BWT0fZYao420mTZv/wze29hZbqiJPYkaUTwn/I
         FFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0z7DrCoaGleoLQzS//MJzwzMT+LSwWIRFi+PP11g1g/btpopqGOOKQscc1tdCogt0c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPz3z5aXB1FsuBuaYeMIm1FHwPay1y/H+dYvTfdk7wINVwnSif
	169zXRggnmwQwbrAJxrWvFf+v/yI7rqdVsv8LrmGPuXzx7R/hOD/
X-Gm-Gg: ASbGncsitUG4CFQRcQVEjQPZRSf3D1pFME5yUCWxP4k1XKhnJs/j7xVioHh/gTOhiyg
	wWsslSL8BpLcpjgJQFAD+ovMQarMq16ZdSsujD7iQPOxI4YU7/R7xm32clSxLP9Q6I4Vxm/WyOn
	QJ8NPgnKS4/CnxRcVQH2vIVPZfqZz/3Tbjlb+DFyvWho4hKcufT5/pXKmkyVDfQaIMLtV+qn8E1
	aIIfXC9Pq8wvbVDc+UINlDjCJV02NdvPswQZDlIhJNdiI/LhYDpBHRIw/SkA8XRfEh2dTK4pmyE
	C9bqaiF9dSrRJ34U0DcgDcVNtRA1lesw2dAKWUPJAy95jCBQRq1zlvGlFVigVPMFEdPxC3TH4iI
	544UHNyXIpKpUF95Xt7lZ
X-Google-Smtp-Source: AGHT+IHVCBAyk4/0mr40Dd1kcT2ICBYx9o25Lptdg1KsYpiCkDgIAEQwsRKTcYVYY2mT+NmO4S+NaQ==
X-Received: by 2002:a5d:6485:0:b0:391:2a9f:2fcb with SMTP id ffacd0b85a97d-3997f932d70mr15307685f8f.36.1742913347101;
        Tue, 25 Mar 2025 07:35:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556a4sm203125345e9.22.2025.03.25.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:35:46 -0700 (PDT)
Message-ID: <b7145e94-f5c5-496e-9d36-0022841ceae6@gmail.com>
Date: Tue, 25 Mar 2025 14:35:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: avoid using the comma operator unnecessarily
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <7dfbdc48954b55a435c8cb429b648d77a1a9d044.1742889711.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <7dfbdc48954b55a435c8cb429b648d77a1a9d044.1742889711.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
 > > diff --git a/builtin/rebase.c b/builtin/rebase.c
> index d4715ed35d7..62bdf7276f7 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1843,7 +1843,7 @@ int cmd_rebase(int argc,
>   	strbuf_addf(&msg, "%s (start): checkout %s",
>   		    options.reflog_action, options.onto_name);
>   	ropts.oid = &options.onto->object.oid;
> -	ropts.orig_head = &options.orig_head->object.oid,
> +	ropts.orig_head = &options.orig_head->object.oid;

This is obviously a typo - thanks for fixing it

Best Wishes

Phillip

>   	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
>   			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>   	ropts.head_msg = msg.buf;

