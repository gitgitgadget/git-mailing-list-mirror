Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C3411618
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971136; cv=none; b=Tc7A/XhCdZ9cjP89bBrx3Gr7OAQWOMqXHu/1ugURvpOelPmn9orVrNSn/kLrDkq1cceIbj9ulhj7YjmJ1R6SszHWm1sDmAGfIGA/MbNo5BvWhDcp2Hl1exxnhF6BCSFAWq+9NPLM+9Hpmq67v+LnV27fYqMpn2DtKXTevDO37Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971136; c=relaxed/simple;
	bh=fXKcKwg8vaoiJOyZP38cNXd56+BAF0/MRndB2UGzxN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsQHfDX/+y51qvyobG2hi6w4cwgZVxhrMvzGKiQOJAVAr2sycLN3+TKFqLiDcCl4y42NI/mwLLXEDBp6mpGxz/TsGzYMHhYmHXAKj7XMCrflY7ABPhzQdCr/b6FXyOBsEe7NclUzw+Y4/cSFIsTe365kjzA1Rvi4TFpuZSsDK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=biFpYpTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHStO/DI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="biFpYpTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHStO/DI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E41614000A4;
	Tue, 31 Mar 2026 11:32:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 11:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774971125; x=1775057525; bh=EBjWc/rAym
	HxId7j1GT76gflKxcOH5JecidGlEDtWQ4=; b=biFpYpTIaoZJs6+uHP4++lZYGZ
	FDIuylpS4LjR6cu0O5yDMsJHQtJNOj3Hw6AdJofxW5eJUDvb+H1tbUv9wkNOk9Qf
	FWZfqDPRNQJm84TTjWtHwFOkjjASOKnCp2MXkm9nahjVl78s6wIQ55jCjTGmg312
	A38J9KmBjNge6qw8M0oCXuFdFgShOB0mM3sdElm5aD+YGlB6bMjk+TR8lXwVr6gF
	E+AXVMz6P9Mrx14PtYu7f9Kr7AefQDvQtbLw9nIVzYmQcJn8ZHEX6GqgFhbMk2H+
	80Cxp7IyqXx2HpY+zefLS+GSoGB5buSe+EqEbdwdsU5CaWNO5xAp1eed/1Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774971125; x=1775057525; bh=EBjWc/rAymHxId7j1GT76gflKxcOH5Jecid
	GlEDtWQ4=; b=NHStO/DIgx0Crm9EDH4xnKARlAVvTmAP4QIwvWciXrZOWIW/mCK
	2T9Tfmcu2poOAi7o7QwPXIvQqMtyqjWdc4JC37segIHZzUgPL+A3GYJrPIdJ6384
	XYOvsaWQ/Y+w5Brf+TmJfHFDE0eWyr2Cuss+lGtkEjfEtFeuvQuNPuqai26Oo4vD
	wbsN+g6BoIzdWGSyhA1mNrtnu01RPRqmnrsC6BiH+izJJ37DQ9yJZB5iSqo6ghKG
	yKoc7iPUexU6SYoJjnXKGs407NH5TMVeks2UnHarnlNOYMDZaoJ5KEU7MtJPZgWx
	S/bCFcRdV02TvDTgKqWcwWlduQJL0COddGQ==
X-ME-Sender: <xms:9ejLaaJcKZBw6gKroGCQgiuD9wfIApzJRfplaYmJHNeTC9YX1HUxog>
    <xme:9ejLaRP4lvpnGQrbTkF90k8oCL31npxHjKnRrYKey-93kuuS0hXztwq8sH1A0YBe6
    18fymJ8wiDhW3r0hOA6hbA0NAjaFMGkj4T1zrakMOpuI9Ebo3iv6g>
X-ME-Received: <xmr:9ejLaQ5wORQsiBgOvCEBSZPcJArS_e3HVXiCfSntThUUn5_7ykjU68y9E7WblS2Ff1zwm66KlyfcQINHl0IR-Wvgx2sV4nRJUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrhigvshhhuggrghgrleelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9ejLab5n8hyJjT7Rtdad51-kcshgnDoyxF1r7kjnZGo7CZ08kv_5pg>
    <xmx:9ejLaWFu0atC4Vn0tL2mgyEhSq03GK4D4IOJrf6e-Rfj7Okp43-dQw>
    <xmx:9ejLaTUjexE2-tvWrG3Bm8jB_Bx-LmXdUjTu4vuxS1DlsLadFdRwZQ>
    <xmx:9ejLaSXsrgAp-oEvpzJXDkQSm3wbjdICy8v5lUWGFK66a14i2aqYnw>
    <xmx:9ejLaeKSdAj0kPEDUJyGn5rhcD3OtR0dLcnQG4sPBXASb-ZGM9sgISdd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 11:32:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] unpack-trees: use explicit repository in trace2 calls
In-Reply-To: <actcHT_ZHkb58ndi@pks.im> (Patrick Steinhardt's message of "Tue,
	31 Mar 2026 07:31:09 +0200")
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<actcHT_ZHkb58ndi@pks.im>
Date: Tue, 31 Mar 2026 08:32:03 -0700
Message-ID: <xmqqy0j82ex8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The changes in `unpack_trees()` are a bit misleading -- while it reads
> as if we don't use `the_repository` anymore, we still do because the
> function starts with:
>
>   int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
>   {
>   	struct repository *repo = the_repository;
>
> So would it make sense to maybe have a separate patch where we inject a
> repository as a parameter to `unpack_trees()`?

We can see that "struct unpack_trees_options" is rich enough in the
merge context that it would be a natural place to have it unless it
is already tehre.

In fact, o->dst_index->repo should probably be what you want, and
because it would be insane to start from an index in a repo and
store the resulting updated index in another repo, there probably
needs an assert(o->dst_index->repo == o->src_index->repo) somewhere.
