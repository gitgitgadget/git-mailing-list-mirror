Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9341A919
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065718; cv=none; b=OwgPYwfgk/VZjtNeSMkh/AY8zboPWHLAwlSZ5HeZVc4z5lUAII9kRUKVI/Uz6RRPukpomAI7c2HbTnnh0sRhOBfrwOmNCYrcV8JxrxxPbyi1xwsRqbklD7SR3AaJ1keSgFnuChlsHENgQPh/EtPZMIssgEBtOCNw9RX23+hMXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065718; c=relaxed/simple;
	bh=yDpiBjadCSIpTUVlWg8kNAjIHrKVdgsHOGJ9L0Ut3b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tzwRMpj2C5y7seZgjpZOPaJ82PcXwAHrlalJkCGKmsXinZxFkMZb9Q3UGAqs6QXrIgL3/aGDCASD/EGPgTknuB+rJI3inXLWwNB4UrtXgWHRe76dFxvmAUxYtGFT8B+Nfr3rFild2eT9c2PAwJB4g7YW9lSqSP80t2iY3nTk3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+LA9zlV; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+LA9zlV"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso3156357a12.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065717; x=1790670517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWg9k3/nsF7kVsdSfVZvxS2iN6q/9YOEABT+ozyAddc=;
        b=T+LA9zlV3BC0FRYUK9Wa7qzj2if3JpWyibSoCrP/kiPRnipXLNPS0WRHaV7YmSUIY/
         dgYYlXnOjW97ENumRxbJJFf9LpCLojtXs+jwUuYA3z6WBAzZUAdp+TLoh3YAc8G2y71h
         XnHsSFlOWzUXawStf3OyowoHmeyTBvg5AtU8Jg6ShUyZU7c5DAnc13WcFpVnnHwf1PMy
         qyaueMcLMb08xjg37n3hQ5PI3RnQrxbRO5LFauJyeIT0tZFNCaaLtxHe/JOiDuFn99fd
         SZK+z6mgQrEaHvfqpXYcs0oEk4rH2oadvNIE/S4DSC+8Dy96bkhk3IcTt4gX41ChGGed
         k1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065717; x=1790670517;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWg9k3/nsF7kVsdSfVZvxS2iN6q/9YOEABT+ozyAddc=;
        b=A315eGGHQwjCOrlykjaoctkSsIXxo4mictRjxe4pbyYDq4LDGJQYbXdXQ9GDb0vydG
         oOkv5EqyTkSyljMnD61T55AMHVNguDYVuPN1t0fiBP1oe7eQ+q/KfPKgi2Ii9GruKPMA
         uiNM5rAXsx8Ecsx0kbtEofNynF+1lk2eGlZe4AXgrkt5WxC5adDCV4wFOfUkDEkoMXx+
         w3WAoozu7a9Qorqsd4gWVVfAwYKrxEpB/ei0uA+i63ld6yYniR8YEevI1gG1Dc6c3c61
         Ti7qbZotIxdQ4RddGFstVmuz5Ui8kli0nL9QjHutD4YtgjOid7FzfCv/1qIKOI+mDpsl
         dplw==
X-Gm-Message-State: AFuF++lop4+XyuEZ/xBIW2Athl8zsMjqbFFvHlKoDgVLCY9K8FSHIPWY
	R6qTZQiCyvCYVwy4hyHOteedfPJgAED6N2nVrxmuoj6LBGz43IbmfgcO
X-Gm-Gg: AYBFou0ZzuqbNasg1DjwjznflKYz4YNyrVRIzK+RuvV0sBhPBXl402ga1ddRjWOjoG0
	1d0WttEtmLrKjWZO5fVBVUv1Li+5q7FezbyFczONSIWmX28Hg+HF+l+SljeT7W2txqHY9/FbhFd
	dLTZy/7XGu1C0e7uHH1hgkipbDdqf5fjX88ppXRgJHld9ZNWvxooQy05LN6/0lkQAcSdINGZeWv
	IoD5kWu5Sdmps2pPpL0XHx0MIN16+tv9RqquEg5qSQx6gE8SKOJtfeplCnwZLKO8sjhuzG/GJAi
	EkKSNyaH8ixYnNYKx898TjDcU9B6a30bdErTWqpaWCGij/pua1h8yhc4zCclsXvz0N5baO83l5S
	ouwEUq1zC3+Qy4AU6umLj02lg7wGIsHLadHZ28cvcRbfS/Np0aIfeZBS58jIdHdlTwvXw31FuMQ
	RLQYhDKAz2bBjXqEolfwSUcunXjd5u1RRdNF0Pe/rGO7YY7P5yIWWVG2Mde8ldOXBdMJvf2Sq+L
	L9biRK465fc0g==
X-Received: by 2002:a17:90b:39ae:b0:39e:6c68:c780 with SMTP id 98e67ed59e1d1-3a0732650a6mr456369a91.54.1790065716714;
        Tue, 22 Sep 2026 01:28:36 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e672b5b30sm958143eec.24.2026.09.22.01.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 01:28:36 -0700 (PDT)
Message-ID: <7da4b657-b6f3-4ee9-a49a-459b77088f55@gmail.com>
Date: Tue, 22 Sep 2026 13:58:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [offtopic] GitHub CI webpage caching is horrible...
To: Junio C Hamano <gitster@pobox.com>
References: <xmqqo6dvp230.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqo6dvp230.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 10:50, Junio C Hamano wrote:
> I usually keep the URL
> 
>    https://github.com/git/git/actions/workflows/main.yml?query=event%3Apush+actor%3Agitster
> 
> open in one of my browser tabs, but this request interacts badly
> with the web cache they use.  Depending on the phase of the moon, I
> get a stale cached page whose latest entry is from early August!
> 
> As a workaround, I could append '&nonce=$random_number' to the end
> of the URL, but I should not have to do that.
> 

It might be worth putting a word here: 
https://help.github.com/support/contact

With Taylor moving on from GitHub, I'm not quite sure who if this would 
relayed to GitHub by someone. So, the GitHub support page is a better 
place to complain so that they'll hopefully fix it some day :-)

-- 
Sivaraam

