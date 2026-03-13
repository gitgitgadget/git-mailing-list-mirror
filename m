Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D43328FA
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398004; cv=none; b=M4IUseBPW8tbPsaAlNOIuqPULXiTd5uLH0LvvcslbdvAb33EC0ZkznQNeXDMhqQ0sUd4KXJXL1PadS8D2gAK1ajXlf6/l5GQTd3Yy24cgzbiPLumsrPvUry20SJKxWD/SqhQiA8a9thZLXRX2mT1nZj2i6jNMIXlnHrYz+wATj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398004; c=relaxed/simple;
	bh=bRD7YL/617kgD9JoRdpMfUMNgwoQd3gWSEy1hj8D5Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJCmYBctMchDYDUT8gsc0Fcc3IZJqJm22Hlci4bKv0gewlRlZqxYJ/1iphdD07IRfmYAFX0fIXA3LHS3xnl5jb5eQxEsSzkvzg33TGYhaCPCwh1H4QtISVcbrOvWRm8XnwkTmjSlW+Ydee0seidcR2qWLnsrJKjIkXJPTIfOaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzh8cdwp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzh8cdwp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439bcec8613so1610782f8f.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398002; x=1774002802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UKwBXYUozwN3o3QZCqrp8YYjGNQYV0qHY5sAJ7aOdY8=;
        b=gzh8cdwpyS4swoH7xHolrids0N5zqxFuvM8/9k3sAMlSjCxkAJn3x0eFhpcLNnN5X7
         +jGilntCQyuXr2W7F/MzQp+fEp8QXYSgwZiy+kGmESozvI9TYZF/fQ/+MeOvUMk7wWta
         amk1f/qb6BYs1aC2f4lA1jD2DH2fVKe7B/gYZcz2L+6qvDXlyM/Oip5fx/HFMpxly19c
         P3S053cDraV0ruPobO9nl8R/YRE7V0Ux3e1az5SN11+N4wU5/asxDX0D7Qdi3xdw8sEP
         VIaMctXOjwEwFiJsevvhkmmV8vkjSdigVoqKqMSrOJ/n+kTdYhyN2Ct13J2dWhPTSC3k
         NpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398002; x=1774002802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKwBXYUozwN3o3QZCqrp8YYjGNQYV0qHY5sAJ7aOdY8=;
        b=XKDQoxih7tVXpKEhKuU+rDDb8PcJ7y/se1CHWHkiMH0YX7ghBOtBq5Chc37YmbiJuO
         NOjHSKPPGTW6dUk1OG5g3opE4eQ4dugBRdh551kIi5F9tkz+KFwL1YZTdk+ABI9mIPbj
         n5K4vQDidfQy8OnJKwysbZwNzzWsjaa2KAdxwbrqKuEYhL4RPNpIllodz/YZTfBK9NS+
         2zg2F6wz2UF6o/gPlTOifJWyOieimJ7eHIT36mrpE51PsD/0jWvHp3V2wk86F62fSAD4
         KQAtaurd6D5rYLN+PbkhvOLiKJg3xtlVMbz6HhHzUvD+hw5xcXybrZVbBBPv4GfjMl2p
         unyA==
X-Gm-Message-State: AOJu0YxLXkzWjdmkmdsG3iommKIuMSAWwwqSAItbpqetFl/JbfpqS3/p
	KIb1ynzxtydkj69vsFABfvuKLLu9tByGNSS6sQBIiOeF7BMDK9Bo4mo7i0+/kQ==
X-Gm-Gg: ATEYQzy/6S47Po9SnzQVnAQXAz7cdq/aPH+1l2tzaf72e6AZesLphkKP0I1VJY3vWJ4
	LdHThXJg1VIY6I3Yu6+L7OPDzwndehAP7Fv0IqqmYNxbMPqToS8Xl3OWcLhMqQ3s+GVgbRriy7g
	2VVzNmqrcJq4e6K0bIXhXy7OVB3isMdWGJ+3wdTggtvcRiyYWdlEWhjAhn+t7FlUQ+31lea6aBH
	jlk53+80slebd5ONQsWrHijbK7Fbwy7FTs7wCDj4NSfHvYdn3d021SDe3yzW6uRRKcbsXvo3kmU
	GcVe89Vq6kHObav+hgv1TNgTq1+bxmkf8Ml2rbSSBTfHp7aBCJrYwDwRfB+8cQwXEHgWp8PuKeI
	7Hpy9i18woKVtyF7XVsQl/Q057oQxKzoxfYWZ51A3sgxsTPaqg7Bc3QjIjibPOgWj+jpUSho+LC
	nuUohdkzu6UJNDlA7OlP7A/zlYoScJUepY21TxUH2r2T+V2UpTqJksSq+mRDVqJ0dDJELEnvg4B
	3UNsQ==
X-Received: by 2002:a05:6000:2dc2:b0:439:b1d8:608f with SMTP id ffacd0b85a97d-43a04dc25c3mr5433110f8f.46.1773398001576;
        Fri, 13 Mar 2026 03:33:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm18132202f8f.25.2026.03.13.03.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:33:20 -0700 (PDT)
Message-ID: <2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com>
Date: Fri, 13 Mar 2026 10:33:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com> <abJbir7NocxmBuAo@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <abJbir7NocxmBuAo@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2026 06:22, Patrick Steinhardt wrote:
> On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
>>
>> I notice the reftable sources don't seem to include "git-compat-util.h", do
>> they need special handling here as well?
> 
> I don't see a strong reason to do so. The reason why we need to be
> careful with "compat/" is that we redefine a bunch of standard symbols
> there, and that requires us to play a couple of tricks with preprocessor
> macros (see e.g. "compat/fopen.c").
> 
> We don't do anything like that in the reftable library, and we already
> include "compat/posix.h". So in practice, it shouldn't have much of a
> consueqence if we start to include "git-compat-util.h" implicitly over
> there.

It does mean we're using different includes when compiling with 
pre-compiled headers compared to compiling without them though which 
means contributors using per-compiled headers could accidentally depend 
on functions that are not included when compiling without them. Wasn't 
the idea behind "compat/posix.h" to avoid including "git-compat-util.h" 
in the reftable code? The commit message for 75a044f748f 
(git-compat-util.h: split out POSIX-emulating bits, 2025-02-18) says

     This intermixing is a bit of a problem for the reftable library as
     we don't want to recreate the POSIX-like interface there. But
     neither do we want to pull in the Git-specific functionality, as it
     is otherwise quite easy to start depending on the Git codebase
     again.

We could precompile "compat/posix.h" for the code that does not want 
"git-compat-util.h"

Thanks

Phillip

> But if it ever does we can treat it the same as the compat library.
> 
> Patrick
> 

