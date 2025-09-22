Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48121D3F5
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576410; cv=none; b=LhpupSURdTtu4vVqZIcyMFU051isvTAurx/Dz+dGL3XV/Jd8Zu0ecJ4fJpRxXm4AByV25ce52CgQkt4MY2XkfOuEnhhhE0Ef0WkaO/U3IGXGxH0oHW7hVvUohv18OfUwqRrkoTVPGLKo9daOXbhu7AKXiAc05TbX47BAHrl8uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576410; c=relaxed/simple;
	bh=WSfuHaQBlnyjGLX3y7wtcUI4y/eiFzjmaL5WwnZqR4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDB5rRfmzm+6EDrak6Rtsy5wi//EjUgteQaZUMbHpVEAC9b3wvAAvPH+WLcWIs2NiFEOiJRbr8BO5lOHf67eTIrCZsi0JYVhqnjlybT2BVAqh9XEh7sPZazjKqRGNNvKpD5+5NUeV2fKoO1tHN6Ssc+S0I1UeZ9rgiyOE15IZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJ+yFsAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxUJZR6P; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJ+yFsAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxUJZR6P"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E0451D0019F;
	Mon, 22 Sep 2025 17:26:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 22 Sep 2025 17:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758576406; x=1758662806; bh=xY6jAyqOPZ
	qiG8qEKFSgka5dP1k+XvyY+sUlVbpe6UA=; b=rJ+yFsAut8Xq0AheB3fuJzdQLs
	rjURgLch1WUi/v5C869wU7iQNhxs08I6FFg2MagEOZlEsMBIsYSeGFcwsV5SR4KM
	YDsW7CpHhPRHfg2l1mJt/6B9IXqL8FQoqrGYqg6WWP4jPoq5dPrzCly1gs/Yz/xV
	2QL6HJFXWZitop/txlwYEKCvXTvDc/QPlF/kTahXqBrxMO0mLlSyYr/nK1adlyv5
	upUkt5LrprR9/ZFnrpr3aE1Y1JZxMekQMuQNHiD5lAW5BhiSZElmH9Se75pkz+sa
	UzTirMoDrEiZeYzzl7khvPKVIa1/hiDphH2LE7zjiwVDGWPkcvUvIe/f8Tng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758576406; x=1758662806; bh=xY6jAyqOPZqiG8qEKFSgka5dP1k+XvyY+sU
	lVbpe6UA=; b=SxUJZR6PTNq93hPeVO1XpFh9O/8ILZ0HQ4oq+KMLgfr1kvKFxGq
	oZldytyQjWyV1Aht7ttvGrV2N05pwtT8W/UhPZNPnSDRJKdmvkWeQhfn2/mNey1z
	scQWERFiT+nxbnNkG0yKNMFoE/GOPF88v/4w6Gc333CNlUU6sd8lotGJbdA6xoPr
	ACYKcoD1YJmYhJuEW9Fsej9B7ZtLyPqdZ1F07W+yJJUuP9p4mLcLFwA0yc/BCR9H
	ADqiYLaoNOstiSr0vUQwW0gDnVOzoWnfnsIbTorzkrLpLruFsx9n1Y0BmS8TyAfP
	FTuw9YcOXEQmiOxWL3qns7pKzKti2nktAzw==
X-ME-Sender: <xms:Fr_RaB7boaS-Vc4zkLfjj8XLX1GPved5ev2GtTiuklkSsw6ioeEadg>
    <xme:Fr_RaCmB4H5Bg8yi4JaGZF9DEActpHLcQaLiY8aW7lCdYEewwl9c81Nyisvi6RwgA
    Rhi5JL2Jw9aBfI7Ro-SaUqnmQzPfHB_fbl0e0lurIwKWF1YZSNFDQ>
X-ME-Received: <xmr:Fr_RaCQvMaKGFRVEH2y4Zp2ljY8yFKBLFSYywl8Tyxm3TZ8DtXyQcjn_ne8gmYK8ANGAO2-5d01F6mLbaBdO6KoPA7Dztbst_KhX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Fr_RaBHaaNC_PnLwjFMF5rDaNne18pwkUABPttGxIMnnTEh2ETIi1A>
    <xmx:Fr_RaHHusRyr-U092t-P5DIGT1IOIfAutnOrCWpVKTCIDKGZutfH0Q>
    <xmx:Fr_RaPQqWHGzHRqpjckteFFdLw1o2zGb78YV1LecOfefbxRtsObSHw>
    <xmx:Fr_RaIL4GbhDlwvdmtuYiRmC136ZE0WF8DKxPApPHJQyVWtUzh34GQ>
    <xmx:Fr_RaMxc0hjeNspHk668rAug-pqp7I0DXqJ4DdicxTuUoafce_DfkD2t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:26:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Lauri Niskanen
 <ape@ape3000.com>,  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
In-Reply-To: <20250922202509.GE2205919@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 16:25:09 -0400")
References: <20250919223351.GA3906184@coredump.intra.peff.net>
	<20250919224027.GA594545@coredump.intra.peff.net>
	<xmqq1pnywkwv.fsf@gitster.g>
	<20250922190555.GA2205919@coredump.intra.peff.net>
	<xmqqikhath3d.fsf@gitster.g>
	<20250922202509.GE2205919@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 14:26:44 -0700
Message-ID: <xmqqms6mrxez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Sep 22, 2025 at 12:36:22PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Yeah, I had originally written just:
>> >
>> >   test_expect_success 'stash show -- does not leak' '
>> > 	git stash show --
>> >   '
>> >
>> > but it felt funny, since the test is doing nothing in a build without
>> > SANITIZE=leak. If we are OK with that funniness, I can switch back to
>> > that.
>> 
>> We have a prerequisite for that.  Very nice vehicle for
>> documentation purposes, even though we do not care about a single
>> "stash show" invocation for correctness or performance reasons.
>
> Ah, nice. It crossed my mind that we could try marking it as such, but I
> forgot (or never knew) that we already had this prereq available. I
> guess it was mainly used as "!SANITIZE_LEAK" before for suppressing
> leaks.
>
>> Perhaps I can squash the following in, unless you have other changes
>> in mind.
>
> Thanks, that looks perfect for the code change. But we probably need to
> update the discussion of the test in the commit message. Here's what I
> came up with (replacing patch 1):

Thanks, will replace then.

> -- >8 --
> Subject: [PATCH] stash: tell setup_revisions() to free our allocated strings
>
> In "git stash show", we do a first pass of parsing our command line
> options by splitting them into revision args and stash args. These are
> stored in strvecs, and we pass the revision args to setup_revisions().
>
> But setup_revisions() may modify the argv we pass it, causing us to leak
> some of the entries. In particular, if it sees a "--" string, that will
> be dropped from argv. This is the same as other cases addressed by
> f92dbdbc6a (revisions API: don't leak memory on argv elements that need
> free()-ing, 2022-08-02), and we should fix it the same way: by passing
> the free_removed_argv_elements option to setup_revisions().
>
> The added test here is run only with SANITIZE=leak, without checking its
> output, because the behavior of stash with "--" is a little odd:
>
>   1. Running "git stash show" will show --stat output. But running "git
>      stash show --" will show --patch.
>
>   2. I'd expect a non-option after "--" to be treated as a pathspec, so:
>
>        git stash show -p 1 -- foo
>
>      would look treat "1" as a stash (a synonym for stash@{1}) and
>      restrict the resulting diff to "foo". But it doesn't. We split the
>      revision/stash args without any regard to "--". So in the example
>      above both "1" and "foo" are stashes. Which is an error, but also:
>
>        git stash show -- foo
>
>      treats "foo" as a stash, not a pathspec.

All good.  I do regret that I didn't resist harder against the "1 is
the same as stash@{1}" or insisted that the parser be written more
robustly if we wanted to support such syntax, but that also is way
too late to change now.

> These are both oddities that we may want to address (or may not, if we
> want to retain historical quirks). But they are well outside the scope
> of this patch. So for now we'll just let the tests confirm we aren't
> leaking without otherwise expecting any behavior. If we later address
> either of those points and end up with another test that covers "stash
> show --", we can drop this leak-only test.

OK.  

By the way this also solves the original "git stash show -p --invalid";
do we want to credit the bug reporter and mention that issue as well?

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/stash.c  | 3 ++-
>  t/t3903-stash.sh | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index f5ddee5c7f..e5ab3c4cf5 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -957,6 +957,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
>  static int show_stash(int argc, const char **argv, const char *prefix,
>  		      struct repository *repo UNUSED)
>  {
> +	struct setup_revision_opt opt = { .free_removed_argv_elements = 1 };
>  	int i;
>  	int ret = -1;
>  	struct stash_info info = STASH_INFO_INIT;
> @@ -1015,7 +1016,7 @@ static int show_stash(int argc, const char **argv, const char *prefix,
>  		}
>  	}
>  
> -	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
> +	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, &opt);
>  	if (argc > 1)
>  		goto usage;
>  	if (!rev.diffopt.output_format) {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 0bb4648e36..daf96aa931 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1741,4 +1741,8 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
>  	)
>  '
>  
> +test_expect_success SANITIZE_LEAK 'stash show handles -- without leaking' '
> +	git stash show --
> +'
> +
>  test_done
