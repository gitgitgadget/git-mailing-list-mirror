Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A71386A8
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276317; cv=none; b=pCf8ACeY7PkEVLJbfA6wYwd/veUHXJ4sOuiwL+puILCXeXEnn/PUpACjPgKMp22ntqVGlZFROv3htpvzsU496bjbdqk71wYZR8TsVq/y+JIyFlYC0e0QjxA/3WiKgAhwTXMnSRZIZURPrQft4Ctb2VLpAzjhHZr3aQyI9BNnE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276317; c=relaxed/simple;
	bh=/fIJOmvH0hYQdqGiG6U4BZybCPZIfd0aG5WCvFbSmAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7wd4hNF8jhlbniLYJCRPJifF6QrIJQvbCBgSB4MMZ7Xw+l79FSSu4jlSSoSTcjL4WXKZRaLkmsMbyBxcDuB7Vm1PkMSv5WoEqtsLlDHgXAlWPjXEZUqTbsQKBlbLLtuTcpu7be25ZeQZQCwRWhc0rAYeSSsEgIEoZ6+rWJCh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yeGpieQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yeGpieQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a450bedffdfso50267566b.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710276314; x=1710881114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8gTAjnLTJBUA50BDFGpH/UFkKgJCUYRV0Ajr3iMCg8=;
        b=1yeGpieQ1UscfBYQrcBN+cjuKYFDPDBMfsBSQBHdD0vjPx6ZG4OUG6D/sjxhUNUgX2
         3kzB/bawNnMjA8BCTfqY2V1b5fYwUZdIZqZqfZNm9+AaYjY24U4v2CRsed8drcUM4z77
         K33atBGD2sXfMtjUdSj+JGZBWXFSX9lywqf3IDDXzlpThxLX9p/D71PK932MVej1d7zl
         ve8+f94YifgVRRdoEyBS1pBXIwy/Z/vf7g29qD8nDhKKA3SHF3Na2UhaPQaAkX1UwSwB
         Ya3xgHfLIU4GXKBNlyFllWTjI7+kZWG5XkLRc+IcZOcISxnlvEnnVoqUOwzwgps7FLlK
         osPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710276314; x=1710881114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8gTAjnLTJBUA50BDFGpH/UFkKgJCUYRV0Ajr3iMCg8=;
        b=WY2JSAQ0AQER8VqmBau5oCEqpaX3sk7u+oNzpqGRgYXlTKPjFNcAHisYCwb3RGqfBr
         TYe/oiZH0FArdPoGO7C7r1OhVB5D4BBeTLhfzWC52WXrUxrhrDGZu3zEUUXOwJGjh9hh
         Dkr+4if8OZofdt9u40Iud5gKSjP9UoRRpwnW1iE68r0yhxMUgOPImjWR84NKSiJYUKqK
         TqDf1eSy+vtxEpeq4c8P1yynMKqmBT4I6Fn9VDIDp2IT89VMtZ6SOJPTEtSMlhIXTiON
         PTqZgeMiT8ZRkxWT7lUHiGXi0Q9bfRlv1xdCK7b8NHzH7Tjr1E0JTNK3+eVX1MohQGEh
         X95g==
X-Forwarded-Encrypted: i=1; AJvYcCVfcl5TatHMNDEd9jDm+9Yx5al9LnLLMOLgLops52bvrczvF+pUpjfMYkn5dL0TO15EfAeUjtMDidSUSAtmSEgEBAX7
X-Gm-Message-State: AOJu0YzmSpNSGg66uEkI8mZXFfJ1kWr429DDAfIczN4hZjp3JISJbC4q
	UjleHGnxM7+4ZwtmSe5rzFk0UAPhT9LPjpqKS6YSzGJXEVFZ7UaTOPeakshrpt6Ce0FD4oaj9N3
	wI5MRO0TxZT41LO1DD9JIX+6iWFeyffzwlG1n
X-Google-Smtp-Source: AGHT+IHwtnd30dfc78MlmrnnaJtFU43letlahXYlHpLj1iPo7Yk2V3uwUHC6LEfzyhCXekCrCX5pauZ69rVTVKuVPFw=
X-Received: by 2002:a17:906:a384:b0:a3e:c738:afa2 with SMTP id
 k4-20020a170906a38400b00a3ec738afa2mr959517ejz.76.1710276314489; Tue, 12 Mar
 2024 13:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com> <20240305012112.1598053-3-atneya@google.com>
 <10042df8-5d06-47cd-9202-ea6965f50784@gmail.com> <xmqqttljs3he.fsf@gitster.g>
In-Reply-To: <xmqqttljs3he.fsf@gitster.g>
From: Atneya Nair <atneya@google.com>
Date: Tue, 12 Mar 2024 13:44:37 -0700
Message-ID: <CA+D9mTFLehceHtO+_3w4pCW+XKNx1FjxJv_qR+sfwR94kPJMVw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>, 
	git@vger.kernel.org, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 8:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> >> +    if (!path) die(_("Unexpected null from realpath '%s'"), dir);
> >
> > In fact, this is not a null path, but an empty path (null is not part o=
f
> > the string).
> > By the way, shouldn't this be an internal bug instead of a message to
> > the user?
>
> Unless the strbuf instance the result_buf pointer points at is
> corrupt, its .buf member should *NEVER* be NULL.  Testing for NULL
> is meaningless, unless you are manually futzing with the members of
> strbuf (you shouldn't).
>
> Thanks for carefully reading.
>

Thanks for pointing this out, I fixed this issue in v2.
