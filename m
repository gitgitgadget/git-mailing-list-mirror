Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E722612
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878771; cv=none; b=KmFufv53RuQlMb210WZ0By7AwrUIVXLwMqtj9tVqxW0mumB/Ff4WkM0ZJ+WYSk4nmKd+1o2cHV1tsGAGnYg1F2h2UadOIxqMv+C1poDp4vqufBFUozENVBWq/vMynbWOf2BgxG8GhE8B85J0BaZMM8b1Jjku5fU5DBfzb6ipDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878771; c=relaxed/simple;
	bh=4Je5/XUH/aJqUXDy+sCLFJ658JKF/oo+JXlfAO1YE3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vl8RZWUuNkDnh17N2/XXgBTG60B6BIuX/y0mp8y+ro2+ox73QWnKH+uJopilETYIzs6K2qtqa70SLWJ5z1stf/D7mlpiKsFMAMWF4oob1ttz2O8KOFz5p8swpXZM4aP9RjIqn7PQLmj19pX3IIoskz1U7cFQNcsnwgRddcpxyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XamKCXZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXG0VwKu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XamKCXZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXG0VwKu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF70D1140083;
	Thu, 13 Mar 2025 11:12:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 13 Mar 2025 11:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741878767; x=1741965167; bh=fizZFo1+TJ
	KB0ae0dqjfZLGyg5NaNioAfXWkvMXIE5w=; b=XamKCXZBG3qMeKCQMTmeSzujH9
	k6CW6nfZmykQyNG7T2XXd3tW+QyniM/O2cKi20lIb3CzPzTtfHNVoMUgIWqaD/M7
	hvECAJRajW2WMFyLoDTC6ZJ9x9TXnfSPNZE6d9Wbdiico2/TFltytSNyGxVKIMSz
	jazTA1LAdE2D7R30iMcJM7v2oCAp2G+DmaLtpCF0Y9ydYLgWRDsOVw2FO+azRl3i
	MkpfphrWreqBihegvKLwjpDbAT1nm73Jxh9bc3NQyXOfWEk4qLGk1tCAE1m3YOsL
	Bw6KbMTyqO6J++gJzR5k9R9XDT29X0hFTY30Qoqc6SQeAfsOCmDsYabCYIEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741878767; x=1741965167; bh=fizZFo1+TJKB0ae0dqjfZLGyg5NaNioAfXW
	kvMXIE5w=; b=BXG0VwKuchVNTb/+SpVkV0WkkVD2ELGA1r38sHThfBXmfUUVEL6
	0VZWgBp/onnDzr5MKSs+mOvo5PKmrs8f5GVUNlYlO5VwE/EqGytRmbldxTLV5NCY
	pZsbOKsOHyudaHuMM3ea/RWGhytGtcqDT9RoreiYiFmoVdcehh/Sb7YwlV8nTWp9
	V/DcW4xQMvESHY1PwuniCaltfPciUDSMrzbuxU/GkeDYwxF3mXH9J+gvBDU1NcNo
	nuyIknjZhnj/P7jiSmjj+W6FT7vK3K8+Wf+Bo+YTTGdd4zDmoYGu+KSfOuoloQ/+
	UKcBRGU/vbnvG3gSg3oRRIaSI/j/o3tkbWA==
X-ME-Sender: <xms:7_XSZ7ze5551ZvZ88BLRXXsrNnzoWnqiAwi7fVwqZ90yeKrijaltXg>
    <xme:7_XSZzTaHKCpgqTW5aeBlz52CHAdOwMtwY9OkohFTd6BS69QqAZj7n4_jw9GBtOxW
    UYt5nRNS4Jw-WCT3Q>
X-ME-Received: <xmr:7_XSZ1X4o09Frq7lPpPyg5SlEf-A3ICOrX_WJzZWt-OzZRkUpl3bvsVv_flD0KCP_THKJj_f62chV61LfjoC73lR-YSyQhh4O2IIpgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7_XSZ1iGLCPEQsLOOwyJK5y1W8c0w8AZrbPyRLF0l27PJwzqbodEuA>
    <xmx:7_XSZ9AHDGAQZBH1QoqgefGBEMZnzHWFo03lKuCqsyAQopssWXBBqQ>
    <xmx:7_XSZ-LPysiI2IvS3aP01Yw9gb9zMOuELQGyHEDGcjiwI_6S9wFSzw>
    <xmx:7_XSZ8AgFcgVCHMf1vb3IwftiECdparw3Ei-Ljnx1_HFmYnGL4-BCg>
    <xmx:7_XSZ_1qOkFokPk1R7bPNGKgSKW0sLhKdmBtFtCybHpou00p6BCWpbLy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 11:12:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
In-Reply-To: <20250313062951.GA96035@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 02:29:51 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com> <xmqqr0332un3.fsf@gitster.g>
	<Z9GpQqm4YBvWF7Ff@nand.local> <xmqqfrjixfwe.fsf@gitster.g>
	<Z9Ha2mFXpojI+aIR@nand.local>
	<20250313062951.GA96035@coredump.intra.peff.net>
Date: Thu, 13 Mar 2025 08:12:45 -0700
Message-ID: <xmqqr031q80i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But do we actually care about eventually having a series of 40MB packs?
> Or do we care about having some cutoff so that we don't rewrite those
> first 40MB on subsequent repacks?
>
> If the latter, then for step 2, what if we don't feed a max size? We'd
> end up with one 60MB pack (again, having written all of the bytes once).
> And on the next repack we'd leave it be (since it's over the threshold).
> We'll start forming new packs, which will eventually aggregate to 40MB
> (or possibly larger).
>
> If I understand the main purpose of the series, it is that we must
> rescue objects out of cruft packs if they became fresher (by having
> loose copies made). But that is orthogonal to max pack sizes, isn't it?
> We just need for pack-objects to be fed those objects (which should be
> happening already) and decide _not_ to omit them based on their presence
> in the kept cruft packs (based on the mtime in those cruft packs, of
> course). Which looks like what your want_cruft_object_mtime() is doing.

Yeah, no packsize limit on the output side, but making sure that the
decision to roll up existing cruft packs is made sensibly, is what
the above gives us, which I life a lot.  The one-before and -after
confusion came exactly because we somehow tried to have threshold on
the output side.



