Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517933B6D2
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438103; cv=none; b=q4DpUilvOU2bnXTkxXObzMzyRh7oN3YzIpCR9+Gy9rYGHK34BZJbHVT2I34a5xHyRjcFVjhGMX1PtJXluBUJ6L5X4aTX/jgDwtMpkTR+GwDuzRvWzP6umENymYyzPlgYSXkZ3fKRUNWbtIidRfz86tZ4LbOuBh8T59/6pHtZ26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438103; c=relaxed/simple;
	bh=jYCX40wNRKi+T0G3ATvbuD8M2lN+cE7DDvJMulg+ecU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HumGFPPLESJQZWuC5O2iyVQgmnl28dRjbfLWXc7fE0Ly6P/k1yetL36EeRToi16P9ibStdeWoepdx9/HSiCN8b8hptNkk0IlqE504QigLNY7hRl/pLpk5jwfktKSPpjsf4LgMWQB4Ym/VXqI/vqRYwjAv4L7Fvj1I50Dffd902w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXIQxMr3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXIQxMr3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78665368a5cso10209537b3.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762438101; x=1763042901; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUoUyPLZBwrPO0VAdvrN5zRMmv9EC+Pmd/AMpovYPJo=;
        b=jXIQxMr3ZoOCSsQSx94jIQVP4YEostJxDCawsMP1EKWNOKrFCxBCABKTl6Qwc08lZD
         QN+icBCxdaf4dg9yOQq9nF01HyPFC2bIzJEO65MviRqFnbgKAIZzq/GqKMXgy2JJZbzQ
         ePenvT2M4uV+FbpSIuBFgK0Jz7J02uHnsr9h2R6XgT2I2gysH1O4qqMvGWc3tG0KiE55
         gEJ31mh/qH0Cu2SVDxlWypIKYnUpIU5FCTYa+B/v7JLbEFOEhUl+ND+daA9HZCz7vblW
         0KxXkJvTJtg90gR8uY0E/mGqzf6QRJdaFiEenZjgsvOt7+oaQE2kVsop5t/mJgCxLvdy
         1ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438101; x=1763042901;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUoUyPLZBwrPO0VAdvrN5zRMmv9EC+Pmd/AMpovYPJo=;
        b=UmswWToqeDE03QDa2hjgIUvrnrh3I6VxzuzX2JbSrMWborkquiPyWkiaqBSOqW9bUy
         uHF44PKe/rPEsRXYXdC2BfvmKcW/AJzhn6yPeE3RNwvun6E/wyBc7nwnwk5jldYZDZNQ
         meAjdrdGbqLqWNU97ioD0JGiFB1zxOKBhkIsZf0PAc5Hy8gJNLqfcEdjZSaI1CU9FSpd
         TNryDBHLqL/r2gmlPqd+FYG43UDBnEbs0WZuIGUuE0yUp79Pq3mqoyIDr1L8AYrXUNth
         QAoRDSR6xSK5E8wWnZ1Xj+iOjCSiRBEKTTY0T1aOuNgUZ2zJ0kChsnBUyiw/0a0oq45k
         4kbA==
X-Forwarded-Encrypted: i=1; AJvYcCXlAuBMR6LhqIDbHhBYU2/XEHb7hKSIiG+mcSMlNHSivlCzer9JNMnYqqVz5q8TSRC2j3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IjYt3fnw55Wm7kKvOr0WdpSADuAzElcG8BcAkldlNAh9AIQa
	sFX8+KtmqhnUgYX7pL6b1PqpQtBU1RGJ+HNNWIVh/tiJvwyxHup5kq8T
X-Gm-Gg: ASbGncsea0EyXakdHJL2cXTUU+v3MfOi4+L+CQ/GdVqVyzhgG+hrcCSBghzVJuOz/Ld
	MYRQGoFpKko81lmfkGhvKhiFuanVOAl0usQB8MYoDS1yQBy+kZiVpQ/FnO0ghPUfdr5I1h2Z7Zw
	ao7Cno+Mn+MYdRGNrzYndqInWFgIq+4U5Dk3rHuO7+xZkqdOg6Sdn9KjXkbeD5mRm9mndSVzlQ2
	k7MazCWyzcUFvXtiG/UJfYJ0MrS2g1/ESmSL08eu2xLSY5I25L5tOSAGtAc/153Yw6/b2W4KipR
	ChjqtUS1n7zvzueSB9vyZx0xtiiVq0g+vDWiq2A0LGv1fk1L4XdNUf8uJXaJFzoEBk/I2MJyrkL
	6+imvZzFNWzl82+9eNb40eA55eP5g2tJZ3ui+THuHl8rmNbHacsNcusaANxWKQkr9msb0w46UBX
	vNNhVHK6asBNS+shIaVI1RFJGVkvbm
X-Google-Smtp-Source: AGHT+IFXGYBhdon9MZDpbhD9kqQpgBbjDjBTCOrUaR2MBwmt1xyvDiFVsl/pGTVmK6h/gMPh7OgjQw==
X-Received: by 2002:a05:690c:888:b0:77f:952b:951d with SMTP id 00721157ae682-786a41acb5amr73865447b3.34.1762438100971;
        Thu, 06 Nov 2025 06:08:20 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:81d7:5975:fbe7:7159])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13df6d5sm8451677b3.14.2025.11.06.06.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:08:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
Date: Thu, 6 Nov 2025 09:08:10 -0500
Message-Id: <0930DCB8-D545-4043-87F9-4359EA5351D9@gmail.com>
References: <aQxTZNYKKAsmL9Sg@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <aQxTZNYKKAsmL9Sg@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 6 nov. 2025 =C3=A0 02:51, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Tue, Nov 04, 2025 at 08:58:29AM -0500, D. Ben Knoble wrote:
>> Makefile-based builds can configure Git's internal HTML_PATH by defining
>> htmldir, which is useful for packagers that put documentation in
>> different locations. Gentoo, for example, uses version-suffixed
>> directories like ${prefix}/share/doc/git-2.51 and puts the HTML
>> documentation in an 'html' subdirectory of the same.
>>=20
>> Propagate the same configuration knob to Meson-based builds so that
>> "git --html-path" on such systems can be configured to output the
>> correct directory.
>=20
> Makes sense.
>=20
>> diff --git a/Documentation/meson.build b/Documentation/meson.build
>> index 9d24f2da54..c00c9fe7f4 100644
>> --- a/Documentation/meson.build
>> +++ b/Documentation/meson.build
>=20
> All of the conversions look sensible to me.
>=20
>> diff --git a/meson.build b/meson.build
>> index 2b763f7c53..1f95a06edb 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -768,13 +768,18 @@ if test_output_directory =3D=3D ''
>>   test_output_directory =3D meson.project_build_root() / 'test-output'
>> endif
>>=20
>> +htmldir =3D get_option('htmldir')
>> +if htmldir =3D=3D ''
>> +  htmldir =3D get_option('datadir') / 'doc/git-doc'
>> +endif
>=20
> This retains the status quo, good.
>=20
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 143dee9237..13d421c067 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -1,6 +1,8 @@
>> # Configuration for Git installation
>> option('perllibdir', type: 'string', value: '',
>>   description: 'Directory to install perl lib to. Defaults to <datadir>/p=
erl5')
>> +option('htmldir', type: 'string', value: '',
>> +  description: 'Directory to install HTML docs to. Defaults to <datadir>=
/doc/git-doc')
>=20
> Tiny nit: let's keep these options ordered lexicographically.

Can do. Shall I send v2, Junio?

>=20
> Other than that the patch looks good to me, thanks!
>=20
> Patrick

Thank you!=
