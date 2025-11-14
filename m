Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55242DEA74
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150428; cv=none; b=gJzYB+ha/V4oUDmLqpe8EfimPycMw189wj6LtJjconCXUYhVcMsVPvl/NDuQog4XQYZPeWeR81zlrBosJJB1M4pVqOgOjvLV35sHUFYNhtp7Z6ZG5OqHR14FlSm/CceFXedCQrVNNhEt/8XBCU+qGggYngOwimToYXwfu2uh7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150428; c=relaxed/simple;
	bh=WJLjCzrZUSSlRFwpZfqyvFlM2obN+Qyku8TuzfGjG7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIpkPgkRhQu6wEeFnzPkpWb4x4mln9KB3YSBHKiZj50+K11ZyuIQlE++WJzaQEBftjh2tPut0PNukjtJLJL2Fb5AzN6j1xJ6t7BxrW+MWuQp/2qdtTaR4gqusOSM2V+EWA4g7HLvTfp/piUDQk48+wdTNwhQa/HnxgVv9LoDQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/ipR1pI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbhGNFTk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/ipR1pI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbhGNFTk"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C0111EC01A6;
	Fri, 14 Nov 2025 15:00:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 14 Nov 2025 15:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763150424;
	 x=1763236824; bh=jI6XC2QUzq+04RJ2XU2UI/7ieQ/0uJiZIP3fiASCH74=; b=
	T/ipR1pI9t+2s3AKQWunSPZ6ct4z3YelZQPnmld0cMeLPPby8AI+LnuNzF3eYv2x
	zV3WfHkBjg8lw35gyOD5pW/tUOCLvfjMcwQvLC3/I6D6uCFb28gwFim4L3Pw1EVJ
	Q/KPsdy7+eCxGddGtAzLnejEPi4OEVx7ndjIuBFAh14qdDaiAudmpuvdi+1LwcgT
	+ueOFywsekUaRBEybIWcV18LecuNBysTG5CwuNACcIE1wZb3Z78SPs2iGod8jQK0
	ODsVtCjQbMOLi4S7106ZPBCU3S7QpZMInUDVD6KTpN2ZsKKJ8b2Ox9KnPlwg6iDz
	I6XWFnGOdqMHvTSU13hxew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763150424; x=
	1763236824; bh=jI6XC2QUzq+04RJ2XU2UI/7ieQ/0uJiZIP3fiASCH74=; b=T
	bhGNFTkvUtCMU1GdRJC9IS2VXE/VtHtJoX0b+VEj4tfi0ae74G63Jy6Zw+c+WJUR
	PcT34Ed12V8hHcKvGE/fNaLupCajmQeA08mYxAwhkvzJVFSm/Gxk+KRMs7fgfx39
	hUpWWpTo0yypLdGw2TPscZH9cbxBymAbcnuhNsnRImDsKIy0K44hMa1x6LjLlsx0
	aoqGlaqe6cRCAqpIaZm1+OAjItkV2tEFhz3adAaVHxACzBoMbOQVEyS894H8ssdQ
	76vDjLh+Z2LrwwCQ7v+PWYtFQKYbFc+D8mFd0T7LbX9Ip4BycSxU7OrgAS4stH9W
	x4lO0R9XFcVTSWMS/lqaQ==
X-ME-Sender: <xms:V4oXaR_5QG6Yqye9O6EYsv4v57xBh1DHc-z0MbKCphYCpjQUXcul4g>
    <xme:V4oXadS7oTKB1v5v7bhfOHMIdsFL9_Xvw8dW6G2D9vlxU1EUQIf839NOicSRUTdUU
    RNckVYPZlf293bDZeSmBy3UEK4fuicEGzOvdWuGhKky5oedSIo3>
X-ME-Received: <xmr:V4oXaep7uPd8s5vQfsdFr7sRrayf2P2iSjwPqqXQkW9XRTaMui9GMFx_cfUfVaPf4e0mOGZVaQdmPFUFRPE2HIXxDiNfU2FCJyBq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhhse
    hkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhfohhrtggruggr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghlohifsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughjmhdttd
    hnsehmrghilhdrrhhu
X-ME-Proxy: <xmx:V4oXaSNeTBQhxLsX0LDVX6M34n_X92u-ytSDIOxolgHmJgpEPb_j-g>
    <xmx:V4oXacwOrXc_KmSxn4VuzIQNHgHHJMfLBYlLBUOPocTfVdiWi3vaLA>
    <xmx:V4oXaezSkNsr2OQ14IlGUHTyMcuesLA9T2G5OI0f1uxxdK3m1U_IcQ>
    <xmx:V4oXaVLytSnR64aOe7g8CKsDZ97Tcmvr-rWJUh29wfZhdpAC_TVAPw>
    <xmx:WIoXaVc0mZvkt2ohTwCD2upSCP1mZVnqq-OiG_sYu3BxcNJgUOYvfEr->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 15:00:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
  Justin Tobler <jltobler@gmail.com>,
  Alexander Shopov <ash@kambanaria.org>,
  Mikel Forcada <mikel.forcada@gmail.com>,
  Ralf Thielow <ralf.thielow@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  Bagas Sanjaya <bagasdotme@gmail.com>,
  Dimitriy Ryazantcev <DJm00n@mail.ru>,
  Peter Krefting <peter@softwolves.pp.se>,
  Emir SARI <bitigchi@me.com>,
  Arkadii Yakovets <ark@cho.red>,
  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
  Teng Long <dyroneteng@gmail.com>,
  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
In-Reply-To: <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 14 Nov 2025 00:52:45 -0500")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
Date: Fri, 14 Nov 2025 12:00:21 -0800
Message-ID: <xmqqa50oiduy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jiang Xin <worldhello.net@gmail.com> writes:

Not about the contents of the patch, but how was the list of
addresses on CC produced?  Do they all have enough stakes in the
code being updated that they do not mind getting spammed like this?

Also, you had a non-address "Gemini <noreply@developers.google.com>",
which forced me and anybody who will respond to the patch edit Cc
address list (or suffer bounces).  Please don't.

> The output table from "git repo structure" is misaligned when displaying
> UTF-8 characters (e.g., non-ASCII glyphs). E.g.:
>
>     | 仓库结构   | 值  |
>     | -------------- | ---- |
>     | * 引用       |      |
>     |   * 计数     |   67 |
>     |     * 分支   |    6 |
>     |     * 标签   |   30 |
>     |     * 远程   |   19 |
>     |     * 其它   |   12 |
>     |                |      |
>     | * 可达对象 |      |
>     |   * 计数     | 2217 |
>     |     * 提交   |  279 |
>     |     * 树      |  740 |
>     |     * 数据对象 | 1168 |
>     |     * 标签   |   30 |

As there is a concrete reproduction sample from a specific tool, ...

>  builtin/repo.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

... it is a good idea to protect the change with a new test or two
to make sure the expected alignment in the output.

Thanks.
