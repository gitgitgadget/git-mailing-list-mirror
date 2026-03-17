Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507A23D28C
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776384; cv=none; b=KamDhkE0MMqUzeKr2vcY7/nUYHg2H1krAVTPnAvsPOVdoP+/J8ZCHD8CWAIP5i22W0FrP8HUqCWBT7yBUvKT/J1Uq9cUnVIjiuTaUO2FaVm751Om8cNgsc1FSLtkGc0OAIoqvSzindfHRd3ozB1aPHZiPnXOrQ4qpdElz8TNseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776384; c=relaxed/simple;
	bh=kPiG7ZNKyoOv04q4S3YsgeGqo7ZQZaQXYS1AZjihnsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhDTWU7Cfd9238hsQD8sZUBaS04ULW/OJw44mK2JGt6H/vNxFmmRRAAIcHDDOF3fasu7fP2wRLHOJjGMvGw9WmNoHBNgwJfg6Hvrhk6ADDvpPcnFhLSUIyO9ZiQFXHa5MZTeRdBJl8VZ89e6oQsalC9dG+ezLNgL07s47s8vKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V3Fg/u1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpoXTV/i; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3Fg/u1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpoXTV/i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 004681D0017D;
	Tue, 17 Mar 2026 15:39:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 15:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773776381; x=1773862781; bh=OwAo19VjlX
	fpDz0tFKpNd2DTiqqZ3a+bqaOs+oo+Bo4=; b=V3Fg/u1u996BSizZghZB8MSgWH
	9v0i2ak74/ChChGhwc0Z11DQBOjPlIsWPDFD5Yj0K0QOOklrq5mG/qpQfd2okFm/
	c3+W6SA9E6RNzDQW56ndliGzltV7a0oQkZVbbjze8jAqXNUiKMkExAvl3dyC39D5
	AfJHro29yP5Rkm8VGgYwcpPzMX5tlgPPUFMnLXfazCmmRUtBv2SRgviIo3hQxcyt
	FISe+EDzz75m+Zhd9yo1Fx6LlyOgSy3lQTtmzXzDsjkQbaibo/yYs3cKAO6VKdoq
	5eT9wQqm2zanEVR5kEOGDT8s/LjZINW2LNlwH6qK3cEDL+wubdnwqOUlP7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773776381; x=1773862781; bh=OwAo19VjlXfpDz0tFKpNd2DTiqqZ3a+bqaO
	s+oo+Bo4=; b=rpoXTV/iKh+Z7DxzvX7JzvTAwheWEkeg6Cs8OLbUsiG3ZhWP39J
	FxGuBJxVlUcdFN+Be8vkutp2dbj5TFWP2jm1hkz4/lhdJTuT9i5OTWLIvlL5+jJh
	PF84e2ya0mNvkZKhWlnmFe29NxHSg5luJeNzA+0rXz+E8gD99xIcZek9m4LPTJ0P
	URo3l8MJ2lt3BHG005+CZoSk3uR4dJExEJf14WJ4N5DHHmZB8zSAIeuCYlUbnlNR
	H5/cl+w1JccK0TdRobBH4JiqmTwDAyLKYH/DozaVUL8WKgJYz6qrB6kmJMQL6rhU
	sFh6rXrfNeJVQx9E6OBP2OtfHGqZe7w1yCw==
X-ME-Sender: <xms:_a25aeluovh4t80HTdGz2Elc0RyJTMB_6VZZ7lC-SciIpbVtpFcROA>
    <xme:_a25adSGbMv6_CIBGJbrzNoWurHssngm_T400m1pPkVnGuT0jCxtH5ahm_6KKnhPy
    jv_Ap-F-m_U6cmxxSrq2OsMTPZ09HdJEfFNc3WtgzGYBkVEVrRssw>
X-ME-Received: <xmr:_a25aaDoRXYsEVtSlcdqIXZ2wymYLE-xceWhQ-YiwQmCKSmpwJwEX8rxaVKSFyTF-RDu2la-A30nWWJ0LODtMluEQ8KXMhRS6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteehffehffektddufeejtefhteeiudfhgeduveegleehgfeiieeffedugeej
    ffegnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_a25acRPDkfxZoDG54F1tP4dRSJc-P5YeVV_sRXUe2x9nctEF273sA>
    <xmx:_a25aQqK0wfivt2kAYF37pToMP5x5oBSqhc8rdCm-oTAK-PvWHgvUQ>
    <xmx:_a25aWxD4FpYJsRr-FjeHDnm5tONzQQ0SVoYMOUyAspst6R_NQlzNA>
    <xmx:_a25adLGcmubY7iIqFJkGi1igBR-oV1_P-8vY94R0-nEc6ANQs12LA>
    <xmx:_a25adbut7oGpporho6FFeyUPczXCMC5uIcycZNOMwqqCJt_2-hI12HD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 15:39:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix writing generations with dates
 exceeding 34 bits
In-Reply-To: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
	(Patrick Steinhardt's message of "Tue, 17 Mar 2026 20:02:52 +0100")
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
Date: Tue, 17 Mar 2026 12:39:39 -0700
Message-ID: <xmqq341ykzyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this fixes a regression recently introduced by myself in 024b4c9697
> (commit: make `repo_parse_commit_no_graph()` more robust, 2026-02-16).
> The regression was found by GitLab's tests suite, see [1].

Curious.  GitLab's test suite runs pretending that it is way past
year 2600 or something?  

> [1]: https://gitlab.com/gitlab-org/gitlab/-/jobs/13522328632
> ---
>  commit-graph.c          | 31 ++++++++++++++++++++++++++++---
>  t/t5318-commit-graph.sh | 20 ++++++++++++++++++++
>  2 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f8e24145a5..7e293a1775 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1319,6 +1319,31 @@ static int write_graph_chunk_data(struct hashfile *f,
>  	return 0;
>  }
>  
> +/*
> + * Compute the generation offset between the commit date and its generation.
> + * This is what's ultimately stored as generation number in the commit graph.
> ...
> + * actually end up storing on disk, and hence we have to mask all the other
> + * bits.
> + */
> +static timestamp_t compute_generation_offset(struct commit *c)
> +{
> +	timestamp_t masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
> +	return commit_graph_data_at(c)->generation - masked_date;
> +}
> +
>  static int write_graph_chunk_generation_data(struct hashfile *f,
>  					     void *data)
>  {

The code and explanation are both in line with why we want to do
this change in the proposed log message.

> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'overflow chunk when replacing commit-graph' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		cat >commit <<-EOF &&
> +		tree $(test_oid empty_tree)
> +		author Example <committer@example.com> 9223372036854775 +0000
> +		committer Example <committer@example.com> 9223372036854775 +0000

This timestamp is way longer than 34-bit for sure.

100000110001001001101110100101111000110101001111110111 (base 2)

> +
> +		Weird commit date
> +		EOF
> +		commit_id=$(git hash-object -t commit -w commit) &&
> +		git reset --hard "$commit_id" &&
> +		git commit-graph write --reachable &&
> +		git commit-graph write --reachable --split=replace &&
> +		git log
> +	)
> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the

Will queue.  Thanks.
