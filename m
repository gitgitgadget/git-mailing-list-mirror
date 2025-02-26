Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59D182BC
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576370; cv=none; b=uN644WUOp+6at4ueVFg+D5xQx3JeAoR/nEOYo/bcQgIavO+GD6lSVK7CN41TiySOgTFQENX099AX2lXRoqolS43YqSwW+b7qJUtznSD73unAQEPJGpvdbJ8LrmuSLMRLpsve1ixf3vgc7/wIOjYYo049LJdQAqBnkrpyLOD8Hz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576370; c=relaxed/simple;
	bh=4hPLcMjo9/YgRjsimzQ1tB+Da6HgiCtyiiscUc91hVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MrxoSyA6yXx5CJu2llYxTR6Qzww0qccDLRVsXArwCLOZ3EyQX7L/DQB/Ea7kLdihW+ISmVQFmDco22nd+h56vp24DOh1jbIe8n8m+Zy+PLV40NzeBwLjk8gEWqBM3PJp1knBmAgNfC5cExWiodqETJMtP6rabvI5lwnNwh1sGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ltq6LZnS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMjKAX7Q; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ltq6LZnS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMjKAX7Q"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3BFC114010A;
	Wed, 26 Feb 2025 08:26:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 26 Feb 2025 08:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740576366; x=1740662766; bh=CDwM8HtOGl
	U6GyaJANLsKRJ+E9pYdx9HgrQ+8AzDJyE=; b=Ltq6LZnSvIj+/RM/8g06zVNI7i
	/AKd61TAjDsaBZJQOx9emOPf0bMcF1pR2BrDdgrolpaF/GJlP7O81BFPYUi8CVJO
	ZQW0L2e+dC74o3A1I0WzCgYVn8/VcL8DJ8txyL7ewZomTOD1xAD6Z8pI6cO8sQPD
	lwaVHuxojucrASCguJEbbMuxew4rET3aIb5tvGHSr2feeJoEF5oKOlvbpewjgtZw
	6rE/pCRQK5HaRpAPoCn9kW8GVtD5+GtRTKP/oUwCI3ClI6z6cKBVDxMvT0yK//25
	zY8+x7JRe5Kb6l6sGZmP2v8jDT+69JNipfGaNz+LhAMiCKEGzo3Hac61I3pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740576366; x=1740662766; bh=CDwM8HtOGlU6GyaJANLsKRJ+E9pYdx9HgrQ
	+8AzDJyE=; b=WMjKAX7Qn6Br5yjunx/6m2dG2j1wDz+uqf/I9TsqbdqmcFzsSYm
	8nAPb1s2bB5nZcVCLw+5ow6rG3V0DaKVlOap7KqH0G4x9+stC0/ZYKC+Mw/K9XNt
	U9YUYeLJOi07oV1WarNoaCXHYVvmsdb1gFvqaaBrVbeco+o2ES/M03A2M8j4GRTP
	tOBSB1parSz4FAJ0sKEjCLCuyWNuhRJm+6HACHT1JtxyD1SBdej1WkstLZqjg2u3
	4OPOmK/Q4Tho8x2rmCMf2dibYYdwHwxZWWpK2m9OSLLE9/pD+Rgh1Yzo+pbtVo9q
	iyRgU21RF9pTakoGRrFiKKFgFZ2d3mMbrLA==
X-ME-Sender: <xms:bha_ZybLVVZs16jWg9ECuOnIcch2GI-Nnx-z5nb4QbMO_gmKkzqnXQ>
    <xme:bha_Z1a_CVpfr8w2fBtVp_83yb8HRFSHNU3VS5_KAY8APUf1uokVF7UeoMhms9xAV
    _142UD5IXBNm-vVJw>
X-ME-Received: <xmr:bha_Z88TtgZylcG94SNN9D86ptBYkibGnWGtyANfj_wKnpaWLohj8oYzaNw5gzLoTVhmLoeoKtMFHi9-7cSapvZLMYpY_wB93XDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bha_Z0rVCXsgqVg-ZH-vhoHgs7VnxAdqlExGpWJ1v0IJwY_u2nBo_g>
    <xmx:bha_Z9oQTEFLJCo3-DVw_ODu0v66JT2oXkId6SJWHhx9Q3VLAz3__A>
    <xmx:bha_ZySlZTodTLgk_i63wtlpF3W_1rDzA6xKhllc909tHEVYxvgPuQ>
    <xmx:bha_Z9o5cxckx0DioiGo1gzQamyQoxn87INgxLpx64wa5C1YpYHLrQ>
    <xmx:bha_Z-lpPK4LAuJZ56mlz6FH9Mg2W-y_p2LMXRpga8cR-Ufr14nuyHzS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 08:26:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 05/10] git_inflate(): skip zlib_post_call() sanity check
 on Z_NEED_DICT
In-Reply-To: <20250225063026.GE1293961@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 25 Feb 2025 01:30:26 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225063026.GE1293961@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 05:26:04 -0800
Message-ID: <xmqqr03kg7mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But these do not correspond when we see Z_NEED_DICT! Zlib consumes the
> bytes from the input buffer but it does not increment total_in. And so
> we hit the BUG("total_in mismatch") call.
>
> There are a few options here:
>
>   - We could ditch that BUG() check. It is making too many assumptions
>     about how zlib updates these values. But it does have value in most
>     cases as a sanity check on the values we're copying.
>
>   - We could skip the zlib_post_call() entirely when we see Z_NEED_DICT.
>     We know that it's hard error for us, so we should just send the
>     status up the stack and let the caller bail.
>
>     The downside is that if we ever did want to support dictionaries,
>     we couldn't (the git_zstream will be out of sync, since we never
>     copied its values back from the z_stream).
>
>   - We could continue to call zlib_post_call(), but skip just that BUG()
>     check if the status is Z_NEED_DICT. This keeps git_inflate() as a
>     thin wrapper around inflate(), and would let us later support
>     dictionaries for some calls if we wanted to.
>
> This patch uses the third approach. It seems like the least-surprising
> thing to keep git_inflate() a close to inflate() as possible. And while
> it makes the diff a bit larger (since we have to pass the status down to
> to the zlib_post_call() function), it's a static local function, and
> every caller by definition will have just made a zlib call (and so will
> have a status integer).

Ouch.  I am not sure if I would have made the choice you guys made
if I were writing this fix, but that is mostly because I do not
anticipate that we would ever support NEED_DICT and the other two
options seem simpler, and certainly not because I have any concrete
reason to oppose the third approach.

> +test_expect_success 'object reading handles zlib dictionary' - <<\EOT
> +	echo 'content that will be recompressed' >file &&
> +	blob=$(git hash-object -w file) &&
> +	objpath=.git/objects/$(test_oid_to_path "$blob") &&
> +
> +	# Recompress a loose object using a precomputed zlib dictionary.
> +	# This was originally done with:
> +	#
> +	#  perl -MCompress::Raw::Zlib -e '
> +	#    binmode STDIN;
> +	#    binmode STDOUT;
> +	#    my $data = do { local $/; <STDIN> };
> +	#    my $in = new Compress::Raw::Zlib::Inflate;
> +	#    my $de = new Compress::Raw::Zlib::Deflate(
> +	#      -Dictionary => "anything"
> +	#    );
> +	#    $in->inflate($data, $raw);
> +	#    $de->deflate($raw, $out);
> +	#    print $out;
> +	#  ' <obj.bak >$objpath
> +	#
> +	# but we do not want to require the perl module for all test runs (nor
> +	# carry a custom t/helper program that uses zlib features we don't
> +	# otherwise care about).
> +	mv "$objpath" obj.bak &&
> +	test_when_finished 'mv obj.bak "$objpath"' &&
> +	printf '\170\273\017\112\003\143' >$objpath &&
> +
> +	test_must_fail git cat-file blob $blob 2>err &&
> +	test_grep 'error: inflate: needs dictionary' err
> +EOT
> +

Wheee.  I guess an ugly and down-to-bit-sequence test is much better
than having no test at all ;-)

We'd want to say >"$objpath" to adhere to CodingGuidelines, but
I guess those particular versions of bash has not been seen in the
wild for quite some time and we may want to loosen the rule there.

Anyway, looking good.  Thanks.
