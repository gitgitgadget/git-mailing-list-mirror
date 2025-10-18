Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C0170A11
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749526; cv=none; b=gcXGhy6cyRTfHU7/DS77zlG/hm6/gsE1e1Zj02iQaWtWHQnBM78Bp7AnqLUs5xAyYVayM/0cTSKPFEK8ZmEMRc0/O5d7gQr2O2EKLAZs1vtIc59Nr1c68fAm/kh8Lpjbio3lKPEgALu7FE2aMGghctCfvZDYUKN9yDGJkB5084w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749526; c=relaxed/simple;
	bh=oJG8Tx12Izk72Alk9ltBgeT1ybCAwwFbsuLSqqmBv1c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s3WciZlPJBb/v8pPiWWGwTon13hg0RFRuVRClsxX8cNHEGbfNbs3tSb77orl5FpxHJUEudtu3sLnb5uvtUat5YuhU3nWZ5Kirl6iylMDtZNNw1/wMu7UMPTZEQpp996GCYBBKbs01csn2Y0uJeEr235AZsn6VmMwXirKkINIKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX6egmca; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX6egmca"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b63148d25c3so1563279a12.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 18:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760749524; x=1761354324; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaaSS0NWmkFNBRNOX2Mr0zGJl5Rv6r16FLAnQtXmXUg=;
        b=mX6egmcam5DelhorpG9fan10VdrlbG/NjJg1XD9tRIF7NHySS1hFblhxhOayEqhr5S
         9BNDLwIbqxaP9llP/MtZ09Jba7hr+Xb89n0cZQxsUsP2tWpQ7PH8ZDtZPnWHZlTc82Lr
         4yBb/TQUm67Ylmyt7GiKKxrczeDyoksURnni71GE6QpyME+gmpgvXUtWXXwYgoytaJfI
         UfDEj0DagjmJY0hIG6qntccA81vRmPQ0cOYsLpOzwAJ9aDPAO8QqG7hV6ITnfbLbZJ7M
         /gMUksYTQRu3Q/smZaK2N5eNsiJFmAwAXNx7qcDm8oNpuLeQqTracornTgiuNPAlA8iM
         z7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760749524; x=1761354324;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaaSS0NWmkFNBRNOX2Mr0zGJl5Rv6r16FLAnQtXmXUg=;
        b=e0sWkpxcPQ7DXIRCAhqSponoeZitEkPG21L2vi54wSFxO59h0jVoQl2+h7gelmnU6i
         gl9RlkgabRoTXNo9dYOY1JFShxHgX4jetOaZF2wyIw+xxMCuJ3EJ2YfBycA6UrwiLjGS
         fGaQvzvbJ+MS8pQgvdrHo3sjdEk0cGQSHXDznjVQbw9uAX4HIcBHnL0jgpqQMY6rlHwH
         rFwkL8+PVDM/RhHSNXdbuuNZhHr4q2JUi6Nofodhcc0mw9P63WgNCGq8exCY/Q12GSjA
         xF4uPoqBFtr55CE4IEFBXCtAFcTntdmesst/aPg2B/nfSeXhVpWMEP3LC2zjYpoR/XHz
         G8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeN1YB7M09Op6o0PDMHk/xsxESD57BIJxG1M/kCaxxFMjNhDnufrlGObFcQ5sISud7aVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELrt2wXZ+1ZN0zbwefWq/10fcKx/EwRXs8YB9wefiiteLQx/q
	WvJFJ8ojkAvg4nMwbkGDrJcdyLdu5lnCYyYPgqNd1AejvSgPiDKzM40Pk4KZlNa6upRg9g==
X-Gm-Gg: ASbGncvGYi1c5hW7K5JA/PlQ9HXaDe4vSqc3MB0rov6i8tMcmM9DSoRwBDQuDKo0Huk
	k5of4BDXDk1ygSolnyur1u5WU1lb4PCT55UI98iIzqos6wnxoxKANgNh3xSU8agJaGf34HX1hX6
	gWalf/EMwxn9H+gwlpTgNLjp6bu1xqKcQBMWNqgHYfVEtvoJWWo69b2qIXX1tq54svzOzSyapW2
	SqnSExibI6NaA66WTgpeNq9WqvvioRvxyJZIGT28u0mT6U4IuTLHoOrEZzOkVoWucyz5FPEPK0j
	LSXa/qvMWf+jkKhz5NHWpEWhXDNfYKoksdo+7/vQ4QSVjY3xpfsWYLL1kXRr6zUeDweY4fm3mHO
	m8ErlmvtkNCa4hSfOiG5UPsarSCFTT4y+fIoP1acqFmOo9toN/v5wZYVhZ3Ez1ALwrhu+0YiS5S
	m0/g/OxoP1Z9YVKaMYvqBJTWS1YpfiGz8ATpPW
X-Google-Smtp-Source: AGHT+IHMUJ+7t8wzhFKEs8IPhDHL9CgWZTYs8SRX2ZboPsEjhwAFN0NEsaBVTBTm71N+/sJCl+uA+Q==
X-Received: by 2002:a17:903:19c8:b0:265:f460:ab26 with SMTP id d9443c01a7336-290918cbbf1mr134556775ad.3.1760749524274;
        Fri, 17 Oct 2025 18:05:24 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d55d8sm8232585ad.61.2025.10.17.18.05.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Oct 2025 18:05:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqq7bwt1kyf.fsf@gitster.g>
Date: Sat, 18 Oct 2025 09:04:40 +0800
Cc: Jeff King <peff@peff.net>,
 Jake Zimmerman <jake@zimmerman.io>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <918E56B8-7009-4E8E-A98E-AC5B9CE4DD7C@gmail.com>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Jeff King <peff@peff.net> writes:
>=20
>> Looking at that patch, my biggest concern is: are we missing other =
spots
>> that need to special-case the dry_run setting? Because it's a =
regression
>> in a maint release, I'm tempted to say we should do the dumbest =
possible
>> thing that covers all cases and just revert this hunk from the =
original
>> patch, like:
>>=20
>> diff --git a/diff.c b/diff.c
>> index 87fa16b730..687206f353 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
>> if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>>   options->flags.exit_with_status &&
>>   options->flags.diff_from_contents) {
>> + /*
>> + * run diff_flush_patch for the exit status. setting
>> + * options->file to /dev/null should be safe, because we
>> + * aren't supposed to produce any output anyway.
>> + */
>> + diff_free_file(options);
>> + options->file =3D xfopen("/dev/null", "w");
>> + options->close_file =3D 1;
>> + options->color_moved =3D 0;
>> for (i =3D 0; i < q->nr; i++) {
>> struct diff_filepair *p =3D q->queue[i];
>> if (check_pair_status(p))
>>=20
>> That would catch the bug here, as well as any others lurking. And it
>> converts any missing dry_run from correctness problems (we definitely
>> will not produce extra output) into optimization problems (we might =
emit
>> data we do not need, but we can fix those separately). At least for =
the
>> normal code paths. I think without those extra fixes the problems =
that
>> b55e6d36eb tried to fix for "-I" would still be observable, but at =
least
>> its fixes could not regress the other code paths.
>=20
> Ahh.  I like this "stupid but cannot be incorrect" version even
> better than the original one that introduced the "dry run" mode.
>=20
> But once we go in that direction, do we still need the dry-run
> machinery with diff_flush_patch_quietly() helper function?

I believe we can move Peff=E2=80=99s code from diff_flush() to =
diff_flush_patch_quiet().
However, I'm unsure whether we should remove the dry-run logic. In =
dry-run
mode, we would halt as early as possible in xdl_diff by using =
quick_consume().

