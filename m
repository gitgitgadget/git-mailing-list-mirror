Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA527B327
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223742; cv=none; b=ZtM5adqGnZpG4SFrw0J3iS+TelD4+a49e0PH+Qa0AkaWtvMGc6NadN+8XQcAtdJ2nHTWkKKvyBZ1NunpV2VEfOzvV1MzumYyRNt1wqBRtOHrT+QbOL4uH0n+J+9kwetRR7bN+SpR1K5VxD9dO0KKCNhDtmEZ13ofu36HAtvCBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223742; c=relaxed/simple;
	bh=X/Xop6B+7+6jBxUf9DxRf/H4NkAHw5ZUbq7kji0xAwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0CXduTfYQVE2uVGUTbb2Rw6IGscO0uEUN4cefAu3dnQBFWXUzcm47XJTDkE6W93QMY0/LMkLelGwpwRc5BJctgmHvKri2SMKsdwICAV/UscQ6OSKG3mAlkyO6X7eRondXcISetJfNjonLXbwcpBOBN0Fy1nnzBtJaixUcdvVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T7ESlFkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8dnpsBt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T7ESlFkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8dnpsBt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C9581D000E2;
	Wed,  4 Feb 2026 11:49:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 04 Feb 2026 11:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770223741; x=1770310141; bh=8CUV+NhcUb
	qes/g2zKa6VJCPQPlT3fCw+DbukW1i11E=; b=T7ESlFkE134DXY64ErGrULUQT1
	pQNNWaYlSMECDtEKJgXlVNsX41Egs7jbs7B9nO275/gb1iG2cEZm3QnjAOG6gmzW
	jhMGHVeiNH8InRzPRj5BuiD9Ip5eXomfYSmi8BMLeEg34GJuO2wH+ZZoYRZcb5A9
	E4N1TSVaYWoqO9my3J7FvPzOC2gbcQ5HxFZov5XZ8DmM/JA49orptsL9RdmmLZOy
	5zjsftz0d0CAyvu3iYC0aBIl5NgXI6JCh1yPKuI5CI1ViXmfPK978Z8mnwtSS7Xi
	jKExrtxXl+Rk0BmTFYcTDBQufHkhba/cgY5jquLGtpeHdws+jDsbMZUTAxHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770223741; x=1770310141; bh=8CUV+NhcUbqes/g2zKa6VJCPQPlT3fCw+Db
	ukW1i11E=; b=n8dnpsBt7jPf7xHVsQ2cjdKiDo6Jb7Nor+hByPBCtJRfFXnt0ZB
	6/gfU4PiM6YPV0avWZL1FiDU+y5twE7/kHME/MS+BMO6C1mvSa/SxW+TIV6RP2qK
	cURsaJDDqq3fZ+G6ypJHAloOQQRMeJbY5uFbJjtc9SA9TL0aQHXVI2uxZZAXFIkC
	FrI1qgNwAa7JZfmQDDn7+gCnvvo4z7slSlN6PBJmdiLVsVqvuzK2ypu/Vu4oLsVu
	tcEF2MJKBS/tnBAYaQHeTWpGBgODT9STGHrfC5hDAksqWLb2yy4EAH3jH3rAei//
	NvMH+zfOEXe6yDuYlRWoPGB+A8VWVSuJtuA==
X-ME-Sender: <xms:fXiDac2TSQOu4WPrn7HBjBsX_e1u1buCRZh6Usmo0slY8BCwEAJe4A>
    <xme:fXiDaeHcSOtxY3ANRqAD_pTFH_bKG21KNKItC2XDOW1q1JnRyYrO_6YRyiEC_nDds
    f-eZCtYoGbZ8jH_knJ3PKIy32ZMkR_8HhqKMoD7RqziDhNAehI9uQ>
X-ME-Received: <xmr:fXiDaZ4_zs_a6l4cb3DHjiIdpJ1dy-k4O2SFqt0jq1_gYyM6U9SSEG3NBDXBVrQbvUEmgnp5MAA2Gc9MqBPBL3kcy7dV8x-8zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehonhgvqdgu
    qdifihguvgesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fXiDaUsYwUoP-wWAgg3rGdqPf_2Tjj6zxoK1fwNqTVbgjgB2FG5UmQ>
    <xmx:fXiDaa7vb2zR3im-VfoDSX1cHuRLsVuwg3JlOC9OAGZzK3YDdGTPBA>
    <xmx:fXiDafWu_eMnNhYAQ9-pb-unO3zeTSvfGYYKT6ufCy8REnGhv-Di7g>
    <xmx:fXiDac-v-kW6EJMQgjg7CwelUhLj_9Z50Kdi9u16Y2s26Zz7JBGztA>
    <xmx:fXiDaX7tUU-HVSUdbQ0bIk8VJkpeDkiuY0N5wo9NXNJoFNYMoJYB-AIQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:49:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: git@vger.kernel.org,  Tian Yuchen <a3205153416@gmail.com>
Subject: Re: [PATCH] fix git add :!x exiting with error when x is in .gitignore
In-Reply-To: <20260204132747.1564157-1-one-d-wide@protonmail.com> (Remy
	D. Farley's message of "Wed, 04 Feb 2026 13:30:38 +0000")
References: <20260204132747.1564157-1-one-d-wide@protonmail.com>
Date: Wed, 04 Feb 2026 08:48:59 -0800
Message-ID: <xmqqo6m4pi84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> diff --git a/dir.c b/dir.c
> index b00821f294..ed6b99e337 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2280,6 +2280,9 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>  		const struct pathspec_item *item = &pathspec->items[i];
>  		int len = item->nowildcard_len;
>  
> +		if (item->magic & PATHSPEC_EXCLUDE)
> +			continue;
> +
>  		if (len == pathlen &&
>  		    !ps_strncmp(item, item->match, path, pathlen))
>  			return 1;

A question that immediately comes to mind is if it is appropriate
for a negated pathspec element to recuse itself like this from the
decision process and let other pathspec elements decide the fate of
the path, or if a negated pathspec element should take a more active
role of saying "no" (no, not by immediately returning 0, but this
loop may have to become a two step process if we wanted to implement
e.g., for the function to yield "yes", it has to match at least one
positive pathspec element and zero negated one, or something like
that).

What should

	git add "$x" ":!$y"

do when a path <matches, does not match> $X and <matches, does not
match> $Y?  We have four combinations to consider in such a case.
The code in the patch says it should behave identically to

	git add "$x"

and negated ":!$y" should not make any difference.  Is that what we
want?

Thanks.
