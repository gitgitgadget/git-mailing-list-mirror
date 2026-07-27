Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B863BBFB1
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134583; cv=none; b=s9cJ2oialY11mixKfQ/erSq2HDJGZc+KS9YEGFLsg6P6rukH1SKLGOuYlKazNLrwEP/R6N2mkXMfxNHjBaS9c0+5HFir1ggdhQEDMxpYbhuUvol04wpVbsZkHHoahenBTGbxUvoHTxxE8k/aSqT09bQ7wRad0pUc4BSdjqQ9psU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134583; c=relaxed/simple;
	bh=PJg9hpQmSPokIUfzBWk5FgWhZfgjWU9UTVw4hPlMH8A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UENJZjV1/5gUnB+oegJjNYHY+dVVY2e/ExFILSQpLpDexmgQcbPI12IjDqVZwfCGhiJeS1q5kZ5q8/ZfHK71do6M1i6PjfWZ3VS8makrp4kpQIYY3ONQTsgYT+p0J/OicuhCwIF8tkX0DL5S3SNJ+shU6Vf7k2QYgeO7W6tVOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pr7Ak7eL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr7Ak7eL"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486672f03cso2250729b3a.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785134581; x=1785739381; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4hHdAa80g9Z2gU2Ep3IRB2/TYXn8mmyU/q3NtJknpLw=;
        b=pr7Ak7eLY/ZZtTeYq47AB7QuMMlQUBuumY4vezn3ZJI2kThsNRULNUeP9d0THlxC5m
         YMDgQtcmqwpQSQBsxMUNYr5Um4f6r+VOZTGAWmgRKK1TFsMD7DMHWRI/gi5rUHvEITq7
         Cgn04JLc+kAy6L1rr9KvcM7XyUJmo8VNfmdqP2hVUGoTtX5QrjQudLMLYPBjhRM7P7lv
         qYFSM1NVe3b5V3Ri8Vtdq/Kmi0lK80bsO9BC+rSjdyAJqINB04wni8I036+hXsBn0SWH
         H5Q9zdb4ZDEbX1xounrQ6Z6UitT6J5XYtmPTkhmepA9oyaUF43iQtbS08H1lJGhPelN2
         PFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785134581; x=1785739381;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hHdAa80g9Z2gU2Ep3IRB2/TYXn8mmyU/q3NtJknpLw=;
        b=rtTS1rP9o3dXWhemQ5r4NgF1CaKERo4pT44EBVGSxFi26wCZbMXIvZC6pQjqAkOdIh
         XKJcuWVOKLlVok/2qeiinafcIseJeQQlI2fkgQgm6V8ubyhj0uRwy6vGHJq07P9eimw/
         /u0mFlaZ0kLO1B543bl/t/ObfTXlBVA4WtfqwlB4E3ceuQTJ23hp5lLGnOOhX/I6gTVm
         sIphT7Df8wajumDFFEfFvUl8DTF9miNY9lOHMzKMoNq61RhIpkXaydaRaFxaT36b54pK
         vbCS69UY3X4yNHAtN1bHE/Soj6k1cep4wSiF7CEji452RdwLv8PreQLjn1hcEtROeX32
         wseQ==
X-Gm-Message-State: AOJu0Yz0erv3V/RDqMlO7miL/YCnHR8upSvzP8DHAQDAzRu12L3dk0gY
	jUMnjZmNrHtzIZMc4iQZjkS4mrRIjx2dtFEwwVaZHz3nCKB1kdwNVADz
X-Gm-Gg: AR+sD11lPXuNJZS2cGlfoW8dU028FvGYH7kCp1myY9YOYJTacHNxp7QV56z7IqV/y3f
	2GpwFy3zQDgGtAWm7ZZdtXbPkMevnwtaBFW4stbRYvCAoVVOlRJOMNpDE/OfqQ3e62I2gVMo2zG
	Rx/Lp3cvgrlG4gq/14cFl5NsBvztggMNKjkswYsRm3R+mWe4gKVTTKHe2RJ//GQ4wDGFDinnfzY
	9oE30YchpSTTToXL2DFYhzstjjr1UZNaX5Ymdp2xoLBkQR13tmpj+3Nu0KBivEmuWlZ76DMl/6P
	kywJKY9GQG4OhhqbvRhGniKDOeAgwdSYT67fvZn91E1aCJTOJxSlzg8RX8+OJ9w2L3qg3c9mdOV
	PeBEU+cITQ6pIilAO0HwYsinXOoGt19qeTebKT3MSFMujyjVyz+ALwfFbHmQUEKsWShXlEJ+/j4
	E=
X-Received: by 2002:a05:6a21:6196:b0:3c3:69d0:c57c with SMTP id adf61e73a8af0-3c67ddbe0cdmr7689076637.32.1785134580992;
        Sun, 26 Jul 2026 23:43:00 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc415eafsm28524214eec.7.2026.07.26.23.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 23:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 12:12:55 +0530
Message-Id: <DK95E6MN2LYU.3P2KB11V2SAS7@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>, <l.s.r@web.de>, <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2] utf8: use size_t for string width methods and callee
 sites.
From: "Hardik Kumar" <hardikxk@gmail.com>
X-Mailer: aerc 0.21.0
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
 <20260726195718.1914131-1-hardikxk@gmail.com> <xmqqpl09s3cc.fsf@gitster.g>
 <xmqqbjbtqdv4.fsf@gitster.g>
In-Reply-To: <xmqqbjbtqdv4.fsf@gitster.g>

On Mon Jul 27, 2026 at 9:32 AM IST, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Quite honestly, I have to say that this topic has a very low
> expected benefit in practice, while it costs us quite a lot by
> having to carefully code and even more carefully review.  If we have
> to endure so many new bugs in the callers just to clear an existing
> TODO, we might be better off not doing so and relying on the "safe
> cast from size_t down to int that barfs if the quantity does not fit
> in an int" protection.

I agree that while this might not net something significant and yes
going through this is difficult but, many places it would much rather
make sense having an unsigned int as mostly its rare that we would be
dealing with negatives except in a few cases which you highlighted
before and others I got when reworking.

I would like to send up a patch with some better changes done. I had
previously not built and tested with warnings enabled apologies for
that I assumed the defaults to enable them without explicit args.

Thanks,
Hardik
