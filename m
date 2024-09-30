Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487C1991A4
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720326; cv=none; b=bZXFE1N2MKRZWs+brXqrUuTfxqQlUDj5UArjLSp4FEILP7pKJBPObVWAnt1+OcmacHfO4a+XMOCB7S1TZGWgzqQk4rS/vkk3PgGfQge6woWwTKN9+z8h3RxQ4q4aWylUdl5BON2tL6MYt3d3rKGBXARXjtsAbCscHOJVLvf29l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720326; c=relaxed/simple;
	bh=Ffs1OR8+FagUCWuaGXZFkVgjqpSb8U1N8d5nDo9ueps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQbOAth2syL7EX9wWFSLFiOrUNwSJNbp82Zd9SdhXTwdZpvXbOzWm+8Y5UDVsVrwPRsgEzl4ARB63ugYSDBuAhJxfSQfnncMF0n3mdIoPpvq5eyOye0m1c6ZZv15bEqUswJRSqMtK5ifuHjAxmEEXt3qZEF1qDd1oh5BsqImgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AEU3BO8I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWp0KECt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AEU3BO8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWp0KECt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A89B13801F4;
	Mon, 30 Sep 2024 14:18:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 14:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727720323; x=1727806723; bh=Ffs1OR8+Fa
	gUCWuaGXZFkVgjqpSb8U1N8d5nDo9ueps=; b=AEU3BO8Ih1rOnHajdkMNcZQi4H
	kPD8FwRWkNUX/b4sUUa7QqZ6G1MPt1iKB5jIC1cNZ2TnNNEkj46OMCNNGZqupZqt
	GaG0pZMasosqPO/ZTtgmt4PggGyN3+K+qkMH2Ur5evP6b8CFdOAoZAf4iBTEl8Gd
	FYy7X9wR+ruXvQCepIcbHhLiKgGOnTaJGOQOVmHFDl/QJoflWeB1BD517sh0cbxF
	luheR3u7kpVwMCOYTa/4qC2P8i345P99QGx7exFdBrufVpXM5dWr8l+5kiF/Mt5k
	FiR5MIlBFTA9g4GLg5S64phpDnWbS1f5o0OKn8WsFRKh2ExZG+Sl/ELgZ3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727720323; x=1727806723; bh=Ffs1OR8+FagUCWuaGXZFkVgjqpSb
	8U1N8d5nDo9ueps=; b=UWp0KECtd20PEa8oTY1j7i1S8VGmu+ssWw5VcP+fuWLQ
	/oV9Bg0d/WGpHH0zsboshWMBON9ns9nBKs+2mYtEaU8y1fxWXsHlxqMRAYoFJgsm
	3jOTGvM9QvctiT+rIOYHikyf5YQ46IOojgC8p1OUo2A6/NZws5VMuy1p7mV4Be/p
	m8d5IKrTQ2/fgqUXydKrrI8eyu/8yVuXnsHMMllObj+YCjBDLLDAnvytTsrhaCzK
	Ycbwr7oVl1jhtslXW/dCiYUCIYKrYPk7l8Q/hY0Cbx2m337EqaCoSy8fEHMd8Zhc
	UjDVAoRnZ1uszCAQhDAEPNwuDId4Vlnt6acX2NQf1g==
X-ME-Sender: <xms:g-v6ZmGBidy31FN2sIWPd7SMGZGytWOO6sulo4oiC14wNlYUY0XYvg>
    <xme:g-v6ZnVYKxxGccESmoZAjD_nueKeptFR-fOFbeXX4-342T7IQ6JlnSSQDrAZW6J7-
    jQXhQq6jvI1qS_jAg>
X-ME-Received: <xmr:g-v6ZgIgKumbLJ1r7-Q5_EqVbRgs1dsRZZqtyVHvYaKBKhIcnKS84frYfsxMMC3KmHcLw6les7ZzCGO_HOIbKYd8BzMhElRawhO2sE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:g-v6ZgHZbKKou7gVee47ZdMNjtBL7lNnxM3dWowQB8mfpvpJ8N8YOw>
    <xmx:g-v6ZsUPfxra6SDFMwHUNSc-RHnn8mQYf29WcuOjKuc3arNxEsFAzw>
    <xmx:g-v6ZjNRx1C2yA-EwNehAGqiQtL2Q6dqeNQrr01_NCuD29fFmCBCiQ>
    <xmx:g-v6Zj32cv9VJOx4wh1G4VJchRXtgu3sxnlXAUL82ZqCnMzkwfktlA>
    <xmx:g-v6ZmfK9TA8sLyGPSdAXgRDxAK2jxe8Jf8ISInfWeKEK_A7Wwy-DOZa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:18:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 00/22] refatble: handle allocation errors
In-Reply-To: <cover.1727680272.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 30 Sep 2024 10:08:08 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727680272.git.ps@pks.im>
Date: Mon, 30 Sep 2024 11:18:41 -0700
Message-ID: <xmqqy1396m4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of this patch series that converts the
> reftable library to start handling allocation errors. This is done such
> that the reftable library can truly behave like a library and let its
> callers handle such conditions.
>
> There is only a single change compared to v1, namely that we use
> `reftable_free()` instead of `free()`.

Indeed that is the only change in this iteration.

Looking good.

Thanks.
