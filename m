Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2657339A1
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054033; cv=none; b=HIM37WFArHZqjJt4GNvL11YbBLjhtTD3tBkIWGUC0wLOeRdC7L6ARr1GB17uCKEwfOaddYM95p0uhioPIXLxSGMDcwzqWQ/fATHvNxnTEaFKtwGkRO5AEGKq4f9p/ehuRnl0C96reyZX2h+Io4MMz9vntXO8Uw7/4WEAF/EvAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054033; c=relaxed/simple;
	bh=NkrH23V+b3JTKrr7lWw449fpsEp5RP47V67A0nvRPRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSJue0aOtY3kS6ZBtaOta95kWSFyqBdwN9PtsmE4Qmp9GBCX0q5EwXhofPPNXHrfQNk+ZfWjiNE1cGQzqcFDsPeVnzUOXybJ/xNtT/S5F3pb3azBxA0Xop6CkZ0HGTyJfuZpQqZl00zd/EKWlHTyCH/ngpsquze9wiAR+Y4PCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H77PdWoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIPBoRcL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H77PdWoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIPBoRcL"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AE8DF13804AF;
	Wed,  4 Jun 2025 12:20:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 04 Jun 2025 12:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749054030;
	 x=1749140430; bh=NkrH23V+b3JTKrr7lWw449fpsEp5RP47V67A0nvRPRI=; b=
	H77PdWoYe/OvSv2QnfDQZ861/g07EzLl5tLqa9jtHRlQE7o1rB1bxFh4YHkvLDBY
	uKBNC0l1PueXKHUdop8TZq8Rwor2k6ObrhnOPouSyiL3QTXVkYABjp9t6sFlyMIP
	SGeGuDAPjOPhZHQLnJ7T35exQPgDLrkhAVAakH/qkTleOb4YJohfOP4LYx2Zr/kr
	r+j7XkHgJN1kkPFWd4N+CW+4npQj6yGM+wzzdbE+FMay7ZUMYv52pPHbGJSi5tcn
	WiBSS6MC8ecL/O4EnuLwLs9Iy9c7wtJ9st/aeqKMmI9b4qsO11mQ3VLVRGP6Wb3R
	8GFri9NuW61cviXC2iRFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749054030; x=
	1749140430; bh=NkrH23V+b3JTKrr7lWw449fpsEp5RP47V67A0nvRPRI=; b=a
	IPBoRcL3hxZWKp4vgykKP8UzWfJwGGdR8WPfvWPhiqitZeOpaCLU3XBiclm7GkiA
	clANXKjfzWYSZi61fX10sKJthyF4KmutG0K3DNTKjeL4Zj/E25TMm4sT+WtL2zv2
	WFKQR9O6Li11y8pAzv3m5N+eXwURLF1PoWDc45SJ3PcKCdhENyNLvWXG8o06ZgK9
	l6nJL9n+ioPo+10alyXBf7/DoX07t0A/OwZmbUGSyTI9Pkux1jfja8bXnIrUKiMa
	PRqdgp5T6LIx2nJQEQZwFP90mcsHnZe9Esqj1d9x9HkAx/pKOarPJwC2g8vKLzmp
	4wyPQFbi8nB2dms1PyAMQ==
X-ME-Sender: <xms:TnJAaD8qXcvch8v_Fco0BS7LINKniL7iRLlcbiSGbHKeY-ltEYg6cQ>
    <xme:TnJAaPuyqSbMnoEksi7p9jPvAlIwGB6zvc9MWVXO_FJ0VDha8gBmobORMm-I-bpwx
    JY6mxG1pY7qqA59Rw>
X-ME-Received: <xmr:TnJAaBAP0422v6vQtQA-eRIRhRtWSyIezirp5Ub4hDwQtV87cp3D7Qg8AQ2wnoSByF_fhQHNLcPISkhBsvq9z8ODCor9k5Xw4eZ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsrdhtoh
    hrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhhithhhrghmmhgrrdgusehi
    sghmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TnJAaPc1CQoKbCjzyhgBczonnf76WyJvlDDsNPQ1L6Vz0NIh8sMP5Q>
    <xmx:TnJAaIOoX7pLnE2Xvs9diCqLhWFKJwaEfiOf1wCK5lDdFrEcWVl4vA>
    <xmx:TnJAaBkOy78qvdUMAPujRP4-UfOSBObpepuZAL-U8VDaWtvooLEYrw>
    <xmx:TnJAaCsIyTfQsIyB1Yqy_IiIsQGy0vcXA6D2-KD9LA2QyASitnvT1g>
    <xmx:TnJAaNwWy3IDkcP1wxQJwCvmA3bWfFlz535WGF8Ewl5pd-kpEHJHdOHQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 12:20:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Haritha D <Harithamma.D@ibm.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Clarification on GPG preference update prompts during Git test
 suite execution
In-Reply-To: <CAPx1Gvd9pUbfyq_AuQmqTqNY=mB+=agoreKR5DfphNNgc8md6A@mail.gmail.com>
	(Chris Torek's message of "Wed, 4 Jun 2025 04:13:58 -0700")
References: <3B3EF793-F2B0-4D77-98D7-900E5273D498@ibm.com>
	<CAPx1Gvd9pUbfyq_AuQmqTqNY=mB+=agoreKR5DfphNNgc8md6A@mail.gmail.com>
Date: Wed, 04 Jun 2025 09:20:28 -0700
Message-ID: <xmqqtt4vbhrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

> On Wed, Jun 4, 2025 at 2:39 AM Haritha D <Harithamma.D@ibm.com> wrote:
>> I noticed that the ci/run-build-and-tests.sh script in the Git repo does not seem to explicitly handle this scenario (e.g., no --batch, --yes, or other flags related to GPG). I’m curious—how does Git's CI/CD pipeline avoid or suppress these GPG interactive prompts during test execution?
>
> GPG does not go through Git. GPG uses the "grab hold of the user who's
> watching this and ask a question" interface provided by the operating
> system. CI systems disable this interface (or do their best to attempt
> to do so) since there is no user watching.
>
> Since Git is not involved here, Git has no control over this. You need
> to deal with this at the GPG level (or use the same tricks that CI
> systems use, but those are considerably more complex, and
> OS-dependent).

We do redirect our stdin to read from /dev/null but that is the
extent we attempt to go non-interactive while running the tests,
which, as you said, is insufficient to defeat applications opening
up /dev/tty or going GUI.


