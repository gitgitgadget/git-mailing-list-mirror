Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795612FB03
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811755; cv=none; b=RZPeFK24YJ9OYFyqJMOLqyXi5jgsFmUy9+QR0Y9Tqytqa73CpJ1cVbxNTlEvY/jJxwqE6aei0ncXxZfUyassb6UQMH22glSckZsb5d0+1Nrg4bPLP11xi813ePJNjDWxDWIv+brbTW9YZ0j7dtCRskB1Rt2D7zuprTFoJtZIC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811755; c=relaxed/simple;
	bh=ZVHoh9UJcAmG2JG4EgTGTCmdvjCmEES8F3OpNudofFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NOqkBUXjMzTPrX+/kqT0mDMtz76bAKxAZ0Sq3IXVbXF/EY9+H1KTS2t+8Wvx79u/7PliLIIdDazNAMe/R9Sc37KjXCdi+UsENEksmRxOVYf4TyilL1iYOcdD42oSw4O+E/giBbdGi5+g2tjdG4Jz0a32J6o7b3+QRDaCMUxbOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtR+Ui5r; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtR+Ui5r"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d7465d60b7so10082955ad.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706811753; x=1707416553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE/A1o5cTvxwrkgrJBqMxoJo2lH6ZUs3P7WKuJVlooE=;
        b=DtR+Ui5rG1CBR0GPLCXWQ3TNhgNZE8OwQ/nkydWlq3XpxBPSVXUESVzftcQOSs054J
         1YS+bF+UCRnFoijDpm7lM0xlU0jjkkrvFA6GLGynPOrv0e0lo1+fHsuncLOKPHYjwxu7
         kGeWZErXqwSsLLQ8etKhQBx2J1pLQNCdpcsO6wkZN3hLfxQaUaAaXmGItQbj2jU7OKaf
         eBKtzLcjMI7IXV0+jEQua6ii2G99sEeSlqr2nMV+ovAdtgSHv8CcFNG4DPKL4WxUJz7j
         jG0CuMlBEzJ0WQ3zPAh4r1UYyC4Tot/PSxgviQR+6RBBxhsBIc65fbb4rWlIMTlk26rQ
         /a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811753; x=1707416553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE/A1o5cTvxwrkgrJBqMxoJo2lH6ZUs3P7WKuJVlooE=;
        b=rE6+S9VYmC2RG1LXarHhh2/8/eCLI/vMdCu30/goia3yz5fkFI5SEbJv1Ft6sZuFSn
         zy9D08sx4KR1Z9aXfgljLfWfESY+4jJxKHCYExbl2LOaE4zXjTX90Nt0eWKeO53mFpvi
         Qf0ZlT/RUEbZ9/qnCa3iYmD5EJBPi1eP2kFdjOmsAEn/acS/LxPImN0i31y7rz1uFLiI
         WH6gEkDvuPm2/MZvefhmT6TO7BIxZyTI5UJJjCVyim/rUSFs7mGbSrsghOAcqvgSa12c
         er2C6aK/NtDpUGF6IxGT/mPuY/pU7vKi1yu1ztq45nFiYT3odJabh4z8fdc4v/QnvD7M
         R3/g==
X-Gm-Message-State: AOJu0YzjPzCeZlOMSN4QiJVVuJDd1l069kpXGxBR7OQEPll7neUhE9Zm
	2RyV4ToBkcU9/Y+NlaDVZUGfN3735WiXPu++cYzCJlQPbKnpj/LTIvXlJDYDPVAm+jWQYfruogC
	EUw==
X-Google-Smtp-Source: AGHT+IH5tBwcxDa7YLySV9tQm96dwK2xmd8qEJ7A7DXumAkzGuqGIlqGwpMPX1X4u/4t1t2W8vxDamKMfvs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:d4cc:b0:1d7:3a3b:c5d with SMTP id
 o12-20020a170902d4cc00b001d73a3b0c5dmr84140plg.8.1706811752863; Thu, 01 Feb
 2024 10:22:32 -0800 (PST)
Date: Thu, 01 Feb 2024 10:22:31 -0800
In-Reply-To: <xmqqjzno13ev.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <ZbqnSNPjIQW3Durz@google.com> <owly1q9x2io6.fsf@fine.c.googlers.com> <xmqqjzno13ev.fsf@gitster.g>
Message-ID: <owlysf2c11ug.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Josh Steadmon <steadmon@google.com> writes:
>>
>>> On 2024.01.31 01:22, Linus Arver via GitGitGadget wrote:
>>>> This unification will allow us to delete the format_trailer_info() and
>>>> print_tok_val() functions in the next patch. They are not deleted here
>>>> in order to keep the diff small.
>>>
>>> Needs to be removed after squashing v2 patch 4 :)
>>
>> Oops. Will update in next reroll, thanks.
>
> FWIW, by the way, having them in the same patch made it a lot easier
> to compare what the original did (with these removed functions) and
> what the updated code would do.  When a change is supposed to be a
> clean-up of an existing code without changing the behaviour, it helps
> to make the before and after versions visible in the patch.
>
> Thanks.

Ack, will try to keep that in mind.
