Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C4281371
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608825; cv=none; b=bI3T6ivPBETC52sRyfaTiErLHOz9PPK0VtZdKHyJ3KOMdnx/p00wrNf+n54Pk9bKDtm3ApnxP+klLI5LfgHnrWJr5D2ANPlduDCE+WHZnCrNfaP0qcMlBSYvC30SZAecdl9CGK8IdYfaco/WWkRWV68x6Ucr27BBLqoxkHk4eYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608825; c=relaxed/simple;
	bh=p4qUYDowdaW2CjTXy9mc2XxyTnVDTMxsOvgQi/JVv7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J8xmldkocKj6i4Txq/ckVxqtWQ2OxKgSrLREzJdUfwtD03btEy0fGwaQVMsW0+Kj1axUNpdk+2aMDRJg9o4u+U7XfTrfAnsu1jOK/+ChJ/c6cZqPWxEyNdSXH1OvfJPLrk8lWjRNbi1dzqZlnRsW7CporYFu0JW5uPupNKXPKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xtEkUj4O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7RUKFtg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xtEkUj4O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7RUKFtg"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AAE61140191;
	Wed, 26 Feb 2025 17:27:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 17:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740608822; x=1740695222; bh=np9UxpdDRR
	fCGwaIHPZQyrDIut0DUHkUMWD8LHNR15U=; b=xtEkUj4O3C8CqYC0lexXiN7q1l
	GU5Y60j4TNls3tmSeBwS8orHkMjvIETYg4ZLIaE00ycKkR8yUl3WLeYJh8av/k22
	WYGa3xlIczw0L8uqk7dz0B2OCMzHQJVNf0D1AAKaS/ZN/is8r1k1Dc0jv91T9DQh
	7pJmuz453FsxbBV3yBVwjAQekpUCugufJdVVmR+mKbXECvtFwJCUDJvsyTZzcI0G
	4VIRUEVGWYKppJJvukHsS69J1Y7Rw5LQLsZ84oX2dMSoFWsX9t0MXmU4a9y8oN2j
	y39M5PCGw/tQ0seTodzI1m0jMlzJHsexpbPAWcY8G7oZ+VLaIAjRYB71ucBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740608822; x=1740695222; bh=np9UxpdDRRfCGwaIHPZQyrDIut0DUHkUMWD
	8LHNR15U=; b=W7RUKFtg3wsPl9hD1dmwUccSSCw96EBurvzNwyd7uZj/6IsHSsP
	QSH99D0aXRKuoA9oSM2CHPtVIdN82a/bANF+LzlqFCmOBvZZ3t5d7zsK3EdbILub
	+2n7/b8stcyiZInLrPzsH91M01keGOVaN+oyCSdv0P2NcMC8V4UROr1QCGut1X7a
	7eJDx4fvWPdTA+1QB01z1zubHX1aio3Fwm7IdeyYUCm5qXdgvX4UQvyGXzvlt9p0
	spy+SgT1o5cejHjHGSKqI2H4is3MDdmy4xpn6IQgDnkQqkXZ2IletqKa862jUiS0
	PGKFnIilWWc0TcwGde+6yqMI1F0nJgLNvpw==
X-ME-Sender: <xms:NZW_Z3oQRBB4FF9aIdL2aQtxF4QU2sUjdhpGuLGRETbJ_dc_b_EUpg>
    <xme:NZW_Zxq8Nli22JGyM_JiCQ1BrBdNFtK5y0yTddwOxsMvtmvzQvhfX6ePB0pQlHror
    T30GLI7dxcCEWUVYA>
X-ME-Received: <xmr:NZW_Z0PLpafUsjQuNANBQbPzQGE0gxS0Izg4Tk8oAqyew0VXC34qhS4PwqS9Usxl5Ye0oCobdcusD4occ1FcHQ2iqY6cEO-ahluq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NZW_Z64p3RZMuuErX88wTUYZewB6SC3StFXWyUYm0XitEVBvLVL79w>
    <xmx:NZW_Z27XSPze9YkZub0lMa7jeyXztfbcCW9nGQplLM9NHIxU3udKWA>
    <xmx:NZW_Zygq31oMPJt3yJRLVjFMVvvhYeIrrL1IVT_cluoEELh38LIFOQ>
    <xmx:NZW_Z450YjASkSRjE9CrYc52JYb123Ijj-ZiZElfGFigNa3_p7c6SA>
    <xmx:NpW_Z4sKuk7AY75UTYXoCFvK-ODMkfbU8zbdvLktVoJ60PJKAXyMzoPe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 17:27:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,
  shejialuo <shejialuo@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
In-Reply-To: <20250225-pks-update-ref-optimization-v3-3-77c3687cda75@pks.im>
	(Patrick Steinhardt's message of "Tue, 25 Feb 2025 09:55:49 +0100")
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
	<20250225-pks-update-ref-optimization-v3-3-77c3687cda75@pks.im>
Date: Wed, 26 Feb 2025 14:26:59 -0800
Message-ID: <xmqq5xkwbavg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Most of the commands in git-update-ref(1) accept an old and/or new
> object ID to update a specific reference to. These object IDs get parsed
> via `repo_get_oid()`, which not only handles plain object IDs, but also
> those that have a suffix like "~" or "^2". More surprisingly though, it
> even knows to resolve references, despite the fact that its manpage does
> not mention this fact even once.

Are you referring to <new-oid> and other placeholders with "oid" in
their names?  I do think "oid" in our documentation implies that
only full hexadecimal object names are allowed.  The glossary agrees
by saying that <object id> is a synonym for <object name> that is
usually 40-hex SHA-1.  However, that is not strictly enforced and we
say <object> (or its typed variants like <commit-ish>) even when a
command takes any extended SHA-1 expression, as described in
Documentation/revisions.{txt,adoc}, not limited to full hexadecimal
object name.

So, I am somewhat sympathetic to your confusion, but not that much.
When we wrote the command and documented it back in 2005, we did
mean to take any object name that is spelled in any way, not just
full hexadecimal.  You may want to update the manual to emphasize
that we encourage the use of full hexadecimal for this command and
elsewhere where it is more appropriate.

> One consequence of this is that we also check for ambiguous references:
> when parsing a full object ID where the DWIM mechanism would also cause
> us to resolve it as a branch, we'd end up printing a warning. While this
> check makes sense to have in general, it is arguably less useful in the
> context of git-update-ref(1).
>
>   - The manpage is explicitly structured around object IDs. So if we see
>     a fully blown object ID, the intent should be quite clear in
>     general.
>
>   - The command is part of our plumbing layer and not a tool that users
>     would generally use in interactive workflows. As such, the warning
>     will likely not be visible to anybody in the first place.

In addition, if the user meant to refer to a ref, it is possible to
disambiguate by prefixing refs/tags/ or whatever.  So squelching the
warning unconditionally might make sense.  We will yield the value
of the full hexadecimal object name, instead of the value of the ref
that is confusingly named, so there is no material change in the
behaviour here.

OK.

