Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F97265620
	for <git@vger.kernel.org>; Wed, 20 May 2026 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243984; cv=none; b=pr2HnaVPBiRTccl9JRLW0Cgr58BWb/YhhWVeq6U4MIg1/KOebEvEumtfxf5iEHVYHPdEDLyS2fS/g6i0tUoSpHs/xqN2eKNrRjybi2B1VG5JMjvGgQ9iSq7qWtcv41CygggOP7tsrKonBkA5tNfH9uZbUOJlRzARWdPufgS29RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243984; c=relaxed/simple;
	bh=qgph2ySgRZ9pfWMevX+foTGI/SrfbULxLRXVUG2iRuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BrbjxKjR9ATHsNfBpMpfVnZub66ffFrRP02jQYu5gu5g3PEb0XpbISHwtO8STPX4/lUdyljgXcghUPdRAZ6VEljxlh7BCnV5tpnzrFNJTGjXqDyMLPIAFomLWwpl2MgO6sH0pmfrSiuJLbWjTOMLeKYsHovRH98cCVphbswuEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TXya4Lpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdsoW32e; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TXya4Lpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdsoW32e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C86037A0122;
	Tue, 19 May 2026 22:26:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 22:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779243977; x=1779330377; bh=1UpPflVINS
	T1vdoGKTk6SoIu0RD82loGWEqnM87lFNo=; b=TXya4Lpku0MbaYvS9lAeH3wuZN
	Kt49/pUpV92hw+xKI58AaCWUKCJD65P0zRAonbD+Pip8lirlLRETKXolIzhsfoVr
	kTGD7XUmPekgvh8z1JZDqS2WH3lKtgBPNcKY/rALZSSlauRPyhei7pXsAUZGhpT8
	bDivAk3TUJjIVsBsqSlWw6hUZfwKv8+ftphEkzC8S6sKsa3Zlj+HljvHJHjZlwa/
	hRlBxacJpX18d6sVc2OEfqaQx+3RaioH6yzRCUlaMhC2God45sYX4S4ySRYrA9TG
	VUVGCdgdyvyWr4EY9SgjpgghapDvFbnk91BhpKB8DpcEcA49tJnUBotJbcMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779243977; x=1779330377; bh=1UpPflVINST1vdoGKTk6SoIu0RD82loGWEq
	nM87lFNo=; b=vdsoW32eQGmzRA1kgtB+CL9S51F50po0PeReZSr2DGNnk1JUFla
	T3WMFHUIdvePPLdQ4v1xKu5ONLbrTLQ/K47RViK8KhwqAcibug7ItoWVQ1SgJLLH
	V0SxH/xAUIu4ERRbtZBTVJs2i8LBOeNokJwUYx201fsvLY1B7oYaQyJPpTCamYla
	GvK5dym+I7XK4gYbXrBDxnKuIexZLZcgC1F0lcX9UjE1TVqluH9wlxxDhNWeMetX
	LRTPKJq9Cch57rIeONx2t5bOzgfssjkt0T9UBoZ5qQQ4dQ9hioABIXvvEyN6LNoN
	upWiDPh3+zLXbbSpS7Mup/URU/Rsd9DI6VA==
X-ME-Sender: <xms:yBsNasUnCJ0XQiKGrjq7PY5mENRRMUSm6FpSh5Xdc402CGGeSKWsQw>
    <xme:yBsNaqkKuSQAMvIX7zAw0_tptfSgoUtu8CHE9brOublWWWy7g1-SXjZJ3cgnCCOpP
    vhJr14bQlvDTR-uO1WGAM8S2fx_9OWtVviwoUmahTK_thDQBhpiMQ>
X-ME-Received: <xmr:yBsNanDuZ2w5NacfciK2f5OmMxixnEaSm1jV3DDkc240rLxdi91ybDIEVbp6EdX_OlioSPjsXJ1knEIqwVImewjThPPmxW_o9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtrdhguhhmmhgvrhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtg
    hpthhtohepmhgvsegruggrmhhjrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:yBsNapgjcVj-ZlRiJMA7WI6W1gaaBwOF7Z21iIFYFAsIzgSrlSRLkw>
    <xmx:yBsNakwICnEOfOVUONmjBClHUafcnXGk607uEV_3PN67VDNfMjXptw>
    <xmx:yBsNaq2wfeUlcaiTm4D5cJr_TyB9iCLA_bIVsTv--C9EUqjjl-imng>
    <xmx:yBsNap982Q_7Z1J1PrBU1bRuGDDZIDwZsZeo-YRBuRkhGMhWV2lP-Q>
    <xmx:yRsNats7ku1HhqkhARYjoRvjf0_5VOb9Tw0xPD9yw0rWTzId9V0NaEDX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 22:26:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Thomas Gummerer <t.gummerer@gmail.com>,  Elijah
 Newren <newren@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] stash: reuse cached index entries in --patch temporary
 index
In-Reply-To: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com> (Adam
	Johnson via GitGitGadget's message of "Tue, 19 May 2026 12:43:25
	+0000")
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
Date: Wed, 20 May 2026 11:26:14 +0900
Message-ID: <xmqqldde6cl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  2 files changed, 83 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 32dbc97b47..48189cb9f7 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -372,6 +372,57 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	return 0;
>  }
>  
> +static int create_index_from_tree(const struct object_id *tree_id,
> +				  const char *index_path)
> +{
> +	int nr_trees = 1;
> +	int ret = 0;
> +	struct unpack_trees_options opts;
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct tree *tree;
> +	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
> +	struct lock_file lock_file = LOCK_INIT;
> +
> +	repo_read_index_preload(the_repository, NULL, 0);
> +	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
> +		return -1;

Is this "non-zero return from refresh_index() leads to a failure"
intended?  The old "git read-tree HEAD" wouldn't have cared if the
original index were unmerged, for example, but with this update, we
will see an immediate failure.  There are other conditions that
refresh_index() flips its local variable has_errors on, which leads
to its non-zero return.

Since "git stash -p" is almost always invoked when the user has
unstaged modifications, I am not sure allowing refresh_index() to
notice and barf is what we want here.
