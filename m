Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A81D5CE8
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301942; cv=none; b=Mi+AvJDRdlVMFz6KZXDKdnogO7sHztwvjJQM6bCLv6lPHyKtP/PRtqbQIagOQSRVA0m0qalSNXbntDMKB9N3KRumxWkUv4+/ZwCHi/jRprmceqea9cK6RJ7NKiDFvBRxbt29+E3xxtRdUPItUvu+a0yy7Lz2cgxx9zPBDcpTdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301942; c=relaxed/simple;
	bh=h/GYqmlkTgKR9sTPxE6i7vKiBYpbNu+rqJ9oGEK8iPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SR4klG6MQPjrkfTt9nVWC1HZhKFiOPKuey1ULtkk+7SNVKWSbFLjDh6rYa6C5pDGvYm+yMwlAaDxGzISErltQfsliGYpp8l6PsnIRj/PfS9hh6Xh78vsck68bYB9TUhuMiTmN0ZKd5lDTcc8HoQgDy5v8B/9Qd4mY94GiZ2cBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K3WZ70I9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/tCwcW1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K3WZ70I9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/tCwcW1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6CBC25401F4;
	Thu, 10 Apr 2025 12:18:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 10 Apr 2025 12:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744301938; x=1744388338; bh=E3vZLKkKDx
	aJsJ9pL7i4UR5gaiS6C4WA9pNC9CTNt5Y=; b=K3WZ70I94cGMuB8kahRuf39XbG
	xgVahsBspTiX3NrT2Wpkz/4iTvuh2FfKtEQkn9kHtZlituXK6BsNXbzYEMyXVUiK
	Dz/h60U79I06jDRpVK8QeX07B/5mOFXkkLbvBS9pIsuC/Cv1kA292CdwoI2ATtFb
	DTriR4pRlq/PVlWvaLcvw6dQmeu9QRLy8YvMwxVNMtN8I5Xus9r+S/JvbnTQ7prp
	Eg6EkM41mVoL9BIbeiog0fDUgUwbuZJTYpjBoea19vR2IladFC2So6S/t//e4/+w
	siU84JO5CY2FPQvDin+lRODBhNG3UeQkCFs0i3Mwk1NdCwk/0MzV/Bah+53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744301938; x=1744388338; bh=E3vZLKkKDxaJsJ9pL7i4UR5gaiS6C4WA9pN
	C9CTNt5Y=; b=U/tCwcW1m2SWizG13hi7GT4dHGBjBVYW+Na1bLCE+9dT/RlXh0p
	IDjknMSpNMUtgG71nVX9tbc537C0+jrnKVTMJL06cxNSRnKrGjwFDuqnn+SDVjFr
	H77sKOGjwtqXaQPaYNrBZBpL/ZnCNv7yF6gDq4EQgovrKgf2qKrIFwTfs6EbjGQ6
	95qTDzN5Y62niBHZoNKl0piGXUlJdghXcKA0j4qSUNmkIGDCYSnd6lTP+S7uNp0V
	jMUbseVQHmW6QhOlgLQI1UPMN41pek6rkt/Mi5N58HfeRkQc6DL7xIaKtrlXRmk5
	sKvaCQHlriItQ0N6IIhLcPaAJbvOl8FKzFQ==
X-ME-Sender: <xms:cu_3Z2lmtHjFrjAZwfBkxDm-PKlEdIXFvlaZWYPDjaOFI2wnwj0G5w>
    <xme:cu_3Z90MlDfdIUJvUhQifMRb-aXrwjvkzk7ZITJQsMjumNLmqiEN4quXDsghXbgdv
    6xV3f5EQZecQ0_-Mw>
X-ME-Received: <xmr:cu_3Z0pgtCb3tMTiCW-xbBUT4EmqWEMGjR6Kt7wQPV0awc93E1Zok8rhrLsZlX3sjG56Wzh_vHEO-mubl-P6jhYiCj5A2qzmj7fJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepnhhi
    tghosegtrhihphhtohhnvggtthhorhdrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtoheprhgvmhho
    segsuhgvnhiilhhirdguvghvpdhrtghpthhtohepphhhihhlihhpmhgvthiighgvrhessg
    hluhgvfihinhdrtghhpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cu_3Z6nnar7KQOaxo7iW3pHGZK9StE-sKBSdx951kg8MjDu2iguG1w>
    <xmx:cu_3Z009tnkxqSQ0J39rhxPOFYLJZUTER4poz6TVE8n-8pll8NCoXg>
    <xmx:cu_3ZxvkjVewJdblCONzGOQxSwycotMiv76U2uPhcuxK2YeB6ai3-A>
    <xmx:cu_3ZwXz2-ez4jjZjNyynFlSl7s6IJhdia7ZRT12jqgE0b4IevesRA>
    <xmx:cu_3Z9vCzH-3FKE1k-36cvQMZMOtkaF9j_mWWZqtxpvuX7tCD3XeiNYH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 12:18:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Nico Williams <nico@cryptonector.com>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <20250410134426.GB13132@mit.edu> (Theodore Ts'o's message of
	"Thu, 10 Apr 2025 09:44:26 -0400")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
	<20250410134426.GB13132@mit.edu>
Date: Thu, 10 Apr 2025 09:18:56 -0700
Message-ID: <xmqqy0w8ng5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> Regardless how we come out on whethe having an "inode number" for the
> high-level semantic value of a commit is worth it, I do think having a
> "patch set ID" which ties related commits together does make sense,
> though.  That would solve some interesting problems both for the
> web/forge review workflow as wel as the mailing list review workflow.
> I'd be curious what people might think about that.

As a concept, I agree that a mechanism to identify these iterations
of the same topic collectively is a very valuable thing to have.

FWIW, I use the Message-ID of the cover letter e-mail as a rough
approximation for "patch set ID", and it is quite usable once you
train your contributors to always make the cover letter for
iteration N a direct reply to the cover letter for iteration N-1,
and also make the individual patches a direct reply to the cover
letter for the same iteration.

Then visiting lore.kernel.org/$mid/ will give me at a glance some
essential information about the series, like

 - how hotly the topic is being discussed?

 - does the iteration $mid I happened to have picked the latest, a
   bit older, or irrelevantly older?

 - has the topic been extending its scope?

Thanks to the "cover for iteration N is a direct response for
iteration N-1" and "cover is marked as [PATCH 0/$n]" conventions,
"b4 am" grabs, by default, the patches from the latest iteration
when given the message-id of the cover letter of any iteration of a
patch set.  Because most of the time a consumer of an evolving
patchset is interested in the latest iteration (unless the
contributor screws up, in which case we may need to go back and
explicitly grab an older iteration), I never felt a need for an
official "patch set ID", though.
