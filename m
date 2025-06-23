Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCA1C84D2
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699632; cv=none; b=dUTHjfeBwHRiGIviSAjHrvHy2mWtR/Zix93yVQ8GdqrclGt8/Zui08f0YXx5R75/eyDLdNzO8FzyBk+RGy0c3RST1ZJgvF8vZMtfz0qj5Z4KX7SMx5AlSQt3DRrZ+28Cr1DWq2DvlIGDGDdWDSLlg3BmFtVikgP73uKLTto6V2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699632; c=relaxed/simple;
	bh=BqhJ7QtF2sklU8hu14wV5wRc8e51j31A4Vb7Qe+4rT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1W4Ty1jyx1tDmQgN3lOdN8PplS4atTYVeTz+rtYWzZbAAvLAzLsql//FJwxqnR06xftFs+2mTvQPH32B3YDlby+OIH0E1j3AKZhideyNlHmzHP9D/A9/+66zmVuFalQ1FvyG/ZTFawJZikvMk4P8WWmXY+U8p5CZ3mmeOB49Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zv6w1PWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+JtdYAv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zv6w1PWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+JtdYAv"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70ABF25401F6;
	Mon, 23 Jun 2025 13:27:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Jun 2025 13:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750699629; x=1750786029; bh=i9uCUXVHMf
	Zh0MliSyn4Ceg9wloMIZUPV69rVEfLnFA=; b=Zv6w1PWOnFtfjd93arFN2LzWuX
	8+ZMmGCE2EKm3QlAqPMnAx9kpY2Hn6JJGb3Hpf71zCznOpWESbfxUM8LrLUdqYZ7
	wfZcY9/nL/kiTpAWFr+wfY4D0gw3IzJGHBT6vmqfjqpSjQpJY19mr1xthh6AEBLE
	UdajQseXiL0YSrrfXPZ60wZRojJj2h2B+J1/i44lm83xZY+2XNmDsYDJiE3WKNMw
	0C2cvgBXtd9+mwVhVaR/F7ke7SfT1mpPaiGgFnjGW1UfKD9H5GhZk2666x9xP8gW
	6Ae7mLXE4qqPgRKAXBpmc0Hov8Uzi0WjdkQ97/SQvuzUTdP2TTRzJ8jOATQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750699629; x=1750786029; bh=i9uCUXVHMfZh0MliSyn4Ceg9wloMIZUPV69
	rVEfLnFA=; b=T+JtdYAvuti65QSYkFh6z3l8+EcHEyVctbZnqn69blUQ1+CxLpP
	Y1hYIHUBPBmSDRr6sLCuqhX55RJZNVTNMIm+PRJw5NbHsduI+cQ7MUvPIBcyhUQd
	16+Z5Rm17juraOhlWVXJ34w25Ech78VILERQosPoW21ZI4B/sDNaOgLvJyZjBczf
	5z0T6Q8CzXBhERwzJBJ6WxClwCLtdWtHTanq5S1zDgfSlxreEZz+LqMEcmuSVK/j
	3V27FhA/LacyVW8sYkdZbHYmbspq6I7BOzNjJhqTThtfrL+rpbQWy3sz5Hxx6MSl
	GQHhNW5vyEz+LYJsGIBTYEyHTRZEGvhxElw==
X-ME-Sender: <xms:bY5ZaMlDiz7aJ2_IkTrT5rO2T5hLqS85ey0y3QraHocWWd9Vjl6ybA>
    <xme:bY5ZaL2OdNP5oUAE-uiRb9hSNayZsxLRDtG8yH0Z6reNJHj0E5wM8Mf2fzBnYMccW
    Jdofj5ia3mEfnHydw>
X-ME-Received: <xmr:bY5ZaKrsejQlTua2MpXtylmxZ0X0y0Kt4J00wQIi94VOrhrzRHLmH8IR3QkOCTUvPSSYFPP22RS6K-sjmT5Cf1iVfV-lXDT1CW_PuVnYqEzfVT675Z3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fgveefveeihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bY5ZaInskqbSLKttLrhChxXjbP1c90YM8r8LB7RDQlaoKEFVM-sbsQ>
    <xmx:bY5ZaK2QoQV-mE1TkpI-1rOfuvw7BnvlNL0OrocyVWak1eN50wrkVA>
    <xmx:bY5ZaPujKHR4gO26tHkTZ9rplZ6sBmdJdB5-1w_l5XjWvbtE6qcHqg>
    <xmx:bY5ZaGXlokAq9ncECWC1lgHbT9QfdtMRCKaOHjhyqfvXxiJPFi-KQA>
    <xmx:bY5ZaHPC2U0uQRiC76EG3AeeA799shek7oa9-eppV_1Q3ZE_XvHEim2O>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 13:27:08 -0400 (EDT)
Date: Mon, 23 Jun 2025 13:27:07 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <aFmOazVXXGpt8bLB@teonanacatl.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623105625.GB654412@coredump.intra.peff.net>

Jeff King wrote:
> The "seq" tool has a "-f" option to produce printf-style formatted
> lines. Let's teach our test_seq helper the same trick. This lets us get
> rid of some shell loops in test snippets (which are particularly verbose
> in our test suite because we have to "|| return 1" to keep the &&-chain
> going).

This is a nice improvement.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index bee4a2ca34..8c176f4efc 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1454,6 +1454,13 @@ test_cmp_fspath () {
>  # from 1.
>  
>  test_seq () {
> +	local fmt="%d"
> +	case "$1" in
> +	-f)
> +		fmt="$2"
> +		shift 2
> +		;;
> +	esac
>  	case $# in
>  	1)	set 1 "$@" ;;
>  	2)	;;
> @@ -1462,7 +1469,7 @@ test_seq () {
>  	test_seq_counter__=$1
>  	while test "$test_seq_counter__" -le "$2"
>  	do
> -		echo "$test_seq_counter__"
> +		printf "$fmt\n" "$test_seq_counter__"
>  		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
>  	done
>  }

Is it a sharp edge worth caring about that someone might
write `test_seq -f 1 5` where we'd pass 1 as the format
string?

If so, perhaps a check like this might be sufficient to
catch it early?

	diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
	index 8c176f4efc..87b59d5895 100644
	--- i/t/test-lib-functions.sh
	+++ w/t/test-lib-functions.sh
	@@ -1458,6 +1458,10 @@ test_seq () {
		case "$1" in
		-f)
			fmt="$2"
	+		case "$fmt" in
	+			*%*)	: ;;
	+			*)	BUG "no % in -f argument" ;;
	+		esac
			shift 2
			;;
		esac

I don't know whether it's worth the extra code or not.  I
just wondered about how it would fail in the face of a minor
typo.  It certainly should cause any test to fail if it were
to output 1 instead of the intended format string, so it's
arguably fine as-is.

Adding -f to the usage note above, as Justin suggested might
help folks avoid making the mistake of cuddling the format
string against -f, e.g.: -f%d.  That is caught by the
parameter count check (though perhaps not everyone would
notice why, thinking they did pass an argument to -f).

-- 
Todd
