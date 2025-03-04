Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD761FAC4C
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130399; cv=none; b=CFlEIy4w+J5rESAVYpBPHwPWZ2G7I109/0gFyXGodtUId8ZCkR0dBMFzA7QTa923wRT2PLK0s2RWowfabUIL0XTN7iyrxvLQnpSqa3OEBjvEo02xjYc0Gti/xVU+b5DDkNiz9eO+TM0wk+Hc6XzUhrEf9tBEk1V/rbdRoMa0wsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130399; c=relaxed/simple;
	bh=CtorhJgVMl52ApDvc3YqLPmkYIeX7UF9ALpBPrbIrSI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fYmEQ7fhTW9WN5aWS6iOr1fjGPDygSrvj+4y8zL4oAbpRaaGpoh+A0oRt+qELPXvbvUbWw5o2M74lchJSPyRm9Q9gqnZ3OEM/TDqRZ1ppZZvwKpW5PUgcgLF5h3e/YWpMQ2DS/WhyFAmzIQeKx3kkbU+yHHX5KbArZp6ovJctg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSpRecOl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSpRecOl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so9882126a91.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 15:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741130398; x=1741735198; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmjS5VoZkVi7pjbxbDi0jQRRfFbouB9XII+kSQTQA6U=;
        b=GSpRecOlMpKRg3/MXsti+mXDPvV5dJALpLZhEtNEMfdn3pXmZP5Biw3V6FxSOqGYza
         rgz/WFgCO8MM9lwL3QXSa3RM5Gcxt1NOYRX9amvSN1LfnIk8E9avLWZYJ1LU8FWjfaJ0
         8afao1/04FID5kC35KgcH5pUjaiPeucxepK8ppjh63jbCd9Rhofa/UkY63uPlpgJU0sY
         uQxqb5/da4SaApRayfYxRMpF+OSO6GJUU4Rr0WnPGydi/Z91ttT//kxRcpvJDuN029Dd
         MJw54P9wHU1jB6ufC6CTGYDMTOKhGiiY6ygqZ5C8A0Y/B+p2eSsUUxCFiofNLibWqaiP
         UQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130398; x=1741735198;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmjS5VoZkVi7pjbxbDi0jQRRfFbouB9XII+kSQTQA6U=;
        b=BALfYQweNoEDhqaEBb7ZVYDaBMC2p4gkn0KEffwFxCXHI7CdUbdh5sifb/Q6QD25SB
         Hp434qjrZ5yh+9gzuMLBhn7ygaU+QrVVSsTaxs32c5lXOT4PDxmD+JQRzvouqM1a9Zom
         26loJBAAgO5S4DuIyKhNRDGRj1LVqvChT1m7HkU49DLlTvWRo6qBhv4WuT6coble9zsf
         U9kF7FQFYqP2FrCUm5F97cRx/l5zFnxbhGYHEGemInFWAHmc0lH3cIONejrg34Q+XQQ1
         T03veTpeh+QXrjr/ONFeoOmbp7/W03yUEOsgdNKALjP83PtqaH82huPDApU5jTRKzcdP
         Tnjw==
X-Gm-Message-State: AOJu0YxPkKTtweBKdlR3MP+6co/GJSRS4v7QtNjZyMizGTd8dCpoItXX
	W3zLSMiXSGgK1KdzgmdFJgsZj1AEM81TaX3M7SGx2YIJYOtQyRM2
X-Gm-Gg: ASbGncsZL0MHDgAd7ZapVETuMUWfPmzbEm3jlHq2PharIuDaTBxQLMPk6AFlv9z3jPZ
	zyAjujd1q2YUeitUaRu2Lqfk2Oig3yKjNJ6AgeXCpt/IdSk1LFxOTWODxx/I82VTohamQpaVJOw
	ExEJF3uZm7xLnw+EuLXVeJOkkT1VcuYpOrrgadc8ivLfPs97IVyv0P+/mQA+SsNq0K67ZlqsSMj
	9XP1DNi36vdBmVBnphpZaZAsEGve2/6+tUiDBQrKQQVuMRAvH12Sa8op9ken0aohet3nHitLCtX
	J/b0TfXdkNGxoS+EqexXscVFSVMKNOE0cLEzHnLvDvoPgPUPdwkovvQol6Xk/FR/4k6T1rgJdJJ
	9vcIy6alg
X-Google-Smtp-Source: AGHT+IFjdEPNlY7BFOk9Ol31mmSaIro2n//E+AYRrJu/FSgn8ACzkMCETagDFQsVdHA2/21Dnp4hOw==
X-Received: by 2002:a17:90b:3ec2:b0:2ea:356f:51b4 with SMTP id 98e67ed59e1d1-2ff497a977amr1744689a91.13.1741130397647;
        Tue, 04 Mar 2025 15:19:57 -0800 (PST)
Received: from smtpclient.apple ([2804:7f0:b77d:283:3159:a06a:78cb:36b4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea698ff95sm11679036a91.43.2025.03.04.15.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2025 15:19:57 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqfrjtt084.fsf@gitster.g>
Date: Tue, 4 Mar 2025 20:19:43 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7350D94E-39DC-4C9B-926A-3FA2A4C76687@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
 <xmqq7c55vhj8.fsf@gitster.g> <xmqqfrjtt084.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Once you stop treating [GSoC] as if it is an independent prefix,
> everything will fall into place naturally without adding anything
> extra.

So, instead of changing the behavior of format-patch, would it be
better if we changed the documentation to ask these patches to be
sent with `[GSoC PATCH]` or similar instead of `[GSoC][PATCH]`?

I mean, in
https://git.github.io/General-Microproject-Information/ :

"""
When you submit your patch, please mention that you plan to apply
for the GSoC or Outreachy. You can use "[GSoC][PATCH ...]" or 
"[Outreachy][PATCH ...]" in the subject of the emails you send for
that purpose.
"""
