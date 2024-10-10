Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A1CC140
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576543; cv=none; b=B4/L8pB65LyrDXIxwGI5mtlB9SMr3hZ0/XQWo8eRFG+Ik6v2bop2OeMlpnTmxS+qmp0YarI72mDPnE285YuBeo6bIzZsGqGbKC8IjlLF9/hxI/VvgvDGFiPOJscbRJZNk3ox3lQKQTy0fM+r8LcU4KlEt/miFu9Q3ICCMVngzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576543; c=relaxed/simple;
	bh=liNcpFJ2ogAxYVoXy0/C/BJFGgfD/HoqnUztiT3uSX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvQeqPgTHdf1puCkDwWGnFb8Ss7RGmW4iVeocnAyujyrysTL5cAnwTdIbLKbcpggFpi3V3pp62HdAhZChzDPFGTUrr1JJdtqXZZbGH4sztqYcWDVxgFcfscnK3/JOzGt4LwQbVb0D0VCkw2nLsxdRSEKXKT/iTbPRqu3n5fPxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JEB/Ywl2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pmzn5NKr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JEB/Ywl2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pmzn5NKr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5127511401F7;
	Thu, 10 Oct 2024 12:09:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 12:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728576540; x=1728662940; bh=XKvK8NHkMw
	+GoY7SHv9Ct0eV9AYLU6fKeMUCDR1hMjo=; b=JEB/Ywl2izoAtF6J0bw0MDUiEL
	ZgpZPK7Npk7Ai3AWORuEIgORIueCHH3jdeDvX9lrLy1xCB6BI0wxToAMv/1fYF3K
	DSATxkr4jPP3uqRwhGmoXPzdAuHoCCTpcaWY5nxYKtMo0Uh8vCYIW0eZeecoUCnl
	3GvJZRoQDwbo10/j2quAESUoTDCzJ2UO6WLiWcDKHpO9uoxXjuHO8AauZ9XuxYEP
	a9CHX4D2JB4S0+Fam2MCXUCDzIvECJ5DCtIE1vrZkkS14mlT9ThC27TcClrdEski
	A40snsFMuB63+rEJ52JJRhM8NLsBQqEe2EKD/Fuz+HL+cP0vv6KfD8Nfk3PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728576540; x=1728662940; bh=XKvK8NHkMw+GoY7SHv9Ct0eV9AYL
	U6fKeMUCDR1hMjo=; b=Pmzn5NKrQplD6Biwd3NwXQBZxDX4aX1f7gyuRVbDKYyW
	OgA7lqJD/Yb6m2ghvD+TnqtJfOmyQdAOO/7gdei6G4CMr2MvsJ1qvp46dzlbCq5U
	vF1C6CGVCPTDqdyQhp+FsqPUlRiG9JBswC8F9F5BBtDpUfYD1iI5CoHIeLqqFLrH
	HyxDQrRpsS3CHcB3KyRLythhnkjcqqNovDPZAAMOtilsBM0x3JMjP4LssLzkj/Cd
	7EN/3cQN3SBtXNTWbEf5MheFJPq7LgQDuKac2t4Tj1h5i+gJzGskQGH0GiOSM0dn
	67Q/SaPf3/Ew04tpS76u4EvLNRo9kAaLKZ+rdvwNiQ==
X-ME-Sender: <xms:G_wHZxWTH1Wd10ACQPb0G5SeFwyeCXYJZksMlVYtdgJxX3uYlBavSw>
    <xme:G_wHZxma6LEMGaBFYutAWvp2IbS2LkNUnbWHkTE3gqR8F6UfkV9x38xqSXZp3GSgh
    iTH--SspWNMNXo3Yw>
X-ME-Received: <xmr:G_wHZ9Zq6G6o75bECsuPXUc5K91JABZVoa--f_sS4qcLSRhAvCikyV_3rRTgtJlsyelXNxNlFRdx17I-ebghXesCaAZscxPKHQ7wwL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhovghkkhhlvgesfhhr
    vggvnhgvthdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:G_wHZ0UtHV9wcz95nh-U3iPzO0VA-QgcHBWUcUyPSKrhQPBXKo-8PQ>
    <xmx:G_wHZ7kI-INFssxvBlADxMWXtX7x_7VDKzecxSqm1dNFyaEdpys6-g>
    <xmx:G_wHZxeJ5AFEky1Pfi5KWjLK3n0sVGKTSVU2unfSa65skc1jLgb-2A>
    <xmx:G_wHZ1GaSuc62bL_Y33AQLqvUoJFxwp5aHW6mjqOsZblh5CSYbjNqA>
    <xmx:HPwHZ5bnGw1ChFHREALfecJ_NbNvSQRFsAfPT6KYNFPS4fhrpQ2kctGe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 12:08:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,
  git@vger.kernel.org,
  tboegi@web.de,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] [PATCH] mimgw: remove Compiler Warnings
In-Reply-To: <e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com> (Phillip Wood's
	message of "Thu, 10 Oct 2024 09:59:18 +0100")
References: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
	<20241009171342.2354-1-soekkle@freenet.de>
	<20241009171342.2354-2-soekkle@freenet.de>
	<e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com>
Date: Thu, 10 Oct 2024 09:08:57 -0700
Message-ID: <xmqqldywlz3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for re-rolling, I think "Fix some compiler warnings" would be
> clearer than "Remove", also "integers" is misspelt.

Though "Fix" is a word with less information than other words we
could use.  The changes in the patch are primarily about mismatched
type, so perhaps

    mingw: use size_t insead of int for lengths
      
would make a better commit title.

I agree with everything you said including this part:

> It would also be helpful to explain in the commit message the changes
> to _ssize_t
>
>> +#ifdef _WIN64
>> +typedef __int64 _ssize_t;
>> +#else
>>   typedef long _ssize_t;
>> +#endif // _AMD64
>
> Please note that we do not use "//" comments so this should be "/*
> _WIN64 */" so that the comment matches the opening #ifdef
>
> Thanks for working on this

Thanks.
