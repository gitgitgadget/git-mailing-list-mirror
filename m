Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661501FF7D6
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124758; cv=none; b=QHt9SnmT6+SL5EMr94vM9TJ03HvH2eeixDTud/dH5qlCG0AT2XuQ2REtXfRm4uvsBdA0N1NSU8Bo8MU6YuhAm9Ck+gGZ/87zvasCv9O20tbkKX+q94g1NJhLrVbgMWl1rWuNBA4RNeYsoZdAehg8Yx6znFI0PP/lQ7Vbeg8OBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124758; c=relaxed/simple;
	bh=HuO4TxYoa3dEB7Epq50RDgL9A0aocrav/vNgjrRq9qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5+HRKTv/X9i3e1QPDBPHLPnczZvO6n8gZzaGCUJGSSsDYKBCTl7brEmHJxeFc9Phdv2MhiGiFV4Xggs0FOcDeoWcNiK1BAnMSYSWzAzvqWJ1Fp2rjBB3YIjRCXTgiGFLn+fn0CgHrP/m7Wuv+WQHjmokBev7GdwT7bdkdtcunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOmpDV1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4N+OkmOM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOmpDV1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4N+OkmOM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75171254024D;
	Fri, 21 Feb 2025 02:59:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Feb 2025 02:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740124755; x=1740211155; bh=NvN1fyXx2I
	e5gFec8Tep0iBYB9D92PbEO4hkqY6jikY=; b=iOmpDV1CRflep9oPjPE8FOI+/x
	bHyfmidl0wn0RWpzpznbfzqrqICCTlKPGQhtnLqFyDQYt1FwhCin2bSrEK0sPuFQ
	TvemZ5mF9LHknx/jSIyohA75i2I9w+1Iqmucy2/a9A+BfTTZ+qhl+K3PuZrB22Me
	Des+J9LVah2KRDB+IBCMxWVlEoXJ8QcPYZOvFuWocoLobFox0kFofguWXPUJyLK1
	I1FJaPdGdViELi6p/KclQfPay/CYwj7t4692VQluxqyXbgraWuX6jTJ/RBcmavp6
	fkdGChc3+43Aj47sE9KJXpY5m4fnQZYDXlvCMankcNQdcViub89KqoGz236w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740124755; x=1740211155; bh=NvN1fyXx2Ie5gFec8Tep0iBYB9D92PbEO4h
	kqY6jikY=; b=4N+OkmOMNa8ai5jCjWo7WAXwseyRuMi/4CFlezJFFlc3c6wnVwD
	v6cJWzkP/4nqf7O/avK+dMQO/sIIOMwNPPN06/fFcKcsMgO/yujTfN21KnCiZXlO
	GVoKy+kGczb25bNoH5ahX91gMAGwss1Hzaw45Nz7EqYzu3+Jhxs/3+JHzoszVzxs
	wl8aoQTIA5sS9xRcrJ3DuxC5ZYw95fEUMWIQaFvZXlCYoth+k+FKNvvdhAReePUP
	+2nVw/ycVrXmJBXmyec1Ijp1U7duaAVxfyu+hKbzy9rG3pXQJbXgFUfNZ+HSWX7r
	hMA8/3GMTU/6Y6F6j66poujo10XtCoPXNfg==
X-ME-Sender: <xms:UzK4Z4tN9tv4VNRxI2R9TqGiwqA6StAUy-1BFQ9XH6llyc3jnXSLjA>
    <xme:UzK4Z1cCpD8OgHrzClGSSDkPa1oyVxgchGvso4GAwwDZP8XqmGXURvrn7nRfGhzxP
    SdGZ_Kf6HQoTfLjrw>
X-ME-Received: <xmr:UzK4ZzyBgwQBj0Hf3Mx8zoPDrpORzzE12mmLmFIp6nYGLHc-n_S6LXxwMxYew9fvTQTxNGktaK__V3K9fIfiDiq4r2lwskYBC55xPfbuYjw85A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:UzK4Z7NaTYJHuh3Z0G1ZkkeI-6UD1wYUv4DMWLbsW6cIrfIjTsLzrg>
    <xmx:UzK4Z480tA3Ck8YyDJNfLEX7dlOW-6_7kDGCSz9vV4_kAdn5aC2Lmw>
    <xmx:UzK4ZzV3rbNARU5VLicEI4bHaMUYTXNv8IumnsD2f3WZ6JcTt88-2A>
    <xmx:UzK4ZxfxbqefVb5ZuOXVttP43N_blF0bX1-u8bJ9EPbgPZtDP1KNZQ>
    <xmx:UzK4Z3aut_F_o8Bhfs6IiI43TgH_LXhvNAqxIGGDYC5Q2nmYjdeYXYjn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 02:59:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e9c9359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 07:59:13 +0000 (UTC)
Date: Fri, 21 Feb 2025 08:59:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] t/unit-tests: implement oid helper functions in
 unit-tests.{c,h}
Message-ID: <Z7gyUBVi6PTtoQul@pks.im>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-2-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220082959.10854-2-kuforiji98@gmail.com>

On Thu, Feb 20, 2025 at 09:29:55AM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
> index 85e5d6a948..ebed51212f 100644
> --- a/t/unit-tests/unit-test.h
> +++ b/t/unit-tests/unit-test.h
> @@ -8,3 +8,22 @@
>  	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
>  	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
>  } while (0)
> +
> +/*
> + * Convert arbitrary hex string to object_id.
> + * For example, passing "abc12" will generate
> + * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
> + * create object_id with that.
> + * WARNING: passing a string of length more than the hexsz of respective hash
> + * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
> + * environment variable.
> + */
> +void cl_parse_any_oid(const char *s, struct object_id *oid);

Nit: let's add a space between the function decarations. I'd also add a
blank line into the comments before the "For example" paragraph and
after it to make it easier to parse.

Patrick
