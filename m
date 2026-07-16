Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B743321A2
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165416; cv=none; b=FtEqhLq6cLZYGuTAZecHQLLDRF+vBn2eVS8J3SGnoSDpEuyPN5rXHrk/ub9bk8YXsC1XV4wbMuJmi9Fk/dtoC5j/TKyoswru3E8uCWOID+KWZ0HlNyH7LekN+cbMQjdWXJkH9xoFNa23tg+EGw42oVmIEDMtWxYGh3WBhhh7jCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165416; c=relaxed/simple;
	bh=LxqeOSq/UQSvtUEZBbh72O4varJOnDodqCaoJbQVK7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuZ9/BRfN3OdXI/qusBOJbQ1swV86+JK+0raVRFOP9qhgC17tYcXAkvQHeuUuuxjuVK9trX5UNgQfBVm6iKaCQhJPxB9CICqQa4OPTpDVddRvcxETq3YQcomQGn+FcsVHEZJjmmcFXNSBciGNFd3/Md8112hIYEFpa7pQtvgJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H4Fm2XVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nz4LMYzI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H4Fm2XVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nz4LMYzI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCA14140014F;
	Wed, 15 Jul 2026 21:30:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 21:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784165413; x=1784251813; bh=5mpElsVI43
	157uPsLdB55bz/ZEibj7fO3Nhlk5s3X4c=; b=H4Fm2XVWT6oirCFOsje19irguq
	rBLuij6Z1LWUW2FqJb1sYBkBCrVsi9SeObb7VYM63/Rdjishjvlpq67/xbvnSH0Z
	QiMBc/+wXJEeZlFtAB3JkzyPTgjKGUT8+ForuNIHfZ/Scn6uvPYnqhpIcWG8fPhl
	wbvh91mBeRXrwjyfkGHzgfZcm6H9v/3yMEqBQpvmzU6KggbuYArPEj9RqGQ+19Uj
	AnMt1YX/buy8nK8crA/dmhcOveWYBZ7caf+4vGaxKTXbolGjpr88+u274LLp2jSU
	b99Dr3Jmn60korJeVgwDtp/cN5IwCOtsVvXuo+N0bj+ozUoYX23YUMhFfVKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784165413; x=1784251813; bh=5mpElsVI43157uPsLdB55bz/ZEibj7fO3Nh
	lk5s3X4c=; b=Nz4LMYzIExycKdo+/aVTF+jNcDga+Gu3xZStvE/yb91HYw1lrEX
	4Rxs7soQdfjqf2Nnjph7iAZiNSF9E7fBCQQqT9o7TRxLlkk8b4kHWDV0DZH1rHjp
	JCmdmVWZxaoqJClKhsw7yEF8Fzdpt+mSST+6HFcDpRb9iSdB4tYXTSf0jd4BTi4U
	s+Jl74VkQNDvGAnD+V4aseU7ele9qFAsmhjB7my+w55Ox32kcqo2/ANSE4Qb1LFL
	hEmQJ87x83HdzLNyhcfngoLamqXtIaJ60NSSnPMFlK6vu2mgh71U1iytKKNEIq8U
	G1pEOjV3AUyKf+Yd5tZ2vqVfp/WCuS31+3g==
X-ME-Sender: <xms:JDRYamlaJZOVf7zWFBk-nmoXRC8jYRdIoPfRM9VIYBxU3O0w1b9Ggw>
    <xme:JDRYaqa7uRRl8sc-6fvHWzbek55ciyyWedJ1Xx-sS1py9H-9W4sijceW3cgcokbIF
    7iXlfl_exC2qUQBW9LuiVYr1Ia2paoX7_JRQggYevIoayu9FM3FIg>
X-ME-Received: <xmr:JDRYapFCWhZgW6k6LkvYJhfs1TglyJrBGXx62uZ5usxcpcD4x-VJnnWKjwh4GJUO7UjDiZ8Ufx6SkvRUeX5Huk8BLR_ZSlb1UBCiP7Q>
X-ME-Proxy-Cause: dmFkZTFJl+fxLR0zkxbZW/MYuD4Q7oG2mFNS4vrmAPyIMkErsKxHFP1giIbFUvfoyrEeWW
    7cWkv5r0nGmeKsocJIk524tKR8TMjDiaisVIIxnLXE6GgmmevAiqQx5T1uZw2aqnFj/6U4
    QQ344FP/F0hn0xLS6H/DfzO7eMXBN5uauDdWpEQOxTyIVOI0nFdLrznEzf/wEf7rVyrlJP
    MWoW3fnOYawRiv4/qMgcyFCO1IAr3F/7AzaDmtM4kJC6gBaYno0ZzdHkgafHxQW53JHAA4
    i3DuIP5WrYLgnKoVkasncE4oeVLXMnfrOqWtK6rVo6nAFXSs2csiQS9f5sGoqotQHWr3jU
    OE2QJVqvXOd2SyRLpeBOHbX1utPdRN2ruFuiL2Q9t/qUumz7TXue3QepBh+rxlXMd84Nht
    HCHVbbqMOKb13I/4nR5qSz755G1ZFa0nedR/G0cXlHx4pAs+mmJczcKYPKhRqECEahJOMW
    Nw2sxU5jTl6/vKIeADVHPhXcg5PoVlX2IqNtmln7bQnxqZNBeNFOXm2EsYkV9QXiGUpz6t
    dGvM1rqwcI1lUEk9i0kJioN9zgaz5mK/3bLLo9WR7nJtnIxI5UXAM/DAJinOChTRH46UkU
    6MqKKpnp5j8C2pOio7Eo5ErA68VOOHUH4WBXKTN9YiNc1ftAGRHbxgTi+oFA
X-ME-Proxy: <xmx:JDRYahafXeh8ofQPXYkRFAm53anlJP_H3wlqVxgGpYVER2SZldpB4A>
    <xmx:JDRYalxYMCUuI8wrM2dladwt0oYISFoARPNK5jm_DATxUL5lRZ5IqA>
    <xmx:JDRYarS-ylqEmQiDyRsKNCTV1NC9YHRORGw0Vb9UvieeXLzuM4Cncw>
    <xmx:JDRYaqJTWUnoNfytLuSoTRPBavdtmEJTAyvUdj4TEadCbNhI8qtyrA>
    <xmx:JTRYajuAlFVzAgo3YP4iFiVN0Wph0YCMNUfYHo-pUFjorCcniEJ3AA_u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 21:30:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>,  <chandrapratap3519@gmail.com>,
  <chriscool@tuxfamily.org>,  <eric.peijian@gmail.com>,
  <jltobler@gmail.com>,  <karthik.188@gmail.com>,  <peff@peff.net>,
  <toon@iotcl.com>
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
In-Reply-To: <DJZH1PLDC08G.1XTK39BO8YOVS@gmail.com> (Pablo Sabater's message
	of "Wed, 15 Jul 2026 23:44:11 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
	<xmqqcxwonnkx.fsf@gitster.g> <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com>
	<xmqqwluwj8of.fsf@gitster.g> <DJZH1PLDC08G.1XTK39BO8YOVS@gmail.com>
Date: Wed, 15 Jul 2026 18:30:09 -0700
Message-ID: <xmqqmrvrk9ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> We can force "size" when only %(objectname) is requested so the
> server validates the OID, and discard the size on the client side.
>
> Because this is a cheap fix, I'll add a NEEDSWORK for the existence
> check to be done regardless of the attributes requested.

Hmph, why NEEDSWORK?  Not doing so would mean that the result
lacks correctness.  Why should the first version of this series
deliberately produce an incorrect result?

