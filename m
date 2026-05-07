Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B83E6DFA
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183803; cv=none; b=ZvTuUHjOPPwF3R/Q9pAFYlR9JyvRopN64L3+A0MRr0tumuwiHdIsjyQ+ZQpHTYhMgu8ho1vtkJC7q1kU9Z7eqzQvJmg9d7tb+x4I6Smh7E9D9uFE1b+k3PuEXgSNpGJGJssX2tLV/zv0p4YgvUhYuxN/g/Q6Gp8PE+n28IK8jMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183803; c=relaxed/simple;
	bh=+EhK+Yc4jwp3e6GQqK+SDWFnwOouUnsD9xNIcs7OFXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKI09jXXb+kJLQEM3Hy3viE5mj3sJHYc4W7rajD1z0GeubJ7XhaWsTZapeofdpskJ3KtiGX+7BTvBdFYUcybDr46HQ2vTgVWgo2auLH7NIUlKFT2wXh/BQOJoIXpGTG+wIARFFsH3OdkYlrFcZa+BdyapHz7wgSPmxmEFJUssd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwfrEk2F; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwfrEk2F"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b74b460d77so11694546d6.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778183801; x=1778788601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I4zxEhyHgtzLQ7OvvlnDEPv38A1pInNfBKHsaieyik=;
        b=hwfrEk2FaRLkVDtVLnXRxqfwTQddPSX/Zc6CuJVLr4QhtwKwE2WpOPHY21u9wGOFsV
         OIRlpi4OooRLqYONnIO4Qt1docuRohlfJo9okiK8L2RNoQFpQLi9gmbDiDr8hVLvfbiV
         FDe8Hr0jii+RLka3Z6ufTXUHFMh9eoLgpedyhiHJ8qVBRJD1txAluzyoEzvwHTWYcupN
         fDUg1Mxjzhpwomj4kNRzJApGxG+dMVmQKPmqR1FpOqX+teW4XMWoFXlR0g6szVerZXIb
         ZIHA6ztpyHjQglTR4vTzz2OjkH5DVBz07M8QQhcfJ/qlZ36m6zZaAZh/bvUnUZ+p711q
         wvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778183801; x=1778788601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I4zxEhyHgtzLQ7OvvlnDEPv38A1pInNfBKHsaieyik=;
        b=FCiYCI7JQ8pgnmoemRu5vyx8ohz7Mp/ZrrG3D7Ae5X1GVV0MgXci3AlyDKHvtdnV0n
         G0FIR6Y9M6mW3UITQqBBpUva8LlzQt8sVIlHor1gnsgSr+hPZXmR3qkbCjcLoPzv4TQm
         5n3T1WUH+bQdkNFDsTPRzEdNOQH90jPwnvgBWSurHvJ9MVe5EsLLBUulRJS+/rEDVWhf
         7mr68iXVMAd6LzNEWjD/E6xhaW/P2hIQYyTg9fPjJ0dIc5E9xDgD+wTgB2btYiG+vKRL
         PDX/6J6wNDKT20O9BBtEvNXKk+DlGuHGeSTAVcwP+fFDWTYL/SgwmL98ZbuV5/9/JDhl
         F2nw==
X-Forwarded-Encrypted: i=1; AFNElJ/xo3a6G5ofMZcb/NGWztY1YU3cc3bZlUmNKjHXRSt/SYnwuRyrsXZTzLUiuSWQhLTFqnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMuTD6aG0lUyM0eUKZV7CubNtZMxTsMkf5w87Nt9Lgst8gcV8
	r6tOXsBF13SU3LXktzxPhy4/GGARuDyeQmwYjfZxtwN9z7v+qpCM80Cq
X-Gm-Gg: Acq92OGn7qdnNEZoQQyGB21jajNnlB1MxHwogZiQSmIZINgEyNQ++v8sRxw5Lux6KVz
	903mbnOdOIYO3XatgJZVKNhKAzcry7Ccwxz0FPaOgVC7tjHzm4AJSJd2bXbRXKHlgiaR8UFMcaV
	RqeNo9t2sF51Orc65JIab6yVJM5FWsrGovh00cLNSDH9Z+ZK5EOzLot/W1nfy1Ttroxsd5NDBw8
	X08Od7EMVXq8r84ot7YsXPwDuNVk0l92C49AiJ5PlHYk8NpBagSTDsR+fEMPPDTpnYvBF317knu
	BTwesVPIncpYR/pm+6a5GLlReHA4V4Sr9c9i4bK+oyUrSzFyY4CF0NcDpXBtr1hGsRN/fE/AJD6
	eUtNjyoegQI/1EBpU8wkEq/mylAITqTvATtHgsk/bFl3uPkHrqGgiuG4G8R1mcoqpYEqmAyfkTd
	UZPTUNaY49c49/3uK+LaEKwZ2yI1XPIPaW3xb86b1Sc3E9rJNVn0id7WiUoDuy3lxPZ8qjFQ==
X-Received: by 2002:a0c:e08a:0:b0:8ac:aa89:6bbc with SMTP id 6a1803df08f44-8bc4259256emr135687906d6.16.1778183800693;
        Thu, 07 May 2026 12:56:40 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd827c5sm251888976d6.40.2026.05.07.12.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 12:56:40 -0700 (PDT)
Message-ID: <39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
Date: Thu, 7 May 2026 15:56:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: add caveat about turning off commit-graph
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <V2_caveat_commit-graph.68b@msgid.xyz>
 <V3_caveat_commit-graph.6b6@msgid.xyz>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <V3_caveat_commit-graph.6b6@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/2026 3:42 PM, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>

> Range-diff against v2:
> 1:  82faa72f7bf ! 1:  fb5ba74ea3e doc: add caveat about turning off commit-graph
>     @@ Commit message
>          But this isn’t mentioned in the user-facing doc. Let’s mention it on
>          git-replace(1) and git-commit-graph(1).
>      
>     +    Acked-by: Derrick Stolee <stolee@gmail.com>
>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      
>       ## Documentation/git-commit-graph.adoc ##
In general, you don't need to do this. Junio will add these
during his application of the series, if necessary.

Thanks,
-Stolee

