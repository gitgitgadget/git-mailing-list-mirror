Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6C4317C
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626825; cv=none; b=j3sAdaFriP8eYjs3SO+uZvPTrMrpluYrjNcLkGLxH3znJogbT4FZNXVa4bDTX/DjYX7DWcd7u82IvNMwsfD7ppavSxacd/SB57f3XCN4+Aywlie889EGi0b6bjSAfx7EGCxPux1gnVs2B5AtV7ne0HkL8JE4a8Kps1z6RXuu20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626825; c=relaxed/simple;
	bh=AhLiNFZO2aJRCCB4XXAdwOQZK6NWpV0MPj1sHpRxZ3c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYHfbs6S23Gktp1ZiM4a+KqxHgsJHwyy6IW1J/gRq9dyoliVMrcdBjYUYIW0uFLhigYr79LcIR/vPCyD8bWnUXA6nl6lsEvv/HX91gPtHjArAFLkoB3COteBXXKuP4N5BkDyht0v8qIMYaTkmqb4sOqT06tbtL+0L2qYZ1cnexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrPPrvtZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrPPrvtZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso36248035ad.0
        for <git@vger.kernel.org>; Mon, 13 May 2024 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715626819; x=1716231619; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhLiNFZO2aJRCCB4XXAdwOQZK6NWpV0MPj1sHpRxZ3c=;
        b=DrPPrvtZCrPr2tuVDj3otNHGKXT/T3lBe3VoyHupcPoThJXsXvFjZwNAPSl1NjorsS
         K6LlZtJFNvVdCqyVi2e5c02p20gW/jIiCx0pW36Vl2HIr8KXPQAY9rT3R+PsncdzF6ch
         Z1Ocr1MTQd2ZrwWxljkxiwio29sNib/MtDCugBtGIjLjjwItIUgaoGdj9hw+9va6+KKT
         77vUOdJod/3J4XkPi9c0FmKvzNoGwURHJaZaNCc39aKL0MfU+S4AYfHxVGZcysx8bIYc
         1KlLkizX73ZMrCw0Nf7w7WnZBMhpcgNH3kKm79eVC4ZkCNY/9JTAXu81PDZCkFHkV23L
         xL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626819; x=1716231619;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhLiNFZO2aJRCCB4XXAdwOQZK6NWpV0MPj1sHpRxZ3c=;
        b=psKnhy0+xVV6JTaNtQSqf9sFWG5HS8l7NE4VWn+w0Xgj1dErclB0MOyCoyKx64ngkb
         8oRH2zcoo7tg5M+ysW6HUWFafWEKR5pm9r1RM2GRnKgDycjUzz2+81w1luCFd+wGIIuS
         RrR1nPYSow4pn60q5DovEoRafaV+z5pE8Pje6mhtalNOJLucPpmrZpmBOprWzVw/e6uO
         cjqNPFuG5rcObisqjX/z/9r+JwdP7bOz3S4RMWhW6LI4Oe6senKZtqQ8Dujnn6WL9nWX
         M6hBYqG6H2PL58/+29lAZb17mp0Bl7uuX/4FKWhgq0IrRu6D/GHmg0SX3rj5KwL+ebMH
         u4aA==
X-Gm-Message-State: AOJu0YwEHTZyv9ONJ15ZxruhgZRdKg7HB/ATlXNPJ0glNS7Ez5pCoJEO
	D6u4vV4w5k0DrbQKg1P8Ys+/xT6E8pYQgeLWeEG4nrs5y1RcqnTjh5QQAjUq
X-Google-Smtp-Source: AGHT+IHoD9Xpg34gatlvb+247tqFXRKLPsWUtwsGhnz5o1WChrutrIFAztKYX0ftMApL8N0fKIt3PQ==
X-Received: by 2002:a17:902:b195:b0:1eb:527e:a8ad with SMTP id d9443c01a7336-1ef44049fdamr99855825ad.51.1715626818067;
        Mon, 13 May 2024 12:00:18 -0700 (PDT)
Received: from DESKTOPI2S1NGB (99-58-59-125.lightspeed.austtx.sbcglobal.net. [99.58.59.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136843sm82838535ad.235.2024.05.13.12.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 12:00:16 -0700 (PDT)
From: <lbdyck@gmail.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Sean Allred'" <allred.sean@gmail.com>
Cc: <git@vger.kernel.org>
References: <02f201daa547$503df630$f0b9e290$@gmail.com>	<m0pltptx3h.fsf@epic96565.epic.com> <xmqq8r0dfsvd.fsf@gitster.g>
In-Reply-To: <xmqq8r0dfsvd.fsf@gitster.g>
Subject: RE: git client enhancement request
Date: Mon, 13 May 2024 14:00:14 -0500
Message-ID: <051d01daa567$caa22750$5fe675f0$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAerfcO1waJyo8uA6nqAp40soFFQIOt0DaAtI9TrWyItJ50A==
Content-Language: en-us

I have to interject here that the git client doing a push must be fully
authenticated which implies to me that all the information required is
available to do so and allow the server repository to be updated.


Lionel B. Dyck <><=20
Github: https://github.com/lbdyck
System Z Enthusiasts Discord: https://discord.gg/sze

=93Worry more about your character than your reputation. Character is =
what you
are, reputation merely what others think you are.=94=A0=A0 - - - John =
Wooden

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Monday, May 13, 2024 1:51 PM
To: Sean Allred <allred.sean@gmail.com>
Cc: lbdyck@gmail.com; git@vger.kernel.org
Subject: Re: git client enhancement request

Sean Allred <allred.sean@gmail.com> writes:

> Is this even technically feasible? My understanding is that storage=20
> implementations of each forge vary *wildly*. I don't believe this=20
> would be under Git's ability to implement as a project.

Not just "storage implementation", but some things are totally kept =
outside
the control of Git proper, including user and repository management.
Creating, deleting, and modifying authentication and authorization =
details
of these things are outside the scope of Git, and forges build on their
competing designs.



