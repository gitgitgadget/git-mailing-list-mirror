Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AD2ED846
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928836; cv=none; b=ObuToEUNPippIVO/b9NAvWh7sxtK6BGsynAbdTpREZIP7c9y/lF6a1jMdZH/UIKtUIncb1Qbv++0OyjhxISRvReWaddKCi5aBdctnkv2G4lDQm63qccGcU4LukcOqVmmRc7Q5UIyjz4bjSLLJZyvNd5JoAcwDfmTTonBtZbTSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928836; c=relaxed/simple;
	bh=en/T44rJg/za3Qhs4p3cbgsb1tBkaL8N9O4810pHGHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMYsDzf1Ie3SRq+xQWEpuKKpK+8yERbbUPdxdH0/9fuJwh4F2DW06usSqWjsMPhm+RwltyU2mlXaOEw1dvboTViijNh0oRLdAsz9kC2601LFZPVdhJipx4q5hLMNVmicXlHyuXVmnsSRqMCGC4TP4bx51WZQRZzC7fBS8F4Z2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AIrwz26P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFCmFFA/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AIrwz26P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFCmFFA/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FDADEC0085;
	Mon, 15 Sep 2025 05:32:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 05:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928752; x=1758015152; bh=/8bvGB/8s/
	egO20GSJAT/G9efj3og16SMOdDWVyptRI=; b=AIrwz26PWHOz6qrc6teymb4Bt7
	X05J1C8nEFw030XbG4IhphoUVacdFOJyahMIgWLjoLRJ1JW4iPgKVUiEKNUaXQJ2
	9laAn9SklT5ylJUzyDgyQmrw6zUdalt/Do3fdztqQvPGIJ3Bjlgdm0I3xNHnXvzD
	RtYVvDoU0XZmJnIpC4KUql1Sn86UY2kW9p5ZwY5YSZYfdA409AVzGQU8s62e7Jgu
	m03KxLFhG7nhJcyDtslAKMOD0z7yoOrISfP+NKh780sPDb2KwmKxxSVb476ZlWc7
	zvlwgVuDLMPunz3XBQUHistwewquCRRJN3klmmJJGz36M4xV/LMgN3LjUdPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928752; x=1758015152; bh=/8bvGB/8s/egO20GSJAT/G9efj3og16SMOd
	DWVyptRI=; b=hFCmFFA/sszHjSxtVxtHXMposLHpKbdphj1FWFh2IAT156Ntj9v
	aDe1nKeEpKf6CLdnqt4uDJatma831vzaUYzzZw2Zps4CS/KJ/TTl7IF75ycw/jGC
	+NjZmHnADO+YtLSMMh4HknRM92SNHe31y6b+1ymlYMfpxf5/rR4UMort9EjwUgiN
	zq5EI9ucYU32OE3CYKJ8DXKQFlYXZVpAeEvsk51cckFjOBnTgfS3DSPWZ7GHGwOY
	w4JBZCJh+QuC/1bKwz/c48ri0x8RDz7mn2c2WPnsj6kN0VCGb5nFTvW+m8bk9Jh/
	nj/FZIp+NTxs+S/KOPv3KH31COFLHMRrC+g==
X-ME-Sender: <xms:L93HaNNqYo6RDzQixM5Xelok70_B1qrcAYcyKS9pVBdbZIhf2RKUuA>
    <xme:L93HaNjpqGvokRRdpQk6AdlF5J5nM0_ORURuOOtOXlO2Uc1Q4YgNAAphqfarnGRWY
    s-WOyzWeUA-HMsiHA>
X-ME-Received: <xmr:L93HaCsP0wr0rTss8dA2tPQmTZehvnEJmm_XH9FsMupjVlton23mcR9s8y_0JWjC3X6tzfFMCx2UxpEYRbhMMxdfQPq_jQ7cPS4FcK9P81z4rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrth
    hinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:L93HaLTr1sgeaDRO4SeXq181dqMk8j7k3FZW1fRI955h_lmo5p8UvA>
    <xmx:L93HaG1zg09b_b3mqACvmA4wn65rE2d8KGn-OhgxvKkYo0Lfq2sZ2g>
    <xmx:L93HaAtvAleahCobZRB_a5b580y7oCEeI2-YUnP527s4qSfAIEvNkQ>
    <xmx:L93HaMgkWrLADYJ5W2Sen8gcpLiCk1Yg5KuNJtuAZ_a8jGWloRHzLg>
    <xmx:MN3HaLZSu57oUfGoG7O11o0_Spz3O7dquPacOj4jGONYp0lSz_4prYyY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2cc0621a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:30 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
Message-ID: <aMfdK9f8BjRPPJOG@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <xmqqcy7yrs2i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy7yrs2i.fsf@gitster.g>

On Wed, Sep 10, 2025 at 01:05:57PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Note: this patch series is growing quite large overall. I'll send one
> > last version of the complete series with the RFC tag, but after that
> > I'll probably split the series into two and stop after introducing the
> > "reorder" command.
> 
> I haven't merged this to 'seen', not because I do not like what it
> does, but simply because I do not have enough concentration to deal
> with conflicts with some in-flight topics (IIRC it textually overlapped
> with Peff's add-i color topic).

That's fair, it's been in RFC state anyway. I'll trim down the size of
this series, resolve conflicts with 'seen' and then send a new version.

Patrick
