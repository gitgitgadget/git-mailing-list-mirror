Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB447DD44
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388678; cv=none; b=CD6Im7hoc101MjmUx6nbRbaXuZ2ibdGY0SNwukUdEvba1eY2Pw361Rp79hh5wzuDnyCMpF+F2fqIXjwcwjKGnmRq7xmZK5luO6vT74EbLOZGhT7LvInY42vWnKxBPeurc4hHgSG5KhrUrv9duXCOkoVNeMkjwroBnSem7n6gtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388678; c=relaxed/simple;
	bh=eEsIkXVpDryCaCyvGqdZQPu6fSnWOdaWZgbtgHX2zaQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MpLjSIseIr+Vw2Wv90zv1w+B7xqABcGTt9Eg1OpQnEf0TYKS8//AmvxEP5THx5kXFclrLetxjwihzGxu+iU2x6qf3cITjj68yfSWKf4bhmvZ3QZITVtsfEtb/aSDhInhgTe6hOTG38PTrm3z1VIdHGBaxvVonsSrpwET7yNgkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Jm2v2Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Jm2v2Q"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so15092265e9.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792388648; x=1792993448; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eEsIkXVpDryCaCyvGqdZQPu6fSnWOdaWZgbtgHX2zaQ=;
        b=G3Jm2v2QOwM8UXNt3X/K5wRZpxSmqJ88DeFjss6DvOLOg6d4UB4jQAqdFrTAy4g0cm
         4Kkz+b0ypogcaoZnAqekhhGboQQHvGPZ70F62USnlU4Gh5nXQcs2W9D5mySH0j+GSCON
         H7nKM5COYzaUGOS50wncMkCxTyGUhNT7Z62V8jSINNR4DfgkP1ZihnrVWVq/DOifqYzl
         SKghKPm6lRX0p4bWzAnz87kWEqDvqgU6Ec5fsDRF/cq8C9rKBjcfQoMGFt+9wW2NqKp5
         K+e3V1cPoDXmiFzHlG/SCER71YbKcCKvBwKs21TY51uCfxmZyGn7in+iU0FJWftc4kJq
         dHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792388648; x=1792993448;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEsIkXVpDryCaCyvGqdZQPu6fSnWOdaWZgbtgHX2zaQ=;
        b=P4aHOvzwXoYhIA0Iush8ynPr52z7bSFXzw6TzjXfY+XFJzcBLdFXBveOFp6sNVv0Dr
         ou8cHtvmjq0zxKLwzX4A1nLmSIdNfONq+WOmcRzu38MQlEOpVxCOzNV+AlFpRmBrJ0Qa
         YtBmRz7pspyp0OpQUdHfrpvTb1NclC8Yqp7dkqV5MSXjCZO7IMlDwWPltrhh5MnbSP0U
         WywwOcafeKTIXRP7Q//HWkMV9z2HtQ61Ph2gRH8s7K66lucuHbuApDSfzFRA49eZ7BRK
         I6ST5ix9K5nLKjlCzvLqmFRGVi1M4cmObn0es7HXqfxruM76fyzA5W6G1dhno6aq5X/w
         AWBQ==
X-Gm-Message-State: AFq9FYKo9f2wiIMKIjQ7ZEek7rXljiOrNK7WyE9AemWKg6qdERmLBWuL
	MiDK0TZhScMoTfkk8n0wYB+un7iH5u8sjwYhwhmlSVaXo/235RdrQztG8ij0j1V4
X-Gm-Gg: AYBFou3B+MxSUgqgo0WBYkIiPsuQj2kMsQuEEZYX9LbJB2ysNAevnK69U222VBRvLlf
	4IW1Xjo1JRg7WYrmPbmUCVeuCbXvkQzVkGliv5xE6ZP7KFGU0HtWGNQAtNL0bN4ImkxfzU01AEK
	TK+7hdO4AAzukP2tq0PgMv8s/AEZb/pQVAMUBtog6LzIgvGChxFIWbEyixjte6qJ1fe2iQrWqxe
	56YVYFofK8ZLO2IGQ7WlumoQ/KU3i4Xt/2vzRVeglWFuV97qBIBS79WY8EHF/dJ11SVikcbTzmz
	6ATVHJIQzw9im+MYD7wnyHJWJZtTrnGcF5bNfgmSP/SGmD2wu6yNo5a+nPQZ9g4Ncko9T0bFmWU
	vy/GfKkNNkNyD5EPv6wI6LPvesOHro+bj4JSwz3I+ukO6TjarqZcJIRw5CR07vYxdQZZAXBfph/
	4nmdikMF1mXfaOyhjjm1+x0fEwz3EqmI2FCjpfVHQC4KaoNLhIio0IrWEBySr38zz/GQsaKhh2R
	4yA+LGtgZZDFZkQ0DE+g0beSmUPLdxki8O3WTUTaPT9X6vl/doYkC3PIyUga0RUAjRWq58AwtvE
	jeI=
X-Received: by 2002:a05:600c:820e:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a1d761637amr123587015e9.28.1792388647996;
        Sun, 18 Oct 2026 22:44:07 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:989d:ce47:9d0c:94b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5128f1sm21172520f8f.59.2026.10.18.22.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2026 22:44:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <CAP8UFD2aacVCDtOS2iTVW-tB8Ozm8K7oaiFSVk3X7infx0TODg@mail.gmail.com>
Date: Mon, 19 Oct 2026 06:43:56 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF7B7B9B-D496-4E33-A137-30934DDBD349@gmail.com>
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
 <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
 <CAP8UFD2aacVCDtOS2iTVW-tB8Ozm8K7oaiFSVk3X7infx0TODg@mail.gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.500.181)



> On 19 Oct 2026, at 06:38, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> Hi Luca,
>=20
> On Sat, Oct 17, 2026 at 11:12=E2=80=AFAM Luca Milanesio
> <luca.milanesio@gmail.com> wrote:
>=20
>>> SHA-256 support across the ecosystem had been a blocker. GitHub =
reported
>>> experimental support, with general availability expected around =
November.
>>> GitLab already had public, non-experimental support, and libgit2 =
supports
>>> it, too. JGit remains a gap; Google was not planning to fund that =
work.
>>=20
>> It looks like the above statement needs amending, see:
>> https://gus26.gerritforge.com/schedule.html
>>=20
>> Google will present their plans for SHA-256 at the forthcoming Gerrit =
User Summit
>> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>>=20
>> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When =
(Xing Huang - Google)=E2=80=9D
>>=20
>> Anyone joining from the Git community?
>=20
> As I have been kindly invited by NVIDIA folks to the November 11-13
> hackathon (about "making partial clones a practical replacement for
> Git LFS across the Git/Gerrit ecosystem") at their offices in Santa
> Clara, I will also attend the Gerrit User Summit on November 9-10.

Cool, just saw your registration going through, good stuff.

I will also present my prototpe of object storage backend for JGit using =
Apache Cassandra at the summit, see my talk on the 9th of November at =
1:30 PM.
https://gus26.gerritforge.com/schedule.html

That should fully clarify the JGit side of Git Contributors=E2=80=99 =
Summit 2026 minutes.

See you soon.

Luca.=
