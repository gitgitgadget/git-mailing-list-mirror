Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214813C8EA
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656959; cv=none; b=hf8znH12lQ6/72rn9eWhY6JSPG37qDlpk0aoklBjPKbvNMTtYCUXkka+eMJNiG6bH3fDSURmMmizfqb3EAQrxCpqrHKCdVd3hWvFaE4wywE2kRPOjGt9Ct1UHyRBYrda+SBWyqbsTgDTFTwoSADBSqbQxNAkTcaYn4dmVolSB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656959; c=relaxed/simple;
	bh=9vlML5vpM1HKNEdy2E9ci0IVPqi/Pc4M+dtPj8QzVPI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohsd9huZrh1nFVkDkGuZIInQlav1SibOy8lE6xDDjfRPFhEdRVmkQG0237ATIHVnSetbuqZDS8fTkAoA/tbxtNdIZefQJGElDQx/wcG6rBxBz+iW/WTnBmp1zFTAZrbugpSBNZ0hj38brgKcCF6mMbvtDf4hfwkUCBEQhqkrG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oW/eSs5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4fMMq0B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oW/eSs5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4fMMq0B"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 80780138CCA4
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 03:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656957; x=1724743357; bh=EMIbiyW4jD
	Tmdr5ZKxLJ89E6IbiwbGbe1t50ZdHocgc=; b=oW/eSs5p6+qwyYUTQ/KoyWw6GI
	jKPy/Dwu09vnZlZwAyEgbNRhrskhJUkWj36M6E6uVd3rjSDKsIPpMmygphWRviQI
	DqOBNZioDt1Jp+DcZpHYBzLqYSdvRptLFo0GzTUe0KkCwEjuB9Fn+mpVukE66mHw
	54pIV0X2M8owvfjbHYoDd5UAmZPVtjpXL7bLnKxcOWpLEzuP3OwVGdCae7fXghMj
	5DoqbtDr83fSZiYTV4eR5qLeXKnm3/TDO6OBUqRFL6Xk1PJGkaJLvummsKbPKxA0
	/ED1lGwwPFsgFhh1FOaEDTOwpJ4wVKZjPEQrWetiT9hjzLrAi0TXTYT3Wxpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656957; x=1724743357; bh=EMIbiyW4jDTmdr5ZKxLJ89E6Ibiw
	bGbe1t50ZdHocgc=; b=S4fMMq0B5sT0Bqa5Wvp8gbW0SufQsa4O0CJxrjCfzOte
	zKR2uTXrMnHDQEDM36Op9GHdZyffqd3p+HWSJ4G7mnFmKUBBSPY1yf96L46SDOZ9
	spQ2qO7zyqDCvNAgnksTzFb95tZqzJrl3LlRalI2vXMJ8AZpAzJg1YyapdBjxXEM
	5WOEoJ7P99YQw3Oj1QheGahBlpWOZF3BjrvbGq1TZrTMSbj0AEOz9KnVKz7fF2Jq
	qgUDHYdvRiYgjCspG3Y9nc5hSpOEza6uuk3b85ubzSmDEEvETiUdTi+kjJuEeZxg
	elQCb+T7Hz035Sbb9wwjrthEbjEE4lhfgdZ0/C4I5g==
X-ME-Sender: <xms:PS3MZlCUlK0xgqlGCQbsSa8GgPDPLdC9v9wNHE4u2sFpxwT6v-btXA>
    <xme:PS3MZjgiOceAZwq2B0gEWE7CNYqnAPRe7aSr4mPodVkHABgZcOU_39fc4y8ZNF7e6
    -DIieX6XvIyCbj6eQ>
X-ME-Received: <xmr:PS3MZgk6EjuoRw0RXgY_N7wkyAxB2l6Nmb-tYLNYBBpcIe2zyLpyq-Nn_OB1YCY7xw6DKWgkhGS5XIHTt5PYfUPmovm5Ar7yfQQCCq2tO0YhZYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PS3MZvw3FhpHjkQpTqggppRViJnMkYfydo9XUZDwdBjTWT60W3Y9Gg>
    <xmx:PS3MZqQCVnKxITdOKNCCalHh6ZNNBVBfEdMKjry23Q-1Lr1wqJnUJw>
    <xmx:PS3MZiYUFR1QTlCmAuHqwr-XR8nHRkmjW8kfr4X2mTRsli7Cnivekw>
    <xmx:PS3MZrRJuUsdaqjqx9zo_TE-gpLA_0O_lqkildY_euNtzgVwOwdOcg>
    <xmx:PS3MZtLGZeCjPgquA3NBzwQUW791rj77Hq8HQ9L15GhxE7UK-42faFd2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73860378 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:34 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/22] match-trees: fix leaking prefixes in `shift_tree()`
Message-ID: <05461e3b1c02488046ef480f20c109b51b9b7691.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

In `shift_tree()` we allocate two empty strings that we end up
passing to `match_trees()`. If that function finds a better match it
will update these pointers to point to a newly allocated strings,
freeing the old strings. We never free the final results though, neither
the ones we have allocated ourselves, nor the one that `match_trees()`
might've returned to us.

Fix the resulting memory leaks by creating a common exit path where we
free them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 match-trees.c            | 10 +++++++---
 t/t6409-merge-subtree.sh |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index f17c74d483f..147b03abf18 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -294,18 +294,22 @@ void shift_tree(struct repository *r,
 		unsigned short mode;
 
 		if (!*del_prefix)
-			return;
+			goto out;
 
 		if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
-		return;
+		goto out;
 	}
 
 	if (!*add_prefix)
-		return;
+		goto out;
 
 	splice_tree(hash1, add_prefix, hash2, shifted);
+
+out:
+	free(add_prefix);
+	free(del_prefix);
 }
 
 /*
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index e9ba6f1690d..528615b981f 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -5,6 +5,7 @@ test_description='subtree merge strategy'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.164.g477ce5ccd6.dirty

