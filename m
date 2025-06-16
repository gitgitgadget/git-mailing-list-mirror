Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFFB282EE
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113690; cv=none; b=nHIi5mCv/PFT+b1lQb9KlLUc0z8XhNGTzU/OrYuYda+pdm0Du8z7FewdY4FY/uX8nP5wq4L8tYab/NvnVsGtZjyhdeyJnpTqNvmkyz9hpDh3bqFGpaNwgDt5UWeQQCk6zgDQE2s5HW0iDj/9DRLG89LfWOYF+d30j5m59FNp2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113690; c=relaxed/simple;
	bh=tr7vYLr1m5IJzK1eOZt2aLfrlorRLvDaS/A0pbO8Kho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lL0gYx9CYo1AFmBIScULkbFi88ULDUmH3GLYw+2+IoZud8mZN6KXsS+A+7vM/s8srMuef1xm3JLSPZd9KQ2+Iwapuo8z+BejWL+5NRfkPCUjU716q+X0uzdJqsVpzxP4gNzjdqWBxMdB46/o5cO7Dc9YmxTqB1Bvcpu9P9prLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ma58e5D8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GbpwcrAv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ma58e5D8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GbpwcrAv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 580A02540156;
	Mon, 16 Jun 2025 18:41:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 18:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750113687; x=1750200087; bh=tr7vYLr1m5
	IJzK1eOZt2aLfrlorRLvDaS/A0pbO8Kho=; b=Ma58e5D8WgVmBahCg0XbisPRlG
	XkfOock+rhmRRv3+E1G9iCvztvUu0CdG1us448GXamimMABBJsi8ncE9y+Rn1u3G
	tRaO91gFlnF/U1mp0TgJnKG8yD2O+n12vi7MLMfY1nLf+90Koc+OP72t5eTXBThy
	vjVOdArqN3dY5nJaxfSYQUlEtMaDkZDO+88h0874ZkIioLyz1gRQrjla3UB6Qqjy
	/hAMnQE7v/hnwPDF42rpZUFEnHZGniCSQ89QyOyuhlCSmJkgfpyjdyIMM5zTfODn
	9vP1/xBL78HXnTyKv51+CU0K+jL7q4nP8C5Hf1dfhG0O+2GS8nEPax8EpO4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750113687; x=1750200087; bh=tr7vYLr1m5IJzK1eOZt2aLfrlorRLvDaS/A
	0pbO8Kho=; b=GbpwcrAvefXhEMDlvQ8UH38F206O0pMdMQoHTaiFmd2pqUyFlvc
	tibWQL0Dk1FHu0Tgis58yzkEINGlQFGylMpTFMVxNCNUhJi6RpetCsYY9rq3rit8
	4GK1fahrJfDF0ZMx/ezI8to/JnP46Kta3dmKuGi4k99NyDmGyAZeO04QlaC7HHod
	IG6Q9HLYa4y0BCAx3irESCzORmj6n/N44COwtwMnWK41yRMQOU8OzRGRyXE9xpaF
	SdMF0nM+Nial+6kDFkg1gXmm1JPkCLXNZSjZNKqynyYyMO7VBShaVDdvLo4T/p7V
	LqjHyn8BIEYyvCFIpxzPyoXizZds+rDn7AQ==
X-ME-Sender: <xms:lp1QaFuvmbVn3_7BljQSIevGNr0KGDYVbUL3lX4iWUR9Ev464_IcBg>
    <xme:lp1QaOeH1T9pVHTclGO_6sTB23V0IbJXA8p3ogXBNJdXJysALIoJ2lkAQGuLZL6CJ
    18jsHqd9s8nc_bgyg>
X-ME-Received: <xmr:lp1QaIy_WJhUptvn_sZhmg0H3806dpMATqHER-oPLtUO6FX2ZlYZX845PAdZ54yNiiZoVBEj3G9YOHxdfjnY2ODR6kjoajlPoNvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrd
    hkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l51QaMPC1NtnNQPVnA03dfkv9dBiu4OiGjOOE-1-SYb9Hp1e2l8WxA>
    <xmx:l51QaF_jmaLA5LuLrUhoUrC9WWKnXisKpkVoxBa3QxiXsrCe1qsbHg>
    <xmx:l51QaMXFR_zgqBfPxBFPKReAr6Rm5ZOorDCTHIoxgQrne7OJduDCrA>
    <xmx:l51QaGfEd4BVgLfm6XAxk7OzYFklUunZ5_hxKwb31vDDxMC_r3xseA>
    <xmx:l51QaGKw_ssMHaTR7zwdlzJqdAkAFPhH_4E5K0E4oGPZn0DJ7cXelE3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 18:41:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
In-Reply-To: <f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com> (Jacob Keller's
	message of "Mon, 16 Jun 2025 15:27:03 -0700")
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
	<f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com>
Date: Mon, 16 Jun 2025 15:41:25 -0700
Message-ID: <xmqqbjqnz4ve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> Seems like there hasn't been any interest in this series? :(

So far it seems, but we have been in pre-release freeze for a few
weeks combined with slower summer (in northern hemisphere anyway)
season, so it might have just been a bad timing.
