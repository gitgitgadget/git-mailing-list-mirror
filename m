Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05560242D6E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950042; cv=none; b=c9ICZXChimhlnDVIz9kbHcjcTMp4qmDRMtNh5mj56HJbEeao5wOx0WqN/ZI187KuPxZlVujXoYHfYAigV3DxyxzPA33SOxNrtAXClwQIMhlfHoCL6aBcvOuK8cYpL7kPf7PLWL8gmCiZ92t4TDH2xgeqRs7qj651RPvT6PvsuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950042; c=relaxed/simple;
	bh=9uHyrrLIFoiR7TBdbjX0a/P/soK3iWgnKnKjb2DFwos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQm/CT0lhqnUPY5UaKrwwVOXFwqDcGg0cHYA51Bqjgp1UmJWrMnUNRFtOPmEC19MyhpVcWgKJG6d1jms3OL18hxdGCMjBZRszqsztoxTY2TPP1x2jmqSnjHVYNA8NGFQ2+m48m64OFdwgasN9KAd51puey+gczGXbu1JJH8nrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iFAD183b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4JTXd3a; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFAD183b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4JTXd3a"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F0E271D0014C;
	Wed,  8 Oct 2025 15:00:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 15:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759950038; x=1760036438; bh=7VFaKM8ZAd
	M57XKcqTj1MUejVjDfQiockwuewtss/+A=; b=iFAD183bPTDpoP3E/9rZWgPFvB
	pvKgBDT3yMA2OKDLzKZWWDiW/1pB1v4H1yUtq+EOKREHuhbdZbi4a/BulBTIWAnW
	e6zt/0826G4xOLmWtrxh8edDnjzgCAo/Q4CPiGSKwYWTfnxzAyPdJqwW8karPSbt
	7s6LHEBSmOB8CMbGGZvbNjhJZMMG1wyRZ5V4kDQ2A7XogGDxN9hmbwD9W7/MPC7Y
	cA3PIQ53uSNStSAtTN/t8CVVuxpqi2mKC0pNnjkm3QvivJ2pkn5nNABqwz3rQsB7
	GhA1Cjb/QoAhT/B7eo3gS66EceMcRlXw1dZ8EwCT12a6DECjQpOEf/Ip+Kpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759950038; x=1760036438; bh=7VFaKM8ZAdM57XKcqTj1MUejVjDfQiockwu
	ewtss/+A=; b=B4JTXd3ayegmoqbEDyRsmvSnKXs/qWbwnN2fxQ13WSjPWvizjBY
	ENe1xTBVVBk2LDzllXtc0d8hYA1wDT3rf/jR/ru+asuMIv9RQw4ermU2ATPLYSRL
	S/FULKHU3ZimwvHJdgkwsInbaGhFdsJTn7cVAciterIfGUedhcN9dt2cfMNG21FM
	vVQsMFnBdDHX53OB6QtMr851VZ/fNKeu5L+leKw75XMKsE4wbHIaI5eOJXRthQuy
	EAedy9G28jSepeOYjIKax5t98TcZAkbME2LvsXIvDLoYTmkbtemu/OrT2IXBKf8W
	KRpUNbpOOBvWbeFFwxoUIRCuBz+EHqLN/eQ==
X-ME-Sender: <xms:1rTmaEal9i1za9B9-_Wn4AaPYMmTZqvdMl6JtyrEPrdFZf8Kqx7_Ww>
    <xme:1rTmaIuy9h5dL2BdMmU4tkSrFJLD23R4_SQTo8Gnj1l9YVe0d1yQUDuAFe-zHWX7u
    -dQZ9ViKrJNVUHv3dhQHxtEXsBoR7VqoRKX5hEkReowe_oDxq8yOkY>
X-ME-Received: <xmr:1rTmaGO2DFwcVEY7IdrAPWS4Hb4tsp5qTGrQ8QqaRqyfQP7DNVQesjbxfRqlSd4sbWXzwKv7EmY7bnz_YGDYLM9GKQfLZWPfMkW9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1rTmaP64uingsEQNLHUh-XtaYHVTGA8A-Y5jYQVyI9pNMAwZh0yhjw>
    <xmx:1rTmaMRu5WIYKnwvksqokucaiVXJ7tADiHbvKpkDyqdK8kiW9KexXw>
    <xmx:1rTmaMBFslCtDcm4ZaXaUJUYaRPPoKjfmMFYlkkpGYr_XKkrCUUJOQ>
    <xmx:1rTmaMEO1j7zb2GB85IsWZ1ixR884TZa-fTz3KMA3ljK99LKgGgkpA>
    <xmx:1rTmaMXaw3348ERGbZJHOCPv6sEhE9qy9O6VsRvy1Q6wPTDFL-zyrwqe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 15:00:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Elijah Newren <newren@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 1/4] doc: add some missing technical documents
In-Reply-To: <aOYImjMXcFkdwar5@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Oct 2025 08:45:46 +0200")
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
	<20251002221233.541844-1-ramsay@ramsayjones.plus.com>
	<20251002221233.541844-2-ramsay@ramsayjones.plus.com>
	<aOYImjMXcFkdwar5@pks.im>
Date: Wed, 08 Oct 2025 12:00:36 -0700
Message-ID: <xmqqfrbtfcbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This builds on our existing linting rule and would catch any discrepancy
> in man pages that we have in "Documentation/technical/" that isn't
> listed in Meson.

Yeah, I remember the existing check helping me spot potential issues
in a series or two.

> But regardless of that, the above check surfaces one more missing
> article:
>
>     $ make lint-docs-meson
>         GEN doc.dep
>     make: *** Deleting file 'doc.dep'
>     tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: byte 3877, line 206
>     Meson man pages differ from actual man pages:
>     --- tmp-meson-diff/meson.adoc	2025-10-08 08:42:49.864991169 +0200
>     +++ tmp-meson-diff/actual.adoc	2025-10-08 08:42:50.072988794 +0200
>     @@ -203,6 +203,7 @@
>      git-worktree.adoc
>      git-write-tree.adoc
>      hash-function-transition.adoc
>     +large-object-promisors.adoc
>      long-running-process-protocol.adoc
>      multi-pack-index.adoc
>      packfile-uri.adoc
>     make: *** [Makefile:526: lint-docs-meson] Error 1

Good.  I'll expect Ramsay will handle this one in v3?

Thanks.
