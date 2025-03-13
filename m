Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AB142E6F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886491; cv=none; b=YoVWP5Tz3wwp+958/NferQuRWW18JxFDrXcdEsE72Jiv6a8aiyFBkzbG33uFQZBOe3V7uzbMlzII2c6HmFzxrZuSL5ixAJjvwQiHaU87te4aV0gNshoqX3yGhFxZ8S+SWBUodZXdOMMLpwQ2x17xC0FHrxkxQP4NlKg8hpaPzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886491; c=relaxed/simple;
	bh=u7nkfWC4SzEomuvH9M6UjRN6DnNLmQYnu8DuUIeZLEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QScPhhjZgsL6K9eJwlVJ3+toXVvgzqD1/Aab/fkP4E6AU05oHxm9osXEUCaqLgaaRM/hMFtWW1tbuJZ0z5Zu6COOfakn5JuLysTlT8eQqbgB99jA2cquMTgwG6X5tJNU8wQ0QzMkdBQHHtNyauZyIKDI9R1DEiNmGaFGR8sUAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g18F0tmr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qeZTPunJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g18F0tmr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qeZTPunJ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 152C71380A52;
	Thu, 13 Mar 2025 13:21:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 13 Mar 2025 13:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741886488; x=1741972888; bh=brO8O5ccZo
	QjKr1W7+5OS03NgShYBGIoLpHDuTFkqLQ=; b=g18F0tmrIrY1WSFlpSt9WjY7zb
	hKFQB7enQYj9pmsoLKKYrkAr1EOURtydlkhDrq+I9g3h5gjA7FXG42dMt0gIOMOM
	reuLPoNX1pJSzIdtVtqRwVagV1VG400YVW1U2x8H7sXc6y/N2MMXO+VnSrbVMOok
	xwBl5aNR9cOptwbBtIbcw/ksTlV2RIEBa0ZEDczVCMfefxsuaMAWk0KePtE9Gc2b
	vA1qf320KpcPkotaAYvnoWwpOkg56wxZ367CZtUc2GnZraRwQ2id8zvJLA7tU1Ew
	ZPAZ80gLBiwIl10I7GXAEnsPVYrtV+eoAplocxyUu4KarZFP2EWipRfKudSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741886488; x=1741972888; bh=brO8O5ccZoQjKr1W7+5OS03NgShYBGIoLpH
	DuTFkqLQ=; b=qeZTPunJgwD0IwcXWmmXcHT3XMktnUhMaDcxbMORL7BxErvf1wc
	DwjmTgIUB/vRe/ge/pb+jD9SHPsvGyiy9KU0Vl1C/WxMRX8dV6SNJGjafxfXN3id
	vt88Wcxar3xTNPnQMDk4AJLZBsGem1Jf05M63Jp6PyYNTkNKcKIYeEG/LZVnZW98
	4vsTcWxRnAtUSMjvPUWPk3ZzoEKBwZlCTicq+YAZgtAfRyBm72Od3/HuwQbM7hNN
	cWWQpk6v/8h0Qq4sj2bQNNTIEU1LQn676RaS4wZAmKspePz+ovVhSKMcVLOyeP/6
	88biH8yVV7qPMiLO3M15idz388r+mGLJbAg==
X-ME-Sender: <xms:FhTTZ5z6Iu7bHNTkGidHFnQPo5Gsn-z3TGB2tfDst9i3kE3GEFoNuw>
    <xme:FhTTZ5T40mlaoXQcYjP_y670jALvpqkp3-TMAY2n2alAwGDhgw_odPN6UfOLJUFJM
    OOE_uXMecftPztJ6A>
X-ME-Received: <xmr:FhTTZzUn-RG0I7t3n1oK46aEAVZ77Ms54j3Hw5SSz0Hs0monG4rwgs0UTzoYpu212vDP85f_dinS9rYHNcFYNnX6Xvr9VeSQVXxXO2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifohhrlhguhh
    gvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtqdhluddtnhes
    ghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdp
    rhgtphhtthhopegrrhhksegthhhordhrvggupdhrtghpthhtohepsggrghgrshguohhtmh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughjmhdttdhnsehmrghilhdrrhhupdhr
    tghpthhtohepsghithhighgthhhisehmvgdrtghomhdprhgtphhtthhopegvmhhirhgpsh
    grrhhisehitghlohhuugdrtghomh
X-ME-Proxy: <xmx:FhTTZ7i7DuB-U-90kb9cwOV4UZN-JOBdjwX7WBIC9dxp4fQQ2tQ_uQ>
    <xmx:FhTTZ7AB0XyAuc2Igg9N5Ak_gm4bll3SxF5h6VcU1z_Rz_UhOExsVQ>
    <xmx:FhTTZ0J0qJtevpjZGxAzIHCVfyAUjkW1rJaThxr-swnJFP3i_masJw>
    <xmx:FhTTZ6BdonqGjUVXsvMLHTYwad9ORL_BSw8h2jcbVg5t-zmHwcy6dw>
    <xmx:GBTTZ6Aa6dnXPlADpRZGYqVcFtS7N5r2SfQK_GPeHR-XmMeoM2c_kab6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 13:21:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git l10n discussion group <git-l10n@googlegroups.com>,  Git List
 <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,  Arkadii
 Yakovets <ark@cho.red>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Dimitriy
 Ryazantcev <DJm00n@mail.ru>,  Emir SARI <bitigchi@me.com>,  Emir SARI
 <emir_sari@icloud.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Mikel
 Forcada <mikel.forcada@gmail.com>,  Peter Krefting
 <peter@softwolves.pp.se>,  Ralf Thielow <ralf.thielow@gmail.com>,  Ruggero
 Turra <ruggero.turra@cern.ch>,  Teng Long <dyroneteng@gmail.com>,  Tuomas
 Ahola <taahol@utu.fi>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,
  Yi-Jyun Pan <pan93412@gmail.com>,  seoyeon-kwon
 <seoyeon.kwon@navercorp.com>
Subject: Re: [GIT PULL] l10n updates for 2.49.0 round 1
In-Reply-To: <20250313141445.110468-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Thu, 13 Mar 2025 10:14:41 -0400")
References: <20250313141445.110468-1-worldhello.net@gmail.com>
Date: Thu, 13 Mar 2025 10:21:24 -0700
Message-ID: <xmqqwmcsonhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.49.0.
>
> The following changes since commit 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3:
>
>   Git 2.49-rc2 (2025-03-10 08:47:08 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.49.0-rnd1
>
> for you to fetch changes up to ab7cb7e2634bc84e87074cff1035efcc1a5ed27d:
>
>   Merge branch 'l10n/zh-TW/2025-03-09' of github.com:l10n-tw/git-po (2025-03-13 21:57:56 +0800)
>
> ----------------------------------------------------------------
> l10n-2.49.0-rnd1

Thanks.  Pulled.
