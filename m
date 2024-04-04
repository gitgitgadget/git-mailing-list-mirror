Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FE82C63
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258577; cv=none; b=fPGixbLRG7WUMsMqUvRQHXbTsaJNCgyaCpyNIacMyaWYzleDoJx/qXXfE6Ww1wtJ3AQFUS6PeM8d2AsNJpU5MHiPw5Hc7omSKN/vDrBneKK8wrNctxb2dV7RSGAJIa3zBr93VIuReUdxuuZzngmnKollqhT9MA1oOmLTfoj4GS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258577; c=relaxed/simple;
	bh=QVPxmOrlyKBk0SbD5u4vrC45bAxvqgvtV9ywN6Y546g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aor6dvXvAdqIyIHpKcSzeMpL81smiVYLGbS5MkEuUdwginIHKyjzWy6zOkyi3xN7tZ+0CHpSWwBP0LdVcpbGd9pHhh/I3CenGFDQxRqn0B6tCw0HExQwQ8r6eBVPphAx9dWfPr4bXS2pwUzBFsMx5xVvEiN2Bk/1aa75cHPX4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCSl8PFu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCSl8PFu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-415584360c0so10176085e9.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712258574; x=1712863374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5kMHAvWcm080BFgDQ7CPshjvQJVaXDhAPzphfpQk11Q=;
        b=cCSl8PFuY8y8juWOPZu7ZcY5lfF2nvU2SuGSyVSHPuXLuZC5SKIsZ7h5Qp6pEqM3K7
         to9DEjUtpevbLWnFen1g2fZ+a8o4+q9LYkgZfEnT4EjUCYLkg6lWrnUo7JgyuhwDhSEB
         jsAyu4zqfsZf3ATyyVvdy8IFlZBk7+ykTw6n1Y/wUCN6xirU0ihhNnkKevmyurUV2asW
         UbRL/z55Zu+jTcO+vDSnwRkYOA6Xe7OSzwyNKFKDM4T3H5rWik3OSJ2uh8l8t2wEw/Qy
         uc0L3JjS0gbP68Lic2CpPvpHOiDnb8UXpkn5iktS4vkggniB8hsCJ9P+xuYbUJ9aCuRY
         +heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258574; x=1712863374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kMHAvWcm080BFgDQ7CPshjvQJVaXDhAPzphfpQk11Q=;
        b=v60xlMuqG/WbBvb6+PDtfSRLS2HkDjSapAE2gROG5HCI0KqAfNcEEtknAqEPsTAyYh
         YOvllbfsqeuOQwWoTDk5R603+/31hBz5D0V2BfftbcSeQ2v4tASc3g+1giEJu3ijfCUg
         qGGBbqc88GKdGW9QeqyVOaRNCkq6ABpMKkXO56Ames1EmL+PxnVWx4jClfXGs/nU2edi
         mtcDmyx4rLj1aHq9NvmxPuTyHgp3eIfxSDtukrXzandJuWQkwELHcSsOoi2deb42b5jh
         P01yox1BPAKNyeAirA4hbC0oaBn3r7ZtSPITuZu0ltDwsXHNHCt9NaD1qQnNA52av37h
         808Q==
X-Gm-Message-State: AOJu0YzIg5nYIKwoXzydv7GmekjtyN+8PYxC35hNgkv6WLjQLqat701B
	Cfz70ve4dm80lBR2JPQZtc3sEbwQ9kKa1Cna5LQf8+CqPUbcp796
X-Google-Smtp-Source: AGHT+IEYmaIX5YO1pmPd2QVAEw+fkebyR25gzM5DBseg1Be4F5sxfB2nUCeIaXB856wRax45ZJbMlA==
X-Received: by 2002:a05:600c:3388:b0:415:6aee:2986 with SMTP id o8-20020a05600c338800b004156aee2986mr2695293wmp.12.1712258573745;
        Thu, 04 Apr 2024 12:22:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b004156b689edfsm165847wmq.33.2024.04.04.12.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:22:53 -0700 (PDT)
Message-ID: <54b91c03-5170-493a-8c0c-def2ac1f804a@gmail.com>
Date: Thu, 4 Apr 2024 20:22:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor signoff opt in run_git_commit
To: Junio C Hamano <gitster@pobox.com>,
 David Bimmler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, David Bimmler <david.bimmler@isovalent.com>
References: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
 <xmqqzfu914jc.fsf@gitster.g> <xmqqr0fl13gh.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqr0fl13gh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 17:45, Junio C Hamano wrote:
> 	git show -s --format=%B HEAD >actual &&
> 	test_cmp expect actual
> 
> may be a good replacement.

we have test_commit_message to do that these days.

Best Wishes

Phillip

> But having said that, and then after having looked at the existing
> tests in the file, I see that it is littered with the same "do not
> run git on the upstream of the pipe" violation.  So let's not worry
> about this one.  The whole t3428 script needs to be cleaned up after
> the dust settles.
> 
> Thanks.
> 
