Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB51E0DD8
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513142; cv=none; b=Mpc0clbMR5d3HBWKnTius2rMOuYNhnLgEG9irmCi7+mzMJ8lFXIvinTbXPhHyDMSJHCER6alEUCXPEa6KRCQf650FHRl95VAZTjI2ZF1oJGADJ+mTxCr10dOUwLEzLHtXTwg85dQS9p4hMdD5P/WHYnnDL0g7uMcfIGZwKDhn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513142; c=relaxed/simple;
	bh=fpJ0H1FKyNWvyanBaTRaGJxbvMAuflsbfLb5uiFBSoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqx34XEFpfP0+2jCz96lqbOATEXW6fEa9YFHJc9knS1i1GZSNZb8yPy6CfzhX2imaJkCyVRFaiFSdeoLAPDpFiwFEJPeL/gKFOJ65f+PFTOFOUJo68SsMJe19qgSsCzNy4ZYJR6D1zFnPWEzTMXIq1ZskE4lSUlg8l/fn4o9L5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VewlCUBo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkEEitQ3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VewlCUBo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkEEitQ3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 28EBCEC0455;
	Mon,  6 Apr 2026 18:05:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 06 Apr 2026 18:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775513139; x=1775599539; bh=flPTWMVc9S
	Fnz8Cf0ajTaAQI6dznIRMt5NaJmuRxZ5M=; b=VewlCUBo5B2EPG+rIV03T9tTtl
	2cRom63arvaxuYd7asH0GpqrvK7YoVwkX04RqAphzFIDoy28EQAUZD3J6SW/QRat
	k+lYWfwtVixD3IySZfhABO8HT0ovJBjdf64pA/y9YWspoCwAbZEQ2QGHKz1xWNCw
	ZnhI4Z+NH8bMnIsGl1X7UvcAvpZUOGOPZ0YnMDw01wmIRs4A77jf8+4bHk3toZHI
	56Yy04ys+i6nOlsTYEF5iagDHohbsLkBUft44ncQfBL6gW43sdjkCPYzt/hbrPsJ
	U3SQZm54EoXrLyYlXGXEtOcTtOqTM7lYsGMlPl9niHUotoRkMEew6692s1jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775513139; x=1775599539; bh=flPTWMVc9SFnz8Cf0ajTaAQI6dznIRMt5Na
	JmuRxZ5M=; b=tkEEitQ36U+OYZnDdVjrx39CnxHkUIveztxTlJjxI7DyG154y0b
	276NaI7hj+HyJnjojElqrkElT4qWTYjmMVg5PSC7CoHJ1Xvs19L8xgizO9wlusAd
	ztZHx7aV7EhnZqIGXKg/f/Jma//2OWDdDcH1/L0R8hyAkI+WZdR0mCwcjPREbN0o
	wjW0A4Z4dLO1ERluDtWz1VhCi9KT1xqFQ7Ah+z8LxzaK51anTwZZo16RZucs7o3E
	p/LF9+kWGktjh+LURMYpj2mn4cjW1ufZSvXOcV9qBFVi1DK0bk90H5Xkq9dbTgow
	2S3AJ+B/PkG6UoItXnkzXQGlhRWleJmd7XA==
X-ME-Sender: <xms:My7UaRUGlbe7GXu9q3ksDOYukx0Sm_w6bvuQwy28uoVT8bTgLhU9KA>
    <xme:My7UaQpwr22ojBY9q6mhR_ms2DKY23XaGdg-w6Pe6MeSJFKPV0rivcdnZkoL6OU_G
    B2crwYt2Tnd1m5G8u-AdU7vGFZfHvzQ5bACi0JoTx8tOQjCgP-o>
X-ME-Received: <xmr:My7UaTluINupk8N4P3qw3zV7Re-atSzBaJvxIRrybm_SEwfP_wVb1A_Jej2sppsm_WGzTwyk9rGL8_y54lb6CLQoAUuyIZTJoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlohhrvghniihordhpvghgohhrrghrihdvtddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:My7UaQ1CS--shkQ3J_WINvrnTVQLTtkQ-Z-oFuHIOgGPbfVXaC3C_A>
    <xmx:My7UaQRcndLCE1XHsZsFpsNWMr8x9oWFWOLX8mjCNpQ07vFGBWceyA>
    <xmx:My7UaZzDEzoZd8pAyoVfuSRAJj5T3PLFNRfe3-0Rb4p76c4C56MT8Q>
    <xmx:My7UaQDCu5oxKqNcaFbxZ2AeWStevFVS980VtNEXFqZuuZyXXEz0AQ>
    <xmx:My7UaZ7oS0JMO-MG7DTMf85VK5uFf-BFX3J2TvQZqlf9PQxysvfJ2SWg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 18:05:39 -0400 (EDT)
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
Date: Mon, 06 Apr 2026 15:05:37 -0700
Message-ID: <xmqqldez9232.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

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

So "prom" is a list of filenames; since $path does not have any
funny letters that interferes, later use of unquotd $prom will
list these files.  OK.

> +		oid=$(git -C prom_test rev-parse HEAD) &&
> +		echo "$oid ref" >$prom &&

Oh, not quite.  How are we guaranteeing that there is only one file
in the list of files in $prom?

In any case, quoting from Documentation/CodingGuidelines:

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.

	(incorrect)
	cat hello > world < universe
	echo hello >$world

	(correct)
	cat hello >world <universe
	echo hello >"$world"


> +		# Save the current .promisor content, repack, and check if correct
> +		prom_before_repack=$(cat $prom) &&

This is misleading, unless you plan to update the early part of this
test to store a more realistic data in the $prom file.  Wouldn't it
be equivanent to

		prom_before_repack="$oid ref" &&

at this point?

> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&

We expect that there is only one .pack and .promisor file.  Why
are we listing .pack and turning them to .promisor, instead of doing

		prom=$(ls $path/*.promisor) &&

here?  Don't we expect that this "repack" to recreate .promisor file
as well (and if we do not see the file then we detected another bug,
which is a good thing)?

> +		# $prom should contain "$prom_before_repack <date>"
> +		test_grep "$prom_before_repack " $prom &&

I do not quite understand this test.  Ahh, OK.  We expect that there
was only a single entry in the original, because that is what we
placed in the original .promisor file.

Enclose $prom inside a pair of double quotes, as it is misleading
without.  I wasted a few minutes wondering where you are expecting
these possibly multiple promisor files from.

> +		# Save the current .promisor content, repack, and check if correct
> +		cat $prom >prom_before_repack &&

		cp "$prom" prom_before_repack &&

would be more standard.

> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&

The same comment about "don't we know .promisor file should exist,
and shouldn't we check it directly?" applies here.

> +		# $prom should be exactly the same as prom_before_repack
> +		test_cmp prom_before_repack $prom
> +	)
> +'


Same comment applies from earlier to the next test piece, I suspect.
Let's take a look.

> +
> +test_expect_success 'check multiple .promisor file content after repack' '
> +	test_when_finished rm -rf prom_test &&
> +	git init prom_test &&
> +	path=prom_test/.git/objects/pack &&
> +
> +	(
> +		# Create 2 packs and simulate .promisor files by creating them manually
> +		test_commit_bulk -C prom_test --start=1 1 &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		oid=$(git -C prom_test rev-parse HEAD) &&
> +		echo "$oid ref" >$prom &&
> +		prom_before_repack1=$(cat $prom) &&

> +		test_commit_bulk -C prom_test --start=1 1 &&
> +		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&

Do not pipe head into sed, as sed is more capable.

		ls -t $path/*.pack | sed "s/.../;q"

> +		oid=$(git -C prom_test rev-parse HEAD) &&
> +		echo "$oid ref" >$prom &&
> +		prom_before_repack2=$(cat $prom) &&

But more importantly, this may become a source of flakiness.  These
two packfiles are likely to have very close timestamps and depending
on the timing, how heavily loaded the machine is, and the phase of
the moon, it is not guaranteed that you'd grab the name of the new
pack.  Instead of sorting by type or getting the first one, which
would not work reliably, grab both and filter out what you already
have seen.

> +		# Repack, and check if correct compared to previous saved .promisor content
> +		git -C prom_test repack -a -d &&
> +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> +		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
> +		test_grep "$prom_before_repack1 " $prom &&
> +		test_grep "$prom_before_repack2 " $prom &&
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
>  test_done
