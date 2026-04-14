Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B625EF9C
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129209; cv=none; b=vB3aaZRawnkxnCv20Mq92ULl6QnWUqpx70qguyRd2LPJ+ZelC4I+WLguUcTN1/rgVxxqNdGGeHBbMZDFjgxIk7xhUi/ixVZDg3FChhtKoq/jnAgdkji/bCwV41BGOelzETNmEP5woVRk6OYxMl3/JKzWGghGtu06K03TTRh2x1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129209; c=relaxed/simple;
	bh=MFoNZFiEWM28OjlRAUzMd/xj053Q/OUVxQkOx9RpEm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OU9onYI2VKKxqwY/j8Qx7/lQc+RO1x/VGQ+tQBjo7sCGV3l+ElcYHMU4VsSjKAU39wW2ud7vD6l3lN/b3sClrrbMOA4vyV9kYaerMQoBT1c/HGYK//5YKfVaGMV79W5ZlmuFRl46O1vLhYCSu6A7z4LIdHeHdObUgXVkcDviH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GyA6LHZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqVsgT80; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GyA6LHZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqVsgT80"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 400551D0000F;
	Mon, 13 Apr 2026 21:13:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 13 Apr 2026 21:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776129207; x=1776215607; bh=ldo+3QfFEg
	ZQQKbQyyPX8PCtI9SDcUBMDgWol2dJYkg=; b=GyA6LHZd4Gg1mkOLIcDXfLdvqM
	urZV/XYXtL5OXbTR1j48zwRXs8J4LjUUMk4EL5IkN9ryJOLas+jWFXYEVZaiS6Jr
	hRiHzaiJINTegon0cW9BAnLl7zVVkc6/CJtNLj/WrIjVaWIwNiGvr0KvTTbIzkPs
	J3xmMVb+2JPV0ptTy12CiK0o1A6qtjWODMn5ajEJoXv6OhIb3nBkXeJslpQHOhjp
	bi6FIzhGnFjwVTAZsCKJayGON42Pd6R65+gZkPWMp/wk+LYrAxgK08ipgn27ZdhP
	Kx3vQRCrTqTeY9SkjHXcRC2oqXtvMDdOVDlLdQ68SX3TlksqL652J/wRp8rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776129207; x=1776215607; bh=ldo+3QfFEgZQQKbQyyPX8PCtI9SDcUBMDgW
	ol2dJYkg=; b=VqVsgT805xs9D7NMMIS9W8up69/F+DKU075EPgWe7EcfA/561Hg
	OX4J6af8C+U8Sv4JoSOg2dFiREsSANdCPIzF4J94pJIj2sNcjwzy5xAWKtkYkUlJ
	0sjBT9DR97HGEZCZs1CHolIMqbiouBcF62MljMgktfvZ+Ha6C3iW6QF66dwQdt8U
	5NRFPnx+JY87ICzaMr53AbBFIWy+2hX2IST46Py5b5PCGOswtlrhn9Z0DZKwRKC1
	IrEP+WiRocel4w1FWAByykMLFuiYbuLWzT/tcvN8OirLJLXiNBDlOaR4f4U8rtkV
	m6qFTqrKYfzIVLMvRR4PbqFVi6BZkHvNfTw==
X-ME-Sender: <xms:tpTdaZWyvybje7kSiPIwi-cLMHU5WMdcv6nOfO0CX4TDyjfjqo2MPQ>
    <xme:tpTdaVA1A-A3aGldQLVzDtjySTaYqhvC7J4yrA0ldHegi1C3rQxyd3D2TYLpf4MWH
    KTQpmOBeeR4zW-82bgz2bbjOg_H6RJQNUcqRsavZFwg6Vgi5VIVzgY>
X-ME-Received: <xmr:tpTdaY6m7lBNQY_6PA0-PCWRowdPHkHi6FHUjMCXRmDeN1izw5PyAWeENw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkeeuffdukeejvefhgeeuhfeiueeggf
    ekuefhffekuedugfettdekleeludffueejnecuffhomhgrihhnpehgihhtfhhorhifihhn
    ughofihsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrfigrihdqmhesthhrqdgrughvrg
    hntggvugdrtghordhjphdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephhgrthhtohhrihdqmhesthhrqdgrughvrghntggvugdrtghord
    hjphdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tpTdaQxlVannPYpSBnx5MX146WgdzoxUa0DwV8HxdTiGAZgpPGaMng>
    <xmx:tpTdafxgRwRlkUMGoyszb4oRf9q9igPq4AAAmw9gmO0-rPmq9Quh-w>
    <xmx:tpTdaYzdd2nSLoW-YVwtmiBKiip4jJyZbt8HVyapCbQdJ6vn58cp0g>
    <xmx:tpTdaZbZOnOjGKGmrGj5SfGnAUl8YVRSorTIqBxopzt-wv78ArxImg>
    <xmx:t5TdaS5829AlCDFRaTPzmPlKBqgXxPYlgJSnD7qbeylNIrnitPr3Dz2E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 21:13:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <kawai-m@tr-advanced.co.jp>
Cc: <git@vger.kernel.org>,  <hattori-m@tr-advanced.co.jp>
Subject: Re: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
In-Reply-To: <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
	(kawai-m@tr-advanced.co.jp's message of "Tue, 14 Apr 2026 01:07:24
	+0000")
References: <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
Date: Mon, 13 Apr 2026 18:13:23 -0700
Message-ID: <xmqqv7due43w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We do not ship or distribute any binaries.  Git-for-Windows is a
product of another group and your inquiry will be better served
there.

  https://gitforwindows.org/

