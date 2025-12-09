Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AD2FAC14
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321586; cv=none; b=E5WbBuP86DXl6K7usIc16vSvkEJt3KpJcE/qb3+PEufr35lg0qLHWlnJAWoW+noUfgJ+yLdfL32N4npfoRJD5S4ChwB4w/WLijmEHm3DCj1EdUQiGCDTOyl0L+pfOBTNF/47EXj8dNEV7EDuybjRPVuNEMNfebJWovScYg9+WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321586; c=relaxed/simple;
	bh=2JGUrqwDi+YHeW1nbhtlNHTdLFg76VaoSCxmwTCiGCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BT/jTg+fOjWcvom0O4PE6w7w11CpxipAIB0/gxt4eQIQZNwM4bbtb1uXWJC8gOiHYzQbmfuOkTiSkeQQ2We6Y0Eh7izIUhuJKaJ/vOzlD5uQK7uSnE5G5T2VRxJV4JP51if0deaG+VH7B6eV8LGqNl+HeWSyfj/Bop2fFvM2PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LzS04ghT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sctFvTAa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LzS04ghT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sctFvTAa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BFD67A016F;
	Tue,  9 Dec 2025 18:06:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Dec 2025 18:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765321581; x=1765407981; bh=PvEnS9eC2q
	MRB6CJsITttdCuhpMJEUkbtypT4wbABlk=; b=LzS04ghTnq6wmfC3b65NKWEGEP
	wXNICkgKxR2s8h4Oi8AEDA98g7l8TYHf+kGUvfDfoCuuXMVd4QND7Mxngm+4zlIP
	e3m4KqGKdbaMoAOzSZfo1iI5AFRGPh8nUz90+FSkoNANSbQfep5C7Ygs1XeSnidw
	faqV23GHMnFv/tb3H/gU0qn3PpMzdlwwlizBMPFSfTyTlHThGRqSZnrkpQii5XN0
	pZtX8u/MxWRaevzrD19MPL7Oc2qLfLQi8KQIIr9RpQUUOdG++FsHXNHhn3430yvn
	T3PvgEn14RnXTXfVRUDUL4DWQ7XQgzjIHAD844sENAkns3T8FnjuRjAYHw6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765321581; x=1765407981; bh=PvEnS9eC2qMRB6CJsITttdCuhpMJEUkbtyp
	T4wbABlk=; b=sctFvTAaZICccwUKfiAvx2YeuNTNas+k3NMwYTCGNNW+eY2nGnX
	a+TPHh31/EZVis5wjvVbv0LZ5Fy8O6vRohJ1S5MuNfhuAioEf2e+ZdkxHYjy0Bw3
	dRs0Xf51wwkns/QeJCGSv6tKOAF7PEpRkuKCB43ohKVKTvItxCM3fJiPnMhLRfQK
	J0V43nuX0zSUs6OeLyLljPM+Noa1yNAR/SC+C7jEfE3W9QZsUJGtmEWVpBQMfyYY
	/HoO8rH4OiuqROCIs/Zb1ofikhxwRbOrRbOyOwTzBlE3acWMMQuBS6thxZHN/OmN
	nqLztFgWd5n1eWyPDkgszbJdojmNBtROrsA==
X-ME-Sender: <xms:bKs4aZqn-Ob-MxuTD-BGUfIinREMnuWuZQB_igdKlkVdGbJy14g6JA>
    <xme:bKs4aTGwPX75AjbLz5QFioqwvJej4RzidPDT9CCEhU9s9l0243rq5mBycr_wobEW7
    2RU-rrvOou6rqZXTGtWtXBSmG9R6e8mOM6AXTSBo-1h4n1Jl_giBw>
X-ME-Received: <xmr:bKs4aTkTOkwdmxqzP4pA0fAPSRGztMVM_e57Z47kjv2s3BJ16Qb_JmYdokuHrJp6-q2kqkz-TE76HFYIH_ilqBKCG8s1fRNNZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bKs4aenoVbHNWPncskyCfnaX_VFHmyBHAzW9ay-Xz1uKzpIokt2ssg>
    <xmx:bKs4acv8AuAr3j3gh-LeWkOalTtkimiznF91GEkIIW3gvrbdw9OgTw>
    <xmx:bKs4aZmFGTBpINdD8bolkck6hmE-v0_ZNY0w2IZNufBlgLHFhZGXpw>
    <xmx:bKs4afthxK1sej826IidT4LwrmrP4Zt86ktP69UYQkBjh4Nw0_ngAQ>
    <xmx:bas4abEhhtOXv0fr86bbqywwtiXvwM2l86pOk5l8g6nEcS1JC8yCP8jG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 18:06:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: About --staged ang --cached
In-Reply-To: <FD2160CA-DD56-4BDE-92B4-0859C3BD2396@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 9 Dec 2025 16:03:11 -0300")
References: <FD2160CA-DD56-4BDE-92B4-0859C3BD2396@gmail.com>
Date: Wed, 10 Dec 2025 08:06:19 +0900
Message-ID: <xmqqpl8ni7bo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Do you think that it would be relevant to add --staged to the other
> commands just like [2] did to git-diff? Perhaps this is just a personal
> issue, but I find it curious that those commands still have a flag named
> after an obsolete name while newer commands are using --staged.

As long as "Only in the index" aspect of the name is kept, I do not
think the exact phrasing matters all that match.  The distinction
between "apply --cached" vs "apply --index" must be expressable even
if you swap "--cached" with something else.

Would it be simpler to remove the label "obsoleted" from the name,
and remove the "--staged" synonym?
