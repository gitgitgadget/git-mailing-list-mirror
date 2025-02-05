Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C91FDE00
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780846; cv=none; b=tJIAkwQqi+gj0CfKMomEBwywaormi4Jg1XWjmDSNWEi2MiwGzXdrJRXBgIWmGvALCnIAezBY0TZwCxqhgfOAcnIZTahuH0mjcbae6+tI0gDxTLHw2sB7GKCqLgUIg72c4YFapKZ+Gul2PK2Vw0cMyqL3sbHwZKmXcSpQq+aLiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780846; c=relaxed/simple;
	bh=kuaPgMBGa2styEWe4YTi9Q0Z8oNyraSt6zmlLcJuNQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIzWGg47XFZtK9FloI7um8DWEVuvnHSFnXq9PgczOej70/KeNUUSQHrjryWe4+/SV+vvC+PF4LKBEQ8K4B8lplSgyUR1wR/aCC/iDd2CGb7sOfCbuZ5nl0gR7DN48K78gvs/t7BKZ5w1zu6i5JrNWsFy8hGpsp8OhnMRqaHpusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cC6ISDdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E40rCUsR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cC6ISDdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E40rCUsR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EACD13800CF;
	Wed,  5 Feb 2025 13:40:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 13:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738780843; x=1738867243; bh=pVYkY+kdHa
	UPc5teLSkV1o3FRUxoMxiDyg76/IbxX8o=; b=cC6ISDdSJjlu1ZOn3c0jxZ3xbU
	nmqDjsCCrNZk8SYEJX7kvkXaMdGNxANhygM1xXwLT10C7rvkycSHRmQtOQg3CAvz
	I/eE3bbix4AJCIfz/YUdQGQRjg4ddyz4/JpchJf48iM5vYrg2fZoHDoWmvOclLsY
	ycQ+2pVEZX99FG9VDpJB9koxWANXVGhmLnvRXdpiryZhFa7qNyzdG+tbACvNntN+
	pkYoWeMQfMg/UEaluIckLkl/HreVy0gjs6nWhzUjHlFHfqE8/zsP0PjPx7Hg8B2f
	OD5Xq7nLmAMGgI3u/W6R2Xl6T/iqj8lMt5AYh2C6R6UeK6gJcGBCvu9zvjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738780843; x=1738867243; bh=pVYkY+kdHaUPc5teLSkV1o3FRUxoMxiDyg7
	6/IbxX8o=; b=E40rCUsRqwllBy20307Syz04R8VAYgxrPSM/4PzP7J+o1w5dtuQ
	gdnYBwZ3ggpLmHFU+pfgwcWLiyEzPISSRsbbcusO+a6B1KXtXQ5e6BH5sxAfuBeN
	io7LvztZoi24uWGIPyPNsUX0JgZYqUCF1RS1JzkPb0ZQbfp/GbxiLYvmrbEdveM9
	DbAojOvJHs2iqZF2X0JTbA/SbREEQ6q4juT0s4xRUv15zDwtwZZtIxHaztMp3sXM
	iv+xRn0lGlwa6DndMRrTyHtbglNrgVvLi/WGu4KX6tesLAZTaZHkOcTh8Mm8iBEo
	oGbDB+kkf5MWzV5/Q67onNrKOEExrdSPpYA==
X-ME-Sender: <xms:q7CjZ8rL2QCkqETK_8IQE4NZfjIg-ibQ3-1pfTyOKv8foToG1uCV7Q>
    <xme:q7CjZypdAVz2vMr5aYIkuYyGE4oM4XJBwg13-yLSr7OLJgVq6zswtfq8KbrU08dJq
    FowWiCtfOMgSODD9Q>
X-ME-Received: <xmr:q7CjZxO_YKxVpXkowgXIf6VjkSO7JYUIkgRSVFaa7ljPGalrXFsR3y_xNvfpWToX69HsqIOedCMYUauhKkSwAPSj4cJxN7gwGlNm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgrnhhuvghlrdhpohhrrdgrtggrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q7CjZz7ZQzW_eW9UtneiXd4BC3WJ73e_3zA2g1HAGKrHhSstQ8KwNw>
    <xmx:q7CjZ773fOgcofoBLIeK6_nIvsZX7YbrVaMd20WyGrEBu88xqIKRAA>
    <xmx:q7CjZzjM2OtJRyppdWaLVB_JAhd4rhMTgpRkCXV5tOkU1FVFLKCH0w>
    <xmx:q7CjZ17VBnnMTy6_43Ofi65T1MtDNVD3Cn6huS6sTMqFtYoXDRHdVA>
    <xmx:q7CjZ-1x7mXpOEB3U8jHg5nP6Mt2EbErkf7TVxu1NhDQkeO9RNvGgsTt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 13:40:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Manuel =?utf-8?Q?Qui=C3=B1ones?= <manuel.por.aca@gmail.com>,
  git@vger.kernel.org
Subject: Re: Usability issue: "Your branch is up to date"
In-Reply-To: <Z6MLOA3mJGbPFBae@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Feb 2025 07:54:48 +0100")
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
	<xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g>
	<CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
	<xmqqseottxld.fsf@gitster.g> <Z6MLOA3mJGbPFBae@pks.im>
Date: Wed, 05 Feb 2025 10:40:41 -0800
Message-ID: <xmqqikponsk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One thing to consider is that some remotes tend to have many thousands
> or even hundreds of thousands of references. Updating timestamps for all
> of them could be quite inefficient depending on where exactly that data
> is store. If it was in the form of no-op reflog entries, the "files"
> backend would have to touch as many files as the remote has references.
> Consequently, even if only a single remote ref changed, we'd potentially
> have to update metadata on hundreds of thousands of files.
>
> So I'm not sure whether such a schema would scale well enough in the
> general case for large repos.

I actually view that as quite an orthogonal issue.

Recording the fact that you checked the state of thousands of refs
at the remote and found them unchanged is probably a very small part
of a larger problem that checking the state of thousands of refs is
already expensive.  People have solved it at the protocol level to
limit the ref advertisement to only the relevant refs (as opposed to
the original protocol where the server end unconditionally
advertises the state of all of its refs at the beginning of the
conversation), so when you are only pulling a single branch from
there, you do not even observe the state of other unrelated refs
(like other branches or pull/*/ hierarchy), hence you would not
create these no-op reflog entries.

If the user, on the other hand, is interested in keeping track of
all these thousands of refs, "git fetch" would have to ask and
receive advertisement for all these thousands of refs anyway, and
at that point, recording the no-op update would be a very small
part of the problem, I suspect.  Besides, we have reftable that
would make this kind of problem easier to solve, no? ;-)






