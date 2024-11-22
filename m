Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B61DF969
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302613; cv=none; b=Httg0sYtZoI9SLeNf2j0zIdndC9gNc4BFDrcECV8f8YpYVPH5nmCfolDZqpMEYWOylGIOIVk9WOaiqiU1T+bTbZyZZZYVanNxZz/b2+0dlvMXE/yJ0ehXByaVNscLd4vcYWZN+kCaH/lXfvqgC1B55pLWRIw33vBCZhwikzZPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302613; c=relaxed/simple;
	bh=k0NitY/uqrQ1LmQISVRdbV3vnRTV0IMcFV3N+j7CkOc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NT0MuA5K6q4R/0/YDJXZ4rBBa7iIyRVQntTnJEmlOxxgwvvNK35G91OK5ytzuxay4MJnpt9CUrgCqwishngTrBa5j5NhLK5/zEv4dzYQzJCaJ8KdqaCPxX47PjFWahRRPZ/D7KsfoFB7cYeNu27x7yeXTe2DaQxoZ3/yj2RA5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Deo7h4Rz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Deo7h4Rz"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b14df8f821so178818185a.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302610; x=1732907410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSsyAAc162GIiLuy1VVkDZ/MOpxFrFUnuaR8FT/2cz8=;
        b=Deo7h4Rze4dV/5dsGXt9+wJBahtcSX5WvBbG3KDTSvQ5imVQzwo9pqzCto/GuKmYJw
         Gvar3LLCsNWpenWQsxnHXvO8EMinKxi5ge+Kv53ZSss+uwe34Y4g4T5UCLJxwEkxq95c
         O1gIp48tXTO+B1xK+cuOYehpJd8C/9oGjW9QRaHgt2U88Ovr3qe3e/Z7s2vaRlRKF8Cv
         BkFCu/RLlIql2DEZWCifT9MiznqZ1dEMHGX9rEZR+E1bjuJfoa/XLx0sx1qGOtfgBMeG
         m9HSVvaDRUMjGj3Yhw1LmXK6h+PDfN96DcJtO30vqEhV8ZZ5fIx0l2W4NWZEh3XWA/k9
         0QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302610; x=1732907410;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSsyAAc162GIiLuy1VVkDZ/MOpxFrFUnuaR8FT/2cz8=;
        b=oxAcesP+Sn0d+c6OiaAvq1BEy8slcPmMU4E0glKpo6bqvjwUzd55AzvQwgqPTFkVHY
         s6eSKzbvWhp4lfy3kV7pRLPhfMDNZ2f0hDSKgV78tHGTTXA5eeiHwq6kTSSNZCcWV1qm
         4R4ssOI6AFx0eYiq+tzbJ9v6aYkanpQl6N0iSyFHD9QzDpWkVzTyo0Qjb6LGjQdKZFCL
         FvxYrCi9TBwx10Nhvqr4Q9Nw7Lloe3jCFV+N5y2y+itu2f6u0FqF6VP8oGGGSxfVLUn+
         Apq+F0dKB6OZz0EfQMex3uM7Jny+SBVXzFwsFXrs3PCQA+e/kDj1ymUjATfOfAxJOlhI
         uQAg==
X-Forwarded-Encrypted: i=1; AJvYcCXYM+IytZshKxuSt3lLnBcj4zpOxHf3MKfMqeeafVFj6UDvJwxIFPsjUiY4mwl8qlx63KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1yxNRv+nmZZXwbYott3M0xW4d9hcaRzsUiJ/q10ixLomRAYl
	rU+wuFQWPKmxme3ezpIJ2RR8W+oKZS95hoWOMC4ATetaYsJh/t6Q7eA+Iw==
X-Gm-Gg: ASbGncvW7nhNa/FQxg8/dTE6xhNg8btQMx2ACGbcAzGFTKteIMol6RsKVMiQlbB0Bn4
	wzu0tzJaehS2yXXFXxZCqhSR0JZEwA/jaoH/6BcW7/uVFx25MyhFnFCqZmpfPCQX+mLY6EAVYBD
	s3+kwWsfFYb9zq4EUQi/vKqWgmBbW2inF/DyuSEzwIH/SsIFL9CW3otBE/xPZv4/qNPcPOsycXd
	uOB3zDQDmg4nlQf/5FKKTL5DqJqCjuApzDTu78XeLmwVtT+JgfBHGrHYcrKXDhRJ/ChlxJfFXmM
	OjkYiVmjFpN3UqPlhuYvfSGboW8f+AiQZhWAWh3Mt56HKXUIHg==
X-Google-Smtp-Source: AGHT+IHLNCfGWOQXW0CDiL2YXUA+B1bTrc0YVYpD+I+UxBc1yAK36iZvHVR/70F6aVsZmZPG9TTPjQ==
X-Received: by 2002:a05:6214:ca4:b0:6d3:6859:c070 with SMTP id 6a1803df08f44-6d450e7e267mr65923916d6.5.1732302610194;
        Fri, 22 Nov 2024 11:10:10 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:40f8:689a:b10f:19f5:4246? ([2606:6d00:15:40f8:689a:b10f:19f5:4246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b49f54sm13080756d6.104.2024.11.22.11.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:10:09 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2024, #08; Fri, 22)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy11bshme.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <558f7192-6dd6-8434-c07a-921e2e55754a@gmail.com>
Date: Fri, 22 Nov 2024 14:10:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqy11bshme.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-11-22 à 05:11, Junio C Hamano a écrit :

> 
> * pb/mergetool-errors (2024-11-13) 5 commits
>  - git-difftool--helper.sh: exit upon initialize_merge_tool errors
>  - git-mergetool--lib.sh: add error message for unknown tool variant
>  - git-mergetool--lib.sh: add error message in 'setup_user_tool'
>  - git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
>  - completion: complete '--tool-help' in 'git mergetool'
> 
>  End-user experience of "git mergetool" when the command errors out
>  has been improved.
> 
>  Will merge to 'next'?
>  source: <pull.1827.git.1731459128.gitgitgadget@gmail.com>

I'll send a v2 with some enhancements you suggested, so maybe wait a bit.

Thanks,
Philippe.
