Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45D14D42C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540691; cv=none; b=moQaXKd442t5k2HY1jTJA7mVmNRUC4muTNi0W363/QF4wQ0n5VcZd0mSJlj2w+G10K3KDk4r3t+BP8Yz+Py0ArZngrreJ6HZ4et0ecBucrq6eSrkAXoUfiw4EbDDN6dUyvudVTPVXVlai68JzzDtsfKnvBHJMQNAdJKdj8Arn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540691; c=relaxed/simple;
	bh=Ar1A81WhZILwd7ZasRx8OXstuX1ul/q+3gNrjfWp7JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OArvU9Ue+pSyzNT5k1pP5wyCAx5nMxINr4N7qKJ+jgNxqDrF3nnwucv3ItctKaOXlTQMj6rVC7D8NHZMVB3Elme4LwONq8vlrJkMm1vTzEiESboJ7iLuB12DCb/GRjEApAw+h7woQyOI35QO4jd5L4+uOF9aOqSAic/U3zA8UAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0MUezA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMfuFYQq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0MUezA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMfuFYQq"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71E4E138FD66;
	Tue, 13 Aug 2024 05:18:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540689; x=1723627089; bh=x27l3dtxWS
	xKK+r9CqeDoMB+zn5CmItRwaFnBtM2iUk=; b=W0MUezA9jfpahjeyhGdjXdq3+4
	O61RiRtKf8Pfc6uO1o9BzVHdFYNkwjLGnB+ZKCn6zaD9jdDopRBL4ghtUD0A8Jsq
	+URcSvmdIips0FhxzwWDF9AvgU1Hg7B8J+LgOYLCX7T5f0FrPpJkKPZreJsWgoXc
	93reSaBFLv7k+aIw0OniFoU7BAqXMYlGsQMuLXfX/mTf0Oz7WJsVCNM5AOygTXmA
	i7elnjY0apCqExn0Q30XGjvFi/DPFtNz+WgG+0v6dgVCsbhiX82FQzyJHdVR4Un7
	SzAeEtVxPR/x3f2YEVLCMqcq2HoB+oytI2vl7xgoDYX8ATX1iO7aC9eaLJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540689; x=1723627089; bh=x27l3dtxWSxKK+r9CqeDoMB+zn5C
	mItRwaFnBtM2iUk=; b=WMfuFYQqx9XGpRYdArSrP5vET+owbDK1K5bhp/fQXKRN
	y6KAkRJcEpYeuVaLOn2+mpuqrQJUU067Cz5QejHPAgf8qBWBI/v/B1U+SVLI9EPu
	daA+AhkCB5rTGZO0fg30AtQGonhVKxur2TQMJoMqbAlfCtAHx+Cmi0SZDliU3Bkr
	Sk4W3KUHx9bPFfjAcDkeZjKZjvXKncO1bWJmY2ilapdkXXm9hdT0oG2OFetwa6YU
	yT6BJGTEJoUrioQ30fhu6sWYNUFyCPnIxNpQL4xIVdO/gI2zN8RHSZkVOC5DsnB4
	Ff8l87ifEy33YlrwfuuFwxc64CedZbUJ/1JWnRtkag==
X-ME-Sender: <xms:0SS7ZouaTzcIxuJWK0-cwuES0Hy0d_ZXhj4YH4ntZDwx9zMZ48gpTA>
    <xme:0SS7ZlfL11uYiLumMHihFT7eJbtUwk6flLjxCK6fiVDUcwdmNoE_NU7PVJ0tGiIue
    70i7CnaZ7NAnuwirw>
X-ME-Received: <xmr:0SS7ZjwWJtlnqnXhGTmJHxurIokBxa6sZEQKjlaMjHFd0ug0XsdDJpQvbgGzhKEBSZIgjQxj7Dk_gMo3TFuzTN7SMcw1tY0q1jL5Jic1T9Ajow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopegrrhgtthhitghlrghmphihrhhiugesohhuthhlohhokhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0SS7ZrPLZHlv-0A_aTKQYP-q1x-v1M0cmjNu4FyDhGVKbiY0GOawzQ>
    <xmx:0SS7Zo9RNX77ARixIXXB0n335jshCGhIxOnx9vXYmy4KNbFwRcJRAA>
    <xmx:0SS7ZjXQtFYgWpkJB01CBdPi3uRiQBnc1lOCPI_6fu5VPLFgDCO8eg>
    <xmx:0SS7ZhfWhbc-q4a9-jv3glL2J7OqBAbRTh-vMR_9KTgcMBPrbqewpA>
    <xmx:0SS7Znnei9Ld-iHigZT9bcwiYA6hIoKz2V7wv5KMY7KFl_KJWkKro6Kk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:18:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c7609ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:17:51 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:18:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: ArcticLampyrid <ArcticLampyrid@outlook.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] bundle: fix handling of object format
Message-ID: <cover.1723540604.git.ps@pks.im>
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>

Hi,

this small patch series addresses the segfaults reported by
ArcticLampyrid and fixes parsing of bundles that have an object hash
different than the object hash of the current repository.

Thanks!

Patrick

Patrick Steinhardt (2):
  builtin/bundle: have unbundle check for repo before opening its bundle
  bundle: default to SHA1 when reading bundle headers

 builtin/bundle.c       |  5 +++--
 bundle.c               |  7 ++++++-
 t/t6020-bundle-misc.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.46.0.46.g406f326d27.dirty

