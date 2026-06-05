Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E72DC764
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678578; cv=none; b=uzQamEnssbgiva7hW6UkD5NF7mePE0WnicCO5TQNw2vWnMSkC8N+RnLU0P8zm5Uho9abuaiZpZ3peujhXOv4moDXa0bSHlDmIhev7OPUXj8s1kUd6UXITTNDAsgpwIWDKFjOQeAziRSEWjS3nZ62tKcMrhi8UnZqcSgcNpBcgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678578; c=relaxed/simple;
	bh=7VnPW/bXM1ZfUss6wEidlBnz4BI+CRq5qzgiZPP3wm4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u3QrAETXTtbTZL88KCzB4NrCr869RPSS0M/FvA57XR20rXVE9c7lW0u8SMYbY7xt2cd1L2xLkMxM27QdHrXbDDzonqwDE6D1Y4Npod9odHwNmqKei0SCXY/QTRE4CVOziNN19W7BYi5kQgmZGJwFqGglE/paVUiFci11jOfJAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cwcB4t/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gHRCNXrK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cwcB4t/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHRCNXrK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B7BEBEC01D7;
	Fri,  5 Jun 2026 12:56:16 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 12:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780678576;
	 x=1780764976; bh=qUpj2zuYzxSqZQE3bHAiysGZDtyfF5ukXX7kpc22hFk=; b=
	cwcB4t/e+q3si7HPUOdw3UBZEEcfshrILtbxmU6ti+vba7HHTWAqdKPWd4tfW3qk
	Ca56yxTi+8V/lYUJmKkAG36iGMT5+9rSjE58c4XjLJLAlOqJVIeJ0ParDIpzQM/l
	UttvDEikR2yccSYcRMmyzoVA80TPHyUEC77aXxHJxn3Xoqzy1e+hLyilrWIJ9y6g
	QgrIbOPlkQWMBNfbV1oiMeAQYrC3ZO7xzl3JDxHgAWCjLNHJ3rT0YVKF2nMQRZ6f
	mgjX8QmawzvPI3J5vYPJZCUF83fxsG7ihiL1xbuGv4RV4id7IsIT1QiH8wuMVO++
	vSBFOSr6X8xLtL/AA8AjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780678576; x=
	1780764976; bh=qUpj2zuYzxSqZQE3bHAiysGZDtyfF5ukXX7kpc22hFk=; b=g
	HRCNXrKY39/MRWFukqOL5A2+1bKqS+574x3dMoT7YijLSOld2ZRcjQglnjWYBvJp
	/r/4qHowKMSk3Fwkr++0eSYh3r5Kz7uMRZCtO9L/EXPqyB0/ykD8SDvD6GnHRCZv
	04haNS0ciQprM62Wrbi3+O3/YDWmOMaqFoxSvcvxmaOdY5wr1uolMtpRsDMD4T3a
	YikvnsV0aWhv/ZyBF+I0lRnCKaTyiJq2MqI1er4fxxpby+e5aI9omzWNTnlaP6w8
	v46ObuhbAByh2DlllP62ZSc1A83o+Z2FHlPfMbMN7NHP9hB9eto2agBltuEVqvYK
	QYPI7TvD1XfOlscp1VcGw==
X-ME-Sender: <xms:sP8iajbFW0ffPas5QHK65g9XueUYX82LqVJT3E2g6AHEsqVincWaS2E>
    <xme:sP8iatNPmFKFw-SEWJTx0lWmu5pP4t1it6ywSnAzUYeTk45Sd7gjb70U2zU9aJIhw
    wHj41U-Yr4ukEStckZ2q4GszdK1h_nHDHSqs97V_QVdKaFj1SiIiA>
X-ME-Proxy-Cause: dmFkZTF6MLOtBrdZZk9+B3ucc7/2nrGbe1+Iwg6NQG7Fw6PGpeWAWhFVsoHEazsj+ClazC
    hIA1YOuNmgWw3lxC23GHjxE4uu5qvB0MxHtl40zvpyO4V+EO7tniLaPIrylKoTtw/+jyoe
    cQ1O9HVT3cmSD4PgdwAMDoQwLETryW8c5VbYp0sla+LmLNI/nx188YiYevWdzDRUH021Yk
    MLvNFpxDNsv39rd0Cv5Ku3XmwGYOCoQG1WZJ62aEMuHNDiaaRp2QDiAn/Q8dXTiqr99a62
    rpYJ0js411zIb5yV//w6mmvmqwrN1JeZXk9oHLqlrE9V+DkdY72jhwAylLHY660wxjpYC3
    HO6tFQuj2/UOqjRcn4+kOd5RFaNrPW1b8bxX12smuqCcjZpt9OBhuQM1te8pFANtWHcTTf
    Y2GIcTHw1bFU9QQtUQwnMoKisPu/X7rwMtji7/wXcZ5KDJyg6/s91AVoWU1LBqSDPohH+9
    71mW5EkAKfwZO61HotZSkRyBxHIImpmbUF1wk5YULb/Yjdwv3nAxjTbG7I1Kj+mq80CyLL
    OjCEYjbucpINeRoKcirdTqsQk/wMqAyLkrFRb/uWmtMqJdPlmdYP9M2ErL5XxDbDPjTYf5
    v1Up2G3kZlToTOkLDxWOnHor6LJU7jWefoeLms2cgJUPAvxzBdeSsjGDoDNA
X-ME-Proxy: <xmx:sP8iauqqGTILZhM20okFzCQS3omx3yOsKhHwEUjTJ7oAafomUZ8IRQ>
    <xmx:sP8iatG31fHLxF4hX70hOe_GtWwY31P_hEB9SoFU98-8RY3FdwGeTQ>
    <xmx:sP8iaj4G2HbnQ7X6EQVqa8qZuo1qCQDSj6q2sEIBUXFYjgWl8fhQKQ>
    <xmx:sP8ialdDiqzck2eHf-eYqTQeVrAv3OWabsEDe3OFdhI0ISvvF_M0hw>
    <xmx:sP8iaiquPcoWHpYk1M4EDtZO-nUHpSquD8kS9HMtZ7ZU-d1AdM1B5Sxi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B6CB3020094; Fri,  5 Jun 2026 12:56:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2I8_XOTDCGF
Date: Fri, 05 Jun 2026 18:55:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "JAYATHEERTH K" <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: a3205153416@gmail.com, "Junio C Hamano" <gitster@pobox.com>,
 "Justin Tobler" <jltobler@gmail.com>, kumarayushjha123@gmail.com,
 "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <bd9bc9aa-60b6-4e5d-9ce1-bf38b6032309@app.fastmail.com>
In-Reply-To: <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
Subject: Re: [GSoC PATCH v2 1/4] path: introduce format_path() for centralized path
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026, at 18:30, K Jayatheerth wrote:
> The path-formatting logic inside `builtin/rev-parse.c` handles absolut=
e,
> canonical, and relative formatting rules based on user-supplied option=
s.
> However, this logic is tightly coupled to `rev-parse` and writes direc=
tly
> to stdout.
>
> To allow other builtins (such as the upcoming `git repo` path keys) to
> re-use this logic, extract the core path-formatting algorithm into a c=
entralized
> helper function, `format_path()`, in `path.c`.
>
> Expose a single, streamlined `path_format` enum in `path.h` to let cal=
lers
> explicitly declare their formatting strategy (UNMODIFIED, RELATIVE,
> RELATIVE_IF_SHARED, or CANONICAL). This decouples the core algorithm f=
rom
> the localized fallback mechanics specific to `rev-parse`.

This looks very well explained to my naive eyes.

>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

Nitpick. You are supposed to add your `Signed-off-by` at the end. You
are saying with that line that you are signing off on the changes and
the commit message, including the trailers (mentors) you=E2=80=99ve deci=
ded to
add. Imagine if the maintainer applies this patch and fixes a typo and
the commit becomes:

    Mentored-by: Justin Tobler <jltobler@gmail.com>
    Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
    [jc: typo fix]
    Signed-off-by: Junio ...

The chain of custody is then very clear.

> ---
>[snip]
