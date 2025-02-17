Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF91A4F21
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782540; cv=none; b=VyusOOU4z0e96Le3+/BPUYhGnx95CinxhDipmoliRrCkNQXvNoJ1f+77eGI8NumbkAeep0Po8CycNeOffo6iJP6onKveWr1Ir/hFhYDrr2kW1y724Attq7/5mo9Nwm4eqaGFVjCVSnARiP0yON+XUlHvIEIHhHdd4iHHKCoIrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782540; c=relaxed/simple;
	bh=UHAm/6jbV5R00kaWYBYRttK6hjcGD+STN2zOx3oadR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgfTR9LlJOfjcDUMMF3N934AtxvV9iK3/0HQr3sjm7MH7BkK3N2M54Czx8e8WUjDSBnryFn3pJQUuRojDyZAGMGqJbSA5MvO5/ireByp2Wxlv4zeNLXmy7wjVShsbjW7MaOP1M01RN8XEDD0N3Kdo386HneXVl0lA1pExeHx4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1IM47Es; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1IM47Es"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51e902b58c0so2576855e0c.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739782538; x=1740387338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHAm/6jbV5R00kaWYBYRttK6hjcGD+STN2zOx3oadR0=;
        b=I1IM47Esv8Ml9ji6dPHY+vNqSIJ2dFJ1flGgBGgtKvYTpmJGlbFt1SIgk59w3Te2Yl
         czaoq9Xg0pSl6QgjtKmh3u4cR4iV4+R2npAhunrk/XRBsk9in9oEN96NzbHItFEqUyWN
         pvAg3iCNW/eEdMEUO17LKgY1EvCmIGqW2DM6+h1u2ET/GJG5TSc57eDVcyqCHUtYpu2S
         QNNKnjvquQGvF7/Ug3l6uRHq4z58Pc7sUl5IIvUJnHx94hIobCDf3EKidPIfEuygX/56
         WIKc1NeBnGwr1cxzsKvHFVBKS215/cyv8xDPZ5E/zQuOFGVtOF4Y0Rj59dScjABZ3Kzz
         x8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782538; x=1740387338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHAm/6jbV5R00kaWYBYRttK6hjcGD+STN2zOx3oadR0=;
        b=gv6SXDxMejQNF3ShpAU+6x2xsUuxN2LKRRDl8UcbPEPPWtsDZaYhoEK0L/vz4usYQI
         4ueQu6MAQvmdy43LGiijnwb/b7fxxA7QPxq4LDEnFAXeBHYUF8cF3B6JoKWZ7qdgEote
         byZODRuW3d9+WtmWhOj3luF7d8VmzThu8PEdBbDXEFSDD4fMYdxiHZjqDXkvWNlFeUgx
         Ouq9nZXQ7z0yB5aEJ3ZAodbrezDj3m9abEMsRt0RzgxsjQ3RCvCZDs9OGtZaBE2ZJT38
         QeVxFzAnsbrqT/5PQkIu094NFYL2oKNf3N6+DETgLAK9d0t+xphtFYMF+PPoXq/eyU4e
         636w==
X-Gm-Message-State: AOJu0YzOyyiq0NJLQacIjBgmbhDKYTO8pHnOEmqpHVQPliCdWafKP+Sg
	1Xalh7Ba5SAKshyYQcek47A/vR8OwY0hqgFu33D1kudCwQjsaj0xtLlY6eTCW5oNKzV5iksUc4W
	K8l3oR9exU8TsFxlxfjQYKqdtVcql+g==
X-Gm-Gg: ASbGnctqIhXtb6GKTMYOQHUoGfpRLboKxxyL0yJcZCRtndLdbAtqkqvGR+j7kO7915p
	EqSx0lYUyT9rcevEbnx9li3z7XmgrrOIl6PoE+Jmqd+my46VSwYPSJyC6FUafB6etWlXBQCEK
X-Google-Smtp-Source: AGHT+IEONjLXDHK6orZdGdOQ0j+rd6xnjNB2AQ1Nz83ESHBXdiJw0uQkEWJWV9b5+E/XL9wcgxStpArJjJR7/pVr4DI=
X-Received: by 2002:a05:6122:2881:b0:520:5e9b:49b3 with SMTP id
 71dfb90a1353d-5209dac852amr3757458e0c.3.1739782537781; Mon, 17 Feb 2025
 00:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-3-usmanakinyemi202@gmail.com> <Z7F4ftdJHlMB0RL-@ArchLinux>
In-Reply-To: <Z7F4ftdJHlMB0RL-@ArchLinux>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 17 Feb 2025 14:25:25 +0530
X-Gm-Features: AWEUYZnubm7Gd-IrZ5vaflXgzVzNkiV8L7kNtQz4T6JzNKA3EcL9lNIQZuUdXRg
Message-ID: <CAPSxiM-478vE=20gdX0QDt5J-vVcwRXZycGUAugafWPhXN093g@mail.gmail.com>
Subject: Re: [PATCH 2/7] builtin/verify-commit.c: stop using `the_repository`
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	johncai86@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 11:02=E2=80=AFAM shejialuo <shejialuo@gmail.com> wr=
ote:
>
> On Sat, Feb 15, 2025 at 04:27:18AM +0530, Usman Akinyemi wrote:
> > Remove the_repository global variable in favor of the repository
> > argument that gets passed in "builtin/verify-tag.c".
> >
>
> I think this is a typo. "builtin/verify-tag.c" should be
> "builtin/verify-commit.c".
Ohh, yeah, I will fix it in the next version. Thanks.
