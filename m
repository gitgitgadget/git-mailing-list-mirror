Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEC3AF648
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585410; cv=none; b=Pik1qv3zZHhSAImlVGcVAIBA5xmF9QRMNBbEbhdP8JORf5IEhZfIKDZhiRpdB8/CaCWYRBSiq3U6NWpP6VUXB/nMQvkj7N1uzoNTLVqXqy7/AXoDfRmhVjdy/tyy5fixDNd5BcmT4nXluZcHUbwciNe+EIcDHZO4dLbIjl4wCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585410; c=relaxed/simple;
	bh=etC8gNp2L+SADGqp+g64ZrvuI4HzBX9qtUrNOcFNgPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMp6WStunHLYlH4mf347/4hXPMHGx2ZHrQ0ts6JevpzxuP89TdlS7SYr/B3oTn72xhH9OXkpL1GgoHxrUAzJEG588KSomb32GyLRtgblqB9iVdZ/ppypgfcX+FWVOWR+uAYLRY51xyeu9exbgwOfE3jBWpOaZ/n3pomHCImUgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MGZhmObb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIli5da+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MGZhmObb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIli5da+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 09BB1EC00DD;
	Tue,  7 Apr 2026 14:10:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 14:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775585408; x=1775671808; bh=RSxZb7D4Mf
	pll7BzWW3L/K+Wbg7kWvRBPaArBOY/Gi4=; b=MGZhmObb52eHdm+ei4W45/mtHy
	Q4RAXJGAaicEAz+5ZU+A1TCETjzdfry3wgfsvygh5HUyLS6/GvX+mhOjksmbFdpc
	AFGOC1KtG83QlPEpTtjHfrD1a3j8Nv2w8iVUgwDlpjIUU+fc5f5PvVGGEzYw2Z3P
	nTW1ZlpCzLIHPxOKao8zb+FLHVLg5LThfQIO6VNV8GZbsyBS0sRyKr/FYZSyDLch
	P+u81OdAPqdMKLXur98WVDqSr6Hg9fBWoB5M+hSxR1YihYpwH3+o7piAPxnqoqAk
	3kqc2rb4LZK3twyOe0FPEaJ5LmRv6rLeyociX8o9MdyFVI0Gl3MpSxTDC89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775585408; x=1775671808; bh=RSxZb7D4Mfpll7BzWW3L/K+Wbg7kWvRBPaA
	rBOY/Gi4=; b=FIli5da+vMaRSukIYzuJbVn2LtP7gqM1X4uGWohBzpOlbhqvtQz
	AVDVXul8ap7Px2IztzYRseQMvqKe1iP46jKQAu6HQWV7Fw7laVKg0fXrI85x2dHc
	6EU6+9ewWZgNsGJiWnd3P/BOVGjVUkBViHMEDZrj0r9fPNTtErpS1pmqFQ7KPE6c
	d1D7J8HPTEHBYHVpQm11QnJnTlId1Vsk5qzhZNyW2rk9uB3wlJuj9BNgzcTyKks+
	WAm6puPLJh4EBhFQVBZzhVVyfRZbNrkVNyrQdnpXzyjJ1z/G7fkUtrzM0DdBkKil
	BvMV1PoScJ2fdy7E6oKVT/CUIhOzvc9shGw==
X-ME-Sender: <xms:f0jVabQtc04bMPOWljk_DgfE8EOK5NIhG7218ZoOls8x6Gn0hNWrGQ>
    <xme:f0jVab0oc6pGpc3QQSPu4lSSxFlWIjQr5RwTG5_220tMvM5RUq50vYnfAwtp89XoH
    _7BFqm9Hk12RPxX-ABq4HgJvY3UCwHgR9i22NQvlrAYQ6J3UhVVUg>
X-ME-Received: <xmr:f0jVaXDkahGx445UPgDpRPgLpLJ7UFdjFGwWI3B66T0-y0FKyZI9Q3Mi0TbMySJuenrf7oXrvc66aTfI7TwkvjQ5XV4YvnU2Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorh
    gvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:f0jVaXgB6Z-sIpVgtCQLanEM8iC42C1YvQi4OkjzIWUt7q0G3xrlPg>
    <xmx:f0jVaZP-ZQBzkzyKjg6ctkCeKVVjhe1yblNuWgr5yZzWXhlGMO6iUg>
    <xmx:f0jVaX90YdhPLqkIYkgHHinhu4EK3BIoTjjmn88EPy_vzAQUvOpgnQ>
    <xmx:f0jVaacEALriAYfHu_gBfc6WeIMS0PxlANq5pSRGH3lGiksLkFvyCQ>
    <xmx:gEjVaS3ZsKb_dJqHwgMr4RUBcftXSXi_L8dabuwQEl1Q99j5yX0_wMuf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 14:10:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 4/5] t7700: test for promisor file content after
 repack
In-Reply-To: <8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Mon, 6 Apr 2026 02:25:19 +0200")
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
Date: Tue, 07 Apr 2026 11:10:02 -0700
Message-ID: <xmqqwlyi4p6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> Add tests that checks if the content of ".promisor" files are correctly
> copied inside the ".promisor" files created by a repack.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
>  t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 63ef63fc50..89a2116641 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -904,4 +904,67 @@ test_expect_success 'pending objects are repacked appropriately' '
>  	)
>  '
>  
> +test_expect_success 'check one .promisor file content after repack' '
> +	test_when_finished rm -rf prom_test &&
> +	git init prom_test &&
> +	path=prom_test/.git/objects/pack &&
> +
> +	(
> +		test_commit_bulk -C prom_test --start=1 1 &&
> +		
> +		# Simulate .promisor file by creating it manually
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		oid=$(git -C prom_test rev-parse HEAD) &&
> +		echo "$oid ref" >$prom &&
> +
> +		# Save the current .promisor content, repack, and check if correct
> +		prom_before_repack=$(cat $prom) &&
> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		# $prom should contain "$prom_before_repack <date>"
> +		test_grep "$prom_before_repack " $prom &&
> +
> +		# Save the current .promisor content, repack, and check if correct
> +		cat $prom >prom_before_repack &&
> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		# $prom should be exactly the same as prom_before_repack
> +		test_cmp prom_before_repack $prom
> +	)
> +'
> +
> +test_expect_success 'check multiple .promisor file content after repack' '
> +...
> +
> +		# Repack, and check if correct compared to previous saved .promisor content
> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
> +		test_grep "$prom_before_repack1 " $prom &&
> +		test_grep "$prom_before_repack2 " $prom &&

This test seems to be flakey.

  https://github.com/git/git/actions/runs/24095497271/job/70292906676#step:10:5274

shows that $prom gets two file names, and because test_grep is
expecting a single source to grep inside, the first test_grep
fails.

