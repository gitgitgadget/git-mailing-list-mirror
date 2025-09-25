Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826D27467B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834403; cv=none; b=uhbqC/vwWtdBmTKimmg8o3FSkvElWnr5LJk6WqSOeXFyQhNOhjkHS+V2eW8JktjcafvIv9ZL0ymzKSl42KXOzQi4dC5C19OS+8j9ohosjE4JvQF6Noq9ToXoZgUQFw4Lm61nU3qZ+9qzRolfKjNMqQBLN5IwhYnjmfoWt/qwGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834403; c=relaxed/simple;
	bh=qQu8N8aRnpl7A2UNl2FXKD15wkDtRVHqRj0+pgwXFtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9h0BN0LzrO4d0NUYT7o1Q/kXaOsae2AftJ6Oeux37ISJR63RMwBs8ToIjgJzhfdHXZ05k0rq9TElHkCKQ8btzutYUzfi0vyPM8J8ihMOcs4SAlW3Oghj3Aw76pMB99z3j8+ghRyeFz2DCQeWfMgiMNglMQgfsXfRlncv+dSuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GJI9vTYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdHxKoFt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJI9vTYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdHxKoFt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 352E8EC009B;
	Thu, 25 Sep 2025 17:06:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 17:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758834400; x=1758920800; bh=9C/KYAofYv
	M2LNZQGuXYK/5fFbqgL/VZKOmrehcJKK0=; b=GJI9vTYLrZbywKQuYnChN1lI5Z
	+IepEm2K5XUMge5XcH4IMh91Hetr4J2pQ6AtCAEslpBxn8qwanl03RnmSbl/XmTh
	OQMTIAui5v0gw9eWtnscG4LiznqjPU+uO+Yzsc0xWLJPtbX40/AT4C4FzUwRI4A8
	BXMWWZflQsVSaCoEGal63Jr+rXS/GhoB1aREgZtPTX2PSmzxmt66CmcFlQ+uuTqi
	hQ8FPwFwUjCf6InwFs+D6XyQlriwROz8Vz+BFpaSRawH+VGaHxaxiI4CvM0RJamk
	knbPyEGiYLmO20QZ/XkWB6ALKsvJlp425CGv6T/unqvzb2cT74XoQHRwEQxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758834400; x=1758920800; bh=9C/KYAofYvM2LNZQGuXYK/5fFbqgL/VZKOm
	rehcJKK0=; b=IdHxKoFt67cwjk1fbjYeNWuQPZBRK2TLaumtojSErGiLMyyXBv9
	OwvJxIORz/mHmDYGiOVLpNlZ1fr3iE6Oj74xdaZ0Dgwi8b/VrFLWEy215Tm5jbHD
	EaL3mot4g4a/oqr2CU3RaGiqxg1cYFcM6m5FTe9RmYGPTIWWdWICjl/oIGjkhi2X
	BR5W6Mpq/W+5ETsA5kBbliPRFbGtusLo/jzxpt+MvaT0JnEcF4fQ0H+R79F67TbE
	OsTrQaedj+mrkeu+3eJlr08YLl1sG1DRiZ16hkWhpUM3FaIsODkoz9FtkgNAT1CZ
	G5u2NeCK/UgC7MfwIqXqQn8fDKIVyctan7A==
X-ME-Sender: <xms:367VaBMOwxgyU_rNaJDzaaooCZvtHG7QwOGTN9VR7O9tV1QgERA21A>
    <xme:367VaK_QZKB3LzHb0cj_W1IPQ2wKMIFCt6NypZ1oeODBSv_VhoQFfMkFhix20Ao44
    O5qFtVHVcXXrD15eyxgg1KEAievli8Jx5XqZGGkBm4CtIJS_C_vMA>
X-ME-Received: <xmr:367VaFQiqG9zkDRGUEiMlKGqpGt_Y-SoTqmD7MSXdkvH8yLfTK145iF2YOC2YUmiyNl9ryTZOq_n26P8CdU94_zGzSz0asRXtzY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhohhsrghmrghlhieisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:367VaMkj_u9Gm3z1mX8eHKDJ3Kpp37pQFWkC_JcFD4t10wsnXS_AxQ>
    <xmx:367VaFQI6XsSJa7b3Phxs3kiw0-PCtwNKDOeazfGXVsmtAW5ZytqUQ>
    <xmx:367VaKNRuvNxK9er-VUwMUPc0pk8qd7ZPdSVnZzGCEpmYfqacNnNLA>
    <xmx:367VaOVH3E-z8MBIS4dn85nrpVMXWalLAkeVyGHnyhA8CR8N-nX2Bw>
    <xmx:4K7VaIz5GSJL39vvd1Kh6Ilzf7TrjgATD7xU7IPmip4Xl0wzBTkBl9jh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:06:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hosam Aly <hosamaly6@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Bug report: Untracked file lost from git stash
In-Reply-To: <CAJA-u1oORK9b2=mg-s_n6-Jn3VBhe6sqrWg8VN0-MdEOjZGcwg@mail.gmail.com>
	(Hosam Aly's message of "Thu, 25 Sep 2025 23:22:40 +0300")
References: <CAJA-u1rnzef53+eW_mbwd_40q+-vt747Q_dP3PG_HKt1yXcmXQ@mail.gmail.com>
	<CALnO6CCfwdKcqxFSvX68WDvzceYeo0ougz4337ejChbPB9aGEg@mail.gmail.com>
	<CAJA-u1oORK9b2=mg-s_n6-Jn3VBhe6sqrWg8VN0-MdEOjZGcwg@mail.gmail.com>
Date: Thu, 25 Sep 2025 14:06:38 -0700
Message-ID: <xmqq4isqfdi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hosam Aly <hosamaly6@gmail.com> writes:

> Feature request: I wish that the maintainers would consider changing
> the default value of `stash.showIncludeUntracked` to true. If
> something is stashed and the user asks about it, they should be told
> about it without hiding anything. Consider the case where all the
> stashed files are untracked; `git stash show` currently shows nothing,
> which is very confusing.

Do we include untracked paths in the stash by default without
configuration and/or command line option?  If we do, then such a
change will affect so many folks that it would be possible to do so
only at a large version boundary, like Git 3.0.

But untracked paths are not recorded by default, and a stash entry
that records the untracked ones is a sign enough that the user cares
about these untracked ones when the stash entry was created.

Even though I do dislike any suggestion to change existing behaviour
established more than a few years, I would be more sympathetic than
usual to a wish for such a change in the default.  In other words, I
tend to agree that the default should show untracked if recorded.  I
am actually tempted to argue that the presence of the configuration
variable stash.showIncludeUntracked and the "--include-untracked"
command line option is a bug ;-) but I won't.

Thanks.




