Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CB139578
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134389; cv=none; b=VN0iYei1eclHlgV8QB0zLMb27TqrqO10CGWEBJVZCGDwhknZnteXbHaRbkLRGVw1oQVe9kRGjatev1dNnYNrDofqYAQCyNkb2QziAzysit0wcp/3MPiMOepbaK5Fps2lpwWCuTUOnA/DTe24mrAVXpi/tbnzJziGbGNqXa5Llkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134389; c=relaxed/simple;
	bh=ira0rpLaSHli+86PEs0DrUV1GuKyVFywaoNGEpEOyj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JBEfDIcOzqqgaMTXkvMqUjfwk7W4A7mW22Ppw+V6ON/eEXK7XH6B5PuCdp8RGs+Cn2D9q+uiEWqeXYZwXdf//qM+ABkzEKCxRiNsIovrSGzbWYhvQxcSYwIz749pDUztEpIQ98yOU7hJz9/NMyfj0LMneiAnaWdGTf5PipofyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDTU/WJY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDTU/WJY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so38580315e9.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728134386; x=1728739186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dAsy1gC3A6cRcwT6zjwDSlR1PzGJUdizHwyGyWgq0vM=;
        b=WDTU/WJY/qqyx7Kgyb7EnXtlixtdoZSFcGJVEevhVI63N1NCEiYa387MtiRd1MNy91
         f1qYKiKXYhIbqoLbNAg/cXN2wLJBskWeyUxGaDjiwRjdqDEV31DhQ7CFvgtffDll7zdC
         rMgwFMlcJACX4WTxTql7rTTYTLtRp1zhV3RpRpoM1DjW4P9QTQY0ddzIa6vPyZ6cJ0IS
         hrc6CiYBv+wTmZcnIMpMoNV7m5t+PD85Zl22ijIJAb1g+E0fxYqbZWrXrGyJ97v+crpS
         ISSRUZeDr8ECvdU9wvnfky08h6QWnw1KK9Qj+4HpznMfXkApkCS3Ff5/341WN6J8fi4O
         9BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728134386; x=1728739186;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAsy1gC3A6cRcwT6zjwDSlR1PzGJUdizHwyGyWgq0vM=;
        b=od5aECoRw+OKPO+LA22LEqpY82MmnzoJwjnYw+ip4flFGtzYBZ91R6soo3NozLRG8v
         G7HEvRSkVWf86QMoBHazduCXPIG31x1ayhi0adMHXOwdKbi7kuoRiFGf2JoA3BhBF8QP
         uYa2HfHfdxPyZBowEtvZzKUJWnK06QiDYr+Y3U1q6EBOZLx/08lu7TH95NaIYA1JrXmV
         mCY8tVn5c11Je6fU9ZmbBfBUCClPeJd2GX7O7bsOR+UqgxdgCqw7+VC92xMiFPHZ+VTK
         vL1xyX7eNoFvaBL5vlTIqgAyzX61aRh7Gztgv+C/hFTsdsKgUsxWS4tFW4NvIaEbM+/O
         uPlA==
X-Forwarded-Encrypted: i=1; AJvYcCXAF7sXkB/7/mxd99ldMxhb76DUGFh//YTM049fuUxq/zzl/JV7PHgbMyCrhEbp0rGPcWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydD2bs3f0Dp8bfEQqJW23ltfZyyIsPyySNrcv+0X5yC0LnNrcv
	L2FKSLZuloZ/bddwUv89oivo5YSsaAYBpGVatn92p4AnM2M22JnSnsSKhg==
X-Google-Smtp-Source: AGHT+IGQIU1Fg69fWttNWeCZ6q66sG2z0bHJEfUAY20pP5cSc8Am/bdD95Bb7KZYDUH14PrQI49k1Q==
X-Received: by 2002:adf:8bd4:0:b0:37c:d53a:612e with SMTP id ffacd0b85a97d-37d0e8f13b8mr5253836f8f.51.1728134386109;
        Sat, 05 Oct 2024 06:19:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b3305sm132215066b.169.2024.10.05.06.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:19:45 -0700 (PDT)
Message-ID: <1caf0bdf-6235-4cc8-a4ba-d7d92e6dae26@gmail.com>
Date: Sat, 5 Oct 2024 14:19:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Outreachy
To: Fashina Segun <fashina.segun25@gmail.com>, git@vger.kernel.org
References: <BF74FF00-C553-44E8-AFF8-F83D28422A7C@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <BF74FF00-C553-44E8-AFF8-F83D28422A7C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fashina

On 04/10/2024 17:18, Fashina Segun wrote:
> Hello team,
> 
> I'm Fashina Segun Kazeem. I'm thrilled to be working on migrating our unit tests to the Clar testing framework. Currently, I'm dedicating time to thoroughly understand the requirements and familiarize myself with the necessary resources.

Welcome to the list and thank you for your interest in this project. If 
you haven't already done so I'd recommend reading  [1] and [2], if you 
haven't already done so. They should give you some ideas for how the 
Outreachy application process is designed to work in the Git project and 
lays out the expectation of us mentors.

Do let me know in case you have any additional questions

Phillip

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/

