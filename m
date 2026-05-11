Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627F175A6A
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778460400; cv=none; b=GMtDNuERlFYcqP1swWvvxVKxQEyb/u+wB05wnyPe51o8LnEXJ3k2BuYw5v9m9SfqhnXuvApdQgH5QgC43h4ILTbJasXDt7/F8O3zoEdbRcBn3W0QkfnAKxZ/yoCO0MSOdU9iQPFCsX1VaIKodnU+EFBQaLfiy3V8KbSuWfZIyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778460400; c=relaxed/simple;
	bh=d/j+lWYTIixOmXhGN7iMUhKBIRa+9SzGWJQza7L6CgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lx4391rrM5fp+jjeigOk3rNUq/4+Kd7GzNBVtEJzbcsQ9kT4ZvAl0HS5ViFCeyfAAniH88S47pkTcjCxJcXfsIQjW9QoRJEgbzBb+kBT1HpLsddZFz216hu9FGHV5sZUjiB/cUwKySdjhgvQQz6FH4DrR2arTmUuxaGIE4IjVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PzAb7NvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6b3I4NV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzAb7NvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6b3I4NV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B02087A005F;
	Sun, 10 May 2026 20:46:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 10 May 2026 20:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778460397; x=1778546797; bh=Kk4htpb08T
	mFGwFVz0uXvVtDeDWr1h/b5HgDSRDPG1I=; b=PzAb7NvDBpBQPBWJqjGKCpBswA
	RbTlsTZPnMvt8MsjUGQujIdyiUkiaE8lie2nUq3Yz16rWTctppgiaa5mSlWv59zt
	L2NYyxY/R5pKMhZvQ4FeE42YP7LoJWnqlgI88V4uF5KuxA7A3IpjkdKqzNm7xXzo
	XCoUnzd1DPBCuZxkQkClgjTs/QTiN56JY5OCx7mOWJD7V/eeJZHCdZ7/B4W1DfFQ
	krZnL3Ov1sFK/PqpWDReh0rTB9851RmQWWCxDZBLVJkRlhT1LzOoQKtwCZiC0hGZ
	BAVr414DnIj07k8aB149b2WPbV5n6qSAGFh5BJZ73N8dCwk17T8ss2UpY6uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778460397; x=1778546797; bh=Kk4htpb08TmFGwFVz0uXvVtDeDWr1h/b5Hg
	DSRDPG1I=; b=B6b3I4NVAXe17Y8ffR8yAGajkZu7IovZ9hImDlsCk+cAxZGLKjv
	Als1kHRb+8G6YbRHt3RAGe7er3onIAtdNKU0nH15Y+TmrF219GMmPUamHFpqAe1I
	nq1PW/ZNbM4VQFZDAH6xbNIvimAqMbgctbJvwVEPCHYdRCwLCaUECE3FQbIDhLhq
	u3QlP8chv7PldukzzBwuyQBmDKFYkYdZJrny/DgnlURO5EHPyE4+bDgeKyGCVvqu
	kFLf2Ao+AL+OBi+17/PkjIvgOnoYk0uc9TteQQWEVUOCiWwlaidaPnQK9/fM2pcW
	S6RnHUBlY0aVPSdzcgRM9a2xKtdRS5BqcyA==
X-ME-Sender: <xms:7SYBai1zBf1Q8dydWM8xUMl6VNp56E-mbNvLcX4lqfclMi4e-7vMLw>
    <xme:7SYBasE4dzfioMwFX04O_4lI9tAM8bJS8Wn9TQ9mliVKJC1XJ70813Y8FkvLAhwVY
    qxEWFjSzp7m7Mbx_HieTJBD8gtk9xV_l2DshrpLQrZlK3xBFey1Mc4>
X-ME-Received: <xmr:7SYBav6dlth0L-gTb-G__JUmdcz_x84Y_A7OT-kLiRp9bPacQtjWq6V0-Vhw0dCPN9qc4tpPkZ-SZR4yvghVlQKmMEAYT7HFMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:7SYBaiuHW02PHJHFuyrG9NHvQmka52RizFPmMLmfEmd3cq_Qcvt-ww>
    <xmx:7SYBag5lTr7SK3Md9eIj8KDjsjHkoPXPZ-vzfvBE8hv32S5-JfrcNw>
    <xmx:7SYBatXoqREp1Na5JwCpVkv9yaadbcfVPFVdz97_F7UEZfJN5B3s6w>
    <xmx:7SYBai-Uzg5RG45RtpqVDH3odsopz98b6BSTYzLkURnt69Z0bAv8MQ>
    <xmx:7SYBat41jrcLayCFWpCsKHKKpLKxYW1DDp819WPMaVPySlUry-mWDE2C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 20:46:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
In-Reply-To: <CAJ-ks9krzLO_+O74omAfeVByUBh=rDGSVSarf5PGwkdWepzubw@mail.gmail.com>
	(Tamir Duberstein's message of "Sun, 10 May 2026 20:32:29 -0400")
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	<20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
	<xmqqik8u95yn.fsf@gitster.g>
	<CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
	<xmqqv7cux0q7.fsf@gitster.g>
	<CAJ-ks9krzLO_+O74omAfeVByUBh=rDGSVSarf5PGwkdWepzubw@mail.gmail.com>
Date: Mon, 11 May 2026 09:46:35 +0900
Message-ID: <xmqqh5oewz6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

>> Undefined behaviour can change without notice, and users should be
>> strongly discouraged from using it.  Describing what the current
>> implementation happens to do moves us exactly in the opposite
>> direction.
>>
>> `--follow` is a checkbox feature. You can use it "only with a single
>> filename on a linear history" or all bets are off otherwise.
>>
>> That is what we should describe if we want to be honest.
>
> At the very least the documentation should state this...?

Sure.

Doesn't the current text for the option

        `--follow`::
                Continue listing the history of a file beyond renames
                (works only for a single file).

pretty much cover that, though?  The configuration side is a bit
more verbose but essentially says the same thing, I think.

        `log.follow`::
                If `true`, `git log` will act as if the `--follow` option was used when
                a single <path> is given.  This has the same limitations as `--follow`,
                i.e. it cannot be used to follow multiple files and does not work well
                on non-linear history.

We do not say anything about what the feature happens to do when it
is given a non-linear history whose branches each rename to the same
final name that you start following from in the more recent part of
the history, either, and stop at saying "does not work well".  We
should treat that case the same way as the case where the user gives
a pathspec with multiple pathspec elements or a pathspec that
matches with a directory.
