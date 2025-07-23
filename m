Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B92F5B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290583; cv=none; b=HyQ2KYUfGqSGFTdOMmteCyl3GlYoOV4d3hUNrss+1bxuDyokWNcV6Q5MSMXOuh5S5VSKEY8R26ScDNXTWYlVqejtNEcK4jVdirv26V/DyiRyyxXIomzitf4klGAYacQPbeZiVzlkImj/Wf9tLnNRZiBbxbwgtX+OT1iU/nR/IqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290583; c=relaxed/simple;
	bh=1h9MSTE6hCVSjh/FheU9MdsYpnihxu4Z+LP2JCgAID0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7r5ujQJkfqCXFHVWMyvb5dLSUcEUwCTLaRjYlKMW4+K/yI7k3pRSmrTIe47KqG0Agx8h1iEaV0+Vaseh13rckmvds7BqTIUJNbHULwNeCmgYN92iFapbaRHn81JfWXgAqgxTnct1bf6cq+q4ffbmRWO5Po7NNIAafqXbq2gKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qhEkYaeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8Q9EtGS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qhEkYaeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8Q9EtGS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 80B17EC022B;
	Wed, 23 Jul 2025 13:09:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 13:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753290580;
	 x=1753376980; bh=dIIOtfxSTnq3aS+nd8xg5nB5G6BJRh+Xu/2gRLIauqQ=; b=
	qhEkYaeSdV1mvd5AKeTkJxJUEd09vnmWgZUXZrIKhx7mq5aE/9vHVQK+0/WdTZ58
	XGGYPkfjfeHDjhglWB7Ga8PYA/6kOorkMSg2mkyE0EytgUHCUIMaZBOfPClsdnfx
	iAGxTTFe4L8RLX2W950+iXOjyxe7L3lHCmfwdcVpTtuKoqlmMl4zGlQwVJYmcrwO
	DPLsmcYQhEssj08P90wVF+YSSYWfxxFl97TJcNDSZJUNX2nwbhF9xPLChm9jzlLN
	T+oCF4n31ZRdw2L4FlfQvHb9Ow/LOAG1w7H3zw7DBkISzLoV4FHwW582YLOH42MW
	6Z0kGIppl5hC5+9mno5Utw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753290580; x=
	1753376980; bh=dIIOtfxSTnq3aS+nd8xg5nB5G6BJRh+Xu/2gRLIauqQ=; b=h
	8Q9EtGS7k9TCNNBF8k76auConk+Epr60Y3g8xe/BJGPQ2sZL82m/Rutk27c0N1IA
	0AMHuKzIM4SEo6yDL0oEL+xXD9GC3HMduByNAKMhAKZQUWjhCkyWFgQ5r/nFrPqQ
	8p1JU5LCgaUVj4KDMSsgrnN4Lsw4aWeGU1y6ES/TX6ASZGXxJxxV9+otmjmFaoze
	sQruULc8NCg+Mo5foGP+5AunwnX4oUbx42xvY4Yp8PWvS+wYJMFMSELz731xKhqD
	0e4QqpDFrKmsC2sINO/sLa8OakfBJZ65Qd0A3U1Hn4J+E0svVrg3o7gxS7TXq5Sv
	7HH6rJHy7w7EOVWjJTgcA==
X-ME-Sender: <xms:VBeBaAREBbUqHTbLs_8BK_4H3p8sBLQBOC2mPISY2MGFdtyV1D0TVQ>
    <xme:VBeBaJQgHJ3sAM4wKU_XNdBVBn3bQYf5aqzTik1Awjc65isAqXJ3q3fVlXllf1A3_
    Sly1T4bf-meQ0W_Zw>
X-ME-Received: <xmr:VBeBaEQBUBBIIRFNtOP7I_9LSlluNlTRnMHAXU6nWUA3X2-o91tFRzFbau5cqDFrdHHPHpcp0C9M3nbxQEC4Lw2bvSljbrlujodu0xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohephhhisegrrhhnvghsrdhsphgrtggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhesihhstgdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VBeBaO5e-SoxWuai7yb4vGl0G36TcNUPCF0_iNd-Eb4s5or87A5uBQ>
    <xmx:VBeBaA2Z20K51vWlpC8Ez3rfJQdK0zFdFXBfG0BZWa_CWb1EAfiH4Q>
    <xmx:VBeBaJAgN3fVnJvW27b5CxL3O2jofcHToYruJtfNueZoo3djTPSdZQ>
    <xmx:VBeBaLN-6yXgUqpTsEDHnihxA9U7AEaFJV3gb5SNDbvGoZnRAEu-qg>
    <xmx:VBeBaHdkUd_0vUuthDHQosHueHKzragURJrhmMWU_6fUo69kmmabUZ17>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:09:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: hi@arnes.space,  git@vger.kernel.org,  =?utf-8?B?TWljaGHFgiBLxJlwaWU=?=
 =?utf-8?B?xYQ=?= <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
In-Reply-To: <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com> (Lidong Yan's
	message of "Wed, 23 Jul 2025 16:00:43 +0800")
References: <87a54v8nmz.fsf@arnes.space>
	<12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
Date: Wed, 23 Jul 2025 10:09:38 -0700
Message-ID: <xmqqqzy6omul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> The `—ignore-matching-lines` options is introduced in 296d4a94e72
> (Michał Kępień 2020-10-20 08:48:09 +0200 5803) Since the Git documentation

WTH is that reference format?

> doesn't specify how git diff --ignore-matching-lines=<regex>
> is supposed to behave when used with --name-only,

True.

Traditionally, these options that deliberately allowed loss of
information (e.g., --name-only that strips _how_ they are different,
--quiet that only talks about if there is anything different) are
meant primarily to be optimization---when it can compute its result
without looking into the blob contents, it is very much encouraged
to do so.  So originally the design principle was that options like
-w -b that needs to look into the blob contents are to be ignored
when computing --name-only and --quiet.

Things gradually have changed, and these days we generally consider
it a bug for the class of options that deliberately lose information
to disable the class of options that require to look into blob
contents to compute the outcome if the output were not losing
information.

"--ignore-matching-lines", together with any options that affect
XDF_IGNORE_WHITESPACE* (like -w, --ignore-space-at-eol) are special
cased to tell the machinery to look at the contents when deciding
what exit code to return:

	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) ||
	    options->ignore_regex_nr)
		options->flags.diff_from_contents = 1;
	else
		options->flags.diff_from_contents = 0;

so "git diff --ignore-matching-lines --quiet" would already be
operating correctly, I would think.

It is just --raw, --name-only, --name-status, and --checkdiff output
formats that deliberately ignore content based ignore mechanisms.

And I do not think it would be a good change to have them follow
"ignore" bits.  When asked "has this path been modified?"  "what are
the before and after blob object names?" etc., it does not make sense
for the answer to be different depending on the presense of -w or
--ignore-matching options.


