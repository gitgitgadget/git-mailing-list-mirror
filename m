Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4627057D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368088; cv=none; b=Y2mQvFTTxXNCCwtfNuhggMnCXF7V2jd6yKmgXEkEZEatFeAUv3HjSJ7lBuuvdmBW0YPp3fCqq/rBm+6Js+sR34rpKLBMiPMLz4jC3TwZrqknAZT9ILC7V0KK9aqeKUR/cuDXHr/wxq155FUreORMQLIV/KRb15mAtJRwOopsVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368088; c=relaxed/simple;
	bh=wmO/kz28JvGXoqm8ZQWX98QvNYKBs+NhawpK5Yh2ihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2ojvj80BHDlK4xzF2yd3dcIrZmM90J9nT9ZHSU6ozPUnK1A8uRE3yt6BoxNZOn0dJZuWyzinHbcP/3otNV4ps9qyQLnT3TxP4Mi2wzmM9JJSRAVgdd1APDDZeLYr6wRN5xVtZ1WOavUDTgw4hgFxZYq6lZ2tj8s+tEpry/s1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8482uaZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8482uaZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb5ec407b1so561964666b.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751368085; x=1751972885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tiryGrPIT2Hf8R0Wdx6dP0aUJpVd6jWmKq/TTm9GpU=;
        b=P8482uaZk/DujnOpPeq8ZXZpOasrxfRqBf2ESqZzL9yFroIlqhIPeePN9YjgyYSax5
         lDxhK6ywrzkPi0bpYQIneWhe8Lsh7F9LCXAXs/f6lr3xNMQ6rGnCPOw5xlMmlwZ8vn95
         ojzQ4rcNj33WFsSmFTZ1jid1meCy+JftCdQzll1T9eRhvMHPDnvFgM6gRUKXSwkk5AZZ
         arPsT8b+bxCEtjhsLlXBXa/+mhA4Sod18QPpTLivKOU1+MKQxUW9xmz66lKGzHJbd4nF
         7TPuqOcCqCLiJuaDzWXVpter/pDa5Z7tOibHugcll3eM3P5p4KuNlpFSmgc4+C0SPgKW
         pCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368085; x=1751972885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tiryGrPIT2Hf8R0Wdx6dP0aUJpVd6jWmKq/TTm9GpU=;
        b=NLNhGHmPWPuAEpi5p0u8rtP56Mz5i8m8lvy+vmeA747qe9NHC9QATdYL21rbHC8u7Z
         Zib/b2BUogKBi+HxixMQOMXqIgTqfj+UU0Veq8JFH8wUIdZ1+g7qmt1btdh0cxHTuhVi
         23fnvOsY4279HXdE+IE10gypZpe0sraOAJRJKMY+GuDLJuQds6ON1Rw2Z8nfotkY6Lcx
         lJtIl6YBA0HhqYQJAwGFYISMBc8zjIMtJ8UK0KWhFvl+cA/tZMZfl54LOwv1aXDyW7Mo
         vXt08DojQgg7bQBRJENcdVe0DObAmYbGZjVPxmkRy2gkit3e+LKZ/BZLPZ3Rlc8B3M8g
         6kqQ==
X-Gm-Message-State: AOJu0YxOcissL8ysAZD/iSbRGA4W98sG6thZrjwkKRACY+IguhzccKNb
	ciEqfhFlgnqWm4UEdTDmWF8f/+fsV19TOD4961edysXdV1dfbU+1BYQEo3XmRRRLG7KhW097Bzz
	aQzVJN7r9qCdJxwVzahG8pt0H6XEVrU/fQnDh
X-Gm-Gg: ASbGncv4nPcpraxftD7Vc2qPj7qM3YJ4zRPuB+izcHifDlSeyTTLBQUDa+wuEIjdTsa
	d/0NepfbCRh2jpwUpBntBap4/SFmHkJob893Mjzr1Vsys8bmD++tgiTbG0jzlkEkn8vfh4hsRI+
	1wQemmPwzpVuIjrfFPcbpWn+lYLtC9usvZyE3V4dbIf/vCxeRgl00dhfbd
X-Google-Smtp-Source: AGHT+IF8ZN8wJEzotgmWdWjShPq6Nv4v5t6/xjPFEGZ0CgSbCW7FwRnLwr4D2e1UxordgkXYCNqWRbzJ3yiNkxg1rA8=
X-Received: by 2002:a17:907:3d55:b0:adb:2bee:53c9 with SMTP id
 a640c23a62f3a-ae34fce8a08mr1697974066b.3.1751368084337; Tue, 01 Jul 2025
 04:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
In-Reply-To: <CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 1 Jul 2025 13:07:52 +0200
X-Gm-Features: Ac12FXy9UL_cWZdnduhKdW-sM87wdSGi1pN7n0mRYxRa4R7o1mpkX6K5bOny_Bk
Message-ID: <CAP8UFD3DCi5n12HpYwuF4Sh4gG-B98a57HBpDAB+uPrqJcN+jQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate changes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Git PLC <git@sfconservancy.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:36=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Jun 30, 2025 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Following the example set by QEMU folks, let's explicitly forbid use
> > of genAI tools until the copyright and license situations become
> > more clear.  Here is what QEMU folks say in their commit to adopt
> > such a rule:
> >
> >     The DCO requires contributors to assert they have the right to
> >     contribute under the designated project license. Given the lack
> >     of consensus on the licensing of AI code generator output, it is
> >     not considered credible to assert compliance with the DCO clause
> >     (b) or (c) where a patch includes such generated code.
>
> Here they forbid licensing any "AI code generator output" with the DCO.
>
> > and it applies equally well to ours.

[...]

> > +=3D=3D=3D Use of AI content generators
> > +
> > +This project requires that contributors certify that their
> > +contributions are made under Developer's Certificate of Origin 1.1,
> > +which in turn means that contributors must understand the full
> > +provenance of what they are contributing.  With AI content generators,
> > +the copyright or license status of their output is ill-defined, withou=
t
> > +any generally accepted legal foundation.
>
> Here we would forbid licensing any "AI content generator" output, not
> just AI code generator output. So what we would forbid might be more
> general than what QEMU folks forbid. For example they might still
> accept a new logo, or even commit messages, made using an AI while we
> wouldn't.

As QEMU is part of the Conservancy, like Git, I wonder if they
consulted a Conservancy lawyer to come up with their wording? If they
did, maybe we could reuse that expertise?
