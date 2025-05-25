Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73222AF0E
	for <git@vger.kernel.org>; Sun, 25 May 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199925; cv=none; b=MfpXRPOYncdBvn2AfuqM2nhUXp4OYa2LI2xQ8/l3xPvH2Jua7skGDA9SQGgKK2jj5Xv1Ua2VFefCzsF3f828rBj+NxquHl4iNRpzJP8DhVRNhRzOyjlHo6/J7Q5j6DKMyK91nzuMYKaBOTDG/o/WJflHPteH09ieRkK/xz5sxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199925; c=relaxed/simple;
	bh=ymdyULdT3oDBhoIAp2pxHunwcN4VUVipFRoriELqwZo=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=bfuvVOYyfz5q6+g70pK4+WuYQ7La1Xf9iLelv3ER7hmgpLhaWoRYRSoprkH0iBI37wpogdeHmLDA6lrmFh5A+tAw4xgvQyjRn9FVGJawePYJKhhre1cOf0E/pLTRF8I08XPeFHWe3BnDEGT15Wa9UEnpWkyJmjLGNIdzKWHnD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApAQZm2l; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApAQZm2l"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7da099de49so490578276.2
        for <git@vger.kernel.org>; Sun, 25 May 2025 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748199922; x=1748804722; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=167yvEuQUezQYVi3Kl14Lk2IhUz0FLWipABXsAPcPA8=;
        b=ApAQZm2lUo35VqjdM3orjUVGWUVZ0Kc2Hq/8VuSjS9ngepj1XJmKuNtvWOMfQLfm+B
         FFpZONe4jlMpCucH763K3UwMIoYRWDktzcNDa3m3nDm9hnlEImebp5hDEvLYiRMYTqkx
         NjnxQv8qKf3CvAK+Vu1Uf4K8AcFFtGsm1FqtBGs72Tvf4/JXqvGoO9GOJq510ztddVRc
         9jF3GOAXfxXoxaxLGONPMx0/itGt6uGgYcFkHymyUEc4JPmGtCtez8sgcUsi6a56Gs3+
         UiUvbyLAyAFkB2DaYqMfIA9dlB7fI6hzPCpp38j1ROAwx8HCUH+wdkXRsZlF/DwOxNXN
         oJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748199922; x=1748804722;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=167yvEuQUezQYVi3Kl14Lk2IhUz0FLWipABXsAPcPA8=;
        b=ng8BbcZ/VBXl8JeOO4Xu4kuB8Z84rAUM3KYzPgbViQn5EzLMqEkuQLP/nmy6sbGWOX
         7CgsOhNZLdAlJZN84lJh4KVj4j72YK0F0/+emKhmH0C8s9OK4pGbMQomi7R39Cbuml64
         /1yxz0gr5Fkb/hnE8iylMc44Ha4Cy+YUyb9u58Us43uzu5972i8L1oELMUMwg5MDUt1n
         PLfcUuqAcdlmjI40na2ClygXwxV41yCYHn3cCC4iLsO8v3Lup9g+duIWWATlppCqNEIE
         gPIMrB8+qUWJzMZjGR9Yx5sfM4ndRNmbJLF+g7pMPVdSQCG1Ynm2jilnagSGS0EPre3X
         3l6w==
X-Forwarded-Encrypted: i=1; AJvYcCVv+D6bVseuY1+oKCcNhtG9u33fovXVvQ0t/64ncEP40Aldgbynq9gBTo/ngIqif8xPdac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrgiUgeH4KaJFMSZNRKcppDU9MOgUwMcPnQ5zB/5FnQ9SN0HB
	MjSt68WDXc9F7LhSVVmBAQ6GCyV6ny7UcEvilM9G+gwgLKPLJMs+qusp
X-Gm-Gg: ASbGnctjG+QWvFxFePnbcUHspPywrcoT/YKaWnYMqUXLmhBSsrM4qmg5UxhFl9bxypS
	hD/bgBgfk9H4wC1yEUZeEQBxoPAMWK8C78DQqPP2GWvfxbKoRRcLBKTFIACajpWOHgJqK5a3evc
	fo1iHQIHtkWLd/h+I1m+4kKWCDxm5PXvMefUbGfvZdIYuCD7RdckCVEeaIukQZqXrdEb7uy4Qkb
	N3URxcgvjwScG3sqDme6Csrd5/wyDZhU1MdlDFlPvoWuevwy41iZeq5wFWcPfRKUG8FTINcFVez
	IXrdKsqriuN9GE5zira7ZMCIldLmCdKkYMHWh01wn87PN4nMgnZW4AOiI5OXOLjO1e3h5/wS5lq
	CaHIEUN8S
X-Google-Smtp-Source: AGHT+IHI4Q1dNiCeY0HNkShyOTJR33gvEPIzHumNdMm6gYKbaQ/1vvBHaZA3rDok1/pofPstvWod8Q==
X-Received: by 2002:a05:6902:1104:b0:e7d:b52c:663a with SMTP id 3f1490d57ef6-e7db52c6a23mr46115276.0.1748199922327;
        Sun, 25 May 2025 12:05:22 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:8083:23b:95d4:228d:ebc4:fa8d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7da4698737sm458499276.45.2025.05.25.12.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 12:05:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <adityagarg1208@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/2] send-email: fix bug resulting in increased message number if a message is edited
Message-Id: <32479CC9-3C03-4F3F-A57B-88A3D43305CA@gmail.com>
Date: Mon, 26 May 2025 00:35:07 +0530
Cc: Eric Sunshine <sunshine@sunshineco.com>, sandals@crustytoothpaste.net,
 julian@swagemakers.org, Zi Yao <ziyao@disroot.org>,
 Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Aditya Garg <gargaditya08@live.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPad Mail (22F76)

=EF=BB=BF

On 26/05/25 12:19 am, Kristoffer Haugsbakk wrote:
> Hi
>=20
>> send-email: fix bug resulting in increased message number if a message is=
 edited
>=20
> I don=E2=80=99t understand what the bug is from the title.  =E2=80=9CMessa=
ge number=E2=80=9D
> sounds harmless.  It breaks the threading?  The summary/subject could
> say that instead.  Fix threading bug.
>=20
> On Sun, May 25, 2025, at 19:12, Aditya Garg wrote:
>> In case a message is edited before it is sent, its message number gets
>> increased by 1, and so does its order in the message id.
>=20
> It feels like this part about increasing by one and if-editing gets
> repeated at least two times in this paragraph.
>=20
>> The cause of this bug was that when a person attempts to edit the
>> message, the whole sub process_file gets terminated, and the user is
>> asked to edit the message.
>=20
> Here=E2=80=99s the repetition.
>=20
> Also I am not familiar with the code.  Just testing it I get this `6` here=
:
>=20
>    Message-ID: <20250525181003.40129-6-kristofferhaugsbakk@fastmail.com>
>=20
> Which was incremented every time I did an edit with:
>=20
>    send-email --suppress-cc=3Dall --to=3D<me> \
>        --confirm=3Dalways one two
>=20
> But that turned out to be benign in my simple case since the next email
> used the correct In-Reply-To.
>=20
> So at this point (reading the paragraph) I don=E2=80=99t know what the bug=
 is.
>=20
>> After necessary edits are done, the whole sub process_file is executed ag=
ain.
>> The way sub process_file is designed, every time is runs, it increases th=
e
>> $message_num variable by 1. The reason for this was that the function ran=

>> again everytime a next message was sent in a thread, and thus we need to
>> increase the message number for that message. In case a user edits the me=
ssage,
>> there is no check for the same and the new message gets treated as a subs=
equent
>> message of a thread, therefore increasing its message number by one.
>=20
> This feels like repetition again.  You say that a variable is
> incremented because the message is edited.
>=20
>> This breaks the shallow thread logic which relies on $message_num
>> being 1 for the first message, and it gets changed in case the user
>> edits the first message.
>=20
> If I=E2=80=99m right in my assumption that this number is the `4` here:
>=20
>    Message-ID: <20250525182426.41076-4-kristofferhaugsbakk@fastmail.com>
>=20
> This was the first proposed email I got with =E2=80=9Cshallow thread=E2=80=
=9D (all in
> reply to first):
>=20
>    git send-email --suppress-cc=3Dall --to=3D<me> \
>        --thread --no-chain-reply-to --confirm=3Dalways one two three
>=20
> Then I edit all the messages.  They still all manage to refer to the
> first message id in the thread.
>=20
> I still don=E2=80=99t understand what the bug is.

Steps to reproduce:

1. Run `git send-email --to=3Dsomeone@example.com HEAD~3 --in-reply-to=3Dsom=
e_message_id`

2. Edit the first patch (pressing e and enter) when send-email asks for conf=
irmation.
(You may have to set confirm =3D always)

3. Do the edits. The message id of the first patch should have 2 instead of 1=
. If yes,
send all the messages and watch the threads break.
>=20
> =E2=9D=A6
>=20
>    $ git diagnose
>    Collecting diagnostic info
>=20
>    git version 2.49.0.780.g892193c3f50
>    cpu: x86_64
>    built from commit: 892193c3f509fb8a9e4e7a5a19a2e24137befda8
>    sizeof-long: 8
>    sizeof-size_t: 8
>    shell-path: /bin/sh
>    libcurl: 7.81.0
>    OpenSSL: OpenSSL 3.0.2 15 Mar 2022
>    zlib: 1.2.11
>    SHA-1: SHA1_DC
>    SHA-256: SHA256_BLK
>    Repository root: /home/kristoffer/programming/git
>    Available space on '/home/kristoffer/programming/git': 200.56 GiB (moun=
t flags 0x1000)

