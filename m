Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD819AD70
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726797; cv=none; b=NPhg2qOcqgBFFUm92EG7GASHHxwVHDNTuD3T9n4lms9BquADhMtCvu0G5R4ih5TErcXUCBEj4KnDAGt15AixSsh7XADu/OcaBHIc/GjHvfgFyoaqeuZ5Dzy3ckLaZww9mkSCW8PBr8jNKB3EPT8Idn2LCH2H1DwC+XzoblOyc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726797; c=relaxed/simple;
	bh=IIZ36ryd+Lgra3p6MebeFETCz8WNH8skvOO19WWpun0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oouFKNq0q26Sf0CtX8BtmLaMcXsam4rNhVTXTXG02ZZzw1YhFszaL7c4n0MnjlTmefe0tY2MMNrFdLM9haELaKA89TiZN6PKKko0Ic41ZoR34YhGPIv5UOSlEmqLauGOOCc0/ZYeQbF5HRO/gvI7YmqIAFKpHH+MaHth8Xlq48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f520sGKX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEKGh8OT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f520sGKX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEKGh8OT"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3001D0016C;
	Mon, 28 Jul 2025 14:19:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 28 Jul 2025 14:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753726793; x=1753813193; bh=+FvW1redhc
	ZDuXFNPCzpNGZQL4IAnn2cVl0YC/kH8o8=; b=f520sGKXGZ28eRlx3Dbut3e2GV
	JzgrLrLUcex93+dAEBR4Tx8dkNI9bT78o9Q7a2HdeN4FD8+1ortoDMaM4YA+P90u
	JNwRFVGNuyAQbjFGexqagQOhct9XQK6IsR2JJIDB18vBOtDjZzXjnc2Q+YmenPwG
	9cwpRxr7xvRWrudrU43cNqhKYG/lKji9WKQ+KMkMaxuHU1yuie/dzwVv4RZi9SPU
	fjYdtecfFjr2DYJPXHvmOiXRJ2BFvQ2znz7Tx9fqqUuuM87D0nbWTS6YNgl/MfxG
	H4RGn7EP9X4/DgyJveNl93bTNsVraCMof6Svru7egBb8qKutPsYTUTCr4HHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753726793; x=1753813193; bh=+FvW1redhcZDuXFNPCzpNGZQL4IAnn2cVl0
	YC/kH8o8=; b=kEKGh8OT2Ia9cEGpCiE15t2JP9eEZKuveXd0qPVb/+xTxEpXcKP
	+B4inezf7ZmlI8QPNHUqyp+HJQ0eAiA0BfsY6tj9H8JZOnc8GaH4G51X5ibzamG/
	prL4QfN/5c5z2QRqDNJ4Kzn1lsahmxt5PpXIcBBzatd0C8qWpjG05P4IZgszmU/s
	olBonGCrjGx2vlzRMRbbYvRPRy4C3WrzbvpQNfi7i2Iq5jUuuPkVrMzCETAAhZmx
	T+nbJwZJoJi2SkeHwzAJcFeWE3lZG25/BmuC7yfeEJLbMIB7ljolHDtNM+SiYgdi
	/sMVVBpu8Qnvi9Y65HO2xGdfnMQLj1SE+jA==
X-ME-Sender: <xms:SL-HaGCKA_W0I0XuaAkQtFW4dSuihnEIhJu9wYRn3ayXpIvnswYJjQ>
    <xme:SL-HaI-FF5oyjVioZ4gpJwsGBsWu1us69QHJs_Yn1gxHMSlJluqKxlK3PUMr8tFAi
    3Bl4aT3wkFA8QFE7A>
X-ME-Received: <xmr:SL-HaKDHw8M4KGTIWEfdZ0sXCZZVN1S-2GwpTFR--y2jmxfRs7uSI54L4c5WR2kha3t57Hl2qXOuTQ758G9poZzj-DvM0TesULlFkJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegrjhhrhhhunhhtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Sb-HaFSOq21r6SXS93tfrq6czCBJ266WPrqRR3FK0WMAAnP-dJ3SjA>
    <xmx:Sb-HaJswi3C1nS_IzB4L3310uxTkH4yZowYowWO8C0FLq0MrWxMfcQ>
    <xmx:Sb-HaJ1q2z_aoKTujhm4VpbtfbHJm_pRz3ryQAIEBE4pZpNkWDe4Qw>
    <xmx:Sb-HaCV3v79IiBNWmoDPk1duSVr5KqF-ufoc1EhrpJHW7SirCNf8kQ>
    <xmx:Sb-HaH9FINQ_AsrV4JeWMEwWB8iwOukkeUfDshOdpt-qcUFxo496E738>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 14:19:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Andrzej Hunt
 <ajrhunt@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 2/4] parse-options: name flags passed to
 usage_with_options_internal
In-Reply-To: <xmqqjz3sxro3.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	28 Jul 2025 08:26:36 -0700")
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
	<20250726165320.4039-3-ben.knoble+github@gmail.com>
	<xmqqjz3sxro3.fsf@gitster.g>
Date: Mon, 28 Jul 2025 11:19:51 -0700
Message-ID: <xmqqseiguqig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> For example, it ought to be sufficient, for the purpose of improved
> readability, to instead doing this
>
>>  static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
>>  							 const char * const *,
>>  							 const struct option *,
>> -							 int, int);
>> +							 enum usage_style,
>> +							 enum usage_output);
>
> just do
>
> 		int full_usage,
> 		int usage_to_stderr);
>
> here.  Dropping the parameter names in the function prototype is
> allowed, and we encourage to do so in our codebase but _only_ when
> the meaning of each parameter is obvious from their type.  The first
> 3 parameters we see above are of distinct types and except for the
> second one being the usage string given to the users, they should be
> obvious.  But the last two unnamed integers are not obvious and they
> should have been spelled out---otherwise a developer who is adding
> a new callsite cannot work from the prototype alone and has to go to
> the implementation to figure out what to pass.
>
> Adding two enums for this is a bit overkill, but is OK here locally.


And with that lessor impact change, you could still add a smaller
change to help callers (you do not need any change to the callee,
which uses biased parameter names for these two), if you wanted to
(though as I said this is internal implementation detail of the
parse_options API, so you do not have to).  For example, you could
do

#define USAGE_FULL 1
#define USAGE_TO_STDERR 1

without anything else and do

>> @@ -1088,7 +1099,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>>  		}
>>  
>>  		if (internal_help && !strcmp(arg + 2, "help-all"))
>> -			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
>> +			return usage_with_options_internal(ctx, usagestr, options, style_full, to_out);

			return usage_with_options_internal(ctx,	usagestr, options,
							   USAGE_FULL, 0);

which may make it easier to follow.  The point is that you be more
verbose only when you do a non-standard thing.

And without enum, of course you do not need any change like below.

> One way to reduce this churn is to do
>
> 	int err = (to_where == to_stderr);
> 	int full = (help_style == style_full);
>
> at the very beginning of the function.  Then you do not have to
> change the body of the function harder to read at all.
