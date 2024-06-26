Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658471891A3
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415266; cv=none; b=EGBnlgslRcNL+Cp9t0Ms2cAbfvJYFgtj8F7yPiB9qjM7Q54Xd2OklQScNgRtlu45XkSDdIz4kH2Im6+pq928V9ufBpUuAwsVMvyBHcLay5fda9+tWzG5lJ5O3mT1VlDXc3Qc/oO4DrKcbEIytfVwAJrKbUwQ+SM7UG6/UKV+iF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415266; c=relaxed/simple;
	bh=A/Q5L8NIWhlEFK5ud6ESZV5eEKrlXGmHjzPuNrCAhtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ/r4IZEVhjtClei4ytdzfgQWR4rz08MJUjUgDTjFXxnKF8BsIj4qkgPDgFoYyRTEjZCE5CS4LzWFqLJEuvAzEYHa906q2wm4uB9g0sc5dh7f8awyx+rfhrTaGxHBEMfoYf/UVsiG7XFVgthaHrXBYyDcOyLC+XK5SPHZy8H0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz/niM9V; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz/niM9V"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so78958641fa.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719415262; x=1720020062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/9TnA60Vdh8UZ1RFCm1ib/p9ToBYa5UkiEqE1vL8c=;
        b=Wz/niM9Vl2KFFs8Qb22GlR7Oyzx55rjqqfPLf64hngA2SzlStpQzCjAGcXJgiaYm2r
         rStFEOKWRkZZ1TPRf6QNdQUXB8dRBzIUpjD3h7MGGvy0fIPlpecTZLreX/0D0b9PsW44
         /aj+BzcTBGKEPcI2nImUt4/BaLX51APtcu0deAtqKqdEVkeq5pCNt91nLI/dF9LL75MV
         ef2of9jf0g0BlfI5jHIXkP9uQ1ai5E4lxILG1F1BrovX78LjIQZ+2OFmgtmZmZ/L1F0H
         aYaf9FPkkoVjJtYEQcLgT1OwFPfxNjWdNyJyByVTaRfQHX9vj1yQbptW0v3raJIob5NF
         29gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415262; x=1720020062;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR/9TnA60Vdh8UZ1RFCm1ib/p9ToBYa5UkiEqE1vL8c=;
        b=L7K2qP0tRpAxXD0HYNa5IaWmIq6yWRSmg5a8gZghySjEXdU9A8nyrrL+4i9JtpvV2q
         xKGjS9/kKh4Kcb/ZfnZ3ALsnJNuc+XTSf7x/JuYZKZChfgF+rajeTadxenlZdoNaGWjF
         QODKLDNmTOmPKuM13tu35/IRQq2L+dgqi/FBVaE8qGTQ0aiTgj/WA8EU8DkZK90QlhOS
         /XYzfWpr6veVBdyqNuTlO1a5KWW+Q5AFD2WjZhMGeu+If8u2tyZIXgFdPa+T2rUL0Fuk
         3Xivp9MUiSTFdaMOwrkm9cIz/GqI6WFzzZHpsUtSJwfA/2ECRtpKaDXxulioz1H4/kEy
         yMYA==
X-Forwarded-Encrypted: i=1; AJvYcCXCTvPXVEyFeblgobUW8Ejk3AZV7tlpppMP48QY/7C2NToFzdcHZXeb3j/fOhjRX4amQKgYIHIGfu4PVMhdhz2kca/r
X-Gm-Message-State: AOJu0YzYaBV8UHrTUy630myfGGiBodd4sgAXiypK9F830TlIHz3ffcRi
	TPKrdbGBb2BIUVyhuJLKoDFo7eOGqWrIKwrskKNP/HO9fZ14NSD+
X-Google-Smtp-Source: AGHT+IGe2t/DcvyIr5OBM4DgDlFIxcpFhOPL/mhp5KKQY1X7SuHnZkwreY18ZhnG7CqUq1pfJDZWcw==
X-Received: by 2002:a2e:9847:0:b0:2ec:661e:e83e with SMTP id 38308e7fff4ca-2ec661ee8fbmr45505691fa.23.1719415262329;
        Wed, 26 Jun 2024 08:21:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8250860sm28636585e9.16.2024.06.26.08.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:21:02 -0700 (PDT)
Message-ID: <dedaa590-b9bf-498f-b743-ba058cba8486@gmail.com>
Date: Wed, 26 Jun 2024 16:21:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] Darcy's "date underflow fix" topic, final reroll
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Darcy Burke <acednes@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
 "Randall S . Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20240625231248.4070257-1-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240625231248.4070257-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 26/06/2024 00:12, Junio C Hamano wrote:
> So it has been some time since we discussed this topic.  Let's clean
> up the messy "SQUASH???" patches I had to queue on top of the main
> patch to keep the CI working and make them into a preliminary patch.
> 
> The tree at the end of the series is identical to what has been
> queued in 'seen' for the past few weeks.  The only difference is
> that we first lay groundwork to skip certain time-parsing tests on
> 32-bit systems first, and then use Darcy's patch with minimum
> adjustments for 32-bit systems.

I've had a read through this verison and I don't have anything to add to 
Eric's comments.

Best Wishes

Phillip


> Darcy Burke (1):
>    date: detect underflow/overflow when parsing dates with timezone offset
> 
> Junio C Hamano (1):
>    t0006: simplify prerequisites
> 
>   date.c          | 12 +++++++++++-
>   t/t0006-date.sh | 51 +++++++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 56 insertions(+), 7 deletions(-)
> 
