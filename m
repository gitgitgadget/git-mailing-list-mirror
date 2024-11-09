Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE8149C52
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164541; cv=none; b=QjYXmFPL7g8ovW9vFOMOvkZMsHVy+ocKpILmCc59VY2f/3qTh8D7ciusAgmu7jJUw1N4Gr9fd4wyAT+kaYMXgqt6piq2Gz+QtiMbU818skIjci0cXt06X9XGHRgIpoCoFjUk1tE/8d/hbN/4lJHMLGoC0hmjIGqAEKdTDajhsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164541; c=relaxed/simple;
	bh=Z1FAR9SQeu7+BDSxFUVC7hkhVrhgPwH+FFfqVBciPYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALUi/l/rA5wEM/mthwMbvmQL6lnZE2tctpaqUeXLv7CU0g5Jh1N9Imk7QmI5osW0zpYFycwZABgb8X068LhVhVnQOfd8p7w/2DTxMH859hNTle/4QQdUpVHffmAvxNTyQbtgI//A53od0C2YXbDFqrGBIMjwtoU41Ra52oudsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGXUSmG1; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGXUSmG1"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ee3c2e79aaso1444771eaf.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731164539; x=1731769339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/62hGSnMoqW/TZ5qSFnE//5Ic8qh4O1PIud1AL93rk=;
        b=UGXUSmG1WpwZrm+pXNZS6qvtFO2ISbgqfjtqq5biCvaLLgtdV5AF+yv4WCh+A3sFzi
         DZAzzVzWn0ucUeTotYnNLD66MiAcknRbhUAkNJnkeio4D0079R/P9nPfoR4YxMYDInmY
         URq8Dw74o8CGisnNPx7nbb30+h6YNDluFLEBzVNyCAbDJmBREOo15GQc/ROEla5YKVfk
         tdhfzvaI1DOdsUite8nWq3qfC7uCVe8FcHvOJI4aGoek5tTPKR8HlK+9qs7hDvxO9ahV
         6T0y/j3iIevlWtkJFVOH/jlRn/JDF0IIgVPVSVlbzpbMRGWKJQW/MuTbxc5ci6QIowfu
         84ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731164539; x=1731769339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/62hGSnMoqW/TZ5qSFnE//5Ic8qh4O1PIud1AL93rk=;
        b=T99RYK5tsoPvCTnYi012CF1Tga1GVH9MfRymJNR9Uw/H4Hm+QqHLJYVIIk1OTlGRku
         wfQZGdr02l2qQGRrWnaGSOq4oPI54YQy2oMmd6H87RVkoqqtRLYH5SmRlsRFE67/hXlF
         U+BAlTf061t0+hIupqzgb5W+ifPyrvI7OzpGFDwrBAQGOFYrFmUOe/dapReKvyucSvY9
         VxoM8foZ/K8L7W5av8TWj4fvDTBi/JOgzEpRiRsAkM6YLY2An9fArZVhuKy39iNsFHDU
         nTXZd1rdNmIpfHpTHLcULvIQ9dzGsTXL1e6O+T4GK7Gs4IogCu5s+3YgWRNyjZjVb0/e
         T7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvPGo4jqzhHyIHQy4MB+rrb0dmM0gzIfBXrMOlU7mgapSGajmgSaXMm0F8klWUs5UgV9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ka1IR0Mn/v7Z030dZ4J5ThIkFHo82jjFAeib3CD3TzIEREV3
	kR/5IlNgR4gaccTKKaJMwA8zTi89Jy5tP62SfZuzdybFcO6G7nKdcbFOrQZm05hbJMiLGBkbdzJ
	h6MGspJHHbGswTVhxBi+Z9uZkpkryuyom
X-Google-Smtp-Source: AGHT+IGYMKB/KyKQAflGzdoTSN6bgmQqYeV8ixdMpRENGXbpUqAzasP5QEu+mG2331tfWgfGuhaAAQMAuN5pTg0A+ps=
X-Received: by 2002:a05:6358:2741:b0:1c3:98de:facf with SMTP id
 e5c5f4694b2df-1c641ece5e0mr410148955d.13.1731164538922; Sat, 09 Nov 2024
 07:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com> <87msi85vc9.fsf@igel.home>
In-Reply-To: <87msi85vc9.fsf@igel.home>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 10:02:08 -0500
Message-ID: <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 9:35=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>
> On Nov 09 2024, Christian Couder wrote:
>
> > Yeah, not sure why it doesn't work while you have it.
>
> It's probably of the wrong architecture.
Hi Andreas,
Thanks for responding.
It was actually the wrong Architecture. Thank you. Just curious, any
reason why the 32bit was present instead of the
64bit ?, I will normally think the operating system should ship 64bit
by default.

Usman Akinyemi.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
