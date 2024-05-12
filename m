Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B15DDA0
	for <git@vger.kernel.org>; Sun, 12 May 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715497515; cv=none; b=tdmbD9CViqinZ+4FAh/eJrDo/quikCykGwnQdcegg9jP6LIc/jG1rx5lui52jDrNgufo08xJ23GZqQt04rhxOqg64QFeBD7GKAO5R+b8R7ewYquyDFRaav7qwvz7WQJNg7CDxgFNKXfLVLwn3xJ6MhJ82vsE715zUHMGvAfMuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715497515; c=relaxed/simple;
	bh=uQxiLDW1MKRmYCVtXkXfRluHItiAy122QP/JtFEvdJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAoFriQwjj7ZOkmwGEAy0rT6BXg9Ac0ASeuAC5wbBsSe+K0PKOjEs8ujFHRjGARHy/U6gXNc25FaUm2BpakjM+IHYMePu+IlaWtlKhxsfXhsmjfRlmfxwZ2HoVlIi5OPiRQEG+4ARceryfHBML2VS8hVoxWwgQd4gF0vItTy59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=PHMOefIa; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="PHMOefIa"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f05341128so252170185a.0
        for <git@vger.kernel.org>; Sun, 12 May 2024 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715497513; x=1716102313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQxiLDW1MKRmYCVtXkXfRluHItiAy122QP/JtFEvdJc=;
        b=PHMOefIawotuMy4V/uyDMhyi02h6MfSGKa2me0ynMrBEZAcI5fczLoaxGLskIu3ykt
         zohgAHVZ858A5h5TotbPDxc4ZzIbNFkMGBWD4+W9qhnxgCwUp5WGIuQEjYKtvZ6fq5nu
         uAY5E6LMLisqkX6D+aLiu5ia8EwfsvrHH6NmQs122zgcnBH6lU5c/97F7zv52Q8czaGG
         UcLVnhkglG//PzBGu9tzRbqgcUIVYzm8bg1W9GV+p5DsFVQifey2EoZBdnZkSl1AHdh/
         UXDsednv3xMp169DsI2zC9kP7P781wQsY32tvZd45rNQihcpXQ9rAdrBOSSp4d0ffHuI
         hfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715497513; x=1716102313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQxiLDW1MKRmYCVtXkXfRluHItiAy122QP/JtFEvdJc=;
        b=OGiCSo742buKqTepxNamgL0rewDfXFLTK5WwgzZqiEo/pOz4o7A06hJMFU/FXWR+2w
         Coa56pRo0UfmfgoHvro319KjUXzdO2tgtlyhqR7IlOggMZ9Rw6x+HidvS1g3D4F6+Vb9
         qB5Y/zXQv8vkDv9MN1uLrAMLs8S4gakoeNywWc37g3g2j9n3MLegJbsvwUeH0U42kG1l
         z1nsa3NEIHaEC+V2XoKXlmru3oSOb3VU3xo1tRlKv2DvCPZvdowgeK0vB6EBDgERfqqi
         0K6l5xMgE48CS48qzqH2Vdp8AEGmAka/ejAkglYsTo9ILEGVsEE3caZGrT361PT+nfDj
         Fq+A==
X-Forwarded-Encrypted: i=1; AJvYcCW42aXkeLYP4TKN+kJfKOqOoG74lWOFV5r0vWdvnPC+CSgjDt1ry5KOGfslJhr9fIp//klmH8u1Wxx9OoLtwfjzhfHM
X-Gm-Message-State: AOJu0Yx+PpOgZeYUT3qHCZSYo77KT91al+t3IfAInHn3EaJwChwNdlZ2
	I20ufmwyxuOeUmHmk0x4IrSqE0Z15cX6h8lHy6NoYV6LZPbLf9hnyD1+7QmsdBwOBsX0I6LasWQ
	B8F7pAxRLT5zzhSmcObecw/DsjiCEVopU3TnlYtc4F9JqnvE7GYS0JTXGU9s9Uc3OZDQOewGY/F
	JdG2DcbysCVOPDj8iNh9JDKE2VTbZBc90QZJ2l2RNn1GSAKVjDSiOy9s9mQs7M3dOS3ajyK6kkd
	XceJA0O8QTz3iU7etjAn4aMz18jCRr4NfnBvePzwEtp4rTCWwgTWaGdwXjIL16faqx+8EFIwPGo
	zVNnHFJNpkw=
X-Google-Smtp-Source: AGHT+IH151FKh0r1njvqcMy3AYsGvpd82/aSIYMgpoEvwqD3/G7PQAF6Bg8yNyQbRrN35KSyN4GpjV6Ebatf2z4jV7g=
X-Received: by 2002:a05:6214:5bc2:b0:6a0:b6a9:39b0 with SMTP id
 6a1803df08f44-6a168242d87mr94931706d6.59.1715497512606; Sun, 12 May 2024
 00:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com> <1f57718abff1d0e234c4145e833424da7be79311.1715428542.git.gitgitgadget@gmail.com>
 <xmqqmsovisc5.fsf@gitster.g>
In-Reply-To: <xmqqmsovisc5.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sun, 12 May 2024 16:05:01 +0900
Message-ID: <CAOTNsDyw7xZT+KuE7=ExKk7wARJxAM2xQpv1dMGt+CfUr97pyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] osxkeychain: state[] seen=1 to skip unnecessary
 store operations
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Bo Anderson <mail@boanderson.me>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Thank you. I'll clean up the whole patch and its description after
getting a final reply about exlock.

Koji Nakamaru
