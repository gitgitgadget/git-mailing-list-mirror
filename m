Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F661917F0
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569819; cv=none; b=TnD6O2xBCCrI/JqFPmlXNHH6tkCfCKpN0ulMLYsYw9BaiHTErXJIiNc2t39PDTHzYvH3Mzr+3LUppwqJzon4HY8abLnFgpyRXAqW8v1zeoOgAxcvrqCMAoce7OknBAQcfx9JnyznZM8lFjcOcbGhZQsfeNOXG53dlQAOD0uXC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569819; c=relaxed/simple;
	bh=Yy/zHWk5YRxVTDFCSRZ1g9uK+rDsZbscJ6iCWOAKOZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYjV4kGrmIUnxNt0RMxARuVjTS0CBdHbkXnCnquKIm+zDSApaVRjHVegRkcs/i96IhS2XkX7Wztf8O2PONgdsAiBf+hIMQTbBTzcGuIR4HBDINeEhmVtxcbNTq4yNSHXpznjKPgrYPv5tuihsE++iVa6rkjprV/6ZyQmpwOhOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyngvsQ6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyngvsQ6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45619d70c72so12232045e9.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752569816; x=1753174616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq1ngP+unwGyLtqqtX4ED7lWrMMEBUPMT4OmaXH5WyA=;
        b=SyngvsQ6dWSjvoNZuCpTHxtFc09t0Jb1H+9eTq49bt9yWEhRrpcEbixmWK8l3sosFv
         0HyEpd2bq9SsZaM9FOSupsznp3pTNsRZMJICsPNZAGAm5rmuUUNi2oNszuzZwEK2Fidl
         QbDsyg/J9xnJ/veVl+jFyfagy1zO2WrUXZLvEH40VPHfN8ffJARjgLkMyMrJaGW2IDcq
         gwC44bjnQrpT+AhTwdnV0TwUplxfVQFkfFWjVR+KXy3fVvP1a5tjUsbJ0hvsFYjQ2z8k
         YXyEC32K0YicSuRzZ0IHN4fagbSiIXGBj9s1rxkseVQCcYsE+QpvJbH3Fr3terhhrkFL
         hg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569816; x=1753174616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq1ngP+unwGyLtqqtX4ED7lWrMMEBUPMT4OmaXH5WyA=;
        b=BOLgnBX9kwhG1RYDdgTPh0CHZ59kpZHXsMAbG6ijU7Spsw4DFC5EuAunDe4VaQy/fc
         9MJpz3qr1ZDuRrFZ1+CJb0a0MF2HADn0QCxQqBdwktfTHoFKR0RWcXJUmK0lGijfDD1Y
         hmOC40Lbsd68ChhQoom7W/3ITYYPGB/FipQYvO44vSylK8UXpM38RhmnfYjlCfTfeNM7
         6IM7/K7J4NHK41P+sF4TtqfX+8x0wRiwPmutYbE36nuyntzczOcUHlJ9O4BjS+PPrApD
         UAmjQPkH9IuiX2FTT0mTDuCuqYqC/EIgd+iBNC1Ksad/NnET0QihhEv3k0G45n12EZnf
         snUg==
X-Forwarded-Encrypted: i=1; AJvYcCVX2AYtOfjGPexBPOK/niKFx0PVCsuYwgolD7Qc8hbHIMFfgWxd5mIjhZ6JLcAx7CqmCyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCHlw3Og4S2PVL057XbWU8QXgdMUtfDAYlzF2EhLrgLZxf9ba
	rK5o7/QQ/cMkh0kendor8Bmn7cIFt58NS7uIhXkD9xdKWiKqPk3tbQvyCdeAY0ACvbEc7celdiO
	z2xOryTYTT0g5M/mKSqIXqkKyuyEfdIaUig==
X-Gm-Gg: ASbGncseebfDeo0Ge7TmKKjfN9WbdPks7UIWlriN9r+piEZh7yJbrSnSQzvg3nYRscY
	eNbYuh9i14vrlQCrPKjfvZW3/xw2yLzXaj6KF4Y6sURHP2eL/YqhE8KTIb5Qrl2RL103bpFa0FB
	MpHe/g34cu+ENORaoCFVCilNogqkDu8MzzXrxHUHIVaRBHqo8l5KSk3cROS7UAaGI58WIRY0W+J
	MFe+yTVXWjs2rj8eE0CD1e2UaapARAQJbK3PcoUMh7H6smbTg==
X-Google-Smtp-Source: AGHT+IHLs7Kh96i1s6iWkK/BMTKUfH7WMoKZqVxNxziVuAeB5OdSzdndc1ASDcTr1OHRxx4FkI1lPNnOll2afhg9MNg=
X-Received: by 2002:a05:6000:1a8b:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3b60950341cmr1851526f8f.0.1752569815949; Tue, 15 Jul 2025
 01:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713122341.17976-1-carenas@gmail.com> <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org> <aHYVdMii_rP5-ywa@pks.im>
In-Reply-To: <aHYVdMii_rP5-ywa@pks.im>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 15 Jul 2025 01:56:44 -0700
X-Gm-Features: Ac12FXzHm4yW6HzIGnRfBXMZQo4ILal0pnplesHSXBXpWSx9rtx7XLkNQTIGKEU
Message-ID: <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org, gitster@pobox.com, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Mon, Jul 14, 2025 at 09:55:27PM -0400, Eli Schwartz wrote:
> > On 7/13/25 1:48 PM, Carlo Marcelo Arenas B
> > > diff --git a/meson_options.txt b/meson_options.txt
> > > index e7f768df24..f63ff32556 100644
> > > --- a/meson_options.txt
> > > +++ b/meson_options.txt
> > > @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
> > >    description: 'Build Git web interface. Requires Perl.')
> > >  option('iconv', type: 'feature', value: 'auto',
> > >    description: 'Support reencoding strings with different encodings.=
')
> > > -option('pcre2', type: 'feature', value: 'enabled',
> > > +option('pcre2', type: 'feature', value: 'auto',
> >
> > This part is fine. We shouldn't default-fail if it isn't found, when we
> > can't expect it to be universally available.
>
> Agreed. I guess tha only reason why I picked "enabled" here is because
> we also got a wrapper in "subprojects/". But with this new workaround in
> place I agree that it is sensible to switch to "auto".

AFAIK the "wrapper" fallback still kicks in when the feature is "auto"

Carlo
