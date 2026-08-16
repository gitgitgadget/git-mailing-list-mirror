Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AC4B04B6
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786906195; cv=none; b=AcxFTFMpCjvjN1yOpb11l76slduoCSdzt8nPcGd6O5FcNOLF209NBkkhLf7baApoZIB/TvnHURmHyntf1LHO7keF5fSMVvB+8C7DPS9r1Kp3R66Z4/roiK9XqjUAkE+LI1pPNASDDuGUtQyh3CyXjiLAg+sJLGVkCDGkCWGugSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786906195; c=relaxed/simple;
	bh=IaKymM6Kt2Hlb3q75hZBPrdFEfnbkEgQPC9FURR+YxI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kGeVp65UNmcXqhrjDSmchNaSbQcTXBC9/yZ3Rw3L7wQOCRPWhHE6nkiQrNE5bCo26sYPrQoaaYDS/JLKeNHIQPP4d5saykOnmfTB+VbWjhSDbSf8G+s071JpxFIpCaQU4VHOHc7rHjP8Wf6XgTX2zT9dZ0e6Y50poFbsXoNs6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH4Tj6nW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH4Tj6nW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84eb992a881so1895384b3a.2
        for <git@vger.kernel.org>; Sun, 16 Aug 2026 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786906194; x=1787510994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WT8rLTFeKBR75jOqU3X4zJla3x9sp+X7GizRU2P5tzg=;
        b=UH4Tj6nWx8zg9Y0fsbIO0ZBs+FUMAZ54zuNwyl9iewJemAwPAj+y4jqY41z4W3vheJ
         M6RizZXgB51MmZTgaJwRGCCX5qrsYgjW+b3xnUVSsK4SKRcs+sdtK1PH8dmBukhMAA3B
         eEiy8j/tfxajCsBPH5Kxjp2XeGyQhA988VGu5tzChzgWRgg1ScusTB+4vDwKF0y3+HXU
         WXE4N8re4+4Gf66SrTk/Kx/pkcUhegpGj81KWqe0sGD+mk47YqlYrbgiIf21/8ErcYQ5
         IWhya+k7pXnP3OpxQiWehMwsZAOk/ZBntaWtX+ruBr+RC0vWY0SbCLbYJ/qpYewlvBs2
         NkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786906194; x=1787510994;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT8rLTFeKBR75jOqU3X4zJla3x9sp+X7GizRU2P5tzg=;
        b=SR3250GC3G3GIZF6WB/wnADGq7wCdlyLFuIbeLKAeexxvKWft0pabHS8a08fBKkOn/
         DGyykp7u2AafAY+151s/09j+86RqGGnCR05U4atqnuguFW3+Uv0X3mQecbsD0s5gljY8
         RJtzl+lYhufcmN2Z8tUXMN9xyir6ajgDad6kjzlAbzJ3wehD4SBJSq7my7Mso9XEfXE/
         2aNmg0hVhtI2D34RJGZ8faST7ASUT9z8ukQ0Hk7xR7/jDUNbLZp6H49DAlktOm4QAUBX
         GgqTed12OrkJk/PeqtWC0FPZLIgRbsrWaSiqisAyzGujkSeGWB/Ve06+Ye2ewhrA2eoC
         r1/Q==
X-Gm-Message-State: AOJu0YygTYgqpRtOybujKybfc2lU8FfwS7iL0Au1wIgGxIqozkUdhofj
	hk9+zc0esCk8TJ40jvdL8CMWMJYqDW7iV3mjoOMFq6x50oUXTA2a1Tthy94OjA==
X-Gm-Gg: AR+sD10tfcJ5KYyBHQzd7waWaMl5D5cq9n0vemHtCVoFNlxuiMGQ7E55DnhP9z6aJ6M
	OldD1jQAXPvVHhv9+3R22KY2YSCn2H84LlBWwuuGQfC4V8D9bUS91/6r8ovo5rAmNl+44aS7pVr
	noihCAMdH96Vy8yLacBDXALKL4IdDqGiwEac81Hc2dt62QwBFZlMMgd1BaKA65dVDSdX4yt7TrD
	0RwzW+0OYRBYKeENHh4vKFTfQEwNu+1sHHFxK6++T3pnNK0l/mkudHIUfE7RvmqP3RzDY6B0PcG
	l5NfWBEp5nRU+NWHNNpzVAqS4PMneAXf281kn4vUrmA/Xeox60AHyzB5vDwBvm+rdLqNzl/dn/0
	3Nh0wi01LtVnjbNoW2krbSdwQK3SDbgfHTZdLa06KoJ8a0rLsfc6WyPQWnAGJW/Qa6NAAoUyl7v
	XuAL0JqsYtvsbiY5ZGwvHVEDnCZ5y0si1CDxL6Zk1gH8DCJ+r13GD2ejAMMFuoJcxaSRRjdKYzZ
	7sXa2nCU5tDyiVOE21VO/GUKR4QebxZvMLA7vODL1Az
X-Received: by 2002:a05:6a00:2e17:b0:84f:68d6:d894 with SMTP id d2e1a72fcca58-84fde315eddmr18549297b3a.37.1786906193990;
        Sun, 16 Aug 2026 11:49:53 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:93df:ffe2:f69f:66df:2b07? ([2601:1c0:4c00:93df:ffe2:f69f:66df:2b07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d01d3a1sm1948820b3a.16.2026.08.16.11.49.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 11:49:52 -0700 (PDT)
Message-ID: <bc49c03e-5a90-480e-8bfa-ad8fb8e42db2@gmail.com>
Date: Sun, 16 Aug 2026 11:49:50 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: The Super Techie <thesupertechie1@gmail.com>
Subject: Add a git squash function?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am a developer who often squashes their commits using Git. Currently, 
the simplest way to squash is to run the following two commands:

git reset --soft HEAD~3

git commit

Where 3 is the number of commits that a user would like to squash. 
However, what if there was a command like as follows:

git squash 3

Which did the same thing? This would save quite a bit of time for 
developers. Since some projects require the DCO, an -s flag could be 
added which would add a sign-off to the squashed commit as well.

Has this been suggested before?

~thesupertechie


