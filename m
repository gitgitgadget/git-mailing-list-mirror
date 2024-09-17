Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3D14BFBF
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557197; cv=none; b=oQfC89FQbFuqCGmfQ+53rv2lokuzEFYsbvZRpfpaU8b38ri/q+nRPM1SDO6Bo0hXS9ziYzU1cMWHhz7qLcbEhIyz3U9fWoanEaEPF16Yn0Iwv7mxIRP20higbuajaY2+NUN4GNBIXBfw2NLwa9c8+cqyqtV2h975D80rOF/d6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557197; c=relaxed/simple;
	bh=GmzZHc4pVuBWFIwlhR4wm6gz1uQMwYIu2BBxer1xr70=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqRfaKyaVLJ3FdU/nc3WN7OYjNqGCFU+ZbSX93GMzBX8A4f+f7Jin5lunW+PUBRbB6srA2cGa2Uy9wMLrCg8w7fehi0ocgpnUGtnwz0064eVG6tgEkJHwpXH5NjzWxNicPO8oSFlxBr7FUHfpeBH7olasg2gBL/K05AuVZxBn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lZjLXFUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvshQYcR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lZjLXFUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvshQYcR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4305D13803FB
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Sep 2024 03:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726557195; x=1726643595; bh=Ok2tkGaO0e
	9Ye4Y2j9nMG1NIhDDL9FWs9sa4RZ7KrQc=; b=lZjLXFUGRZA1Z5A6vtTt7Lvd29
	aEzNj1U2F3vDmOvId8JdoR45XTMGetWBdEr+DEoSVjAlWQG6Bl5pt6y3bkAur5uQ
	M6bTt/j4Y5mX7FcwWF63a+uqQvaYcyFLKq/NtRLPn6o9WIFXeWOo87IPDQFtKn69
	c06cSyY0KZ33sVRSDnrA6Dd74JjJM5wWP9amVG2VB0lsoJJ69uVLa2nr2lFPcl01
	28IZCzwaovnOiHpHuJqtKLQRuoM8XhZKovDKcDbJO6gmseCtQQ/hZcveD1UjyWVf
	ImO3Xs+LEeTL73sMOigqmMYiuSzywYXv+AHLgBXi2sFwqcH33qSwT2D8fvcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726557195; x=1726643595; bh=Ok2tkGaO0e9Ye4Y2j9nMG1NIhDDL
	9FWs9sa4RZ7KrQc=; b=GvshQYcRff+WMKrdH2cWB1Mz5wr0v6GO0DX0W73AIGKd
	xWAAcHVdQegjKuTiAlfCkN6FlPBXgfW2gJAST42HN7xRujZmgFyZoA6elThTLdxQ
	fXYtf3FZVk9trw9uaZaVcXYTRZK6d5xUFchA95i1iPKVV8lEErqhh1/qvF5EUuuM
	qPCQUB5iR3K9TJ1ni5cFWCJwKX0YJI+uBhXC1ZhXK8WrhnZZAP2scxHej8MxrTnN
	MM3ylgSkgBgkSDgnlFHHsdtNLIQROkHVE6Rw15G9IcuywiF0J/jpn/CphZHLql1E
	cc5Ybo8QSEfNf0XHuVcc/R3bAB+QiiYE5jazzaa/ow==
X-ME-Sender: <xms:CyzpZq9i7pfua_Usy6m5rSoBENVZ1-I6iYoRCPyp33xuW0Z2DI2UZw>
    <xme:CyzpZqtac-CzLjRxmBPxnWD7Ydq_5AT7t5Hk0iQJ3ALMB7aaTOoDcY3VkeSNuyQLE
    quP38gY0Ete5zpWdQ>
X-ME-Received: <xmr:CyzpZgCVlwtwPWjOQ2snoqyIMkvSOVgL5aPsK4YD-kiY0pYL7Brs9PXzWBIGZoFsoA-rHUGCDifur3jZZ-GvI7oWdnNGNHKeT-6wYJz_5bno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CyzpZifdS8BkGjVq9UoO8F97lXPKjuP_bVENH683U9qpVpAcEjPPew>
    <xmx:CyzpZvP3Nfc1NWR7YTBvaVKlghqMBYT9IXR4aveLO5Rhk0e8lZGXbA>
    <xmx:CyzpZsmAqY1OJRpSAqjm98eoIBl8_A7GvxtLYxAw2NpP6BurfaTvAQ>
    <xmx:CyzpZhv9yRSkfuV8lW6tcaU8U0ONqZ--CYG1dMtDcIEAdkz10JUHVg>
    <xmx:CyzpZl3GHDPEQPfOWuB1PtzQGpkVRuVvTRdZBSe4SFCCL1J16_B02E_H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 03:13:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb6b34bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 07:12:55 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:13:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/3] unpack-trees: detect mismatching number of
 cache-tree/index entries
Message-ID: <e2ba015ced1f390966c7bae46969d7725e23fec5.1726556195.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726556195.git.ps@pks.im>

Same as the preceding commit, we unconditionally dereference the index's
cache entries depending on the number of cache-tree entries, which can
lead to a segfault when the cache-tree is corrupted. Fix this bug.

This also makes t4058 pass with the leak sanitizer enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4058-diff-duplicates.sh | 7 +++++--
 unpack-trees.c             | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 3f602adb055..18e5ac88c31 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -10,6 +10,8 @@
 #   that the diff output isn't wildly unreasonable.
 
 test_description='test tree diff when trees have duplicate entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # make_tree_entry <mode> <mode> <sha1>
@@ -143,11 +145,12 @@ test_expect_success 'reset --hard does not segfault' '
 	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
-test_expect_failure 'git diff HEAD does not segfault' '
+test_expect_success 'git diff HEAD does not segfault' '
 	git checkout base &&
 	GIT_TEST_CHECK_CACHE_TREE=false &&
 	git reset --hard &&
-	test_might_fail git diff HEAD
+	test_must_fail git diff HEAD 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
 test_expect_failure 'can switch to another branch when status is empty' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 21cc197d471..e10a9d12091 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -808,6 +808,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 
 	if (!o->merge)
 		BUG("We need cache-tree to do this optimization");
+	if (nr_entries + pos > o->src_index->cache_nr)
+		return error(_("corrupted cache-tree has entries not present in index"));
 
 	/*
 	 * Do what unpack_callback() and unpack_single_entry() normally
-- 
2.46.0.551.gc5ee8f2d1c.dirty

