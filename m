Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA27867F
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872045; cv=none; b=tfB+rI9FBNTnUvlrp+do8jUWWczeSxxtzmvzV5A7xkUBlfto7oe75lvNe/L+0p59yqS42qqw81YAk+9NqBN4ahCSevu1GZreP0mH3iBRmYDjxlJns0jGRwt7u7QJuEgka4niKLxQujxFn+6EmwSNmjN/jIuCqQ9JW8z+ECvSaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872045; c=relaxed/simple;
	bh=fg0kRIj4FLYM4iKg0Wz/vYpLILup83fhDLN8m0cb2OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEU1IsS6r6RH++r2btm4ac5E/DPKFT4vH/xMNWMaMupe3CIYRHrFrcN75fEZOnvfbx2YmNYug89pECSZuTa20wPsgUlIiUPEEJdK9BSISe1E68Aolnhp+19Sfa17TxNOJZLceiVXO88Vh0EXxbn4tSV0p5AZLZ4hL7jsZQm5o/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4nDjOUd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4nDjOUd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fcb6ebe24so492605e9.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 03:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706872040; x=1707476840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NcM+B6ynvB2d4+w+E2um+teTKkZBaDzxDWeqtf1u4lA=;
        b=d4nDjOUdfM/fqcn9cF2NdqQWm1sYaFzYxVHDmhzbuMs2dk1BwR358966im7NKrdc8E
         gKx7KFkjrnx+gzw3GpPInfFK6NXaFm/2OalHVh1AG9ezQXLbL5V/ccZcUBlk8Q6kiadB
         mT2taFYDbbjkHQIaIAjLNnF4Yx99I0h+Dd9w8bMWB+Wl+2HZCXSAxWx59nP6yzCjTgQ9
         fPf3RoJ8xQX18bHOOv/wU/aSdN/ICZntaeIWQOJyW6kHbkwOB/IbbDslB32AtClPFFcI
         j//hs7jctLIPzK9AXUnGcaesuIVSAaDIQesQLdnvMthcpmLPuzQuS9Lkcw8AjA4da9CH
         N+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872040; x=1707476840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcM+B6ynvB2d4+w+E2um+teTKkZBaDzxDWeqtf1u4lA=;
        b=oXaaKvaMd/9+ZTwe4EZHsF9tMj9Yiq8qGvX5hL7FnY9UIeyXwnHyQzhFliRgR7GhGu
         e+7EtqF7+rMi/6YRAmOqSiVivhmAS1Kfn/aDm5ALr7P6JdiIb2e21KnglYoxefjA8TD9
         RXnHkbtFdgBXrh8nwd0SViZ/aUF5GTWQeLtT53Ex2FukbufGAaHiWl8qPrfLATM8svo0
         0dkTWPbbVipdwdeoF8lk8xrKuLAHzAFPKhcPIEYX68pAfDqxW5CdZ/V13WvJJ36G8NLn
         VleCaAzn73L2UO/WvZsTJBSogEs5TtCYkykZLZHS1PV9SlFUn9XwRcIwW51lCvMfV9OG
         invg==
X-Gm-Message-State: AOJu0YymHOvittBqj1sSwZbbA78f7emYOYbR8cx6eR2IqVHdhOeyhQ5c
	YXWCQPARljIWgqwwVT0wgqMy/gPWRjxes3fqNfC8fZDVmdv7s8neapa6gJeW
X-Google-Smtp-Source: AGHT+IGErxLIKvnj/VssreyxlCtgMK5mu5AjwwLGYMQEf6iOAzjCHACM5+eRSJHzDkgRiTo4NN1ghg==
X-Received: by 2002:a05:600c:1390:b0:40e:fb8f:debe with SMTP id u16-20020a05600c139000b0040efb8fdebemr5911657wmf.38.1706872039663;
        Fri, 02 Feb 2024 03:07:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOaVsnTX2R/FW1vEhxEIqkpRSl8pygScuCneJl5teMEpU8kj2RKz6zwmkHVcG73P+K/ie1MIOrSShBGm6NYGx73kURWbg/WCwy9qn/UGsNhZgp52zXY106
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z2-20020a05600c0a0200b0040f0219c371sm2325541wmp.19.2024.02.02.03.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:07:19 -0800 (PST)
Message-ID: <6b34d999-3da2-42ef-bfff-37c8f592347f@gmail.com>
Date: Fri, 2 Feb 2024 11:07:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Hans Meiser <brille1@hotmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, git@vger.kernel.org
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/02/2024 19:00, Dragan Simic wrote:
> On 2024-02-01 19:36, Hans Meiser wrote:
> Please keep in mind that editing the git man pages requires very
> intimate knowledge of the related git source code.  Many times even
> small changes to the language style can change the meaning and diverge
> the man pages from the source code, making the man pages useless.

While there are some aspects of the documentation that require a 
familiarity with the source I don't think that is true in general. If 
someone has a suggestion to improve part of the documentation that they 
found hard to understand we should be encouraging them to contribute a 
patch. There is no doubt that there are places where our documentation 
could be improved and it is not necessary to be a C programmer to 
contribute improvements to it.

Best Wishes

Phillip

