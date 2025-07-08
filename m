Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6B267B19
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972901; cv=none; b=lDdS/K8HNlPaZeOd0sVPLdTL1/WoNM86pSNeZIYbAndlsz9q1vX18SsH7yjLxQdLGJrZn7BC22kmIp7h+uRAf0VQ7FId3nUq0GsKxgMvCW9ODpWpACaPTio46xLqJNB7rmiV3ByBjKRk1tG7utT0Op902wmPpbvz3TQWNtzGWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972901; c=relaxed/simple;
	bh=0/kTY244PKCJ8HBs93orFJPP5zesU+Uy5qZQaUwXKcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPCx3pyWj5jpJtAD6L84821hxw/DtMNs9ir6nO2ANIhMSdnGJDZIh4J9jTabgl98ramc4XpI1J+Tcutc+iiAfITBByGNybU1Hhs3c8xgDYLT7jFMGhHlrEzO+8bDSBNsZIrvVoCy/eJmq9y52oay6WEqijt5TYWX/PC7LvD8TAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAAW33Jx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAAW33Jx"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso7534331a12.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751972898; x=1752577698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJSA1jN/LpimQOqun3eOi6v5mZBAg7QzPoDVnkbsplU=;
        b=KAAW33JxUJbJ3oQ5up46N2fUH7L0qi6u22iItVPk2uKbEg+XyajUddfaGLMX6bWTu+
         6xd5HvAnRBSbgo3T2kPHA2PlNxNnAQjWebuB/YINnEWkDl9F3gQqWoVXzD8BFZfTT6SM
         5xYQOj3D0bKvpkpMp809pFWxcsQ4MxEgh5UNtX32KB09jV7rjvAKl6QIGXhltItRroWp
         HLH3iLRRVRZ5FxvvruXBhrpS58X6M2z9q/KHvPQv0hs3hwACm18s4a24VH8xTnp5bvTL
         xxYjusbJcNgbN1IPWg3QUj5yiXcn5nYgC1XlruMm3Cmf2n6iWUQhfD4pO4DcI/GcTRIq
         yKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972898; x=1752577698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJSA1jN/LpimQOqun3eOi6v5mZBAg7QzPoDVnkbsplU=;
        b=HXYRDsG/wXAlkHMSfIxl5sYQ9x2iC+CKyIzOiVEojHa6zfUHkpKW7YJzhwH3i2goHF
         ZYc4Lze0tR2eb75EakZii/0cxCOp24F2G0lwjjWWZtM3itWqZ7yYi0YUXMYMXqjPAR38
         gySmaoLxvg7bn8Fe7iLKB7TtZZzeKBBKqP0Rp8dElpGJ9hK6ERSthpCS/D5pbIRiml8Z
         HuwU3LpVxevxUOiOMB7YJm7/CbCgSH7/Q4JGCLjpE8mzdUtT8+XuDRXVfd0N34IlGdjo
         1lLjtnTUUraYIDi2IGg2W1cisbmp5GIwZAm6DlmtU3n4iMFinguQpvWmHM0TNBFiGl8V
         Bnzw==
X-Forwarded-Encrypted: i=1; AJvYcCU84MIO8dAox5rSuLUjZtd0TIc1fIfxAZ1lYOvKRz+jXVwq4taR6np2gz8XN47uVg4RFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAnkJQC33xwdCOClkjsi627Pamy3aKDG0l8trE4Zp4zjBYAi2
	6hlAMDBm0iMeo8uxm+pXCw/xX8hi5tbct+oAEnf8IJrIOpNTvcT9vX8OA6Yq1zq4xg/OiUmC3xo
	+fI87OPie8jOzU1XmTUk0GVeB6Omhq8E=
X-Gm-Gg: ASbGnct/J3aDXneVNtJYHnizgQJhvlSyT85AODkejrwv0uS3dbAIAoWLtmWB4BaB9+4
	q8GdDn64kMwq7/RiIkIA3VN/8C9qewhhZJ42A3kK3/o59pCLPBXLNAwmjcMAxL+vVGaYUmX4Ntu
	3eHAkYpCfXoZNfUfw9g69RjeZCMw28Q8F6l7w86tySTMKfidj0mehdG5RbdTfDGNHdksynacHaI
	k/j
X-Google-Smtp-Source: AGHT+IFJZxgJ24uxf5HiunrK6+cYVfpP60TCrQoeRCE5L8GTDxJo4fh1sh4KokBlH1+OYvcKFL9nOuQjnyPu/UOiNLE=
X-Received: by 2002:a17:907:fd88:b0:ae3:bb0a:1cc6 with SMTP id
 a640c23a62f3a-ae6b0081537mr326467466b.16.1751972897868; Tue, 08 Jul 2025
 04:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <xmqqbjpv1ucb.fsf@gitster.g>
 <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
 <xmqqwm8jxoj3.fsf@gitster.g> <aGy82TiRFcij5V_9@pks.im>
In-Reply-To: <aGy82TiRFcij5V_9@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 13:08:05 +0200
X-Gm-Features: Ac12FXyP-sDQ9qWnzCBCk135FN137RaFI3hfLub0svGDOgkIh_Hje8-tM2-FJbQ
Message-ID: <CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:

> I agree with your points. Overall, a fast response cycle is key to good
> collaboration from my point of view. I think it not only makes your life
> as a maintainer easier, but it also makes the reviewer feel like they
> are being heard and is the prerequisite for good discussion.

I don't agree with "is the prerequisite for good discussion".  I think
it's perfectly possible to have good long running discussions even
when people's replies are delayed. And people can have vacations or
weekends or private issues or work on other things which can delay
some replies. And when people work significantly for a long time on a
topic before replying, I really think it can increase the quality of
the discussion.

Also if a contributor comes back with improved patches that try to
follow closely what a reviewer suggested, then I think it can (and
should) make a reviewer feel like they have really been heard better
than just a hollow reply right away followed later by less well
thought out patches.

This doesn't mean that I think there is no value in a fast response
cycle. But I think it depends a lot on the circumstances.

Yeah, for someone new in the community I think it can often help a
lot. And I encourage the contributors I mentor to respond soon.

When someone has been part of the community for a long time, I think
it's different though. It can happen, but it's much less likely that
they are going to disappear tomorrow or otherwise not follow up on
feedback they got from reviewers.

It doesn't mean that I think oldtimers should have some kind of
privilege, and yeah they should also try to give a good example. But
we should allow people to not always behave in a very formatted way.
As I mentioned above and in my reply to Junio, many things outside Git
development can happen, and people can behave differently, have
different preferences in the way they work, and especially not like or
want to switch topics very often for example to keep a better mental
focus on what they are currently doing.

> On our team's handbook page [1] we have the following couple of bullet
> points regarding how to respond to reviews:

Yeah, I think they are likely to be good for newcomers.
