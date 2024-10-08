Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC11E104B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420266; cv=none; b=Hk17sZMEqUegvJV9iJanKXdjfS0bZRrZvFd71PtIypmJEXjgPTyR7XJNQx31ls3Dqgoc0bY/goD6Va29MuH9xo8xxHDmffEDCwTcPKOwFX6+m/8XyzQeCBZCFHeGWkQfqInwwiEyhLBYDm4jsDjkAwrP21f96/OnOo9BJxKEJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420266; c=relaxed/simple;
	bh=OO6p9eFWrsDG+ny6BCXSPmpCvQizfjwzRLM+zuPymjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CaxTe5Zh9H6XsiSCEG81S4vvHw7PI02Ca0eZg9DUcb2tcFu80QCceR99Ri8q9ZPDBEAj+BmnqFpeyIkMo29pe5MQTP0Pt5IMRioUCU3HLMo7NYvqB8WtdGbit2m0ZP9MobUh4QEofiJBhxKnWTcBKrqgwG1EK2+M07zVl4N7d20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMwTo/dh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hi8+4Bkg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMwTo/dh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hi8+4Bkg"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 460531140137;
	Tue,  8 Oct 2024 16:44:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 08 Oct 2024 16:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728420263; x=1728506663; bh=tNPTYb8bFM
	+HSasTtrKnyXodtHtFEbFGDlKx3piB6xo=; b=mMwTo/dhk5UcgWg1LYCnz0TV9U
	Wsqawsuo6nQLiI1kdNzvMLnMVUG165+TyfS+wKT+1LhHMKTT0bWAeFLhqZ6iSTL1
	QSNPkv4UfNy2Fl7tp/Wq7LvZrtYkQFJjgpSd8IZ3pTyefchbVVEhtHcxpkTuv6hG
	TtBFyr7ISnYJLFqAIqqnKX/mWfx04Ue3abdr75cTPlqzxlVvpmJVzkHJfQdmvhTO
	MNYtTJbphnMvoPpi9MSPE24s9/1Qaa/E91AyZaqsyn4g6K/CWonX/+otpzwNbJ8U
	hHxucyvVvHK1WH+hxa4EK8FypwPuefzPM65ZPRKQvz3Q3Jv9W3tIwU5Cnitg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728420263; x=1728506663; bh=tNPTYb8bFM+HSasTtrKnyXodtHtF
	EbFGDlKx3piB6xo=; b=Hi8+4BkgaH6hykqolCqPKu26xPjdeM6wL4BKN/L+ZSW5
	dZ4S+pEDf0P5SRonZydITi+OwygF68FAbxCfzLdoCuWgLDFkkxDZiKOQf/5In5pb
	MiIp8B3PEQ06AhTBz8TXmIx8K6YRb7EkICfj1IQl0FoW9JS/mHsHke0sH+AWo+Q6
	weYleHFtG93KF+7ycOqUDF4HU11c0HMZe//bHp3VqP8RENG07NZNaImxJaQX6Xo1
	/8BelbAyP6EyfLKSu8vja7WzAXrbuNq+5MBx1fEVZTrJ1B54Hl63HPwo1efYUqFu
	yVBMb/gLe3/WsXQJS/etgYoXIFUYrbDdaYb+3QBu6w==
X-ME-Sender: <xms:p5kFZ8-oadb739JYrEeEGFZ8ek5SMv3_RNZjIDAUy_mbVm2_k-TTOA>
    <xme:p5kFZ0v2cKHmzL8rcjc4cy-7wLlg7MrYyNyYLrUD5I-oG4ZDt31r6R_xIu1g-ZNS2
    qTs39H3XjTuTTL0eg>
X-ME-Received: <xmr:p5kFZyCY5Eh5LxfJbkiJVqoUgeie4gE0m2OdYi_dFSQ7LrT6kzSYKPn_QnleeTsScKUZF9aJKZhlUyK5HBg-mrvRJzmSVezKPPlB3do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p5kFZ8fxZKx6PXIU41EPNC850LWDNs9SCRSsPRrRJcSt4y22tdN7SQ>
    <xmx:p5kFZxOA68kxB8vk87zuhUWu8rEgMef2lvALUnqRIpeytmJFJyAnwQ>
    <xmx:p5kFZ2k2wZoaiO5lx_app_A2nc1kOu1dcb8-F4WR5MSpCmz83lrc5A>
    <xmx:p5kFZzsSkCQeCeRtWL4ge9SHhHg_ZiAwoler4W1KhNN1x6feGBp96g>
    <xmx:p5kFZ01o42j5B7EGfjZO89djm52Szd16pQ7v0gu9AUmCXFkmuQrJC-X6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 16:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  newren@gmail.com
Subject: Re: [PATCH v2 2/2] doc: merge-tree: use || directly
In-Reply-To: <13e0f3bed5dd894ee692c672b301697e0a909e04.1728413450.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Tue, 8 Oct 2024 21:06:06 +0200")
References: <cover.1728298931.git.code@khaugsbakk.name>
	<cover.1728413450.git.code@khaugsbakk.name>
	<13e0f3bed5dd894ee692c672b301697e0a909e04.1728413450.git.code@khaugsbakk.name>
Date: Tue, 08 Oct 2024 13:44:21 -0700
Message-ID: <xmqqjzeiz5ne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> -       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> -       test $? -eq 0 || die "There were conflicts..."
> +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
> +           echo "There were conflicts..." 1>&2
> +           exit 1
> +       }

Makes sense.  Was there a particular reason why these two patches
had to be done in two separate steps?

Looking good otherwise.  Thanks.
