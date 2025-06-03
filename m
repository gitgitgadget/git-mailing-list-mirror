Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBA281370
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941525; cv=none; b=rscqInQQK72ZCKJ/kAEA3tTLATQkp2byZKmHREYSuL4AWJJpsfRsAcQgHW78JzlPgw+M32N00ENsY7MCyenbDPIQDYtpMH3bHw8PQb34BxhdLaxZTR6TT6cKvppWvIoz6QHbYXDFEuwqDj2kNF3pAFI2+CEoFSUC6J8GWpRzpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941525; c=relaxed/simple;
	bh=kKVXX2U5irDX4Kk6SQIew4HsJp3wMhP7mxJALiCQbjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvul3d4+XfKQ+JL11SQfJrO8dHNcd4iN0yERyFFNLq1FQbQy0hQAfJNJ7lZy4z6+fAdHFn5JaRtCM5ZPDaBL1IvxKiV2SxPTWLZIi5gtJk6lf+GALenDIuXJg0D+ed+1UokuKOpChL2mdyyWRfJjpN8hG91kkEowz+5wCCb8Enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzViD4xI; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzViD4xI"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5240a432462so3597051e0c.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748941523; x=1749546323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKVXX2U5irDX4Kk6SQIew4HsJp3wMhP7mxJALiCQbjQ=;
        b=LzViD4xIy6Qr780LCQyNj4mjPQcn5w1n9xddKCIGfOZlma3Nj72zryHEaOp9bEattd
         316IKYqVVl9JI/k7F7kBp1IOwUbsVqwpt+mm/DEeNjja1xXmRdb/AqNs5qSfKvYo+c4M
         p4Bo4xiYLhX0EHWwd5L7y0eTOEOL/rcriiWAiNzW8SKtxpHgWvtS/ALc0J13Cawcvi8Z
         pReiYC3YXxf1BfpFGT9Ir9o25R+MYwmmvAm5GAgT591BuXGwyGqIeCbu9A7Z8uvO24Ne
         5c42646NOn5IsajAmNa4NRxj5qu02xW+GvpqTlrJ2JgjzkSr3kXDC9jXRKHebhSPq7ty
         RBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748941523; x=1749546323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKVXX2U5irDX4Kk6SQIew4HsJp3wMhP7mxJALiCQbjQ=;
        b=eTfjR25eaDffbsmSuLGL1/KS/Fxp3EDgWMnr482iuGaHQqRZZoOrLo4MVi6KvsBICT
         b5PZUIWTHHBbmyFp25GLdQtyEVkoSUglh/DNVuEzHbbtobmPawvnd8dehKrWhnWs+VN0
         wTExZh9DqvKfDrpe2sfYwUgoW57FCnbbDxhpIU2V2BJ7axIB3siu/DxusvCrklHpAyK6
         7ip1zuWWNu+jRCn+d4NImvTUFK16qabR5bb4/gLWMrNBCtqV5Khy7TaciSBjDmfeK1iI
         I4J89MEvi96OSotkjMqc/gcz9m8K15x5w9MWlsd4vSm7n9ymEFQW6+6Dq0j8oDETsZOF
         x9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVnl09nblnwJ4K+aHkUnrek4X2oVBm3Ph7+bCKBNx5PeNI4F5yJ6oWFURJ4GaNd7Bgn+MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Duf1ztpVNZGmRAZtwDX3imMtm8m2QWapZddFdnHiqMZCI3sK
	ql5s3ZA2Tkln64HqirypVohLF+gVElXeF31oa1CHp3HgCMZwYhs3MQvixU8VqPfAPoKKQLHu5Z9
	Oqg+IYXcmXJbCDgDrkmB8MVMB6ihxM3BxvMjS
X-Gm-Gg: ASbGncvBcqQINak6FhRuCqJRIVyJO6JJqPqkvvzSSgr2OPb4jqfS2TKixoO9QSsX60b
	f/cTPO2dxdc4K0Fn8gKvTOOM0BFFEpdAkj5p7py2hn/fqoqgkINUj6ey0Cna1gV91Rwm1UNESzv
	KYqGypqKUCCUR1k6K2o9tvJ0GWeuPaOdyPxUN+6VkIRFYdyUJSlmEcOdOUyoIcgJQr0W8=
X-Google-Smtp-Source: AGHT+IENAUS8EZ/cXhtQPGuxNvlOvQGovMIrwg/cZ2AVdC/llG+GV3D6lRtgtMJT0NzIzlpTHTT/fsN4teZ58E3enug=
X-Received: by 2002:a05:6122:338a:b0:530:2c65:5bb8 with SMTP id
 71dfb90a1353d-530ba4be176mr1040813e0c.1.1748941522823; Tue, 03 Jun 2025
 02:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
 <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com> <256e9e60-fdea-461b-b43c-8e6024b773a2@app.fastmail.com>
In-Reply-To: <256e9e60-fdea-461b-b43c-8e6024b773a2@app.fastmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 3 Jun 2025 11:04:56 +0200
X-Gm-Features: AX0GCFu6S23RxQNOYlFwxI8O4CwQGhzt5NeU3nKUoks1AGOLToNQRFW18g4iQ6w
Message-ID: <CAOLa=ZQTYTNiUhFW+kOqMro0rpWVTkyKop7az_6h7zgM8njRhw@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error message
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Yonatan Roth <yroth@paloaltonetworks.com>, david asraf <dasraf9@gmail.com>, 
	Emily Shaffer <nasamuffin@google.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:34=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Jun 3, 2025, at 10:31, Karthik Nayak wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Sometimes code wants to die in a situation where it already has writte=
n
> >> an error message. To use the same error code as `die()` we have to ope=
n
> >> code the code with a call to `exit(128)` in such cases, which is easy =
to
> >
> > Nit: This reads a little weird.
>
> Maybe s/to open code the code/to open-code the code/

Ah, that makes so much difference.
