Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A163BBCC
	for <git@vger.kernel.org>; Wed,  1 May 2024 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539357; cv=none; b=E7GoVEYqhlg+v+EJDQ3hbL0og0uEkkWPTYwZiChuZherUeVXlGC8giqvvpChN4yBxoXocEEa7m2KfoDcV8XRns+5VWgLOV2AdG66OF/9+J46cta0HYDL98zblDQLBfgSXQCQ14LjH+NvMT0+Pa548/Htmdu0qpQHCxEd+2E+qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539357; c=relaxed/simple;
	bh=OXbDj6fxN1womQJhhB2VpaIptCQ5xGyGySBsj18owus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrR6me/7IbUshc3NV9HPcQGpv232bRfMC/MSPT5yOTMwcyCD6v5dvar1LtA+3XmGIG0izcGvQRm1mtJfI5yDtbmW+SlrrwfTxIpXe4FT+xReXOG7oVdfZC2qzca9mXdzWj9p+6YvzdUlHlWkluM4jTX9qiB4S6h3gx7gfeXwex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY3T0/2m; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY3T0/2m"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-602801ea164so4396510a12.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 21:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714539355; x=1715144155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXbDj6fxN1womQJhhB2VpaIptCQ5xGyGySBsj18owus=;
        b=IY3T0/2mjBihnlmsZLIO2j6QVDzj09FGDnFlFZY+LOx29bu9c++KmeXh4iKVxLbRZr
         hN+Q9PDB+88BQvoXAYABXrF6nKs8yt4sGM4jo2hhNpTe9Pg1O/FKTF82Cwncx8QYKmv9
         TLPmH6tlnhNBxaHzqaBgQvA4I/bBJG1iPE51+QMn65NWDwyNliQRSxo32iT+HtX8eYxt
         8BH3CuhrS0WZbCHz3QXMbCeGwPhzClo6u9pLPTW2WldZoQ7xqjV2vsYdS73sePp/8FnB
         TlpvVAjLYBZJkVhXakq4V/7t09+ypfttpUJqz4BHoC2uMBdScUysbVOs/wpBJjpPhAhi
         pMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714539355; x=1715144155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXbDj6fxN1womQJhhB2VpaIptCQ5xGyGySBsj18owus=;
        b=F2KztpQ3JuopScbh6mZifpMnsjU7k9nLlXbFibBiFXXFEKYELq8Sdbq1hP46xvaeY5
         F4kFsagOhs6vNIc8gqOf3DR9/EWxBp8mGKWcj5KNniKdIoyyQJkXOvRHp9FMQyolmN74
         n0Q1hGZKwxJM6q2HyyZKD0KBiU4fK0sk1jGQBbZR/o0AEDeCqHAbvfBJMaEZBZXSnEvz
         XL2v5TqgHCOSYwknubOvmmzk5EpoKJXl1tHR9h2ObCXQmHId0Ld2wpnX44203DQATg6z
         4Tp0i8UXrV0yu1CBO2ar0A/eBuG3jiGolNS1ee5Eu27ycrBkH7f1UjNkYlcdEkYuvQ19
         gy5A==
X-Forwarded-Encrypted: i=1; AJvYcCXhv6QK9uOJWbEzAei7fRuL6pnPVd5JpKZtJKouvBAKTJRXe0NoIoXiGjuXLvHysjJIFauPFchtTN6tcbNxescnOOlg
X-Gm-Message-State: AOJu0YyneWA1LGSWECkRS3LLnvyxHQepvBJB4TCOVXUVI4dOJ1bRd0HJ
	IKezfyys7EEFZxibnSLHKTE3zqEih4wnoHfsHIXCpdgdfIfRfdcQZx+NehtSddaeaNtnsUKVC8v
	1dcJjAVmQoASAo1ijG0v9X2hAgUE=
X-Google-Smtp-Source: AGHT+IHxiYPgiPxWkJlDL8C9DDMD1eKfgj9suf/rEMexQxWdD0c54TEOCDCRYWHVu3ffXsu09XqQ4xs+hNuEaHJ11Ew=
X-Received: by 2002:a17:90a:e2ce:b0:2b2:32c2:44b4 with SMTP id
 fr14-20020a17090ae2ce00b002b232c244b4mr1465317pjb.10.1714539355398; Tue, 30
 Apr 2024 21:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
 <CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com>
 <xmqqedap2ijk.fsf_-_@gitster.g> <CANHPH19FCWUAMZLFZEY+_+zv0KUkuVGNQS26WmEPjnPtjrK8KQ@mail.gmail.com>
 <xmqqedamzo17.fsf@gitster.g>
In-Reply-To: <xmqqedamzo17.fsf@gitster.g>
From: Toru Okugawa <castor.4bit@gmail.com>
Date: Wed, 1 May 2024 13:55:44 +0900
Message-ID: <CANHPH1-rdP6V_9P3mA+hMpDqVGkskBqrL6tJLYfePBv=WutCjg@mail.gmail.com>
Subject: Re: Re* Unexpected behavior with the rev-parse operation
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> When you write a script that you might want to use as a part of a
> hook, for example, you may end up running it inside .git/ and it may
> be necessary (depending on what the script does and how it is
> written) to tell where you are in the working tree (or if you are in
> the working tree in the first place).

I misunderstood the purpose of the option initially, but now I
understand it. Thank you for your explanation.
