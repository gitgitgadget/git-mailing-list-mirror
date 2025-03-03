Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB64238D34
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034702; cv=none; b=oUad1Lxq+jkjwiGRuz6BAnNdbv/tDt4NX1y0TNaoz9WxdYdXwqvZ2ucGHDdqMVp8E58ftfyRH3uuEkAgkbYEefvwYGJ7v2HpctRK6t/f7IOCyuS5aI0jWMbjh3vzxNyZU+e+gfvRejJ9evOV0QwroQEs4QdPFrlckF4yuOUSj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034702; c=relaxed/simple;
	bh=R30MdJSGlX1MrBffCONUT1MwaayimHq3apuaLGdaw08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smwMesd037P24Y2fga8RWc6dukH9g0/gKvdfyKRdrWbQhIeZ2vjPvYTRe/m00iTEgVNBWkckpVF42Ouu6svxVD75uh3IavEG6o7vbSyh4jaQIPSMWN2eNgzSJe5VijBrlZrFj88MDBvV2VWa7MynDlwhYiYfKwoNmocVsDc9iL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ChAwFgzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWkSnCLR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ChAwFgzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWkSnCLR"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FC0F114018E;
	Mon,  3 Mar 2025 15:44:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034699; x=
	1741121099; bh=+D51ECDIs6fty0iRNzkUlHgFo7CWAbIh3smmpz4rKys=; b=C
	hAwFgzGoF2hMzv2aTvNre94R6mKN+tbjHezdSpy6NrhnAM2L2PvUxXCtSRvhQYje
	mcCDGbzIqO0qeL/4j0xU2JFi1NuHbd/48+lw4fDBoeAaLVhkVaDDM/KmLVEvR22n
	E+z3mLYoz/WIqDQWhjq6RllUyNBIvtKxQBRnpFq5GNcrcYmHWXVDp1iv2NfBWDCB
	SIIgI7q+WGkl1S4HiV2CxeBEnskF2txYSLxmUxN6xajVOrjpZ4gcmjSe9zX9GPL4
	Q35uxw2upyyzDy2iZqXt/LTifxB1rjq+tlFEvZXsCMuzVz3bm6CZDHKPTVYMWbwg
	hvi0CxEaT0zXjJBqQOPXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034699; x=1741121099; bh=+
	D51ECDIs6fty0iRNzkUlHgFo7CWAbIh3smmpz4rKys=; b=QWkSnCLRTs7poj0QN
	csqe02EU07YLdeNIdKv+Jxo6Btz9HEe8U3Ds+5c0y3rYKVCFc6oYtrn3ihII/mxf
	BFZunPrmgskozAg33uJadaxs6MS+hpoSeK2zWAMxPV+T9eiyL7x7fOjZRqnBisDG
	rOo02mE7IW1XQHS9O+84EokqOA1fxRe0isns1VtXUp8FKU5md2E0CUhzjG9tDjuW
	ST+wu/SX/D05og5z96mun6KypsytsUtj52gfYT4Y4TxAEi1W1z27QyO87EDrU1x0
	hAOGIsazFPCD/CSeuzjjSd2DKC8+HysWwfQ70YeViMJ/4GMNKpBLhH4o9G6/yQc0
	1RiqQ==
X-ME-Sender: <xms:yxTGZzOrjQ2AeteOqvh7JPE-Kz7VcV9mra89R5GI7mPClEOeexcO6g>
    <xme:yxTGZ9_SG2LVy-e3Kzip5eKMEcrTRrbzYe6wQIWZra39K5kZOu5K1nggfLczvXWIK
    8OuZ2I8pT01CO8Etw>
X-ME-Received: <xmr:yxTGZyR7QYRnOw_eJwG6ERiM5kfarHsIj8ORxWslEGv_WGKg_Hs3JsUz8BUH5WhF6He7RwVcWXouu2XQGTH5Eg0EXmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeegfffgtd
    dtkeeiteefgfdugeejueehkeegteevfeegfffgfefhffevgfdutefgteenucffohhmrghi
    nhepvggrghgrihhnrdhnvghtpdhgihhthhhusgdrtghomhdprgguohgtrdhnrghmvgdpth
    igthdrihhtpdgrughotgdrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:yxTGZ3sylybp4hcYxhNaGJpQigSeP6Ygd_jLV-4DQAkRCO3arMxn0A>
    <xmx:yxTGZ7fEYrUqMvvcRbkcgqVbMD0rUHqPNk9fYYT_O_eo63hliyEgVA>
    <xmx:yxTGZz3IZIPuULNkfTXZDxQ4FbNFpB5zLPXOxaQocml0ck0FfTocQg>
    <xmx:yxTGZ3-hqW4qWJ0xKvm3Qp3TE72Tn4rc4ULvmmJVACfLESaGWXeOLw>
    <xmx:yxTGZ34Y1UF-Q8x8n7UcMtwBf7Qf7LADrXi6JqWrBjsGh4oDIE8dWiC4>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:58 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 08/34] MyFirstObjectWalk: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:06 -0500
Message-ID: <20250303204443.360595-9-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/MyFirstObjectWalk.adoc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index dec8afe5b1..d6e9dfdbbe 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -15,7 +15,7 @@ revision walk is used for operations like `git log`.
 
 === Related Reading
 
-- `Documentation/user-manual.txt` under "Hacking Git" contains some coverage of
+- `Documentation/user-manual.adoc` under "Hacking Git" contains some coverage of
   the revision walker in its various incarnations.
 - `revision.h`
 - https://eagain.net/articles/git-for-computer-scientists/[Git for Computer Scientists]
@@ -112,7 +112,7 @@ $ GIT_TRACE=1 ./bin-wrappers/git walken
 ----
 
 NOTE: For a more exhaustive overview of the new command process, take a look at
-`Documentation/MyFirstContribution.txt`.
+`Documentation/MyFirstContribution.adoc`.
 
 NOTE: A reference implementation can be found at
 https://github.com/nasamuffin/git/tree/revwalk.
@@ -132,7 +132,7 @@ used to track the allocated size of the list.
 Per entry, we find:
 
 `item` is the object provided upon which to base the object walk. Items in Git
-can be blobs, trees, commits, or tags. (See `Documentation/gittutorial-2.txt`.)
+can be blobs, trees, commits, or tags. (See `Documentation/gittutorial-2.adoc`.)
 
 `name` is the object ID (OID) of the object - a hex string you may be familiar
 with from using Git to organize your source in the past. Check the tutorial
@@ -141,7 +141,7 @@ from.
 
 `whence` indicates some information about what to do with the parents of the
 specified object. We'll explore this flag more later on; take a look at
-`Documentation/revisions.txt` to get an idea of what could set the `whence`
+`Documentation/revisions.adoc` to get an idea of what could set the `whence`
 value.
 
 `flags` are used to hint the beginning of the revision walk and are the first
@@ -153,7 +153,7 @@ can be used during the walk, as well.
 
 This one is quite a bit longer, and many fields are only used during the walk
 by `revision.c` - not configuration options. Most of the configurable flags in
-`struct rev_info` have a mirror in `Documentation/rev-list-options.txt`. It's a
+`struct rev_info` have a mirror in `Documentation/rev-list-options.adoc`. It's a
 good idea to take some time and read through that document.
 
 == Basic Commit Walk
@@ -710,7 +710,7 @@ objects grows along with the Git project.
 === Adding a Filter
 
 There are a handful of filters that we can apply to the object walk laid out in
-`Documentation/rev-list-options.txt`. These filters are typically useful for
+`Documentation/rev-list-options.adoc`. These filters are typically useful for
 operations such as creating packfiles or performing a partial clone. They are
 defined in `list-objects-filter-options.h`. For the purposes of this tutorial we
 will use the "tree:1" filter, which causes the walk to omit all trees and blobs
-- 
2.49.0.rc0

