Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211728382
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294779; cv=none; b=uiFAJA9OO8yMA6IIqOXqGS3x8ik/b01IkHLM9FkT6WhvOR9RlEqNDqT32yA4vpAh2nlC5eIRu+cKPzVpdFIMqfEX4vWOBThlJgaqjZu3GHwiSUrXiokQvWmFPEz8LHgBRSrvjDkwKQzCP12JbNnKNfLuR6AGLkkdXmtxQavS7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294779; c=relaxed/simple;
	bh=+4hS/Tu8rWvETSWTxGyoWVs3TyDdT+DGVpncyBQBC50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O43UjC1iV6rBAkVNGi9V2JG/bLqAWQEFpl3ZBihGVgtosMY/BK2LCYLURKrcJuhXgKRLn/6LxFl093aG/3ITo9StpI5MbR5ZTa6MrEasUhVrdVHppQl/O7Ge9aIq9Q6/Bxp7CMApMq/WhBjxeiycEfaAV3qWAesnpVuUw1bzrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WjKjIDn4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0cOCQfW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WjKjIDn4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0cOCQfW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83E56254021B;
	Tue, 22 Apr 2025 00:06:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 00:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745294774; x=1745381174; bh=d+efj2BrPt
	uEVJZ5+1JczYpuYQbTIaP9lWE2nWgm2MU=; b=WjKjIDn43EgNO7wypbdaR3p+vd
	ihu09R07OfGMvIEIrhevh6V1SSeS4DTjP2leI0UqS0pYLrF//9evFLWpOQYBr90a
	NNsgsvv2zuUzyDKsz2V876R3lnaND11BgIt00wmKfwyL2Tg4mACwlpUXmg6+dcAB
	8xTREbO2v6PMyXa8R56cz+N4A2DlyFn1SSFvAdQNTckdsyDNKSocIVGMogcGjwn9
	O+HIMZwDsM9Gcb8ggJvykaV+a5JfK1F78pRtiPmBLYKZerAn27SSHMBQjb0MFYVN
	1vXpM9WfpyiOGV7E396uVVgurLU5Bv6BXOu1U9D0lxI9rIPzbtpQQDHuctag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745294774; x=1745381174; bh=d+efj2BrPtuEVJZ5+1JczYpuYQbTIaP9lWE
	2nWgm2MU=; b=E0cOCQfWFlXyy8j6/6ZLdBUBj17w5aabxmrUyC06cbH47dNH4PR
	k+CGOmA3tpPQeFVwnBXTEwf5HG59rDQ0H9bs1nqxXxwbFM0CcPgIZf+rh6evfUDi
	6VHedT9PIQ04KVu1gzd+cDtMiLdXTjNoOW7/Qr0nX6gK6PGI5BO4XxUvtYSqtnrS
	X3DH7UL/3YqN05iNyxaXgeJbn3Ex/pNBaylDc0PJPo6g7Y/dF2xRyCUkps1HjfHN
	hjL8B2GBPG08hvLvEBuQUyOc5Le2B9CihHQlQKH2PVfl4v8uvqrkujj0cV3T5Lku
	x1FAhsdAtwz5gHlO/65q2rt4Y8KhtlzR4Vw==
X-ME-Sender: <xms:thUHaCbCGFXtGrX5eLgcdsoNns5htLEVGFcksALtNX5oVkAgWwq60A>
    <xme:thUHaFbq9rBZAXuJ6YkkwM6yNQnx6AOa5mn_xnbs8OogOvwo_N0Adg1f3RDkLfU_u
    AozvZ-cwmy5jRWSkg>
X-ME-Received: <xmr:thUHaM9iU8LW2ndb6oH5Vymj5N_BkEC1fhkqisXplBxkeKB382vOutGpotv7DjKQFKCGaaPilyWz9ELLduwlHIv5MUTKDROhIbjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiph
    hhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:thUHaEp4_oXGsZbf65U39VsC5NgaJX80l9eEsva6JlPrpq35uhlk2A>
    <xmx:thUHaNp35_mSa8YngJMOpAiQ9eeSgeYopCkvPz0iCVQqcWhZ9eySqA>
    <xmx:thUHaCSAGmeAcKT_-T4TeQA3ntNojPEXmY0p3YKg1i0Mgo2n60vOfQ>
    <xmx:thUHaNp4NoHHdvb-l7oqCmBB3-ruMrT6-y74ArkwULKAtGf0EdrQSA>
    <xmx:thUHaL7K6ORyBo0kQSGZvXfzGylqkQQZFJR9S4tH0Tev-_q7uyaXigZb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 00:06:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: Test failure in p5332-multi-pack-reuse.sh
In-Reply-To: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com> (Philippe
	Blain's message of "Mon, 21 Apr 2025 22:01:25 -0400")
References: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
Date: Mon, 21 Apr 2025 21:06:12 -0700
Message-ID: <xmqqcyd46dsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Sidenote: on GitHub CI, I could not demonstrate the failure on Linux
> because all Linux jobs run in containers, and the images we use do 
> not have Git installed, such that actions/checkout@v4 uses the GitHub
> API to download the repository instead of cloning it [3]. This leads 
> die_if_build_dir_not_repo from perf-lib.sh to fail with
> "No $GIT_PERF_REPO defined, and your build directory is not a repo" [4].
> We could fix that by installing the 'git' package before the 'actions/checkout'
> step, but we would need to account for the different package managers of 
> the distros we test on.

Not limited to this topic, but wouldn't it make more sense to first
run install-dependencies (including "/usr/bin/git") and then invoke
the actions/checkout thing, I have to wonder.  We were bitten by a
separate topic due to the same issue quite recently.

Thanks.
