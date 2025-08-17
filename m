Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3F2417D1
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447790; cv=none; b=SpGRtpSs6Kk3MAlarhocdEwwhkeHpGzoZKcDGqfNvuSD53YdSRVmtN0SdbEQl+3NACCRPU3mY4+PBaESD7OBiWW6mWNyqQ70kQdQVrha8gikETRPNojYTcNpIKCFYmKtTn+VTedtSGtc14Sjotqaeg1wVqttlVarzinrLQtHKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447790; c=relaxed/simple;
	bh=1chwUEtqBCKE1+PIyqcBLVN0cwldkYpjgkgm4i6I/lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MK6lflgrVcPhvdnXrO4Z2sdjvlgNlAi8iXZ47Iv6idNmGTfLUdIjSS1ujTeiL2msnn0WeEv9s/ZIss8F/AoM308070lmDpVMusi1NZKmpLhYg9k5j8DvLObjtyYPaviWaJBBapgqw6tv+qsS7qyoui+ctjI3uMnhCxSAKPWJ3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c2QDIaxq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcwCkvck; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2QDIaxq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcwCkvck"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A0251400030;
	Sun, 17 Aug 2025 12:23:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 17 Aug 2025 12:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755447787; x=1755534187; bh=IWcp7zinoW
	7jnkbVJcfyfC+J/y3d2mug5eTWYUuOEGw=; b=c2QDIaxqC5ATx5A6m61euSOlxt
	kjibYcJuQAxcZW3hZXi6+PACEyhS6+O+xz+Omywcwzf6Cv2hv5PEkLteHP+rRxO0
	JOG7HAc/tCY5V8ITtQx4D54I7JO8ias9nCazfFtmlAlmTzJqb/fZdWj2MTApcIAx
	pff4yN0KCSk9XFqn1J7eIFmOnJvZYMeoIiVy9Mj/lzLc5o4vRCYXC+Me8aDVQjau
	gH3RwIDgz3ttHG9699BA7vMnU6hPf+1rOoKdkj7mncwGpFxCy5UuRLZTce1nNYLW
	+B91r/+HipPQtd5sKGvUTiTgrPtExnjbK0Yjr9UfwPRTq1pgBNE5nZP5pmiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755447787; x=1755534187; bh=IWcp7zinoW7jnkbVJcfyfC+J/y3d2mug5eT
	WYUuOEGw=; b=ZcwCkvckIAbXcbasfNkVgkN/vZmhuto2zMVuaQIankjyhTKXO/n
	88l1wpsAg8AC59qP07FOdd5weUedensB0O2R2tW9TKLkO05c1jMCAmx1dZl8PdLF
	PgVaddyBXKAEKFfFGsEHiRU2otgOmiQtcGggcsZrAWBuFryricRGmkn8bTthcRAC
	QvwW/LpkyxdKuesoKqbadK2xy2Ilq7gky0FIv9tGzrGgoEqi0BkWcstPaiFEpjiJ
	VGqRaO7f7+tQVSwRYzoJyif7m0DUlvHr3sK0VHW+2RQIby48ZtmNpHcO31JC3pQd
	lqyXh2TzJpUc7CQiTO7CwA3hnTYz5SWzddA==
X-ME-Sender: <xms:6QGiaBaKPx1tlapKhcY-3srquSJHN_fBQ4nWefTnyriGypjWevFR9g>
    <xme:6QGiaDnNZLpnKyMyZpHkc1VYykxnWlSeh95WRebi64kCmamLzPTNybTHVEMbzNlFH
    Odv51KR15k80QwRTQ>
X-ME-Received: <xmr:6QGiaHwVEci-bgl1EHppl24B3ix7qKVm0rILW47tcb2-d5p8-bZDBJ0etPDDWKx1jdSoUI4ltga-pRwegchXWq2JtaWCbPGIS9k8znk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithdqlhdutdhnsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtth
    hopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhf
    ohhrtggruggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghloh
    ifsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughjmhdttdhnsehmrghilhdrrhhu
X-ME-Proxy: <xmx:6QGiaJ-TkL35n1sJiDl-eFKfjwFsDkOlAZN9nyplNsuF-49HCTlb1A>
    <xmx:6QGiaKB-RUHGQIUxOLXCT2povJn-bW6vNGTDQR5qS1RXObwD6Y_5cg>
    <xmx:6QGiaIpM0G89ihgxi_Y3sp8xGaO3XWes23FKM3thShhUBuD1Re2fMA>
    <xmx:6QGiaKlR8USk7tleFnNKEVxK_Sk5y0lTrsZ7ryu8lPV699ajGIEuZw>
    <xmx:6wGiaOoeIpCPqDx1Y03GPYDNZvsNWLzj1nkwX8PpCwGCADyYWoaizCxz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 12:23:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Git l10n discussion group
 <git-l10n@googlegroups.com>,  Alexander Shopov <ash@kambanaria.org>,
  Mikel Forcada <mikel.forcada@gmail.com>,  Ralf Thielow
 <ralf.thielow@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Bagas
 Sanjaya <bagasdotme@gmail.com>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,
  Peter Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,
  Emir SARI <emir_sari@icloud.com>,  Arkadii Yakovets <ark@cho.red>,
  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,  Teng
 Long
 <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.51.0
In-Reply-To: <20250817135414.431459-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Sun, 17 Aug 2025 09:54:10 -0400")
References: <20250817135414.431459-1-worldhello.net@gmail.com>
Date: Sun, 17 Aug 2025 09:23:04 -0700
Message-ID: <xmqq349plxxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.51.0.
>
> The following changes since commit 724518f3884d8707c5f51428ba98c115818229b8:
>
>   Git 2.51-rc2 (2025-08-13 07:57:49 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.51.0-2
>
> for you to fetch changes up to 79ee0dce2a61b7552f9b5c73f0cf2d974a20a029:
>
>   l10n: Update Catalan Translation for Git 2.51-rc2 (2025-08-17 09:25:36 -0400)

Thanks.  Pulled.
