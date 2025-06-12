Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42529ACC3
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743307; cv=none; b=Q5ekAz6ilPWl1qKXhpnHlswNqLIuQOHcy7H1gq685Yt6XigAM7DgAfVupmqN9WUrl/k/NxZu+3VJ8OER1hT6abTRgPymeUqyLmNjtROW0FwTxI2qdVx3OwVE+6dU+YvLYvNOXYlTIDWh/CVSoRxunbg+OaCakalUtUs4u6uZOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743307; c=relaxed/simple;
	bh=21FiZm7cEJ+6YNlcVn813xp8PRqtXdXropH1tfSk4c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hieiK6Hl1H65Nc0urkk9Hhvxts2mckVfYmYa3JXCXDfhr0EEttypnabM6ZJzyju08+1MWFe7SaseL/LYA/w2qv0AnUtDeeEzPjTLAxxRWVyfWDuljHIextA9YWxeDc+Iglyp96fdr/P/soXj+lUue2Y+sBbEjipM/ZMIYCHeHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fezOgt0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fEoqh794; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fezOgt0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEoqh794"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88F901140227;
	Thu, 12 Jun 2025 11:48:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 12 Jun 2025 11:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749743304; x=1749829704; bh=abBStaf9CJ
	jlbekhkxHnl0/wbG9Do4PjGhg//yWkPdQ=; b=fezOgt0abdZfOYfvnjnZUfe8kx
	fvyAzMcdB1Y5CcSHfJ9M969hYteIAZnDLaDs9yeczryL9RTixOuSEvzs5wd2+KZk
	13sci7o+qn0tzhjnXK3yEklRc8s5C7YanZbs0wmd3pfZjVZFABdc8QUFxwzl9eXh
	S3BAk4dN2znqfyFRYg1f+uH46PAyhT0TAirUdnVtfDvGZOlnsyJN8q/+0zXDg9Ar
	/nWvI/LiDaxSAcpNI7J4IXuW/HN0R7AYg2CtfD1aNtx6PnhabBgibOd2MTD1yyWQ
	OCAz+s7QAHZtEm/Do4vBzM5iMvTNOwjmm2sVkSMM1yYSpH9WyHCWXwn33SXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749743304; x=1749829704; bh=abBStaf9CJjlbekhkxHnl0/wbG9Do4PjGhg
	//yWkPdQ=; b=fEoqh794gGrcsHzp7LVrYGN9EZcjobQz7EH2fTBuoqTuH9ETKT+
	E2Yve9lILCxz1dOklVkQV3Bz5Ejlxkha/ZplK4gwgnTOopFu6PGyH9wuDtf3GEZw
	fqCrblJrSF4TjGl3E8byY92smXc/eCo1sWarBnZxUYaC/4zyn5DqlHOuyoG6XTxu
	sdR0lHcuIsrJogGGzjvLU74lFtiREfB1IobsjTNinHlwUWL7utIbNRR1euPO0VHa
	8DaJr74Cy2LBNWhggKzuzfa+mVjsB3ESVaq8bezAsbKe1vHiPljEaV6U7xrbZoQ6
	M2MLDY73kDpxRsPaeoK1u+YA7ZctGlrpnow==
X-ME-Sender: <xms:yPZKaC9YtplQeEBOUWNjqLNJi55y7supEKJAq8WgsgSPj-MvKRhStg>
    <xme:yPZKaCviJ5ttQthoOEqFza-n693PsSnYW4idJmFYjkQ83Gwj24y5htkDq6t9pSDKG
    i8w0seUAXMkXS-L6A>
X-ME-Received: <xmr:yPZKaIBGMqZGlOCEjt_QEKfmu-rzwNKd-rmsHFb9p0HhvB3YLVXDuPPEfQEeHlYZmuOLoPS8MioeWby94kr-9RT3SbjDvoe8z5e3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvrghsth
    grtggthhhiohhtthhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yPZKaKdwojFPzY6zADvsDjZl8Dpv8Nr5_ao_8CH76uwz1bVOlAGOmw>
    <xmx:yPZKaHPFl_vJEHSzvoDqTAgI8VlgD-R4NpwF21Ao3bqyy1Q8uqEVKg>
    <xmx:yPZKaEkA77ulGeGGB5t0BvYPX0ain99SEflMXGt7OyvBHdU-P4eETw>
    <xmx:yPZKaJtG7sKHHp25s2Qf52aogv9caraLVN7SzPkkIbuTTljudKPtXw>
    <xmx:yPZKaD7HtsMK0q8PphKkFD1WR_2-3eaaVo5rJjUQTV3vdYEZ96f5Z5US>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 11:48:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] branch: move multiple branches in a single --force
In-Reply-To: <xmqqjz5hffn0.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	12 Jun 2025 02:55:31 -0700")
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
	<xmqq7c1jmgpq.fsf@gitster.g>
	<CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
	<xmqq4iwnktyv.fsf@gitster.g>
	<CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
	<xmqqecvqjo46.fsf@gitster.g>
	<CAEgWtF9MRbRASg1Jb3n6Ggvh8viZOpyev+OyX5DSpWQ7bMF8dg@mail.gmail.com>
	<xmqqjz5hffn0.fsf@gitster.g>
Date: Thu, 12 Jun 2025 08:48:22 -0700
Message-ID: <xmqqa56dezax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I may change my mind.  But I do not think the feature should not be
> tied to "--force" option at all.

Sorry for a double-negation failure.  What I think is that the
feature should be orthogonal to "--force".
