Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23C1E1E16
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668253; cv=none; b=LsW0LUSrbGAuytpu8YQeKUnKPubHSBbgZCnf349pjQm6bWyavFmADDNpUjVWV+isz734LL4yZ8FJE71qVPDla5Gb2QEZCLvWs4ROFBofAhPIfS5uYzmIQuzXufqpFr2B14nEuyZi4XBFT2y24OocUgung83kXd69p864a/FYTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668253; c=relaxed/simple;
	bh=vv8963/Uhg5Pjt3CVo96yRyyaDVrR1+7CSvnoLomxqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYYVF5HBNtVKs6/ohpFtebXbaUnIMqWx81PMy5iCxu78adu5d3iRCNZZ1H45Af0V0pTvDo6Meb4MjN/cGvxEynJyNg6GGG2e6hIwJx+ikYLZplrGXmOMkIqfFSHyLz0msdXwdohX45dDRMsL2KYl9/IZ3jclLno63SbRC7EngWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=otF+cWQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=peCJ3fg1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="otF+cWQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="peCJ3fg1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B26213804EF;
	Mon, 14 Apr 2025 18:04:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 18:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744668250; x=1744754650; bh=VodvE/sR+t
	SkunRR1ZRs70Y2OnuELfKeXuaTavQKwYo=; b=otF+cWQ8rs1TrRVJLHbZppCSUF
	I9LsEyWQe5lgXhcYCyyFt+bFhedrgeYzogQMHDdI2lV4CMlNwDEiuGQSQH46V3NM
	W5QL+c2CCddcPr+LY2IBLp1eVOM3cjxqpVuSdGhYdefsD+DWi2isF1CZT2VKoJRG
	PILvOCzy1ZPwYfIBzLmtT2hJ+ufJ0thzkELL4tuZh1mXXKSgWUuT1hQDaHqn0vJi
	YXDMSAdLTKFkumHwwo+Ppxe8/nS8k8gLeFk2hzfiYyzswh1eBpzTg375kJcfWVaw
	CCYhWsXWlbbws5aUT5Sk0bFNzyl1v02s04w0ptntMe/Mw5N28BPoMR4a4vPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744668250; x=1744754650; bh=VodvE/sR+tSkunRR1ZRs70Y2OnuELfKeXua
	TavQKwYo=; b=peCJ3fg1LmWzODiBf7TEr38HuIY/YN4qW05rV/VphMP7LckSxYJ
	vsy3Vg9NgeEMEUOauiidIUSULz9pPAEsqXy+KFnZGj5WQC9tAORsQcorq8aV80Ne
	PeWmbfPM57NlbDI1A5ZdH6paXp3T9U3twZTG/0hgGiyK7PrDpSU9y0tBY0QhN7Or
	epLkOlu1Dq8Ql7FJ+a6hvAfnCcvVjXBh7Q5ZUOE6dSnouOPO5ioURfxglzRhIxt0
	Ev12P2SwKcaGB5ih07enpW377a1KsoPAbpo4VcQaouEL1onsvoEEZvZg2iSFlwzd
	BkziUOMH7Pf32c90KEJYGIXG43yiVgD/VsA==
X-ME-Sender: <xms:WYb9Z803SEIosJobN7DQJw2JtZT-O2outmeLlEZSi8721xOYK6Aoqw>
    <xme:WYb9Z3EM1JnTe5HbwJgTVznFNAFxNE957vAAy_lJpOcNpR-A2IwgEBp7Xf56hHLJI
    bLSgL1raARMVsKBoQ>
X-ME-Received: <xmr:WYb9Z04qA3C38XpayBKkX8fqlehWPqr32t0Jb3ivgmFC4DOvSnGXon2VeyppACEwhPWpZTOsSVd1WPIjShZ-l-Ncj_AY09pUmLNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmih
    hlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WYb9Z12DJnKc3zmUgrsjg1iUkm49lGinYSXLeIPXfOjweWgNawqa-g>
    <xmx:WYb9Z_FAazC-kqKhMF4a9PcU1DOw8RmUcmZFEIk5VPqJF3YABH0eiw>
    <xmx:WYb9Z-_IFVcuoIbV1KGJ2hwEM3NAjMmXjVnECs_KPSvZQMHWqQwMQg>
    <xmx:WYb9Z0nZvpfPgZzNOI-gu7X_QZmdNdRWkBU2ah9rdFoKfPvlJisukw>
    <xmx:Wob9Z-w9pr1GzS4TNdXYPOV1OJYU-v6FAXOB3HQSIW2N8_xX2jChW72p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 18:04:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] promisor-remote: allow a server to advertise extra
 fields
In-Reply-To: <20250414160343.2216312-4-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 14 Apr 2025 18:03:42 +0200")
References: <20250414160343.2216312-1-christian.couder@gmail.com>
	<20250414160343.2216312-4-christian.couder@gmail.com>
Date: Mon, 14 Apr 2025 15:04:07 -0700
Message-ID: <xmqq34eapfhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  
> +promisor.sendExtraFields::
> +	A comma or space separated list of additional remote related
> +	fields that a server will send while advertising its promisor
> +	remotes using the "promisor-remote" capability, see
> +	linkgit:gitprotocol-v2[5]. When a field named "bar" is part of
> +	this list and a corresponding "remote.foo.bar" config variable
> +	is set on the server to a non empty value, for example "baz",
> +	then the field and its value, so "bar=baz", will be sent when
> +	advertising the promisor remote "foo". This list has no effect
> +	unless the "promisor.advertise" config variable, see above, is
> +	set to "true", and if that's the case, then whatever this list
> +	contains, the "name" and "url" fields are advertised anyway
> +	and contain the remote name and URL respectively, so there is
> +	no need to add "name" or "url" to this list.

As a description of overall syntax of the protocol, this and ...


>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 5598c93e67..f649745837 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,39 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The server may advertise some promisor remotes it is using or knows
>  about to a client which may want to use them as its promisor remotes,
> -instead of this repository. In this case <pr-infos> should be of the
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>  
> -	pr-infos = pr-info | pr-infos ";" pr-info
> +	pr-info = pr-fields | pr-info ";" pr-info
>  
> -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +	pr-fields = fld-key "=" fld-value | pr-fields "," pr-fields
>  
> -where `pr-name` is the urlencoded name of a promisor remote, and
> -`pr-url` the urlencoded URL of that promisor remote.
> +where all the `fld-key` and `fld-value` in a given `pr-fields` are
> +field keys and values related to a single promisor remote.

... this may work, but as we are defining protocol between two
parties, in order to ensure interoperable reimplementations, we need
to also specify semantics, what are the defined "fields", and what
each of them mean.  Proposing nebulous "with this framework your
imagination is the limit, you can invent anything" may work for
other parts of the system, but not for the part that is about
communication between two repositories.

IOW, we shouldn't be internally calling these "extra".  From the
point of view of "core" they may be "extra", but to the developers
and certainly to the end-users, they shouldn't be "extra" at all.
They are all supported parts of the system with defined semantics,
right?

Another reason why I hate seeing this nebulous "with this, we can
send anything extra" is because such a thing will have a wrong
security posture.  If we truly *need* to be able to carry
*anything*, we need to make sure how values are quoted/escaped, and
the code for dequoting/unescaping are robustly written to avoid
passing malformed input and misinterpreting it as something else,
which would give a new attack vector.  If we can enumerate supported
fields, their syntax and their possible values, we can make the
attack surface a lot smaller.

Thanks.
