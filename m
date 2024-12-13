Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771979F5
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067521; cv=none; b=tKU7hM8mEJFzR1N9IKNb65Jef84j2JUh0BpBjyhf13ZHmNXUDXKIyn4bk2Yqc3GEGPY3KoklGxEMMSdeH04A6WouuIYcTLmpB+P4rGCiDB6Djp98KHnE1u+MkpEf2m5Vpu8WPKiGzHb/u78WzgFfUdDJZd3seM5RlvDmxnQ0bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067521; c=relaxed/simple;
	bh=Bod3lcOi9wqfBxKj7jw6UkibJRxldaIa416b6ow/PQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyJ8UIiakpgaohvatYjLhTyGT1Un/t/v0cmPW6HowxX0QYa2CK1cmSiWdHC7pZpVvDQYSm4FulOQTOdSEqA7VYlpu6bxem+C1ZQGTP9/T+uQz00K+JGMr14KFINqVPCOXZpmS8Nz70/vVqhFaOn9JY6qpblBDop7VvBtxBY5Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qq9JpDY7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dk8+G8JA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qq9JpDY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dk8+G8JA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31A19114015E;
	Fri, 13 Dec 2024 00:25:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Dec 2024 00:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734067515; x=1734153915; bh=FoJEOVp99k
	LyQIUezGvajx+EpbbOt4hkU1Y5O0glhM0=; b=Qq9JpDY7wYsBXBXspHu+8Crp9l
	63gzgTIllxVoF0xeF47alCyAc6izG+ATfbEJTDQVzVyl13qRRNJ0pHuSAnIaeQ57
	If6LFJQQDkHzyNJg/oUm1FIdzIS8f5fGXsz6XFOcF3LPM3ar2L7AfR1bvGb62rOW
	51zzSm1w1ZeUQao0afLDIynRHaJZgm5qSzWUly/WID8XF50IZWyx2Sd+4Fy8HwDy
	EHqLuUdyyV9fAitj2KWKbf/vmvV/QBevUaxpnyXTVX+IbYtPeVTxw2m8vvkI6ZdZ
	SUJa/7X70aJSf0eq/hwyUT0ZvZUYtRz8JLhlszFZ/BhJB9eeHnD4gel7xRdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734067515; x=1734153915; bh=FoJEOVp99kLyQIUezGvajx+EpbbOt4hkU1Y
	5O0glhM0=; b=dk8+G8JAI42LBJDEqbUfSlibXAT3p2gcl/VY1vh8qwzFanwxZy2
	B9vdOBzyWkJPfnnAtRmX+S1bX9ozZQw7L3ChQ5XE0yFMTCYSrseO4ebKgUndcS8s
	X+oFevA9ynVzF8eBYRVrtt34gfYPnz7+Rl+euvRD2WuZVIVLIDutS310Bw8dRodP
	Ql66OkcqFAx6+qsdTFhTUB/TTtP//T6tYzw5HxkBjmwa/Tj64kPmslprk86Rz5Bv
	tfR978SAj6zP4xCy2FZ1KLp3PCH7LBPt8kqMt/WHc31nnVphIalD8iTu1Xj0fNz6
	t0+1muBHSy/YQB7qSPxW9lFUK40wfxmifNw==
X-ME-Sender: <xms:OsVbZ2kvc-hAvl-hET6muftzLL-_DHTqejlg7cTLy_ogx1DC1-CYgg>
    <xme:OsVbZ92hZYCg32nDwiJYBA37fgKWmG6z1Yp2aE8fsJ9-qw2oascaMQvmd77x5HM01
    H-nVbDyOAUNaGLoDw>
X-ME-Received: <xmr:OsVbZ0rRzs-G_Lvh-yBMLCjEGtyUPT745xWOlumHGebl62YW8m6aVYzuvdRWdYiaTJlcyOY-uXA2UnEcsh9rsi7fqvX-LpiJxpcR_9QAs4u7Xfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OsVbZ6kEM6ydRdje-SI4f1y9HEoHKhuM-95o_yYNHMFR8IoOmMEM0w>
    <xmx:OsVbZ02W-D2Abs1iwnxMZNVysI7Zj_T4UqDMN_qq8_okJ-uf3GC7eQ>
    <xmx:OsVbZxvJw48PkGtgYSEo0Ysy9dPL3SJmyq-Y9eOVosYWzGzqtuyN7g>
    <xmx:OsVbZwV0jF4-UhSsTm6IvNOMAvxjEQqcfuPGeVwB6Q-JUB3TUXB3Tw>
    <xmx:O8VbZyBAUatmnx7c5cEYFPBKn7YCgdP85zJrB2APId2AHSSAnARqPA9r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 00:25:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27852729 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 05:23:34 +0000 (UTC)
Date: Fri, 13 Dec 2024 06:24:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] ci/lib: support custom output directories when
 creating test artifacts
Message-ID: <Z1vFKSPMvLNFqBCK@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-1-28d18b494374@pks.im>
 <CAOLa=ZTtkM_unYCjgQf0FZCo=4KOmOiRosC8jPOcs_Np+tCd-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTtkM_unYCjgQf0FZCo=4KOmOiRosC8jPOcs_Np+tCd-g@mail.gmail.com>

On Thu, Dec 12, 2024 at 02:16:30AM -0800, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Update `create_failed_test_artifacts ()` so that it can handle arbitrary
> > test output directories. This fixes creation of these artifacts for
> > macOS on GitLab CI, which uses a separate output directory already. This
> > will also be used by our out-of-tree builds with Meson.
> >
> 
> So currently in the config: `TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"`.
> So this is broken as is?

Yeah. I've noticed multiple times that the test output directory is not
uploaded on failing macOS jobs.

Patrick
