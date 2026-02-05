Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7331AA8E
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329154; cv=none; b=rz0/Z++XebI+BomGh0zHS/JvET7CleQnmnioiz6oPPXV9GwKXcL9fvAQ7Y3xVUtSBxBKZtsB2vBbt4VLEfvQ6oQ3AA1QacmOp9To5EEmc6geMWSxQCE9j1dgUFRRbVjofex5cZCwv0qdAzVE9NEdGnmmptnnL8UdmOf+UZ1lQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329154; c=relaxed/simple;
	bh=cIDOxXZDfmQY4aucSQ/lnpqpqBdp5WTURO4fnBsSYEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MZsH9aIYmtsi/PzWCER0Dvyit89Vd25W4DmxygE/2zyxWph78RrnMHyY/VyvJShCp6xv5thw8DCknniBP3krmrePYrSEKgoCl1BiTC0U9Vph1Q8z+kVktk0m8LdKqjBpv/G9drX7xkIDbeKEVIafaLuYAtfeJrXhRkgdH8jAvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U+jsPeio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=utIMLhp8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+jsPeio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="utIMLhp8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 53887EC00D6;
	Thu,  5 Feb 2026 17:05:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 17:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770329153; x=1770415553; bh=M4H/6UfKqy
	A+c5sDjWnOffAaZcMFIexYP73CUW1hJKo=; b=U+jsPeioJ7lQx8hRwlOJmfGoo8
	gCfWB1DsuJFchy+XYi9iUeVamBVHfqApJ1ajveO81N7mzpXNIjeR9vbDJwhZDxc9
	BWLE3cBTzjBBthbbDGk9ZU/sR/bGcSLZvj3KgFUnCcgmnLlTNvThbyshR+n5UgyR
	6BCTDIHjbfG/e5+uZjQW4HEaEBAnkD4uJzJ3OFYZOQVLl+3rieebiMTDuhIvAMHt
	aw8UwOEga8MdMPWD6DQ5CSliNMYnYsh070IYsFoXTbZNsDZ+mIFhrEgvxApRcmQu
	831OOBSsz1XnMIpvOtoH8VQtHcFMHuwE13+bFZcnkpAyd+QxZUVaaPx+j4jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770329153; x=1770415553; bh=M4H/6UfKqyA+c5sDjWnOffAaZcMFIexYP73
	CUW1hJKo=; b=utIMLhp8O1Ju97vxTJ3KB16RVXP5WLw444HRuhjplkYlMamVMaa
	KsIbt7Qs1VBhDmtEQ1cgxliUQftN1LkL1kEnb3UixA8Vlana4A/bSfG3tO1dNsOF
	FP5059zgI8kDoskYeOf6yA/sThXvdyjsq1JX3MveUQHr1VIYMUbBbpOevekVDSA0
	1SpWuw//l0r1vQb0dWp1vfVANc9+Ozbq2mWmTtMhZDOxgyJ5p7fV6tt8WtD7E3zm
	g/64TJjqMQpTaLLL63qFtndYxyhhB3/L/HDVK7B380tpb9ZX/9bNbG2ifD3pDVrZ
	/4X8tj6NoZuvM1fhGljJSWJpatGxb69Hwkw==
X-ME-Sender: <xms:QRSFaYxKjmFYBZO1eMh0fTqIHlWWLmvz9P3OrrP8gwNhS0Jnl7n5EQ>
    <xme:QRSFaTJszJwUdGGDIaPD1ji90r8rpL4DcY1tmBC9ga77HFr4Sq1vQHDHTT4Nmosri
    kMBMQ_rzTA3lRX2aov6ZSFC1eEmdXgxkFY26IlK9WJFh8aHshuXIQ>
X-ME-Received: <xmr:QRSFaSqQaSlJIiqtTXzQdz6Q_CbfY29tzZ5xg6AFcz86-JJwFXBTLeNWPnIeMawo70l87srlkdpxFdIGDtMXq32rgQ_CC3x2Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeduudeiteelleefvedtffejffdtheduiefhieekfffgueefheeuleetvddu
    heelnecuffhomhgrihhnpegtohhrrhgvtghtlhihrdgtshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gtlhgruhhsrdhstghhnhgvihguvghrsegvfhhitghouggvrdgtohhmpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:QRSFaSJI0VHSf8rjhpNzhOYhFfX0wwEbBIo67YHFkhGO2sFoWi2WUw>
    <xmx:QRSFaXT_Vw20eWBiUfbH7TKIbcbDZeiXrY6CdKqwfy5qEfo5v2mJ9A>
    <xmx:QRSFaRtW5tiQ9iD0Qvte1IDe76SKsvg-wwRDiZr6hNXv0NrjuJZR_A>
    <xmx:QRSFaYYzjGxQ4GMBpbMo2vTw74WPMJCRqDyzDBMa39lSHW9tG8wzug>
    <xmx:QRSFaWe81U9wmJZsZN8-lMwm65yLO7-jxs0LLNmcXgd2LXRgvuy3lqZj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 17:05:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Claus Schneider <claus.schneider@eficode.com>
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/5] git-add : Respect submodule ignore=all and only
 add changes with --force
In-Reply-To: <CA+GP4brx2CB5giQ+7Duh2yS4qXYEuWmBVrYG9RpZdtE7FOoWKA@mail.gmail.com>
	(Claus Schneider's message of "Thu, 5 Feb 2026 09:51:45 +0100")
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<xmqqzf8pln62.fsf@gitster.g>
	<CA+GP4bob2A+GsVUo5vy+Mw0qJHDD5g+pyo2Ka1726ouUuS_=Wg@mail.gmail.com>
	<CA+GP4brx2CB5giQ+7Duh2yS4qXYEuWmBVrYG9RpZdtE7FOoWKA@mail.gmail.com>
Date: Thu, 05 Feb 2026 14:05:51 -0800
Message-ID: <xmqqms1mkfr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Claus Schneider <claus.schneider@eficode.com> writes:

> Hi
>
> I have implemented the --ignore option. I believe it is done. Please
> review it again for integration to 'next'.
>
> Best regards
> Claus Schneider

Sorry, but I am confused to see this follow-up to [v2 0/5], after I
saw at least two messages from you that said something like

    Thanks for feedback. Noted and will be fixed as this:

in review thread for the [v3].  I admit that "What's cooking" report
often has stale entries, but for this topic, I think its recent
editions reflect the latest status of this thread correctly.

* cs/add-skip-submodule-ignore-all (2026-01-13) 5 commits
 - Documentation: update add --force option + ignore=all config
 - tests: fix existing tests when add an ignore=all submodule
 - tests: t2206-add-submodule-ignored: ignore=all and add --force tests
 - read-cache: submodule add need --force given ignore=all configuration
 - read-cache: update add_files_to_cache take param ignored_too

 "git add <submodule>" has been taught to honor
 submodule.<name>.ignore that is set to "all" (and requires "git add
 -f" to override it).

 Expecting a reroll.
 cf. <CA+GP4bqY02wcESuz1vPMcknigx_fUXFfi_xQ1EG_muGw6EszRg@mail.gmail.com>
 cf. <CA+GP4bpwMui5RT9ixo8iWyZ6XZDw3GnYhvgiqVmRq8dW7yo5RQ@mail.gmail.com>
 source: <37fe7956e089394bb1d75f4c8af4a3347b204803.1768376879.git.gitgitgadget@gmail.com>

