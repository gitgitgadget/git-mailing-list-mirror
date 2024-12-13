Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8871885BD
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067630; cv=none; b=hF6Nd81r5RtI3PO5OR3KS6LcinTVQESJLIgEgSdSrhAr5GE5wkfWiCQSkzyQQfDn6ODZB57yKLgrWK3dgEXAIhv8fs8aPpaKbJwcndy7SLq9mk8PJyAUD0olmnQVNiGzuya7ympNcb8f05mXZwHtDnE+525FxctSW399q9xiWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067630; c=relaxed/simple;
	bh=wz0am7w5ApnbJQVX5T59JYKpiElx+2a8pkQhksyvAL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxnlFFhhH2mPSfYDdBWb9rRaUVzbswmNfchaq65nLzWXqJxM0iLCg8s5GCZ0aKXR7sROoQTnxRSLCNvB2IalfhCYH3MruuZ33zT0jxt1U597qwdblcVIPYhKqwwO/M1710UtAeqi5swxMDGKQ/PUh6ZdL7bI5IGyzmlspZMmx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vtif8cpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIfMflDW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vtif8cpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIfMflDW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A8B31383E9C;
	Fri, 13 Dec 2024 00:27:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 00:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734067627; x=1734154027; bh=SEEZ0O3uiS
	4AUC4S5/rsv+6RpH0XN+FAOoS/tGNMbTQ=; b=Vtif8cpNsLAtgLH3MhmvBrNBix
	EnYTzg1z5U+rgttXte9pkoyxZ7T73mrxjxvaQtYk3CCfAEQUjQgoRVdP80hzTSCk
	WsDLhwlj5lMwNRieEdrerXk69sc8Yc5+dHdt4IRUA1oWAWxh8HYcz4zPW3asniI0
	wEGo6A7n/bEAeUB/JCKZ0SNSYhaT4Jw80XNUh7oB82F3Jd4V5Ff2M2OHcTAOMmWf
	QDAD+ZkohMEdNv7SNWgrQxkYxbjAvF507WqQT/c6YDsgu9go3q+8IfRDuaAGWCr/
	jJmZH6p1mKw2hc4cX6kEmpD3vBSnNP9dSX7UhC5GKc7ydx71kUGXzj8nJrTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734067627; x=1734154027; bh=SEEZ0O3uiS4AUC4S5/rsv+6RpH0XN+FAOoS
	/tGNMbTQ=; b=eIfMflDWRLQd4gXVhIXvqSQZME3qHzXqwPp4O4czx/7bH0S7OTm
	06XkcPu/LM068LFahbFUjCq81OxPTSp8De722vj+KTbQ+XyhFi/wzlPawH/7NsdS
	bQmWOvEktG2H6sH3djp2zToV2Sgkco6CCjScrPnOpfKVDl+x97okCFcUbeNFzgO2
	StfkpbFZOO8U5z8q/8crhzuMGEBpVXNCoJjBPETXnxOqfK4FW1OaclA89QNss0fn
	rlmzdEvs70XmsxH1Ro2p9YTn6acmaSZwGztuoEfm+JQlrmEFQdSpSjeDQLSWO8XT
	XlTmIWr78sfx7pQ+kzb73JqwmFp8kNZnmsg==
X-ME-Sender: <xms:q8VbZ9IDYwvNnhed7ZXg8XDtZbJZKdNwAZSsIajM_BWagqIyxH81OA>
    <xme:q8VbZ5JoJbjtYxs-Lnj4atuapbuYrizZZwDB_5X21-srgVqteBdX0wdszKkZO7ApH
    ixkJxOouiQEeMk1_A>
X-ME-Received: <xmr:q8VbZ1sK2f2ZsHYTZ1uPqbCfz0amKCGhdDqInb6I5ipv9YZ2yGQeiU0SOJinfPWOXYT6ocX8G3dthwJI7XqbisDUW_U2Dei46xdTV7EuzhAVj2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:q8VbZ-aWfs9TP90nbup-ym5A_t54FWuLlruUD-f1DTJ_guam6KWODA>
    <xmx:q8VbZ0aoxOBgIaLDv_iKg-r_4UlzeeDHn-yKRTwtBdXLX28vgW8A0Q>
    <xmx:q8VbZyAmWbjswdjRQbFMi0P9jzYd3F1XtP8OtgMM19kMBuc9wwaBsg>
    <xmx:q8VbZyaNU-5v3AbuXKBk7m1Jqz4_ewa5FQjZTbrGsNVYL28OHEPzdw>
    <xmx:q8VbZzk4xqbtJ7z17F2Bb4LAHJICa_QuZ9wz1YYfWeU7Qs6QU-_Owic7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 00:27:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da1a74b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 05:25:27 +0000 (UTC)
Date: Fri, 13 Dec 2024 06:26:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] Makefile: wire up build option for deprecated
 features
Message-ID: <Z1vFm2SrbhQxLsxX@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
 <20241211-pks-remote-branches-deprecation-v1-1-1431e2369135@pks.im>
 <c421584f-4eed-4aab-b706-214a36fc4e32@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c421584f-4eed-4aab-b706-214a36fc4e32@app.fastmail.com>

On Wed, Dec 11, 2024 at 02:06:42PM +0100, Kristoffer Haugsbakk wrote:
> On Wed, Dec 11, 2024, at 11:56, Patrick Steinhardt wrote:
> > logic that allows us to easily enable the breaking change at runtime.
> 
> s/at runtime/at compile-time/

Good catch, thanks!

Patrick
