Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A446AF20
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566557; cv=none; b=RbNr/n6y3ZCsMG7g3DR6xWRKRtGbwl3kENV67/BkyWSFk9bSc2Zh5yE598TeijKMkR5wGOM4bOh2WQNXx79NaIkvsJBaTDeCinJEfR7LrOTatNiOF2Ktr2lMc4o9SdpcCZgs8AH1Vh6Co5z/c2HjlHJWZut8id0J0hwmnbpWIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566557; c=relaxed/simple;
	bh=TXAt6bNtV5b9bui7h1ou0WbPFXDjXnYJLYol8fZamvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYXub1jK33ER0dG7k3pxD3sMPBnKiGHvm/8z8EgzyRyDPuX+vYhX0ES5HnVIbzMTpS10dhtV7c1CZgagMq2sVtpgRFCXCniN+36cDWtO2NrUkQBQSKv9LfFij0iuna8G703n0QpRW6R8AG6t+YzZUqIEPoKNXDuXWbm74zakr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SPi02D6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9YEz1JE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SPi02D6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9YEz1JE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 162FD14000AE;
	Tue, 12 May 2026 02:15:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 12 May 2026 02:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778566542; x=1778652942; bh=7HfP+p8RUM
	zvAm/bvhKNXqxDZ5DZiQux8bujZhs3jRk=; b=SPi02D6Dch6ziLdNM1SH5LQu12
	FdJwcPraBgZuzP1nK+E73t8zrrEFiqoNoXFAOa7ZWlTcoiMZRiD5bh/qKu8xng3d
	2/F3ChhHgP/+HD5aFnZi1+1oCVxR9xPLGiRDWn8z9Vd3kdQW85U7KiUahXGPgatz
	kLHGUBrvd7n+S6325BfHyoXhSq8PAbcFo+ZwhE4V15QJ6ruzJyGWPgGp5CKlyzQh
	Ta+tkUEKUjfD7InaOzNvw0Bo4bXYZqTh+JC+Y9KNvifBcGhcnfePkDOY7GBKfZyi
	FkhgoTuEmWIIG6/Mr9Vg6aP7pJZEy7sNGBQA57IFKHyZNM8CFn0dl5aS+gYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778566542; x=1778652942; bh=7HfP+p8RUMzvAm/bvhKNXqxDZ5DZiQux8bu
	jZhs3jRk=; b=j9YEz1JEq+hR5414rHLqYo4LRvTUE4nns/+PN6k8DWNgvE4tmbt
	15q8bEwdeGhve0KEySbwQmn1CVXxsHNzqDFuQt/GvDN5NkG+Ol7g8racTCuV3hvA
	Z70gYILqLx8YHJZjHxEMzZt+CxgrnYmmBlsvKHSCNvC2Sl+re9GwHq9ikee0wstA
	DwE2ST7EYyXxZfZRhgDAaozW4VszyRe9RitDnDl1anbek3T+5JrpOJn1leRnK7vh
	UFj/9CKZKP7lqJ4sAKfjavZEckVz2+LmyRuOGx7C8ROhJ4rZ1Kxwbe7ywhwunhK7
	felpPj20G8JDaPIbCfgTQApAwjq2dhpXxjw==
X-ME-Sender: <xms:jcUCatB5RdNe5NlLCjTZuQPvyq2PkzFvwTSPeJ9Gb4h-zZCLzFjIhA>
    <xme:jcUCaih-9G4Mrg9qASD8fGAqp5JVHKS5f31cPijoeiLJ83mwoCFb4E-nRn_YIErfz
    qVetEYusgChZBy8Z95B1ZOtu_Q3vwsQuDVIOtg-pn6VG_UZGEl9ng>
X-ME-Received: <xmr:jcUCatm0O1Jhhgy6taEC-Sgdr6Wq56n8CfKu_6UK7D5GEpEpguXh6W6-3xNHWfyCGJhD70o6LWmKI003wk-pcXz4zNNJRCItWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiigrkhgrrhhihigrhhgrlhhiuddttdesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jcUCamoEE2d1Ktk50S__entRYQ0YkgOxnGKXxsqPl0nABKybtqRJQw>
    <xmx:jcUCauFSCaSXyfMCHyC5ID5U63DpzKJ01buZv-NjnS36lyTwqFkbMg>
    <xmx:jcUCaqy9cAwnlXo66bCsk0FoMHJHwGv7m8zAc5Gj7bZEG8W4zAK2zg>
    <xmx:jcUCarpd5CApCjqFbs6mhph3FtXC1EvqM7Ja4s-4JpLy7cISPKyv-w>
    <xmx:jsUCalEER5oYoeANSEYqaU1xKLLhpQG2ZOtGesxi-m_KtTH_Jhc21Hev>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:15:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v6] t2000: consolidate second scenario into a single
 test block
In-Reply-To: <20260429103607.406339-1-zakariyahali100@gmail.com> (Zakariyah
	Ali's message of "Wed, 29 Apr 2026 11:36:06 +0100")
References: <20260407034446.409175-1-zakariyahali100@gmail.com>
	<20260429103607.406339-1-zakariyahali100@gmail.com>
Date: Tue, 12 May 2026 15:15:40 +0900
Message-ID: <xmqqfr3xnofn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zakariyah Ali <zakariyahali100@gmail.com> writes:

> The second test scenario in t2000 consists of several fragmented
> test_expect_success blocks that handle data setup, tree writes,
> execution of git-checkout-index, and final state validation.
>
> Consolidate these nine separate blocks into a single self-contained
> test block. This follows the modern Git testing standard where setup,
> execution, and validation of a single logical scenario are kept
> together.
>
> As a result of this consolidation, the show_files() helper and its
> associated test_debug calls are no longer used and have been removed.
> This also removes a dependency on the non-portable 'find -ls' command.

The patch, at first glance, looked quite messy but it turns out that
it is mostly just a lot of removals of (1) early test closure
followed by the start of the next test or (2) test_debug calls in
between.  The only thing that was slightly outside that pattern was
the computation of tree3, whose result was not even used for
test_debug in the original.

Will mark the topic for 'next'.  Thanks.
