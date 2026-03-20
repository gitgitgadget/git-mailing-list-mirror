Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6282230BE9
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046174; cv=none; b=bIDtD1AZE4ToAPeO4e8tgd2nrPMKgA+qVmyTOSBt5s79pUPcFCfa2TTxXfHeN3W5d/uBO0sK7RjQeJAteat9+S0U0xjISewNAGtqGICpt+OPkEvx1FyUTZHpuEA6Y7WZTvj9qrbsAklhjfJThAvXLcQElE44hXChCvtF09DGQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046174; c=relaxed/simple;
	bh=472lFeeE0WwMl1yaD/L5nSa+w1rx7rTzEOtdIsWoo0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPgx9h0kjmCHNap3yamJZbm8SOivXp5AE3tyYDF2YppFFLTQx1x50QSoHGAblAHzaVhEFN17LDbfJgzrglvDcAhHqeNEjsa2wtUDepyCYTp/fJ0dR9QYt6XlmSvCFkvT0fYz8aoSdx7YmHLv1iO8OA1CyZ4yuO/cPCP/Q4tuS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bXZ4yu+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lS3Vbq0W; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bXZ4yu+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lS3Vbq0W"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE2E01400247;
	Fri, 20 Mar 2026 18:36:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 18:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774046171;
	 x=1774132571; bh=g5qe/XddtlsxkwlI9QdVlGX1vmW7kh9OGj6JLegOg34=; b=
	bXZ4yu+hxUAZ85h+NV4v6/TLUNVb7WZdYEuH2CBMIkU3UqiGKUrBqtoooow2FAHH
	8jP7rFdNajQ/GDyKFmDYj+heUE5gNUNB0ENcGdvd5QcCompavnAi/I9+fWuyJFOH
	rrU76QDbKyNPMQxobQstYM8kSs1iBb1YWIJU8n+fmJ/1jLkOmc1EZGtmrlXB4VMa
	4HXK9iQQr9Smt1ZkkSzQbAb9X6DSngiN0gLGL0ymqSqR+8ywkEvYsPgvQmXX9zvo
	Cuo2EfLfshttOEJjQzIovlJYTrA1I1Ll/MxDXhDqnqjmX9M1+5kf0dBtYZwS7w/2
	bTZ98T8n/jaEFhIm/rzmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774046171; x=
	1774132571; bh=g5qe/XddtlsxkwlI9QdVlGX1vmW7kh9OGj6JLegOg34=; b=l
	S3Vbq0WIcZxNqwdXijRyKbL5b8ixcbpxCP0VWreC0CbNFE+c+7Fl7hnmdQY0fC59
	M/qpP4gqbzuHjWUKVgqJ72O2w6mMR9WGVGc0WsdLdUrA+aevNE0HxRC2FU/SIWw9
	4wDhlzgk6VHf2hZzUqUw+u6xOzrCVdtZ0x0wt+PLoRrjkOyCW0QTIQsIJVXIw+b5
	gHGrkXQnDdgoKRSnzSvf/g7WrqDfTNCHuOrpCbrZUoZEw6gNq/85UsUPsnMf/KhE
	TFexJSCuzVWAXR4LgG2JWPH/A1Y+KvTLyIQ3PnT1oHxdOgJMjkJcAfFMsx6MqzIA
	8scMJybYSJJ+BKBhhMZQw==
X-ME-Sender: <xms:28u9aTGSHcnDIcZOBHgPww46EvtkH_Evi0U37MnP8GVuisttG4V-MQ>
    <xme:28u9aXw87SeTba4IutlvjJnfYA_t4OBEzAT0MPDjuU3o8nu9HGHtKwkwadpy9rIBr
    y81wTIb1rcx9rQwdt_SWtQDnf67hImg99OksGyOMXTJ0fbrNj5XAg>
X-ME-Received: <xmr:28u9aSgxKKNy-lBGeQfN6pDU5Jfg0p_9Y-stmjDdcQDMFCzy5yACidjk9B-o7r37mJqABq1C4zjt2fs_JLpTLOV8VuMz2HQ9xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhl
    vghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:28u9aaxh8X2LtwARxO1ubdqhGgiNuPDhz3I1cehZiD7ccf639RIwjw>
    <xmx:28u9adKZeBrav2754lbWW1eKWPZXs8AzL7eoHqZuIXiO7-9h9g61Ww>
    <xmx:28u9aZSrtZN2qVltRrX8Nezl91XbUIpv6GW1EFkU7lVAIYk9lPAANA>
    <xmx:28u9adoPxA4_S7MMx_B7IPNdF-3D1YMPKWTyKIcEqVBGBb6oMUWsYw>
    <xmx:28u9aZdQaxNvcMXzLkzA4m-ALcQ4zrfeiwuFQ_p7YopF4uXEVwvNkS_t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 18:36:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Add a config option to add a comment to S-o-b lines
In-Reply-To: <xmqq341ufn12.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Mar 2026 10:06:49 -0700")
References: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com>
	<xmqq341ufn12.fsf@gitster.g>
Date: Fri, 20 Mar 2026 15:36:09 -0700
Message-ID: <xmqq7br6dt7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Uwe Kleine-König <u.kleine-koenig@baylibre.com> writes:
>
>> As an employee of a consultant company I'm often requested to mention
>> the customer name in the Signed-off-by line. Add a config knob
>> "user.signoffcomment" to configure this and use it in automatically
>> generated S-o-b lines.
>>
>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
>> ---
>
> I know it is not the thrust of this patch, but I think you should
> think about this question at the same time, eh, rather, I do not
> think we want to add a feature like this without thinking things
> like the following through:
>
> How should this practice interact with commands like "git log
> --author=", "git shortlog", and friends?
>
> Would projects accepting contributions signed like so want to have a
> feature to easily strip the comments without having to add new
> entries to their .mailmap every time a known contributor works for a
> new client?
>
> And then there is a question of "what shape of comment do we want?
> is it OK for us to dictate that it comes after the author's human
> readable name identity enclosed in parentheses?".
>
> Shouldn't interpret-trailers be a good place to do this, instead of
> a configuration option?

Another tangent.  Stepping back a bit, these names and e-mail
addresses come from:

    [user]
	name = Uwe Kleine-König
	email = u.kleine-koenig@...

It is plausible that a single user may want to use different
identities depending on where the identities are used.  It may take
a form of three-level configuration variable name, i.e.,

    user.<context>.name
    user.<context>.email

where obvious candidates for <context> are things like "author"
(used for commit author ident), "committer", and "tagger".

It is not too inconceivable to have an entry dedicated for
"sign-off", perhaps in addition to the above user.{name,email}
entries you already have in your $HOME/.gitconfig, you may throw
something like this in the project .git/config file:

    [user "sign-off"]
	name = Uwe Kleine-König (Current Sponsor)

ident.c::fmt_ident() and ident.c::fmt_name() take "enum want_ident"
that lets our callers say "I want AUTHOR_IDENT" etc., and it would
be natural to extend the set of WANT_*_IDENT enumeration to support
more kind of names, if we really wanted to.

Having said that, wishing to be known under different identities to
different communities is one thing, but I am not yet convinced that
it is a good idea to use different identities in a single project
depending where the ident appears.

Thanks.


