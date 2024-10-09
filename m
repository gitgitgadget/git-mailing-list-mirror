Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539C152E1C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496304; cv=none; b=iAfuYkZl2UepXkKYrdydlj7KlNAHxU2EazgnK/gW1HSc7BEezsUIMRxPRsewEEJ5z3QNsToczCv0Lz6GwnaSLuNaHL/0L+pgBhmKHCM4Pqh3y/PGhsBeDtlunLBGfe3ZLk5X6SiTnFHlbkTo215SvsEX7KMtP+UoHpFB7NKZjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496304; c=relaxed/simple;
	bh=/7BslQ6cum76bLdLnwpgtH0XoqVhAk2VnZLVzom3Ips=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvSYSvFUoiu8+ulv1BbGpYB1Pi32mOCAHYp+DDo/MHieoo/DtCRKMQGsyxgyWdIm4IJdpPcw91PSOGXTFQQ2CiLrccJah3NtkosGyk8XOC15BnI1Rlz9vOL97OHNxm1wV6K97eoCug7cnYC0IXXIrcDHV3IV6qubTW0rrCGRZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V1iJrwyC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjkEJLsu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V1iJrwyC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjkEJLsu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CDB51140151;
	Wed,  9 Oct 2024 13:51:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 13:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728496302; x=1728582702; bh=IljVCY+zOW
	5v1GaN0Nd60X5iBDMs2dFtbQOcl2kqhk8=; b=V1iJrwyCZYFHY8FH+9EAYOYvp6
	ZzltQe2J9hQ4Lu8FsvpsJ2Smzb/K8jPMh3kfgjPRLyST0KM2EEe2wXKYYfyz250f
	qZqwEuAho3eWQ3HWSAKG9O15QphjWNntK0FD+hbBf43teE/xpBV+ixH7qhbqEF0n
	wLsJ07ZQ2M4aRZC7x2idUn5/FuUDL7AQBYIk7W26XE1o8+upRCeO5NGTvKjDSHXn
	Tkqy+uUXAlk7tWSQDsl1PQxD9kA/GYUBiQ89YPyHVQMEuSWo6+GOUtxpMOKc0zTo
	/71Q1SflbMN9lRKqZoaQQXYyOGAaUo3263UnOjtIyMwbEibBVcXbkX7rFK7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728496302; x=1728582702; bh=IljVCY+zOW5v1GaN0Nd60X5iBDMs
	2dFtbQOcl2kqhk8=; b=QjkEJLsuzCAa7bbdDOLMtLIUyIK2GspHulfYn1Y9dMTG
	Gi88++tgp2IWOK0/YSpLHN3LXhrFWcZ4CCOQBidswYqY3CxiXMaFfy2WMHel5u+4
	wOcIuQPCYK1pRsGpU8a/E238VLelhnv11gRX8eOeDwg32uonoA7zWfYWTscTbrZp
	tvVeryEG6UgqRNFUCBiF681+PZyu+2hiFOJIWFDdD/SsrtF4CFf9M7e9Y5beUIbv
	QrXnXQp+rCgbsMBudIIBWIv0oJygAA1ueUrs/ev6NLVC2S1b3VA1V76kRiV+mC8x
	YXFL+LE0CRMyRT3hgrDvBlZhWdWbuR0vkO7ktgHhog==
X-ME-Sender: <xms:rcIGZ8FettPjk2ETw5yIWXJpwA9tP8XHsYTIqTqrwQog8tu8UH2KxQ>
    <xme:rcIGZ1Xaqf3aiacFaH7zPvvtE4k4Uw1oDcaqmkItw_fJAv3hJCoRWuy-MY8Ej2LrE
    yvut3WXLXXOZlts8g>
X-ME-Received: <xmr:rcIGZ2KsNo_kI5C38xv4OD8FCZzhdvXDLpl15tHPDGrQzP8W9M0IrNBP0bhc32_0Hg5IN9yaFapKcHKnJG1Huz9Tj0tK8a7ON0qK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrnhhivghlsehmrghrihgruggsrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rcIGZ-HdYkTJ9PWbyslemeKrBzKNwsgHssiIpbVYeQjU1cbYJ0wMoQ>
    <xmx:rcIGZyVjINcUmJq_Kx8w7V2AUcXhiDpDaJE4NOrIUiOXlQ4TymiJSg>
    <xmx:rcIGZxMR4K4OqgGditZ3tN4-jgmwe2XspS9JtNTk9AYFuuuXXrLtPQ>
    <xmx:rcIGZ53o325Xd67mKMbm6n_003-Pgne6YYOs_oC-GIgmscS4Bcz-YA>
    <xmx:rsIGZxRm5N9L1ckHGMwExOgRlzbRmnFy8U-upVCObA9GjrWtBb7FhAq0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:51:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel Black <daniel@mariadb.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] submodule: correct remote name with fetch
In-Reply-To: <20241009033257.1316690-1-daniel@mariadb.org> (Daniel Black's
	message of "Wed, 9 Oct 2024 14:32:54 +1100")
References: <xmqqzfnez9dv.fsf@gitster.g>
	<20241009033257.1316690-1-daniel@mariadb.org>
Date: Wed, 09 Oct 2024 10:51:40 -0700
Message-ID: <xmqqv7y1tb9v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Black <daniel@mariadb.org> writes:

> The code fetches the submodules remote based on the superproject remote name
> instead of the submodule remote name[1].
>
> Instead of grabbing the default remote of the superproject repository, ask
> the default remote of the submodule we are going to run 'git fetch' in.
>
> 1. https://lore.kernel.org/git/ZJR5SPDj4Wt_gmRO@pweza/
>
> Signed-off-by: Daniel Black <daniel@mariadb.org>
> ---
>  builtin/submodule--helper.c |  9 ++++++++-
>  t/t5572-pull-submodule.sh   | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)

Excellent.  Will queue.

Thanks.

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index 916e58c166..9b6cf8d88b 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -230,6 +230,7 @@ test_expect_success 'branch has no merge base with remote-tracking counterpart'
>  
>  	test_create_repo a-submodule &&
>  	test_commit -C a-submodule foo &&
> +	test_commit -C a-submodule bar &&
>  
>  	test_create_repo parent &&
>  	git -C parent submodule add "$(pwd)/a-submodule" &&
> @@ -246,4 +247,23 @@ test_expect_success 'branch has no merge base with remote-tracking counterpart'
>  	git -C child pull --recurse-submodules --rebase
>  '
>  
> +test_expect_success 'fetch submodule remote of different name from superproject' '
> +	git -C child remote rename origin o1 &&
> +	git -C child submodule update --init &&
> +
> +	# Needs to create unreachable commit from current master branch.
> +	git -C a-submodule checkout -b newmain HEAD^ &&
> +	test_commit -C a-submodule echo &&
> +	test_commit -C a-submodule moreecho &&
> +	subc=$(git -C a-submodule rev-parse --short HEAD) &&
> +
> +	git -C parent/a-submodule fetch &&
> +	git -C parent/a-submodule checkout "$subc" &&
> +	git -C parent commit -m "update submodule" a-submodule &&
> +	git -C a-submodule reset --hard HEAD^^ &&
> +
> +	git -C child pull --no-recurse-submodules &&
> +	git -C child submodule update
> +'
> +
>  test_done
