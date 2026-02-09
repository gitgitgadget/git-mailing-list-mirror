Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862C19D8A8
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770596259; cv=none; b=psB8EHBsPvvZRbGID1PDpZUqCVzzLtUe+ExDJYAGW+/B4R0BOUnl23GnIHAybWvNVJcb1nw5iBEj3KQM2vmfp7K3hxJ0uwGZEQSEvpbBPo6cSHhVWkePgxezsNcUfCem5KMkeKegW1HQB2rIMQG6alni2THWoeOHj5D6J2ZAoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770596259; c=relaxed/simple;
	bh=YHuSyqyOme4QOFYkGkYavyCqabk2bcXngs4NO4iPqqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GOyMCaXrJn/83/jCaY6K09bdKuqzPBhABh42pZeiuy1u1C8/VdxKUOC0m7y5CajvKJvI1ebz9CFzQClH3ig4K2KzmVc9jaVXxPvg+nZDa357OFLiWMDaLP8fbUAWQ0ZPvpf0c6iMR022AIXiL174Gy5+yP/3I42KgncFpWvMVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ksjyyosP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8kks54M; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ksjyyosP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8kks54M"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D81F37A0087;
	Sun,  8 Feb 2026 19:17:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 08 Feb 2026 19:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770596258; x=1770682658; bh=Xhvtttbzz2
	5DADNn073F0Hgqe/QOcdDDOCB3FHqPDdk=; b=ksjyyosPbTeJxLWjfTkcURpuhF
	Frcn58wF8NbOb1Gr3q1h17y95mdR397gz0XyO/TQz+sfhA4xuEkBgV0SZMK5tBLm
	+leEQ7Ynq5BBlErtXZy61Ht1q/erQxhWui8nySkqTnoll3JwAb1OQSM11A908h1o
	Kh4khzWIx++Jr3F4xIEp8oHVzQUZeVyW7/SvtZUgqaltXSpdeSrXOr3OTdWKUs7F
	+UULeCzJV6HgAuiQC05W1MDopYGQcIpG/OMVhES8ftReYIzmHrYGrWb6hktl6Fia
	FVmMi8eCRI5Zf26EDUeczGefua6GfR6md3JKc/QTdLGNuuh4Ifczd178Afuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770596258; x=1770682658; bh=Xhvtttbzz25DADNn073F0Hgqe/QOcdDDOCB
	3FHqPDdk=; b=V8kks54MuJlqR+c+L1AFg8Y5fPm9io9la6kVONq+hvnrkPz3Pwa
	yU3S1QDLc6ov1OnvwJXvOZjs4nO8W/gCTL6U+LUtjQJKiyOIyDVaEwQf2JhmguSh
	Dopa0KixrVqQehXhkRGWltupQXbcILYeAZSXVzrUwYWrFPAukFk2GLJ/fS0dauxy
	9b7vcf2iBaXdeBXnvVuQ1xOgcniIoIcRKF3DEZ7l6NfjDS2fO9u+idMMImGT5kVx
	Ym3CEudLM0C0RZbDuZs58lCVzKsZSAhuU1nH61iYXk8dvAEUmALc9U22SxWvBTPd
	OhlRt0HwKmq0Vunu5cJnIH9vqscbnRzRIjw==
X-ME-Sender: <xms:oieJaaE1vLQ95glPiRywjmcRpEdcP27kEU038yLiBQLCzTdhOP1p5A>
    <xme:oieJaaZ2Jqm6bdTtZqbKHeVn4iu5N8HSWSucK7UxHUeQs5AoQeOUG6Ol7Hk_RFa-j
    2ZecW2oDrdmnQpLtZd5IFTdpvEBR0EvSJGaVWSwtbBmIPoInIj3zg>
X-ME-Received: <xmr:oieJaaVmjnx_dZqyzEH6RFcwaXRf5t5Hf1enFQ9_bJgGMHHtxvODN2Zw3iqZtO-KDFK1SHOqE3WWoz2cnqDgIJzEvRRBCMDRFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmrghilhes
    sggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oieJaQkQ3yMTSExPcpzFW6uk3dpil4yg-qXWeU3BlOqARYo_4H6MUw>
    <xmx:oieJaVB47GzDH4fx1zvq2GrBIVU_2G10Wifrn5OBr7T_G2oF4woxRg>
    <xmx:oieJafgXP__Xu7G4auVP-zIDg-ks3n3Hh_Hv3odiAP4OgLfiMegglQ>
    <xmx:oieJaSxVyQidJtplHLARYp7gBc-JO7xKlYEV4KqpLe4Oy3lOCLfzyQ>
    <xmx:oieJaXKrvfT2zpSYpxlaRyg_CGLbE53n1v5tcMiQwEcLdZsx8vTT3mCM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 19:17:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  git@vger.kernel.org,  "Jeff
 King" <peff@peff.net>,  "Matthias Beyer" <mail@beyermatthias.de>,  "Jacob
 Keller" <jacob.keller@gmail.com>,  pyokagan@gmail.com
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator
 line
In-Reply-To: <32614598-48f0-4e3d-ba8c-e8d96b71dbd9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 07 Feb 2026 22:38:10 +0100")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770476279.git.phillip.wood@dunelm.org.uk>
	<83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
	<xmqqldh4b5y2.fsf@gitster.g>
	<32614598-48f0-4e3d-ba8c-e8d96b71dbd9@app.fastmail.com>
Date: Sun, 08 Feb 2026 16:17:36 -0800
Message-ID: <xmqqzf5i7otb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> A saving grace is that when the user is stopped with this,
>> pre-commit hook that inspects the contents to be committed
>> have already run successfully, so rerunning with "--no-verify"
>> is not with too much risk.  But still, I am not sure if this is a
>> good thing to do overall.
>
> Maybe this is not the right tool[1] but perhaps the hook could respect
> an env. variable to disable this check and hint about it in the error
> output?

It is merely a sample script shipped with the rest of Git, so people
can choose to install better alternatives.  I think it is fine to
keep the sample script simple and understandable.

It however is still a little worrysome that the behaviour of the
sample commit-msg hook updated with the third patch may be used
against helpful suggestions people in projects that employ the
e-mail based workflow may make to their colleages to deliberately
commit a three-dash line followed by material not meant for the
commit log proper, which is a useful trick if you are making your
commits to be sent over e-mail and never to be merged directly to
your target branch.
