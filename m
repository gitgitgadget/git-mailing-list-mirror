Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8263009D5
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400651; cv=none; b=Xz2DGzoHyEwfb7KodHxPCeX+oH/21ieRsPu04mks2hzEUZthYdYx2BnaNwo5dHiWsUZR6Cx3v32xRT4iwG5P65ws5v1W2ef9mpPQTaA+9vcP2HOQKSqRA+VeTs28XeKFYy/PndklBPpP7S1uET+8AofqPQTVbV1cSwI26f/H588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400651; c=relaxed/simple;
	bh=OwCNIwLP9Loza0OGgJG78A1UOemza/v34J6HrJsP79A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCfdvHdV1sSRAj+5D+6yegYmkGQG1DKNwvyusiexKU8QgXHOa/YyTewl6xQL1lPjitQUzESq03FOGbBUYSRHV7SFixh4EXotxryAUKJi3KoGfC9QAWZ4UaiVw8fDaVCVCghKD4TITtEyfJ/1O9eAVKE8z44pOUwYC9ygerfTUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jN/wuN1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RV9l47be; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jN/wuN1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RV9l47be"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 360547A00F9;
	Thu,  2 Oct 2025 06:24:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759400648; x=1759487048; bh=2UcJEXyql1
	rIDHMbysU0KLQWIjQcvde04uNmDW+uokE=; b=jN/wuN1V7JqCAy53on3ZEX+UHW
	4xDmSPlEKmJdfiJQCGt8DTPWcT37lcPvBDhI8aXlSjf6ZlOSZTMljWUdW8f97kKs
	y/VJk7lecDXLOFPhxrBuQJmF9DcFpe0pwt96Kr19vze3X3LKTkYQ3CeN7UKoRE6e
	lJy5DB6QyJi60rEeEzkMvmXQKDx1q/umuB7TVDqdED/AsAnmzE49feR+BKxxHVM1
	zZBzcou8R3DIpZN4kmtFcXM7IeZGztIaQpcgO/QSfPfgWadI33SYdET2Yg3CHdNy
	OL9gCxQ5tGm8sOxZOKLIWejdgWu8KnMa4EdU6WF9fCKhSbKUy4fjlEHezOLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759400648; x=1759487048; bh=2UcJEXyql1rIDHMbysU0KLQWIjQcvde04uN
	mDW+uokE=; b=RV9l47beTdkI3T9VhbTAg8lsEgyWJL4E/nGhycl+hTwKdQftD55
	1+VIhnDQVD6cwfVx3DKQsHvoXHNY13Dj0aQtUt3Xke1iUaYn9dMcSBrRJ8JKdYuk
	GPmKZKxaH8ShJOwlj73iUfwgFWmDMoDEQGMYxjEg3YI7lH5K7/TQJkRJhH0Mdn3w
	5/3AbNKDxBXPniB7C4UDgSmEdsz5qsTGov4ja75YQkGjb8FV3Q0wRrnNhsXFe4p3
	Kb13yIPExIWkQI7zSvxPwgRD3yWKA09Ds63t2Iu9/cX2L1cOAEbUsvK/f/tAeDyI
	uxEl14VmVWzgq2EL28y56nSPIwfhk33BsXA==
X-ME-Sender: <xms:x1LeaNaUp6KUPkyjEzqF9W4-kkRxJUGIATXuXn1NYnqI01ZOglG-MQ>
    <xme:x1LeaDeewyiulTp2l-j6XGlE6GyYMhkYUkUL2mE4K0f4PEShcchkodeuwt2S_6fqa
    v4HbcrdL6s9pfbpkq06IIjfsALebQWTXFtRYE28cm4hboys2JJYEg>
X-ME-Received: <xmr:x1LeaGKFsDsO1gyLH0xGl1ag_WpC0nz6s0q8LjIaQf2wh94beLFKmEUpWfU1MUGvyo1WqXa3eu9QXzIe09VjoUCyOhbd_lSDRgn0cU-pjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:x1LeaIL0P2nkb7bLo7xqKtbhCM_i_blDZIedhPBGFollpc4RyaLGlg>
    <xmx:x1LeaNV1_pHJZk7FqifL6uZ3GseUM04LeRxmftyWAjNQF3cEjMtQjA>
    <xmx:x1LeaJmHSf79QgsxHiCiSeNqlDxTIUt2jbf96SifqLpLtbwc3vNieg>
    <xmx:x1LeaLmC8Yamor-5I-lB7Elvg2fck0MYkisCnvo5fmooaCcEv4Hkpg>
    <xmx:yFLeaJ1c_jM37_ioanIs24b_KhbzsmDrgZS6Gxr8DBaviFYPsm6RSiRp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 06:24:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d374c14 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 10:24:05 +0000 (UTC)
Date: Thu, 2 Oct 2025 12:24:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 10/12] add-patch: add support for in-memory index
 patching
Message-ID: <aN5SwUn4beYvFJ4n@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
 <1a19d9c6-f0f2-41d6-9969-63f6425b7340@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a19d9c6-f0f2-41d6-9969-63f6425b7340@app.fastmail.com>

On Thu, Oct 02, 2025 at 11:28:23AM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 1, 2025, at 17:57, Patrick Steinhardt wrote:
> > With `run_add_p()` callers have the ability to apply changes from a
> > specific revision to a repository's index. This infra supports several
> > different modes, like for example applying changes to the index,
> > worktree or both.
> 
> s/worktree/working tree/ ?

Yup. I've applied all of your feedback locally and will send it out with
the next version. Thanks!

Patrick
