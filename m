Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211622688C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044622; cv=none; b=He1nE27Nha9NZXonv1+meWsi5t/PQHKBlfcoCX+zeq8PkwBsbzdWXbmDcipFQ1+rW7Qda7rKuIF/+lMICJRcl9sQb70WgEE81nGg/vu/m2BuhL8Sj0HbeGfMqJebKbaKCaYVu00KicBJsdwS3KFBj2msTLGNA3Bg3gt/QrznwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044622; c=relaxed/simple;
	bh=RgVD0mhMYpmdognieMvBeqL59EyEx6Tgh/Uq+GY7FfQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gk+1qpHyZ4s83ZZBJVcM4Z7rUgWtGoep5hf+hF1fyPOGlBCcIWOzX7cTfu9JP4Xe/yIYkp4il+nnz7qo7NMGriG1SVXAM6Tq+vtRaQ+faE9KaGGP5C/ctrCigBiD6eYE+WewGDN+uzy540OzfiO4s/To8XluiYXmD6rqcyTrdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr/E1VHQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr/E1VHQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so14702125e9.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754044619; x=1754649419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9i0C2/ArSJCIlamck5FewEJMNnRsgOmPovLP5DxZ78=;
        b=Qr/E1VHQyEbK7tDdhnCiHivf8bhrdDC7H+jVr8ZX/JH8WQdYiL87e1/yZlqB2QpOD9
         HmCjMgDFAGdScONz18M0b8sUINUJDWETERB7AIqCRrEo/4WaYh4Iw7TVFalzaLotAf4o
         pTniJVc5wisxHzlb33P6zZXBHCoTuPU+QLR6ZO6fcJlsd7yWSYZNS4bFmjwg6pl3yeFA
         Qbi3a3/lrvEXywGsHNEewLENeFmF8Xgf9r4YPxDr8xFZyKmrR8sAG4+pnBlNz0CiiOD5
         hHuHZ+bSrcreDp0RKNbtaAZyVxwHNim82wTDTNRtfcAYShBmzgl+SRzTKUk62VNZ400S
         VSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044619; x=1754649419;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9i0C2/ArSJCIlamck5FewEJMNnRsgOmPovLP5DxZ78=;
        b=DQ8fTrqZzG91v97W8njbv0+y/33NtkosHcqsx4DZbmcTRIJ1CexU/meGW7jf67VlVl
         Qu9O4UwUl9SE/jW6JnbC2NhhcZIyYnwLtLQrSuiidJ9dOO3QxcQZbBIbenHWerSh0amU
         Wb8WBxk4aZ0zC8b+ZVHU1UGYT6rKxJC0ffCVQZ/HG7ez00tYqIu5P9t82Kwb1T8FDRH/
         ShuuBgv9qX2Vqn1irMP9zqGEUXOSw5hKpxX0+xbMSFlIfEuAX6LkIvLp23897CNUELLK
         S7C0XbxE8lwQLN0esO9kQhYU4gvichOME2cR8F1pTeQ36I610FK4pbZw5Kl9VoPrJMde
         2YOw==
X-Gm-Message-State: AOJu0Yznm31+l3+ZYnqRBegaw5UG+zNd3ETcq6kM+JrDESt3xgvMME1K
	gVIvObELE/U7ZJsytQ+P4xZx5XaaXdToY51a/762enQD/E9wzQwbTISD
X-Gm-Gg: ASbGncsqP9ACpCKC7o8E+JhLnArNdaRHRH6eqWpyROFPyLgDC5FKH1LK9vRyZSPLrMX
	2snAL0KEhedYC82GL0qMficOEGcARD/AQjyAWD4BlndzZJiiGDipd7XDJIl0PvWWx0v30a4goN7
	BoLDXjSqydZM1xbSKUCoPsA29lc00eMWeFqypfhWzaquFOvMj2AWs0TVZ661b5dWKRnE0SGBUjR
	s1tTA0fe7Y6JlB3uiKt5LiuG0tSjfVd5mVMucEWi2cj0FguPztYFnWjahbTpkPylBm16S2EakeS
	MvWV2rfxIHOSX18w8WiUrINGnHLXdU+KtuYSLQCi0EDmVYzsLBJuHQ73IuA40edL3KVCyG7iLw4
	VlE3mPrbsdRXIiEvjzdUqMgSlYfGg4Utzbwjllswmls9C3T1QvfVRPhjsck6zm5DMbGTfnhKNx7
	V7
X-Google-Smtp-Source: AGHT+IGovh2vyQ/I2Kg5BGk2QDzcENMjFHmam0EBLoI3Ot2RqD+rX68t4qGH5RjJ2laKvGpOH7KQ9A==
X-Received: by 2002:a05:600c:a08e:b0:456:189e:223a with SMTP id 5b1f17b1804b1-458a222a97fmr55492305e9.10.1754044619165;
        Fri, 01 Aug 2025 03:36:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm5630270f8f.40.2025.08.01.03.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:36:58 -0700 (PDT)
Message-ID: <a9ddf6cd-28c5-4030-9e63-80df191f1397@gmail.com>
Date: Fri, 1 Aug 2025 11:36:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] breaking-changes: deprecate support for
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <xmqq7bznog2o.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7bznog2o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2025 04:50, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Changes since V1:
>>   - Rebased onto a merge of 'ps/config-wo-the-repository' and 'master'
> 
> OK.  I needed the following merge-fix to make this merge work.
> 
> diff --git w/environment.c c/environment.c
> index ae1427bb9e..a0ac5934b3 100644
> --- w/environment.c
> +++ c/environment.c
> @@ -461,9 +461,11 @@ static int git_default_core_config(const char *var, const char *value,
>   	    !strcmp(var, "core.commentstring")) {
>   		if (!value)
>   			return config_error_nonbool(var);
> -		else if (!strcasecmp(value, "auto"))
> +		else if (!strcasecmp(value, "auto")) {
>   			auto_comment_line_char = 1;
> -		else if (value[0]) {
> +			FREE_AND_NULL(comment_line_str_to_free);
> +			comment_line_str = "#";
> +		} else if (value[0]) {
>   			if (strchr(value, '\n'))
>   				return error(_("%s cannot contain newline"), var);
>   			comment_line_str = value;
> 
> I guess I used to carry an equivalent as a recurrent merge-fix for
> your topic branch, but rolling it into the base of the series is
> certainly safer (i.e. we have to do a merge and resolve conflicts
> just once, and after that we won't even touch it---as opposed to
> keep recreating the same conflict and resolving every time we merge
> your topic via rerere & merge-fix mechanism).

I was hoping that rebasing on master would eliminate the need for a fix 
as 'ac/auto-comment-char-fix' is now in master but in the meantime 
'ps/config-wo-the-repository' came along and moved code from config.c to 
environment.c without those changes. I'd assumed you already had a 
similar fixup when merging 'ps/config-wo-the-repository' into seen.

Thanks

Phillip

