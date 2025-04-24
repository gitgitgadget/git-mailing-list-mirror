Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34345BAF0
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511571; cv=none; b=jWun5sKOJ2nfUWtwifkOKGlo+HpLPmcaswvAZReCWxOgqmYHg3wze8OZQhR+Xv/c7SzdeAPOM5NSlEbzStdVIDTCGyMsje2fv/Cwp+4zFjh8lXWuauXqiPonh3C+7AE/IHh5TF7cK3QW1N/snKLIPulzObJAP2poehD3ca/dj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511571; c=relaxed/simple;
	bh=3CF8dx9/PysUgxa2e/kziBkDH2tKpMTnew08Ccea4Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCKBU/5rNnBm9hqFuKyCguwyR7J4CnITmDp7dmG48aQ6NTlMzWNDE9GuFQRkzMuwPlhlTDU/PXobiSE8CIcgmWjsZgu7h0Nel+FK/yb7ulqo6HIZ/hpYzPr/kgPJvnAgLAbxav+QRBUkQobElIdfAS3ldd+Bk1Eyok/KVyzIvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ho8akG8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzcMXCVk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ho8akG8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzcMXCVk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 95BC7114024C;
	Thu, 24 Apr 2025 12:19:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 12:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745511567; x=1745597967; bh=Xco82Pb82z
	J6JEBoBM8P9CFvNJtLoxfvj+QYRYfk8nI=; b=ho8akG8WZESJr8LLQQwBj6eCuZ
	4/vG2a+Y1tfpVD5wGL+w0JHKkbB4kgcnjPhEwzjzjpoD75QExGwmEUrkLZUlckHK
	hc2uMDJ/X2c6iMNF8BoBafHIGzem2o1bhIBqbeeo5yhEnIjtQGzvGixyW/CGT4DV
	zguKML6V5Wcsk7+3TcRRG4xq+FMszouV/qBbuByLldKrbPR6g06OXAY/XMAXtYqd
	7Z+NMSG5dCSBVfR3kmrhz3BlNfVtc5ukZ98dDkS07T/wObSXajKykDIDhY75VW4V
	FgwxAFsvIfvdzN2ZPwFqAIOwLBh+NJ/wQZtPQBqMYb8m7cW04RdPekQmSpLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745511567; x=1745597967; bh=Xco82Pb82zJ6JEBoBM8P9CFvNJtLoxfvj+Q
	YRYfk8nI=; b=MzcMXCVkPhCbjlbTQa1C03SlQ3zpotjwau0G1yxJmLo6H1I7rjq
	/ooRGTp+4ZPSk2ty1g3eOY701cMZh/a0DGEC37N0ORWBSoxYTYr/VXatDOskpe7A
	eBI7bstRKjQugon4B/4hPmVyHDeThRFQwq/GCIsoFxqj5jr0qFunOiCjrCzsrXw2
	ZK00mcspfEvhFgbbAEQiJmscNoBMoaPQOURA6xsCg+v22mVnKInQfu+CA4ELmxab
	xULgELI62wPNHzSpzFKwSeFmzDyEXnk5zB2f/cUfwisoAP//C8i5z+sv28kJtWuj
	IJYTCqfCTL3g7/V2IZwRlC+8AqJI8WlO/2Q==
X-ME-Sender: <xms:jmQKaAkcKFiZDNgL0vXG7l77WzkZ35OcBCC19PYo2d0nO6W8taAviQ>
    <xme:jmQKaP0hhoA_GShin2Gqhzj-Ae9S3COkKRluLCQkcFB1gWjq11NX8_QA35cHNl8NP
    IdMIaDyQt_fMJxCuQ>
X-ME-Received: <xmr:jmQKaOoeQu60qhUt0tOox_1VeauH9JGDR_LSkgogdMM4eD6OOdslww0Mt_U5A8U06b7O3DTrAbJTjgU1oNvGWRfYjYbZrvVmaIL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jmQKaMnRiIoPEXsncT2VHH285OxQPwYMvtfS-7YktqmAD_bE1zlc-Q>
    <xmx:jmQKaO2sS9j1vQO0BPrJ3Fs0ZWGfI8XtieRDSGT4vS7L4LsiA5oniQ>
    <xmx:jmQKaDsr-IboXpz1R2WSFjpTVdtkf5FjCF8E_JbS7dz7f5A1g8ZqcQ>
    <xmx:jmQKaKX7guWsOXpGpAJCEuC8uDl16-ifNn8KnW20l9Rldq3voX_a7g>
    <xmx:j2QKaBiNz0h2Kv3jhFDwqyY4avjatoM0rrZgkPJ-6GBV9rQPZJJwqcGe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 12:19:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 1/5] blame-tree: introduce new subcommand to blame
 files
In-Reply-To: <20250422-toon-new-blame-tree-v1-1-fdb51b8a394a@iotcl.com> (Toon
	Claes's message of "Tue, 22 Apr 2025 19:46:24 +0200")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<20250422-toon-new-blame-tree-v1-1-fdb51b8a394a@iotcl.com>
Date: Thu, 24 Apr 2025 09:19:24 -0700
Message-ID: <xmqqfrhxv8fn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Similar to git-blame(1), introduce a new subcommand git-blame-tree(1).
> This command shows the most recent modification to paths in a tree. It
> does so by expanding the tree at a given commit, taking note of the
> current state of each path, and then walking backwards through history
> looking for commits where each path changed into its final commit ID.

What is missing in the series is an end-user facing documentation,
it seems?  Don't take this as a complaint; an RFC is expected to be
incomplete and one of the reasons asking for comment responses is
to fill the gaps.

How is the "most recent modification" defined in a history with
forks and merges?  For example, in this topology:

 A---B---B---B---B---B
          \     /
           C---D

where each letter denotes the contents in the path we are interested
in (and as usual, time flows from left to right), is it the child of
commit A that made the last modification from A to B?  Or was it the
merge commit that compared B and D and decided that the path should
have B?  Something else?  Does it change the story if the sides of
the merge were swapped, i.e. if the branch that kept B all the way
were not the mainline but the side branch that got merged?

 A---B---B---C---D---B---B
          \         /
           B-------B

The same question applies if the path we are interested in is a
tree, not a leaf file.

I do not seem to see such a case that involves "ours" merge in the
tests, either.
