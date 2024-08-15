Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D31494A3
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699467; cv=none; b=rfEEyNTh07iBXdocqIObj99Inf4S9LNR1Ff2Y7r4CcxEnFzx1wnNAEWjMzK2FU84TXrd7mnE3DWZl6lOvbRhRF9CWG+nNDuGBG8pFenjXxnfe5BEF+ayke98T/H8kVrb0MI8xfD03ZtaKmKuIP1v8DmC4K2CuPZH6BvkdnNMbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699467; c=relaxed/simple;
	bh=+AP/1onvdARFg/ntM/3brXwuH+MshhICEJAszx5aC6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=TPejE1khDwTYY/mRIw6zugI4HXlO9EF7OC4G156wgxhIeOMriyEEmjHiT+pZvQ+XTDoHo+qoVUeK5NikuNgFiUXft0sq8hBjvZR01Hmwk6V9C0zyna5FFd31HEh3I3gmbIaQ3W0Tpbac8HBQxwMvtG6cevJyhor/6yug2CxfCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=QhRJIMmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1qDsXwQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="QhRJIMmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1qDsXwQ"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id DB702138FF8E;
	Thu, 15 Aug 2024 01:24:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 01:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723699464;
	 x=1723785864; bh=aQK9NrCAqsgNjWjfcjGbUBAQ58gOuqPOSmiw/czi1O8=; b=
	QhRJIMmzFX6WWBvTbsFCE/1NPBoqNPpjUjq1dOMQnckTjCng57eR0gBB6uYhAmvh
	DVQ58Qb9qWAX3BHepmx87CdPjfoSs1u7aqY/PquUWDkHj7Y4vn0BySrEHmBAA9fA
	KyEW0Z5g96WA29/6O6HjhhEJIwnhXk2yD0/Ro8v5VZrY1MfvwqoqjpGizSY/hWvS
	2r3WK0buZ7rWpclU3y33mhWkyT5Of4af5vA2LtboVcPw0T8Z2E6gm9BHf/yJB8ES
	HsbPZfAZ51uAjxv3d02E2Lxq1hwSQBlsNEDaXnU2KSIILa0YhpSC6T6mlVsQQvAZ
	uCQMoLZZrPkXV7BwLwqx1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723699464; x=
	1723785864; bh=aQK9NrCAqsgNjWjfcjGbUBAQ58gOuqPOSmiw/czi1O8=; b=s
	1qDsXwQ2h/usjbBtyrf5ocYWk6O3oQlfSLhBQQdOXWyqU/7ONd/b4KHPfSxlm0UV
	rYqtuOSc5fb7dc/bjk53QgJpf8C1ItahldIwXMMDr8UW+Jk9cfWjFiC1vD0b1K2P
	e9yreYKIcKnTDPwYpPZcLixO5wpMpKQjyraFCp9BNJwxVNQz1xBaZUer3CiWlYV+
	AwWtdC4RLRNaiZ84rNA2AYU+ofzQtMgQd18PWOOaIatDg7PbiVZ/RDKGQ+7REOVC
	dm5awcotk/dxXvd+0pp3aZbu/5DZDUrGH3iRaIRclpMUjeGRMWFg5uMJ8ts/v+cp
	UpAGpnBz40bQdxkKEHnng==
X-ME-Sender: <xms:CJG9ZqvOTJu5pbfXRgNFvk4kkZUJMF9S12gvNLmkDdGBuE_RtpnT5Q>
    <xme:CJG9Zve8-zh4l0wOs99POAmRWuIUbFPtEISZWY3GeHkL0o9pn95B4f1IuEcVhA0u1
    7jg9Mfu6lrgtYMzWw>
X-ME-Received: <xmr:CJG9Zly3Ccx5QPexb7ahvAbLDBZMvuqXjthvI2PzaR3dwHGtdmlbmiwrRtxe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeen
    ucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrih
    hoqeenucggtffrrghtthgvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheeh
    vdeikeettddvveegieelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CJG9ZlMmk7DjsMVchhJGbHWWOo-5pdZtgaRoLx156-CBj-t-EEPA8g>
    <xmx:CJG9Zq-n3e1nlhgGXSSa01r6cEGAMwlN42bokKKHfs79mSPSk_wePw>
    <xmx:CJG9ZtU7QkQwubBOWo-hzimhgU0qmwAcCvG4X-xzjSMXqT1aLxEsvQ>
    <xmx:CJG9Zjdp7uJSKAwKQy__04tf6ZgoCnYEuZVBWpdYyaG6303srZ0pHQ>
    <xmx:CJG9ZsJbzv4qyv88MKn3YwwJTIaeUxSvdyYcfbom4i6LixOMoQTnfJAQ>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:24:23 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 15:24:21 +1000
Message-Id: <D3G8GP38BNG8.26Y1ZLIUPTWJB@jamesliu.io>
Subject: Re: [PATCH 2/7] builtin/gc: refactor to read config into structure
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1723533091.git.ps@pks.im>
 <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723533091.git.ps@pks.im>
In-Reply-To: <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723533091.git.ps@pks.im>

On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> @@ -206,7 +224,7 @@ struct maintenance_run_opts {
>  	enum schedule_priority schedule;
>  };
> =20
> -static int pack_refs_condition(void)
> +static int pack_refs_condition(UNUSED struct gc_config *cfg)
>  {
>  	/*
>  	 * The auto-repacking logic for refs is handled by the ref backends and
> @@ -216,7 +234,8 @@ static int pack_refs_condition(void)
>  	return 1;
>  }
> =20
> -static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_ru=
n_opts *opts)
> +static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_ru=
n_opts *opts,
> +				      UNUSED struct gc_config *cfg)
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
> =20

Are we defining *cfg as an unused argument to conform to the
`maintenance_task_fn` signature?

