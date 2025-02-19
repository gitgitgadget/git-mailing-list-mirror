Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2C1FDA93
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984665; cv=none; b=qldIypMaZSD5iVsieywroTtMkc9CVugOReVSf+oLyZKfxB8WnLtsoJFKt0urUrl4F+FV5RdW1D7Z+iuJgv2YXqMMcaC+ykMVoopQoEgC7EoWRq4N9aPTN8h9AleZxkUIIgZJQKGnen5p433LNbWTU1KkbnlNwmYPSSSMV2gsRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984665; c=relaxed/simple;
	bh=KWOUDaftHuV94iqI9c/lbprz8D/2STehH6sjzfEN1X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iw6Srs5Z8Kg11LVVSud6g3PxRPCglJ+zlzSZZxCPT8PJ/w29G38+ZhFomfkVAnxdIfHt7NXG/SDlcMdaelESGomg4L6lS1TOyBH7zEI2fKs6mhAijdL/apkeCbQT/3NnS7J2rZX/0rX6McGBfUQ3cJuo/TuDU+yf8RI38VLbSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FjSAgtsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sd6OM/wW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FjSAgtsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sd6OM/wW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB7221140138;
	Wed, 19 Feb 2025 12:04:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 19 Feb 2025 12:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739984661; x=1740071061; bh=TZPJwvCFTh
	Plnd2aMxNoT/ZC7EmFaR8DZ8EyqOqjCfY=; b=FjSAgtsnDEwLwb2KqfwsaGLghp
	ZDruDUlK9EA7e1268GNz16YqDZ6yNn1jQCV+ZGiIoawUna0YVk0p2C5E6Lg9ltqB
	clqsNiL3vRIdzYZkHY0HWNLU6xgQeSy+b22HW4yEEOofPabY5AqOfWfC0i27bQys
	y7iJI+pcwJ+yjzmTitmK/ffbn9DA0l6M2CtzrPMq397Isz9of+tFatZrXB0O7o5U
	OD8oeccqNS0WFDoC2rJIoDo8f0aD4U9watbBOATPEHwHLRq2xyOvdHy8RBqZzEkx
	CD5BdTQGSOS31H0bIlUfo7E7OLEmH5KOAQi8yj1NMMkETHuFdFhCQOMACplQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739984661; x=1740071061; bh=TZPJwvCFThPlnd2aMxNoT/ZC7EmFaR8DZ8E
	yqOqjCfY=; b=sd6OM/wWYnude4ma86LvBfiHNDPow2Uz09GDXWsIXCf6O/ZcYc6
	zlladG4Y5HTLjZmzZgo7rBRj1AICnHv54qbd//6RbcYSg9pZ5gsrPIsHPA2M9dXx
	Ylc2wiOFv/0r0RWLXYlNH9oQRWkUnwl4zRzrulFyck9TvNei2WSvDclhyKjufN8/
	9JMzZXRq7+Y3mc1J9JAuVede+Nrii2gBdExODiZbR6NsmNu/QOtFcVUuswVZUB1o
	Q0MYYqLmLMAKAgwiFx2r9UvVJh/vA+9TNOPr8pnZodFG1V7/l0W0X2TTOCnP4lo8
	eo1gdOWgzFJ+Ww0jw1DoUxkSxpRGtsSe2qw==
X-ME-Sender: <xms:FQ-2Z8XRn_M_eZ43Yq96SQljdzHiEQtbspmJcVY0OKa0XgiGQFdSqA>
    <xme:FQ-2ZwlrFdFZZGTCo5xRz2pXWG1FBFB5xvLB1KQlSowzsSfMI7-XjjAZxpKG40SWP
    mgivlxpqaO6qgwzyg>
X-ME-Received: <xmr:FQ-2ZwYB9bVRG50YSl0aYwKI2bQnQyeB5ti7v9VVpYfpKug3d7t-M2q0TQE2tA6k3ceXl8AaNKGit5pPaI538LbqrpB180I8_cV5JdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FQ-2Z7U_qALH8LQuvKW8xMPMhkU6t96Ru7SNzrsUn9_E64MxEmgr5A>
    <xmx:FQ-2Z2mC_zeexxeEgrK9JAe-O8LzvkDxMyvvaJbbirkfQoVpF5_Y1w>
    <xmx:FQ-2Zwd5py6fnzAon6o9F6fgRjnp9tv2JtYtnP4InNqeZmNyO4ypCw>
    <xmx:FQ-2Z4FjHGt3PnNG98zItilArTga6BgPUYlOwrZdpNAFih9vC8ZKvg>
    <xmx:FQ-2Z0Yy6bMr__rUucJypSRUV59dizwLYywT8s0meSzDES9ymCw_IH_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:04:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <87a5aiqmeq.fsf@iotcl.com> (Toon Claes's message of "Wed, 19 Feb
	2025 11:06:05 +0100")
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
	<20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
	<87a5aiqmeq.fsf@iotcl.com>
Date: Wed, 19 Feb 2025 09:04:19 -0800
Message-ID: <xmqqwmdlg92k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> So can I suggest to name the option `--no-reflog`? To me that makes it
> more obvious the reflog won't exist no more after migrating, and is more
> in line with the common UX of Git. Also emphasizing this more clearly in
> the commit message and help message also would be advised.

I have always thought, until I saw the message I am responding to,
that everybody would expect that "migrate --skip=X --skip=Y" that
usually migrates X and Y and Z would lose X and Y with the
transition.  But I realized that it was most likely because I happen
to know that the choice between reftable and files backends is
"which one do you take, you cannot have both at the same time", and
it was clear that "skip and keep using the old form" is not on the
table.  For all others, your interpretation of the option name is
entirely plausible.  So I agree `--no-reflog` is really an excellent
suggestion, even though `--reflog` option would be a no-op, and
`--no-refs` would be a "Huh?" option that only logically makes sense
to have for completeness but nobody would want to use ;-)




