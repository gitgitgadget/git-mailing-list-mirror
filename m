Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED52E0B58
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148569; cv=none; b=GjR2BiVAwCymehX407vvSNX0BCGdNTwcpXznXCRzT8e/OXeoNSE5X+rhtk3a/fySimUtD7xwGdj7WZL93mGMyiV4ZQLQaInKRppDid7zwT6Uh5iyUgv+KfonbZxgdPdXrrh+5xsMgtm4rnizF8rr+qi1TzKUmUGNvILPdQUXgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148569; c=relaxed/simple;
	bh=ez4irgIIwQRT8rIGsP6RDL00nTTFDjBbS6piJGJDLrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTY21DGiBo358Kgvknz9cBA3Z7T8tBlyMr2Qe25u162UUj8YVg0C5xQk4Ra2H3gRsa1nsLNserZMzCwto4kwlSPSS1kY8yJgXfDyGJEBsNwOwrHBkVx9Icxp5apGo3VSx9/7Rj+sjfTDeh05KMc/x7S1xFkL0WIekOoO2BC9JCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AFnub8rB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4lJYIne; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFnub8rB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4lJYIne"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A987F7A011E;
	Thu, 26 Feb 2026 18:29:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 18:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772148567; x=1772234967; bh=JrWjWy3wOC
	fpMoJlV5iczaXpJmtvg5FGzIDy9aNNsrQ=; b=AFnub8rBO4XgkSeOwdnCAUEO62
	y+ajMXAZMPGfDXi/A7tyEzDj4waZqklxiDsmeHmQgb/p0VTO5bK5NQ5TrzhvQEGg
	zqUzJWQj6Ltz9UdjP7Y66+63moKXfy2yq2Nzv1a0nbeX0pgKdujRRCSt9PRgekti
	cCZhUprcLzD9X9cajt6GEszkV4onJwzDlj0r0TOaTOmN33ZDOsxuOCwtzMwJYwwI
	djwAdcSGVDfWFEs3vwuxGg13WZatT2Rye5n2a9T0eooIWOIch5n945bVebeag0us
	rQHAg9jTdAT7s5QYlqBMntHdMeRTShx6nJwh3Q5p5dEGOe9qslb3qJGF23dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772148567; x=1772234967; bh=JrWjWy3wOCfpMoJlV5iczaXpJmtvg5FGzID
	y9aNNsrQ=; b=e4lJYIneZp6yqez/iBdbJ9/QBp/mMigoqWaNOB8oCfzgYArCZ/U
	KNTo+7WpsqSMX/0kRRc5ycdnbqL2W+Z8VIxGZsHCFXQSYJLVbIeF6WLE+FYb9D7M
	hTG45iBvZYVLxZzjIgcgwnHSvrbJqkXKOgzO050fjVnWYJ32nGu815E9AGOBFJ+3
	urqiWDQ0jZBoSVZQuUBhNdUtPv6ACqoberWopNQpz1fk0wnJqGWUpHHUOWoGCvMp
	JPmHfmTEPO/UYa1MFoIHttRouck3u+6oO/qbEYrGoY0f9bp9Qgc8YGJ/feRYqMv2
	qmGV3OEdZgEjES0QiqUUzjUBABlw6MeBjsg==
X-ME-Sender: <xms:V9egaTW6v5E5cm9RP2r27QFNtoIj-EOAbtfoyoAznNPVJMGIIA5fcw>
    <xme:V9egaSmn-FEbBWhrnBAA0x9ZrHO07KnCWeMPMGMF_JOegE8ftdWf0TJgkMuF8oumj
    AvEYjm0KFwf4Vf5qDEhLqunDkuoqF-xkmUUA8o5E-GsEyxM2bgWmw>
X-ME-Received: <xmr:V9egaUYQxGKBKJYh7moGwMPBML8jwexVfMjLJis599U97Zperh3BXeeYSgInvrtbPjR8B7jCdNe_7mnohTvSEsVaY4bUHW530A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvshhlrghmrdhrvggurgdrughivhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V9egadPfwcGxiYA3uD1lAEK75g-8FWy-6zESKjeU0rGVMeIDcVCtVg>
    <xmx:V9egaZYUaaxCPGX6UgISE4YqZKaWeL_Y5YzfFJorOd1VZASarQwxCg>
    <xmx:V9egab3VGi4_fQjUkevrtjHh8Ry4-hVeXDWoDmS7clzK-LAVYoYgCw>
    <xmx:V9egaffimzVi9gdoHRXxN0-rhyaNTm43k2WNte7V_51So0KPXA1FhQ>
    <xmx:V9egaf4J_kyWIQekM1_mpzd6HRjMk5OTWpjlphd6JEYdjhAyyiUqLyFL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 18:29:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH v4 02/10] repo: add path keys to repo info
In-Reply-To: <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
	(Eslam reda ragheb via GitGitGadget's message of "Thu, 26 Feb 2026
	21:14:39 +0000")
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 15:29:25 -0800
Message-ID: <xmqqa4wvulre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Eslam reda ragheb <eslam.reda.div@gmail.com>
>
> Add a path category to git repo info with key-value pairs that
> mirror repository paths users commonly retrieve via rev-parse and
> git-path lookups.
> ...
> +static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
> +{
> +	if (info->prefix)
> +		strbuf_addstr(buf, info->prefix);
> +	return 0;
> +}

Can (info->prefix && info->prefix[0] == '\0') be possible?  If so,
"repo info path.git-prefix" would not be able to help users who want
to know between (info->prefix == NULL) and info->prefix being an
empty string.

