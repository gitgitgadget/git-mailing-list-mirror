Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A61D5AD9
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729423; cv=none; b=c0fMs3sjIcRLxQaG8Ynv6AMIBjPUAPheipYcwiIuZ8nq8+MrgVL5/Y6haQKxT2XplYhLvcQz8To0soC7xhPTITLmojGzqxp7bMKWKM21seWf9JnNPUI+oqmzRsPQHaxwFTpaPoPUq9g5rMC8M896V1pG7Of0UGK4gYVeyZRwI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729423; c=relaxed/simple;
	bh=IE67LWFylUQmT61JztmFX2woinWGUwCwJnk5sIAMEF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPqA+FntZweXYTfVsVf9zXc/vAshJTh6l2x11H/XPFNIcNilqMcxvDLm78SWSDTUZJdDfmEJ3iCSJEg24B0TjMQXyJlno5Yc7dKICtPmA3N0WeK1h542Q50fOygc9eqWAF2RHxElSiItfjUZHQa3MuCYyi/P986dGERNPZKQdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTkOC3tx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTkOC3tx"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so560776a12.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740729420; x=1741334220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE67LWFylUQmT61JztmFX2woinWGUwCwJnk5sIAMEF4=;
        b=cTkOC3tx+vCCSkc82SmqIcUvh9kMhsNREQRZag1/r0z6/I4y4Q+/VcBv5pMOR9LGc9
         /vtN60DYW2gTlzuyYgdLGAeH86WAKGSUdoTi/UVgMd0utFFWCFqbhky1o6cIv9zAXxAc
         gBVBnId91PKZzwDEM921QOMyk+dQTpLhJ3BIlYs75bQGJ5ahqROzdQEXg135s2Sbyn+d
         vcVIVOCeKFZWB7EFGa6mElELZTRlEOY23smQ78gh0IVF4JMx8sV4RbrYv98D6DwmjLIi
         MMaqGpxwQwTj5X5CkYzNBbhAxqH0J33Gvti192NOiV4PifKNAoa25zJDj7tdVC7WFbEy
         Z86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729420; x=1741334220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE67LWFylUQmT61JztmFX2woinWGUwCwJnk5sIAMEF4=;
        b=CDUFinMSZ/zAlZ+I1uPyPrcIGieDglpg4Xy61DMf1FFLBRoZa2ih1cdQ2x+KzYEJfp
         evZNWtpSyGhJbDylizUgDqumd5NZ/nOPoLb/eOPcdkOKsrzVsUZXFno52p4Ifk53mW+W
         7ukhwgSph6VQqbgi2UnSA9MzDY2XggLKLQEWSmDU/n472Aep9chybubaNYN6EXtpfAQ7
         4NmeJvlDAumV6aHgkI0eIT0TgNmvUbCzUBSRQ1R6UXQ/hBdigV6Gep9E08/N+/5IXiIQ
         xSd3Ds9MF3DL6i6Odci7PQ9dhVJrg+/EuesEJuij4X5e9/JxjT2vdQf8nfZGEOWvO4eB
         4emg==
X-Forwarded-Encrypted: i=1; AJvYcCW6IsBDlFLlssupirUsCnV9B1C4R7vTZXCLOUpzBo4+jDnv/R5C7jWwYEyYWPlwQf/q8tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NjWpkP/Jyr+2bMYWWbpZGeWo+TM/jippGKPhvmELAviTTTbP
	11M5yFjCjInzewOM27Lj3ZvSH6Me4U8mGfLbhKKPhKLLSIxf6HhZQXblu4xqhPicIy+PBbAlglE
	HxgK6LhdbSIha/aJ6Lp3QciKdgIpgew==
X-Gm-Gg: ASbGncs65yWy7CynUmrYe+0NuPnT71WwtvbaPuKrRsUB0TfYcFXTuBPzwlnta86/Ipy
	v/rQzultg0tOaWP52U6/ur2WmCS5Lp00ij4hsL6EIoypOX5rvwbbAa//OR1nK43DoKmf9RjkjVJ
	HwAcx4Acc0RraVI1vYs6ejKUZcU8f4sDD9POug7hHJ
X-Google-Smtp-Source: AGHT+IEUad7dGEdAbGps7LfvMx0Z1rdbNAHfCOqCf3A7r69pBsNpT8E3dZmL+jp8lg/FMWL/zOJjxTD3otfZwqWYnJE=
X-Received: by 2002:a17:907:2dac:b0:abc:ad5:eee1 with SMTP id
 a640c23a62f3a-abf25d91fbfmr194389066b.3.1740729420006; Thu, 27 Feb 2025
 23:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com> <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 28 Feb 2025 08:56:47 +0100
X-Gm-Features: AQ5f1JoJVAjpYoR0SvrY46k2iiBPVapsAh72u-wjgNrvJLbipuF2xWKN0H3mvvk
Message-ID: <CAP8UFD0Tos_3kF+FBfQWiL=69M2bZKcisYCT=5p_Qgt9hv+dJQ@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:03=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> I'm glad to announce that we've successfully been selected as a mentoring=
 organization for GSoC this year[1]!

Nice! Thanks for your work on this and for reporting it!

> Christian, Patrick and Karthik,
>
> As you're already members of the organization kindly log in to the GSoC p=
ortal to read and accept this year's Program Rules and Org Member agreement=
. Let me know once that's done. I could then add you to this year's program=
.

Done.

> Let's look forward towards for a great summer this year! :-)

Sure :-)
