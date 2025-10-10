Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A72FBE1B
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113116; cv=none; b=IkZkeLKYnWhiv2/DxLCrvvyhhh174ZKGc014ZMuJYzMhkM+ma3tPg3rMOsEGjxcRWkgfajbvxfpIyPDNSSloYxpnjz/s5UhxCWCrda/5H8DPASNiBMkb7b/lfXBAAmT8oCQOY5n6+NdP+KPCj+p6eK48EpxzeKYEzOcKjfUBe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113116; c=relaxed/simple;
	bh=6TCStAaYoqRs7k6oE0gG0KFZmES7a/5iU4wTmPDx+Q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kpGouRGh9Kqck4J5KLEMzaROt/2qXWDB4ykRDBk1OPGRKJtrczojVckHNxfWWxyFHLOZ40BYJ72egvMq6lV872F8fpyBZ0bylEbeWk5x7rf6lU/q7WWntswNTMhDB7qcOVvzquXvr9b/he7Buvnj/zfE8txnmtlh7RvGqdWDzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g2uLsk9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PseXjhgp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2uLsk9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PseXjhgp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47BEE1400054;
	Fri, 10 Oct 2025 12:18:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Oct 2025 12:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760113114; x=1760199514; bh=q6bIp5oNmI
	4hIUubmkeg50OBXd+0f5OTHuhfzkZWQYg=; b=g2uLsk9V+KIKE6BF8U21R5iTC6
	CWxn2XQ/3IJZRUb8xpY/IEm9o8FAsbwOyYyXCiX/XlJbEn8lIv1k+WwS5mw2LyY/
	F/W7GTdtiPXZtOHOmC/CK4dBpwWGMmO2p0Rgg6q3/eD5IDKDJ+jUSWurWJCOfFHh
	YsakvOnKXS4xGX+AWi6YoDRuaTDMw1CLuy0kJpZRn1KIfyeMbxAslrGtyRVAdR2p
	BNlWQ3CA5igQdTgs2gm7TMx14LGJDKgVbsPhJFSeTd9qfF2bKX4mRj8ZEc5341Bx
	+3CgOuaQWEsZQ+0jyFl9tE7Xy2ceBWjQ95UFzcwJ8D7iAU3CeUQsjFAttcew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760113114; x=1760199514; bh=q6bIp5oNmI4hIUubmkeg50OBXd+0f5OTHuh
	fzkZWQYg=; b=PseXjhgpMh7KxMEEWs5Dz5DtQygh24754dniRKmeE3rM3aqsQBC
	lP3VwuZ1xt8w02Mqds+c8VQJFBny3Y+InMLpZfnJ4/AI5beCqxZG3Lk+LL1dDAIK
	yQTPqWsIeZ0/5ViGOkcF9Z9Njy9GPujailD9V9vY4s93n4xJTnUA4X3rVMBksiww
	UIK5/noN9jUo7gvXRwWivS7/yA2XDwtlf6+nuSSj/Wdyu10xHZ5Bh/cEnhwWRQsx
	AGIFNZA45QAKASLoSzXkATVutZsWRONATUttZP/xDidaV1hR2VZfLl5RfuGbWxbf
	2ABTtVXmN5eKYeCj6fIfYJyOls2OfzAXLLg==
X-ME-Sender: <xms:2jHpaIcCdc6Wwr_M0d1WVtPFw7kFGxxbnat75f2QmHKyjMHXQEh3Yw>
    <xme:2jHpaBFEuIlAQAAuZlNHy6Va5-SAZHG1OPJiVxMNRAW2r7_4jrpOGKWoxwjN7gs8R
    wrzFZy00hvmeVl3qb_loeAnN7imDPlFTzEbOSUAUOPynk5wgioDng>
X-ME-Received: <xmr:2jHpaB3UWlFgD0L488EIgmaPiLK3tI5mXDUuV9nuwW2KsvgCgxYOoEtd__6ZmxHCVMlmEU0M-oVR07T1oIZEJQdAQg3-ExYZZfiT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2jHpaJmIm3Swp_NG4-hzIl4N6PN4vwokoqxBcxe6Fics5pa9rN2f3g>
    <xmx:2jHpaB9cFDNbfSwiH7lxHxgSTk4dg7xYRbMBjrqJt1kbVNjYZqeMaw>
    <xmx:2jHpaOps_9yozahJwqWUpOakGbndoEINolm_m1VXyxBynkUDaCzN8Q>
    <xmx:2jHpaKnjjD4xVaKU9MYBPOVVrvkb-UB6MBIc91sKMdqXx6LydQ0faA>
    <xmx:2jHpaH_0eaUsNDgH8ibcxqQvhD49VuNrH8GO6moPiJvGOFL2XerVSC-N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:18:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Organize mingw includes
In-Reply-To: <c4a03e23-1c14-05b7-25ad-a3d6998df876@gmx.de> (Johannes
	Schindelin's message of "Fri, 10 Oct 2025 15:55:55 +0200 (CEST)")
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
	<aOjXjEJePkpCDoI3@pks.im>
	<c4a03e23-1c14-05b7-25ad-a3d6998df876@gmx.de>
Date: Fri, 10 Oct 2025 09:18:32 -0700
Message-ID: <xmqqfrbqafxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Sorting them also makes sense. It's another thing where I wish that we
>> had a tool to enforce this. clang-format supports this in theory, but
>> it's disabled right now. And I'm not even sure whether it can be told to
>> include e.g. "git-compat-util.h" first.
>
> In theory, I am totally with you: Sorting `#include`s is a job best left
> to tools. But then, I say the same about formatting,

I am afraid that it is apples-to-oranges comparison.  Nobody has to
read the #include directives; they may have to see if a header they
care about (because they are planning to add a call to a function
that hasn't been used in the particular C source file, perhaps) is
already included, and sorted list of includes is a good tool to help
them.  IOW, they do not read them, they scan in them.  But the code,
the result of formatting, must be readable by people.
