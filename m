Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7C346FAD
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587887; cv=none; b=fGc9xihh5ANwJg0ksFxvDOflDnThh4Y3itTjRa4r85eTgBUiP7rBijm7AcSJf8IEu8vwAKVYFW2uayWnwECrDDvmK7dRZ9pkEJ/dlKUViqS5lZeL4vWf7yXgH7zs8aCboEZjId9X0ENaHEMwWlH1tMyn7U0hjEieuxpNn8wiCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587887; c=relaxed/simple;
	bh=TdaKHbg6FkgH7JCYB0zCEbykmUIc5u0/y3/QqoIbJxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZpfCI7oRKbBxFQ5U+Ev1DWtzWWNONQDfjYJfaYBzL7myK2ARue8ewwwRnDD2GWfuVBD5YWkTzPJbajz3eBFCbh4FTxVk9/5F7ESHZueuxFCdvhSI2oUsQ1nMz494LqkAIgSCW51irD9iSqr7A1KQfRUcaOyjsmdYfNT4OD7KDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=olw5ux2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paDWFEEJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="olw5ux2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paDWFEEJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 88838EC024F;
	Fri, 16 Jan 2026 13:24:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 16 Jan 2026 13:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768587885; x=1768674285; bh=Ed078BD1Ix
	QXYq0njK0CKqzebxSs6y1r/KN0tt5S5HM=; b=olw5ux2XopcDV0IY+ZYQ1R5sD+
	3KMQtI0LptHqgFinzx6WfWuxD8S9nLBwavC+sPhnps7HMH8n83BXBGLAsMbqYT5d
	DSprJpL/mWcg5+T0xyfxb0spVimje99DlwLooRxRfkKqmOgOVSNJKGo3JkqmQV9m
	t5VDSjYoYcLvhtQ7H4wM2l62RZM/3rLsuqkPLsxxIaQ3jWKlbMGJ39nlDJuj/GS4
	1Sgp3av36fOjnQCAw1LUc0X2gqDCx43sq5gJvd/8MiY2qzVsY1rPOO7yYYfopkT4
	woBZBJJB76J8FzUF7Krzl5QkbH7dNCXeVtXFhh7adZbGtAAq1Es9upaLosNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768587885; x=1768674285; bh=Ed078BD1IxQXYq0njK0CKqzebxSs6y1r/KN
	0tt5S5HM=; b=paDWFEEJCLt3FUO8g2+VBIagW4RyVqzDOWB9EbXHAOuayO569ak
	vuKpchMZ1shgObWhN/Lp2wjHIouZ2aBh3eLZvbqV5fNQAvz/aZ9Mqo69pS6dUggs
	zxeSYa0849u7XtjxHL5KHVxdu5VkpJAIy48nqEc+sGny+misTugpRemS1CowF6j6
	3iW1oxHSnCgcfkTPRUv6VazedmzYCwYMppmjDEyUvBwB0oMjOrvhcxWiJBKA4Z2y
	0yyMcYjo7U2OaHBCw0NyTlq2Ku2lqnNYObnM/chq8vUBAi358k73NVs8tbggW4s/
	zOYWREX4dzgArfr1a7zYvC+N5d4BFMw6RQQ==
X-ME-Sender: <xms:bYJqaZNwjYxHbYkee2moE127GcjUe_szZyjvGpaJRagTkpjbC7vHLQ>
    <xme:bYJqafpBUiQ6ket4dLHDDGNSGcYgvnbuz0O7-K6EiK5ACQ4Fk5XJOu_CLWOx2pBc7
    HDcvpGhq4SWT1Q0_LWETzpeLbngxzfRM8iIqO7Hjv1eWnS4PtulPQ>
X-ME-Received: <xmr:bYJqaSEOiEUMaTwdZlhaGkO5pKe3kFD_fPiNXMkttLDnlRPw9Nm7VTN5f99TzHNjHfM3DubXaNYejtKXp9fuerF7sOAgF2js4L928Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bYJqacoZ-V868pksGJpMIMk5VNNeaZ2vOzYe_jARjK1N3bjTKb6M7w>
    <xmx:bYJqaTZG6QLieE_7dDRmz3-kG0T45aV9IUQR8N4EapbGX5mp8fjNMQ>
    <xmx:bYJqadWHX-881rn-GNtIywbsNX5HoEcNPQsW7qMG4KPaFsTrxf7xJw>
    <xmx:bYJqaU-qGrxVLLs0IDlWRn_bzXp2cDrGz7xryH6TZez2TZKLGnp1cQ>
    <xmx:bYJqaaoRKPCyGIctsH5hSZc-ezIatNsm_nLTi3-FCXOif0GBbO_O_MXM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:24:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v3 4/4] last-modified: verify revision argument is a
 commit-ish
In-Reply-To: <20260116-toon-last-modified-tree-v3-4-e6ade4dc35ab@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:08:40 +0100")
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
	<20260116-toon-last-modified-tree-v3-4-e6ade4dc35ab@iotcl.com>
Date: Fri, 16 Jan 2026 10:24:44 -0800
Message-ID: <xmqqh5sl8lg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>
>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
>
> Fix this error by verifying the parsed revision is a commit-ish.
>
> Reported-by: Gusted <gusted@codeberg.org>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/last-modified.c  |  5 +++++
>  t/t8020-last-modified.sh | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 0df85be318..5366cedd0f 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -150,6 +150,11 @@ static int populate_paths_from_revs(struct last_modified *lm)
>  			goto out;
>  		}
>  
> +		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
> +			ret = error(_("revision argument is not a commit-ish"));
> +			goto out;
> +		}

This will do, at least for now, but I tend to prefer to say what the
user gave us when we expected a commit, e.g., "commit expected, got
a tree".

