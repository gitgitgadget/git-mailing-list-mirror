Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB91B4122
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475450; cv=none; b=WjC3PyZWl5OjvcCDkWo7+tZxYzf14CSQSsnPfnED3xgV04bSLaCR7b8p82Zx58ZDXCZAor+aC07ehhU8YZDM2TlXklqrIrYoRnQvoSATNgBUuXRmTB9mzdfI4N/3a7yop5FummhgCJZbhEpncVTXtqVtuJPxcXxPnOZx66zE7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475450; c=relaxed/simple;
	bh=4aMxuG8eTqKEJ+BLb9bB7ezNc4NE18UF7W7j9w3KjJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEV4W8GcTIAQy7OFnmKkGvqvzVBbA0/wlg08/rXuSaozBd0hwVXo6PW/sDWZHuAGE9ByQtXUzZSah0g4gdJayJcWEycW4/fZhzciUqvXd7Ih2c6J37TevIau8TK0GdtbjDvSbBfGgOyuCGKY/zJytpna3KhHNgBzDOEshiUMkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ei2NgUR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1JgetBZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ei2NgUR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1JgetBZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 897FB2540116;
	Fri,  6 Dec 2024 03:57:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 03:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733475447; x=1733561847; bh=pNla7x1eny
	aDMgOBVi2v+lUSp4fsmh2UUvUpVt8q+Yw=; b=Ei2NgUR1OuGnYbNhoTrrZlg0tX
	2nbcrKl/R7/DTgfSlnLAs4OKkFQ6yqYq4MskUwoNs2eIz28YIrL7rW7iXDV4NqOY
	AU0JNbTgqDMReFlP6ipRZ/jumrGNQhL6v6ZwYbXApsDppdT2lyZISYE5Iy0dq7QU
	pa8qzg5rNDNb8e3DWg5yEnS0uxmfOZRp3GE60FxeXdqZlrtu/hhNAl1azLWZwix4
	2LrTC+kYVkC+i2OqUrJCW++PoqXoIvANkWhZ5AakXa2sVx0KqiAYdnuFiCyFn117
	Ve4Iw+VuFScLeD5B4SNb1XNZpQmiJ0xkR7YS5C/iOH9dA3gf+thCysOizYIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733475447; x=1733561847; bh=pNla7x1enyaDMgOBVi2v+lUSp4fsmh2UUvU
	pVt8q+Yw=; b=a1JgetBZbc1UnGpuXpwZ6WNBwNEucwsYh0sT2VxsiQoVE4CSomV
	QuLgoRSIpvleg0VEYDNHOY0W19ziKy3Y2g8158VNYgD/sgDTh+RPRtpD354lUEst
	Do780SDJXJ5gyZIOwfMjlgdnBl3bKsnq1eBsmsRyZ5Dw63ImxEDMFkRl9Gtu1sUM
	+RdvpQA6H14K6L7dgWUlZ5Psayl/cIB285fV0MZ0K/pWTfVommEn9Q75XjN8Esbd
	B/78mOHxl7nBrvcp/E+7MUTC+WqRAdY1686tcvKhGDFZTkb4Gz0iSccOJKmPXoig
	sF8HYPRyZDjGn+CuuMH5c+DjyO6gaF4GR6g==
X-ME-Sender: <xms:d7xSZzMIUkbayM4GhJE6Ke9Y5fLszv7XbvDBT5QkKKzTFsD_-88FDQ>
    <xme:d7xSZ99rRbWUzKlr2bME_JC31kr_yrVoPm3YAPtyXzBDpRk_ZYYQCynU7SBiU7g05
    A0E5m8LKJv6IVpxmQ>
X-ME-Received: <xmr:d7xSZySgbVg3XXRhbqpWPcCOdmCPUbSfzWMPORWbd_T-6818-ylOEgneQzpGr5of4pi9YShw_RLfSLzWEa9A2D5p0Qz_sqvytW-axpClIpwXuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghp
    thhtohephhgvsggrrdifrghlhiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:d7xSZ3vzoEI9rszelYpAH0_4whue1KCGZPoh6zHs2nk1N0HYy-JqVg>
    <xmx:d7xSZ7fx71T3fIrL05faSt6wNWecZbb7HY7qDSnKxzDOViyEwipAbg>
    <xmx:d7xSZz3x7sQVheH4bII2NOaAYwv-F9eakjrdGE1uUNYtdN3y6lCxqA>
    <xmx:d7xSZ38WU0MwVO1p9eQPlWybccVOiYCU26lussNWaEZBuB9uAaFVYw>
    <xmx:d7xSZzTgbQEGKt3w3drxZwYtWaN1vN1hhSw_RvZJFl9H__HdJXL1ODvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 03:57:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 552a2d60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 08:56:00 +0000 (UTC)
Date: Fri, 6 Dec 2024 09:57:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Heba Waly <heba.waly@gmail.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
Message-ID: <Z1K8ZPF9eOqQYsqf@pks.im>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205122225.1184215-1-bence@ferdinandy.com>

On Thu, Dec 05, 2024 at 01:21:58PM +0100, Bence Ferdinandy wrote:
> The advice message currently suggests using "git config advice..." to
> disable advice messages, but since
> 
> 00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)
> 
> we have the "set" subcommand for config. Since using the subcommand is
> more in-line with the modern interface, any advice should be promoting
> its usage. Change the disable advice message to use the subcommand
> instead. Change all uses of "git config advice" in the tests to use the
> subcommand.

Thanks, this version looks good to me!

Patrick
