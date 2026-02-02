Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768151DA62E
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046249; cv=none; b=SLA1gjLrZ+qKKJxOibWsxVTrOemwy41yFFaJk5Mk8i3NKczVysCBBZ3pVLmTIFBOwESBJiR4Enpm7/7JZcPyEpInDX+kHca4HX9vYci0qRZTZELxBn0HfCtbbGTQzBVOSVqOUd6dhzEs4/slkpj9A2d+dzORBtDAAzQZCjMoSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046249; c=relaxed/simple;
	bh=HUdFvmrHwPL5SxJOb40of6asld6/2lSzH820D3JXGQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXgdarwos2UMqP2SLwm2HyU+cTFNlAXYwLQmqnv75D7YM79t6e5k5JZks2ZLpl5pEKL17knHTowFnAkMwz4svaJNQ+c7rJI3G2kNdBekvH/qao0K+Z5nco6YyqHTaKLsAsqysVDwJTKO/Dfk17xA25Y9tJSKBCE39GdAkmk5NCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLE2y1Lo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLE2y1Lo"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-386714da2a2so7869861fa.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770046243; x=1770651043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUdFvmrHwPL5SxJOb40of6asld6/2lSzH820D3JXGQ4=;
        b=ZLE2y1LoXSxoGjm7ZpHq03TeHrPR9AOck8E2imhj3NXuJuip42D0KWuqiYwMAB6R0B
         06WKkvkpLWqJDLmgsSPtCuzkzE/7HOn3xPaUhzHaBBvqk5D1zariWu4/mUTxDMZxMgCx
         rQfQTdvt0MjeRa09a/1iuohFBU7VqcqYHV/fFph+Dft9aLAZHgOodpmDatL30XedgFGq
         T5oLCUMCF8rIrUkqMOBLpwlnkznZt3JgcHTuwPMm+xKWU/HUPsl2r/KdTLPhqna7bJwC
         sPN87WxOI/7vIr/MUyC/Z8nhuqVa9LYDOhzp5jk88LWSzAnfV7xbEXaElr3EScUxPzhb
         r4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046243; x=1770651043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUdFvmrHwPL5SxJOb40of6asld6/2lSzH820D3JXGQ4=;
        b=E7o4Org957URVIgXNqa3GwEnyHKOA3E7eFmNKg1wft0GLo+l8bZs83Snih8GGHvhrh
         Q3Ys7gIjdNjpD9qjgRb/VX2lGDk5N3QeiW3r83i/gwMPuZNXA/PHPLNTlSZRBeqUyH17
         TMftvJONC+p2ya4TbH9fptKNW5IWHs5qT5cuqEZyxkvhhrRgYS3w17qJ3vPF4rZVhZBY
         PfTvzsI52CubivkbVK6kUrB29E59nXk9/3RPRtiBkqT84h2LMUTv9+4Z5pkX0hUnS5Yr
         BDp/sTHirhj6ivyu/FU4c1QRxFaVYhDbgYmlVyCB1vyvBOA9amVU/1DcpLRCXdjWFa5I
         lwVg==
X-Gm-Message-State: AOJu0Yy+x+IEeC9Z1TwN1jzvdDwIyAbu0UK0oaZut/STeFffvwODqRw4
	6XoW4FIYUo8PhMscz7Dk3JiC/mO/udeZC60Ue06lRFFwabpjIf47zRe1xbGt1w==
X-Gm-Gg: AZuq6aJu7w525sHggL+HHFn/1HinT8h+H/4q4+HpaYULVXkiSX5jGpHn3/Uq8ew0SuP
	RHSiUcEsiJ3ZyFGaejuKy0XRNR3WnQo5slwoKqkdLlynDdPLniG0TlFkcWLqMKn0F7OHyUIuvwH
	JpzK+jilioiQY2sefDSq2nN4VEJsaXtO9GZZSxpp53ghDaarsARh7qprUC2t3hLdJoqYBOkOU/y
	ubEYpNvPQ904U+ukp0ZvKAual1CYIuy9/YHgSutWdTd4JTVKah3Gri+KaZWBx3kiqhPI25ZuuFZ
	v8VmSDNZJ7jbnlElCvdAcDbqL/qaM8r3vwjr8YezNoHN1w+J/lkWqowfSQ4zr00JGAA7S36M4Ys
	C5eWIaHYODo20Mt3i5yvGRUVpyKgj4N7dxNTTU2Dh01wxOQKDthw5B3fV4RR7MfzyDhM554M2ar
	todsqjSaiIc+mzTn879aSxcQ9fex938UyiFxBWajQzuKXpW9ADpqSQMJ56dfBm71R/EI8ImzZlo
	H1o
X-Received: by 2002:a2e:ac12:0:b0:372:628b:5cb4 with SMTP id 38308e7fff4ca-386467224aamr42305011fa.45.1770046242582;
        Mon, 02 Feb 2026 07:30:42 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fd37a2sm34299481fa.50.2026.02.02.07.30.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 07:30:42 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon,  2 Feb 2026 16:30:41 +0100
Message-ID: <20260202153041.2939-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqjywv2une.fsf@gitster.g>
References: <xmqqjywv2une.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> So the @{default} we originally discussed was not something that is
> "relevant for each repo", and where refs/remotes/origin/HEAD points
> at has a better chance of closer to the relevant name?

This is a communication error on my side again, my goal was always to have
someting that is relevant for every repo.


Harald
