Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B7222593
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002874; cv=none; b=Bkub0ebl8O1UwprlKyluF59pEOJlyZND+xnldUVJ0tFdEZ6vynVHMOuCfkTJ4BU3BgiJk+94rCySTTCuL/4MTN7Bm/yRfpSIjyfM706XO7c5uG78lgKda9IZip25r5ew5IXhOv9OJJrrFFdEjHtDWUsL4wR/OaMXJDg92i/VMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002874; c=relaxed/simple;
	bh=hgvFR/Q75Nodw5eIIrAGzDk9uG6YHe+XjvMZK++2/oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBDwGNrYiPS8bntxSoP9NJZA7Jc8nYuueVri0aZCQMQ/R5X3xdrOsYsk8jWwbpf8LuF5Sq1vSrHy+n9bUEPrAZviXUfF9KlA6s9wGY+SwyCJojHqFrmvmARHfeVyKN2lirjfU00ij3GVNFhg2G8iIg6x1RQ9eK1KX4aF7wcj7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vBJ47ULU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVlqtOD0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vBJ47ULU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVlqtOD0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 617E5EC0013;
	Thu,  4 Sep 2025 12:21:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757002871;
	 x=1757089271; bh=KVeBEeZmh4bAulRRYdrcdctvE4A6xlfoTvNVdau+mwA=; b=
	vBJ47ULU6kl/Mf1DWT3/o2oHHie4qovH6UfkownLZdFtZRG6JhyVfdSnIOe1gaya
	PuQEDx6EyapcAWc7ZFt0oeLHJmWEXxCH2jhCKKgc7OlCS+/BP+ugtIrjFG7gipYi
	OAEjhLpg+7UBC1pOUqDWs5iDTBco024JLlUXlzOg/k7Gb8564Suek8RwUxOGDWW8
	TQBN3naoMjJEcyf/kZN92zFoD+LW9ARgZT6srD2OFImdUiJiT6ZIkOhPSq5XLRRq
	H4o3ES8NbolFyoyfa9S+sgzTer0axKOp+Goo3XhxnCjr5Wg8MpK8IRx3cs9QUxuJ
	LreXUpTJAXlxXVEgFU0GWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757002871; x=
	1757089271; bh=KVeBEeZmh4bAulRRYdrcdctvE4A6xlfoTvNVdau+mwA=; b=i
	VlqtOD0UnM5FoFxkn7wJH5vZ8QSmAgSrSe07VFMiWeZ3D55GYAJH92L0/Tsno68q
	OupCTvTBeuAUQ2rz39tax3GKQ/zM5ABT5PH8phBof2wlpOD1/QZmdPjlKqXQGpc0
	K8nKxM+1+Fo92UpTnu4H62fCdU55YEKef8yWB0trvECLjYErehNN11auVHRzMbp0
	EHQnEz+4RpsgDTaedlQZ6qdm0bLsZOs913FgLwfokEKxt1CY4KfZV70xKZ6h0Q/m
	ht0pT51W5PVAis8Ev3LFw2G0WDcp2TGp7S1NPj8q+Xwee5FRx71FYJbUp41yoBB0
	2vBrtN6Lhrhb5FJ3gNPbA==
X-ME-Sender: <xms:d7y5aD2DZ2ZPymFuoDvbDpAd4OFepHGeNjvGqNrzAjae0JGfX6FIMg>
    <xme:d7y5aFW3tbB53ehsTuHCG-iuhIkG5K8OuQM3tRNNoI_66w6ytNAvrvEp0wZNbfp1M
    bJQNakG_U5cIdrI1A>
X-ME-Received: <xmr:d7y5aNXwOyF044cXK5c3_dMyHQdoDNJS0rnoy6CkeVkmAt2u8yEpF0V0_l6HwLV0-kESi30Xm0nEvO0kh9n9_Rv9Jze3y72AfGARK7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d7y5aEdkoiUr1iEp3vVa_dppbVNzF1RCClvX8d0llHE7B4OP0g-rcw>
    <xmx:d7y5aGX9QfqiYLiNLxsJigHaFH6KZLOjZR4ETReu7153hB95WhBrFA>
    <xmx:d7y5aNersHT8AqpsPEyYtLzjWdz4TtFDf33bKMEUt6YbAbhC1tp8rQ>
    <xmx:d7y5aCMV_6h--8mztqTqzirT27sdjvKIobXa73ZQ2ZDHHtkmadq7jw>
    <xmx:d7y5aM7QeQhficNDuxoiJ4BAXUpY4LzvgvM9kNBw6HN6WocOIGzLFbDi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:21:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
In-Reply-To: <01554a3d-886a-4f0d-b174-1dffab0b924f@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 04 Sep 2025 08:55:08 +0200")
References: <xmqqplc6byai.fsf@gitster.g>
	<01554a3d-886a-4f0d-b174-1dffab0b924f@app.fastmail.com>
Date: Thu, 04 Sep 2025 09:21:09 -0700
Message-ID: <xmqq7byeb34a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> • Incorporate Peff’s patch[2] if I’m up to the task
> • Then mention on the whatchanged *hint* that they can make an alias to
>   shadow it

Hmph, I am not sure if training users that they can always alias
anything away in order to keep deprecated names forever is a good
idea overall.  That way, we will ensure that newer users when
watching over shoulders of more old timers will have more chance to
get confused by unusual synonyms old timers would use without any
advantage over the more modern ways they have learned at school,
other than the "mustle memory" of old timers.

But if nobody is disturbed by that idea, then the above two would be
a reasonable way forward.
