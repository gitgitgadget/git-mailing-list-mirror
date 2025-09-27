Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE59824BD
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758938515; cv=none; b=FgeYUOqDOXrVwUTZxDDNFCuSDY/IUsmapKTmPksT6WXqGyj2WRxtwHyuORnk7CBLsrTlN3lwBTGo9n6i7Cuegpoucb5ygQlDdeji6b9DfxuR2YshdCeSisVSKJ+WhW7mBrHWh6CRPKF3tdKMQcgM8dBDEEahBQO84TR02C3LIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758938515; c=relaxed/simple;
	bh=L7EmTKz9lceRY6ai59mlV8V14XIFYMHhcWEU+wCc9cM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmBcAVBJh4LamoTONGH7HkQWRv+z0KqmXtvAJF6g5jfWgIJzeWakuxrDihfkUMdfaz8rWCyjnbB15rqxzkxsYk4oBfylfg3s3e8uJyUJpMuHXKeZbUhgSllxWKHcMI+w/cRfgCBWn+kx02fsRmUYyD2kWs4fzMR4TbsE6U2E1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IUGEBbwk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIa4uzKN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IUGEBbwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIa4uzKN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D439EEC003D;
	Fri, 26 Sep 2025 22:01:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 26 Sep 2025 22:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758938512;
	 x=1759024912; bh=9tT9TB4D/HRV00LCgKC6mQvGXx3okWh7H+zf4mWR8co=; b=
	IUGEBbwkRCoMuxIqI2+z/xdrN/cjGqMATdT/3ODt5wW3sq2HaEb3dy67fz14jWbm
	4Omd3MqIVNIe62P8DxrdulRDlrYSIrkqzb0dPsYEftlPuU0PxA9FG3a84LgcALrP
	Im02ugOIjLGaK4eKipYVEjqsq6JJaS9yn/P0Q4IfXAjoW4UrDW9+pFT+IF0CYc/G
	4ZI180v4OSZ1pf1pvCRqhzfJl9TuJaVEtIKwT4qIwN1qHDoHKOSe0WCS/fahtiUC
	8cW2jOC52ElJ6XUgfdm1/awWNuMXDLamELEDBV/LnlqyqpA6qRTG92r5Bd4a/G/h
	763/K8qyfgvkgLjDjUQiLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758938512; x=
	1759024912; bh=9tT9TB4D/HRV00LCgKC6mQvGXx3okWh7H+zf4mWR8co=; b=L
	Ia4uzKNEvjdUEDshtfYeBNnZp78yzkS3IMEKz1ZhCkWY02wk18L0j85MCwsOoT/d
	VTGtICTrKzgQj3ME/9PC9XA2Ent0d2Zxe08fGbiVHTx3qnzuveWGFDR7ld9Zr8lG
	dtSTocO87eyEMGp3AJsmebuM7mA16KR5uK3Bxc3zjRHNFWOtxDB+jOuy0WRUxaIa
	kgaDHXABBzFGa127G8ZBQRyrlS//pnmMUX6Fg0u+/+dFrTwKAD4f2yLJkK+tXI0A
	MeghtRwKDVZXfWe8rMR6fud6iqCNUoDXcokEvfXFOusqESCmAWy3AEXHDIk3WpFh
	r8uyXpQ8ka0ZpXvG4D4cQ==
X-ME-Sender: <xms:kEXXaLtraeymXl2HG6vy2nJIjAv9K7TjzOnjVJaZsb7U1dQVN0a2qg>
    <xme:kEXXaAIigtFsQn8eHmPEYxNijqm8KvvDv6eXUPlaU_D60w9Egybmm7ztwLvcwvj_o
    VTqoXUdiRWBab95n8jaF5nQhZixNiyo2uixKxD-IxeyvIi1QFLU6g>
X-ME-Received: <xmr:kEXXaImhkX31KUq9uX9-CG0EAYOgIj157ts9926Ovgs_ne6VHSUMmfYuHqNe2FKmwONcS-BiBjJ6XMzxVPppvTTDzptUJ08eIXcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeei
    ueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepiigrrhgrrdhlvghonhgrrhguohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kEXXaBJNXOrvl1gNMX4ztL9dsqN-ngDNWdw7exEDWr6tdT2wP_M2tQ>
    <xmx:kEXXaN7LmMW0P8D35eLRR4fBHSvBi3dYera005HOiGqedIc5h1Aq4g>
    <xmx:kEXXaF1gEG3PGCdRoADg-14HIlwi2NTnASCfclVQs7WlLnSA62D2zQ>
    <xmx:kEXXaDcMUbCSMtF2hk1kDEFYthvr4WqHsgeibCvev0YrD0SyvTbFLw>
    <xmx:kEXXaISxRvJ9fDyqHvMIspWSbeBuWKbb_xcS-_7ZJnOHqipApzq-hv0G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 22:01:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  ions <zara.leonardo@gmail.com>
Subject: Re: [PATCH v2 0/3] libgit-rs: add get_bool() method to ConfigSet
In-Reply-To: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com> (ions via
	GitGitGadget's message of "Sat, 27 Sep 2025 00:07:36 +0000")
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
	<pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 19:01:51 -0700
Message-ID: <xmqqzfag8xgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"ions via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Purpose
>
> This pull request introduces a get_bool() method to the ConfigSet module in
> the libgit-rs library. The goal is to enhance the functionality of ConfigSet
> by providing a way to fetch and handle boolean configuration values more
> easily and consistently.
>
> Implementation Details
>
> • Added a get_bool() method to the ConfigSet module.
>
> • The method retrieves configuration values as boolean values, ensuring
> proper parsing and error handling.
>
> • This addition simplifies the process of working with boolean
> configurations for developers using the ConfigSet module.
>
> Testing
>
> • Added unit tests to verify the correctness of the get_bool() method.
>
> • Tested edge cases to ensure robustness.

Somebody may suggest a better way to organize your cover letter for
second and subsequent iterations, but it is helpful to returning
readers to list what changed since the previous iteration.

> ionnss (3):
>   po: fix escaped underscores in README.md
>   libgit-rs: add get_bool() method to ConfigSet
>   libgit-rs: address review feedback for get_bool()

I am not sure if you really wanted to make this a thre-patch series.
The README.md patch looks pretty much independent and irrelevant to
the Rust topic to me.  I am not a GGG user, but there must be a way
to tell it to send out a two-patch series from this branch.

> base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8

Perhaps you'd need to rebase the top two commit on top of this
bb697214 (The twelfth batch, 2025-09-23).  Currently your two
commits that belong to this libgit-rs series are not built on top of
that commit in the mainline.  They are built on top of d7810781fc,
as can be seen below.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1977%2Fionnss%2Fadd-rust-configset-get-bool-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1977/ionnss/add-rust-configset-get-bool-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1977
>
> Range-diff vs v1:
>
>  1:  d7810781fc = 1:  d7810781fc po: fix escaped underscores in README.md
>  2:  a5904a2ac0 = 2:  a5904a2ac0 libgit-rs: add get_bool() method to ConfigSet
>  -:  ---------- > 3:  43784e3ff9 libgit-rs: address review feedback for get_bool()

Actually, I do not think you want a two-patch series, either.

Review comments (sorry, I do not recall the details) must have
pointed out what was wrong in the initial iteration, but this
iteration is carrying the same badness without correcting anyting in
a5904a2ac0 and resending it with "oops that was wrong in the
previous step, and here is a band-aid on top" commit that is the new
43784e3ff9.

Until there is a concensus that your topic is ready and gets merged
to 'next', you have the luxury to pretend as if you are a perfect
developer who never made such mistakes that can easily be pointed
out on the mailing list by others.  In short, anything in 43784e3ff9
that removes lines that were added in a5904a2ac0 and replaces them
with something else are unwanted "I went there, it was a bad idea,
here I am correcting the earlier mistake" changes.

And the way to pretend that you are a perfect developer is to
rewrite (i.e. "commit --amend") your "add get_bool()" with the new
strategy to wrap the C version used by real Git, instead of
reimplementing it manually in Rust.  This is a chance you have to
pretend that you weren't even tempted to reimplement the thing in
Rust and went straight to the right solution.  So grab that chance.
Once your topic gets merged to 'next', you no longer have that
opportunity to wholesale replace your patches to pretend that you
never made mistakes.

This is because nobody reading "git log -p" later is interested in
your (or anybody's) mistakes that have already been corrected.  It
might record your cherished memory to celebrate your growth as a
developer, but that is not something the history of a public project
is used for.

After your topic is merged to 'next', we'd go incremental.  This is
because being in 'next' means that enough reviewers agreed that a
particular iteration is good enough.  If later it was found that
they are not good enough and need corrections, such a mistake that
nobody managed to spot during the review becomes worth recording and
its correction worth describing as a separate patch on top.

But we are not there yet with this series.

Thanks.
