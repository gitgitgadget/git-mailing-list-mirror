Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F511519AD
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776646; cv=none; b=goUZQ//Mrmj5yItOGXp3hegTNEu35uhMa5ZEnqCSwCFiOgOAvL9Mpst0ikHyQ9vIsSPUGFnu6yaIvEnocc8xZDvk+/TDQn1hgH5N+Tb3PRQw9b7MHtyoFRccFv00q1KqoVjN+/9aV+Ud+pZvzYojks4+bXGCck0HpMgIueNmvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776646; c=relaxed/simple;
	bh=j9gpzjik0cml4oFg6fwSsdcmFKKsi2z/u5ZRLIWCT8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/3eKGuuGHjgHgdc/Y2IF4bWhgyl1cR15Ec4w9sAqKwF43XR/hgNyACn6juUYVxRj2TUUaZz6jZnN5a4c/4/qeiCKy6ds1ih9ObH/SjPVugEyU1J+OpJiw4XnwLpMj0w/9Qp4Rt4ijCFHeSH8YXzZAQsSJQIzH7NUioUsOArnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F74ikqIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yeM75NZU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F74ikqIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yeM75NZU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB30825401CA;
	Wed,  5 Feb 2025 12:30:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 05 Feb 2025 12:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738776643; x=1738863043; bh=Q4PPzLlCbJ
	o+OIJA0QysOsI/NZzfk7jNOTfKYuuTc8M=; b=F74ikqIb/y3dW8ZTP5McfGOveH
	HmzsddFUMRktPUAd/z5gfvmPmmK6FGUv/XDaua8f13lSX3W8wvJSHs00t1ibjyO5
	9H939bkGcuZFPLmdFnysMjsLcFmKm/EHmbkbcX8I+nYYmfEAE96kgMvtfb6iVf75
	QESKrq3+LzwJNxxXN056oOpvFudw/VXIYEiegqYwUvgU8UyKwtFettEQAMpOJk3Z
	Ddi8ww0m1BDGNws3D7vA5BU5WW7GSZe4uft6irnT1AgicD4ZyALfWcHHDu94s91O
	lmP0DzqGr2z7+zobrWdasFtcjnOxtHnF0ULv4Cm5P1C249GJNPDZyIXaaorQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738776643; x=1738863043; bh=Q4PPzLlCbJo+OIJA0QysOsI/NZzfk7jNOTf
	KYuuTc8M=; b=yeM75NZUxhNea5e0gaGPOkN4jhpL3SFqJ9zL9Wclr8+Rb/wH0sA
	yG96I4nBk83qKj837y3hZSxfzpSOLj4WmwO9jnmDLsp8iKHB+jiIk0iSrSVTv6SD
	EInNbOg39fNpniyiPm1G4S1ZGtLe/VfR47oYEaOGsT2LMPNff3iuSDzPsyBZ+/AY
	smQ69fBqfYchRtpmyTVp8tStfJutrjY/G+ZsMb0HCostn0ofzsmiCH7c7Yw35KEV
	1X7oHc4BSiIuHtkrTHsB/Inive/hP5fpgNR6PbZ0yGYjJvz8h1vUKSDeJDWB+u2x
	TelFiAvEvGRQpw4SqfIyoZfjcPNAiC23Q2A==
X-ME-Sender: <xms:Q6CjZyFjEkoh0O4RiWHF2QGDZxF6BstSt9dOR4e63JaK49I4haJ1Ug>
    <xme:Q6CjZzX3RVfSxVNih4mOCITbFwZy1gVXfrEhp7q5gFW67CzedbUvyPBHcmQKHw90p
    GzDRuXjJOb5Ww4Mog>
X-ME-Received: <xmr:Q6CjZ8I3INcVw2z_CfzMXCF9arDI4pRe4iybjpMQtXZW_lo3kvvuLQqjtiCuRzNeDEd25pRErWwtHlFac9-l9UWVIN79j5FoLzCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q6CjZ8F1i3IqKvaffJcBamLGk47lW0zx_QUKzZAwEwB5AI6bAAYBhQ>
    <xmx:Q6CjZ4VNXDneZrD8Gchh4bPtfqsuf49jRPO6C__RcJf4xuvn9m1d8g>
    <xmx:Q6CjZ_MbdaetfDJXD0SrieZKhYPlLRvT3Wh6ETs70c3WWfJbnChfZQ>
    <xmx:Q6CjZ_3JmnQBqE50lJtjJ0SbIckCwZhJUoflZNj1uVDUyNcD2tMrtQ>
    <xmx:Q6CjZ7G4H4t0w_-8NxyjCzxMPOK18cYzvZoFdDzgcR8NJd-i2MOm_WR9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:30:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: David Aguilar <davvid@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] difftool: eliminate use of global variables
In-Reply-To: <Z6MThg8oEEtx5xur@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Feb 2025 08:30:14 +0100")
References: <20250204225501.597873-1-davvid@gmail.com>
	<Z6MThg8oEEtx5xur@pks.im>
Date: Wed, 05 Feb 2025 09:30:41 -0800
Message-ID: <xmqq7c64pada.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +struct difftool_state {
>> +	int has_symlinks;
>> +	int symlinks;
>> +	int trust_exit_code;
>> +};
>
> Why do we have both `has_symlinks` and `symlinks`? The latter gets set
> to `has_symlinks` anyway, so it's a confusing to have both.

I had the same reaction, but one aspect of the topic is about
"encapsulate the existing globals into a state structure", and since
these two are there in the original as globals, it would be easier
to validate the correctness of the conversion to have both in the
struct to keep the rewrite more faithful to the original.  It would
be more appropriate to do it in a separate step to turn them into
one, if (I haven't thought about it, so this is still an "if" to me)
it makes the results easier to follow.

The other aspect to lose the reference to the_repository indeed can
be presented as a separate and independent change, and that may make
the patch easier to view.

> Also, I think it would make sense to rename the struct to
> `difftool_options`, as it tracks options rather than state.

Great suggestion.

Thanks.
