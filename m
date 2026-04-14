Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0931354C
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196133; cv=none; b=AyLnVC9nigrlX6sGpyuSV5lKy2RJP4+Bqg8BVeunLUg4mSsX120CKavtvuFZeDGRZnS0VgS5FA8B9DJxGVM59nxzpYVHmCjIQR01A1UacrOlVqEsAda+OGSj2sfaeArBvVn/DJ46/2vG1tQkLvp1lhamu6Jsw1yJ4qtGiqAMc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196133; c=relaxed/simple;
	bh=OkjjUGq72qoTOa54INHdVEHuuq0/bKkdx/f4vMouiBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E8jG8QCcTZD9vwg7ScIBudeOlN4vjV8DNhBZ5mgDRvQMMRYA5OHFsbXm4X+TEE0OHvqvj5+uF+FQODKagmN+kxae7c+getU/H7GixZs99hQhYC79hu5gXEyv1z/oXMVYTapc9B1ul7/zOK7eXM+5RNeiP0ZjM5F0BQ5oc2y1a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCPiw+Lz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzXEun4c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCPiw+Lz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzXEun4c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 243AFEC0121;
	Tue, 14 Apr 2026 15:48:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 15:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776196131; x=1776282531; bh=ex+7Qh7EAJ
	waZMRPwKvhRdb+34FQAuuIcEP0oMaRysI=; b=XCPiw+Lzf1pSKjbLkhjAgZvzhK
	VaztqKeLo7boq7jtXn0r/EaEM/l9EbH89PI2su3wDzvvOdJtflO57gSeR4jcMwaH
	L72xWoOsOduPJCHnZ3NpBZ8hq3yUMGt6QG6W84KZiR3cuwqLPxeRvQNFzp68IdoL
	XLHqCuwWDYnBZx0awYqM848Sh8OHPJ7XSHbK0EZS5lKq7STyEhFbwOWR9+hOwR1r
	spH6giuef2ikgGEtGtS1hMq/EvGeFeblRK/54mqthjtf/9W1R7w8liMB/N4/85ys
	l7dL5rrgoMHi3nsBZs+308UQg/1HbA2qA/e/Qix5HBDcdYZKYYozEqdTtlcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776196131; x=1776282531; bh=ex+7Qh7EAJwaZMRPwKvhRdb+34FQAuuIcEP
	0oMaRysI=; b=jzXEun4cl9iwrkrDd6jSfKKwjW5KVpDv7lC/jWsemEH/FM/PZSq
	Gkn8cQgI7fZGDcendQMu0lYUlkXpUO6SlhgInBs1PSl/tCawZBDG8zZXH0WdpATD
	u5DnfSd4USK7tdo4yl0g3w0XDVuag743rI3yXQkslVS7ktIctEOwYBfBZW8WZpbr
	LncVOWG8usZj4BXgOBiwDIq19rZz7QCwdtRxah6Mx3DQAAgQF3iuhgkkKXfHIDqH
	Eg5uMDjU+cfGZBIbZZpqxxZkMgEeRXU92Icqpb29XmctHR+1D87MYPt7UiZn+jvX
	8zDdlR41AxaYXEtKW8+Eqni9uEn+9doST2w==
X-ME-Sender: <xms:IpreaesZKg_uXk3f6IfhZ7zFv752mYJcvvH42nv5sP9spRFHJdLKig>
    <xme:IpreaaURBxJuDbZRaqQLZA0AQlhTfi9C9mKi9LmZRvClPdlxSEe-zoD-mYxdy0Y1t
    70Sir6kBqEL1yLmOy9XCCUJeQGGw4OawI3QHrQLlpcVFh20Hk3nhw>
X-ME-Received: <xmr:IpreaSFUCwTp1BeFd9auQbb8t6Ne6sy4o_y7fh_SUWy7tDf0asaru1XHUvimGznMMXD0Lk1F1lg5MvzbmPzknSL9NRuTq6ASEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IpreaU2idZjJpIle-Hq2grcGNOW-Ofn-9ROnANPjU-kXr2l08F2Fiw>
    <xmx:IpreacMF-TNvvVBcGrZY_fN2VqcbpgfWUViOuORNem3rA2a30UqrRA>
    <xmx:Ipreab7_9EmAGip_Kl8hYsLPF04Wto_LmWkDN_unYVKO2M95Az5MSw>
    <xmx:Ipreae3fdnj-FpNFf-vwtRZEW-qTB6LUC5bx9on1q8HOA3BIbrh1AQ>
    <xmx:I5reaRUimotJJKnZ6V62PbSPLBuwpPT-gUMtpihEbkeHGyy5nKByeyrW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 15:48:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
In-Reply-To: <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 13 Apr 2026 19:56:40 -0400")
References: <cover.1776124588.git.me@ttaylorr.com>
	<d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
Date: Tue, 14 Apr 2026 12:48:49 -0700
Message-ID: <xmqqik9t9vby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In f16eb1c091 (pseudo-merge: fix disk reads from find_pseudo_merge(),
> 2026-03-31), we noted that `apply_pseudo_merges_for_commit()` is never
> triggered by the existing test suite, and that this bears further
> investigation.
>
> This patch is the first one to begin that investigation. The following
> patches will expose and fix a variety of bugs in the implementation of
> pseudo-merge bitmaps.
>
> In order to do so, however, many of these tests require very precise
> selection of which commits receive bitmaps and which do not. To date,
> there isn't a standard approach to easily facilitate this. Address this
> by introducing a `test-tool bitmap write` subcommand that writes a
> bitmap for a given packfile, reading the set of commits which should
> receive individual bitmaps from stdin like so:
>
>     test-tool bitmap write <pack-basename> </path/to/commits.list
>
> , where "<pack-basename>" is the filename for a specific packfile (e.g.,
> "pack-abc123.pack"), and "/path/to/commits.list" is a list of commit
> OIDs which will receive bitmaps.
>
> The helper respects `bitmapPseudoMerge.*` configuration for creating
> pseudo-merge bitmaps alongside the regular commit bitmaps.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/helper/test-bitmap.c  | 110 +++++++++++++++++++++++++++++++++++++++-
>  t/t5310-pack-bitmaps.sh |  24 +++++++++
>  2 files changed, 133 insertions(+), 1 deletion(-)

I haven't been paying attention at all to pseudo-merge stuff, so my
comment may be too trivial and/or misses the point, but please bear
with me.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index f693cb56691..9489e59fa55 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -648,4 +648,28 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
>  	test_grep corrupted.bitmap.index stderr
>  '
>  
> +test_expect_success 'test-tool bitmap write' '

It is very unclear what aspect of "test-tool bitmap write" is being
tested to me.  Let me think aloud to see if I can convey my
puzzlement.

> +	git init bitmap-write-helper &&
> +	test_when_finished "rm -fr bitmap-write-helper" &&

A tangent but the above two lines may want to be swapped.  "rm -fr"
does not fail when bitmap-write-helper directory does not yet exist,
so "prepare to clear anytime it fails from now on and then create"
would be a safer order than "create, and prepare to clear anytime it
fails from now on".

> +	(
> +		cd bitmap-write-helper &&
> +
> +		test_commit_bulk 64 &&
> +		git repack -ad &&
> +
> +		pack="$(ls .git/objects/pack/pack-*.pack)" &&

So we bulk-created 64 commits, repacked into one, and then

> +		git rev-parse HEAD >commits &&

wrote the tip-commit in "commits".

> +		test-tool bitmap write "$(basename $pack)" <commits &&

And told the new tool to write a bitmap file, with only that HEAD
commit and nothing else to get bitmap.

> +		test-tool bitmap list-commits | sort >actual &&
> +		sort commits >expect &&
> +		test_cmp expect actual &&

And compare the list of bitmapped commits with the singleton HEAD
(it is puzzling to sort a single element list, though).

> +		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
> +		git rev-list --count --objects HEAD >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done

If we look at the implementation of bitmap_write() below, the object
name for HEAD is fed to bitmap_write_push_commit() with pseudo bit
off.  After reading the list (which has only one element), we call
select_pseudo_merges().  What do we expect to happen in this call?
Since no bitmap_write_push_commit() call is made with pseudo bit on,
we will return immediately without doing anything?

After that bitmap_write_build() is called, and as this is expected
to add bitmaps to the commits fed to bitmap_write_push_commit(), we
are expecting to see bitmap given to HEAD (and nothing else)?

I said it is unclear what is being tested.  Putting it another way,
what could go wrong to cause this test to fail?  We give commit A,
B, and C to "bitmap write", and it somehow chooses other commits to
also give bitmap, which will be reported by "bitmap list-commits"
and we detect that as a failure?

Thanks.
