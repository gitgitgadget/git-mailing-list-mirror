Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849028CF7C
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437042; cv=none; b=pEwDKovgrys4V+afJ9nbm+MEjSCSz4yyQkJon4Z7oS7yRpr+gisppIKa69eA5cKTwFFeBohcfQGIxeuUMDWrYY/ARU/ztb5M2xbhQfD5C4Y++vUXYh/r1otRHzQkdL0ZuTItoYVFlFb7hAr+Oq1+ISYChy9EiRXXWQXTmi05rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437042; c=relaxed/simple;
	bh=h72GAKzP6wK0y+pPMg04puOUHFbDH8T0HbUIsNdayEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POB/gHpUltCKpg5PkSihzoJi6uK+AsRGp4U4e8yysxTONSlhZgNWp2fJtun4dduNfnTkzggAkab5hUxr//ZGgX0GRRp6ZuaZpl6MBb69zd2cUAzXqnwLZsEXUr3iUeh8XtfjXoR85TKtZR31yFAaCwybozZQpGiufJ27TGSxY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HoacIcCl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAj75MX7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HoacIcCl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAj75MX7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56E92114021B;
	Wed, 23 Apr 2025 15:37:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 15:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745437039; x=1745523439; bh=GtwdiJH3OF
	jsmPnUx+E3OFzU3+ABqdNSBo8UXg9rFVI=; b=HoacIcClksBK7er8BeLxcza5aF
	YGT8lS6EvRFWJBOo4qDF++Ms614GBxcuHgisBjTr/B9sTx06+Hcnk4rinMUZrgJ5
	pq+Y8/H8BeBqZCU9B3OHCsGi5wjQSP25nldKIf7xaidI+dTxl6ZYDu0DokBNSVLA
	pcn00wxqjURvymJ0idjkmxk91r1uG61TzRjfGDkPfKROTs5ocXP4NIjWz/FlQ5U0
	jdE/m6yUip6Pr4Xcz3L0mZlggnK18iAoxuKl0+6aH8p5Y/WRQF4Pfi8U0odM4lkQ
	ZasABNW6z8Y4dtOpRsyvd0lDkAvKy2e1b8VE8T44BI6pOG3wDlQtd97QeyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745437039; x=1745523439; bh=GtwdiJH3OFjsmPnUx+E3OFzU3+ABqdNSBo8
	UXg9rFVI=; b=PAj75MX7SVzgvJJLbpLAgQee6IgMj+uMN5b299lZaMN4S6ihulu
	ffihoH1OKU7VdaH+ILWKYh8hmn1XmU729PS4RlKE5kgExB70C6yTzbgWa9TOizSO
	cbGX6nWxx/Nur97dznR6sRM24vWKm76dsv2vZzads68yVyLvn4j96Bg4foBFTS1F
	AaJGnXsGtFA6YZiKifccXZuny8ZL/qWR5ooTEwXJzeoRDEYiWxB0r47jlaY6lCIs
	H6SKZ582sCFc5KzNjuFfkJq9uj3jIfdkG4mZNu1KJAieXp8b5Vqz4XkVy1B6vcf6
	vi9cUfj2jYOUdAz4wgIdPvHNK5eb0066LVA==
X-ME-Sender: <xms:b0EJaEB-rwcjSgg-mudT2lXtdZJXnAe6xdEN-6-NTC65-wMhWg_31w>
    <xme:b0EJaGhdHBxPbEwKb1AyVxxBBt-Uj8nfxWRpwpNyhjcleTzHTlRZ5B2qsn0HOeq8l
    FUfhXupAVKhshw6-Q>
X-ME-Received: <xmr:b0EJaHmNP7ddSvyzah04Rdlxf666uUg7ke--JPzFz6gjvHnD4rBZiIfZr55AUALmNHlbB2yeJlTmCIiwaaYaXGyL3X3vL7TXw-qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:b0EJaKxemb2ROjf8jRV_lredHKN0nnrzgUIAhxKUezj4J0EKtZY_Gg>
    <xmx:b0EJaJSbLzCULGJH_IU63x6ORdiz1tOTY9RYgOQ-oLh21gmYz-of9g>
    <xmx:b0EJaFbSYo-p4dZGM1tNrQm0BRobHgpuOPB9_GaA3H6boWd88pKXuw>
    <xmx:b0EJaCRk8sNfNQ5x_urVrE5hjd5G-SdDojHcljpAeydLjBA5y_UI5w>
    <xmx:b0EJaKuF0Qqosuw-fgqgI3PE9U27Rzg1YXf0W2j3_lHYzkURtALmSbxC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 15:37:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] t5309: create failing test for 'git index-pack'
In-Reply-To: <a9430447641ff3b3f519abc0960b6741fd7df700.1745430004.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 23 Apr 2025
	17:40:03 +0000")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<a9430447641ff3b3f519abc0960b6741fd7df700.1745430004.git.gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 12:37:17 -0700
Message-ID: <xmqqfrhyy8ia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> This new test demonstrates some behavior where a valid packfile is being
> rejected by the Git client due to the order in which it is resolving
> REF_DELTAs.
>
> The thin packfile has a REF_DELTA chain A->B->C where C is not included
> in the packfile. However, the client repository contains both C and B
> already. Thus, 'git index-pack' is able to resolve A before resolving B.

In order to reconstitute A, B is needed (which recipient has), and
in order to reconstitute B, C is needed (which recipient also has).

The index-pack sees delta based on B to recreate A; it should be
able to reconstitute A using B that already exists.

OK.

> When resolving B, it then attempts to resolve any other REF_DELTAs that
> are pointing to B as a base. This "revisits" A and complains as if there
> is a cycle, but it did not actually detect a cycle.

That's interesting.

> +test_expect_failure 'index-pack works with thin pack A->B->C with B on disk' '
> +	git init server &&
> +	(
> +		cd server &&
> +		test_commit_bulk 4
> +	) &&
> +
> +	A=$(git -C server rev-parse HEAD^{tree}) &&
> +	B=$(git -C server rev-parse HEAD~1^{tree}) &&
> +	C=$(git -C server rev-parse HEAD~2^{tree}) &&
> +	git -C server reset --hard HEAD~1 &&
> +
> +	cat >in <<-EOF &&
> +	REF_DELTA $A $B
> +	REF_DELTA $B $C
> +	EOF
> +
> +	test-tool -C server pack-deltas 2 <in >thin.pack &&

This is minor, but I somehow find it easier to follow without the
temporary file, i.e.

	test-tool -C server pack-deltas 2 >thin.pack <<-EOF &&
	REF_DELTA $A $B
	REF_DELTA $B $C
	EOF

> +	git clone "file://$(pwd)/server" client &&

This truly loses A from the resulting "client" repository, but the
history still can reach B and C.

> +	(
> +		cd client &&
> +		git index-pack --fix-thin --stdin <../thin.pack
> +	)
> +'

Makes sense.
