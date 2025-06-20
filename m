Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FA2AD16
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453548; cv=none; b=CdMwcb9juC8IxSzf2K/mPJj2EcI5bJD2xVEcq6CsUzdAQUuB0OEuG3K/Y4xvcq4fsTvFlkV5n6u0Md7l2j+0a5dZloFYtwV2RnoAd5TSiCXAujabagjqflmN8ppQfeDuyTxzixRo6XJYCnmYq506ZGw/gDLLnvk+huF18UCt7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453548; c=relaxed/simple;
	bh=kv1ltTSQaIJ4MTDDbm9PZvfLOzbvy+NdRoHtVqS4Bqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GH0jBGbQzbwOrlzGECRkVsJp7i975lbG2pGBQPOaD8mN5V4fS28iefv6A4FMtXUnzf6cvRIHi/b7A5U5oXtQVq1vV2WDJRmuKlTHWaMIdbQhAmYk9IE7sfXaBjFoYttWnXMUh3vS8yNp9NrUsFO2nB57aypoTRdyHskl5Ug1Jg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BlXFKxI1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhJRl1AG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlXFKxI1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhJRl1AG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98F8E2540289;
	Fri, 20 Jun 2025 17:05:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Jun 2025 17:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750453545; x=1750539945; bh=1w0X8DN1ad
	L5Stp9QKcJ56aisoC3xdSlLkke1ccmhRo=; b=BlXFKxI1XO08eYKAAAHjZxhkoi
	6Jnf6+nn2KD0clAfTqXu5KHN/FpHDHXfP+IaUVn2Wytwl90uzi73VRDxrgPQ/MtJ
	I5K8JDEiRaBMYsAynb5TiCShTg/iyv4RWi27/xwb9N7Q/wfIuAtqW4fEIjYRH5cE
	Uv7DSi8rO+7eJSd2HtJbI1XQDD9F5KmmtGNea10XZm/oHouwGtVjwZASH3DSJJUK
	W5VsCDIY8OwJ3Gcst+7w7UiEIgnhs1mt1ww+987PgmDBL9vOWVuNX+jQYAthF+uQ
	OZUfOwCxicpFGRcIVn0ZYxGVS/0+XGGUj3rlNFE4E+Fx4hRvDRmWPN1KMbNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750453545; x=1750539945; bh=1w0X8DN1adL5Stp9QKcJ56aisoC3xdSlLkk
	e1ccmhRo=; b=JhJRl1AGMvUgDf/i6KyUibQe1zZGZhrrYvH4I+nRh8chXW3evVS
	wbNzbLXgjoEoZ6FHQ8cyFmzyxI+c4xxGwPEG4syGQClbtjcbYQdrqMwMhb9f4drw
	mUxMEf61v48RlCcP/a6J3ro4c0z+UNR3fPhoqc4TxhiLezoUU/1Vm56lS7kSaFRu
	NB/He03YWcCCw5dQLT1yRl11gslRVw3J80gELLhuDFUBD3TRiA+qNDvNKto8KdTL
	lV8hilYtGrAVQOksmLXInj/vaWZeXrRTSMvp8hxWXyYuxs87YbHtVmgw2N/3+7pr
	MC00wL2CGkYxrclN7LmTbHLnKZOkSsax9ig==
X-ME-Sender: <xms:Kc1VaNNqS4Nk0dqZnVuPvjrUmH3Pp2bbxYkhgHDGYoey3AjEuNLLlw>
    <xme:Kc1VaP8pkGXizoyyr5iYZAPtHjkQwIiFSO_R83HX6YSaFZEorBsgqJCmK8nZaEgk7
    DmTWkIwIE1_ndXv5Q>
X-ME-Received: <xmr:Kc1VaMRTkZQiL0Bob9Vgq5_JunK-HJ-z0k4qtveN-IoKEwMEAa50e30lBLAO8V-bJUmXKSy8Lq4ZncLCJjUNwufsJFpCB5rSlm5q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Kc1VaJsutkhFptEE8E4hmlI03vgLejVdAHDv690YMn6n8iC5LbOCfg>
    <xmx:Kc1VaFfemEA9N2SogpAF8Un_3YcWjU7keVF7E155K17GXbBIns5-lg>
    <xmx:Kc1VaF1x88P8AOBi5Cro6Qn9W7zBn5QB38Sc5vuTvEdi7ndC6MZAVw>
    <xmx:Kc1VaB9k2sAzc3B1TMH3JF6tk8r_TqNU6d6kWHcObfjZFmbcmg5I9w>
    <xmx:Kc1VaBoF1fRHV9Z8xohsbnPQ9PHE713a6ZUkocqDEHnixzp7r5M_hdEA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 17:05:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/10] setup: use the default algorithm to initialize
 repo format
In-Reply-To: <aFXEgLRLRdbaPOb2@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 20 Jun 2025 20:28:48 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-6-sandals@crustytoothpaste.net>
	<xmqqtt4a5upb.fsf@gitster.g>
	<aFXEgLRLRdbaPOb2@fruit.crustytoothpaste.net>
Date: Fri, 20 Jun 2025 14:05:43 -0700
Message-ID: <xmqqqzze15ug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > -	if (format->version == -1)
>> > +	if (format->version == -1) {
>> 
>> And if there is no core.repositoryformatversion set, we will come
>> here.  According to the comment before handle_extension_v0(), some
>> extensions.* should still be honored even in such a repository, and
>> the above call to git_config_from_file() should have handled them
>> just fine.
>> 
>> However, I do not understand why we clear all of what we read with
>> another call to clear_repository_format() here.
>
> Because this is the case where there's no config file.  

But my worries come from that .version == -1 does not necessarily
mean a missing config.  Missing config will give .version == -1 but
the opposite may not be true, no?

> If nobody
> bothered to write a configuration file, then we want to reset everything
> to the default.

True.  If config file is missing, yes, .version will be -1 and
clearing may make sense.  But if the file is missing, we wouldn't
have anything to "reset to the default" because we wouldn't have
read anything, so what clear_repository_format() call initialized to
the default before we read config from file would still be there,
no?

> I don't know what we do if we have a repository with a config file and
> no version, but literally every repository since Git 0.99.3 (I believe)
> has core.repositoryformatversion written into the repo.  I'm certain
> that the behaviour we'd want if nobody specified one was to do the most
> compatible thing, so the defaults seem prudent.

If our assumption is that no config file in repositories we care
about should lack core.repositoryformatversion, then what you wrote
above makes perfect sense, but then we should probably update the
comment before the handle_extension_v0() because it is stale.  The
new semantics is that any extension.* found in a config file that
lacks core.repositoryformatversion will be ignored with the new
code, right?  If that is our intention, it should be documented.

The current code will not clear, so there is a change in behaviour.
I do not know if we particularly care about this behaviour change,
though.

> The reason we need to read all the extensions is that different config
> options aren't ordered ...

Yes, that is where my "somewhat questionable" comes from.  We'd have
to read everything in and then refrain from touching a repository
with extensions that should not exist (i.e., the ones we do not
understand, or the ones that should not be used with the stated
format version) in verify_repository_format() as you said.

Thanks.
