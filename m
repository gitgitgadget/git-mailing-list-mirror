Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC933507E
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497749; cv=none; b=qdcX66EkkB9mb11E3yivMLpU2dkf7hYEYcxn0JLCloHeeyfrlo+mn69EHUVofIKuxT3JKVIc7mXDRg7ifQU5xCJXfqfWgKnTX4FDM4Xp7p9Xu9HcAzsM7fRfplIyJ6+uhHGp4eoagRhL9qomaJbzP7HVODDA3hBacjFSLlzRv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497749; c=relaxed/simple;
	bh=+srzJCHGGvkEDvidZLEUNGJPcZukYDOMzo88Kb4gN0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgM4YkyGN7aTuVC057LKnETFjZ0SCv/5SOFx0wt9kKgMUKA7vjUOvPeffZ0Ge7ZRB7zJdf/CidTt4ow6zNR9bsQgw5Ika0vsTzffwxJo9J4sEB02Ai+CPGjSB6S8vz5Aj8TyvscKPGTIGSXHLMff2VOwqNHs5HrYRCprJIDtBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAQzuM2N; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAQzuM2N"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4807068eacbso6986365e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 02:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771497746; x=1772102546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DW2DC9RNLk9NoABQT05WnAUWQx0G/5GdpHVeVHnvAbw=;
        b=eAQzuM2NOGRZA7gdWx2si0UuOUrA70a2nVje7uIDEmT/JcXigQ3XR1fTGeGvOWupbW
         mjeL8DEoiJOe5BR63dGOW7By0hRDNk22EMbb/kN73e5wVnY2WZT4nlhu4x+wPlJiMZc5
         0Jpr9OzutevU+tfaXjtrfXSJZz/XvxpJ09dEHAPkOEwbpSprEUIxP+2hrzsRm5GcJuW6
         d4rgmEKgovWp2oUYCgRF152wlkfdcsI+8Yud4uDuxfhyWUs0+wVvbwclc/Lf67HtEJ6h
         9/sqr+47ymNcTZZhpmGkfKi7v3pn8UUqJvdveTu+7qNXITm4Dmqh3oRrucZB+tXCn2bz
         GEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497746; x=1772102546;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW2DC9RNLk9NoABQT05WnAUWQx0G/5GdpHVeVHnvAbw=;
        b=mWqbJe/LoKDcCNxuGNKD8BawjxlVY0FRdhxjqGn0PtaHOR2kyZp9rBCSxQKY2zIGIj
         qKArMKY8ft7aRifsBbu7abFt2TI8nvEzW4JFI1cbnNIeAinPre3OwPJxg5U3/qqSMBVU
         zwpPvGMkgnSTUsfMjUB/sg7+BaeooBeueqiVSdhcvPMFJnjLSj3ZamPUFJftz1H2c60i
         Digk0sqR227ohJ5q5RrcqQPqNov+mxouetQlM7rGR7JHLqH2SlzQFe2id0Onc44wunez
         vig0KE6AuuLPO66xDfvIesfloIJm+ccYODXGOtmXR65Wup0vhaxll3ASgPThkW7nCHER
         Wpmw==
X-Forwarded-Encrypted: i=1; AJvYcCVvWTGnmp99GCh80VD256DNDWaBfY3JHIxLrrI6GZ3SKjAzaUmKKLs4xuXL2V0FutYtxBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDQ55xesnHL3i0FoeXxXlGJ+kqtz9H7ejOAN/IHU3ADc7dZzH
	nLP72A2U0tz46f0/+nchnDpIfl0MscjVPTthnGlYNlhGayS/RtV7CyX3
X-Gm-Gg: AZuq6aIADhcYN7tim/Ws5N5V7v1QLxrzCjRUrDSNC2FiJigyWqU8+NmgGYiY/lPZQWf
	4tidAvB/k6ixdIi5xAGLLKgm7kqyWWyUcDwfcuXJ1DSmRTg0mov3rYaB45hIZluyUNnWAxKzKo5
	lYMV+vueQlkGFUz/wL3pBATFCadGZF67gfRllSDzlqAKw8vvK4dfwnOK/k/5IhEJh4Adqnd0tm0
	BxOt8WOd/f6lWIM136We+rZojBGAd+VDxGidVFrgOba13bKfolCsrNVA1oolWe7mWZvLsQB8ynn
	MJ7qRvRgBtCM0r1SWOTJNtQanYFBYcs8Q/BdMwiVHKOWCmJS4nFf7J+UfgPLGDr2yZqrWKcaUWL
	8EQ6kUMz5wW7JpImBMwBTw8fHOsruj4DEikcotypCZMQIT5lmqfjD5em5WABAWfbJ9ZK//HV96a
	zy0/Ym1+FQ+KEXhSF5c/LZKt6x+draM4OdoPNK1PH3Fv3gIN9azi/OTJ9GqmJV+Gm2AQHrhhAWu
	5vgfQ==
X-Received: by 2002:a05:600c:46cd:b0:480:4a90:1b00 with SMTP id 5b1f17b1804b1-48398ad71a0mr85147135e9.20.1771497746255;
        Thu, 19 Feb 2026 02:42:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839ea37b6bsm15555865e9.7.2026.02.19.02.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:42:25 -0800 (PST)
Message-ID: <0d6c5b14-1c53-4372-8395-7c7cba9fbf0b@gmail.com>
Date: Thu, 19 Feb 2026 10:42:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by
 introducing a lazy bare state
To: Ayush Jha <kumarayushjha123@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
References: <20260208062949.596-1-kumarayushjha123@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260208062949.596-1-kumarayushjha123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 08/02/2026 06:29, Ayush Jha wrote:
> This patch series is v3 of an earlier RFC that aimed to remove the
> dependency on the global `the_repository` from read_attr().
> 
> Based on feedback from Lucas Seiki Oshiro and Junio C Hamano, this
> iteration introduces a repository-scoped, lazily initialized "bare"
> state in struct repo_settings, exposed via repo_settings_get_is_bare().
> The read_attr() function is then updated to use this helper instead of
> is_bare_repository().

Doesn't the lazy initialization here suffer from the same problems that 
Junio explained in https://lore.kernel.org/xmqqpl63b2tm.fsf@gitster.g ? 
Changing config settings that are currently parsed eagerly to being 
parsed lazily opens up a whole can of worms and is best avoided. As 
Junio said Bello Olamide is exploring a different approach that avoids 
the lazy parsing.

Thanks

Phillip

> The series is split as follows:
>    1/2 repo-settings: add repo_settings_get_is_bare
>    2/2 attr: use local repository state in read_attr
> 
> Comments and suggestions are welcome.
> 
> Ayush Jha (2):
>    repo-settings: add repo_settings_get_is_bare
>    attr: use local repository state in read_attr
> 
>   attr.c          |  3 ++-
>   repo-settings.c | 12 ++++++++++++
>   repo-settings.h |  5 +++++
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 

