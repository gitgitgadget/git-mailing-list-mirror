Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E114A60D
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006641; cv=none; b=pcNYNnXTxDZTS7d/2CjYIJplPc6jz6otySq5CK0vm8BWIccXFYcLYR6C7hfR7v10KVVoiEwRnl4RmRS7f+9hrmjdx4b/lfTcZdpKBKdSIcAsGoaHtZbQ9N4FiEotC6d74vOYg0a5zaW5ykcAGCihAwH3R9Msi6R1JK4Vy+Y/qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006641; c=relaxed/simple;
	bh=uxyNYorArWmN9TbdW+ryn3mgXWWJ3KzBz0YN4jP5InE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j34S+cFgaybmi6gFpLeGdy8gnkQAR5v9afPUaEL6E0MYA/fwMy7tsoTv/Oh5OL6CY2uQhCQMTfPMLEyyqEb8LgPUCTQr8/PRrgJf1xkEZVeKDCm7zKTtOilaj3bhs6/iTraTyUupsZiMwZH7HfbrGrlVehci4YrDHJUOtcPcOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CiFCJLN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXs7yRFu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CiFCJLN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXs7yRFu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F2FE7EC0B37;
	Tue,  8 Jul 2025 16:30:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 16:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752006638; x=1752093038; bh=KCgmo+2+O2
	ORaJRcAqxqqwJOhLcmZkwgPbyzgAwS++I=; b=CiFCJLN9uuoAXJNofAJi34TAaW
	O05bZ3d27qjEj3bcv/zQIkc41bY1/vH34DHjab3/gMNNiRJaAfO/LktNUPBITpsz
	Y4PSDxGvbPpWEL10KMjK+26zAZ2H8VEhjytVOSaaMma3CnilWUn/7OwMw7hj/tdT
	lez/ZPjWscARIb+UwAS2In1/qh5pYVm+lOa8DcKtJmoBmVXU3ygvnBS1OgsJ3mJD
	3qF81bjNDWCuuQDIU3Bssu/IO9a/30A/LDhpw4EW7prwlDRc+5tuBsIGtyxxdaKy
	0CifKXxfDLhFIjEKcJaI7kTjuGXqKag2UFSZRrdEnV6dCphu8PNzttHchThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752006638; x=1752093038; bh=KCgmo+2+O2ORaJRcAqxqqwJOhLcmZkwgPby
	zgAwS++I=; b=hXs7yRFuiS3B76R8HiPMdKPqqP4vGiHA0djMyz1W9TPgwOKqCi1
	htA8kyWUEcNJF8gMuk5vcCVwy3DRc6Cu0pfo1lVdDjrf6pWquhgGGd+ZVjOcNl33
	DONdT76uHlF7NGTrXmtoole44W7QKKVOig6iOC/O/64q4IwMSZldJgKuhj7JAj/R
	K2Pe8q1epLIhp/Ru+IAuwbpDugSkjuad/IEi+oMth8zi6DQYlobm1gZIrGyhvYpY
	ZAxJAMDqnLjRlx99FDkNiCGVW50HXJdbhYs872cE4DvxpiyWKloUczVm+RVoM4EK
	VXR8ZXNvluoHBhluqFyIktaR/PQPoQeNFVg==
X-ME-Sender: <xms:7n9taDWfFbcxD7NOSenJgSIrsrG9pzG5SEwXJD9xYlAvTYXJF5015A>
    <xme:7n9taEDC3WT4D4gQnMctM7AXq4GwMydOpRPnEVrjbMcrlw4uzdYCCZygAJjqdiMcS
    7O2LgOs1FHXDMcChg>
X-ME-Received: <xmr:7n9taP2k3qVWccyEF2a1Gcx4EZHkgoNM9uve1w68G6xNrPzZGdZP0Xyq7tTNUGwTBEiIuiCB9n4oIXY_VPQFT8vfgz7-i5ySytXSov8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7n9taO1cuY0eTK_ZKgBiI6zP9K4df4p8VunaZ8AlaJWPSAFsTnRbIw>
    <xmx:7n9taMCdFaFA0tiYTOHgKTA7h9Q_yP537c6t8-rE6oRiklSMLIOE3Q>
    <xmx:7n9taF4h9_xbqTczSgC7t2adpj4yAl1IOq9N_AaqILLSLA8Kn7EtOQ>
    <xmx:7n9taFKtqQIgzUgsg90KI5c8xyBWyU52hdLsmSHP-Qhlgj1e7StIvA>
    <xmx:7n9taO5B2dTBd1U2FdVFD9SJg-FGs1Pn62nWvQRWezDMLf1IRWNnnPUA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:30:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
In-Reply-To: <aG0LzlnfoQVDdetk@pks.im> (Patrick Steinhardt's message of "Tue,
	8 Jul 2025 14:15:10 +0200")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
	<aG0LzlnfoQVDdetk@pks.im>
Date: Tue, 08 Jul 2025 13:30:37 -0700
Message-ID: <xmqqv7o2togi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 08, 2025 at 11:19:52AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
>> index 529a8edd9c1e..21ba6f759905 100644
>> --- a/Documentation/git-sparse-checkout.adoc
>> +++ b/Documentation/git-sparse-checkout.adoc
>> @@ -111,6 +111,17 @@ flags, with the same meaning as the flags from the `set` command, in order
>>  to change which sparsity mode you are using without needing to also respecify
>>  all sparsity paths.
>>  
>> +'clean'::
>> +	Remove all files in tracked directories that are outside of the
>> +	sparse-checkout definition. This subcommand requires cone-mode
>> +	sparse-checkout to be sure that we know which directories are
>> +	both tracked and all contained paths are not in the sparse-checkout.
>> +	This command can be used to be sure the sparse index works
>> +	efficiently.
>> ++
>> +The `clean` command can also take the `--dry-run` (`-n`) option to list
>> +the directories it would remove without performing any filesystem changes.
>> +
>
> Hm. This is somewhat different from `git clean`, where you have to pass
> `-f` to make it delete any data. I'm not particularly a fan of that
> mode, but should we maybe retain it regardless to ensure that things are
> at least a tiny bit more consistent?

Ah, it reminds me of my favorite "regret".  We may want to consider
making the --force/--dry-run used in "git clean" saner at a major
version boundary.  I am not particulary a fan of that mode, and
would oppose a patch made as a part of regular "let's change this,
as I do not like it" exercise, but as a known-breaking change, I do
not mind it at all.  Essentially the change to propose would be to
deprecate clean.requireForce and internally make it a constant
false.

But that is a tangent ;-)
