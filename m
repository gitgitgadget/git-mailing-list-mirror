Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526D305E32
	for <git@vger.kernel.org>; Sun, 17 May 2026 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060671; cv=none; b=qRvn79cifVsYuvAfEzPJguSjEK8iXYyR1PsgmMYG4dDZYf+/EY0Rtz4jgA5WRBXjc59EXWPpw9xMqzbTmHgpZPgDVjR2jEeuis/J4XZRwTz1BrmlRYurtYUJTgkwyvT27uFJng42DH8RLt/rvVquhoPaWPsIiXJvyCkIo8aF1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060671; c=relaxed/simple;
	bh=JKhpS5rjqszOGN54GH+AveoMZaP0Z1l5OY3cd0rOB7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stB1gks6IEu43mmc3X4UUBoU924ja/TYvHIIbvZVO0j+oK/OXZ8kb+9K3WOC6mPEx0y3lhl+UL1J8tTjtNGeZCH0LtNy4LX7WnAAn9J4PZ5WeErInj48QWd8Q8uBdLhHkFRcfLdtyX4J1slXZshe61Wp8aJRkxFGohUt8FLMZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yuw63Ckl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BdgsPDgW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yuw63Ckl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BdgsPDgW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63CE4140005D;
	Sun, 17 May 2026 19:31:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 17 May 2026 19:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779060668; x=1779147068; bh=6yDMp1pPJ6
	IAWm+EwbeBUk8Kk1mRoT+r7MjjZu68CmE=; b=Yuw63Cklb/l9Cy3aK9hv5hIVi4
	8i6g83FPSm+scuL0FGYNcyoYyWpp+28g5UuH3RrpzJqLMuLWpwNpsgU1pj7QtFOx
	bkt7zY6JTizYIVCPurQEHOWRfm6/0zLp0L8NDHvqYdfQfDzCIshokO2q5SotCRcU
	aDik6g6pDIEdd6F+aIkDsMsFFIq6I+MBS4ln59IdE+DY0ajOtxjQzwghUFWROJA9
	H1vDzUZxUPU3Vi+sHb3ln+s5ECd+wnc/l13dF2GV4psDoRZs6mVTnO7Qljqg8oJy
	cQXKY4brk1ZtiOGOo4tRkxdhon6SESRdS8hzjTM9smipMoCsWcxq2X5siqRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779060668; x=1779147068; bh=6yDMp1pPJ6IAWm+EwbeBUk8Kk1mRoT+r7Mj
	jZu68CmE=; b=BdgsPDgWS/4HKi7Unzy/fxckq+JyM6gzLbC1r5OukDmyZ9RIYru
	K8gs4Hc03T9W8NJsKW+TDrjpvIMdlS4lRLEHA1a3wcaVkgXaXtJ8ZAQsbiih3yiG
	eeMfuXewo1P4boUCy+5hediAa/QwiM2wzNegJPvH6qVGGTlEvRNc24M/NdCbgyF0
	GgvRJO4TncR1OVt7P9tQs6R+bVWvagYEpOGperf6omUZvi3AlVNBqjUCpW7gerT9
	tq7gK2j1QwPexXF8GSFbou5NdsB3TMkXLzuRlmVm4MeH54O5K3FFHueuMeit/N9S
	eJB76dSnQqV/b1cN+Brmch/NJrijxqfm8Vg==
X-ME-Sender: <xms:vE8Kas7VQtM7sIkmes_r_KU63ZLH2nOIgW57AWAHEvY0X6EMdf4Pjw>
    <xme:vE8Kahle5bTa1HdbHNNcC6nWpMa8OPFapqRWlcf6CnyxirN7rP559MYEq5JPqVxtj
    oabNr-oHxdTrkcm8TWcbvKyqESVPW7hcSRvFZPVg0zmfWXuT2UEaQ>
X-ME-Received: <xmr:vE8KalThAs6Y9mRlzX_qoaHeWXph2hQNR5YU1UB4nwzyFh-Gtlz9gYPsz9cIKVa4l-pDRHDiVqX4_dglLUDi5Qqnm4yhmFBKlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrkhgrsehsphhothhifhihrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vE8KaoHYCMOHCKPohpwx80t3526EPvtwYiC5tss1-t7xn4gL16kldw>
    <xmx:vE8KaiHkqdjLWIWFsXrYZL7hN4F7iBJy3zSYO4_BxAhI2JH5D-It9Q>
    <xmx:vE8KauTm517O2eRP4p8HoUdwHSanIfAt-VGejc4G32qpKvuM_P-rjg>
    <xmx:vE8KarKdZmJr9ols9aJBnZ6taJdBncIUdk4zTvlLJR8nusFrLytXxQ>
    <xmx:vE8KalvPsuVaW1QXQK8JnSIhx2OGQZb9DyENfN8l0YuhKKqjWO6iJaun>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 19:31:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,
  Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] revision: use priority queue in limit_list()
In-Reply-To: <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
	(Kristofer Karlsson's message of "Sun, 17 May 2026 17:26:06 +0200")
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
	<20260515041641.GA81292@coredump.intra.peff.net>
	<CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
	<aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
	<CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
Date: Mon, 18 May 2026 08:31:06 +0900
Message-ID: <xmqqecj9d35x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> I don't want to pollute this patch with that change - should I start a
> separate thread for it or just revisit this later?
> (Perhaps I have too many optimization patches in flux already)

Thanks for a great news.  I agree that it is a good idea to find a
good stopping point and make improvements step-wise, and the patch
posted for limit_list() is probably such a good stopping point.

If we do not see further comments on the current patch, let's merge
it to 'next', cook it for the standard 7 calendar days or so before
merging it down to 'master'.  Further optimizations can be made on
top of the updated 'master' branch as new and separate topics.
