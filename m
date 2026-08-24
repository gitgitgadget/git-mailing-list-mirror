Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1A450413
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588587; cv=none; b=PxE6ajR3mlUrmbkVT9ZJRGSXF9SA33Y893b8Z5MWBHPvvVXc5XfQSNg3szxkOEsa7kRN40aSna9WGXyWTMn86sC6/ZV/r8PhAPOZZ9yaivvUpDLFk1mdJWknckQh3Av6UBF+6dO3zTkbnv+01/LYl9R5fbqdyXxtcFAn3VHyM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588587; c=relaxed/simple;
	bh=+wXcKpOKTi7TOk8F43CRLStTezmQ5XeiuYvybISEal4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amc0szAl6qv1H8sE9JSaM8iCmOHx6HQUPrXf5295I/4x422gIa6/2xxuYQ9A7ABszVouq81HIMywj577HDzygDjPhAVb2iDxsEfT+FjyHOMccRottVOU5GaS0DPJ2Wu/NW+xeK9C9goVg7HvrYegUu/PTjA3yMTgEfqiSa25vQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oqFK3QOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U29ruXgC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqFK3QOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U29ruXgC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5602B1400019;
	Mon, 24 Aug 2026 12:23:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 12:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787588585; x=1787674985; bh=+wXcKpOKTi
	7TOk8F43CRLStTezmQ5XeiuYvybISEal4=; b=oqFK3QOr3Epf3iuoGPA5A4gqhf
	nFgDj5MdutsMfZshMyDiJyIPA3pDVwvdrov9laslUqO+67dSdexV/8DQulLC+nJB
	Qe13G5Jjt9BVTqXPZiPaQneIVc9Y6LozCZH7vfmRGGVzTJVQyvmVLAy6gUBVtS7P
	LcaskngQ6+A3R5nQyHnQV3o0SNmk66Q5Y4MX+zG5cgkM+sWeg65oGf0zGHYgQYYV
	A4aCGEmAKobrUSWGuKxe51FJriJiFcgMTgpb5ODIFDKjL3LeyYZ+x5GiBLMUG5QD
	YQ8nZe/AbKkpZLsNJEuUh2lWRxx0ONtxL25AExaizZ8Yx9bBrZLyy0A5JHvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787588585; x=1787674985; bh=+wXcKpOKTi7TOk8F43CRLStTezmQ5XeiuYv
	ybISEal4=; b=U29ruXgCN+wM1fSmHdIXxLhh+rURQZJi0YPBF8bpofxtA8WsNHs
	tvSP34CFe7d6KOdwoveHzzYEHP+wITp0ZdvFkjjcn4xU9wwomp0MX3xvWYCIw7BB
	qRk/WIFGVT5tI5VZYT7eL0OBRsX8sLNAwCu3mQQAsHHzdceGTh+gXst/eeQi9mEt
	z2hvw/e75LxcrQhvCNOo4U0SplQsQmEgneU9WYP3cka8lsJxxIegvMPl/oRk4T9u
	p45YJ7iQZ2PySdgCcAsKpe5DofR952UR9egJAEu4M4oel+mXLsKDWYV8UQGwmMNV
	/26mdiOpeOqmjWxHh5YOdFGGHO7tHhhF4SQ==
X-ME-Sender: <xms:6W-Mal_iMzO9jSsRpXhRuOBMSmmgrJcTdEalWNKbAys3t9NnQVoS-A>
    <xme:6W-Mar_A2npv189mJitMliHyo8jxdwohjQeTcrKuy89sgRcGJPWeMBMTWC3mVHf4I
    1NZzmkD1U6okHnhUHXpYHjmaHsx9VLUzVdZTORfOD4HlxdqVknXSVg>
X-ME-Received: <xmr:6W-MalSHpxWap5-YOCgF5fyZ0ooxkmj2PIG42TBL89FS-be3rdx77G6EFpiND8fAAqjYrzl-wRMglDbzhvgDL5k6fReXDn8vzQ>
X-ME-Proxy-Cause: dmFkZTGyZenG5+Ang1bO7PWNiXcV8Qc1j3O0A1BfUEVOZDohsDWb1htjMYestTXonGmZSf
    WUzHjjBRQuSg+xD2obrgB8SWFQplhhxVLR7tjIJKn/vJfIb6YGv6SgTmPCynXmQ5sJTGwK
    5zgwKIVglko/GAt67XFOoOHT1ognfL/9n5CpPgRPo3Nh2fRLhMFU0tx/pv5XBtmkjyB8SH
    gFm1w/zrseqxEUpScDTAT0TjpHXebD9H7NxcetNR06ng4QsirNar12pF04j3BNbULi3VXL
    PlUXqTw+Ov34U4XFV6XIhdNWpuE+0lZl2Cs2ufVd/Dm9tJtsoU/XtmmTTf0W6grsAQcnqa
    D26IiQgxScq2DMKCa5Eu/+OqAF4MpmHhsVlj4yzZq2mTxK1/ihF4Ky0Y7+1lLG/1eK2vnQ
    Xx8jOi6KqB9sJe5l6mXLijAx1KsWJsHMp+pTOhgU+vHpxFHrnU4r5elcUluqmb7EPldX+p
    hDCK6ZRxYFaZvqAwhB1EL91Hol/ppFlYvUmEU3B93vOZRbdHYnxK4gLc8bxx48oCKcA0AJ
    brktHIls/Uge+j1xoOqI08hkah3lanWmfj+PSZftiU4Plyxn12+h+m4TDW5TQww+yl85Po
    Nr+VxpExRt4PvRdWZUN1//PbvQbSO5YXHGWoanf7k/APCLQwa7g1wS/5k5vg
X-ME-Proxy: <xmx:6W-MaveECeS2lYm4cs0JEwoJtAjaSFPl3GhGFQShU3hB1Y4iIVbfWw>
    <xmx:6W-MapBb7LKFMt5Z4hTUd9omYwiIUOt8F59NAK8O5FF-ZeCAnVI69g>
    <xmx:6W-Mahm88yPKDKTyJzERyvqhENEm5cb9qoO08DHwCVsWdihS7fsKTQ>
    <xmx:6W-Makfoq9LBxl1Y65H1DDPMDW69v0PPjhnR2ZkqRIdjcAoNqgzCmQ>
    <xmx:6W-MajNee_xFoSYMzpqoB8II6IKzBx4u0GPEnj0cobwRZ2pK_NvPWKmG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 12:23:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Alexey Samsonov via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Alexey
 Samsonov <vonosmas@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <xmqqjypfqz9e.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Aug 2026 09:06:21 -0700")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
	<xmqqzeyeujde.fsf@gitster.g> <aor07LvsXOy1p7vh@wyuan.org>
	<xmqq5x10vowf.fsf@gitster.g> <aosVkqwcsmAWrDr6@wyuan.org>
	<xmqqfr04thhe.fsf@gitster.g> <aoxkQHCGJENGxV2I@wyuan.org>
	<xmqqjypfqz9e.fsf@gitster.g>
Date: Mon, 24 Aug 2026 09:23:03 -0700
Message-ID: <xmqqfr03qyhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> By "sufficient due diligence", what I meant was that I trust Dscho
> well enough that he's done a similar analysis to make sure that he
> is copying from ourselves.

... or wrote things using what he learned from other places that are
OK to copy from (like code of BSD licensed projects).
