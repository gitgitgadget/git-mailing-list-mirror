Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC322475E3
	for <git@vger.kernel.org>; Tue, 27 May 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342405; cv=none; b=Ms5WrjjLT7sFme+zjZwnBSYIkImQcCq91cvCrf7tO93Eq3k6LZXG/teHF2jshH5cHsPxEEihAQ/gRn380eoA6jia+ZlhK3wBjz7pZJYpmNU/HedsCb1u53HEiKI3BEnuVAeHrjAGqBOy1FJ++p0eSuzSJLjo0nQIVG6RfWgTL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342405; c=relaxed/simple;
	bh=xzeuDoth5D9QKzKpORrriNQgbk18z4qCZnpoyM54M/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsnK2GennmgWUHJ8I9oJ1hsNiIeAm5rElGmiziKv2k0go83TYAYvpb9JsDrgu62qHWmoKAyp1C6G877paBly1fiFv98OzsmvmUwEVmorDqC+CL/jqlCqUWO/yFemuuU1ZxbzcSyzkY3Ur7gb80rZd+GZMmRgK0VEk7Q70Opzw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I6i4WNLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2k6IwW9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I6i4WNLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2k6IwW9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 370CA1140110;
	Tue, 27 May 2025 06:40:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 27 May 2025 06:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748342403; x=1748428803; bh=+Qn9lH9h5l
	+VRRdHA18Vk1H8ap7Sqs+0RYiJiIh/kAE=; b=I6i4WNLN9rcWSzxzapRSo5Clrz
	44CzRK/JCP9UAwQ9XLpYxlK2p5LACaD5zwZwJi60FTsJfYEbFMlkmn9GH0XP2gdu
	gaHT2ud96hdbi1aeWWNiVCpgWYXXYpJdkCVjXaDFhVzc2j9/ue764AjZP1r6XfD3
	khz0j3v/jdqPe4nDrVACVeCltq5fFvefSxriNUBJDwskEjR0ARAhB1VSJWd47uoF
	m9rj2fR1MTbd7Sk+QzlP3KJaiY0PEc8vYVK5IAzFE56cnI6Mu86dPMtggAeIEszw
	TzF2yp15zVWCvCFviAZN6jsYHAcaT5h3w2BrdkDqq+JKeMVt01KeSpxoSHWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748342403; x=1748428803; bh=+Qn9lH9h5l+VRRdHA18Vk1H8ap7Sqs+0RYi
	JiIh/kAE=; b=p2k6IwW9vrIbuhR6thdLBU44kbrCwFYsYnHls80faHw5v+XndTG
	MNZY/B1P5blJ8llsZC1Gfy6sm53DLFkE9cuSL/YpYk9Ie8r1Ojb6IvoyTjzN9rJR
	saJwTU+esIvlbzt7oiEdUXDLgfN8YuqdO8tgPakOTSGsYtWwUwVHgy00el0qlJPW
	ozZPRXR9tFWGnPcu9BThfGYn1roGuD8FUnIDsxaueaZZ42e0qZ0RVxIQjfc/fYBS
	5Yy2wL0hzc/V5EN4xJ88crbQOL3daoN6yfMeCDOkn8DZUlUMVcw7qnEIBBGjDsBA
	pf7GZ70SSiWdlraMPoO8rv7fSzy9l3+foSg==
X-ME-Sender: <xms:gpY1aKU1Em0CMnVDV4QKlx6enu-t2A3EhkSNtf6n3avWmaAYhRak3g>
    <xme:gpY1aGkxBZ_O_8JnHt3NDUQkczd5N2-s6rMa6JqDjCjb1SwTNtSDmTR98s53Q3GiX
    _zPe4VZKaCvorY3zQ>
X-ME-Received: <xmr:gpY1aOa3xvF3tU_T0pfn0JlyESDe-YpEsKFJciSCDJctQ7eQjDTWTlT2HHyzlYpq1JGnRfHskVdvK0oHgSAeJf7yk4fwtQW0BsYM_oeKk3FOZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtddujeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gpY1aBVdwLtP8aasbIo6l_BNDgE1VXVlVUK0ahsFpRXaMzFuzwWLoA>
    <xmx:gpY1aElEKAaOEUbTOs538drus2XcpC4b1CkQAaAkwPQEYHfxc7_cAA>
    <xmx:gpY1aGdFsY4ua8X3UZw4vS6w-fuQoZMHMrZ-6OelruJHqVwI5nYFpw>
    <xmx:gpY1aGGoZsUQHmFUH8Y44AR9QKNT02n4W_8AdD1HgwCHCGJSmvSSLQ>
    <xmx:g5Y1aItu7Jd8V33cD0bqm-JLbt9JZIDzoj4Rut5BKpwCwNzHrxg712PR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 06:40:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9cd59c9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 10:40:00 +0000 (UTC)
Date: Tue, 27 May 2025 12:39:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 5/5] last-modified: initialize revision machinery
 without walk
Message-ID: <aDWWf2YSgfPrNdrh@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-5-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-toon-new-blame-tree-v2-5-101e4ca4c1c9@iotcl.com>

On Fri, May 23, 2025 at 11:33:52AM +0200, Toon Claes wrote:
> In a previous commit we inserted a call to 'prepare_revision_walk()'
> before we started our traversal. This was done when we leveraged the
> revision machinery more (at the time, we were leaning on
> 'log_tree_commit()' which only worked after calling
> 'prepare_revision_walk()').
> 
> But, we have since dropped 'log_tree_commit()', so we don't need most of
> the initialization work of 'prepare_revision_walk()'. Now we ask it to
> do very little work during initialization by setting the '->no_walk'
> flag to '1', which leaves its internal state alone enough that we can
> still function as normal.
> 
> Unfortunately, this means that we now no longer complain about
> non-commit inputs, since the revision machinery check this for us (it
> just silently ignores them).

Hm. Should we maybe have a manual check that all inputs are commits? It
doesn't feel right to me to silently ignore invalid queries.

Patrick
