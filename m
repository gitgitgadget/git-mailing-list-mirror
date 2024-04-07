Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB13D6A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479613; cv=none; b=lYI10RxrL72zVbQjNO18Zlqz9lvI2O/Gw6V/BBy5wuChvZzxVSDHEs97J7KZJDRLvG7ZmZV6zNzgVtZQOAwEo+qpyQvwipWmuCqpC74NnYnvovtaI+LU3YGuCttdbnuq9GXNIZvYXiNJ3a9RECSi0yiQbaBwGU5uefxKZn+EpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479613; c=relaxed/simple;
	bh=DYdo4E8Hh+S64s0YmYQe4yH83DDAkRzQ0sDW8FFhURs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QDeb/kmPW2MdMGG5V9g/Cr5K5v4wHKGQqlC0oPiMa8CVbGT1mzWNbBJMadXIKKxG76IFR9hOXyWE3Fz0rR0K/9/5te8eSYQ7090beMY8gf44HHnCI+GwLVVOZP6hBMmJ+NppmZCqgOGaQArd3H9WYZxHKgy72kwiBFZhr/PEfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfWjVSGu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfWjVSGu"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ff53528ceso2746327f8f.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479610; x=1713084410; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYdo4E8Hh+S64s0YmYQe4yH83DDAkRzQ0sDW8FFhURs=;
        b=nfWjVSGug7NgE0m4q9gMFe9qE6Q0byLAThkaP7fo8k5fHiIoEdUQ+cvCHgcnXbw6dX
         49oBJk+zL4FDp9TKJzecm7zELKf/yVcWFqInvBEuVvtYgq/1wgg7O4LDe2t7McktIOhs
         nmSAY0MrUwrE17a8aDEjWeJ7orNILZgQRBzi2xnliPPmqcvGg3UldPZ4LjZYzDpFjXkK
         kppMgBKyOslwhgoIAAaMtY2nF1huZ10gMgBUL1VxK3uPPljl5n3LC7+iq9iVlScLU6FB
         W7sQhPNdd2+BEXA7aLr7b79YZb/lNQHTIIqcfFClIopAmN2+EeQZYQ8fDEGHcAXHEn3G
         aRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479610; x=1713084410;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYdo4E8Hh+S64s0YmYQe4yH83DDAkRzQ0sDW8FFhURs=;
        b=H1FEQfXtRfe6LFWyvzIlI2Vpgi3J9RUIArL20t4y0SFjQDiNbsFxmewkPkij9IWpi7
         qFdDw/9KL3fgOOldL0Tjz132wIa2bsutOZXsr7Dmt4CqJOe72wIXiIIlx8r5vtql2fEF
         dFDEdK6CXgIPhG0RNFBVvkVmjgEpq/6UndbL9rMmMkwkWE/D6LvvJpZ5s0OqA6NvGTAF
         1vE//auJpEQsmZAQNeyPH4LjTa5A8eswLkTE3BZvkREpq5A5udu3LV5UE1EQ9zmxDmLz
         smW7/B9ghLJXtCbwYgsYLwnzRZXc0xVZ9alZvxvhpQO3tollToDYqeNuRZAc3wCKa3eb
         9Cpw==
X-Forwarded-Encrypted: i=1; AJvYcCWsx2SONq0hruJJbEk7UdVFZdBRF5bwiKXtjkOUBe7JpRJRtAs7rMND/+AKk9IOKP6LbI2w3khIBv176KeM+3BHASux
X-Gm-Message-State: AOJu0YxIDXcM6JLdChDqa16U+R7CDYaEH6CQwmBzQnvtHzILWvDkendP
	Kb5kIw5YmsrBVgUz0RR2vRJ3ZEvLmkWXSU871mrFh2QMG/ZtGT3R0X3IoPZqc9pE+Q9jmOuivUe
	OIg0g5RDWUHq8eo10Fgx5C3dOtwyOeznTZVcQad35
X-Google-Smtp-Source: AGHT+IGkQDqArr7Pi0suu+QuTmTdwiI1+du13SwOnDcJJshTOICK5DYP5orBOHdkxKKTvnr27/eHPAL6Rw8SSw5JcAs=
X-Received: by 2002:a05:6000:1864:b0:343:75eb:7f32 with SMTP id
 d4-20020a056000186400b0034375eb7f32mr5498197wri.14.1712479609716; Sun, 07 Apr
 2024 01:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
 <xmqq4jcdivgw.fsf@gitster.g> <CACXAH50KHrnmc1At_DHX5O=BGuGT_pe9n5nGLSJYt7fXTbe_Yg@mail.gmail.com>
 <1e5dfc946c38809f159776f41e23c7c6@manjaro.org>
In-Reply-To: <1e5dfc946c38809f159776f41e23c7c6@manjaro.org>
From: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Date: Sun, 7 Apr 2024 15:46:13 +0700
Message-ID: <CACXAH52+ZZGW7xwutZ8Chrap3e07Xm-5zwDg=L2PBV2nVEvOXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
To: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 3:34=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
> These days, very few computer screens aren't in widescreen format,
> so there's inevitably less vertical screen space available than the
> horizontal space.

The ability to scroll makes all the diffence though, there is quite a chanc=
e any
non-trivial commit log is going to span more than one screen height already
anyway. There's no risk in sprinkling a few more lines into it; meanwhile i=
f the
number of columns actually gets too many, in many cases you will not have a
horizontal scrollbar to play with.

But it depends on how this idea will be expanded, as it has been only an in=
itial
hint from the original reply.
