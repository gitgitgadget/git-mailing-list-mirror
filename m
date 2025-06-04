Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EB290D9C
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048206; cv=none; b=hMsd1xkMbysas4E06E5eNtYGUgaKuJxhNUmNUIpR8KE9kFlb0EYgFP4YAqZnCQEY8XeB0q9iqjqmr//IiDYEi5C6OXCatnHz70GLyO7+YSCWlRsxSTlAlC6Kgm3VnkLrSgz+rtSJto2LmenVpHjDuNygoP97r34oxMyoD28yzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048206; c=relaxed/simple;
	bh=KufEptqTyR6u2BK+P8qMaWIixEe99t/6IHfVek80ock=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kP0iHXvKgIshuXaQ72Wyiq/AwYUNeRMQSvRqPgXln+XNd+VXxV/2eR+YmSE4rmkpa+lKPp3Tmr3WUndcdmLrMous1ftx5xbqgDlpKrJG7HtmGkxvUyXx1aOaZ3w8TudRutetB5G7fgpfY/oQqGB4Lpu394NE5qxPgaR4Bqqq41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kH20vj84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAcX+ZCa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kH20vj84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAcX+ZCa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A84E1380442;
	Wed,  4 Jun 2025 10:43:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 10:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749048203; x=1749134603; bh=bljM4UTqtO
	/SXDcSl4ixVPj42BltdpqdbBeNrfhJ9s0=; b=kH20vj84qXFs6DBeN/9pnfPkhD
	DNNbDDGUxR6KpmDEtrEPcs6Tf+CtDu07I7CmUF2GyJf/EfwgIZUXe9xIn1F/qgqJ
	QUkqloifkC28FnRKnsnLk1ad8OiAOlheL86VFzmXPjSA6WreT17pE0anNPZjF62x
	Doogjq7PHj32RR85rwpsLmJUDO4QKT+6xpANPT1mQXu+AE1JZSrAFbO5orJIR4IB
	u7o6rX+mYCcNsmeRf8iuGI6DpOMrxf/ejq0/qaOk3cVENUSTrJ7ostvwiWdrpxqm
	0h9wt6NuLahlhSRQrp3QE9GJl2SPV6IlUCzcFK6opCWqidA3RNGn4eiaIUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749048203; x=1749134603; bh=bljM4UTqtO/SXDcSl4ixVPj42BltdpqdbBe
	NrfhJ9s0=; b=MAcX+ZCaGVQgZJrxVcKA7ZWwRY9GWXTILKkvCZzKeXBdAyt2JUW
	qmLcFl8bGXYPILAF8tMwlL0PHf8RB6pkBEywNoJ6WLPTUfmhiXn06wS3bmmjJs4y
	dAZxbbtyQdy7gojCWN1PZfuvIbF5ZodnHZ62/Z7AKLXcC53GFJta6quyoapXVAfl
	Ptp3D7zRbwXf1Cvv1e/h3zPshYufDf6WyoSoNuGlLEP2niUL2rwYZDFYHNRFftFQ
	yS0c4vtpRR23bZxccCxnfWDm0vWPijZXjML0hDrSF2TWdz88/sMwtCjCJKQxd6QP
	UsbEMLK/XGE2lMDn/7Ta+aK9+p5Qs8X0OSg==
X-ME-Sender: <xms:iltAaJ1wB_J7QPYjLL2h4uNbjMDMjitbK7YZ8PJJjb9hYkCwmBusNQ>
    <xme:iltAaAEdCvs6q4gUEHQJKiCyEX1wrXIlY3PPT3LXIu8wayEDAFSdAUVFGYEibGxxO
    IfN4Bzam5tX6x2vaQ>
X-ME-Received: <xmr:iltAaJ6XqYut5zj9XuM6mvvu7wmVLTq0vhIXtQvChlJEtaNQwciCKPPbwVhuZf0ie6BB7xRLtWPlP8l-5j2GjFsSW-Em4M6dIsls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvh
    guhigvsehgihhthhhusgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:iltAaG3u-OPpGdpUAdJZGGLxTuDJ5cNcIbb-vz0Rlooa1v92YG7YPQ>
    <xmx:iltAaME280WMoSBPsZu6hb-_dClmq46QvxI3nGYJLF2LgWlfunxGdQ>
    <xmx:iltAaH9SkqTpCtUdDoSa2DKBQM69I72GB9zwtELt5pC7iaTByr1MOw>
    <xmx:iltAaJnLHCp7XfUzuCUzcfvbyS48urksfGF06BQdqNnscOOPuaTiCA>
    <xmx:i1tAaORrgUtGwcXl294uFtQoNnC7KjHc5qG7aBGWOSjA_MAkcZWaj9RM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 10:43:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) and submodule message
 to batch commands
In-Reply-To: <pull.1929.git.1748890555.gitgitgadget@gmail.com> (Victoria Dye
	via GitGitGadget's message of "Mon, 02 Jun 2025 18:55:52 +0000")
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 07:43:21 -0700
Message-ID: <xmqqh60vefee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series re-attempts the changes proposed last year [1] for extending the
> information about tree entries available from the 'cat-file' batch format
> commands. It also (hopefully) addresses the initial round of feedback that
> series received.
>
> The first patch updates 't1006-cat-file.sh' to test non-OID object
> specifications. In response to the feedback in [2], I added more careful
> quoting and a couple tests using paths with spaces. This change revealed a
> (likely known) limitation of the '%(rest)' atom when processing object names
> with spaces. To make that limitation explicit, I marked the relevant test as
> expected to fail.
>
> The second patch adds "mode" support. This is essentially unchanged from its
> initial submission, save for some conflict resolution in the test script.
>
> The final patch takes a different approach to submodule resolution than the
> initial submission; rather than treat the entry as a "regular" commit object
> with empty content, we now print an error message similar to the "missing",
> "ambiguous", etc. cases, but with the tree entry's OID rather than the input
> object name.

I did not send any line-by-line reviews, but after reading these
patches I didn't see anything questionable.  Unless we see others
comments that need to be addressed, let's merge it to 'next' in
preparation for the next cycle.

Thanks.
