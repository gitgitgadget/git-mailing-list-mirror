Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7402690F2
	for <git@vger.kernel.org>; Mon,  5 May 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467259; cv=none; b=iXOtiJXJ7JLo4ZBl0mbvusZiHfgwNEHV9PVxcVDh7vQAnY8HmpoZAsnz/zLv6UnCY8qemPnMZzVNSLSvH1mvzCMlMRE2OvE8m2q7htvoeIR2SVZu07o9HoRa6uFz1g0HvMt2XU7q5BvjAg3BTV9bxLYaBRSbAiIkmqzBfbHYfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467259; c=relaxed/simple;
	bh=wPDEUsOhcCkNLto+w6LiH7VA/5bcB0dzase/V6u8tEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgTARkZXN7sdMWCelaTfpmOc0lezccCIw3Wa6A+fefyzmGzu3h2UpalkcMT1PO5DYfqgGZ1lqCYLeEoz5/X/92gx/hJStDG/bpJfcgfpe/qcJMIAxg8EseyBHxyim2mKVRUy5axKoiH4sam098HimPUF89IJmDLpQtVVjOLwMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WrU/MIDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Do2lMeUa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WrU/MIDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Do2lMeUa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CC5E71140213;
	Mon,  5 May 2025 13:47:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746467255;
	 x=1746553655; bh=78rrv2L12JCIDg7vGLZt+QKNcUZPgCDdq19YXpzlWXA=; b=
	WrU/MIDyjA736UHo8HewTjAAlEpAS/dCM8SQShJaDNYtPSD5iyxUTEj2H+Hki4xW
	1l94L0yubADOQy2xd/4UtdECRNJV+nzpKFbufENhXahIDjBkHU7h2FjNMvp5EjUx
	CrGXyE8ko4q/5Ixs+BjI+NmZD4EtmyetQlaOYjKgwYPODIH9rMQVGwB2o3Yu7ksx
	QhXHPugjDC6m7o06BhU7qkDVQYQ/zr8yac2GXwXtE0kudgsHl8YtcvxK3to5TEFO
	7HYA4We5IbZ4f3bgULXgGKYkTGvXv3qWy2phgGjCW5LuMVFPgEU1vPkzbep7KmL3
	HNLFInsCKHmoAMyi5ACs4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746467255; x=
	1746553655; bh=78rrv2L12JCIDg7vGLZt+QKNcUZPgCDdq19YXpzlWXA=; b=D
	o2lMeUa0Wg5q88sTkchdsGnOX4MvSXsEZLuXAmh/sjrL6t+Rr3ZztwAqMvQ89pgG
	IlUj8ZAkt3tNT5VP/Ti7EMFw11h6l/LMVvuVGtcKIjL1C33owrVTtlMksX8EJiky
	krtNWFbNBQRgSBAKIZLCGsHSoCZN1gxUYEuG2QtJZn84PcENh20hMgXFsC6lkQsA
	ux1b4w8OUQaNq+s3L+VABivadJMXJs970q9fOtcIw7f+nWme5jcE3MsqOzDEj35j
	KaHZPXBYusrdM+aSfYlOq29NfzJCTZmQ/i1ejIHgQD355hy5zoFQ9AlXJECCA7WY
	hS1B3RPk5pVQ9wyFl7oEA==
X-ME-Sender: <xms:tvkYaHjFuGi4VNjX2qKH5vRVh3V8b3Y-lkePDIJ5LFtZ39VAWVb-6g>
    <xme:tvkYaEAArPpgBJ8glFkLFj3bdXJZHa14ldkTOnHJ9rfiedm9u68RpbL9_JiSNLfK1
    zg8k92xnROYIN-KFw>
X-ME-Received: <xmr:tvkYaHHz1fUCiYbA1fqscn5oLzagutY7Dz3EweVmuQZMAju94EeWV24J7OFqQYZ8K1Szfs2Na0r6B4ROld2UFiRI-Od16YOQfrjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tvkYaESZ35NwRY8h6nb8aoiXB6pkWmfduvZ7b-n1WbIiG_UDJ9cKHw>
    <xmx:tvkYaEwe21h-IFRmrF7O1VT-9St0INbXs4BSLjlnELoeBr9_vxeMDg>
    <xmx:tvkYaK7Kegnp1Ij9yVGO8TPpOTLQFLpwryS0swk-AKUMxk_RAR0n6Q>
    <xmx:tvkYaJwxZoopXIhG2j6sNhK7HdijYDxrGn3jUlbCNK4uA-BM5HM6AA>
    <xmx:t_kYaJV7-TkxbaUt_yyK0RkONNPADh1AXO5MIKDLy_QPKqgn80TKpJWo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:47:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH 0/2] doc: fix subheading and inline-verbatim
In-Reply-To: <cover.1746299135.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sat, 3 May 2025
	21:13:07 +0200")
References: <cover.1746299135.git.code@khaugsbakk.name>
Date: Mon, 05 May 2025 10:47:32 -0700
Message-ID: <xmqqa57rosp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> I found patch 1 by accident.  Then I looked over
> `Documentation/doc-diff` and made patch 2, after
> finding out about it.[1]
>
> 🔗 1: 


Both fixes look reasonable.

Thanks, will queue.
