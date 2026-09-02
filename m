Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2061411A01
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387094; cv=none; b=G0V/2etgSXbTUaoBLmnMngBwmN56j55Kw9RuEaHg+dROA1zXdFyGz4+dLBD1RscvOFEkRg9a0iHxvTVlVj+YAAkR5FQANSLtU9UYEjwTAfMSxv/Nm4thH6Vb3eY14FLQgjNLyZ9TvUF8voi19xVbhP3Oz1PDMXK+oXPr0LkPuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387094; c=relaxed/simple;
	bh=ki0er0TJwibfHvV0XbPZr9Yu+oKvwlSleQYPDmCs/GU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqmSPvn9hcxCy2fHfEHkJP0Z9MwQ/ivh6gcDgkH0fAKIt9xz4K8k5+EyShdmmMO/wV83hZ+7PCLSblFl8N4s8BhUCsu0YhwjJ2xtACKjCGd6IO65zrfWhG0yip2b3djEjFtEAK5mJAr5Q0CYPG5jx8n05i+lP35i9KqG04BY66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EWKN9ykV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hb87qs/8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EWKN9ykV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hb87qs/8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 848501D0001A;
	Wed,  2 Sep 2026 18:11:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 18:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788387084; x=1788473484; bh=OcMccW4Oep
	q+fBQxzyUsNTK9iGcdj/DVgechI9zvNMo=; b=EWKN9ykVTKm/G0imR8XgL9hkFH
	nhy1i2LQbfanTqsCsCwb6m/B1ImLSVpA16dSWI64aVauoDub3LFrF8jinRUTrUaY
	LNQ2kZxLyR4EOqugwZXwxOOwgVKliNt2l5cb79razTtjP4Iy79zkG8RcT/WkcxAJ
	xVNW7EUxY+Pf/ZlS9hkhzIajJexlFah60JcpsEU/Ok5o4hngmI67zwdFWp/WLFfa
	DoCikmD4taIzxuTQv9C60UjwHCM2LxKauzpPWQW4oHtkcdMmyQiiJxJmh5OxhIkg
	4Y3bKfRbVfTFBEZD8YOl1mA67c2OMWq+5oXv67n2RMHPy812Tfi71N15snjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788387084; x=1788473484; bh=OcMccW4Oepq+fBQxzyUsNTK9iGcdj/DVgec
	hI9zvNMo=; b=hb87qs/8p6OuIn4TXOmLdrL4uEssX1M+a0/28T3H/MYVtw8aClz
	qPW8AGeIqMmHWq3Ny+CS9J+/zO+Bsk0yOqcCQMRecaJNTnhefP2KkvnjOAanbOzA
	hnTPzo/wYcELUU0oEiliHPC/3hs2S4XF9Q7upaVb4YamrkoqVF+ixspU3a/92HgE
	mjhjPRZcAFXVUgDOTbOcL97gPDVqgn7+rFOvGuNb8bTTNCH//fLWQXcMPRTisKZD
	Eno9MYQIaYlR2gzQXHwIs/3kYOQPapGcIIApXNydpqEWq1xM1xK7XwGy4Fdqr3W4
	09jNhSGOjf6L1nxzksW6jcE5VkCiihwtBTQ==
X-ME-Sender: <xms:DJ-YaqMwtl-5QmNnOeJWxFXBZsb8O-g5FwQAI50fcOCgN_kdSDTSiA>
    <xme:DJ-YargHPdPdUN29KyisxzkJa8sA5QgiEzAL4J0sGsu4cL2QtyY562QZHSRktS-oR
    HEqqApAxxJhGtxUX61jW_P2Wo6Eb4L-UYFftcqGGlMLBDfzhTA6qes>
X-ME-Received: <xmr:DJ-Yak5uqfri5_GvHMjT2n4DUrlnaQPMc2eRERaOc4kga3829E1vmeQgkRgYiDJ7qaf0SlEG21Vtm5VpnABPM41mMKzTdVXAHw>
X-ME-Proxy-Cause: dmFkZTEzOf9KCv9wSYD1gwKnp+u6pRoRj2yJ1eN7gH+hYhEhqMwPuIhagIVG3fdzYMcmly
    /KRUzjJTdC9qPQc52O1qWf4P5nFL8x5Ux0gvt+Y1I00W7M6ykAAv1v/PCu//UlmG4BVFFF
    5jQy0To48wPGsIszRsj3uV4Q3lOSlI9pr5calv4iHC5jgU45pg3RSFUH1E4ScdsjUBTYXP
    1iyxznp3mUNPVh7+PXn4xD2nYtSE3Vgi+z+MAuSU1U0veDcvMb5rpMkQ0kml7dPG42g5Uu
    OStzvRtjziZ9k3E3ILJXVQ3Zdd7i6sGGj5Jwsf4l5s6HvoW5bqqrRldE6LKaNskZUYOfG/
    +vj8g+3hYDb71hIKutM5oQIYAz1bZz64Xn2ZLMOBqxJIoi+14thLXT3fnmI+3viCVZtsny
    vULq7HF2dbrguq1ONzvwcHuFK4cwHBIY87xPbfrwZDVGofnf93RV2bOw/RwTEtui7hz/QS
    HmBBjs+CUNK1Qtld4z7AVaENX1USOBuxKmJXVMpePxlvIWsrw4guRT3goGwmXfVoloAnl5
    Fvk4SV2blxsZJJBn5PLcO2fvFjlPEZN5GvCQABSylrGk4hfwSbceorC/aI5czCQSLMhCag
    dib1LW9BUgOX2SmiYwSGec3Pcq3rKeuE3Pn5/sMhR2npoXDuRRXjRlrYSllA
X-ME-Proxy: <xmx:DJ-Yaq3AslT_J5l5EBGwpSfiuVTH2kcilHJqbR_XXKh-Vwdu4HoC5g>
    <xmx:DJ-YanunM9CGiXlLZgig27dVCjk_o20gNDMse34ipmJgXgsTJ8AGVA>
    <xmx:DJ-Yao6HfC_Q7_ShLJ3Ahdwkex-xlQdbMTgsqlZeaDLDvtsO7cBOmA>
    <xmx:DJ-YardHvv0bNFspBUUHQR2Qt68rK4rDzq7v8d-EGi5XFtFzCFQP-w>
    <xmx:DJ-YahgjVCIRUcosT-lWD5it-S9nTRNQwJn1QpEI5sUscz54mqeFRRcW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 18:11:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/6] parse-options: add early_scan_options()
In-Reply-To: <20260902161047.476753-2-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 2 Sep 2026 18:10:42 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
	<20260902161047.476753-2-christian.couder@gmail.com>
Date: Wed, 02 Sep 2026 15:11:22 -0700
Message-ID: <xmqqy0djfgmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> So users must spell these specific options in full. This restriction
> could be lifted in the future though, once the scanner is adapted to
> accept a command's full option array, as this would give it the
> complete context needed for safe abbreviation matching.

It is unfortunate that end-users cannot tell if they are dealing
with a system before of after "once the scanner is adapted"
happened, so they must be trained to always spell the options in
full to make use of the commands that use this feature.  It at least
does not regress relative to the ad-hoc early scanners these selected
commands have that do not even understand what they are parsing, so
it may not be too bad.

Stepping back a bit, the burden on programmers to use this would be
to write in a separate notation what options there are in addition
to what they feed the real parse_options(), which cuts both ways in
the sense that because this does not take parse_options(), commands
that do not use parse_options() can still use it, but those that do
already use parse_options() need additional work to use eary_scan.

And then once the scanner is adapted to accept the full option array,
the programmers only need to discard the struct early_scan_option[]
they wrote and replace it with the struct option[] they already have?
Or would the calling convention to the scanner also change when it
happens (oother than replacing the pointer to struct early_scan_option[]
with another pointer to struct option[])?

> +static const struct early_scan_option *
> +find_early_scan_option(const char *arg,
> +		       const struct early_scan_option *options,
> +		       const char **value)

Because you return one single element from the incoming array of
options, it is mildly misleading to call the variable/parameter
"options" here and everywhere else.  Let's stick to "arrays are 
named singular, so that option[4] names 4th option" convention.

> +{
> +	if (!skip_prefix(arg, "--", &arg))
> +		return NULL;
> +
> +	for (; options->name; options++) {
> +		const char *rest;
> +
> +		if (!skip_prefix(arg, options->name, &rest))
> +			continue;

"--option" on the command line, after getting stripped the leading
"--", may begin with "option", and that name may be in the option[]
table, in which case ...

> +		if (!*rest) {
> +			*value = NULL;
> +			return options;
> +		}

... we found a hit.  But shouldn't option->takes_value be consulted
before we return to signal the caller that the next arg is an option
value before we return from here?  It looks a bit uneven as we do
that for stuck form "--option=value" here.

> +		/* Only an option taking a value can be stuck to one. */
> +		if (*rest == '=' && options->takes_value) {
> +			*value = rest + 1;
> +			return options;
> +		}

And if the option[] table had "opt", then "--option" on the command
line may begin with "--opt" but "ion" is an excess that is not a
stuck value, so we do not consider it as a match.  OK.

> +	}
> +	return NULL;
> +}

If we are to write a separate function anyway, I wonder how much
more work to write a early_scan_option() parser that does take a
real "struct option[]" array.  Its elements already know if they
take a value or not.  For expediency, it may be OK to start by
simplified parser that does not handle unique prefix and other
complexities like callback functions of the real parser, but at
least it would reduce the burden on the programmers quite a bit if
we used the real struct option[] array, I suspect.


