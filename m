Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05AB1509BF
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480661; cv=none; b=gH8mXSuQf88E94e7uVrAuWmC3w6PuEKpkqYIgamttrLOY3kPWjzXVo2r9PELBkA+F4+6j9K+Do8cHXXNGhOWZTLrmzjInGGtwnULLLfU/wZdOA3OS5RnuJ5OiQIfKAuwNz7V+o/5iqiGjf6MCDsbwlRzUzVq7tUE0djzuRi7JQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480661; c=relaxed/simple;
	bh=l6nIhybsVOkWoMI+aMBwU4UoZzYOGyPgshOHMF6eKTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Evr5H5ecY6MY1Lj2F4KyC6nbgpNFvHyttPPLBtJVbCKmuvO4kKlzx0iB0jK4avFVXGqatRaUfaJGfCDfYlxkQ4Tcz1NOfr/6bJDhpd4618xAAfUVKCJLqssm9ewPX/pZm/El9TP57zuskVu8Q3n2qdTFzVbrF4NaComNHJuYBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRWT1EB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOsl9Wx8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRWT1EB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOsl9Wx8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A14251380267;
	Tue, 21 Jan 2025 12:30:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 21 Jan 2025 12:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737480656; x=1737567056; bh=l6nIhybsVO
	kWoMI+aMBwU4UoZzYOGyPgshOHMF6eKTY=; b=iRWT1EB/QWeRLszsMxrpG/orcv
	X1zg+bBp3jnyfreIUlYtzN5uow1EUHHoMQMRTYZoSPAEWiat+Xhi4pvZB8ROI/ha
	H1Y7RGE8OObUBrGWtUmCxHG/ViHPirMpS/vqFdwAPFu2UpqemC/OFEuSly7X3THT
	128pDFkY2OgeWu383V4EjktWjgdzlxHmH98JL9/nUmyBzBPm8cJ2xlxhnf6U0jDF
	VDHIdhg9yirU5qy7L+EN0znIiN0zrUxYKx0+DaFPxc5tLvB4WWvZgRRruv6jeNsB
	o+ob6DHDDOJFjYk40w5Mwx5iOomJVlqAczQhH4WIRbomKsFFX6zNTGKmnu9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737480656; x=1737567056; bh=l6nIhybsVOkWoMI+aMBwU4UoZzYOGyPgshO
	HMF6eKTY=; b=TOsl9Wx8dj23Or0r+oJpL+OUM+9DZApJcF66THBXmcmud/F+Mzh
	VWl+SYHRBW4DZ6ZqGIiPWLsJcKRm1f4eKM8Ky5VWvE7qQBexW5KKVBWC2BrtyOi/
	pAMBWhWL6Sd9O82kme0jO7OqoE7ZvKiTxRw4WfuIqyNMAPySlLyf+GWjLUrtFIQv
	wvETnlS+HA8J+jI8S4W3fWeUB0K1HpRIGRRaU9tJiXQz1MZZpcDtLpRHlBjKBbcY
	EtdlAHdS/+JYo210h4vC97Tvh2cqLBCb4DuMYOzWrFyRxU+lwHPAhHbRS9fimoTk
	xYVQ4J02Gke2WxJ/KpgZoTgmHDRyM9EjUhQ==
X-ME-Sender: <xms:0NmPZ0ln5N55gDfTDrceGoEJpoW4YfkU8ee2cLE1ubhdSJsOi2PHJw>
    <xme:0NmPZz2sTek3_2ZczXEAvMVYPBlyz_6Yl4-K-3Za9HMZWU8-todJ9oBFHDhKB7zNn
    GlgsHBCWu0AdiLj0w>
X-ME-Received: <xmr:0NmPZyp8bcQFWDKNmVZhep9r5e12zV_DuDxeuA_-M5_xg3xjLxI4Nc_-8ovT84csMD7RXzgDxNAPUmagZvJqYLdmtkuVzkQRLh8T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffie
    etueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtuhhffhesuggvtg
    gvnhhtrhgrlhdrtghhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0NmPZwkGxyeKTvp-A01R-h5tQh_fEAQ-tq9tp2MgPaj6eUeHG9U89Q>
    <xmx:0NmPZy1suVmgxoGutxTQIRJD7zn8dClhRzwuolUlLuqh5Kd-L70xsA>
    <xmx:0NmPZ3sZhgsM4fgSE5bSYPfVnVLBHLeDqz1b3Lt4XKiNTJGgC2NHqw>
    <xmx:0NmPZ-Xs_vx8fStaJHJZuJifv9rteNPmP82TyvLCE7SKMtj5sVnSzA>
    <xmx:0NmPZ3wTjL_zAHPOMm0Buk1n0ju31tmcwXXLK0mr-aF_4A0e16VA86S_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 12:30:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tim Tassonis <stuff@decentral.ch>
Cc: git@vger.kernel.org
Subject: Re: Erase a commit from a git repository
In-Reply-To: <db7ea8df-2f37-47b9-828b-67b8d3068232@decentral.ch> (Tim
	Tassonis's message of "Sat, 18 Jan 2025 21:50:31 +0100")
References: <db7ea8df-2f37-47b9-828b-67b8d3068232@decentral.ch>
Date: Tue, 21 Jan 2025 09:30:54 -0800
Message-ID: <xmqqa5bk2hwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tim Tassonis <stuff@decentral.ch> writes:

> As this sounds like quite a lot of manual work, I wondered if there is
> an automated process for this?


https://github.com/newren/git-filter-repo perhaps?
