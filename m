Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349F1B532F
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473582; cv=none; b=QaaB2S5IpbWhoPI8J/e2Rtloli5KUesQIWQmRCK+zFfb0PT6FxBwY+H3h/cRzSKSn2m6VLcR+Qk9XIiz6y18y6CVbEHLR87QVxRnSyyKEruEuFNK4xzDDYS92beBNx6dSbyoNMootIl6tmtUcsZCmktZxGxtSpXbWioArJT6f28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473582; c=relaxed/simple;
	bh=osT8Gjf9+tZY85H9OUZgXysfXmIAg+If1VVO/geqo68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9DYI4fAgANPLhPO63/iGaWX4cApzMqFFV5okY1VIGUd/luc34t/m5Zf2jUwS2F2VbDW3rhpZXCILdNxRR7QVfT2jsj63KBWbhtTCIRLB0zXE8q4Yq4thBBNSlZQSJ1/vaw87C51Lq+5fyhVktAr6WakJ3G8K+wduy7Y8lkltAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzKKeWtq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzKKeWtq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234e48b736aso4287085ad.3
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748473581; x=1749078381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SwFWrGbGCmKFLd6hEAuMKgj/0YT07B5oRzLmVF17EM=;
        b=fzKKeWtqYmSee/BrSyx+ZLB7Zv1Dl+/OJ67gL5Xc2Z3J6tNHDtZ5Z/iAQuIHr/rAML
         CIYER5cKEquLNulRUloVS6iT9W2e8eZYQVlXCHyPUIhzd5mhi1oLOKNyiEUGtZOerHPo
         8pdiBXUiwwtMfYAbA3X94FOWFG6t0yuLTN3OXNxLAxHJsjzAnHJ+i2bly1orOxTbEtsn
         nu/HxeHKMwSdcxKv96Pl3HGOJ98TialarMsJtcw/qXGhEgYHwG0Wm0GhNH60ShShtXt/
         Td2kSAzsy5/T+tlaYyADQ0it+YEi4avUG8qiMyES77YZLgqvoDKbHmc+d3J61pvAn7C1
         U5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473581; x=1749078381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SwFWrGbGCmKFLd6hEAuMKgj/0YT07B5oRzLmVF17EM=;
        b=VjVblUTINbO0qEB7B2gBUksyAvK1ZpIiRE18ZpiJ4Ful6NPEz4q/Z1pK7e3KuLzp04
         3YCRWWzbK1FlvIVqZZLgssFAJ2z+84YGYekdkplws+fYRKwz59WoKHSVJT6i+kiySH6S
         ysHx8yYIodCtO5dzdMKGdOKTpMICsZBib+Buvq4Wn1w4ZCjtboPwfGU558Gf2XkxHIcI
         tyWkIEwE4kXiNosnLlYugevDxDtntXpzs6r+YtdNed8Bdn4xbgOLLHEO291ohtipJZPY
         fMY9BP1iI6xYdayWxf+QMoTkfzlnE1JOuyZh6VnK/M/GmhB6UtUHFkMOeO1VBF89TMpa
         NftQ==
X-Gm-Message-State: AOJu0YyUg8GTWx7wejAiG7HHiZUA8CG88cYi9wyBTLrLLotlqykVI0A9
	h7GN9HD/cRTVnKQbGI1bzkhCLJfqC7QM8ahIVVG2rYTuyicYFw9XbcLM
X-Gm-Gg: ASbGnctDN+JuFi6wAox8zrujj1rL2XPhcBgxCjIc+IHzxRhBMZSdvWerlAjta7KY50j
	qYXaNsumumw91CZSx1io+eWnKyrTASCYSgDhW5qmxWIrP8x0IFfam67Kvc6mRJOu3OcVqE2/M3M
	eqswcuuyksoFA3EPWMq7sCzt1tueMzY3rrOWDj0QOxA/YHGAZG8tOlD06TFTucZ3EzCYN51hi/4
	Rt/VfmRCpJpp/KPIyvsRb3UyrCoge1kaYqwFBsef1kTAmgr03bUz03z6D8rWRQVNXOoIxi71Cja
	8BsvRpQGc+ezkjBJ4tZ8wnxYO6CKYsb6aEGhJkBlzQUUy8V2Khtrl9FbNRHl2H+yixBU1JPRGEq
	y505xAgUPgTE=
X-Google-Smtp-Source: AGHT+IFOc56Y4CA1EbD7Hfnf9B+X9Ivl3Jq+BaZN1a5nOlnk9RZXecm1BJXTV6dpl/Fa5NBXknkukA==
X-Received: by 2002:a17:903:2403:b0:234:8a16:d62b with SMTP id d9443c01a7336-2348a16d6damr123400725ad.12.1748473580614;
        Wed, 28 May 2025 16:06:20 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14aeasm1051225ad.226.2025.05.28.16.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 16:06:20 -0700 (PDT)
Message-ID: <550e4935-6ae6-44d8-bde2-d61db3656830@gmail.com>
Date: Wed, 28 May 2025 16:06:19 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
To: Junio C Hamano <gitster@pobox.com>, Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
References: <1014npb$rbl$1@ciao.gmane.io> <aDXo0Enj4cQzKQkK@ubby>
 <xmqqjz60pe65.fsf@gitster.g>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <xmqqjz60pe65.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/25 3:24 PM, Junio C Hamano wrote:

> But `git commit -a` would not change, even if it won't add cruft
> with well curated .gitignore files.  That will be a terrible
> backward incompatible change for those who expect it only deals with
> the files it knows about (including the one that is not yet tracked
> but its presence is known via "git add -N").


Just to make it clear - I was only discussing adding a '-A' (capital
A) option to git commit. Its current behavior with '-a' (small a)
wouldn't change.

Jon


