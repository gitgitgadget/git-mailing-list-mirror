Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A52F4300
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679482; cv=none; b=rfNKFFNVcffvljqkoP/kvbCISau0FG/jOY8W7HDFqcWR+PXGh7Ud/3ZTAEaA9pihyWW4rGfI096TCRpfM1IuWErhIShAdvw19576IaQ6P590ogtHGUbkYcr0MkwDXqbopOqN71VOqwbVms8bG33GaSDEtFZw6fMi7KdYwVtJaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679482; c=relaxed/simple;
	bh=S2wjqjXkLxLqOr+QvRvnQ2qNijYmM/6idL7A+WgWH88=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c7t8u/lnM6C25poj/2yCFs4usHpnWspl0XqAjg9eYAQCdyQv0MM935qt/D88ZuRYK1gx4ZUfvPJZA3hjUPXFDtLIRARb5nWdNa96dtCUctX4VpaMtr8RZ2wyuib1OJVTdY34Ftw+8wuKM2Avut0/cMpKJTwrQ6ecY43bs4Gmwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeS7yjtB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeS7yjtB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so23862655e9.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752679479; x=1753284279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MrM/DvEXZzv50AWFzMgNJPcrq7Dy6Ayybm2GfEgt2M=;
        b=PeS7yjtBl3I2JchnJu/IVxgJNP2jbgHnhBoPuAzZI2Z9Oy9sQl4FFpXWtG5zhY9M6H
         hmUhpfMdt3T5BEc+HG6NmxBzi8IP/l1EY0W1USU9bdqLmMGYjYQti1dhjklPO/QQYVGc
         rEYo6nHIdCjlqqK298BZaN9UHbmrC3oX2kzuZAVIWqirCWKItMEV8haIAhOOgeFCNrL8
         1grWYz7HFN+cDgHTTqrPrZcY1AcyPY0zO7eB16PL969MxGG/qiKQsEKkWTbZou7+fidv
         qoYorguuphxGq9q/PUhCT2p73HkfLE+Yq+UOFsAdqJ4MQfebbp+uAmklJiyL20fZ4mPI
         +epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679479; x=1753284279;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MrM/DvEXZzv50AWFzMgNJPcrq7Dy6Ayybm2GfEgt2M=;
        b=EEmn6Lbvakb64qsL43eMI3Yhv5GbIViycfYHg0MggCHMLdKKWsrhcEbHj+xTlC7rG1
         AAf04uh/VCYjf+6FzzpwUXRRSO5t6t+GUaFLch+ZHE8WF5wk5eaODKtomIt5X15LpNIE
         n63N3cSb+Q2mNRnmqiYCqrX3GsfjwWgiKM/GjV12jcf/edI0t+dzzwx0R3oIblwZf/+m
         3tza5tn8fQ6T3fxKbgjVpFMJ+l41XzTuNQUgnZvcgOn7ZGWGTA4oUgIaTbnS/Qu0EtSl
         +CZe4x+pzoZVbcpgsYXa47Yv9Vn6Sus70hBjRqou42sfDsVlKLhZiOG9Xg8oZHmEStuG
         43qw==
X-Forwarded-Encrypted: i=1; AJvYcCUOs4R94kwgn8kuHx1IjalqC3F9B12dYJ1YwCp0fYp1UZiwEJyTuXY8NuhY2vcWM+YSb5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxxE1/xbli3gXx3Hse9gZBpZuRBNjeewhTPoBJy4wAlKmZm8K
	4KX+FIRMPs2dZp6uBWnNU1PcAPj8sbwss7UKXvM4g3ozqDbsON7KoyCQzr6TtQ==
X-Gm-Gg: ASbGncvH5ysuUZlAwxV7n09KjwzhVWVMosWhC8IUIxTIAb5ecjKhT625+M9ItnS5og0
	ziEzmdAWNzQCbW5NB9gPG5mZRkyNWpFV8y5YDlboU7VIgEA9/NeZzfj6b+i7P0++MIMcbZ9Tnen
	1XJOfR8uCpXTGcLrPE00wXtTruBpJhDa9ueQi+vrNVZeUUVv/tJbIM/W/FWzEgonRfsxIUUPfQw
	ibdJ/16ieIkQ87tFBug1/qLoG+wW7pLmor2rNSjTYfwhNVeJh8Yibwz2j+jjAdA3F4vIbN0ZHXm
	+f+bl8w+7yUVHJhqubUjW/J85HGMq+xl0EcLFs80X7snB/Xo4ISluHL5omc2TBhQG0onCl5t69+
	usNr9XTWW27+T1TVPwrynCUFsxesOGTXdp1a3KeTE04OkfX3BNETmJsEN4mAZ9I1v5bpQnu9Ihz
	eA
X-Google-Smtp-Source: AGHT+IG+EYJbhjQ3gsPY6SqLkOZkTAOiQVXGnZM+GEl4OWChpEOcPiCV4dw2XxnTz3Ib3B4RbUDufg==
X-Received: by 2002:a05:600c:4e8a:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-4562e2a5c56mr30650885e9.32.1752679478546;
        Wed, 16 Jul 2025 08:24:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm18385223f8f.90.2025.07.16.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:24:38 -0700 (PDT)
Message-ID: <b16c6f79-c021-4068-9c95-09625ca058c7@gmail.com>
Date: Wed, 16 Jul 2025 16:24:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
 <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
 <xmqq1pqhgnby.fsf@gitster.g>
 <CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
 <xmqqcya1f2vr.fsf@gitster.g>
 <CAE7as+YxajFO0FfMe2wYpT9okYQoevZAghDD29d7E0P82-A_Hw@mail.gmail.com>
 <xmqq1pqgduvo.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq1pqgduvo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 16:21, Junio C Hamano wrote:
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
> 
>> Yeah, Phillip should actually get the primary credit for this patch
>> and Suggested-by does not do enough justice.
>> I will send a new version right away.
> 
> Thanks.  Don't forget to ask him to sign-off.

Here it is

Signed-off-by: <Phillip Wood phillip.wood@dunelm.org.uk>

