Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE541FAF0E
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801701; cv=none; b=POdxSurYX3oFAG2ZURmfjfT5O1psI1/WbU74G7aaBai417HLvc+GtU08cFZFbBx7hMiCzZW3ALYuTJDsGnpe7FqcPCDZBEWPFhTwcO1I5JBEFbbfho/7J79+N6TVQtNpG4Q0yEaCQPOZLkDZWkM581vBFExag6++Lb6Q2A0c7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801701; c=relaxed/simple;
	bh=wq4EKxxk3I91x1qiQzgpXKSwOT+vN5bZtYQr/ApwDYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcQBhZmWMeZ7R3SXAkepTTG+uZSJOUZ8inz2NUTl6v3URzhk+JG+1O6KmLnzelELysVi6AVk8JXifHDnuYArB7rr5dIKdm0hCugvkDzWFPPdRQWYF2kF1mkxG1891kneDXKmW6Ns+w4RithFTyjW6eTY7oUwHlNtXOW7O9URDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kicabbv9; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kicabbv9"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e290e857d56so1517809276.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729801698; x=1730406498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq4EKxxk3I91x1qiQzgpXKSwOT+vN5bZtYQr/ApwDYw=;
        b=kicabbv926Vvw/lUSLSvSDCuFvo1UX1Bwr0STmtggYVZg6JSg0RKAAMVreHJlAtGYj
         RmfIsn5P8vCUsB/vgPZc+ZHJFV4k0sdtUOerQscSFTkXHTu9EbRPeFYut8MzwFoWotNG
         hQTIVUx/ToVluAfcFiAh/W7A1jV4Qp+4bps/BHfFlIuIdWP2hdZG7B5lHwWNyk3sFJBK
         /edNh87sTfoXullEH+GeYGdw1/0dz+biotL85n1fVTPpDXxr0YbN3n0EThoXUiEXz1wY
         i5yQWYiy7POb9GybxlhZyM6tNE+pah5B6FDcrilP/gvsQA8EqLCNg5lwDs77LUcMADOT
         T2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801698; x=1730406498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq4EKxxk3I91x1qiQzgpXKSwOT+vN5bZtYQr/ApwDYw=;
        b=mM+hpzH8zkPR5dwp1JGLSPb1pQvxAm41eCeAHd/Wa7DhqrXQaf6y/4+ERr3SN2aFao
         B7OvSxMMErqIwmZXGTOSaf7/WM+hM+4cabhz5X5ubReJlKf6RfUcM8GF/xTNexsyEQDW
         keriDRPw+KvUh1222OynYXUv60FuIoGygUWwyMHOuqceQeWDFMBPmuDQk4BWqc0b2h3b
         nIb1sGm/7ETlM8T4+GchalOSydjLrKw3uW20NMU5S4F1Dx7mcpgShpOSU3fXLI2OnUoK
         k9WRrI1s8fSOrnsz0UnuPJgJhV1/B9T+W0MYssCOw8WIKuYVkqm4kWeIy7ttogPtjl0L
         92hA==
X-Forwarded-Encrypted: i=1; AJvYcCWor8pgd/MzZPYo83PaEItj5Z8xHZE1zSqD3++/jIqY4Iz7zLwiyC1pq7nn9vPN3MysC+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywunz6tXNVcrj3p5+Mm5ssgJb/NLF5eghNsYeKXZvf1AyYeWU5x
	71cYJz8RZrSClt+ZmTwMZhPsKH/Kan87JQaiESZSNk9Il6lePLAmvjLpP8V/k0BHxJeM9xPrCTX
	a3yKymY/l2FRO8J6KXdAUBTgibug=
X-Google-Smtp-Source: AGHT+IG3HkzYoa6ldox2+SZxRGEDSwYwyzetms71/HOrVondYv1AcJP/2trChjUq+LAik1M2LorNsTrekVCbLXgkSEc=
X-Received: by 2002:a05:6902:1243:b0:e2b:dde2:30bd with SMTP id
 3f1490d57ef6-e2f2fc106a3mr3283800276.53.1729801697230; Thu, 24 Oct 2024
 13:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com> <20240926013856.35527-7-eric.peijian@gmail.com>
 <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com> <ZxlbsizeDUz5yp11@nand.local>
In-Reply-To: <ZxlbsizeDUz5yp11@nand.local>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Thu, 24 Oct 2024 16:28:06 -0400
Message-ID: <CAN2LT1AJwuocyvww71E8H7s3SU=rXjigLviWgCfUMac7zzH+VQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] cat-file: add remote-object-info to batch-command
To: Taylor Blau <me@ttaylorr.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, calvinwan@google.com, 
	jonathantanmy@google.com, chriscool@tuxfamily.org, karthik.188@gmail.com, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:25=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 23, 2024 at 11:49:44AM +0200, Christian Couder wrote:
> > Except the above nits and another one I found in patch 4/6, the rest
> > of this patch series looks good to me.
>
> Thanks for reviewing. Sounds like we are expecting another round here In
> the meantime, do other reviewers have any feedback on this series?
>
> Thanks,
> Taylor

Thank you Tayor, no other reviewers' feedback yet.
