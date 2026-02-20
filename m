Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415230B529
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626467; cv=none; b=kQMa/nyPkNfg9kIpFdHdbzhgPBaTmtBXiHBRNDA6+dOGAc+ZIj88P3i13rCFAJC9LGSIBWFYnNWr44R6/jVm1TImwZg7s9/k8qWaL73/d6hRU36H9Roc7b1TCmq77A0Y7dXWr6V2Mqpkw3gPbsOYt2OXVZjgCDp3qB1qXlr6Gzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626467; c=relaxed/simple;
	bh=F8kJwDkPNo+U0fFV7MlXQbw4wf7I32RTj9gYNG+yiUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rl0jMTrMBYKSy/yxuwnw9shVyIs0wGDDpxa0FDka37CAnGqiopEqnpVIuXX4atkIWQlV6ufHp1jCc9dFadbHF0qZUBQEjhiHPbeeS3oswUqR+vEgzj0mi8KjquULv43s517wEHGCIur2jPJdsCFc9PAbuTe7kZqkcMy/ROJaAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KULgZzEO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfPMytqH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KULgZzEO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfPMytqH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C9CE7A0050;
	Fri, 20 Feb 2026 17:27:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Feb 2026 17:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771626465; x=1771712865; bh=0IPQV+j24S
	ow4tE6Vb1LTzjjxSAvXR8b9iCM5imCwOQ=; b=KULgZzEOPPlz6temwCqqKX+NFB
	Jao0NIkcLl6/gs9gUZ0Ah2BIQ0bR+t7MPqYzEd7Mjf3WpS9l7/etyPBvn3s7StJk
	5tsPOETp/oaecDy0rH2Qel6iQsa5wxFzN4UGEaAEoKH3OKE+n+lxSGIdDMrVFVXR
	hfUGOEMvqFWVvaMvGjxUyMH2K8DGX8VMtxJdIilwPvtC+qkpEg9nSejNzy7tiJsQ
	scBn5FJJvf79vlmnZZdBHp4x0Xs0wvx/Axr5+EXHxGZ/KvLaR3DoJx5TeNZ3oPIo
	0WLmdvLr6x1ns+ox7EKiSZdfCHF4NoPpfovosp6MPvbN2qjjbTt/rZdKvzuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771626465; x=1771712865; bh=0IPQV+j24Sow4tE6Vb1LTzjjxSAvXR8b9iC
	M5imCwOQ=; b=vfPMytqHBSWhWPNK6iaLjPuzuksd65lWrKVQc4erlnc/k7lunmv
	neZp8aJqQdPsbvzCJ5vQmAw9G+oWJZz0bWUDDDpG1H7n9nZyZ2MXcSDlFK/3Q5Zi
	T3n0bmxNxEx1OmEo9g3cpvGX+Vzrn22keEAQgtNKZF7UBaKxIaK0SFplWT6Wnyz7
	oHmYZ238MxGJBA6PvjAf4vAq8WWJ9ypW0CeNmkAe2QG6hKKPBaO6kIUq04KD3CeD
	+z4DyqWikZiyjPhy7Lq6Fiyk7uTEhWByDt97WtrJHF8vmkRLfxXq4fdXnmXvgN6q
	AGG18JLSqh3A7hNoVoy77GPOsJzIMjiBWOA==
X-ME-Sender: <xms:4N-YaVJP94JncGjRMCNvTX6igxnSLV0JXUzvZvWjsSTmJ-BrM2GpBw>
    <xme:4N-YaTtS3GKrAne9eS7kmGgYQhg_NhFnpaSMqnM3vmukTy1utv2E0yc9Qo0EpYqFS
    cf1i6TBVz6uoz-ie1MXswlrP6cTg6c28bYG3VtHkhZeFxNOuF0of10>
X-ME-Received: <xmr:4N-YaRXaMYlfjCq2UFQZW2rzCUHXlx_d54iXe1Pv11JRVOHoi1DhUDR5Y1JT33ukM3Xw6z017xZ2s7CSQfotYv0LOTGut_z8Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegsfihilhhlihgrmhhsrd
    gvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrse
    gvfhhitghouggvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4N-YaWhuEYOS-Om6e3timKsCn6nR7PxeValSNVgo0RXPO_KNGoyczg>
    <xmx:4N-YaRqi_fAtTw7jDZv1jh7LeJekNfCH3uIiJ5rTSmjGVcSN9zXcpA>
    <xmx:4N-YaUEXO4nXncSrKDgkP7zHAuGzqcl3O31RNcnmVLwDmZ9vddTjkA>
    <xmx:4N-Yae5IABxc9K7NtROHk8UvLcVak_KetC4Y4zPs2oa6tfEmfasJ-A>
    <xmx:4d-YaXhUANkR4vV7tKHxYMPH8wLWAcA1bOmkzCP8eyQ2PXAa1dbFzEEY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:27:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  Brandon Williams <bwilliams.eng@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,
  Claus Schneider <claus.schneider@eficode.com>,
  Ben Knoble <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 0/5] git-add: Skip submodules with ignore=all unless
 --force and explicit path used
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com> (Claus
	Schneider via GitGitGadget's message of "Fri, 06 Feb 2026 13:22:55
	+0000")
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 14:27:43 -0800
Message-ID: <xmqq5x7rvyn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The ignore=all configuration for submodules is currently honored by status
> and diff, but not by add. This inconsistency causes friction when working
> with submodules:
>
>  * Developers unintentionally stage submodule updates, leading to conflicts
>    and unnecessary changes.
>  * Tracking branches in submodule configs causes friction as updates to the
>    submodule SHA1 are added without intent.
>
> This patch aligns git add with the behavior of status and diff:
>
>  * Submodules marked ignore=all are skipped by default.
>  * Attempting to add such a submodule explicitly now requires --force.
>
> A submodule can frictionless track a branch in the configuration or manually
> switched to and use update --update --remote without unintentionally add the
> changes to the super-project.
>
> Tests that previously added submodules without --force have been updated
> accordingly. A new test is added to test the behavior of git add with and
> without --force.

The latest round of this series has not seen any meaningful reviews.
Everybody happy with this latest round?

Thanks.
