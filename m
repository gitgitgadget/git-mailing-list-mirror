Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13356286A4
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149009; cv=none; b=WRU/MThvMNnUe/li4GCsEMtvut02MKqTKJl9FOBdJjUjJu5zdzIFqJ1CxEGFJep75TlGHKTqSgOCjjKW7CBLpLu1/fn1/Z6QPOEiri9mlLPJA3fWGjnpdwhlg1/ibuwjmTFE7onLOs2j786EIOznsgV4C2SfvhCEnCfjxkXX7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149009; c=relaxed/simple;
	bh=D1sKnsSdBn6alHjZtYXAVXml52AYQBXm4+9ljavznJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HApUm8jyxGr7mkeG7RAFFpoM/vNC1govAt7Sd6F2fzoyQBQ7bmHfmzTKvytTAVygLvAM52IZjsRiC291gYsd/vY4DKLRIbpxHMm3yGv9n5Djd8dvqRQJJKtU3WhKfxa+87VTM8iw2D0eUGzSTUIlDIeXRJVcZ3PTc8LEaSR8S70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QNqr3DSI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UgOHNhck; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNqr3DSI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UgOHNhck"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49D7414000B7;
	Mon, 18 May 2026 20:03:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 20:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779149006; x=1779235406; bh=MslcZMxLsR
	oWXbyHc5r4jVQjIZ8K1QL4R8E9i7yid/E=; b=QNqr3DSID64ex1y5rNpYQB8I+q
	QTZNviA9/Mt347Fe+INK75E9iQ8Wl77R1P+b3Jifgkx2qwFoYroH6IJEkZZuMQpw
	KCTwMIay2lJhch28ee3dHGN9/uGVAruNQvF68Xm3PxdjVRoM8zlZfTiTkltFJoGv
	+FtG3dl4xcCzzSw81qsNkV6orhAQCfLegERYnEn884euc4WL9RvrVvqpGF7HSy/m
	OpcHVuD89RKiuiEb2IAds6EXjlOEGSdasWEhVGMcB1WslyB/uP1k8TnFn/s+9feT
	Maxpqjxnk2mGaYsIWqrrG1Q32y9f7/U+MqRUV/HxAxRh3MvpC/pGSd874XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779149006; x=1779235406; bh=MslcZMxLsRoWXbyHc5r4jVQjIZ8K1QL4R8E
	9i7yid/E=; b=UgOHNhcknBQCVpzgS8t0ILvVmt0cyGNLk4J7K5OhUnL0x4i3OvI
	8S9h34nJVQoDCbqxyRAyIbchz1uxSodNDsYMnPM8o11fl2E0szUQY+EIYpjYcBD2
	uV5vlEM6HmEfRHFci2L0+E9EhlcvaV6c/Bj+s3V1/BSJI7gleyNL5Sf9UqtaNt5W
	PEiNnBRi6BMEXkM5QNdQqC45lJMDhSh/cBrkm5wKEptxy/IrS41qdQhcWm1XWWSI
	aCsoRLc6JscXwxANIs2gPPn9XyGbd16l/57hRq/HdsdAZQcamXtqttcIDcrqr/qa
	SyClGE1fIdD9IAhKUFHqfklPgUfzIaqoBXA==
X-ME-Sender: <xms:zagLakUPNAmoUeM5gASBJQPAh8Wc9VLC3VLygUmDKMX0y5Fpw7I3yA>
    <xme:zagLarp_88o4cSdsiRw8nK-NLaUnqClaS3d674QiWPY84CPR8XqXswAwn9VmcKRE4
    54RDzOs_fij2Lc9XX-3HqdRo4fjGvJMIGXxnquOUlxWLNLEExtPdw>
X-ME-Received: <xmr:zagLajBWBJauzn6hxTzG2FPmWeN5YqjoZ32fYsj-2dQTjUWbIMNXIguSFTxcRUGHWwSiNZBFVQOh5bCcdPu4lJ_2rQAEIWcjqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehprggslhhoohhsrggsrghtvghrrhesghhmrghilh
    drtghomhdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zagLavhJirJYyo5F4Ij8FvQuxyKj9ahnBtpEuPu87Quk37mg9jNl-A>
    <xmx:zagLapa3the5qnThn01C6VLTszzNoUsMUGVUuZrLgAXyMyBgoNFK3A>
    <xmx:zagLaon_dlaI89L0e_ASKEu7pihs7ib1YDQS6KNevD3ZbyfQugLPTw>
    <xmx:zagLanilBqTW6kzrf3bPT-7o0v8i4qZRtbigMGepxgPIKSx0ngVaTA>
    <xmx:zqgLar3gq4RG80Zv3u-ZW5ZUXmvVO0hTP2a4cOIvTIVmVUVWzMVMegMB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 20:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  christian.couder@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  ayu.chandekar@gmail.com,  siddharthasthana31@gmail.com
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits
 preceded by a root
In-Reply-To: <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
	(Pablo Sabater's message of "Mon, 18 May 2026 15:26:45 +0200")
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
	<26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
	<CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
	<2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com>
	<CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
	<CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
Date: Tue, 19 May 2026 09:03:23 +0900
Message-ID: <xmqq8q9gb704.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> By having is_parentless as a flag in 'git_graph' that every stage can
> access we could modify the rendering and maybe completely drop the
> commit placeholders, working on it for v4 but currently renders like
> this
>
>     * A parentless
>       * B parentless
>         * C parentless
>   * D1 child
>   * D parentless
>
> (A has indentation when it could not have, but that would require a
> lookahead if the next commit is also parentless)
> But definitely a step forward.
>
> Do we want cascading or just a fixed indentation?
>
>     * A parentless
>     * B parentless
>     * C parentless
>   * D1 child
>   * D parentless

I am late to the party, but I cannot get how the latter is viable.
If "A" had parent "B" whose parent was "C" that is root, wouldn't we
see the same output?  Or are we adding " parentless" at the end of
the one-liner log message?

The former, with the understanding that "two '*' commit marks
vertically adjacent have parent-child relationship, otherwise we
draw line between '*' to connect them if they have parent-child
relationship", does not have such a problem.
