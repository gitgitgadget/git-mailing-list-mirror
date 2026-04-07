Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7053C870E
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578228; cv=none; b=mNOxmNsUwD5Yd52z/HecurwcVF46hnON+F5p036uu2xdjS2rELNxFvVSLyzJD/it9u/kZqsU6VHooRebeZwMHZmshK3A+OywHsVCnK5/YCl0qstXERAqb2SoL9SmE2mCV7z39k3aNedMC8kTVgAUFPNPDKrnTTeIqUko8fI2f+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578228; c=relaxed/simple;
	bh=TJNpSV12v3Sv1jQB4YdkW5eryacW9sIInTQbgxQ8wh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dfed7Y3+JZbnn0ciEt3nAhNyShXZLrv7Ousk115D7xxl/Eec6Lxge1c4fpzTjQxYvgqj0r6blBsNRUzjfZMFW2rZXw97rXGAriYip9LgR+GSBs7Zl16PeHog7q4sG8K2j5k34zP1QJUKqwHhiyKGJ8x9TPzgW4F90TdSPAMNQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BJr3GImI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuRhqSyv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BJr3GImI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuRhqSyv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0447CEC0081;
	Tue,  7 Apr 2026 12:10:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Apr 2026 12:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775578219; x=1775664619; bh=/wsSORNn5e
	OVsuaMC6mlUFkqaevO7tdcip5U9e7K45s=; b=BJr3GImIk7cm+Xyc576OoD+5YN
	5M4Zy8Vz9H+/HOqGn/n5NWUb6KvhZxODSlQQsQ58SUc4k59v1NjZ6CDZWonnJHf3
	uDdwsqYuyEHFToAfELl554X+1MqVuxpU7Gms6ek2aG2zInd6UShGzuIJDB8N0d/1
	A3tWVHKbUC5TZJPOz8LIquIYdAnfD3TdDkMObib2c7WjUW+/7gPOCJVVoRq1Fl9u
	S3yMR9ZOTlpYyrnzSv75dR61L8prRNnULeq7pco+7PMPH3FHGDgE1xTWONB+g/eR
	XCV5OhHDhen4os35S/ZjBkUu3k7UoR9ln+a3R/8bDXj1u+ReavLXAmPgdeHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775578219; x=1775664619; bh=/wsSORNn5eOVsuaMC6mlUFkqaevO7tdcip5
	U9e7K45s=; b=NuRhqSyvzI9Fwg0TyGq1pMy1gy4y3Q9TvToc4m7xADALZZAfzWE
	Fw5x5uTTbHZef6/pfASi6z5h9f7cfhWTdOdNjDfZ7jqZ3l8bJrdrxbQRNIAlPLps
	xhDR1WSGkc3b0IguebrQQpLeQQmjSC3RNV1noVZwZ2SL8QtpKyoRfsS9J9mzSwiz
	FfruofCs2vIIIePNHDu78TmRLnyCfkhTwXHemZ9QyJnJ+/7S2vBgL/F7Ldeo1Iiv
	kP2kiZuFB9/CrbONuADWoCu3GZR14wvr0bHRa4F2pQ6VHwe5dMk+wQnptz1IQCrJ
	Xg1vzF+sj9CClsost/iXrGUMLnssVoWEp0A==
X-ME-Sender: <xms:ayzVaTDZpwyYW1TXNvKIhN4zkaOX-61GIoJT4IHVvHYJmT45_tLXqw>
    <xme:ayzVaQaABSQ9YqMjLCZOGOi8Kfqt7mL3u29-ddE00M7X_1SBWfJJtRcwqguQuSEjM
    bZRnKziK5HqY00zc5JfTSP0xGscnXvgiSG-u1uYnWCXh-cw2ymhOwY>
X-ME-Received: <xmr:ayzVaW559yPCMVpB2pJ9zJldY7sKI4wLStWqjIYtqDkJhmFeIzfxna_6EGgpqoLMiCOCx3rtpFbx9ib1b_3r0bRVu4PKBB3K7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeiirghkrghrihihrghhrghlihdutddtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrth
    esmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ayzVaRaygIJT8bMD2xNFTbrUiYQjLqbggFCvQzrZxXDCQL6-woVzOw>
    <xmx:ayzVaVhUKaZmqKQQUdSjxCAmwljr0Rx5Kj_s9TouhqZ0LXRxAsMK2A>
    <xmx:ayzVaS9TfPbZ1UFpVLxZMCqCeUywZMrfbymnBxmW1D9z4SQH9B9acw>
    <xmx:ayzVaQrtOG186ApC8Yu1XTN3MX5xIkV5e5NVLx0jxl6aIq1AfaWTvw>
    <xmx:ayzVaXq0hfo2MIG6iRAzcveSQF4ghU7p7n3zv83Tk5fJPZbZThhZu3fS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 12:10:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v5] t2000: modernize overall structure and path checks
In-Reply-To: <xmqqmrze7sj9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Apr 2026 07:29:30 -0700")
References: <20260405011135.125912-1-zakariyahali100@gmail.com>
	<20260407034446.409175-1-zakariyahali100@gmail.com>
	<xmqqmrze7sj9.fsf@gitster.g>
Date: Tue, 07 Apr 2026 09:10:18 -0700
Message-ID: <xmqqzf3e69at.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The description of this v5 patch looks suspiciously similar, as its
> patch text, so I suspect it won't apply to my tree.

So, I applied this "v5" to a slightly older 'master', immediately
before the za/t2000-modernise topic was merged, and compared the
result with what we already have in 'master'.

    $ git log -1 --oneline 0713d3b7f6
    0713d3b7f6 Merge branch 'za/t2000-modernise'
    $ git checkout 0713d3b7f6~1
    $ git am patch-v5.mbox
    $ git diff 0713d3b7f6 HEAD

There are some things that are better, and some that do not look
improvements.

> diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
> index af199d8191..44728329f3 100755
> --- a/t/t2000-conflict-when-checking-files-out.sh
> +++ b/t/t2000-conflict-when-checking-files-out.sh
> @@ -35,19 +35,18 @@ show_files() {
>  	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
>  }
>  
> -test_expect_success 'prepare files path0 and path1/file1' '
> -	date >path0 &&
> -	mkdir path1 &&
> -	date >path1/file1 &&
> -	git update-index --add path0 path1/file1
> -'
> +date >path0
> +mkdir path1
> +date >path1/file1
>  
> -test_expect_success 'prepare working tree files with D/F conflicts' '
> -	rm -fr path0 path1 &&
> -	mkdir path0 &&
> -	date >path0/file0 &&
> -	date >path1
> -'
> +test_expect_success \
> +    'git update-index --add various paths.' \
> +    'git update-index --add path0 path1/file1'
> +
> +rm -fr path0 path1
> +mkdir path0
> +date >path0/file0
> +date >path1

All of the above look regression to me, for the purpose of
"modernization" effort.  We want the steps to prepare for tests
(e.g., creation of test files and directories and preparation of
their contents), the steps of actual tests (e.g., running git
commands and ensuring that they succeed or fail as expected), and
the steps to verify the results, all contained inside a single
test_expect_success for each step of the test. 

On the other hand, the below looks like moving things in a better
direction.  The original has a logically single test split into
multiple pieces and code to debug tests sprinkled all over,
like ...

> @@ -83,59 +82,22 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>  # path path3 is occupied by a non-directory.  With "-f" it should remove
>  # the symlink path3 and create directory path3 and file path3/file1.
>  
> -test_expect_success 'prepare path2/file0 and index' '
> +test_expect_success 'checkout-index -f resolves symlink conflict on leading path' '
>  	mkdir path2 &&
>  	date >path2/file0 &&
> -	git update-index --add path2/file0
> -'
> -
> -test_expect_success 'write tree with path2/file0' '
> -	tree1=$(git write-tree)
> -'
> -
> -test_debug 'show_files $tree1'

... this one.  And consolidating them into a single logical piece
may make sense.

But it seems not quite complete and needs a bit more cleaning.  For
example, ...

> -test_expect_success 'prepare path3/file1 and index' '
> +	git update-index --add path2/file0 &&
> +	tree1=$(git write-tree) &&
>  	mkdir path3 &&
>  	date >path3/file1 &&
> -	git update-index --add path3/file1
> -'
> -
> -test_expect_success 'write tree with path3/file1' '
> -	tree2=$(git write-tree)
> -'
> -
> -test_debug 'show_files $tree2'
> -
> -test_expect_success 'read previously written tree and checkout.' '
> +	git update-index --add path3/file1 &&
> +	tree2=$(git write-tree) &&
>  	rm -fr path3 &&
>  	git read-tree -m $tree1 &&
> -	git checkout-index -f -a
> -'
> -
> -test_debug 'show_files $tree1'
> -
> -test_expect_success 'add a symlink' '
> -	test_ln_s_add path2 path3
> -'
> -
> -test_expect_success 'write tree with symlink path3' '
> -	tree3=$(git write-tree)
> -'

... we used to write out $tree3 here only because ...

> -
> -test_debug 'show_files $tree3'

... we use it to debug that tree here.  In the updated version, we
still write out ...

> -# Morten says "Got that?" here.
> -# Test begins.
> -
> -test_expect_success 'read previously written tree and checkout.' '
> +	git checkout-index -f -a &&
> +	test_ln_s_add path2 path3 &&
> +	tree3=$(git write-tree) &&

... the same tree3 here, but because we lost the test debug, we no
longer use the resulting tree object name.

>  	git read-tree $tree2 &&
> -	git checkout-index -f -a
> -'
> -
> -test_debug 'show_files $tree2'
> -
> -test_expect_success 'checking out conflicting path with -f' '
> +	git checkout-index -f -a &&
>  	test_path_is_dir_not_symlink path2 &&
>  	test_path_is_dir_not_symlink path3 &&
>  	test_path_is_file_not_symlink path2/file0 &&

I didn't go through the updated version with fine toothed comb, so
there may be other "why is this thing left?" and/or "this update
changes what is being tested, no?" gotchas that I missed.

In any case, can you update the patch so that it applies cleanly to
a more recent "master" to resurrect the good bits out of what you
have?

Thanks.
