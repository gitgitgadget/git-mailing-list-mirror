Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D29EC0
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229026; cv=none; b=Nk46dXKoUZguA0IXplnoVgae1sGvVwzIv0KHb3aAms8rl6bpAWFwngn84oN2RD5urYjTXtfB6sB/qskKZKf65UPKuj4uax3GZygQQz4xdSgSlzU8rjef1xsy8sI8cISUQMCOdecxSgRaD2Aiv/5Vsl9pJnEBiuz5GBeFKj81KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229026; c=relaxed/simple;
	bh=fN0LAoA8fSD1kYrDSHB5pDoZ1wJn6Z0OiDlE+ex4K7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=li7jq8FfBbGJzavB93SWQtF90CxxChnbOwdiCimGFjhDrWxCXWVHQZQe3EXex638w+rgxHUko50w5u51gLvFrtKV267TBphG/TxpuPq+r7OQ8riBZsLh1qlCGhR31OWdLkEiw24V8k9Wf5jo+6tF99fqQKjfgYQoP9G7WOwO3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uYPd+wJC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjkMnGpG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uYPd+wJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjkMnGpG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AC041140149;
	Sat, 14 Dec 2024 21:17:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 14 Dec 2024 21:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734229023; x=1734315423; bh=XDAOoFeqhC
	dkeVoeQOrynVN5xvwP5sZ/dmYC3q6ol7c=; b=uYPd+wJCBW5HL/cjF0hJtXfir/
	++WMOuoIdcQhouSHgAANCVautFQ1mkgwmdA2IhhmcAO6Np1//aBXvlsPkhAzQ2qN
	Ke21OMtxV3dzlQp9/rKcfb+ZFZ/uJw6cj2Xb2b/fLkXtgvflWoqe1x89OQYEU8Ys
	ttK4OzWEa7DE5jRQtARhkV4vgLRHYevlrpjIW++hfWXO+DupCds2z7Y++frjS5Kp
	7A2Jqh2I38hRGiyQbVmgN453QMXk9JzgbJkfrQfhPhVVnq2TEaWQp6l2HT0+956t
	ciXY0O95EVHum66G/DYsnwgDWmC9eHQeEhiNwBN089KxIP0smsvL2fRTC2Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734229023; x=1734315423; bh=XDAOoFeqhCdkeVoeQOrynVN5xvwP5sZ/dmY
	C3q6ol7c=; b=mjkMnGpGRBOHSLQdZxyk14eEVcZ+D/dOmWpj+Za7Iiw9UWpgTLB
	HND/gV0Cjn736qrhE7YB2XXGo4ytJIHCfjUd4AcYhrzHxQ8t323GLuZWcRpgQcWR
	gITxUfRJ3lFhL8KEBWDs1qj0wCdQULSN7pDT+htyGAZQUNuLe9cCg5ZDhzZfWeXq
	Lh9X1KOWRAuxDCu3aXNxubUvFEK4KDBWMAKtwIkEmrMD3GGHV5eYHd1zAr77VL3P
	5cP7ksUgLwXHLxSsZQMuai6OLNsBRUqtfNhZSf28LK3UVBR8KoFU9qpLo+dKGC/k
	Ev9lmZOLcPcIb27YUVWXVdNYoOieoS9j4mw==
X-ME-Sender: <xms:HjxeZ7HjM5MQ3exIJ3eMEPD-G4BmXv1fQJUe0iLJEsDNaLlkgYoxKA>
    <xme:HjxeZ4UUy_iDhgu_w7NCeBYDwOLrS21GaXuFs-7EjmRcBSBUXFWNVqmps5wYLuPJj
    jNXQcWnwQti9wHnKw>
X-ME-Received: <xmr:HjxeZ9KS45qxMvbngT40cQSrl3I5Pe3gmsNrZ-DBUW-ritrPaMR6m3npgnklVXn1WbcbQZa4qNlvjrCVmo12KpwQcTzOXLorYCorOsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HjxeZ5GbSSPB3GH0BC76i3BfHITlDHlKmFLmAst_feG8hmH0LyV5ZQ>
    <xmx:HjxeZxVHC4wAhy96hlXrzG_aVj7Zm0NIQpoFWxVBHjWrp-3ee3yPag>
    <xmx:HjxeZ0O-7AB940m6sU77B00-BixeWMbfg3Fw6KNt_0chIHAknidf3A>
    <xmx:HjxeZw3GHgqHrG_Eq1sVfpl3zO-LN2jX2RapIpFSTwc1ULHZgbt4pQ>
    <xmx:HzxeZ_cHzEhmcpg3wTA71TdXVXVvp9Ucl-QVZe4Hn2ytTx59glrKS14o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Dec 2024 21:17:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <xmqqcyhtaecy.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	14 Dec 2024 18:07:09 -0800")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
	<xmqqv7vnevjc.fsf@gitster.g>
	<20241213103850.GA1456983@coredump.intra.peff.net>
	<xmqqcyhtaecy.fsf@gitster.g>
Date: Sat, 14 Dec 2024 18:17:01 -0800
Message-ID: <xmqq5xnladwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Yeah, you're right.  I forgot about attr.tree (does not seem to be
> documented, by the way)

We do have an entry in Documentation/config/attr.txt that describes
the three; I simply assumed it is not documented as I didn't see it
mentioned in Documentation/git.txt where --attr-source &
GIT_ATTR_SOURCE are described.

We may want to add something like this, perhaps?

----- >8 -----
Subject: doc: give attr.tree a bit more visibility

In "git help config" output, attr.tree mentions both --attr-source
and GIT_ATTR_SOURCE, but the description of --attr-source and
GIT_ATTR_SOURCE that appear in "git help git", attr.tree is missing.

Add it so that these three are described together in both places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index d15a869762..13f6785408 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -228,7 +228,10 @@ If you just want to run git as if it was started in `<path>` then use
 --attr-source=<tree-ish>::
 	Read gitattributes from <tree-ish> instead of the worktree. See
 	linkgit:gitattributes[5]. This is equivalent to setting the
-	`GIT_ATTR_SOURCE` environment variable.
+	`GIT_ATTR_SOURCE` environment variable.  The `attr.tree`
+	configuration variable is used as a fallback when this option
+	or the environment variable are not in use.
+
 
 GIT COMMANDS
 ------------
