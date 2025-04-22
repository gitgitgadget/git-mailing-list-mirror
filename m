Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62621D5AE
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365760; cv=none; b=Z7gyff8VZ6+be9Rnx9yy1zKDuyoWeW8vQVPdplxmd5PXOdZoUPEqyK9J/+Z4xdSVYS0NqT1pWckG/L5NMdoh6xdqxMp/JZuBdMnhRG3m6rO/qK7lf0MvTyVpqg2jPcHMHf7cHkCQtHLdRuNNh/EfTL+yt0VaDmGU36HaZgl5ZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365760; c=relaxed/simple;
	bh=dnc1jMqsBYb9fWH/Ajn4TrBT2ZKGlkiTGxhLjpvBNIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fryF4O+aD1N1Te4UAHzu8BgLUmyfkc+biRo7CeyTy3SqnFu9eYuwyBGzki3iESBaV6pLP5BGC457y8YCWPgfnySjnqD2fyko+JDP0pq56hvTngWJ9wxpEaZuAui+32ayfYV9ZwWJCRsSmqw2FMRTzmb9sIc/pLVHR3GMqdGcBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aB+JB4Po; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tluYc399; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aB+JB4Po";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tluYc399"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 596DE11401D2;
	Tue, 22 Apr 2025 19:49:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 22 Apr 2025 19:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745365756; x=1745452156; bh=5r6DJzwrdN
	bhiTr2Psyyx63EAw67JYRHPPymB0fJEYQ=; b=aB+JB4PobPChgWpvcLVBb64VGF
	fPPHfQMJVSxucGX36OHb2swFyXftfrDeXmOr6koJb5MlU42FXFT3/UKo1HrNwW1T
	TJh3lavPjcn2kRgm62IEESZAD1tjscJO4pLRZ4VWxUKgmdR28+L3iGtsoYv7Z0Vu
	gVmzLWL8xH2wre079feQ+j0erPJB+bXrlM8WcibdIuvLdUo/5ED2ovJJr2PydeMZ
	ANq/D/KKJpIxdTSaoVOrMWnHKjH7uuIczrAOq8bUv2O/27QN9K7KDfFD75Rf/iRh
	6oau0g6Ju8jrhZyfbFSWiRBa2UbOd0+12HPOK9jZ+y8rllFoQhJqN3MmK44w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745365756; x=1745452156; bh=5r6DJzwrdNbhiTr2Psyyx63EAw67JYRHPPy
	mB0fJEYQ=; b=tluYc39978IUeMbMtGqs0WyxmoeEw8J6CX9idYirukmOOvYxmwJ
	ien3W2OsywKkYa90IrPBwhE4VCVPZRa+vn4k6khRCyvGfOC/6e1uAWTLGEhPAB+X
	rD8RnoqVxRz7miultwdkco5GqUQNxoCwAwY2FePw70qGfFkiN0PiwsoyHGiLLClV
	U2t3+79oMg64USFEA/ZAU6OBY39R6ZVnqnpi+VWLQA9vioDd2gNO28nqDFKyWYiV
	bq5XPE24MnGDk4G1eVrsj/ZdUxxSorQu3np1x6f+6eBrTk744HOvqEFufyFLkZZ3
	Inv9VSQkVpHoMRj8vkg9EDTVLkTs2p4eZfw==
X-ME-Sender: <xms:-yoIaAAq2XGmeHzpEZYZ_U1MDLDfWT2coJDsEYOfvkpXe128qqQxIw>
    <xme:-yoIaCj-KJWXc2Hv4ZbM0GnpB7fSleVM35Hyh1WzL94dqhfSPExN7-5YJkHF0CvyR
    w5gVp9LhGT4lSln-w>
X-ME-Received: <xmr:-yoIaDl_DEt55V17B1i9SpVzSwoOrPqaedtkt6IXmkiQ6jbFaVABE7TNy4qP3OU4_MCTI3RufngJhlwjy4_IfK3IhfbkFcv_WevY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnihgtohestg
    hrhihpthhonhgvtghtohhrrdgtohhmpdhrtghpthhtoheprhgvmhhosegsuhgvnhiilhhi
    rdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohepphhhihhlih
    hpmhgvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:-yoIaGzNDiro4oFu0PvDKP7RC2c9uSUtwy6NtdCqxQdehVrwXaoBXw>
    <xmx:-yoIaFRDsHg5YR7q6EWU9ZVoSeEAkJQDpR3BBxpgVamm-UtlUZK05A>
    <xmx:-yoIaBa_4CnfhXSUQrUQZh1AXov5N6AV8v1hKs2NmxF5jXtuI6-qcw>
    <xmx:-yoIaOSxRG_vkjZxQlBUdX7Eb52tZWw8vgxgOcYmaJIhnyUW2agXWA>
    <xmx:_CoIaEX0-ggdTHmgOjhL1g_YRmfEhYfrRSIrvjp_DlbK7vC-X5sJMJxC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 19:49:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Theodore Ts'o <tytso@mit.edu>,  Martin von
 Zweigbergk <martinvonz@google.com>,  Git Mailing List
 <git@vger.kernel.org>,  Edwin Kempin <ekempin@google.com>,  Scott Chacon
 <scott@gitbutler.com>,  "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <aAgdauFt/mdCY+GZ@ubby> (Nico Williams's message of "Tue, 22 Apr
	2025 17:51:22 -0500")
References: <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
	<Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
	<Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
	<aAgdauFt/mdCY+GZ@ubby>
Date: Tue, 22 Apr 2025 16:49:13 -0700
Message-ID: <xmqqy0vr21vq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> Change IDs for this purpose need not be unique, IMO.  If they get
> duplicated either you can notice the problem before pushing, or you can
> accept the dups and use context to resolve them correctly as needed.

Not having to worry about duplicates (as long as you trust Git well
enough not to worry about object name collisions) is a powerful
thing, though.  Unless there is a strong reason to stick to slightly
shorter (like 160-bit vs 128-bit) random string, being able to
directly compute the object name of the very first iteration is also
a plus, if you choose to use its commit object name as its change ID
(hence you do not have to worry about how you come up with a new ID)
possibly in some encoded form (if you want to be able to use both
object name and change ID in your UI), and have later iterations
record the same change ID in the trailer would be quite simple,
robust, and would be just as useful, if not more, as a scheme that
uses randomly generated string as change ID.

In any case, I am not all that interested in how change ID is
assigned than what its semantics would be and how it would help
keeping track of the changes made to changes.  Personally, I am
uninterested in a scheme that does not let me even tell which one
among many commit objects that share the same change ID is the
original and how they evolved (in other words, how they relate to
each other).

Thanks.
