Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC72134BF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377629; cv=none; b=s7IyDUjkb13YaiZuHgRVmUvw++stFe3Ga0AnpQv98K5Qtya1s+4sY6hEukOnXqG15bvwbSheCSxx5of+s3wEDhl8idB9jh0dg5J6KTyU56oIPgTacridMrNYNRRohrBfIbvu2Ny3AMPf/7NX9XeQak96o5pUUYi2lt5l0IOZV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377629; c=relaxed/simple;
	bh=C/BaTE2k/xBKxIBtuDdpADuCexcQS1117IYMOFRyFFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhUNcFIcyi1aMPNBBLtOtOPYXRpZEriOJUkZfev9qcaK+rRKVygpaBd3Q5r1meWRB8GZgvCDOZ8wqQQuvOzbm2uP6EuxIUjRXRMHdNRmT6GaSN0otc/OYmSqHLV6UwW4SVoxRztMMBQmTF8vLNRDtm7uNf1c++7JGjqz064g56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNwvmukc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNwvmukc"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617f8a59a24so36241497b3.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714377627; x=1714982427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJiGnCjBrw+bvo+P4fSnumCw9Y1+Ed3uytwFIjRKBXE=;
        b=LNwvmukck6d6CZ7EhYpcwI36RPJ7DheWW5mnWywlT68TgvPqkB6FRNUli6pvIqdfVf
         YMfUH30+4MzJx//+9sSimLrtOCt7/4cJ5bUdIrA6zX9y9Ho61beH9BTV13koyU9npS6H
         qreuub1eET1Nj8H66lj1zI5g0Tq42GDDxWpB9SKdJke0mWD3Z7P12UGQDuIHLd73LGtS
         odceXPtv0WRj1E2azcmNqNhKVl5jrOQcOirhpT5nMvQY3jW/dUjO96SkG0Ef+HXvh1O9
         gYewwoEMJxGqiti5tbANi7/L3PZk+Pt0xTEQkMk62TrC44/1jIaMBS+jUcHQYWU4/ww/
         u1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377627; x=1714982427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJiGnCjBrw+bvo+P4fSnumCw9Y1+Ed3uytwFIjRKBXE=;
        b=D03Im3jpY3Rit8lCfCQi5r82+Rb8YsnKYtZINRV9tL8mwFyhZBlJtvmQjJVXGxN1Rx
         kFovLO4ZZEdRB7hO1KCq1rpkDhch6MaH/3doD2NVxW1SvrNHpeAvtgC5bj1/5SIYQozs
         ICh2Ds3idX4N755KZMCBff8C7RHGBq/LBWaY1QO+tOzhO/tdGeMFUl42kUmQLvLn8BBn
         HVNfylDbVZYmNAy+yUD7AeN5LKHHKkSwFemFI2E3hVtvmto7Ff5Moeciaey37VEfbp4W
         QaJe/HuujjikMFfasxFfVSdmPoTZ1jssKjyyDGOyKdWGfJkLlvEP6Tc7vncpb/jrgQ1I
         fDBA==
X-Gm-Message-State: AOJu0YzFwSNEoO51/+otxsrUasG0oMSQzkZPqB/YT7U600ed9Wx8elk7
	ek4NybGM3qUf3kJWW3vuihcKt1CAQjkwaDduzV7ONdCQsffllmUMvwYthTyUOPS6Q4I0hPwq4Lg
	XQtIOfooxek58FUaOtWmEH5pIQdU=
X-Google-Smtp-Source: AGHT+IG4Rfr+gPpfAY5F8bZValNLpqfMujHj7GJane9BnUaE3I32KQrZ84i4l6YbQevLmCMRDoa0lvTJi9SXZZo0Wn4=
X-Received: by 2002:a05:690c:6ac9:b0:61b:bd7f:c62b with SMTP id
 ij9-20020a05690c6ac900b0061bbd7fc62bmr6230855ywb.2.1714377627539; Mon, 29 Apr
 2024 01:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415072226.15005-1-worldhello.net@gmail.com> <xmqqa5ld2b5i.fsf@gitster.g>
In-Reply-To: <xmqqa5ld2b5i.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 29 Apr 2024 16:00:16 +0800
Message-ID: <CANYiYbHwrthiA-5HBT1tMrwvbw2oniDEsYsUALgnEkOMoJ6OjA@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.45.0
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Alexander Shopov <ash@kambanaria.org>, 
	Jordi Mas <jmas@softcatala.org>, Ralf Thielow <ralf.thielow@gmail.com>, 
	Jimmy Angelakos <vyruss@hellug.gr>, =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>, Gwan-gyeong Mun <elongbug@gmail.com>, 
	Arusekk <arek_koz@o2.pl>, Dimitriy Ryazantcev <DJm00n@mail.ru>, Peter Krefting <peter@softwolves.pp.se>, 
	Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Git l10n discussion group <git-l10n@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 9:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Before the upcoming release of v2.45.0-rc0, let's start a new round of
> > l10n for Git 2.45.0.  This time there are 78 updated messages need to b=
e
> > translated since the last release. Please send your pull request to the
> > l10n coordinator's repository below before this update window closes on
> > Sun, 28 Apr 2024.
>
> In whose timezone and at what time???

Last night (CST time) I discovered that there are still some languages
that have not completed the translation of the two additional messages
introduced by 2.45.0-rc1, so I decided to wait. Today I start my
vacation trip from Beijing to my hometown Harbin. I just got home in
the afternoon and I have sent a email to the list with all well cooked
pull requests merged.
