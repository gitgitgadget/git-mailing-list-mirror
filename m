Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92200267B86
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486520; cv=none; b=ntwX02f8DaOLlDGJLQosEWM498T6oDkjnXaQLt+94T3FDVtXgy6QslJ+iOwBMHG2XyNjx3cMLLgynBmHB3Hl+ht8DCLkpdk31stEkordKyfyMVAD2CTa4Z7XSh9xcsA9Vij68GYHD29tByAHcnIhZYlF4WLx91QREgTJBxqamCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486520; c=relaxed/simple;
	bh=Y98Ikb0ZjI3CwHBoiSuldyniNl6TVIxaXL6sz4y5a6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MRuWMRLHGjJ3DucPzQcxfqvr3gui26aWJp3ktRJkAE9n20laggCEbKIcVpdeHyJuipgmHcr4oxWlU5SLMq+TuW8Tlz+UFUO/4N4lx+w0DPBrEmB4pDnrL4/TOjnG2vN2N6qeoTnDFaXRBBHpXZz6GfCaKO5NufAtzLWCzIS9N+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=Zrz6hAg7; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="Zrz6hAg7"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38f73e6ed7fso1974902f8f.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1740486515; x=1741091315; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVbDFTgerYdJ9zavV5+DyrAvH+QaiMBhmMRGRcfJEao=;
        b=Zrz6hAg7A4q6XFyK06J7SydjhbMzrs9DpRigObCVRpFmBLQNw+KKKlnTtEVnTgsYeF
         Bj9HGNfpfsukmOcscgy38YBZlHSMX5XnFHlC7Z4qAzfv52+YD4L0GhyhDCxaWKKkEucx
         HDbWFJtLDFDuG/eskdyEnyDVNFmXxGJRg0Jm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486515; x=1741091315;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVbDFTgerYdJ9zavV5+DyrAvH+QaiMBhmMRGRcfJEao=;
        b=GydBtkYcKv5dVMA8JBcK1qn91Tq/nyrt3bLY7bzmntB7Nf3x8xCOwEno+OTDOmkRC3
         xJMa7WC5fZ2jUIcPyKhp3Co9ncBpljv83Zy7WvZhaPzwB+hlJYqNV1G5Y3BozeeXsXnZ
         XLrM8Gte2LykWUKN1YkI93X2NpfnZaudtyF/wRuuiillC/Fy83zmt9nzZjRvCqa2iGlD
         Dvb4Bmu0tZtaAjIR+RdxdEVNdHyAvOKEojLX+P42cKLLPInbyhYdtwyntN/Gzu09o5Mj
         zdRsgqWSLFV5bmewizvLJSyXGcagnLN/81hhNrHLJ/uxKpmcuM4YLojBKfZkfpOTHCsC
         v8/Q==
X-Gm-Message-State: AOJu0YyxOfB96xd9HZiIqfUzs7NYvME/60sXnOHB09eCfzIWxS3QUOa+
	DC7911pXLfuuUiT4QOTjROyXZWLo00yQlZ2NX86/NHNY1seO7DTY3Q3ulAaRjg==
X-Gm-Gg: ASbGncvvuzRaW7jcnBzj3hlAfB25jb8nbiswYo+OzM60oJKx0r0CgxhvaRhEtBdDXN7
	PqhjBTQzp3Oi4JKqVukZdaVw8naVsRZJLmON306c55KshWIHv+vwLqaz5IvCIp09JnXxVwAzh43
	bcO544jBUbSoscc1W0D5mNRVfTLfq7XxKDIvj6bI1j8v9nX2Yi3VF1sbseShZQwvZTSEVLrKgFY
	ZZE/1HJf3GKoYxlF87g0ufRgkpIlT3EwNrweriCJQVt6axdQVIiTU2GZugLPc5/K+avstRErT2v
	XOvc4oGHmOFGok+98YDVXccbzv0NC0hy9xXCE2KBm4KyR4GlOe0z9vHzY/W+vGPX1uBqKRv7MKP
	QrdLPfnuIlmOBnqsA2H8TNevleobqUfXv9Wsu
X-Google-Smtp-Source: AGHT+IFhPi+SKEGizA6Edql8Bx4MzzqGXfhjIH2sk+2p8fWrAQJWNw3DkX/ZwzxEqG45qw42UhW0rw==
X-Received: by 2002:a5d:64ec:0:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f6e74f38amr12618985f8f.8.1740486514671;
        Tue, 25 Feb 2025 04:28:34 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2126480f8f.22.2025.02.25.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:28:34 -0800 (PST)
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 51PCSX58034512
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 12:28:33 GMT
Received: from localhost (mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) with ESMTP id 51PCSW1p034509;
	Tue, 25 Feb 2025 12:28:32 GMT
X-Authentication-Warning: froglet.home.mavit.org.uk: mavit owned process doing -bs
Date: Tue, 25 Feb 2025 12:28:32 +0000 (GMT)
From: Peter Oliver <p.d.oliver@mavit.org.uk>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fix Meson Perl version check
In-Reply-To: <xmqq8qq3kqyk.fsf@gitster.g>
Message-ID: <ac54ce2d-a00d-4e9d-2c79-fa6b8de4aba4@mavit.org.uk>
References: <Z5c4OzzHWOo30Hu6@pks.im> <20250218153043.63535-1-git@mavit.org.uk> <xmqq8qq3kqyk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811584-680861954-1740486513=:4342"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-680861954-1740486513=:4342
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 18 Feb 2025, Junio C Hamano wrote:

> I wasn't involved in the review of the previous rounds (so it was a
> bit of surprise for me to be listed on the To: line)

Apologies if that wasn’t the correct process.  I am not a regular contributor, and was trying to follow the process described at https://git-scm.com/docs/SubmittingPatches#_choosing_your_reviewers, “After the list reached a consensus…”.

-- 
Peter Oliver
---1463811584-680861954-1740486513=:4342--
