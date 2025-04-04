Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2B1CB9E2
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764811; cv=none; b=Cx3y9Vx41RYJij+QMzapbY7Q7jy9WRdRXNqIodDo7m/1UjeQNDMxyrXbpaI+fNkWB16IHIjYfhXxR5yK7LdWLNl3a1V9B1MdQfs4M7tAkdVuQR5MLqblgNYoybnZuyRrGbn2jUWgWOCn5JXtFtwQX/+UPR1qqRAIX7eDCf+XSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764811; c=relaxed/simple;
	bh=SMI21ijUsky9u2RYqy254Owjn4MlCcD/QhMpRXPBp8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH06g8KeTtV9p5SlYME68zcwFZ7IAdciT/L7T0Dd/sBC+Tsa4JsFpFvpKQIs2Oq3gfncAR0It8nTEf6IU2RhLo0yOeez5ikuV91KZrGT9upg5NcyY/eyldLVZbnS1wG9qm8SpKfHX++syiAk4wKXzrxQRLbrXRRs5cUa4s2K7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYoP0/FT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYoP0/FT"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac73723b2d5so384231966b.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743764808; x=1744369608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spzjp8mnkaKyIGL/b6LV5RdzlKCg6HdGboet3Zknb78=;
        b=iYoP0/FTSJkx8KJl0Ax7NDJW18vm+ra3KYZDbtURytehgItU/bBWRFc6l20+vh2ZsV
         biU35QaMemT5YT0DqV2mvEl7Tpm2Et670n3y4EYe+MRx9PgO/BYcEdXwXRNs4xZHWgoh
         rke6cWhdY86IYHWcu6RHEvryB4wsp99Q6x3/Tq35UeDax7z7L+ZIjuf8gVpEqIuIRNKs
         2lmZqGS3oqwWtjT3Sw1swx/NjooVUtwElpNNuJnajRx5vpabE2aUNyZwU5ZROBMkp5rT
         GBJsyBrmUISDlYpewPDFfdZrjVKS3IJU3yaJG2ZGFzCZyOz7gOGlSxGlArzPvd1Kdgoe
         9qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743764808; x=1744369608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spzjp8mnkaKyIGL/b6LV5RdzlKCg6HdGboet3Zknb78=;
        b=wf5qubqigz12P6muctxBgZjYYnSK/Q8yvLRVvxBLhETPgZGujhOmxIMhRZs2TBqf2s
         DJNmJH4BpnWwunZUDe9yJHEgQ5UBA0fAx4VRZn9/p65l4LOCoSiFigiXQNHgNLDKcAj4
         u3uq8/fmFbzgxiO3dY5FAIoiv+O8A+q8Ql1QfSdov5c+4SmTSpclrg/Ar6vejvyA65Ei
         AAfPXyKxB8r0vRGg2VMPeg+i1X5hTDzfDtjtKSF21cBCg6orglAkeccX+oLuopONiJAA
         imPlREYTaK58W/ZqpzJmiK7s6tWIAwQX2B/U398CONwnOk7Zp1aIldEEhYMoUuIO/Vz7
         MJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx5ZbYOqRiAiioAskTnn6cofEo4wy2MCBRSBJiyqKLZfxPJz1FYrSD2z8Df5mr0sRZyrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQiTScGIR/wDCiTETVGFhCOS4geJGNjCVAKXbFycDDhS/o1Jb
	dYeKy6LtsVvKNE1S/uWhPX79Jqr9mOPLODH7eCK6qfLkhVaZq3xpu7KCVTHYbzyOKM708lNTkpR
	JVOlh3uEkuV9AmMoo1Clxu6U0rp0=
X-Gm-Gg: ASbGnct20ye7jPnzFmSu6K2A3er23qW93SIUAN6V4s62AxOOBl9OB9dT394OUrFFGjE
	MjOZsrBX/rtWCOoZeA+KgJwyfYIiZB0tE2L+L3Fsm3JbvrbWUssI/cbwPBgtiIILDL3hGddfO12
	oLM8LD1DSxZp2OyoicoA7PsJ5mkMzV753inIXiRORwksdnxyW26XWGi4rTKtQ=
X-Google-Smtp-Source: AGHT+IGQt2aCHI2JD8pkTTVb9u/7hUDQkI3/f+DBIgmvNT+szhghy0HeJb/5rFodCWnuOXzSQmIZlqwXTEfqERAZSxI=
X-Received: by 2002:a17:907:2ce4:b0:ac7:66fb:6a07 with SMTP id
 a640c23a62f3a-ac7d1858ef6mr241892966b.6.1743764807553; Fri, 04 Apr 2025
 04:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401203630.285451-1-jltobler@gmail.com> <20250403140529.497876-1-jltobler@gmail.com>
 <Z--kT3fIvz8k7h96@pks.im>
In-Reply-To: <Z--kT3fIvz8k7h96@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 4 Apr 2025 13:06:33 +0200
X-Gm-Features: ATxdqUENG4dhMlvq0aCAEmer6biM3DeEDzAnt8Zbif_gxX-annI5jIfDorBaFwQ
Message-ID: <CAP8UFD2a2hA5CEYgr9i5jtw+k8U9gu=Jb01x=W1zekSRBy7B8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] help: include SHA build options in version info
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 11:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Apr 03, 2025 at 09:05:27AM -0500, Justin Tobler wrote:
> > Greetings,
> >
> > Additional information regarding how Git was built can be found via the
> > `--build-options` flag for git-version(1). This currently does not
> > include information about the SHA-1 and SHA-256 implementations Git is
> > built with.
> >
> > This short series adds build option info for the SHA-1, SHA-256, and
> > non-crypto-SHA-1 (if any) implementations which may be useful for
> > diagnostic purposes
> >
> > Changes since V2:
> >
> >   - Updates to documentation to provide additional context.
> >
> >   - Inlined `get_sha_impl()` function.
>
> Thanks, I'm happy with this version.

I am fine with it as well. Thanks.
