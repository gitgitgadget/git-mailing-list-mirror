Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C6273FD
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744101; cv=none; b=nE/1/rnQj+vc4q/yoz5GCAreboY9LTqjjQ4c16T1i8R5edY0k6kUzQ/vKcpQ8gR8nEBDJrtUOn1dr380iOrC8pf2KIuwIVvtMSeGnrnIDAhNHE6L7tVYlgvu13/c3NayrGYcrV7MPJWVZSiv5MLOFp1eT534NOTiADCcPC/v6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744101; c=relaxed/simple;
	bh=/tQTIJGFo/ukmDD3wh/WJ0cDtAH1oechcuEZjlPV/Uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnO+ZPJgx7hBwDuzSwrpw4SEeS/E0h4rhlZuXqgvX01V2RB54Z+XkS5vTcB2rgAM5ZwF85F/OpYDhs2EDf9ePsRA9ozWkdpDA32KbXv692lhnCjyXU24RQFBA3FykJbw0Cv0BslcVX71v8tmVT0C0jkyL7SUOYbt9A818Bj+E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gr6EvQ/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJMWA7Dt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gr6EvQ/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJMWA7Dt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6749AEC0136;
	Wed, 24 Sep 2025 16:01:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 16:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758744098; x=1758830498; bh=qESqAJVSZO
	gfafzNHbp3MWXwSCyZ/rcoHXXqw4ZCznc=; b=gr6EvQ/oMftvg5lXuVnQhtHUX3
	OUYP9XJ49Vhq0+lRW/RcmvtmBrLDxWbSq9Mw4mG5/PovrQF7MiMO5UPbfLB+vYdP
	JCl6abhMtBbU0MuTY6o+nOITCfxo0oUPFlgvr3eHVuB1E54p3T6ek3yS1tjb69lC
	obCYKt2MT+EkAyd1tpkhvsd4iaHAlB/ppvS5LH4PEgePhjqjqczuJVXWLkecsS8Z
	u03uDs47nSRnI7Bctz7rRfZe2fl9oApij6Yvs56ZW/lJdee3D7/1F1nVYPZLUi0R
	M/7zC5+aJE4EeVNO0ERcH0TVuDthUkdSfvrk0NZEqqwTuaUBuah7+5ab/qqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758744098; x=1758830498; bh=qESqAJVSZOgfafzNHbp3MWXwSCyZ/rcoHXX
	qw4ZCznc=; b=nJMWA7DtIjFC8GJ5jXWu0kRYFlJAB3BEsF7C1AHqNSy9WywNROr
	mbaa749xaN/3l5W/lHt9q6BbQ98jRNhUqP0kq55sbEsd+xS3tMbXk4IVrKbEl31Y
	sA5UI9V+iBzQOi24peGn9f3c3oz9vaAABwjSWMrsIHanmwfdFJ5H9w+QL3LOUXzY
	RDGJBFVDRb3LQpBIuisSN5MANmNuqxEXDgCKirnFROh8vE7QULd2sAcFu5Vk30zN
	DugflkZYhFuPdInZHHBmAwoLAspg6qsNDe/NBAuW3oyI20Xo+YYyIKgXr0lZ2MOi
	fLd18tiJOhAYz7wKr3h1ksoLcGWkIrrQhkg==
X-ME-Sender: <xms:Ik7UaDq28zpBf83rOXUVINm4s0qp6mZuzbwWvMd9AXjOV6-XBLYlaQ>
    <xme:Ik7UaBX0ZVDB-pnNwchoyO-3fh4ODarx8BGw0pIuCQNlEbqugiUuWNx03uO0UKuSq
    1AeA2ydESiVXag8xifn6n2TyO9D9gwvF-S0xg3nP94JazlVWWxNDE8>
X-ME-Received: <xmr:Ik7UaKAl01Z8EeOo1WRSvYL8FSEkjlDFppEcorYbajZ7J3HEQqpqM_4mQvtyjfDitBIvbUAFeNCNO8jVH_nmG4l84iUqFgz7nDlB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Ik7UaN00Iv-vfvEvEAn4Kg3Nr7gpVjVP_sW2bRk_tBEewOG1x7ze3Q>
    <xmx:Ik7UaE3fQCUsXt-LMXLBKkZl99e5TFTjLAAnUz-UUUl0h8BydvsyQA>
    <xmx:Ik7UaKBgalVy63vZwxfRE2t71Q3w3kkZflwpTBFks6VKjWeMUuh2oA>
    <xmx:Ik7UaL5ao9Lni1KTso2H62BEbFYXKNXyfeU_28vX8SQzKxeA2yUMGQ>
    <xmx:Ik7UaLPFsLYATVYFGI0XsBAHCu-WkWhiS0IKlfTSHtGBxT2ZBjV9nfYv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 16:01:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 23 Sep 2025 17:44:32
	+0000")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
Date: Wed, 24 Sep 2025 13:01:36 -0700
Message-ID: <xmqqqzvvk4bj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -When the command line does not specify what to push with `<refspec>...`
> -arguments or `--all`, `--mirror`, `--tags` options, the command finds
> -the default `<refspec>` by consulting `remote.*.push` configuration,
> -and if it is not found, honors `push.default` configuration to decide
> -what to push (See linkgit:git-config[1] for the meaning of `push.default`).
> -
> -When neither the command-line nor the configuration specifies what to
> -push, the default behavior is used, which corresponds to the `simple`
> -value for `push.default`: the current branch is pushed to the
> -corresponding upstream branch, but as a safety measure, the push is
> -aborted if the upstream branch does not have the same name as the
> -local one.

That's a lot of text, and ...

> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the repository being pushed to
> +3. The `push.default` configuration. The default is `push.default=simple`,
> +   which will push to a branch with the same name as the current branch.
> +   See the CONFIGURATION section below for more on `push.default`.

.. the above gives us vastly more pleasant readability improvement.
Nice.

I do not know if you want to do anything to the lack of any
punctuation at the end of sentences 1. and 2. (I would have written
';' if I were writing this myself).

> +As a safety measure, `git push` may fail if you haven't set an upstream
> +for the current branch, depending on what `push.default` is set to.
> +See the UPSTREAM BRANCHES section below for more on how to set and
> +use upstreams.

This feels a bit out of place, as the safety measure, as I
understand it, is only relevant in 3. and only when push.default is
set to "simple".  If we are referring the user to the configuration
section, then it may be a better place to say that the "simple"
setting requires you to integrate with the branch with the same name.
 
Thanks.
