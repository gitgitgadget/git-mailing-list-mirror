Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411318B0F
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116610; cv=none; b=f9s0wi2rjz0iXf6OZi60aXb4ceuRPwO2adlMsx7tbhmRLoPQx0QXcxjWa1kNK/luHdP7FJWu2uHmvih79wWSnVH1kJQ2lkgmeFjP8VQ31wrGqhs59D7Se8I+qLF0ehDZAgpKrahoLN4InmGngNSjUT9JOk1E7bL7UMpgs8v9izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116610; c=relaxed/simple;
	bh=ywDnrk+k0T1cAaCZ6RwBldapnDswK7bpFUh+6qXpnVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHTyU7ENqam3afTGzpMDofxx12/XzBRqeWyVrDqsbSLWUci0DzokihqfPT1Ms0K9d7kG2iN4DBa7SedEw3rt+UeU2iLAkLi0YhLCp3NpwFF9IB/pBAXnQM0Im/Hv5EHap06aWElDn8Rdmi0POir3sgS647zjlhLaR/ZQrvvqMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b73J6u2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FR2/rkd/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b73J6u2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FR2/rkd/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2A871D000D0;
	Mon, 21 Jul 2025 12:50:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 12:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753116607; x=1753203007; bh=P7YHaRbVrM
	qLYNgseySwA7pUr5hEQbQbyOnjuR+NjQg=; b=b73J6u2YCGzoocK7TshK1bNlH4
	QstRdHU1PIOtTekrLp5g2aL9H6Ua0eIWdtjeOkfUczRn7a7w5rl8Ie9jHEZZX/0t
	zRWV81rQGbU7epOwTvvjrO6f/eUiQEd2OZD6g6B052c14xxo+xm4lS2w7XcGk0lL
	npbRYJZzCe1wkS6c5Q1Ux3QK4VUE/x7Z2SsOdvdxNKJQDYvS+YbEa9Puye6Y3Ke6
	dHN6dSQAabTKM1sSfwkcNebKBfAckibMNMvhYjq2xDZ0e1vAQ4evRhTy0KcrW/FJ
	SsMY7tkdwBN1dIPgd3rLi1LYV6Rj0fjLHHqSVTUkpp3ulDRoGfzKxgWtU+iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753116607; x=1753203007; bh=P7YHaRbVrMqLYNgseySwA7pUr5hEQbQbyOn
	juR+NjQg=; b=FR2/rkd/YhKTM65nlVmK/+G0fHkIciqgJ9Dt/VOPm3oUWHxOU94
	MfAe0CqMvvuAtEYMveoY/ifCrp30HNYJiUgor4FJ9roWuowvv2A2BJvx39jucAW3
	NTzzlgE8NGt8T8z+ne0Y5Bamd//IIEU6GfXVmbHjBf0eLydY+NSnhWk4ImotUP9O
	TbbI+eM+f2JGo1Sc7Yluek4VH1PmlIwizPB2jE/9RcKCXY/FtIOO3DLKCVI5Of1E
	itg0+M8PmiWBp36Rj2Xp/Bm0P9dOeYaHZ2WhiUaa6t+RsvWB2lPVGJKxA+oNEtxb
	aiBtQNyvjZq9NAN9syvMnILAlCibhVMpTnA==
X-ME-Sender: <xms:v29-aKXB1dUm-4ikNHcLK_BsVfNi7I9dXsbZVtalx3cvc_QoUCexPw>
    <xme:v29-aDhvpkXzIHf8wauFbkKMwZq9ZiCcNX2C6oJN-VJUV6Lr8aBMBL4AzZoLqLeql
    aBGvIyOdZ9f0TVXhQ>
X-ME-Received: <xmr:v29-aKDIUrxM1Kwp5biv1LCiUkbI3eM79bxVpaMkeuHUlPie4ykJW0YYMqCIDQixrRvE_c4LH2p_6nMmklN38BuIFPVIq6ZLrDtGt0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgv
    ohhnmhhitghhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v29-aJu6PWtzy0Tu9zz7oBcO4znGCRQhYhBlsbLfCmO7rBNAh6F40A>
    <xmx:v29-aOezi3CISxUtXqoQXG6judqILPb2EKNGo4nfUOquOwQFEk3RSA>
    <xmx:v29-aO9z1Bz44ftPxEfZ69-2YKODv_vjbjALVd9_JAouIK5Ss03Kmg>
    <xmx:v29-aBT3pXvH6XSrlrJjQio5HgY7pi8MnF8HMYMqbP7hau0Cxufecg>
    <xmx:v29-aD0yBScZWLd2vTJsSoW4HY6tyJ_HZigI_wkt-h-ke7FXY_-uHVaN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 12:50:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v4 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com> (Leon
	Michalak via GitGitGadget's message of "Sat, 19 Jul 2025 12:28:29
	+0000")
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
Date: Mon, 21 Jul 2025 09:50:06 -0700
Message-ID: <xmqqfrepzdxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v3:
>
>  * Update commit descriptions
>  * Read struct properties directly instead of assigning to variables first
>  * Simplify config setting / error checking
>  * Remove redundant tests in later commit as they were replaced with better
>    test(s)
>  * Change tests to use single quotes (this messes with the grep so was
>    unable to explicitly test single quotes in the error messages, so decided
>    to use regex . instead, which is what some other tests that have this
>    problem seem to use as well)

All of the above looked reasonably well done.  Will replace.

Unless there are objections, let me mark the topic for 'next' soonish.

Thanks.
