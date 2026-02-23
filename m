Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117103033E6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862097; cv=none; b=uWHstg97b/R9bFrJR3VtCSAqnpSjyYA6n3kez/aPHmZUInR+NWaaJt+W0vz5+QQlUT59tWnXlhCVheGEq1L5ZjkhoDxncvp+diAAaG+j5Pr3TwuuIldIGykPHFdHM4PQBV2F7ifrko6iiNxHlDiN4OkBwDfXJPi5H1nxy6xM3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862097; c=relaxed/simple;
	bh=iir8UXRjLUFeuwiaRAlAOtaDEeoUatwrSusQlR87YYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZyXMb/hgMbUNqbrKTvDV4n2kA9kBXbR2QO0Ct49SnjI/IqL16Bl8wzkjXj0bwKwOXUaEtHm2LhNXWIKswaj3UTIgOFWnUf73ky++anlIIh6Qq99GMuY1KxZnsTFNzw1rS6KKpbGKWQoI3Suyw/ZUH4NBhXEOgHabEZXgD3bPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mxzq9Q8l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5US8e8u; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mxzq9Q8l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5US8e8u"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EC42EC0547;
	Mon, 23 Feb 2026 10:54:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 10:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771862092; x=1771948492; bh=zPtsTr3YV8
	tRlnMshJUeZhZmy0cSPGzDKSnah1WMfgA=; b=Mxzq9Q8lKq9AMb+kBfYbqs0Vaa
	/IMj0757QeKikZO4ws3WcXF/tC3TbLcNSNkC5ZK5T8DqBp2KBk5v7MUu5l46bHP7
	p+SX+3w+BsP45McA8S98J6c9uFj1rPZkqwOCuCdxcmWPIncSMmySjW6fzG4M/yu9
	hu0/6XBr1zP3JaneTyxrRq/bV4zk91ndsFQZ49sP2b6UjvASJKgINrGyZNro0zjS
	wsapagKhajAf8Vb4QrTgYJHgMALIojm4HimRgoSCoq1538KrRXFxdcEMDvYLXiYJ
	3CVtQlkPMO9j76ZDH9E5rq6bkyxEMJszrs33s9425RMF1ud6rC6j6SYVHcTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771862092; x=1771948492; bh=zPtsTr3YV8tRlnMshJUeZhZmy0cSPGzDKSn
	ah1WMfgA=; b=l5US8e8uHvyz8ZoipfF3O0wC3XHQU/Bj30cO34chF1GH71RdXDJ
	UfM1kC+vKBu4iTDZa6xbKuTTRfB24B8prYqTnT2srkv+gPgbOQXOwgfHoOSjxh0y
	SkD04icF9bFFrLDOJ4pDjPJQv9GqhkpY+imH6qEVTtJptFacm6eS/ipT6PoA5wDu
	hdJl2u47QtQY7uTNNyFmmSwEeC75Js2ZBFUdm65z+4wiDRHjbBUofmfBRYWWc3L0
	GBfJlHjAOp+FmZnqgv/THqqjOST5GrMCK909yQzPNphkg+z9M8iGD7OmswBB8Cd4
	V+aJggJMvRKCF5l2036gue48ja8xNQUrofg==
X-ME-Sender: <xms:THicaQ4KxAGC1uL7wPYSEUgz8yfDQDlmPTzNvI-16NTWRbbBtSN6QA>
    <xme:THicaY6cl61t3ydsK4ZBe3M-rZqEHWo6Ek_4AU2gnp65mA9Z-KkngEV_xkRU3Ophc
    JKC-ippSs4TBukfSYNtQVcphVE5P5wKA12cGlLWshxPrUrBKRFo>
X-ME-Received: <xmr:THicaUdKBwXgIgQs3TI6-hpDxZmdwai3fRTOjsxwQEVjmNoYPUSyXGgnmx6RBeRzbuxOackoMt46yT5IcDHU6GHns85hGuT0Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgufhgvrhguohhushgrlhgrmhdule
    ekleeshigrhhhoohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:THicaUB4apWG6BYw18bgz8bBQttetDYg49uEr0TqvpCv_hsozmNmQA>
    <xmx:THicaf_on05te5_UFJI4D81RU1vlbXtuKbrmgFP0KSic26UksYT6gg>
    <xmx:THicaXKcFWGaq_GyPGl9MBWkuPOzQsp5NktFT3C0JUITPgX1HF2WYA>
    <xmx:THicaQgcxV1-dzrGfZLRXdi_frSuTG83kFiL0fbBI-d4zWGtajHexQ>
    <xmx:THicaScTts8NXZzauKHyDpH-3Uuvdp4j2qnk5ygfb2iiX2AnkF82CyQ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:54:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Ferdous Alam <mdferdousalam1989@yahoo.com>
Subject: Re: [PATCH] cat-file: fix error and warning message formatting
In-Reply-To: <pull.2052.git.1771836302101.gitgitgadget@gmail.com> (Md Ferdous
	Alam via GitGitGadget's message of "Mon, 23 Feb 2026 08:45:02 +0000")
References: <pull.2052.git.1771836302101.gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 07:54:50 -0800
Message-ID: <xmqqtsv7o3p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mdferdousalam <mdferdousalam1989@yahoo.com>
>
> The CodingGuidelines state that error messages should not begin
> with a capital letter and should not end with a full stop.  Fix
> the die(), error() and warning() messages in builtin/cat-file.c
> that violate these rules, and update the corresponding test
> expectations in t1006 and t8007.
>
> Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
> ---
>     cat-file: fix error and warning message formatting
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2052%2Fmdferdousalam%2Ffix-error-messages-cat-file-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2052/mdferdousalam/fix-error-messages-cat-file-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2052

It may be cleaner to deal with "Not a valid object name %s" that
appear in 5 other .c files in addition to cat-file.c in a single
patch (touching no other messages, just the "Not a valid object
name" one), and do the rest of cat-file.c in a second patch.

Have you audited third-party software that use Git plumbing commands
like "git cat-file" to make sure that they do not expect the current
and historical spelling to make sure this change will not break them?

Other than that, looking good.  Thanks for working on it.

>
>  builtin/cat-file.c           | 8 ++++----
>  t/t1006-cat-file.sh          | 6 +++---
>  t/t8007-cat-file-textconv.sh | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df8e87a81f..a8d564dd6a 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -121,7 +121,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  
>  	if (get_oid_with_context(the_repository, obj_name, get_oid_flags, &oid,
>  				 &obj_context))
> -		die("Not a valid object name %s", obj_name);
> +		die("not a valid object name %s", obj_name);
>  
>  	if (!path)
>  		path = obj_context.path;
> @@ -182,7 +182,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	case 'p':
>  		type = odb_read_object_info(the_repository->objects, &oid, NULL);
>  		if (type < 0)
> -			die("Not a valid object name %s", obj_name);
> +			die("not a valid object name %s", obj_name);
>  
>  		/* custom pretty-print here */
>  		if (type == OBJ_TREE) {
> @@ -200,7 +200,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		buf = odb_read_object(the_repository->objects, &oid,
>  				      &type, &size);
>  		if (!buf)
> -			die("Cannot read object %s", obj_name);
> +			die("cannot read object %s", obj_name);
>  
>  		if (use_mailmap) {
>  			size_t s = size;
> @@ -910,7 +910,7 @@ static int batch_objects(struct batch_options *opt)
>  			data.skip_object_info = 1;
>  
>  		if (repo_has_promisor_remote(the_repository))
> -			warning("This repository uses promisor remotes. Some objects may not be loaded.");
> +			warning("this repository uses promisor remotes; some objects may not be loaded");
>  
>  		disable_replace_refs();
>  
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 0eee3bb878..0283c7400d 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -705,7 +705,7 @@ do
>  		then
>  			cat >expect <<-EOF
>  			error: header for $bogus_long_oid too long, exceeds 32 bytes
> -			fatal: Not a valid object name $bogus_long_oid
> +			fatal: not a valid object name $bogus_long_oid
>  			EOF
>  		else
>  			cat >expect <<-EOF
> @@ -721,7 +721,7 @@ do
>  
>  	test_expect_success "cat-file $arg1 error on missing short OID" '
>  		cat >expect.err <<-EOF &&
> -		fatal: Not a valid object name $(test_oid deadbeef_short)
> +		fatal: not a valid object name $(test_oid deadbeef_short)
>  		EOF
>  		test_must_fail git cat-file $arg1 $(test_oid deadbeef_short) >out 2>err.actual &&
>  		test_must_be_empty out &&
> @@ -732,7 +732,7 @@ do
>  		if test "$arg1" = "-p"
>  		then
>  			cat >expect.err <<-EOF
> -			fatal: Not a valid object name $(test_oid deadbeef)
> +			fatal: not a valid object name $(test_oid deadbeef)
>  			EOF
>  		else
>  			cat >expect.err <<-\EOF
> diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
> index c3735fb50d..3a69b03794 100755
> --- a/t/t8007-cat-file-textconv.sh
> +++ b/t/t8007-cat-file-textconv.sh
> @@ -22,7 +22,7 @@ test_expect_success 'setup ' '
>  
>  test_expect_success 'usage: <bad rev>' '
>  	cat >expect <<-\EOF &&
> -	fatal: Not a valid object name HEAD2
> +	fatal: not a valid object name HEAD2
>  	EOF
>  	test_must_fail git cat-file --textconv HEAD2 2>actual &&
>  	test_cmp expect actual
>
> base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
