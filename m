Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0A22D78D
	for <git@vger.kernel.org>; Tue, 20 May 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758615; cv=none; b=VXWZw2TdRVEhXp6NsoZ2SgCo9MOrEwDk8fNqT+WcafgW3W6bjqBHabcw8lpWjwQQc1Aff7E+f+nIB2KQhH9S5S2fWcb8SOWr8muCl/Nup8UvcLTCttyizBXyEq1NHy6GzzzTqYQZRG6BY5YibUpLOtW0aMwq8OhWBq2GIRqpdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758615; c=relaxed/simple;
	bh=UIXEee5drpYePK53zhf0e1aqi28S1oeGVJNfC+oY6LI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+r9Z10TkghWBFt2TxZ/2LF1E9x52Mcuei2CxeJoQ+rfTSpdo5eOAmVzo6kQP+pGhYMkvYHfP2DnOs1HwaAGnw/YHY+TGDfszd+TxHR8WgHGVAfKYs2cRP7KzGvqrxACtjeB1x5ivPpzbepHtmWbHuE+YZb4EoZxOu6xw5Tx5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jw3PSYWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NY2sJflc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jw3PSYWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NY2sJflc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEB5F1140148;
	Tue, 20 May 2025 12:30:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 20 May 2025 12:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747758611; x=1747845011; bh=NHWe4UDpK9
	8s2JrbsyaatMl664cU/pTNmy6fDmjyWSk=; b=jw3PSYWwP9qXiuYCxlszz1M6g0
	6sQT06fNe5LL2DJvx8lMcY5wK9z2DvkE37EjygpZ+LddunKHukax/8Jw9mv/imvy
	r0BhpTSscdOkukzthySfrfdqA68fYdgk1B/kGf12Bq0wBByWNPzT8AXe/Z3D/pDQ
	mcwSaGigbQ6R1IqNz+RZvQO/rKO5e/QSSg+FEQf0rYoe3DGT50smUtLJ2sDaAMPI
	Ft8+JbAqNC+ERDoarq1ifFqf+97cCFv1+AivzytmxC8C2DPWoJo6s4lukl4hScau
	YaZoMIZ69JQk9QR4zNQXo0n+4TcMQm4OiDQxEyl/SLaPyeh7xepVNvcfhCOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747758611; x=1747845011; bh=NHWe4UDpK98s2JrbsyaatMl664cU/pTNmy6
	fDmjyWSk=; b=NY2sJflcnf8nx9Xu/PR73FAQgsv5c3coSAj1XDYnmJ5OssjGEB2
	CSE1cqdBWkTLNCfEXe9+A7aLUqn/XnWWmrStpVMoqzJVV6ammXtb7zctDE6vX8bI
	kxecxhmUZaOenWUDRADt9KU/aFA6UQthwbEUdjTp1swhP7EWQA1hoT9B3h1mt2z3
	qvce3wN8wb+/qqj0Ba8/hYvkx5jMV0OFHqySty3/fAmZBbw3fpTAzV4Xs0kCoG1E
	J25yQ5kUgRXY3KFZOT1hvAcnfIEjVCEYAC1j4oioTIueFe5uP4XJCWTK1dmxuhuM
	yA1La4AUA7giUMv6UmsnI06XO9nej602j4g==
X-ME-Sender: <xms:E64saJArAscspFD-N4w3Atkjcx_yEF3-jkmmEoP8iScfpbvoI2BPUw>
    <xme:E64saHgIxv8hN3MLBTjdsxFriRkceb7IeErbUlvxAD1xMhJ6l7GOQR6D7sTkhxOmQ
    _WqxGZKple_Y59wDg>
X-ME-Received: <xmr:E64saEnD7agG6pxCvD5ZF6Bjaj_yDFSDElnkvDan2TcUfMVF85cWOtLsdbidM8Kc2n-JTTB_o0fHIrZwAsT-sz7t5IA4p0szagAMeoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeileculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgf
    gggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgih
    htshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeu
    geffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlh
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:E64saDwo3yTwSKYsCoh73CDu40BLW59PXqVwUCueAY7eYMpYDaqaXg>
    <xmx:E64saOTNvYztJo47enLR38DI8gLiklCwpxh9ALR7cvgI-pgJG2RP8A>
    <xmx:E64saGYe4noAdfagVEMyIKfnz38gLzqoPuIocmxfe88wiKxO8rXzew>
    <xmx:E64saPQmPGZLktMMZ7M7bE9WT4XDAcVjMFXYip-T6SObwyF00Pbnuw>
    <xmx:E64saLLiuRkbBj5s588mhFeVqmSDiJJtKpeOnqcdRB2zb1BUm8yxQwV4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 12:30:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 4/4] diff --no-index: support limiting by pathspec
In-Reply-To: <20250520000125.2162144-5-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 19 May 2025 17:01:25 -0700")
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
	<20250520000125.2162144-5-jacob.e.keller@intel.com>
Date: Tue, 20 May 2025 09:30:10 -0700
Message-ID: <xmqqy0uri6st.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> The git diff --no-index mode does not support pathspecs, and cannot
> limit the diff output in this way. Other diff programs such as GNU
> difftools have options for excluding paths based on a pattern match.

True.

> However, using git diff as a diff replacement has several advantages
> over many popular diff tools, including coloring moved lines, rename
> detections, and similar.

I said this when we introduced "--no-index", but back when "git" was
still young, it would have helped a lot wider developer populations
if we didn't do "git diff --no-index" and instead donated these
features to "many popular diff tools".  We however chose to be lazy
and selfish---those who want to use these features are better off
installing "git" even if they are not using it for version control,
only to use it as "better diff".

People are still welcome to add "coloring moved lines, rename
detections and similar" to "many popular diff tools", but given that
"git" has become fairly popular and widely used, it may not matter
all that much any more that we were lazy and selfish ;-).

> Teach git diff --no-index how to handle pathspecs to limit the
> comparisons. This will only be supported if both provided paths are
> directories.

Good.  If you are giving only two files, pathspec limiting would not
make much sense.  If you are giving a file and a directory, lazily
give only F and D to compare F with D/F, that is essentially giving
only two files F and D/F, so pathspec limiting would not make much
sense, either.  pathspec limited comparison would make sense only
when you are talking about two sets of files.

> However, if we always passed DO_MATCH_LEADING_PATHSPEC, then we will
> incorrectly match in certain cases such as matching 'a/c' against
> ':(glob)**/d'. The match logic will see that a matches the leading part
> of the **/ and accept this even tho c doesn't match. The trick seems to
> be setting both DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY when
> checking directories, but set neither of them when checking files.

Sounds sensible.

> Some other gotchas and open questions:
>
>  1) pathspecs must all come after the first two path arguments, you
>     can't re-arrange them to come first. I'm treating them sort of like
>     the treeish arguments to git diff-tree.

Exactly.  "git diff" proper is about comparing two sets of files,
either comparing two tree-ishes "git diff master next", comparing a
tree-ish and the index "git diff --cached HEAD", comparing a
tree-ish and the working tree files "git diff HEAD", or comparing
the index and the working tree files "git diff".  It is a natural
extension that "git --no-index dirA dirB" compares contents of the
two directories.  In all of these forms, it is common that the
comparison can be pathspec limited by giving pathspec elements as
the command line arguments at the end.

>  2) The pathspecs are interpreted relative to the provided paths, and
>     thus will always need to be specified as relative paths, and will be
>     interpreted as relative to the root of the search for each path
>     separately.

Yes, that is not anything new or something we need to point out as
if it is any different from the "normal" pathspec.

>  3) negative pathspecs have to be fully qualified from the root, i.e.
>     ':(exclude)file' will only exclude 'a/file' and not 'a/b/file'
>     unless you also use '(glob)' or similar. I think this matches the
>     other pathspec support, but I an not 100% sure.

I think that is correct "git ls-files :(exclude)po" does not exclude
git-gui/po, for example.

> -`git diff [<options>] --no-index [--] <path> <path>`::
> +`git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]`::

This is a bit unfortunate.  The disambiguating "--" should ideally
be between the "things to be compared" and the pathspec, as the
former corresponds to <rev> in the normal "git diff" invocation.

> +	... If both
> +	paths point to directories, additional pathspecs may be
> +	provided. These will limit the files included in the
> +	difference. All such pathspecs must be relative as they
> +	apply to both sides of the diff.

"as they" -> "and they"?

> +test_expect_success 'diff --no-index with pathspec' '
> +	test_expect_code 1 git diff --no-index a b 1 >actual &&
> +	cat >expect <<-EOF &&
> +	diff --git a/a/1 b/a/1
> +	deleted file mode 100644
> +	index d00491f..0000000
> +	--- a/a/1
> +	+++ /dev/null
> +	@@ -1 +0,0 @@
> +	-1
> +	EOF
> +	test_cmp expect actual
> +'

If you use --name-only or --name-status would the test become
simpler?

> +
> +test_expect_success 'diff --no-index with pathspec no matches' '
> +	test_expect_code 0 git diff --no-index a b missing
> +'

OK.

> +test_expect_success 'diff --no-index with negative pathspec' '
> +	test_expect_code 1 git diff --no-index a b ":!2" >actual &&
> +	cat >expect <<-EOF &&
> +	diff --git a/a/1 b/a/1
> +	deleted file mode 100644
> +	index d00491f..0000000
> +	--- a/a/1
> +	+++ /dev/null
> +	@@ -1 +0,0 @@
> +	-1
> +	EOF
> +	test_cmp expect actual
> +'

OK.

All other tests also look sensible.

Thanks.
