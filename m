Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85323ED6A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878915; cv=none; b=Yyo5tfQIQqf2kS2KBktzN9F+o6SyAApxsH6HFYMB7iBXpqjTYlvFEomX9Ji9uK0cCGnFxL7oqViXD8QijKd3/eFoKMdFDbpD8cOQh7p3ruNSYall054OQDmda8bD1vDl7W1MBj7qizjr0ANPB8lzK7dWoffmUitqD+/MqKrIVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878915; c=relaxed/simple;
	bh=7VNP0TyvHlvhsuDucMtYy8iSfae9hvQqVOhbSJr9nM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmGptdmjVoabpUMKjdU01fvmPeZCXfyb7odzIsVE67gnq8shDtAo4A2QN3L5UR1NWvLql6ecGBXLloNg1q7RJKtp7V4Lbz7bMFPlq4VXemBXoXXGsqlj/SqjQFf2lt/r8CtdlgxKxwRvyX90ZFnxQlAUyHCqbCx+XMbxdrrjcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg/GEjOP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg/GEjOP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so9223342a12.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878912; x=1740483712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WL9PlCGlVbRCrOOrdLG1tynN+ObWpzxSLxqQfIO5PY=;
        b=Eg/GEjOPngLKFPNUU7OInQf57Zg6i5Fk1+G/lk+340hRv0xBBEvIxlQhmpzjOPaA3g
         UOldwolAqKl9zHzyizOKZ1muC323IvSnPCiv3M6bgK6ECPISvR1LAGiUj+EvpsL5sdRI
         mKWJZLdC8asv69ph0F2zuYiao8qho3crQAl5I8RvOZ7UuMXm8GL3/ZkjZmcRzXmUGXv4
         +2382fZe26YbIxhEWAuLacaofJXGZQAQWCkjDaZDPdP+a4l8ksTqeoi6asJzpb7HPGiG
         V1GIdQRHubHpUfLgvX/bL0U7I7qYFvGtCQ1FR78gAnikZIkQExUSDcmFn1ScEOa8Ly4E
         oY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878912; x=1740483712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WL9PlCGlVbRCrOOrdLG1tynN+ObWpzxSLxqQfIO5PY=;
        b=t+bfPrEF0ARgDby+wycLJNmeAOD6LyqDwvFpVRlERBd1iDYGl358QPFHFP0i4wJsE+
         dTnO/55GqzFe2ufcMtGc70UDX3zD4rvaTuNqNBvjm7E8KDn5KgAJLfQS9W9nUsEgkWNE
         KM9HdTx7a8HeoNFylafkJO97tx2pAiNclyNRolg2LysyqvMvwC1OnWgTmZ7qKM/odoyo
         yJVZpE/xp9A1s6jm6vIRZWxe43jdNZLDiRkRsRfz0OeFYAYjBQi8nvn84ToyTPIauI3n
         tSQzn3Td62W7oC3P2Eu63u7Klqh71MKUD5hr/Bq7mDpQiXzDpV5eqzCQtXnEvcvKd19H
         p1+g==
X-Forwarded-Encrypted: i=1; AJvYcCW5KiCZKRVzW1ULPe9Bh+EZWSdrQNVWEhp5LoTMBhI8FdgphG037+YzA1VPcm9CEE4/Y4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdY4A+10nl4pA4hljaGt5qdbMK8xa/ofnZ63ZFYNJkuyR9Sd+
	Mx2cttC1LTNUUz+KVAksTxAkdxBodIv1QP2J2tMDk4wTigDT3fWYFcSnDGWH3ls+svMwKqTKICg
	QPWRyM/WYj3DKtYCyjTia6CZTGDg=
X-Gm-Gg: ASbGncsnVsGqB7wIL0hi7HJNnUiS0SYmxF0u9oEo1DKZpW477YtiuahttuWV4nUfR/z
	1SAhuz7SOhJKZxw7SmZa/nCZ3Lc8s6vVHqdiBhXCfT5Nv+sdPf0L3qLew5LV0NzQQOcHrYpQB0R
	k=
X-Google-Smtp-Source: AGHT+IGoLli9NjYAkCqOBUHqoV+ensLuoLY/PR8reXdn9CXYUyvaitReUVWD4OrdAA9MQTdhImrBNFENeSgAruQJK3A=
X-Received: by 2002:a05:6402:3495:b0:5dc:c9ce:b01b with SMTP id
 4fb4d7f45d1cf-5e0360f9622mr11347290a12.8.1739878911500; Tue, 18 Feb 2025
 03:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com> <20250127151701.2321341-6-christian.couder@gmail.com>
 <xmqqa5bbq0nb.fsf@gitster.g> <Z5tZoiAHK-2OqjYJ@pks.im>
In-Reply-To: <Z5tZoiAHK-2OqjYJ@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:41:39 +0100
X-Gm-Features: AWEUYZkB2oCBqN7bArMJRIlkuMP82T8uRlwr8WNkZ6nkViFN7umRigypW9ERoXE
Message-ID: <CAP8UFD3OmrgPhhRNZ4aF48G3hoi7qr9kka+m9CAoUCw205UP3w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] promisor-remote: check advertised name or URL
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Jan 27, 2025 at 03:48:08PM -0800, Junio C Hamano wrote:

> > I wonder if the reader needs to be told a bit more about the
> > security argument here.  I imagine that the attack vector behind the
> > use of "secure" in the above paragraph is for a malicious server
> > that guesses a promisor remote name the client already uses, which
> > has a different URL from what the client expects to be associated
> > with the name, thereby such an acceptance means that the URL used in
> > future fetches would be replaced without the user's consent.  Being
> > able to silently repoint the remote.origin.url at an evil repository
> > you control is indeed a powerful thing, I would guess.  Of course,
> > in a corp environment, such a mechanism to drive the clients to a
> > new repository after upgrading or migrating may be extremely handy.
>
> I'm still very hesitant about letting the server-side control remote
> names at all, as I've already mentioned in previous review rounds. I
> think that it opens up the client for a whole lot of issues that should
> rather be avoided. Most importantly, it takes control away from the
> user, as they are not free anymore to name the remotes however they want
> to. It also casts into stone current behaviour because it is now part of
> the protocol.

The server-side doesn't control remote names at all in this series.
There is just a match or no match, depending on the value of
promisor.acceptFromServer on the client-side, between what the client
already has configured (for example using the clone -c option) and
what the server advertises.

> That being said, I get the point that it may make sense to be "agile"
> regarding the promisor remotes. But I think we can achieve that without
> having to compromise on either usability or security by using something
> like a promisor ID instead.

Thanks for the suggestion and the ideas, but I think that what you
suggest could be discussed and implemented as part of a follow up
patch series. This patch series implements basic checks with
information (name and URL) that already exists on the server side and
might also be available on the client side. For a number of use cases
it is likely enough, and it's also not very complex.

I would be fine with resending the series without this patch, if
that's what is prefered though.
