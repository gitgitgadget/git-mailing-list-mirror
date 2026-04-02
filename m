Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EA3B2AA
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159771; cv=none; b=tLSpyMJlYqd8mECMdeJ0NidWVE25Nrcoxc+LYJ3hp5HHhj7oiRJbW26ODb81UoVNgMMM+NRZd/OuHkcKkIw6odozLdAzNpP4qN3nqfi4izm5QQNSG+OAZ+G2H3Rn8Kg/pJdV5H3eS6X1678Og92qWihOJ7LdulcTBBGtLypnXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159771; c=relaxed/simple;
	bh=EXu32YO+1uDsIhyZng/Awr9iS5nwqi7gv9cXdIyT724=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAHDK6lBoX1VI6N/5ok1ipeZwYAb/MGPEbr+TdWAtPSks3Zh8jyYRz/UDaRMlD1KlyteNDcGHASQqlufdcKi2tBviVuKrN0ItHIfAdZEgBdlNsr/lAxhwJBDhz0Imy8HOsD0GzEGq8Rig2ioST8HLp7cYtnHEJsD3u7nstKOTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gS4ObUYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0U5/8mW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gS4ObUYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0U5/8mW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BDFBBEC0141;
	Thu,  2 Apr 2026 15:56:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 15:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775159769; x=1775246169; bh=KZzTnNQPGZ
	SLQ7QQmqTL/2isso8508vxBykBAiWuTNQ=; b=gS4ObUYwjsKe2FILd0A9/yBtIO
	2gK1kOQ1Xqijiufx0JFzcV8+n4xnZ0uuvSgvcTZteIxP60tqC6ahkVKY3Pcnl5Od
	zTt5BLN7+ZkkjTVWE9kYtnIj9zQJGLovEzts3dK6ka0LeG0VlgVVi5hjmEB6tGar
	81mViN/+ZA27LwXP8faDIMT5GnMhSOg1DvFCCES69t7CWQCEYZBqWjWwf7bqp9D/
	mSSosk64/0le5OqHsowTh/EDwIB0/CRgGooSRsj0H446KfLeptlLEPh7cC9KGnQ8
	ETiN51wvcG3QyqZFETrQM40xR61JoEylJB0GuFR5j5yqVOsMUxMjFVQLd23w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775159769; x=1775246169; bh=KZzTnNQPGZSLQ7QQmqTL/2isso8508vxByk
	BAiWuTNQ=; b=E0U5/8mWMrTvMp4s2iWTTd03VppRiQUpTkHzM7oBBblnWQEq3ky
	ixIx4jRAwAhTEFWcm/cal+WfEZKV2LpEOYUaSKGQOhZcR9kpZQ6n6ogL5vg2VG71
	vMxyzmvirDOD1Wy4WgD4UK5dBTRO+NBlKpRvazznffWkz9ZdKAR19m6nPIYJ7z6Y
	RNmXpu0HKxg3z1Ya2Hj8iyFVOfRhqT/c+yqM1ecLH2oAV2uW93OHAXNPpmXo98d3
	Lj3muoecVwR00ljmGIbTaRCtiCdpRnBs7D5sO7sHKSvKMwJocxseUZmcDv+e96KR
	YLgionRppw6Cv34rzIOepWflIUCCW1JVLSg==
X-ME-Sender: <xms:2cnOaUn-ZLc3ePRrxyjN3OGW6v92ENhIVDA87NBudxPRqEjMFjXuyw>
    <xme:2cnOabTSkz1fodE0JYODTfhPznJNLnwjCymXf8e4lm_gCBWSvFmXULnau85Vo3Gyo
    cfmzFjlDfhVfD6kl4XM4bnFYazkndxjNExxvqIzOT6HRYznX4PzfUw>
X-ME-Received: <xmr:2cnOaQB3rJGZpKDWMLrNrowtgr6xH5U-px-DRAdikFnL7B-QTuQi6xSaFcjyjhyOz07tjj-dbzmsJeJX_dO2-6u2VcTQUAqr-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhkihhnghht
    tgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2cnOaaQuI5YzTTGLR6GPLNvz5GuDHwgbnB8hnl0z7BbiqmOL24BwJg>
    <xmx:2cnOaWqvcyoG52U8K5c2sxiayA84jg5iCoSeMP5wfy_UcXhWKB8D0Q>
    <xmx:2cnOaUxtJK_rMJ2bSd_gwUETZbqSzKqqnVgwQ_P5DjoljiTGqJ_f2Q>
    <xmx:2cnOaTLbl2QwB181mMn9x1AFpQLqW6WnzKH33XAwlGMIwX8HiUipyQ>
    <xmx:2cnOafRljPR0_pXf8m-0b0bB-SQ90MQCHayS8zcAORg2W4G0D26au2wO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:56:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] backfill: error out when HEAD cannot be parsed
In-Reply-To: <20260402191359.11304-1-viking4@gmail.com> (Trieu Huynh's message
	of "Fri, 3 Apr 2026 02:13:58 +0700")
References: <20260402191359.11304-1-viking4@gmail.com>
Date: Thu, 02 Apr 2026 12:56:08 -0700
Message-ID: <xmqqcy0hp25j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> handle_revision_arg() returns non-zero on failure, but do_backfill()
> ignores the return value. On an empty repo with no commits, HEAD is
> unborn and handle_revision_arg() fails, but backfill silently
> continues with an empty revision walk and exists with a zero return
> code.

"exists" -> "exits", I think.

But more importantly (with Devil's advocate hat on), what's the
downside of the current behaviour?

You tell the command to backfill, the machinery does not find
anything necessary to fetch to backfill, and successfully, quickly,
and quietly exits.  That sounds like a graceful exit to me.

Is there anything wrong with that?

> +test_expect_success 'backfill on empty repo fails gracefully' '
> +	git init empty-repo &&
> +	test_must_fail git -C empty-repo backfill 2>err &&
> +	test_grep "unable to parse HEAD" err
> +'
