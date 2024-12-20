Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5F218AB7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710013; cv=none; b=bmOqjXv9px8/OLmV7cwoVe9b9RnfRwg/wySbMdKgzOx9IJ/CnPn77odcor8GCIPDOLFh3ZP5NLa08OiKMNW3ZrCIyQxTKQhVVR2kVxwJ9Uk3ITjxq95WlLc7sC70zOInU/JIqYWC3Ruo8OtnP/HnHVuse4U+OxnddY7O6cXfsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710013; c=relaxed/simple;
	bh=jhu6ZdFSgaz0y+UTKwwHXcUiravw/JFXo4sMOntPDbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3Ft5igpiwBFA7vnDpOiHEEJxpT8qSyjsxOGfYa6s7o4CbMg/cGhYrzkte72wqNYvgvGcTtjnLhBxFUzAM4Fhq4Q/w0DV2VA6o9m0D2hUeVLeGxaRcX/2IqD++8ueUN19SKvNQi3BIS4RevhiMiM5jKNtxfR17581R8T+3v7THo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QEW8D814; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+wpwVlu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QEW8D814";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+wpwVlu"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6705F254017C;
	Fri, 20 Dec 2024 10:53:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Dec 2024 10:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734710010; x=1734796410; bh=nAyhCYaUH+
	LFWXHu+bTEwFytkd5dsJON485YxyAHh8Y=; b=QEW8D814FBIT60xpywxU24klt4
	oXpPxC+/638AZ1qJS9r5wIn7yx0bNkDRxLp72t3vfKhbRsrzcbSmPQtaxRTCGoOM
	ZWwAv3te+dMQIPZK7WXAILt5Kycc+D2p5Qau1bBBJlZJ+72L+vTAPAeDCxsxSgoY
	x/Wo5jTZYZoBIl5FgJoG/12icoGwO+s8/K7ygRwA9ivUHXDD4n+sWNFJBtRMioNL
	sEYZ1Ov92UBpyCzhjde6bY74mv8ybGqIFY/JjJkUb5VhKAmlE8MIgoOjldaxs82l
	CR+JQpEkIt735sPv+yEECN12nH0GZGn0mVxwbc4dkUNKBcH9RnfbtaNVUCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734710010; x=1734796410; bh=nAyhCYaUH+LFWXHu+bTEwFytkd5dsJON485
	YxyAHh8Y=; b=t+wpwVluZti9sSalvkAytHGgFseN27garykccp6H2bsfgNAhtve
	nnYlDfQPiHjqsK059y4idtVKd8gueiUaZKy/g0mPGIoLArtP89vhXDZgLhhYXSgz
	wAiUem36MV8amG1teLD5q3+jIPYfEB8CJbZiP88u5k0zuHtm2s+KAA77nyezlWi7
	TyGpnL+w2uIR3VGgyt/gp92V6DfbrvsYbysMMRVUe6i1dS5Dc/o0qEMoZxjXvrtO
	nhfEHo7jCAG1luqiBrAZtwxaNsDolXMH6YJflzpBe917XNLfrOG8r01BX7KYelFx
	apUFjWHmDs3i1WzBiSc3LpCIlOu9Nl4hQHQ==
X-ME-Sender: <xms:-ZJlZ5QFjVoGX92NXDSFEhOq_j6BtOtkoaTtmDfOVjpODqF4qnG9dg>
    <xme:-ZJlZyx0dAXymFCiItIG_N8HgzERubuOcHm53r30euyAegvZRNaRellFu5GPMDIeE
    X7lV-7UWj1ygMDIHA>
X-ME-Received: <xmr:-ZJlZ-1W5Sqi-T-2LVdQbkB8pInEkjiHsCsyjcap2VbWENpdnE5JUzlJowO84ivLfNg5glMoLZ9gVla0sepHBCy-8IPh9-pC7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-ZJlZxBdHj2nlG_c_YoZYcuIwLG5VbtflkV6IGH57BL1K4j9nd1zYw>
    <xmx:-ZJlZyjEjTQ5MeFyhHwQrKpvHPqRQmIMkoVILm2Wdl5VIcZM_BWygA>
    <xmx:-ZJlZ1oRX8QxxDh1QYfzzoLVuzUOtKRp3VmLDru5MoZVjtZlIqqk4A>
    <xmx:-ZJlZ9jQpoMZ6fCnay5f6myIGv0Htn5K_9QnldhhLgLD7xWNRSaThg>
    <xmx:-pJlZ6eiYEDbPrf3bH8yv-KtyylFWlghp8LWeIuIbs_GXK-8YoaliG8J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:53:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com
Subject: Re: [PATCH] refs: mark invalid refname message for translation
In-Reply-To: <20241220125837.2774153-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 20 Dec 2024 13:58:37 +0100")
References: <xmqq4j2zifmy.fsf@gitster.g>
	<20241220125837.2774153-1-karthik.188@gmail.com>
Date: Fri, 20 Dec 2024 07:53:28 -0800
Message-ID: <xmqqzfkqe4g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The error message produced by `transaction_refname_valid()` changes based
> on whether the update is a ref update or a reflog update, with the use
> of a ternary operator. This breaks translation since the sub-msg is not
> marked for translation. Fix this by setting the entire message using a
> `if {} else {}` block and marking each message for translation.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Since the reflog migration topic has been merged to 'next', I am sending this 
> as an individual patch which applies on top of 'kn/reflog-migration'. 

Thanks, that is the most sensible way to fix up a glitch that was
discovered too late ;-)  Will queue.
