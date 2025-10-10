Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF020A5EA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090005; cv=none; b=IdKOIZewkYqIoJsCllH4+svMw0JGMue8nahugMkmtiVkPp3bHK4KEda6BuKg6KaTKkPATiH3xOBuHrt/BqP67ejGkwMydAINvqs9shdhC8Sb6UKRwDzFzQf5l2z35vvEoWyRwAYgdvy9zI+tL0odDWUd/wsXOn3iY2AvD4kjSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090005; c=relaxed/simple;
	bh=7N8YyxjoIqc2FwA1ot2DADOjlGBWlhXmRuNIKRuIKF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azBOJJPMBfmHsXr/9R/k1QiC17nx3jJcWerDvg1+jCyStA2uJ5s2zQQlCaP94iZrAMnvv+28THhUh7leDEiV5CRN2G25YieWBO+0gfSfT3En1ZPE5gRoQ3ccrE4L8ohi43+N1ysvbRzUDdu8aVd8rf0UzWLVveOdZSvjiad0h3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FIg9QYia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pmjjwlJE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FIg9QYia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pmjjwlJE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEBC5140007F;
	Fri, 10 Oct 2025 05:53:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 05:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760090002; x=1760176402; bh=7N8YyxjoIq
	c2FwA1ot2DADOjlGBWlhXmRuNIKRuIKF4=; b=FIg9QYiatAZ2+EoOjcOvgq93VW
	sV+gOCdjHlmkhLP8/AICxv2261EVIdYmwi2IoQUfjkDbDKq4s4Tx352/U/3qG5Uk
	oq/QB/rH+PU3v6bxYdnxbZgAQxKteWsI8nAwBajXkMw/HVYG0ocbAyLvUi3rXgdQ
	Gmje58z1xWxblc2BaPHKrdgtsA+SK8fwstf3VfKSB1idtWvLRqXr97LsEKr3gljw
	RvsNX0Fu8mlLt/Uq3hCqQJOB9kXaCii/5i20lbJ7cVmegm95iEKFZwJZszB8wyQb
	ypYjdZSfHFy+XrLkjTtEdmLW9zOcLSBmrnn9WiSFjyShjAv58BPm1HB3P30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760090002; x=1760176402; bh=7N8YyxjoIqc2FwA1ot2DADOjlGBWlhXmRuN
	IKRuIKF4=; b=pmjjwlJElH/IxDCD06bcfQ82IqdK89dDJoYn6ZlgSBlZ9H1pWa3
	Tfpqf531pJtzZZytMrULarg0Hoq4hmkB6tLL6j/PtApqAwX92+wZqPSKJD/RI6M6
	pe4aOrJybPNlKfx/qzBgIccKecy2DMobGsPilD4t5ANd0nyfN8++z8onYV1idPE4
	auDXyx/ai1fRXIE36LWrisjBKn4zw0T4NSttkGlcQXIJs0ijNCVKHp2Mg9WWE1AG
	JkWrVmiLTYGZ4FLwBSjUaAi69iJWBvaZWlec45oHfWAUStnk3x4QR1KLeWqaCa6d
	WTaZgdEmxxTRhVOCmKPjkPk+aA456JlJT+g==
X-ME-Sender: <xms:ktfoaN62MGudxR_6Flr5IS-J3QdJZEtLMCKr1_lJg0hodByD32SOZA>
    <xme:ktfoaCVIgzKgwucMrs5yWqIYIl3G3r-nKinc7vWsychOIPCbHicXG4z7EVD1uTGT2
    EUj4L7L8OFDgcJuh6jtA9yZGQjbngAiNXTmcUprtI1-DeUoAkOUtQ>
X-ME-Received: <xmr:ktfoaB3-UEEAYambxhUsDnzI4X0JDq5Y87x-ObvAyQHpI7JksoBTuled50RJbfvyyQHLwjND0ixu6D-tigQBY7gcCNDycChFZ_eGBk4Fkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ktfoaP3DUOVwT780cUiqm9TEsg0XtPNUQt9oqJOYmKrkvTKqiJ9X5g>
    <xmx:ktfoaE88FrFlonDB7145fnAiKC9RA0dlK-Zik2YwZYSMkCNUDx_zWg>
    <xmx:ktfoaM0oDIZtsNoPR7MA_lUxLisaUw9L7CBj8L0g95ZtmEQWnEHjoA>
    <xmx:ktfoaB-XpNBRpS7pcPMVkbPrmDqM6DvKHhH3kelNhic2SNtVMK5J-Q>
    <xmx:ktfoaB-CIaI7hoBjxWIiIpv8lZnoTkqhRc64gJqpAQdVQF5ymMJR-Ehs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 05:53:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d46f5b3a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 09:53:20 +0000 (UTC)
Date: Fri, 10 Oct 2025 11:53:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Organize mingw includes
Message-ID: <aOjXjEJePkpCDoI3@pks.im>
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1985.git.1759995961.gitgitgadget@gmail.com>

On Thu, Oct 09, 2025 at 07:45:59AM +0000, Johannes Schindelin via GitGitGadget wrote:
> Following in the footsteps of the many, many recent #include refactorings,
> this patch series orders the #include statements in compat/mingw.c.

Both of these patches look good to me and I like the improved
consistency that they bring. I may also do the same for our code in
"refs/", where some of the files use relative includes, as well. Might
be worth to document this somewhere if it isn't already, but that
doesn't have to be part of your patch series here.

Sorting them also makes sense. It's another thing where I wish that we
had a tool to enforce this. clang-format supports this in theory, but
it's disabled right now. And I'm not even sure whether it can be told to
include e.g. "git-compat-util.h" first.

Thanks!

Patrick
