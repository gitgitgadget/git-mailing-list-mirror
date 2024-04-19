Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE48565D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535800; cv=none; b=UQrlaRldQr08QUlhwvs+72TAjDCzxJns12enJceDVcQBM9SzY30u8R4Oyy6F+KhX5YMpgJru2Fy7qRjbTZnCD1zhhago4wqRwfnYePKQ8Bzve+b3xYtqK7X7EZSFXxUZ1BzTbHiHhcZ7jAoKRqEyi70iJTnDklyywp++mwW9C5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535800; c=relaxed/simple;
	bh=6+G2uDxKVU3H2wYbWqTdBRwKRuFGG3DbDycoI+eSUuM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p/Ch6ZbLMgrZw+rcZvjrhgXV4Fz4kNhukxnqOoP3YYigzeoRE3f4MNuwEx+sgbIw5ZPZ2jUovS9dU6gpxlEyZGWGWqB7dQPUYLyw7xSeUTerrXd5XjGHLBtbeq0G1IWLaG5sj7caCFhqNGGrRZMA3jZadB3LQXAfPchCP2rRj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUxItQ0l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUxItQ0l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3499f1bed15so1774798f8f.1
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713535797; x=1714140597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFLCADB+mh/fPqaeNLbwE0iX8/y/kOj1SPzATZ15Uvc=;
        b=AUxItQ0lbCnmEg4BKAeowGBa5VN6YRB2DL1xAnc+b5tP2RqZEDDDnhSODRIsEp81Z7
         OUbRsfLFhBD9BgC33Bs4CXZ31nu+y33P3sRVjpMXc0Ugt8DB2S8SuLe6x/gWoaCWJ8a3
         tdXmQoWd6EA4p7omNsPdUuxmicnq7gWsNAjTNu99dwx58sOcNLJY+/2eN8e/dDM95AYS
         /8nzWiC8DneDq/nyuOGiqw1MWDCrvunzQB9wSw45QuXRnq47L/vZZ1ZxuMEWdRs+PHcQ
         AlUZ9y8Dpex1unxAn5mBAv6QqQ4Pi7YS5/AK9v6+HPAdSLk9WXEPE0PigQON5cvx/3Rs
         1unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535797; x=1714140597;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFLCADB+mh/fPqaeNLbwE0iX8/y/kOj1SPzATZ15Uvc=;
        b=YjF7phJslqmagk+YbB163C79y+NDTbb446x3OlIObMbsxuXha/DnQ+CPOgdOCNESnf
         +K4/To2V5oPU8OfVaqOsNTlmkZDl4k+j0oCm2+Felm+2WRlAd9vT7R+z8N2TglHESxGv
         Q0IDmQ1xHbF1/tSbqSvXaRXwbE7Nue3peBu9NqzjtpHId18w2uwZ+d/Zakn5C4dQKx3O
         eCL70ZEMPoCKOuyjD6igDrCK7lKNpSPGtWLnDPPVMKz1cEdLcyK+ha0w+ppjDL/tuUy6
         fGZo7xv5/bppG08egY+R8t9HTjR/TGUHf20p+aHOUQIq5wYCSVv8pHgvQvwEMoUKSG1Q
         7zzw==
X-Forwarded-Encrypted: i=1; AJvYcCW0t9UmiqKi0GTyFp7lBbKMFSS35c1al+tHcTOjZOb4rIyvYI2x4OqjDPcGjFhiogaMHH/exCyZVeg/ALSfPxLfrfdW
X-Gm-Message-State: AOJu0Yxx9vHpZkWYhDzwUmjplf3dotjXBnT89j+39IBR/c1twh4adCZ8
	qu7sS2au+l3/qeT7NkT5shDcTFxmXmHOMyeGFNm8UyNtbWXoYOZKzsKQXA==
X-Google-Smtp-Source: AGHT+IFaVz5lDI5JTA6gU8HUrEpyhLkyqIY80YwueSQ7908T+H1Sk1P66aHQiDsDpMPwdvP8YiCUgA==
X-Received: by 2002:adf:fa90:0:b0:347:e635:c86e with SMTP id h16-20020adffa90000000b00347e635c86emr4370158wrr.33.1713535796664;
        Fri, 19 Apr 2024 07:09:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b00418c0d8446asm9623004wmn.27.2024.04.19.07.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 07:09:56 -0700 (PDT)
Message-ID: <9f846a3d-5244-43ec-b392-156665be0929@gmail.com>
Date: Fri, 19 Apr 2024 15:09:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>
References: <xmqqzftqnuxq.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqzftqnuxq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 18/04/2024 23:54, Junio C Hamano wrote:
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
> "--rfc=RFC").
> 
> This can of course be (ab)used to make the prefix "[WIP PATCH]" by
> passing "--rfc=WIP".

I think being able to customize the subject prefix in this way is a good 
idea and makes it easy to say [RESEND PATCH program] with --rfc=RESEND 
when format.subjectPrefix is set. We could add a separate option to as 
"--rfc" already exists I think it is reasonable to extend it. (I'm also 
not a good name for such an option would be "--subject-prefix-prefix" 
kind of describes what it does but is far from ideal)

> -		   [--rfc] [--subject-prefix=<subject-prefix>]
> +		   [--rfc[=<rfc>]] [--subject-prefix=<subject-prefix>]

Nit: in the documentation we use "<rfc>" for the placeholder but in the 
code we use "<extra>"

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
> +is not complete yet.

This reworded description is good

>   	const struct option builtin_format_patch_options[] = {
>   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> @@ -1932,7 +1944,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   			    N_("mark the series as Nth re-roll")),
>   		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>   			    N_("max length of output filename")),
> -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
> +		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
> +			       N_("add <extra> (default 'RFC') before 'PATCH'"),
> +			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),

This is a change in behavior as it looks like we previously accepted 
"--no-rfc" is that deliberate?

Best Wishes

Phillip
