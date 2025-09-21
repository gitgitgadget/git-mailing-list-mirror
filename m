Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C1B672
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758417858; cv=none; b=KXNXqynwCols8pol3q83uM39oSQW++JVB2cbq24m1U8LG0ZuW/EHz9mfbkOvIB8+Iw9OUg5DD+iJPdRAB1xBvh/8cYJZ3S10wbq4tVdIyL5nZj5BUOrK00HgNL782XrsVE9bhAbBzbokhnEmRJ0gzZAjVKAzlXzcckDfi1HojJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758417858; c=relaxed/simple;
	bh=mrRbqoDzAhjPNz2fADq4QYSJ4xMEbmH75pJU06Hq5K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmNiQYY9oJelxpYWLIMHDFYjH8WywWOKEUP7N0wZStKZijEA3FGH85bDqqyHHAX3T1OZqCNgfkeayvFk3k6rMh/k3RjJnoWGIJL6gy8jPDxIvszM/b+WNlCFwke/nzy1pRTXJsw6Qfj3dl6vtC7DT0Dty5ai6eduVfXSp7X0JI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHdGy0/l; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHdGy0/l"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36295d53a10so25361361fa.0
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758417855; x=1759022655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrRbqoDzAhjPNz2fADq4QYSJ4xMEbmH75pJU06Hq5K4=;
        b=cHdGy0/lFIDBaX4V4rKQ9448YcRaZgbLIWH6hKjw6eJM7tHbuJlQw46X9mzEzhnRJj
         U1EwHDJBK58pP/RcOs2yzc7uKsHiyrl30/kTm9sGVVmwjS9sw/758jK1SORYNSTcp0GR
         P40qKxsgxQYVyhl9njMqNr3/oEC4y4SI6HZdOOsjEgJs4iyJdJjwNm5dSdZRoZHx+ciO
         Wgcc9IpeeddfXWXEwmGqX1/0eZI3XEOVE0+3zILF+Lge7uK6o5A65lGpihvfZ+73DZlF
         S9YhYdfnmUauoYEDdSAKb2n51QU6ITkLEN9pOAS0amfM1nNPcJpNDbkCh48pQWN3cDwq
         2kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758417855; x=1759022655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrRbqoDzAhjPNz2fADq4QYSJ4xMEbmH75pJU06Hq5K4=;
        b=KG1dseaw0gDgCLGBQuJw74H7FEoYNuWXFAcJvoqWLWgqx6qzncJRpNFVG+CG0v7VH5
         M9tfgWCTMyw7uzaifq13iEQslQuuvb7GVEiIzL/UfRjSQ6+Xi4pS3y1S08ZLXJVnyORO
         2ETlCdR8l7ItaZRtsqNPiSSy2tY+df23REB4HPks63kUgWPkxlbQGysLa9f7s6OmYdPK
         1kgHvqZ0hfgV/W66pAjfn2pp5XCJibVORf2ueTocCDE5FFYUA6irqdE2KMZ7VWxzhWil
         BGu7GqqdUlEzaK6Kus7q/WyU6PYGn4EXZnSMHDJqrqSvYqGgbKShpDagj6hLp4MjMlhn
         rB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVfU6LWVVkZp2tYnrN9oydp6eGrzm/li6A31aNGMxwKcrYEnjMen1enAP4fbj6X4dJxjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAU9R5ItfoJdEf1r1NmleAMHJWqxMceMKHLL8kUX48K9d6q65x
	Wahm77CGMFMT1eXlOCdYRUKLXU8Z+A8vsdCTpWijRnyYtvyqAvc3jbGWMbDcYWlVwDzsVMHKHsr
	jX/VZ0LJ8QBYVEfeaSgj2cbp2Yh2gs4Q=
X-Gm-Gg: ASbGncuMfAl7xYpyP2ZVPY4vm3sBDWZYkkMBo8fgj6MgbCgkbI1OL3DapSlE3ACaUab
	uZfgt7yV8Mq8786KKu/c6646ElO+R+Jr3tGz2E3kJd9diZgTqbXt6vntlT49v/kI5o/6//4HLtY
	zhUKRSDWjYlhyqLoQc3Nc3rv8YcQltqJSU4UesJ/OU8I/e+SbsljqxVOrSn3Gxc/fMvCSRAgkC1
	PTgp+oa52dCpKjy+G4=
X-Google-Smtp-Source: AGHT+IE/cemX/8YJ4w84xE8Jnnf6q4/OC0UV45Vkrc+VLj4cft/jtwyUcYl/J56/LQy6SIvg1+5VfnvB2kn9nCbfzn4=
X-Received: by 2002:a05:651c:25d8:10b0:34c:8b16:f305 with SMTP id
 38308e7fff4ca-36413f12954mr26831511fa.5.1758417855008; Sat, 20 Sep 2025
 18:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
 <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
 <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
 <002c01dc2a95$400315f0$c00941d0$@nexbridge.com>
In-Reply-To: <002c01dc2a95$400315f0$c00941d0$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 20 Sep 2025 19:24:03 -0600
X-Gm-Features: AS18NWBjcDZOpdRchTtpqR8NzgQ4bmrfGkGBfDinw7fNyURs2s8yG2dYxgaJX3o
Message-ID: <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: rsbecker@nexbridge.com
Cc: CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com, 
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:15=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >What I meant was: Is there a compiler that can be compiled to both NonSt=
op and
> >Linux. What is the name of the C++17 compiler that you use on NonStop? I=
s there a
> >Linux or Windows cross compiler that can target NonStop?
>
> We have c99, c11, c17. The only Windows cross compiler is c99, but that r=
equires
> a license from HPE that I cannot provide. There are not non-commercial co=
mpilers
> available that can be used to cross compile. Also, standard configure pro=
cessing
> does not work on Windows for NonStop.

If C/C++ can be cross compiled from Windows to a NonStop target, then
why does Git need to run on NonStop itself? Why couldn't you use Git
on Windows and then copy the compiled executables to your NonStop
targets?
