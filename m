Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62D70808
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767254923; cv=none; b=NSsoIfewkB8LYz1YefM0FlMwRAkecrfxwNPCnqaXp3mbjXdyT7GrQcaj9al1mR6cSWbHEAVcnuCzmZz8enpyBAhy8IzHa9qNbkNsX1v1X3Ig39+A518mrQKkZ3+0eWbZ/SpeNxdxUPKoZ0NwpxxjX4P3Pli/uEU01kMVOyiohCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767254923; c=relaxed/simple;
	bh=+FvlftOWwEf28w+4vb2TG0bSvMk1OSYDPh/zImBt5kk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R4jfel7SIOAl3K4AQalpbesumHWK+C2NetcHmGq64SRU8U45LfW6zqUEd2x0SXtgMO0H+ImHcCGxUyugjTfMlz4EauWy2czMvmMbtWDhIiBnzr3l+Mml5gAzZQaNT0VNGVyZXmm1uliZ7jI1k06qt/2DDuZK3qRUsOtrVrNEb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq0CPlDL; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq0CPlDL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6466d8fd383so8778015d50.2
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767254921; x=1767859721; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FvlftOWwEf28w+4vb2TG0bSvMk1OSYDPh/zImBt5kk=;
        b=Hq0CPlDLTixMzQukanbY2nud/IzHxPPxwXVgfovFH9oNhMPzIHxvj7IZdY/uTPgZAL
         gJu4JCQGNRQYAzxiF5GAuoJSg9gRfoPyYENJ/nApggl1tqf/5Ae2DdHjTCmRIMeKG2/k
         OgbkOESTnECcY6x8/3a1TcCNRuHBBKeNKwVV6E1bYWDesEL2hVqn85hdp431HdItb7Z6
         nfmBC8/Vt2dTmzAiZ1leax8T6yAnauKSt27cOnAfS0u0/MLMxn6kquzty2YO8IKxC4Iq
         77Ma+NiKGJOJ2/YtPbp+VXPLGf6FWSs17XNRujND4+7K0Rb/jb9GiakfoXqEC31U3B+z
         QbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767254921; x=1767859721;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FvlftOWwEf28w+4vb2TG0bSvMk1OSYDPh/zImBt5kk=;
        b=BMP4ZQwKDs3QhYkiyBwURS9MTok4GeUvZRp2GvQxfFlx4wfJTu2eUKxw6n3GT2RqFZ
         gH4Gcj1ymQIkJ+/QVfsIUGsbByGAhoMKHCvEzt4SioPMKeMxFQYWDp9Sl2/UCa22nL29
         Lza/ARAicCYLzwtq167PjimZZEERVPliGxTQ/N7zGVJsye5ZMaqKOv1XagirwawEU5rN
         0GodfjOb5l+BVEVoAYKfit1GP0JpZwlhdlHaVSRl3kO2V6rmi8Zzovx2PIPhd5AT4YFa
         Lc9nMpUvP8eXj1WjajfLufunSCHlEAzFog9MJYrfP2VyDZjRH7Tu+9iELl8483q+G25o
         VkKA==
X-Gm-Message-State: AOJu0YwXbNHOMwAo9z0mrBQAYYbgCyv9QhMYBiI8rVo6taYXwcx0MTS4
	XSdGqb4REY2znfukk4ECAe5X+bDAHdxEpY6H0IRYhcSbCbvCso7SGYfeOiY/9v0yHfhYwUw4ySt
	xulFib58h9xtCHUrkXjAD6KpE4CCD3a/gs9KTIRA=
X-Gm-Gg: AY/fxX4k/29U8wtZenviz51hX33GrqlGK0hf7a0FhMcQvede5axS/D85cg2nrN7r42x
	U7cd5fP6ezrNnHxVtjvUXNsCiwrX/j9o+/yW7fEYV8ocr9aKeg0PE0UIXIpwcZx4EduUp/JM0uZ
	mA7nSwXbkZdmMLzj5iBBc35MP34QeXFc7TCypMiQWKc+TaVI8QVBkVo4pH8CwBoT99QAHwGjluj
	Ev0makcA+KE1yuAOG2NUhYWN3Ugr3xGkacxPFLx+pms67Dlgubf+JNC5VMWxMyGpqs=
X-Google-Smtp-Source: AGHT+IHcFb4Y1slwCnlB/YhA1zIsfybGOzP9PB8R9zk1Y+KmS2qCb2jmDmZU4Uxo6qffbQcBFpS/7EHSkuBjxpIOV1I=
X-Received: by 2002:a53:b484:0:b0:645:5aed:324f with SMTP id
 956f58d0204a3-6466a913857mr20995930d50.80.1767254920934; Thu, 01 Jan 2026
 00:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 1 Jan 2026 13:38:29 +0530
X-Gm-Features: AQt7F2qL05B8VJo_O42vOgVHVVmSvKqQ2J9Yg82DgHWuYVgvSlSIhrdGiaxfGFg
Message-ID: <CALE2CrQDyN6XcFgkMREmyvywqpuO1_+gt1oehJ8qX3i6b9q1hw@mail.gmail.com>
Subject: [GSoC] Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I=E2=80=99m Pushkar Singh from India, and I=E2=80=99m interested in contrib=
uting to
Git as part of GSoC.

So far, I=E2=80=99ve built Git from source, run the test suite, and started
exploring =E2=80=9CHacking Git=E2=80=9D along with the contribution documen=
tation.
I=E2=80=99ve also been following discussions on this mailing list to
understand the workflow and review culture.

Right now, I=E2=80=99m focusing on the test suite and documentation areas t=
o
get comfortable, and I plan to start making small, meaningful
contributions as I learn more about the codebase.

I look forward to learning from you all and contributing to Git.

Thanks,
Pushkar Singh
