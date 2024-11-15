Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD191C68F
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642712; cv=none; b=dxmGG+sSZZRrw96Nipa2NCp9zLJ+KsNUA5ZdeHCUdV9GW9AkufwXGeW3whE8herM6PGzdjUuL0+VAL4OSErLMYVjLiUKVCXo5DMwrCKtacpzxiFmjgyE77GW7tCH4DiYHUBPJXHySIIDws/xfh4PtXpqqTH8cCTluaVWUCC/438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642712; c=relaxed/simple;
	bh=oBkY7FlN3W9RZslbU3KAIqWyR9hOuttU9ELXUubpfQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=saXdt0su/MGBWdtm+8lr6PL+lH1YyQUZ7N5tGL3FLCy2ZKAYkj3VFmCBaE6eCEVt+w2Y5jrONeGchhdYL0YEIwXHsm8MroAU+RxpcDLJa+ubZOBwtP3tH1ysDRt706AbIzJOpo7Pf7OtkAsx+ECAiyrKD0AtvJoxnBM1EY33HF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6Lahln9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6Lahln9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C43613806C0;
	Thu, 14 Nov 2024 22:51:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 14 Nov 2024 22:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731642708; x=1731729108; bh=YiDO1XdOVzeDdCf9hjFb69V6m8SkU1CH40/
	lVzRtkQY=; b=X6Lahln9DDghiEdUs/qI5toIEDjwDlPDNQ39TpzQP/NbqVGKf3d
	ES3HzyGf2mGnqmiq5bbNFhNxaaPfe5TBMQdzwataBa7qlHjLhOabVEoK/y/GACLt
	SFRztAsxh5uN/UqHWwPYJ0/2ze343CadvE2JcOIdKCLUWWyx98ZPeTHh42mINlpd
	9WZZfjXtfdMwNUJMNflrPzztW4Cd2n6pypmd9PtVEd3C+lTo74al0zSZfx5pXMRT
	9D0z0chmozooHawNorIGfHm7+fTa/pv7W4sMABsE7Rss93sUJEeW5jMOeCKv/dbP
	UN6Y2b1OtpWdtm0RbQCyqUMwXhPnsXQlxHA==
X-ME-Sender: <xms:VMU2Z0h_cxZ79-S_MQmneDwfNNTYV8ztnkRpW5AmcsAYFX_A-BumPg>
    <xme:VMU2Z9D93WEPrZoSsUuC0Ieyi1DvcUsPiM0MhQHFLJEl7TraHOsCun_AAWBMNClnn
    EoqZLzTLGz_wtxIyA>
X-ME-Received: <xmr:VMU2Z8FJrnAR9iIR_ndlUArVE42xJgwrBN9toJGHeO_bX7lz6rEnuMzLja36TeDQ73B9-vDAFgOZ_jZCBGrlgy6pAdZYbmYKntGj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VMU2Z1Q5SDFzTiIb3SUhf26i20dly60f_zTQnlE3vqskXc4QKi2wLw>
    <xmx:VMU2Zxyl9cwR4ELlxPRjNkQjEfmT2cBBSwgyf_iSAUvcNUiF61Q5ZQ>
    <xmx:VMU2Zz4RpfXADXcHhbPSYnt3Na26WiHANSeyWkSN-SI99IHH7h4k3A>
    <xmx:VMU2Z-yciwCEZVegLWI0qTnwM9PdcU-CPyOxT_Gy0ou857HBiycXpQ>
    <xmx:VMU2Zztdg1_p_j7HgJ6JwFx_Qo8W1aGx7iUzFFVkGLEGPzGDBonAyY-g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 22:51:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] fast-import: avoid making replace refs point to themselves
In-Reply-To: <CABPp-BGOLfeUn6H3cdeMf5tZ1gswoaR51J+PDhMB4akR3jG+LA@mail.gmail.com>
	(Elijah Newren's message of "Thu, 14 Nov 2024 19:41:00 -0800")
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
	<xmqqzfm149sv.fsf@gitster.g> <xmqqv7wp483v.fsf@gitster.g>
	<CABPp-BGOLfeUn6H3cdeMf5tZ1gswoaR51J+PDhMB4akR3jG+LA@mail.gmail.com>
Date: Fri, 15 Nov 2024 12:51:46 +0900
Message-ID: <xmqqjzd540j1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> ...  If the repository
> had a value for the replace ref before fast-import was run, and the
> replace ref was explicitly named in the fast-import stream, I don't
> want the replace ref to be left with a pre-fast-import value.

Ah, right.  We want to honor the user's latest wish, i.e., if they
create a replace ref that maps A to A, when they ask for object A,
instead of returning it, we need to return what the replace ref
refers to, which happens to be object A.  So you are right. "You are
trying to map A to A, so we'll ignore that request" is a wrong thing
to do.  "In order to give you A when you ask for A, we will remove
the existing mapping for A" is absolutely the right thing to do,
which is what your patch does.

Thanks.
