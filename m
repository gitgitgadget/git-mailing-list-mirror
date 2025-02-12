Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40509190470
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354216; cv=none; b=Ar+JuVFe0OnPui4i1bhcp4n96wC5VCtx5KV6IBYaekkC1OReUsODUNN1UJm+crxumtQYNRwYrURqO06ujoHrpO1+PZoDLiwDqtEu/xGUQIJfmkrb7Pz4V7IQ5NSxuI8tJ89ds/Wv1/qVlqfWSdRpgOf2z/4MShO6NnJ38D2+V3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354216; c=relaxed/simple;
	bh=TDH033B+4AG+wEpJT7OsUhMjCe8MaM7SjQyR6anl1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0qh9RfiNNuvU08zPZcf0QdP993W50nDNHa5ubR3wtVflXqTstc0pFkH/TPJwctFDBWW2rgUigC2IbU0YIqyfjUcZ9Gr3zHYWB+vnTwnDV08/ik4MpAHe3vAUQx0AJ7dxrz/mauumr2oXbn2mPv5poVKoYRFJ/nOR43mMS/Pa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eA0X90bM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8HRU+nL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eA0X90bM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8HRU+nL"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 410FF1380983;
	Wed, 12 Feb 2025 04:56:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 04:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739354213; x=1739440613; bh=6CYCNGYmjT
	ZvXe6PmQhq9fsCRMHJMHT9hb3O+T4x7ZI=; b=eA0X90bMcb+vtsiLx93sE6JJ0n
	TehhQ3I5ttnpW7CMSLSLufaCz+Ty6TrUrI7Wa9oUtuCI35TRgUI0TVi8KYVwcl6G
	9M5PwAPpT89D7hwcKQ4ErKw2CweoaFADgPOiWYJKe880EkY6P6SQfpy6ueOG+1gH
	9AKWUb2cAiSmxYc66MQTOdaSJqjw/c8ycii1vA/mMKXxqdqcKN3Z3dt834MF7TXK
	+xOfIgBCsOspj2FRHHYV+I/lrWCjh1yIJQa67exeXoNqTvr9uhQ6g4Bq1G215xOY
	hBPf+ZGTp+MYSo0mPNxO0GwJqUX60zQRlGU8FDRmoTSEClsw8eWVKPrI2gQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739354213; x=1739440613; bh=6CYCNGYmjTZvXe6PmQhq9fsCRMHJMHT9hb3
	O+T4x7ZI=; b=Y8HRU+nLj3EOEdsQKY+61m+HeB1uWFmdr1d6ZkxRZS75ps0ThjJ
	XD+BE3WuxnDsU1YxJKSgwOTQ/c7DQqfXUtDTHVILvvqx3QY2tfLiJgEMYWTWKMip
	vHDYr/Y0cXxmahpNxMvhjMhrLDnKfPVK9Y9wLyWwjOZmYNpxFKIW8LygW+Ybbq7m
	7h3mmrFtJzsivqh9SdHYU7/4pppUX14jgDN8hwOCxa1lhQt5fiSe2hMCngkUjjCI
	0hABG/Rhw0iyxe7SeuHi6timQrQruCy2A8hXbmYMtcyDWuUsJoCzJHuGknCyWnbS
	HjcKOHXZ7wJ9lRuZgTl4d3nq0sVXBXNVeAg==
X-ME-Sender: <xms:ZXCsZ98MHtUkY1u9A2u441XtUDCSxmK12H6EhmZzeIgvcT5zTFCSCg>
    <xme:ZXCsZxvx5UT-SOUxA4Buybi1lxgX1IAR65ZBojMF3mpNdho_s-vX-WNPvA_qTKOwW
    U7Q0sWsZxsI5x8COQ>
X-ME-Received: <xmr:ZXCsZ7BCypKQP_RP-SoThoqKCbSLh4ZjT1xUp5Bq5XOjeFzrwdQLE6XugNOHgOlPYIiFoleyElhzhzbcQDeDyrAqa1YG8Jsf4CPI4Du3hszbBxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:ZXCsZxfxK5eCCPnC8r6RlQSG96S5FXpG7Ve4AU7EAjWojLFnvwcQLA>
    <xmx:ZXCsZyMVyEdStEJQDLSpuypbqzU6-V-BRWp1j5On4JrKejcS7ZzXlA>
    <xmx:ZXCsZzkOWaoucI1HGKvaSYY5Y-s05ucWHG1nB1qSYtkg2DppgK0Y7A>
    <xmx:ZXCsZ8vV24fKe-N1peA8Z-lopZ3EKX8GIS3b-KnNCC3wCiw1i9X-ww>
    <xmx:ZXCsZ51G62EroxHjAY4xQJLs2Yzgl2uKgSDYy3X5sydj3Uqf1wl_MpcK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:56:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0bca964a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:56:51 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:56:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 6/8] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z6xwYlYFzbn3ft8u@pks.im>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RPzIGD-fSwIEPV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPzIGD-fSwIEPV@ArchLinux>

On Thu, Feb 06, 2025 at 01:59:40PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index c8bb93bb18..658f6bc7da 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1826,6 +1899,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
>  		line_number++;
>  	}
>  
> +	while (start < eof) {
> +		strbuf_reset(&packed_entry);
> +		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);

Instead of greedily computing the name of the line, can we pass in the
line number? The motivation is that in a well-formatted packed-refs file
we won't ever need this string at all, so it's wasteful to proactively
compute it for every single line.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index da321f16c6..3ab6b5bba5 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -664,4 +664,46 @@ test_expect_success 'packed-refs header should be checked' '
>  	)
>  '
>  
> +test_expect_success 'packed-refs content should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +		git branch branch-1 &&
> +		git branch branch-2 &&
> +		git tag -a annotated-tag-1 -m tag-1 &&
> +		git tag -a annotated-tag-2 -m tag-2 &&
> +
> +		branch_1_oid=$(git rev-parse branch-1) &&
> +		branch_2_oid=$(git rev-parse branch-2) &&
> +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> +		tag_2_oid=$(git rev-parse annotated-tag-2) &&
> +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> +		tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
> +		short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
> +
> +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> +		printf "%s\n" "$short_oid refs/heads/branch-1" >>.git/packed-refs &&
> +		printf "%sx\n" "$branch_1_oid" >>.git/packed-refs &&
> +		printf "%s   refs/heads/bad-branch\n" "$branch_2_oid" >>.git/packed-refs &&
> +		printf "%s refs/heads/branch.\n" "$branch_2_oid" >>.git/packed-refs &&
> +		printf "%s refs/tags/annotated-tag-3\n" "$tag_1_oid" >>.git/packed-refs &&
> +		printf "^%s\n" "$short_oid" >>.git/packed-refs &&
> +		printf "%s refs/tags/annotated-tag-4.\n" "$tag_2_oid" >>.git/packed-refs &&
> +		printf "^%s garbage\n" "$tag_2_peeled_oid" >>.git/packed-refs &&

This can be simplified using HERE docs.

        cat >.git/packed-refs <<-EOF
        # pack-refs with: peeled fully-peeled sorted 
        $short_oid refs/heads/branch-1
        ${branch_1_oid}x
        $branch_2_oid   refs/heads/bad-branch
        $branch_2_oid refs/heads/branch.
        $tag_1_oid refs/tags/annotated-tag-3
        ^$short_oid\n
        $tag_2_oid refs/tags/annotated-tag-4.
        ^$tag_2_peeled_oid garbage
        EOF

Patrick
