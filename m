Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85C2620CA
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203383; cv=none; b=cAfzgZYD6fytHEz63dTLeEoE8YOEBgqeOxikd19qGFJV4bjfgJDDOFzMoQCoc8wMsmiOuWSo3lWvIFtCIxlVXUq3RA8sdseGkXEnDcEi8tlSuvUi3DdveXPwO7rCLFP5p8xR3Cjqwg5E6t2qSiMJHXNEPXpCJSJRBtuBnFRCGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203383; c=relaxed/simple;
	bh=EsZHPdSXW9G4n3QLBk/UpDbQnzKCi5fZDXCpE8h/zlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nu5zR5y7nul5wqzxD/O5QcAny39HJHxwzxR6plc2DDaJHggGRpE08Vs1DhJ8Mv5ogcwL43i2pYJRxeVSYiJCKDBX34XjVLHitmYWcdYdR7UreuuHzsy+TWx04jlw9ksZL1qiitapbOcyuUSeQ0ix6AIYZh+JytXM5+TMGhHgh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pKVJI4ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qprxE+bE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pKVJI4ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qprxE+bE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 914292540171;
	Wed,  9 Apr 2025 08:56:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 08:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744203379; x=1744289779; bh=IUVWBWnBhU
	qY1myMU4XCQNe3ya4xLZf9FGE21Kb70/Q=; b=pKVJI4ibYmVoxnb7jocFRRCNG8
	WcqjPvxyySARkwwuGLmPOwahU6FdSmxsAnD7pnkHVXXyibpoEBwPj05dUDEInwHX
	p9/CYaQRSNIISrEzxH9Gj+PIzoN4saM+2wkJGkUfUoo2pg6HfzJL+ZgTjN9cWMUu
	UbIlNFKQsD414YZEl5LDKdEZ0jnj7SoA2Qu/t9D7hRaYSeV8tXLyygBnC1y2xUJF
	PiaXTXTBiqU5CKX29P86Mvwxb9JqyabJtOCy3Gub6vV4jK1Um948OuSR0o34Y+Lx
	y3+v9nyBNfH9XPKa9OcaxtKorEgamd2CzsN36Tkeg8gIhOF9PoSvhwKH5wCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744203379; x=1744289779; bh=IUVWBWnBhUqY1myMU4XCQNe3ya4xLZf9FGE
	21Kb70/Q=; b=qprxE+bEt/JjjqkEMtuvJLE5Qr7LeAQTAbsem3ONXO3k/HEcU0O
	fkOm/WYs0kxKXzlflIxB/647G3x7ZXZhGWsvYZV/dN6Il4ou4IS5R5/qSQTkgb6p
	eNc2J3UhbJmf77//6H64ZzlxiToKIfobRgUQ9FUlN40Ainoihv2FrATc9HOnBqT+
	BdadxYceKsxr9qAXjvu+IxcCvS3DdJvT2rK1Ll/rqUi+YwWrXsSX0MBYxCv+wNbu
	qyukGqLRKwuT9ocUHc0bnA85ns/a7zdEPpCYh4yoK0w3HyfDN9b2575qhY9gqDBc
	jZLWNAOeX5vsLPTq1EtVEMRLfYOaxcJWSxA==
X-ME-Sender: <xms:cm72Z9kYIPvQvsSdV7ljd1vTUb3OoTMFx-h5mrV0d43QoKRav5BGrw>
    <xme:cm72Z42m_yC8nTTaSMhEC6IH9T3gzCNn7a8PVHiQ-aqi9MvYNu1J2CADq4iBfvVUr
    Z6VUQFiVVQai9bAYw>
X-ME-Received: <xmr:cm72Zzrw2IOgya2eVB5KKlO0l9cIzDmJcvmunlQrE-e-QTnTHwU-stGnVke9w0VQGHudvSxi3AfVzWAzxQYwvka4m0zrxXMZj8XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeitdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cm72Z9nQjRFUEfFZU7cPfF4z_cf4zbQKlCo3X6Ls5ig0dYYsLzBdOA>
    <xmx:cm72Z72mVNXY2LwZ-fuY5zlBcACQOd7aU_l-z2WGIy_BJ5pYDuSWeg>
    <xmx:cm72Z8to-_97gQUatydzM0A3BW2XvZTB49AHYSgqBSd8USyUvyvbCw>
    <xmx:cm72Z_WR8_VLx_xSlPwatqEsIF1LGP7QnBdjy-I6m7x5GGSHlcb_-Q>
    <xmx:c272Z4uOnUg7Uc2tW8h8UPcJg67hug0yb5eD7kdi1xe9SuatJfFlRqnU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 08:56:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Nico Williams <nico@cryptonector.com>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <20250409121924.GA148735@mit.edu> (Theodore Ts'o's message of
	"Wed, 9 Apr 2025 08:19:24 -0400")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu>
Date: Wed, 09 Apr 2025 05:56:16 -0700
Message-ID: <xmqqlds9trwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> ...  This *might* get better if we shove it into a
> git commit header, although if you give people tools to edit the
> Change-Id as part of a "git commit --amend", some tools might end up
> changing the Change-Id in random ways again.

Thanks for pointing these out.  I agree with the above, and it is
one of the reasons why I doubt that it would be a win to have this
information in the header part.

> ... So if I need to cut and paste a
> Commit-Id, I might as well cut and paste the one-line commit summary,
> and do a "git log --grep" search based on that.  But if the Commit-Id
> is indexed, then maybe it might be more useful?  I dunno....

If the information becomes useful enough, we will definitely start
adding index for it, just like we only have "parent" header field in
commit objects to represent transitive NxM parent-child relationship
to start with but have in the form of reachability bitmaps an index
of which commit can or cannot reach which other commits.  With squash
and split you outlined above (omitted from my quote), it is likely
that you'd want similar transitive NxM predecessor-successor relationship
among a family of commits that represents patchset evolution, and an
index constructed with a similar principle should work well.

> Well, see above about some possible semantics.  I'm *still* not
> convinced even with the better-defined semantics it's worth storing
> the extra baggage in the commit header.  But that's more of a
> value/philosophical question, much like how we "could" store explicit
> file rename information in the git commit, but in the very early days
> of the git design history, although BitKeeper did track file names,
> Linus consciously decided to go down a much simpler path.  So that's
> really more of a SMTP vs X.400 preference of simplicity versus
> complexity in the protocol versus implementation...

It is not "simpler is more manageable".

The early days' design decision, which still lives to this day, was
a bit stronger than that.  As can be read from [*1*] (which by the
way I consider one of the most important message regarding the
design in early days of Git), the design started from "recording
renames is pointless".

Thanks.


[Reference]

*1* https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
