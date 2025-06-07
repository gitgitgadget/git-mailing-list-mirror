Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B220F090
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289714; cv=none; b=DXoOjrnrXCIEPunsNDvMOSHeQFQi/ZjGhNJAGgRGYXFkOstICbbukXvycqwQsprMyvuxAp0u6/2gmHZxbfOgSWpBGL56NpcRsLBzGjLtjk4ePe6GV+tYxz2YVgPv9N9ng3W5IWqF692dv/RIRYEwC0/CbG8wG9fSLJ2RNAU2dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289714; c=relaxed/simple;
	bh=hIi46mgz/unqUqfB9A2eQnjC9Tev8gLdoOBDXsi8fNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qNxyCmYsNxflaZ6gPrTwH+MW4P1KkhyWnxEE15OVCtwDoyNZtOMoXSmYZqsavOw6aw7ZGaJwFT1ViALC3Wb08yDQOq5z4pwJY2wO8+guMnHdypCeYh8BL3AoaaarbK/WG33/pMUUxLujAXFGwlnEh5vDlD8BEnkrzyXTs8Dd008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfTU9+1Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfTU9+1Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d3f72391so37403995e9.3
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749289711; x=1749894511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=14lc6ZsGShcs7B6VACeOIABTeZ0Iuz4qSN+8Xaw3NMo=;
        b=GfTU9+1Q61xIvlQqwokERjso5X4JBbZek+V5AGOWxlqIePOWTHM/OEix3f6rErvoWW
         dde41z/xDn/At/1nkY60cfgMruD8i/GsWoKMW1nsElWHpQJ6ROiC+IggjkjpTp9Gv2XF
         WheLvFz872ON0dPaWCx2cBeuLck9L6B9Sf0b2oqEKDmqpPAiSh4fEgAILV/PKo+3SQ+l
         QM23IidXi1poSbRMnJSfx3MVmCcoiG3ZnFM65JeCHm5OzRMhu0cgndI5h3pFNuKG/zZF
         6ZQpJov+5/B2IkkobdX90e95aFLAMri2jPGMyWRMv624PZ0ozY44X9sGZ8kyTLeDKz6a
         mTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749289711; x=1749894511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14lc6ZsGShcs7B6VACeOIABTeZ0Iuz4qSN+8Xaw3NMo=;
        b=oiMFpzJ09A6xWTd9kyEVgx388+PdbC/mys7bzr+6NC3KkhpAF75VZ7QKql+d3J/QXt
         8SFHno3zPq5d4C4NLZTzepj15i3zBlpGpWd4gp/Jx0vWe+HlMF7Uh6epf4qlo1dukU/q
         wRGlEr9uU1AHtm/GdtU1u6lfxq9skk4dxYRMAd+X9ssx8EagYPfXUgky0iQ1qkJdD0pC
         1gi2Hx1i5hVuWV6DiFHKp5qtJQStDh6SqqqX5GmdRIcnKU9xUzJKDUGFxNZbjsQGz5bb
         EWItD5rirhFvbLBIssaIM2JgLRx+5dKuIsKUkR7rJccqQPBWJK33IjjFFsi5gbe5qOv7
         +Qpg==
X-Forwarded-Encrypted: i=1; AJvYcCV0AnRQNS5O0I42qtB7EZQf129ubWnJb2Kw1zB9ocUCce2+8F6xma7LuRfQoIE2rxlBHnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUB9hed2Dj+JZzCVez1KsItcr8PthYwxW3OdYnovE6UEmhtMP
	+mkDR/cqjIGOxXA1O/aoAb/Qa4FLx1hahsuVvxms+FSp7mPxujBAF9rl
X-Gm-Gg: ASbGncuBYBGhYStZ4oB7Pk4l3G2PYE9D9orUzvH53iDNmXb83lHx3yxXv3q8PJTCt9K
	PfOnzC9zoqn9yEa1tUNpeFS776zpmX294Qmh7CVB0oKd+32bEnNC21Z+AceqUiYfT9srfH9Wn3Z
	fgdahoMA+DVc4CwKNI85MPHWqOuA7zMzVxndFEX15VWbCqZo7k68dWJIwmMIPVuR05gxViX0+lh
	nMEvh6CGP7YN249Oyo273qVwUABMQ7qS3WfHQXwmiIBBkIftbLmebaDo3307tG2cDLq4qJ1IHPS
	pvksalsfjZxA2DPasJBTjmCUkg1iM40/NOsVs7yHz/njU+y6J2mru3WGlqpAfL/o2NlYlgm1sXJ
	/YRMc47TKqjX+kt+PJEfkxjSUjv8YTw0kojjihw==
X-Google-Smtp-Source: AGHT+IFPW2+cr/FSLJBmLBaRWqRb/QvfMWrBoOWOq+JGxhWQfOMbcGvZGtGHOa7Eie6IsVe1iY5Srw==
X-Received: by 2002:a05:6000:40d9:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-3a5318823bcmr5452199f8f.9.1749289710782;
        Sat, 07 Jun 2025 02:48:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324361ffsm4113213f8f.47.2025.06.07.02.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 02:48:30 -0700 (PDT)
Message-ID: <0d7cbeed-e3a6-4cd4-8f38-9253c5c18837@gmail.com>
Date: Sat, 7 Jun 2025 10:48:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2025, #01; Thu, 5)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtt4t69l4.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqtt4t69l4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2025 00:40, Junio C Hamano wrote:
> 
> * pw/stash-p-pathspec-fixes (2025-05-20) 2 commits
>   - stash: allow "git stash [<options>] --patch <pathspec>" to assume push
>   - stash: allow "git stash -p <pathspec>" to assume push again
> 
>   "git stash -p <pathspec>" improvements.
> 
>   Will merge to 'next'?
>   source: <cover.1747733203.git.phillip.wood@dunelm.org.uk>

I've just sent v3 as <cover.1749289514.git.phillip.wood@dunelm.org.uk> 
based on Martin's feedback

Thanks

Phillip

