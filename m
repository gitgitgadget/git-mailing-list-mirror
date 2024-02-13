Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAE2919
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842147; cv=none; b=js5mf/xrhj2Ddog/twzFBS/itqx2UBTerwyVCArMccqJa6bgWl1CmszozrXlmBTxD9e5yduW8K0JfOwAH4wGtJdM7ljgAfYsSYuHxnxUC+AEThlEhkwMuEg6/qlD9kkQNkP1Ke4r1oIDVTjPY96BlKFN56SKLghMn5m48WpFisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842147; c=relaxed/simple;
	bh=xBmfX2uF5GIH0ngs0qrPlCfyq+c3MOtgxVYuIxUPg5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DB7AjxghBZ12gF+1vFifR8LKaGX4DEPLVZD2diJG5kpIWvMfaFvAWAq1gCq7DwNpggAZ9fxbuxz5PMjVnc8PBrWTb1luqc19u3ifnu30SELk2EL71pLjoMSa5qCyP0Ur+HjMPk2D0sfhEnBOmvtigxzl68recezjbNFk4KoEags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJR2h888; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJR2h888"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-298ae8b36d1so637619a91.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707842146; x=1708446946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LlgNbNVGyiNbqdXEtVPN5Sp1lT6tJlvlYxYh0eDSFs=;
        b=LJR2h888YMLFcc6RfXqXLKv+eR6XANJ+QyasRmMsmYjTz/p0CXIFzcmlbhjU+RBDp7
         8sWlNOXvsHyNXWM2+nwDCKOGdFJ+guSnVo25lGPcZZBi1jYYwY9OgQyswsPus2Vwn2y4
         vlLSCwN6yGarLh8Q5F+tbbYogQegmcdNJ/KsIEwSL1ctoBD2uzbcJuzFtFA4Xq+qrs65
         b9jX9WMJcx/1l/3CrCBGYt4WAVF5f7RM/Ih+wWMpsV+ShD46CaXDhNG5jVvSYRjLWIrQ
         LMV8EbKUGfMrhgMWz2/E0Wy+V+gK+toxRPXH4bSuoK3+Y3fFOmma4qehu7/VtSaLVoa8
         JT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842146; x=1708446946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LlgNbNVGyiNbqdXEtVPN5Sp1lT6tJlvlYxYh0eDSFs=;
        b=WZAakKNC+250oA2wNJHIpw5ROQ9YpjdI3gvkD+Sd7toItInWlN3iHzF6ZQKLTrUtFk
         n6elJVwn9MSWfJV+BMkAfXZuzpZ2tZpDLIEIzPQ+0ul63dZHy8DS0h5BEKGhD+OFO9Z2
         Yu7TsuSBOVYDQ8IfXMByaCEDR7WNAlMQbPddbikHASzp29nmQQXz3wugQoUNLew3bXwM
         IxgEid+GxP9B/u9Cw41FDwd8qNH03lp9zZwBstgqxEmEe+Wk1nlSV0J8i8YGK3CxQ3iC
         W96tajbt1To30sNiarWRf2krlrCUiJZwC8U0UdPd217V9rr2HH2a7qGBRzINSTudbkmL
         IOqg==
X-Gm-Message-State: AOJu0YyHd7I2e1GWPJEbFYmYszKFy56LCYDj6jid+NyuuEnHRDuIP94M
	0cb/syIWg+CAJeDJoTClXOW5TFc06UB5QvRZ5B8PT76ydocremb8QjegLO6aMTg1iZ6Zjl8F8sM
	Rdw==
X-Google-Smtp-Source: AGHT+IE0a2/IU/SxTkDXPmdWo8Gx9sZQTEIwBrR/+ixe3GtVKciHsHOlys9kUWvG1dc0U/FS2CnPx+3yySk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:2e0d:b0:298:b1d6:dae with SMTP id
 sl13-20020a17090b2e0d00b00298b1d60daemr83pjb.0.1707842145690; Tue, 13 Feb
 2024 08:35:45 -0800 (PST)
Date: Tue, 13 Feb 2024 08:35:44 -0800
In-Reply-To: <xmqq34u1e22y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <f5b7ba08aa7c80a3bd5bcbf5563eac8896fe7054.1707196348.git.gitgitgadget@gmail.com>
 <xmqq34u1e22y.fsf@gitster.g>
Message-ID: <owly1q9gcof3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 10/28] format_trailer_info(): use trailer_item objects
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> This is another preparatory refactor to unify the trailer formatters.
>>
>> Make format_trailer_info() operate on trailer_item objects, not the raw
>> string array.
>>
>> This breaks t4205 and t6300. We will continue to make improvements until
>> the test suite passes again, ultimately renaming format_trailer_info()
>> to format_trailers(), at which point the unification of these formatters
>> will be complete.
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  trailer.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> I would have expected a (tentative) flip from test_expect_success to
> test_expect_failure in the affected tests, to illustrate what behaviour
> change this step introduces and why.

Somehow, such a simple idea did not cross my mind (even though I admit I
didn't like how I was breaking tests, albeit temporarily). Will update
on next reroll.

> But the huge single step in the previous round broken out into
> smaller steps like this round makes them much easier to follow.

Great, I'm doing something right for once! ;)
