Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE91C84D0
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537524; cv=none; b=ia6Bllj7ujebJPmKDEnMMHnpGqtVT83IqFsihsTatG28EnamN/dNYpGfAcX9zAN67D1hWUGpcMOWC/h0iUCYZTQBuXWom6A7S+cmnvdxLVhdyJN6yrOPuMhHiH6WETbBZIN/CgnvlzIBMwQuAkDza4D43bDljFwabJXwSKg+aKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537524; c=relaxed/simple;
	bh=KIfhrPLs+nsbRiYxHToiVtrK9NjlOeME3VGoav/jFqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EA4mkytez+SkXaaQ1EsAl2aFYtITbOCIJOooLeduKUoIUAt8Eh0UL7MvmrdoIm2h0w253tvall9tgNByIkjJwkKfLq5ey0J3ETGo3HnTKAyxI384oT2BJntPnD452DoYPdkW55NO8oiLI2Ykq1TSMJju5teoTVRgRCsLUknqH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G63dHa77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCYnxuBa; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G63dHa77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCYnxuBa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E5721D00340;
	Sat, 26 Jul 2025 09:45:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 26 Jul 2025 09:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753537521; x=1753623921; bh=TJwp8yxmml
	h0tgGKP8oXNF6vDXmD/ABHB/NmZWylDN0=; b=G63dHa77GrtW+uYqjpS5nLNxy0
	ejmXM8/ZfymgNZty5pOcKLHyJM8+ybzh+a1v/ety6omOPsCedcKBzmCKk9GS3H2I
	d/FLwck/GFcYbogkE7KT9o5ZYOuHB+1Bkww7XaEb9XCVCvRjYr/1F0UhJd7SZroY
	yUlpTPLYdL3JBP/yHDeBRWLUmqxoBROAcG2IikoDND3lA/74TYLd6PWCXeva9s9a
	U7D+Cute7d1cimeKfSf5i/5pP7Yqyf9FbhBhQUWg7fOlnRwdXFpHGvJwiKwkYgJW
	n9haT0hkor76DT8LMk/VD+hUpx/84dMQKH6Nzpk7s3JEfoRZuhF5UpB9zYZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753537521; x=1753623921; bh=TJwp8yxmmlh0tgGKP8oXNF6vDXmD/ABHB/N
	mZWylDN0=; b=gCYnxuBaGYJ4Dj2iTI6MUwLmBOLWIk4aI6hxRlkBU4c2apG58j5
	dqHW5Kv8X7xx2mlXJPU/vInsgTUsKVY5LbmkB4f4+rOHBA07gO+RxXV9CpoJCPRe
	0lMrIgJoWSprWBlfrZ3Nbzil73dZMro/tIJMoa6gu5JoX/wo6IfDeue1YTRNz3D5
	xpPqS5EXAtMS0ExLVKudL5JLCVp55wZF91jfSzrI4JIQeSxpFADNXkLRdw5URGEd
	8obnhsEd5B0IfS9j7Eg1nVFZgrxjkeMEwgvXoyMc9XQOu/n6/ENyiVxgUU2WC9IU
	+xs6AheyvehqUW7ys1BrYRDO1wM7mOu6Tiw==
X-ME-Sender: <xms:8NuEaHrtNKNAACPOHGImqllR3ZgJUhKzT7jPs8jA9fnTeEEa66wV3Q>
    <xme:8NuEaOiNekop1b0FI2lcvgE83T7jgJmlKnzUcUn3aaBsr4pgtlKyKfcuWOD7wytBu
    CJJqjweF5UJj042DQ>
X-ME-Received: <xmr:8NuEaD-RGeGvk7jBUzjsEV6RszrXr-SfchhuM-FncpLvi620k8eyvDseSMfwryPxTQ2iDwaBZjtHoGdaGOOb19efdqhL3biKjWd-X5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekieehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8NuEaKWh9dn0uAcGCxvSD6p4tLTnqDFqeSTT5pnTamjV4Ejr2gUlPg>
    <xmx:8NuEaHDHjagYNayx7JHWTBWucs1XhW89kHvWHw_9iXmDK5ANhUXh5A>
    <xmx:8NuEaPGG0-n-clQu2gmcQsK8VTlORbIhhmhNsOuvfsVqs7G5TtpAyw>
    <xmx:8NuEaI7hRHbMeOchBkHjvfTr77vIjYsTpq7jACO1Ia5AvmF_QedyFA>
    <xmx:8duEaPkb-tEGuxpEN_Qg8d5s6SFceflvkbstAkAt3j_lr1WuVto34Azw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 09:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t9350: redirect input to only fast-import
In-Reply-To: <20250725160536.2909011-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 25 Jul 2025 18:05:36 +0200")
References: <20250725160536.2909011-1-christian.couder@gmail.com>
Date: Sat, 26 Jul 2025 06:45:18 -0700
Message-ID: <xmqqpldn12xd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A number of tests in "t9350-fast-export.sh" are using sub-shells to
> redirect content to a number of commands instead of only
> `git fast-import`.
>
> This is confusing and possibly error-prone, so let's change those tests
> so that no sub-shell is used and the content goes only to
> `git fast-import`.
>
> Reported-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This addresses some leftover work discussed in:
>
> https://lore.kernel.org/git/CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com/
>
>
> t/t9350-fast-export.sh | 215 +++++++++++++++++------------------------
>  1 file changed, 91 insertions(+), 124 deletions(-)
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 46700dbc40..8f85c69d62 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -48,12 +48,11 @@ test_expect_success 'fast-export | fast-import' '
>  	mkdir new &&
>  	git --git-dir=new/.git init &&
>  	git fast-export --all >actual &&
> -	(cd new &&
> -	 git fast-import &&
> -	 test $MAIN = $(git rev-parse --verify refs/heads/main) &&
> -	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
> -	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
> -	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
> +	git -C new fast-import <actual &&
> +	test $MAIN = $(git -C new rev-parse --verify refs/heads/main) &&
> +	test $REIN = $(git -C new rev-parse --verify refs/tags/rein) &&
> +	test $WER = $(git -C new rev-parse --verify refs/heads/wer) &&
> +	test $MUSS = $(git -C new rev-parse --verify refs/tags/muss)

That's a great simplification, especially with the use of "git -C
<there>" construct to move there just for that single command.  Very
nice.
