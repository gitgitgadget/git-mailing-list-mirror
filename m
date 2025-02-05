Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7A21507A
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792113; cv=none; b=KOgnmwYoC0DeJBMaFtaZr9o8geZfMe+IP/GpqcPLtSAlDdBe50J1on7CrvPQUxobH6fzUGHxCPpG7FG9qORmMK+LGP/fjo5nBLoWqf4J7Nbw7VJ9VfBJBQ9xsp2yYkmHBIIJrBWGn2Go7vpfJd9pUa0x4trXEBg3HcBv57L7wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792113; c=relaxed/simple;
	bh=desWZUeSvxCuFN4/OY0lUWxjc+gxxQPjNsZDobnBi/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0ZRl3Z3fj7YtmeWgwl90rbbhXl31bSvIZI5s6f1K5zyalr/fFy4uKyjBpQdZ7cTGvrs4OnrxUtIfIFhQiG05FXme/y3Rr7/mEjrMQ43OyNggfgbxplOLdvdWYVfSkE/Sy0lPgT0VfZ6EOqBPpqumjHLx2xrNSU7tJ6X938p7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SRYYGiPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVZH1GRk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SRYYGiPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVZH1GRk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36C3111400E9;
	Wed,  5 Feb 2025 16:48:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 05 Feb 2025 16:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738792110; x=1738878510; bh=nyIaHVMCxO
	LjDo8xr2TkkZAKrNEs+kEcD3KwTC7/ZeQ=; b=SRYYGiPc7BKMigKGYc1PZvetXp
	s9GjV/iGnLZVIsvii07I5WaigTSyleygAV1l631SnI8iPIRx4B9MgF+SzhfJXib7
	MZIq21DF6awe/QjIBSDX6KCYpz5et22YflX20Ym49DiRPQUyXoU/1BJVq1BqE5rx
	qyyzgyy4x8Msb3mASkdLPuZK4lPM7muBDjmbGtM5pWEA9bCXFc4WuImt3nbWKE+H
	k56nS15ljbomB+fcQjRphUypOaNwSHOGRn9EXUmQX7jJo+MqSwBLuDBAv596jdT1
	Rb5Ou+sycFAaZllS0Pi/bPSuC11S4HqPGvIo5fZZrfTYP1wY0psj0qW0luLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738792110; x=1738878510; bh=nyIaHVMCxOLjDo8xr2TkkZAKrNEs+kEcD3K
	wTC7/ZeQ=; b=RVZH1GRk9/88QWu9uP6yFhvOuNwswSURl5ApbYdu9/shs1Su5PF
	MkmWYNBBNwHE8RLtptpFkWXiGf0m3v5gIUIbxJCeXR+sKl5jFOxwBYrLpyK3Z2Yu
	rvGtlY732TyJjwJWrPabnJ00tRvv4/9IFn3s5KMdC6f8td5KZaOAoi1pvJ+G2IOX
	uqd/yLfGaLkHEjFz43c/MCVvKgTYcCMH/dTQeRysnAr0cjuXerTlijH8vNTZAyZ6
	qx9ix8nRqOlL8LctcrPxLgeXzOI7HnNhbS00l55YpJcfhbRVqrPg6mazft4hg84+
	j2T/PGLga9+se6iIE6dj/I8ANK1qNdaHdLA==
X-ME-Sender: <xms:rdyjZwGzZpAVJSaWbtFfdt9eP_Ly82E6Ab2hG6ry30dSUyOCXCJWeg>
    <xme:rdyjZ5U5b-vMRU-Aw17RxeWAV9cy7zm4_y6e_zWtcpBFwcK12gew9QBe3Fbl7RdI_
    bDbIC4AEDkJ15__5w>
X-ME-Received: <xmr:rdyjZ6K6025iR7Y1SdmRnefUH384bAreIblgCwj_BxA1dQOSCpW8zsYAYINtnO9jVeFrUJkxoVZ6bfV9b2ee5_0pLA4k-YJoQnbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:rdyjZyFvDzh0Sz1uPCcLB14fGezwmBjqoQxdocbRf9AZAMDn-LYSog>
    <xmx:rdyjZ2W7GQlZf01m_uIG6pY26RLDiNqUchaDjSQtlslQkLaT4ZYQkA>
    <xmx:rdyjZ1MkVNb87vOewZxxWBQsFSXifvtmTrS-W72Fh9q9fSOQrRw9cg>
    <xmx:rdyjZ92al8OOfGq6jQ4PRmSx--hva9oDTj4PR2zvJSL-kEG8OPQrYA>
    <xmx:rtyjZ3sMhIuKc2g4R2gsGkSDiRHqorscoVdbsYEhKmW0QZaLuHZSZc6L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 16:48:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  <christian.couder@gmail.com>,
  Johannes.Schindelin@gmx.de,  johncai86@gmail.com,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,
  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/6] agent: advertise OS name via agent capability
In-Reply-To: <20250205185246.111447-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 6 Feb 2025 00:22:36 +0530")
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
	<20250205185246.111447-1-usmanakinyemi202@gmail.com>
	<20250205185246.111447-7-usmanakinyemi202@gmail.com>
Date: Wed, 05 Feb 2025 13:48:27 -0800
Message-ID: <xmqqy0ykkqqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> As some issues that can happen with a Git client can be operating system
> specific, it can be useful for a server to know which OS a client is
> using. In the same way it can be useful for a client to know which OS
> a server is using.
>
> Our current agent capability is in the form of "package/version" (e.g.,
> "git/1.8.3.1"). Let's extend it to include the operating system name (os)
> i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
>
> Including OS details in the agent capability simplifies implementation,
> maintains backward compatibility, avoids introducing a new capability,
> encourages adoption across Git-compatible software, and enhances
> debugging by providing complete environment information without affecting
> functionality.

I obviously agree with the benefits enumerated in the above
paragraph.  The simpler, the better.

I however wonder ...

> Add the `transfer.advertiseOSInfo` config option to address privacy
> concerns. It defaults to `true` and can be changed to `false`.

... if this configuration knob is at the right granularity.

For privacy concious folks, I would imagine that the distinction
between "git/1.8.3.1" vs "git/2.48.1" would be something they do not
want to reveal equally as, if not more than, which Operating System
they are on.  Such a privacy concious user may already be using
GIT_USER_AGENT environment variable to squelch it already, anyway.

If we were to give them an improvement in the area for privacy
features, I would think it would be to add a configuration variable
to turn the agent off, instead of having to leave GIT_USER_AGENT
environment variable set in the environment of their processes.

On the other hand, for the rest of us who think "git/1.8.3.1 Linux"
is not too much of a secret, we do not need a knob to configure it
between "git/1.8.3.1" and "git/1.8.3.1 Linux".

So, while I view some parts of the series would have been a good
exercise to use various features (like config subsystem) from our
API, I prefer if we kept the end-user interface not overly
customizable (iow, without a config-knob, we do not need to add a
code to inspect the new configuration variable).

After all, GIT_USER_AGENT let's you hide not just the OS part but
any other things from the user-agent string already.

I notice that unlike user_agent() vs user_agent_sanitized(), you
only have a single function for os_info(), which I think is a good
design.  But if we were to go that route, shouldn't we call the
function os_info(), not os_info_sanitized()?  The idea behind a
single function is that you cannot obtain unsanitized version of
os_info() out of the system at all, so what _sanitized() returns
would be what os_info() without _sanitized suffix would return to
the caller anyway.

Thanks.
