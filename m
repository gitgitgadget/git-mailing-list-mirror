Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08123C9
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877367; cv=none; b=Cz+sDO8M8J828jW0d3F0snM6M3fwZ5VrK/EgS7NfwdzKoWBWsOElsN7w3ElncrL9QC9gxZW0KJSkF+1w6awjlEnMZyWf6ZsOwnmn4gc6ZfkII3A0gQiVUeAev+2MBcxTYNyZkIkaolC+oKvcbTF/jfyhrwzOYV1YLbT4QhQ8XfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877367; c=relaxed/simple;
	bh=RyZ7//8b4o/Kh+MuIDYvAEw8GwXkBVIsgnTnLcbjZLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeEuAKiaZIZTCc0B+iTiTaxZMZ2pq0YQn4/K41lva2LNSmhCjxbnzK92i7JOnoMGXaUHzjyXLkDHFj8rFc2zyA07iISuXFQqWBEtLSVVGzsHiOQPLQWV1U0rdxrPNYotcYlVLbZn+bBbALYHAxFRaEohKY6aDZPqBU3HzJbHlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V9psYqFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUE6nPfU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9psYqFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUE6nPfU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AFDC13808C2;
	Mon, 28 Apr 2025 17:56:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 17:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745877363; x=1745963763; bh=u2DiPUnKId
	hz3ZxxrLgkobjcXWUtspY2wxRVMGdaf18=; b=V9psYqFgTZGKOy35zi+Q985p6H
	9WU6LLGW8z76uEddXR8gtK++PVaqTGWr8XMFHTqIs1nbASQa5pRviBLQoLJoiSbt
	8XwNjUYFh4GTKilbfKC1juq3qlql/jOiNckR31NLiyA3mtc0oh0flhy9FHhprLko
	Lm3wklY4B+tQile2dqSlSJbsr8IOMgW6I22eVWD5NXQpczhfEESg+J4ym1fZvcfK
	wOqnBEw6QZucDxt4vDRYPAvwa/RltmfFFfT0ZDW6dGHO6Nf3ySeCF5V8oO7V+Ahj
	/vuxLnTP74E4TouZKNCz/5twKJDJRl9+YhI3/AJfNsDxGRs2hDuM6FOqf+Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745877363; x=1745963763; bh=u2DiPUnKIdhz3ZxxrLgkobjcXWUtspY2wxR
	VMGdaf18=; b=aUE6nPfUArFkgHiDo8ya9YiCfP0NGJ949xHaof2nsRYmUXni1fM
	QnlF1CvIHQrbAoI9D4NFLN9eBiher7t9LMSo7O227LNd/bOiJbLwU38U9EQqiVNE
	nQ7eG++uE6v1F3A1cx3oacZoMD1rBGLQtymCsgHMGa97BC7X/FgEdTMe7uPRtL6Y
	aHv9fLU6hPqya9tNK1wvjamQvtA/KJaSjjGbgquPYc2tWlMyb0/R7uJ2E+6RY6n6
	y12wi+s37bRXG1gjxn59LOy/V1n9B4czibENX9jeOMa9Hop5IFT3KyTKsBvgAz6F
	Sey1oiZ5DaG6mqan9Q06pzu+yyiyOx2/AQA==
X-ME-Sender: <xms:c_kPaHX45lj34tGcdi9q1ED1xf4BCyGZv1JV7UP9H-5HxPyOs3AsLg>
    <xme:c_kPaPkDYyeUi7vCgNfrGqBmGfZjjHoIAFewfNLttdOKGMMUQRpMytgBsiorkeWsK
    3zi8wUy-DGP92_58g>
X-ME-Received: <xmr:c_kPaDa_pklLApg8l0_hTRWfCQPIC3W0Ba0gmb8z9mvdnquef3jZW8XGHqJuNomrszD1OBRbO11avo9WPdZO7Ckk5BJ0-gPlUHMS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepgefhuefggeelfedvtdejfeekueffvdev
    gffhheevleffieevgeekjeevuddvudeknecuffhomhgrihhnpehhthhtphhprhhothhotg
    holhdrthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:c_kPaCVadYokk_VsS8XDS9CSS1mvJMg1NKnUSliy0qwKNxOKCayDfw>
    <xmx:c_kPaBlkVM9teNjXmEEm31pUyKJHKGcEn7lgyysWBJ_0SVrxY205vA>
    <xmx:c_kPaPewz46Hn3Bq0Y_Mp5XKweU3ERZbhtd9AG8QhCLsyqYKa0X2eQ>
    <xmx:c_kPaLHUvS_3KsaHCqg0GmT1cD-0Fgc7ro7kNyF-I3dfVTSwK9RzFg>
    <xmx:c_kPaHT_vgF0Ow6UnkkBkJcvqC8HWhQZP2vH_F0NCF-LU2zp_jr0MdhZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:56:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/13] http-walker: don't fetch objects via promisor
 remotes
In-Reply-To: <20250425-pks-object-store-cleanups-v2-10-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:09:01 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-10-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 14:56:01 -0700
Message-ID: <xmqqmsc09ci6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The HTTP walker is responsible for fetching objects via the dumb HTTP
> protocol. To avoid re-fetching objects that we already have locally we
> first check whether the object already exists in the local repository
> before issuing the requests.
>
> This existence check is done by calling `repo_has_object_file()`, which
> will fetch the object via a promisor remote in case it is in a promisor
> pack. This fetch does not make any sense for us though: we're already in
> the process of fetching the object anyway, so fetching it via a separate
> connection is wasteful, but should otherwise be harmless.

This rationale does make sense for this code path.  It half matches
the rationale of omitting the collision check when you see an object
in the pack stream being indexed that it can also be obtained from
your promisor remotes, which was of dubious validity, but in this
case it makes perfect sense.

Thanks.

