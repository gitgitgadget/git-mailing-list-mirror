Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9602E9ECE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076571; cv=none; b=lwzv7y1me3YhjJXtQRepTmmzisSrvmFyKBZwPLyI9frbFwzuRUyH7N0BAO1lsfcsHi9S9qibJzuWB6YjSABVsaYgYRQxJF1RpGA9cJ4rFd50ZZY1oytryqPHEB/0iNZkpHFekFYqftHljRJHgQ8B0dDw0JlZp2LNYSmPitlMaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076571; c=relaxed/simple;
	bh=d2T4ZS7GhH3PzyY7YN/DX9ADswBnZ7bxVReZdq9i/lQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QSlZNfgDPa8BwISQAuILyniiePT150qR10CfA+0ss0JZtW5wwjDb3QOdA0TutRgcpEVf3MrTlbC4GXp0hSf3boVg1ugF/XtmtrEeAxHPmT3Wf4kH/sqfDFvztsGeaaWsLzqEnGZ5RbMNVjinbQwgjGUpbvXbkyvGgaOOCflKMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hUNFNa3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGLNANyF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hUNFNa3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGLNANyF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBE1314003B2;
	Wed,  9 Jul 2025 11:56:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 11:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752076567; x=1752162967; bh=PYcAVY3CpE
	Vo5Y+KMio8Ltu2vru4vTcsdKpXSEx7aN4=; b=hUNFNa3rEojRpJYpnjivIHHkNY
	yekuvpCCHJNJ4taLG6jR9zowbrPAxzZ+FQrerwI5qGY81W7QImnW5YLjeDfwDI1j
	vP8P887qtI3+NLmOUkADCT/La08pPIPnY8LiNQo9ouSCbqgFlqM4YL+ETjHC0w5K
	iIBZKy7Q7VSL+0fE0341JJQsUy5MVKHAq+4tePh9zoSD3LSoVgvKTNW23sPGnsJr
	4hPR1H7vq2PDixRDXREVg/6F6FYH9rqepmm80QDNxSWev57bYaCy0DE/WuWQHqxE
	WGwYHoxwtx7AbmncWO7ZgKV3hfsB+V4upY+YPzMzImm+LykrVRJYffBV6zlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752076567; x=1752162967; bh=PYcAVY3CpEVo5Y+KMio8Ltu2vru4vTcsdKp
	XSEx7aN4=; b=dGLNANyFvno8ZIYWpGj72wu90+bTQXEc5XGXQ4HWyEyKnjbrkFn
	CM8sm6jUkfa4zJshrKQyXUvorS1PikJsLA27oK0lws0VsZ0ZITRn2sVkbA1d0QJs
	of0o7gfGbt8gEmF7fOFOI1OfFMOErjp8Ca43Lb7+DWw3vCubTHvB55FFXshOdMk/
	Nc8vQ+RNJA75lxMQAGmEruLV1ZINbx0z/ZDolYe4ROFN41Lprp1LgtkLLgIWFkmQ
	0GjL/7GKc/v3trabJZ65F+pGZklWfa6oVJWLO+/gaXJkONVHje32W1DU9cB+AaRd
	FKx0mymrm69vPCulKsfJzmkxQxSOLTjCNKA==
X-ME-Sender: <xms:F5FuaEgfWPV2yRZ-_d0IwBOMjBi_nrhmV05BJ-b90PlsDO6xYlorVQ>
    <xme:F5FuaHkP6lZh7pPZVd6IqtaPX_FDpzpe_tTc7yDFqZjpRVqYVoGTMLutcV2or3zTE
    CPJXPsOVBqWidcHkw>
X-ME-Received: <xmr:F5FuaIpaO1YyWDOiTpNPL5DVZd3zGbc2RPYwIoV3ATkQL9LHd4KNDwaTQcpF_TsOUtCoUIKklUT1j5bp6fLNOkHBCA95eZlBaqH88aE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F5FuaIG-Ftt0aGxgDhd-3C3ewzJAfn_71YY485kaxmrgfqmPSJa3bw>
    <xmx:F5FuaMxQWYPlDGuvmomU__agMBxxO1WBmvpAzLzBpGMSOp4BoR8m2Q>
    <xmx:F5FuaFrCmRch3nfpSb2mrsoJ3-AWahZeQK8Pdh1OhSBJTv4an1R0DA>
    <xmx:F5FuaOiCOYMiYCmZERpo0pye0mOxT0NugE8f9VJbkvwKsGDPbR_odQ>
    <xmx:F5FuaH5k0ODy3QDxWCdh5yTkRCQOkpWjPgz-KJgbJgZL4dEqQrTFX0po>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:56:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
In-Reply-To: <aG51nFpH6kMT95uf@pks.im> (Patrick Steinhardt's message of "Wed,
	9 Jul 2025 15:58:52 +0200")
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
	<802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
	<77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de>
	<aG51nFpH6kMT95uf@pks.im>
Date: Wed, 09 Jul 2025 08:56:05 -0700
Message-ID: <xmqqple9nysq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/builtin/am.c b/builtin/am.c
>> index a800003340..c9d925f7b9 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -2406,6 +2406,7 @@ int cmd_am(int argc,
>>  			.type = OPTION_CALLBACK,
>>  			.long_name = "show-current-patch",
>>  			.value = &resume_mode,
>> +			.precision = sizeof(resume_mode),
>>  			.argh = "(diff|raw)",
>>  			.help = N_("show the patch being applied"),
>>  			.flags = PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>> diff --git a/parse-options.c b/parse-options.c
>> index 68ff494492..ddac008a5e 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -68,6 +68,26 @@ static char *fix_filename(const char *prefix, const char *file)
>>  		return prefix_filename_except_for_dash(prefix, file);
>>  }
>>  
>> +static int do_get_int_value(const void *value, size_t precision, intmax_t *ret)
>
> Nit: after the fourth patch we have `do_get_int_value()` and
> `get_int_value()`, where the major difference is that the latter dies if
> we failed to parse the value. It might be easier to discern which is
> which if we called them `get_int_value()` and `get_int_value_or_die()`.

Seeing the symmetry between set_int_value() and do_get_int_value(),
I tend to agree that it would be easier to remember what the latter
does if it were named get_int_value().

I am not so sure about _or_die(), though.  The only kind of error
the current get_int_value() detects and acts on is the mismatched
precision bug, which is a programmer error; there is no "die" but
we call "BUG".

get_int_value_with_precision_check() is quite a mouthful, but it is
known that I am bad at naming X-<, so I dunno.


