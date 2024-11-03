Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A415A8
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641749; cv=none; b=crCB/zGvLKB1x0pcZojmibOCRDKyyZdo60fZdLEf9ec4QA7boMQwGYXnLBpVJArpop25AYBTb9Oi1iolOF/Q20TPqpXCm9aUqPEfxYV+jmmTpq6CQ2s1SIRQFjEeYybEsZCrJoIYCREkwtatpZY2nOzNB9J/ocnyDd6Ckyk0Ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641749; c=relaxed/simple;
	bh=qo+tMNhCqOVmol+zv+b+T37WYa3mhQzSvgA5P/aVxhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QamWrGCIMcnvwD2ZbXkYmkdG/+9Bgb0VN0Mti++PCj7xBQNoC7dTaM5yv3aQo/Wr61psSDHh98NJMHWgtVuC48w6PMPaKxoVkEew5/aRjzxhVTRUJTzDo5XICpEPX7519gzBP3xnBzSkFDKOg+j2l7vnQ3R1Mp5MuCB/+9PEsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiDWeTRY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiDWeTRY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431ac30d379so27322375e9.1
        for <git@vger.kernel.org>; Sun, 03 Nov 2024 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730641746; x=1731246546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3pya/w1u4ybDFRg4CBx4WSqPhCifzF9gzr4ngU19To=;
        b=PiDWeTRYIiJRoRunJoP2UDhmTpwGVd7Bah9XmHFy0rRkzvFyYTLVKl76Hez1REu751
         6KKXAk+URC4MnWiJdrO9pTB17l+CxUsvINNJRepVyg6DeF7/RnXtNZUoY5ldO7UsBmSY
         AfaTovEtdeG1a8qUZW29JuSjg7s5Nhag7sveAqvZVoiZWp9OWBsXzX4PGHbUeYRC/ZvY
         9tSJAumom8byHoZ9uow6wUzLkuuq6tJJp5Lv0HBZO+w2/uPfTYmkw5alHRk7fxLau6NX
         1HImiM+vMblXKKmu8dxX6m5k8rebUFiOt58VtpudwlboaVSJPPmxwbtPDNqLZJwh93e2
         Dwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730641746; x=1731246546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3pya/w1u4ybDFRg4CBx4WSqPhCifzF9gzr4ngU19To=;
        b=VL7DwSU6NYIlLngRYW+n6NFm/V2Q+nMqi3qcxnzjipeItMdNtiNAPPri4hUrbtmDB5
         Jx/Jb/GJAkeSGEQNz6UA5xMw//7FrcN7MWqK7N/erSa+z7e+Af96DgDlBjpcUKn4cMnr
         eZPMUjoJBIIvR77Upzkld5Hw43kUTEHrXbf7wvkFfeca42Hb197szLiqJYz20Sr8M3Nt
         E7hCYjmMqi2FjZuhCO/T5uMfUxC3lw9+xeJNi0QUYARMwneAlimpXIgasVYeOH9W+zgJ
         eZP6zmg6m5hd8VFNA/FjAulcN3OmrWFqHk0htgQ8ZnBwqXS64JuWLs9abAFjIc6CaRW7
         6nMg==
X-Forwarded-Encrypted: i=1; AJvYcCWrkxXNPyyZiYjBqBmiJBCzVmFgOGhB08xaCKSnrs/YaQC1azH2i/0JiCWNiDUiXpYMG1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01M3DhGdVrXeNb8kcHX0dWOG0PM1BE54Upkyr1qhOvRajri45
	9oOg/ex4RE65ybukhbWUkWd8d0HxHKELHmrTuX3DCSCMvQ6aCqBP
X-Google-Smtp-Source: AGHT+IEouyKTkTmPyd3+Cj77e6UXxIDnr8wDW/ZMTHrYR0SO4XF/eqpUqPwYe5jplN43go7I3CFctA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr228052925e9.17.1730641746002;
        Sun, 03 Nov 2024 05:49:06 -0800 (PST)
Received: from void.void ([141.226.12.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b11esm10638455f8f.104.2024.11.03.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 05:49:05 -0800 (PST)
Date: Sun, 3 Nov 2024 15:49:02 +0200
From: Andrew Kreimer <algonell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t1016: clean up style
Message-ID: <Zyd_ToxE-KVYSwHl@void.void>
References: <20241102165534.17112-1-algonell@gmail.com>
 <2a385fcd-7cb2-4d6c-8372-2139f11c85a8@app.fastmail.com>
 <xmqqikt5xckk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikt5xckk.fsf@gitster.g>

On Sat, Nov 02, 2024 at 07:42:35PM -0700, Junio C Hamano wrote:
> Good eyes.  I suspect that it is from a separate topic, and this
> patch is supposed to be preliminary clean-up for this change, or
> something?

I did all of the clean ups again from scratch, the resulting patch
files are almost the same.

By eyeballig the instaweb, it seems that the chunks are interleaved
far apart, and not side by side as usual.

Will send v2 anyway with improved message body and an extra line to
be removed, thank you both.
