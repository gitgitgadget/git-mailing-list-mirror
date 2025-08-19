Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2E1A9B58
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615841; cv=none; b=eaC0o3Cnh606al2qFcf8G3B2a7bRQ69Yaa0QZI/oYax5NTz25FdHrN7rV5CiCxEaoiQ0E5nQYFpkbKeczts0wWWN23zyi6tA11jUkdBzgt9HqFHZncKYOAiXgWNbTul7RDG9W1mIJrsWSKkybU1FDW1WUr+S5WcLeXxsozuX3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615841; c=relaxed/simple;
	bh=iVHlMFdvmzytL+fcvDbKbluzO64d9MWjqe14aHSQ6Ho=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f3qldQ98hsOhCE3IdLBzYS9ZR+xBRUDRTP4PDkGXRnSMKc/alAPb8iOeEsjJY1oLQuM4Gy8yMytQk5yaIutAzi8jCn8QtTppBLAlHavjJ9QZp50Df5jIsP5uUBahSJmFlYRQv4XSpUZ1hxqnoseek5pMsf+fBf0TE2gV2a5hLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=jdTigf1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbqBE0Oc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="jdTigf1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbqBE0Oc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BC3D140022E;
	Tue, 19 Aug 2025 11:03:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 11:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755615838;
	 x=1755702238; bh=UqcwFn2jrqviQulicgRUbyuRnG25tGl4dfrnC6euEMg=; b=
	jdTigf1sdtrCNETIueaj3lmjR1sPOBp/abHWQs278g8ixXeIy8u58nTBA+QkU8rl
	WzlP95jqhGW5qYCD5bk4Cr5okYEgbifnUWMAudgR6k6rzVycbVwKetPtxuzzT9XV
	goDYNrtMzE2omBi9x4EtZl4RGBYTsJ3HPEbDYWepT5n9dpTcSdvoFWhKEQkJTNse
	l8myPo8fY7kkjQOMrk2EIF6npK8R/dPQOb/nHfGdKAnOpm2DDykF5IkgxRLDqRgC
	POkb+hu7cCo1aJjDnx36HNY0jkN4hgy/9KV+00i+GZLYiCJcf15hJQVRl1X7InFm
	ik71CpRhu7C6j0cDpLEcFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755615838; x=
	1755702238; bh=UqcwFn2jrqviQulicgRUbyuRnG25tGl4dfrnC6euEMg=; b=h
	bqBE0Octajrn5WeJvsFTgSyYDCVMSqj6gm964mKNkGXqZmZIVqT7dBiKRb/2fMJX
	v1tVybSvOGYs4J8DB0/5cqhQ31qh9TM9qc0TWcA/kkRfscBXBsC1P19SvrL9SA0y
	Ps23UhZsScQgx2kRDV2Vbex0jGiSMx402iFlejTD+q8JpQhD6oTrPWBaXnRH6CpE
	KJU3vFHtakfF2ZIf4CulI/syo1WIkSg2xuAfRN/eapo6q2g/MNxdoUGeDAbwZUrR
	xX973nqggVbqj/s1ck+TZaiMolRzU9Cn9BeaNhibtvC2OVZgulzJPsyLN1XYILUh
	XyIoq8VVttusEL5xAOdUw==
X-ME-Sender: <xms:XZKkaE80KzSZuhkouz_R1SPzNCWtwcT81grB4tmwjUC5w6GG8DY_mQ>
    <xme:XZKkaMtbLgoV5x1Y2NFDtoaZ-9c03A2B_NuG5BbCispsc1bW2vGF_-fBGr2rjTT6n
    YmxPxLEYJ9khvtO5bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XZKkaJPlsIu1mCnx8r0H2hvv5RCYSfDpha633_piVCmpZtaIDVBeRQ>
    <xmx:XZKkaPylzM3p9BS75WLN7o8mtB-tydrf6LN4hOGRXm4g_pPf2b_x7A>
    <xmx:XZKkaBV04Fsqkn_kdK5yuQYkUa_FWg_C3gTQT0ceRNoZ7UuPyQLDNA>
    <xmx:XZKkaJOmEnQQ50XtASEg2cGLLg4cPrkuQya3XEdBAU36xr6pIPt8qw>
    <xmx:XpKkaJg0iN7eVQN1bNWt8p3Aa2-kF12MgwnTljyMzt8lmt-seXv8f-OR>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF15E7840B0; Tue, 19 Aug 2025 11:03:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXxIBYmrVmI3
Date: Tue, 19 Aug 2025 11:03:36 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <106c4a6c-9239-4c67-8bed-5ec2c0987f21@app.fastmail.com>
In-Reply-To: <xmqq4iu4k18z.fsf@gitster.g>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
 <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
 <4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
 <xmqqh5y8nvmv.fsf@gitster.g> <51468411-8251-4f13-90f2-5cd5184d7c52@gmail.com>
 <xmqq4iu4k18z.fsf@gitster.g>
Subject: Re: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> The existing
>> examples are all good reasons why one might want to use "--onto" so
>> I'm slightly wary of replacing them with a single example in the
>> description.
>
> Then perhaps we should find a better place to put it.  The section
> on advanced topics notes are mostly about operations using sequencer
> machinery, except for the onto section.  Perhaps immediately after
> the apply/merge comparison?

I'm happy to move it anywhere: I couldn't figure out how the sections
were meant to be organized (I didn't know that "operations about 
sequencer machinery" was meant to be a theme) so I chose where
to put it pretty arbitrarily.
