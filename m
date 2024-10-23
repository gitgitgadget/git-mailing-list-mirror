Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CF1C9DFE
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702026; cv=none; b=ssM3r5k7YH/XitN5a7OAbRsGrP8HiYk9ywRPG8wP57yjfqXsw2BylA4tB/JtRBTT7zED4Lt3n5z+adyfSgS3RHGbkWGjTYZE0wHBn91cA4sSoSZSoqUMcVmQQiMhLdIBoiL4FfZi2Z8hlBotqeN/CVI1qMP6wd4CJVDqpZN0St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702026; c=relaxed/simple;
	bh=w75TR/3QHJAEjcrndOFMKT2p6VIzkbyQPbl1YiKt31g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HC+FueGtaT/JMsb6AyWq1IJAs1LqZWSyfqUBTju3OveiUDACpOQ1dvsGB8XzMsu8VuN1nd7g+2auHLfh8mPuKFw4FJD5q5oeoLJMo1oWq4DFqBUZiWlhF7Yh2srMKfi0QN55kEYmJLGVT3XIpZz0bx1DPBCG4tUB90GLgOE2vDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sBlO0OMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofiJtJwb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sBlO0OMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofiJtJwb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AE691380223;
	Wed, 23 Oct 2024 12:47:04 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 12:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729702024;
	 x=1729788424; bh=Qwi6w0/PiJnz0DhKgas9n478yYxzexJ0OVtQgMHwPm0=; b=
	sBlO0OMOJldm751rBajs0PG1W1P/4fWDOZ/RgH9BOjAE6L4TtM8UEbx/r6906cpj
	hi3F3XnihFRMSl7cizt6XnrOblzShZQX/j8C96wK8YEyj5bDHwvzyikfHk48RZD8
	jjnfiJlfDn7cz8m7zju6/Q5Fko+x31rgW3Rtp/iAg79twqn99q9/eO3JChSPHVVH
	hX/sGXD8XjfjUcEsgKR9PZdQl7N69Xn20ThhZwJwvcIUsiD4ctNmBlvH01RRYGbF
	gJKc480nxMoI8PZ0AtBBPoy2jmvZuiTPLi9YGcmyx3wUXav+dhK5TPZdJ68DqsHs
	zmEpQPEv70knKFbBY70HnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729702024; x=
	1729788424; bh=Qwi6w0/PiJnz0DhKgas9n478yYxzexJ0OVtQgMHwPm0=; b=o
	fiJtJwbulbq5fWl1kwgo/ggCh1r5Bbk66DuDz9rEI9cp/zmOlHgQBluuSWddD90V
	IRwneZfsD7qhD9Ars4SnLFjdDHndva0r7ZDL52C0adyhA2cIEQLSsJ8MB17I8Fyg
	0UAmPOIJ1y22SRRDPwyTievNBUFNHUFbqTaw0V3P+ZxqXv43pW46NM0+myhTP7dl
	M+4nZwvH/A1wR+YaX23wy35ekZRfbedVh4cIxOzUyVEXJIBTQ7RAG0GSeX/SVKYF
	jR9DAbwgZiOlKbDfh1H3xFixAMOA9IqDu6cPth9NHukcvWCvDYfnkdY4xyRWclKS
	tPMkkVhdWWY68dNq1uHYg==
X-ME-Sender: <xms:hygZZ9kc-NUWFG4ez3_NoHRtokocZ2NwxmJtIJNQkhnPpHZWxf9ApVQ>
    <xme:hygZZ41akRIMVilF-FzmbaEDI-rkuPBx0V3Kfc9jYlmFJhSx1ROeu0lUcHlY7Xlxq
    eZqKEOU3kYnd38c8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhufhhorh
    hijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hygZZzqUmjbLN51qZey0E5jSecLb8CrmC9jLOO4l0l5zSyVO296xYA>
    <xmx:hygZZ9mkWFf2CHDxQNwirjvi6llzFkA0et31PBFXStl0ZNsggm8afQ>
    <xmx:hygZZ73qKDezur1vOPhaKqv0te4Eaabl2diuM94MsjX7220WFMQ0mQ>
    <xmx:hygZZ8tcdAx80Yic9YpTL-0Vh6jmeIBSqvmPopoRXEkvbK9pACSyqA>
    <xmx:iCgZZ2TutwC2d9lf_dMCCIIVTstMX7RMWfoncy6WQcfr_S2isdIsixPF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35250780068; Wed, 23 Oct 2024 12:47:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:46:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Seyi Kuforiji" <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <97e5c9ec-28c7-4f37-9dae-26e4219f1f98@app.fastmail.com>
In-Reply-To: <20241023121113.915310-1-kuforiji98@gmail.com>
References: <20241023121113.915310-1-kuforiji98@gmail.com>
Subject: Re: [PATCH Outreachy] t9101: ensure no whitespace after redirect
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Oct 23, 2024, at 14:11, Seyi Kuforiji wrote:
> This change updates the script to conform to the coding
> standards outlined in the Git project's documentation. According to the
> guidelines in Documentation/CodingGuidelines under "Redirection
> operators", there should be no whitespace after redirection operators.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

I can confirmt that this patch, when applied, fixes all of the instances
of this style violation.

Thanks!

-- 
Kristoffer Haugsbakk
