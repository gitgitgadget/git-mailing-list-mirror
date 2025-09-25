Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA72E9EA7
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782355; cv=none; b=I7HZ6ARP/3DRZWa8FuOn1CoVK0D8gUk6Rb63pXYWMxuho9uKNpP1MWb/6MwduKsgmqDiYrOH7Lt/qMp05p47Zf4z7TZsco0wW/noIWD0eII5psMnbLu7T48cIu7eVV7il8xLJ3vtE9a+LvhalwISOTkJT0IyZIKyAoZ2fwrjSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782355; c=relaxed/simple;
	bh=8jcWLQLDWSkj9kH4Vs7QBwRGgUyFMLB6n9AT917gNBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqpOdZTzRSDQUBGJB2lswzqHqMaQEoDuGDHXD/ehQkFD2cVJyx0nncJDsHptndEG7v6VlMEdsPgyjfpQhAtZDm2yZLA5PPx2EPkelAIkyFDi4wXK+/9slFg5bnTKbVtLVhppv8chdhXRL3fH7xQwzQLUnRQwdgv0YMzWQIe0eNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgp6Fio4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgp6Fio4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so724510a12.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758782352; x=1759387152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jcWLQLDWSkj9kH4Vs7QBwRGgUyFMLB6n9AT917gNBQ=;
        b=Xgp6Fio4Pp9MGV4FuOVm+PC0XmlZOfpCENVyO5VdqXWVkGHZbEVMc8h6QWswovzrqn
         L7GM70usNPIvSuv3T4jMniNlvE12kp0arBFoCLCLMFkfn5mnHlcDFSj/61FwAXW4ECwV
         wUjEN0Hr8nKo7Q7+VwlRPJMKc6zsECmM578ubVjyI5cY8A2bOlX2T1bwgBxB5Aj+At1n
         Q1Wy1xNnNCn7MF4kNBehXQ3nKSlmN0fLw5jSkau6pabtHh330mgblsYtV5W2uRcXf5U5
         E/jylGsLVbwRDzilJkdO8TN4Eu+QngMGuYc3C/tqD4DNfh+Mo9+HQBGmaXZfGIvKPF7f
         N2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782352; x=1759387152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jcWLQLDWSkj9kH4Vs7QBwRGgUyFMLB6n9AT917gNBQ=;
        b=OwCOXvVAcGUwr50njZWZQRzA1Z8IpEkx/FNxZ44RsKekm8WHc+neujyvjhNRjSEet8
         xx63iXBF/GDS/CWdoX5rMtyDe1dyqqbmuhnphPIaa0uSoEUBLs3ECjoyY7QRNw1xVvdJ
         xh5GiijzB6Cj4gSNhAAD7w8h5OfOVqvOn3XNfI8StgGDGE5ObD/34Hp2lznHjrW3tmiD
         kTh17lROFUgY9As4szz47jLs+2lX/abduFdM6I41O7Ohf6Z0sphvdzH/OPUKy8YDjcUq
         qFuRyluQ9lZZdvhfvx9T3wi+2szSpvbiaBRpNAW0+R9koSkS1RFghoCmccqNNSwngjzs
         b4SA==
X-Gm-Message-State: AOJu0YykGVCFcCisa+0qv1Te75Bv9wzxkKFbWzZIGlqRsCqRi3qBBmoU
	svgyfzorokqy7k3JBZ16IwGJZAUEktKMc7IMsAOwAAS2jDkArh5JmD2nnN8WVB5ogJgoBOktd4Y
	PHurKhROryJFRg6XapSMjdDKwxZZ+5mI=
X-Gm-Gg: ASbGncuH7nM7e07H3bsYbnIjpv4kRiSKUvaKve8vXq+egB6/XB1/ejNji9rgxHeDp4Y
	MDOS4IEC2tgXGLjMbdZRAxGiMsPFfOgF5oN1Dev/shTMFtSbbFZMgu6TRyWgEKQFJOF5LE0jPmK
	6I1lyQCcOt90PH1S8ILvcrYDZwGhZQpM26MQavPSuz94TjK1Z2R4f2hiru0dsYvWK/aw+WAkl/l
	LroT8RO0wo6ogzk2bU+roS9hmMD4aFT+MVEOFk=
X-Google-Smtp-Source: AGHT+IHDyRMqytWTldhhIw0SuWxi5mox5F9M8fHnKu/Cy/l+GwD3rQHmWEvuiItSZEVNw1GPbRF1EcGOIZqf5C8UEcs=
X-Received: by 2002:a17:907:9620:b0:b2d:d73:de54 with SMTP id
 a640c23a62f3a-b34b89a41f8mr263803666b.17.1758782351861; Wed, 24 Sep 2025
 23:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
 <CAPSxiM8prcfrnm8ktMG+DqguuNXvZukg=RQVV3oWdU88RNsiZA@mail.gmail.com>
In-Reply-To: <CAPSxiM8prcfrnm8ktMG+DqguuNXvZukg=RQVV3oWdU88RNsiZA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Sep 2025 08:38:59 +0200
X-Gm-Features: AS18NWAXDfZyA2FgTXq_1qu8PSWfyVti646oKdEb5vlWLsPUXzgldE096hOAx1E
Message-ID: <CAP8UFD0ygkJ7v5Q2BwxuqsuAi0-+Htx8Wqa9JXALcVFh2q2_Nw@mail.gmail.com>
Subject: Re: Participating in the Outreachy December 2025 cohort
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

On Sat, Sep 13, 2025 at 5:36=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:

> > As usual, everyone is welcome to participate especially in
> > (co)mentoring, providing microproject and project ideas and sending
> > PRs to update relevant pages on https://git.github.io/.

> I am writing here to indicate my interest in Co-mentoring.

Thanks, this is very much appreciated!

So far it looks like we would co-mentor together a project about
removing global state similar to Ayush's GSoC 2025 project. I hope it
works for you.
