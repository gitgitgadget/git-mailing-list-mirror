Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A31F4289
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284541; cv=none; b=O5s2LriOwlFuFP3FF8zKksQnpu+Y7sZZPd50rMQhh+gWVcsS737UIGSq2ZNszk3CKwCSS+PBBD7o7NKujN3mZYOBtjTWH2ZxLxm6HIMqmCu+yBzNETxKEjRW4cF6xELeKL3zjNTx0s6zTz+BAgZkV3W8o3CIqH+/jkifLYZQLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284541; c=relaxed/simple;
	bh=Lf5lCa7YDg7T1AnVRWvc1eAA+I3BgzKq+R9Z6hotTpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CrLwkkrK/tQeQBSryCTj+VH1MykjKaE0fXWCdIyRKETeETLjjIYOmu4gkRDFZm8lNBsOec5Wr5FosHMu7g2pjTG7kRRA0XYOknCK/vYqalSAY/S4T4Gb21DUb4rgIgM5TVvar2IzjbJZ1u194LacLPkxbSXwv+8ohkj6QV+Cg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H8g7bUM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWrTyiLZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H8g7bUM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWrTyiLZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1973011400A7;
	Tue,  7 Jan 2025 16:15:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 16:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736284538; x=1736370938; bh=MWUmvsdGFL
	xZljcysilP7v1OoI1qvOfcKTqaSVmgpaE=; b=H8g7bUM/01S1aUJqS3ap1RCrMl
	pIu9o/Dyf3hxm2S5fOYJaMoo8/sENYovfzFPQmngfN5UyKU4TlVP03GqfHmMv09H
	qDPeIKb4BAiYbRTv4uGZIB30BZSwJP94om0/Co0zp/eDSk7JlkTNBL0uSvcnUIMI
	SsTHzyTOhXo0nqM2QZ7DWt3FMlJkdtmu7aHXLPCDXY06gDSJVyNieVKg9m2cg+4l
	+Glzxduhm2odPpbRzLpGbZ1BTuSL/Ue+2vKkYHyfYJGUxcRZkWvZovdxgcTaAKmK
	euYHoJ3K6vvGcKEZ4Q9ryRvTslTj0FZnGlhpNcSpPfR6P1FC3uOIC6ZIqa+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736284538; x=1736370938; bh=MWUmvsdGFLxZljcysilP7v1OoI1qvOfcKTq
	aSVmgpaE=; b=UWrTyiLZpRxfGrNyCapORNaJILyN43oGnZN5WlJJRVUQ5/fCWsX
	kIJlaTkmcsrLT4bylucEP7+fBOiltnNyhRa7hRqLwwpPYjb7PEwLsf6GkuWIt3gk
	YiuXdmKvjHx7WFYGjQElParzweTNw+ocIK9w3sx//0OwSKrHQlWFw7a2UmDs2wwb
	3GAuzetRkW3G0dkYl4gBGStCOD5XbaXTG2i1DTr7ZHm47J7+tT+mRHAKoEh5FY5f
	9h4b05MBf5TlkA1aZjTdVLLYc+DhDjwXBnA0715yMUnd3HHOGXBrSaswjX15JtbR
	jo4j3myHTokiC+Tzt5a93RihGnSutXD2IQw==
X-ME-Sender: <xms:eZl9Z_DgKZQMdMJYuH3dH_GPPjPHGcl6fb402qC7lXtG09WxNaskHQ>
    <xme:eZl9Z1iCIntcslIa6JQuIdFBXIy5j-dSnfn4X379MMD4tjasOrlVa9TYyerFm9Xqy
    kuCtsYX951WKxJXYg>
X-ME-Received: <xmr:eZl9Z6nnTN_BIKcTn_YQXRSevA9fq5MjZ-XvQlSmAfcJG3tMpq1HEG9IsNS967OVAHb0QK-GROQP0AIPd0lH_1OPhKkTTbp0KtQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eZl9Zxzlj45-3BQTaNbQKYhSffRpPs2X9Id_5-14Mw63ZIz7vVYfvw>
    <xmx:eZl9Z0R5L7VgX5frhyBfNf_Z3c2hUbyqu7IMCFi5Zn-xklV5PydwEw>
    <xmx:eZl9Z0ZWwA_TwjcWezNO4BAV7qplrqxwmN_OAZMwpMc43aAOGljDCw>
    <xmx:eZl9Z1QxjTFfRajEhd9mUkXZJyhimOvwv6vnJ2sbaLkFKYjDSfVqWA>
    <xmx:epl9Z5ILaWt3nQK_iEmIXxcvNimBtfsc6qY9h6TAhyIAZEFwSHGburXX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 16:15:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 00/14] Stop using `the_repository` in some trivial cases
In-Reply-To: <87r05ejpl3.fsf@iotcl.com> (Toon Claes's message of "Tue, 07 Jan
	2025 22:12:24 +0100")
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
	<CAOLa=ZTn2vfmS480G2wnaMehoK6+Z7EZ3Wx=ctaaPjBetOkbcA@mail.gmail.com>
	<87r05ejpl3.fsf@iotcl.com>
Date: Tue, 07 Jan 2025 13:15:36 -0800
Message-ID: <xmqqikqqqq9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I went through half of the patches a week ago, but got back to reading
>> through the series today.
>
> I've also been reading through the whole series today, and the changes
> are trivial and look good to me.
>
>> The approach here is to simply bubble up the usage of `the_repository`
>> to upper layers and use `the_repository` there. The alternative approach
>> would be to try and resolve the dependency on the upper layers and not
>> use `the_repository`. This approach seems much safer. The patches look
>> good to me.
>
> I took me a while to get into the mindset of taking this approach, but
> after chatting with Patrick I've changed my mind and agree with this
> approach. The goal of this series is to eliminate the use of
> `the_repository` in the mentioned subsystems. Simply bubbling up the use
> of that variable to the callers of those subsystems is very trivial and
> safe to do.

Yup.  That way, the conversion would be bug-to-bug compatible, which
is much better than a rewrite that improves some parts while by
mistake breaks the existing code.

Thanks, all.  Let's mark it for 'next'.
