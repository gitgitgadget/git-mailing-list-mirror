Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053491E1C0B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496053; cv=none; b=XHFwpU1yUm0gdggTCD+bdB8V1bUGFPrlkiTbG/nmzYPEVDcpAZ1DbbQbRW0WQ8AeN318++/MaiT5UFhORxHk+TwORmWcGoBjhRm1O9eh1xdNN5VtPEpgyVVFgkoNbX7ZEdngJ/OTkFKNBznqmEbOkAPfhNUP76vxubA0QkcPYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496053; c=relaxed/simple;
	bh=ZeAw1ly83LxCtDcXUCy6UEGfImFY8yTuGmXOZQN82Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mNp1T223M2lWqFaXBH21yXxsoXhmJvElKi4Mg/9AhJjj02I/gKEi2tt4VbE0GYodv9OWKuJKFxkwTNdMB3i0UuIcyi+lFbj1KqFPdiBKlhf4x01s98vNhSPw6EvZW9d3rq61X8W+mtfHs9cpDLaPBPnSgexV2UqUVMsSV3Uu6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rB7/qCOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qk5+sZ+Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rB7/qCOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qk5+sZ+Q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 37D9F138021D;
	Wed,  9 Oct 2024 13:47:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 13:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728496050; x=1728582450; bh=QuSz1gJBsv
	QPZREZ31IWroq3jKKuUU0zcpkkNH7YLM0=; b=rB7/qCOH8HNBN7+1mD8FZA4DmI
	xyyiOsEHvC0tAWGE71rz+PtSUedCFO8Xuvia+/V7Ss/+OkN4jTQ31VezkepWFS2i
	LTSRjRc6AOHjAqyInnEqRWBlL8kg9+Fr7OdYd9nL0b5GxlaMISVHi9CJdFkCcQ7k
	uJR4b88Yjp7wtIeiOhpsjN5DXRSi4PTll58KkepEM5ixka1od6PBJwc2y+8F0k9h
	gS4FXAGAjfcZymJI4Mmkj0/CS/3gaGBYBsz04IV1ctYITmz+fO2u0+2d1SDSaBLo
	A4bCr7coA6l1hUuxgp0WGA1+DPEhgFc2fWEqgyin1XADWpW/5EOtqSosm/OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728496050; x=1728582450; bh=QuSz1gJBsvQPZREZ31IWroq3jKKu
	UU0zcpkkNH7YLM0=; b=Qk5+sZ+QgOk9EygZWO07uwJkGbo3vjawIo3JRVV3c5Tj
	eWxnVQbQgSCDiiw55rm7p+xTUNNWH4qbg3IUJ9twgZDHnLsFv709LUkkZ5uqgZGn
	5CvzRzY/5SXUpW8w5nUG3NPg09w/4ntiHYiPd/BXq5HPJlJC17WIMn3VuA+pPgSo
	tGKYm7KL2l9jvY8D6foM0oDkBINn0dYQ1zCdzYD6/w+O5gSABbTrFQVhfTxSDtuQ
	MfmePel4UyTpnTeYkjJ9wqGgfPselWPWRRk+NLTz/a+7reVonHsGqcU2oEUTI5TX
	qfucUMHT5eF0ZB8FAW5bSzyjXzQvv6COdw4pFs+DnA==
X-ME-Sender: <xms:scEGZ5gxVhZ_bVT6wQwjrMf-7zaXD7Orw_WjsuZ-CFKoz_yIda437w>
    <xme:scEGZ-DJV8P6qSBhAMnKXZw8dyYbF93q2DF79nIUKiEkFLIpK4hO_44cCAbKBQMnn
    siaI5QETTHE5DBLlg>
X-ME-Received: <xmr:scEGZ5GMoF28lcga9dtBWpY9sDgxmjaz1E-IV6KnLxONeJY9Qb_da3EN7jAgIt3efBaPxhGmp9Bp2-um9vNyqAGfHHkIzOeSiO3x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrsghrrghh
    rghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:scEGZ-SLNbSIAeVcJ901MnmkSBX8Q-t1Dxp2PlqCDF8SS7-1g8gNug>
    <xmx:scEGZ2ws78Dql1-BovgBH7ZRwrwTUM1dKKMmW3tGc_UIyQ-Zkdfsww>
    <xmx:scEGZ06ONSRmcscKJev7iHMhDJfLnohaHHg_fHrzoSYEHsB_abDmmw>
    <xmx:scEGZ7w8Lc9Etk9dO-Nh9N0t-9TAdfeX0q-noAMRWS6Ifz9UAImNgw>
    <xmx:ssEGZ9ksk3zPz9JtkbzhmF3U-WxOCTxXW5DkpynfcJ8vBLriq54due-3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:47:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Samuel Adekunle Abraham
 <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v3] t7300-clean.sh: use test_path_* helper functions for
 error logging
In-Reply-To: <pull.1811.v3.git.1728493350545.gitgitgadget@gmail.com> (Samuel
	Adekunle Abraham via GitGitGadget's message of "Wed, 09 Oct 2024
	17:02:30 +0000")
References: <pull.1811.v2.git.1728390135644.gitgitgadget@gmail.com>
	<pull.1811.v3.git.1728493350545.gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 10:47:28 -0700
Message-ID: <xmqqzfndtbgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> This test script uses "test - [def]", but when a test fails because
> the file passed to it does not exist,
> it fails silently without an error message.
> Use test_path_* helper functions, which are designed to give better
> error messages when their expectations are not met.
>
> I have added a mechanical validation that applies the same transformation
> done in this patch, when the test script is passed to a sed script as shown
> below.
>
> sed -e 's/^\(	*\)test -f /\1test_path_is_file /' \
>     -e 's/^\(	*\)test -d /\1test_path_is_dir /' \
>     -e 's/^\(	*\)test -e /\1test_path_exists /' \
>     -e 's/^\(	*\)! test -[edf] /\1test_path_is_missing /' \
>     -e 's/^\(	*\)test ! -[edf] /\1test_path_is_missing /' \
>        "$1" >foo.sh
>
> Reviewers can use the sed script to tranform the original test script and
> compare the result in foo.sh with the results of applying the patch.
> You will see an instance of "!(test -e 3)" which was manually replaced with
> ""test_path_is_missing 3", and everything else should match.
>
> Careful and deliberate observation was done to check instances where
> "test ! - [df] foo" was used in the test script to make sure that the test
> instances were expecting foo to EITHER be a file or a directory, and NOT a
> possibility of being both as this would make replacing "test ! -f foo" with
> "test_path_is_missing foo" unreasonable.
> In the tests control flow, foo has been created as EITHER a
> reguar file OR a directory and should NOT exist
> after "git clean" or "git clean -d", as the case maybe, has been called.
> This made it reasonable to replace
> "test ! -[df] foo" with "test_path_is_missing foo".

This is a good place to stop (but perhaps have a paragraph break
before "In the tests control").  The "examples" you have below is
like telling readers to go read the patch and verify the correctness
of it themselves, which is not adding much value.

Other than that, looking very good.

Thanks.


>  t/t7300-clean.sh | 370 +++++++++++++++++++++++------------------------
>  1 file changed, 185 insertions(+), 185 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 0aae0dee670..5c97eb0dfe9 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -29,15 +29,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so &&
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so &&
>  	git update-index --no-skip-worktree .gitignore &&
>  	git checkout .gitignore
>  '
> @@ -47,15 +47,15 @@ test_expect_success 'git clean' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -64,15 +64,15 @@ test_expect_success 'git clean src/' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean src/ &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -81,15 +81,15 @@ test_expect_success 'git clean src/ src/' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean src/ src/ &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -98,16 +98,16 @@ test_expect_success 'git clean with prefix' '
>  	mkdir -p build docs src/test &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
>  	(cd src/ && git clean) &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f src/test/1.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file src/test/1.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -163,16 +163,16 @@ test_expect_success 'git clean -d with prefix and path' '
>  	mkdir -p build docs src/feature &&
>  	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
>  	(cd src/ && git clean -d feature/) &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f src/part3.c &&
> -	test ! -f src/feature/file.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_missing src/feature/file.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -182,16 +182,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	ln -s docs/manual.txt src/part4.c &&
>  	git clean &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part4.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -199,13 +199,13 @@ test_expect_success 'git clean with wildcard' '
>  
>  	touch a.clean b.clean other.c &&
>  	git clean "*.clean" &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.clean &&
> -	test ! -f b.clean &&
> -	test -f other.c
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.clean &&
> +	test_path_is_missing b.clean &&
> +	test_path_is_file other.c
>  
>  '
>  
> @@ -214,15 +214,15 @@ test_expect_success 'git clean -n' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -n &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -231,15 +231,15 @@ test_expect_success 'git clean -d' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -d docs &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing docs &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -248,16 +248,16 @@ test_expect_success 'git clean -d src/ examples/' '
>  	mkdir -p build docs examples &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
>  	git clean -d src/ examples/ &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -f examples/1.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing examples/1.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -266,15 +266,15 @@ test_expect_success 'git clean -x' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -x &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -283,15 +283,15 @@ test_expect_success 'git clean -d -x' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -x &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -d docs &&
> -	test ! -f obj.o &&
> -	test ! -d build
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing docs &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_missing build
>  
>  '
>  
> @@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -x -e src &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test -f src/part3.c &&
> -	test ! -d docs &&
> -	test ! -f obj.o &&
> -	test ! -d build
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_missing docs &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_missing build
>  
>  '
>  
> @@ -317,15 +317,15 @@ test_expect_success 'git clean -X' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -X &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -334,15 +334,15 @@ test_expect_success 'git clean -d -X' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -X &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test ! -d build
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_missing build
>  
>  '
>  
> @@ -351,15 +351,15 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -X -e src &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test ! -d build
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_is_missing build
>  
>  '
>  
> @@ -382,29 +382,29 @@ test_expect_success 'clean.requireForce and -n' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -n &&
> -	test -f Makefile &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test -f a.out &&
> -	test -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file Makefile &&
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_file a.out &&
> +	test_path_is_file src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
>  test_expect_success 'clean.requireForce and -f' '
>  
>  	git clean -f &&
> -	test -f README &&
> -	test -f src/part1.c &&
> -	test -f src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test -f docs/manual.txt &&
> -	test -f obj.o &&
> -	test -f build/lib.so
> +	test_path_is_file README &&
> +	test_path_is_file src/part1.c &&
> +	test_path_is_file src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_file docs/manual.txt &&
> +	test_path_is_file obj.o &&
> +	test_path_is_file build/lib.so
>  
>  '
>  
> @@ -453,11 +453,11 @@ test_expect_success 'nested git work tree' '
>  		test_commit deeply.nested deeper.world
>  	) &&
>  	git clean -f -d &&
> -	test -f foo/.git/index &&
> -	test -f foo/hello.world &&
> -	test -f baz/boo/.git/index &&
> -	test -f baz/boo/deeper.world &&
> -	! test -d bar
> +	test_path_is_file foo/.git/index &&
> +	test_path_is_file foo/hello.world &&
> +	test_path_is_file baz/boo/.git/index &&
> +	test_path_is_file baz/boo/deeper.world &&
> +	test_path_is_missing bar
>  '
>  
>  test_expect_success 'should clean things that almost look like git but are not' '
> @@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git work tree' '
>  		test_commit deeply.nested deeper.world
>  	) &&
>  	git clean -f -f -d &&
> -	! test -d foo &&
> -	! test -d bar &&
> -	! test -d baz
> +	test_path_is_missing foo &&
> +	test_path_is_missing bar &&
> +	test_path_is_missing baz
>  '
>  
>  test_expect_success 'git clean -e' '
> @@ -638,10 +638,10 @@ test_expect_success 'git clean -e' '
>  		touch known 1 2 3 &&
>  		git add known &&
>  		git clean -f -e 1 -e 2 &&
> -		test -e 1 &&
> -		test -e 2 &&
> -		! (test -e 3) &&
> -		test -e known
> +		test_path_exists 1 &&
> +		test_path_exists 2 &&
> +		test_path_is_missing 3 &&
> +		test_path_exists known
>  	)
>  '
>  
> @@ -649,7 +649,7 @@ test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
>  	mkdir foo &&
>  	chmod a= foo &&
>  	git clean -dfx foo &&
> -	! test -d foo
> +	test_path_is_missing foo
>  '
>  
>  test_expect_success 'git clean -d respects pathspecs (dir is prefix of pathspec)' '
>
> base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
