Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44511FAA
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249474; cv=none; b=EPzs7OqhuKmRtJ2frrbkQcP5eS24QXGxF5cyKpqnLdiK547rx0qORhmujTutyq1nWWOOZIgR2aPreEwpRIwBqEnHOpaZClEuoqrX+Y+S9p62uxTFV+ZILeLccWcwSWFbnyMEFAEdJ5eFpYEOUOZGR3GnyZZrZJMb93wtTHbtqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249474; c=relaxed/simple;
	bh=JnMKKI3lAQbyRXw8pIouTPEmg6X3CZ2C39pH46bnqPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCmQRFMbjA9DiqrVcw953Jw0FFlcZ5bGmOosA5H+nkyRUhh1jKva43k3rHsD44f05l7cYr26RBLOY2kHpbJeg17+EUmQPnMPhXM6vUs2OlvT2JS//v1Y/o3JE2UiffDuvE0cP0i2Tff0pQXgon94aY9XvLH6/NDlZaQKVig0+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Chy5NHST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+rX48Uc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Chy5NHST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+rX48Uc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E25C3138025C;
	Mon, 17 Mar 2025 18:11:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 17 Mar 2025 18:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742249471; x=1742335871; bh=eV4FAflEYI
	r9dSXhWuO3ETJwt7tXnsZjdTYTeh3Wr4c=; b=Chy5NHSTzBDHLRIkUqFxRietoq
	UhngfrAU4NThoIFSr4GgWFKyDF9JjKQB6nAGXbQzmpf5AwJlQ7Q/iMAmCr9/1Bej
	qLDb9+bCujkampZTwTf9wWWFCWR+tEsxX+vKfITgUk7NcMzS0jFv6k3x5okC2EYo
	TxeIaIZLCgzYoBWG81VmtKr/vNY3fDtNz3n+e6i1mmK81pFzbhnqj3lCsREAD4dD
	uMnB/QBPLo9EctLisZ+fRX+uOrmmv+19OXZuKuYuU4hl6DVdH7xoK8UiJATFDaKu
	329jDOlVKOxlYH0Aef5Ldy/jWFh8ErpbgcmXXiM6HBK0r7ZWvCdAgU9Wit1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742249471; x=1742335871; bh=eV4FAflEYIr9dSXhWuO3ETJwt7tXnsZjdTY
	Teh3Wr4c=; b=a+rX48Ucfn0kDgxBpbwzzdVpzKBTHDLdCE2Psm+D0OtKzTVc/um
	CIpesVCbhicATbP1MBxEA7WZtgghQfaEBg6gqc7fGzBu+Yno4EutYaYxyA1Cqchz
	fbGWwgn1EEUoLAqz+lJnRflFQehsdHCJpWi8Z/Ho9QA3PyUyL/ISJD7h6RANIKg5
	P24OKoHnq4GZc87fvx/v+UV8bk/EWPnWNbn5oyT3kf9iXtHhJu08vayDlxs1KPGW
	S1KYMAchTY+ZLCyNxypFts+2pIFJtW9MtwK7BgR0ZCHzqZoJW5qvBZ0tfDfgTJ5Y
	IWLuimWDrnZIPFoq3nQF87qoeLZovsA1pnA==
X-ME-Sender: <xms:_53YZ95kV07BIInS-94A0LZlwmB7VAFwu9Hyvy69oVMtbhV0lb9pmQ>
    <xme:_53YZ66Cc6hw4SHB8hzXCiKWkA80emuyvKxSkQgJTUWKbscsIxjne_Go3QhWyBauF
    h6JyNBFQsBL0f6Aqg>
X-ME-Received: <xmr:_53YZ0dQX9R2PEBMfP7ygivJ3zZBNviMzW2bHdP3QiSeLPol1bRC70dgHaTfWZBp0F_c6AGhyD2co0DobMeqfh0tUO2Lw5U9bRu3NFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesrggurghmjhdrvghupdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_53YZ2JkDOcOKONjbVqtBkVCf2U3g0_cc0bBWBr_sddTYqtdreqZlA>
    <xmx:_53YZxKOEkWFOTO8Hy9m6ag8OeFeUhd4MnFetQp_op5pxbjNS3gskA>
    <xmx:_53YZ_xFCSphG-QKOOwQGL8s0hJ4aWICbGz2_Wh3Qpi4t_BP50QijA>
    <xmx:_53YZ9LFwLmE6V_Dw33zUzjwnM2yjF7Dv987aWbbylHbHQ6W1OihpQ>
    <xmx:_53YZ_hH9qkLiP0P0LipEqNyTkGunb0fkPCxDDZAbX2Q_yvQIOi76pwh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:11:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH v2] doc: restore: remove note on --patch w/ pathspecs
In-Reply-To: <8c8da3d4-5184-f83c-c08c-51805fe9ca99@gmx.de> (Johannes
	Schindelin's message of "Sun, 16 Mar 2025 01:47:31 +0100 (CET)")
References: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
	<pull.1504.v2.git.git.1685654097812.gitgitgadget@gmail.com>
	<8c8da3d4-5184-f83c-c08c-51805fe9ca99@gmx.de>
Date: Mon, 17 Mar 2025 15:11:09 -0700
Message-ID: <xmqq5xk78g02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Adam,
> ...
> commit message is valid and the diff is trivially correct, this patch
> should be good to go.
>
> Ciao,
> Johannes

Thanks, both.  Will queue.
