Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E219994F
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700192; cv=none; b=TTbHyqS4tn+thoqN8mWAUHxRZoodxr/g5jXOSZQRAEKOTGZ/ILtp0cMcEYC8MVJ+0aPkGCK4GVZq4sSy0YZjdI4+og5Rad9es8a1e5SWOK0MG1rmay0jBCEZo0LiuCLnydUys5qX0Uqu4ueqinypYB0O8t8UGYOXJIAG/90T570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700192; c=relaxed/simple;
	bh=YpqOAHwVgrZXKuBAMgsJ8zJnsSx7G+YDJ7rOJbs/0M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFWSclzRhaZps0hgr3rmrQU3B0tkKNm+gQcAOHrmUbD4SMZXTUt3UcpCcuFcx55qrGWazPOliGnJEdpbbc8MGb155+9nxhUuJ1surYh8uebzCh+ZWsHxsWi/00BnwYAkwi4/unSxPmLGYDciK+Ga2FhKIiopBuy0n9n1V+RB5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhR5gIr4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhR5gIr4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-72e565bf2f0so17230247b3.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757700190; x=1758304990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpqOAHwVgrZXKuBAMgsJ8zJnsSx7G+YDJ7rOJbs/0M4=;
        b=HhR5gIr4MW//2GpO9UzeFh9q3XKSqE4XFmrJZ1893AwNpuV9FcvzC7etVdByTij78T
         Q2pri7DKuFRXpjGZQAys2M75zwUEkB3H/cIWq9utUNflvZ0jyOfl6L4jPMra4PEZKBOT
         7KmORtpyvZDIy5BJ2PbdxDBccYE09TCzFOy03i4JpzelsDH8+Bt+Ec5pY66lYivf9T5C
         PgzGUtzz+UNsC08WW/2Lr++CbDboqUzL0LdLEWtpli/212dTzAJsitTyFitCaTWBPlU/
         cneE6HpZSkxMlRx7sL50HhaOcySafmwaVrDXmk6smUSbLa/cU9deqeaZxoZWe5NVcnfV
         jdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700190; x=1758304990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpqOAHwVgrZXKuBAMgsJ8zJnsSx7G+YDJ7rOJbs/0M4=;
        b=HxBZ3NHr9Aq6NnEhw3b2ddQSLEOddSXl9ZtTGR8PzfohytuzQXR3Tv6avW/IDqRGpr
         X8rLqu+bS44egRgs8EHFcnWf8Tjgm3FHUfQWtn/aaeJLfz6Cob7PsfxMQ0vfNIRW8UHP
         sxmgS02h7PPeSvN3fxvTb0Mff7b9Hv6Iz6rrh9kbtNhp1E8qn2E4uKJlJ3caOrcpgKTc
         PwI79058LKoDzxRJG9jirNTIF6pd4jmMTo2BivgFeobyzK+WHuPXpgs/YiL0eT8EJtOo
         HKggtoVFli34FUNNiol9nI1DhA9aduR7ApGDkMqbxUCPXhtIF1UMb3OWKfSWi7tkRhm+
         sKRQ==
X-Gm-Message-State: AOJu0YxLUwMvRZr1MjedRUrukdQPPr01n7Oqu9jfoUY8NqIjEkbRbglL
	r2jp6jk55HpojjuFej/drNguu0hjNcT+t4NKVCXDnVkoAsy7hBo/ck1GOgP0/Be9dR68qNSjK/B
	RoCCbwW924ykBB7AdP9xIXsyevQHoXnE=
X-Gm-Gg: ASbGncs52X50G46PsgEGkZcS4k7U5/05zFehOYQ+Rqs3y3pwLU0XEdq9eEPDd7T06NM
	MmGrvN2YChDxqv9ArbLDHheHfUu14agqgSvWV9yt+GSJpI3ay/rUSpr0xuBFX53PzS2nqkVm/CY
	7L7kyuBBITccddpV0p12HwspRoFcQvnn0s3ARDXIVU3jCzv8AWd7YLr2ueyJLWpv7TC0dsbWTQ4
	oqBzR/6LH/WXiQOvtYcpmG2qjCouQ==
X-Google-Smtp-Source: AGHT+IGB+2OVfjKvMQh9VmYpZDKvFMUv9Ow4y2xQmfZ0aqTZJyxl4PGYYuS37cGqHIN8pdQ6hSoX93k8x8vrvZSICxw=
X-Received: by 2002:a05:690c:498d:b0:723:a845:e014 with SMTP id
 00721157ae682-730656c51b2mr43158057b3.54.1757700189732; Fri, 12 Sep 2025
 11:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <45640ca0-b3c5-4627-b41a-0b58ff559d2b@gmail.com>
In-Reply-To: <45640ca0-b3c5-4627-b41a-0b58ff559d2b@gmail.com>
From: usharerose <ushareroses@gmail.com>
Date: Sat, 13 Sep 2025 02:02:58 +0800
X-Gm-Features: Ac12FXzyBq0evAVH-ue7FwZn6KML4hPECAHKHj5EMHTZQrSw_QgbY3ydlByU-ek
Message-ID: <CAJKmQvfJVBrmWofs12CAY99HCENASkr1Utjg98TnP7KQ155WNg@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
To: Thomas Guyot <tguyot@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:39=E2=80=AFPM Thomas Guyot <tguyot@gmail.com> wr=
ote:
> To add to the other valid responses, email is something that can be
> validated by hooks server-side to enforce not only proper formatting but
> also valid users are being used, ex. validating against an LDAP directory=
.
>
> This is much better that validating it at the command level (although
> IIRC git-comit does warn about possibly unset/invalid email addresses).
> In addition, unless git starts enforcing stricter rules on the commit
> message format (which would be a breaking change), nothing else can
> prevent someone from constructing commits with invalid emails, so checks
> by git-commit alone can't be strictly enforceable.
>
> Furthermore, imported commits from other SCMs may have odd user
> name/email and it may be desirable to keep then in their original
> formats rather than turning them into fake email addresses.

Thanks for your detailed reply, Thomas. I've understood the scenarios
you mentioned.

My intention behind the original question was not to suggest adding
the feature of validation for email legitimacy, but rather to inquire
about and understand the rationale behind the initial design decision
to forgo strict validation when the user identity feature (user.email)
was implemented.

So, are the use cases above mentioned more of a case of "exploiting a perce=
ived
backdoor that later became justified" or "a thoughtfully made design
decision from the beginning"?
