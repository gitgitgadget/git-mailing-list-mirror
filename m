Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC601922C7
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162718; cv=none; b=QWWBq46MvPVi7gKU2j1j2uu6Tmu8s7GfoKloxrcL64XbKWgz+oQt2HsIITwGMAtWGTRK577clkWNlODrQg9ybcKSrpK8pQ3jCjGAtO7R5sdDnpF5PygIbIHUseuHum8GKRoMWArzCwsx5ftEeUdoRRLILdmvRSyRdmBM8y4+NcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162718; c=relaxed/simple;
	bh=mcRQa9G7hy7QauywfNNmby8ICn9wUCkZYmWcBv9yqGE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEJS+uf8Vgieo/Rtuna9e7VWJVltKocZ8hXQXQ7qOhPK5ik7kzU8s6gpYjq/MCtgQaN7jdLPCe8lreV2OTGwUEYoaFzUShvi9MjygvQDNwEDIYJkX02Ey+IGKzv4NGQrq1lMVbPmbeaE3L7xYQFSq0UsCQnfzvppdnBxPVqY9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cXm25ofa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C7kkGRlM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cXm25ofa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7kkGRlM"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C6DDD1151AA6
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162715; x=1724249115; bh=HX6AGxmsBS
	j0RUbqpwNe1xuthWI35IE6uoPJO6H0/dQ=; b=cXm25ofaHu72QWoHNG1jVSwRcq
	WUhXQ63/KbO0aSdN93WO2KoAyECGutL6AHLcAs36WsjBfAJdoF3gFzhXaDx8AZES
	O5MspKQmR/9zZ0TD43STyBwCEDqIEuR4sO+/RvfP5i5u63uqMK4FvXqSnaCzkNV6
	I4wTu+7IL6vAo6M/6o/FlSsD2F6vqxR+dxzVaCAefR1lhdQn6Eo8jwfGrt5CfXQJ
	h8yb8QwUWt+H+wzS3jijkaesGX3gMU5vfEcObjtgyizk2WHn89wifAWTFaPLll+w
	nfAyNZoGr13KxGRf7JcnlnvaSHZcR65h4Qx7zrU8vEN/AEydQ8ImQ6noD5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162715; x=1724249115; bh=HX6AGxmsBSj0RUbqpwNe1xuthWI3
	5IE6uoPJO6H0/dQ=; b=C7kkGRlMpWypJoAH4RdMA26s5OA5M+xIhhJOC+l+Gdw5
	+lQDnrYy3c3RI8H7zukN5MmZK00k6rx00H4naNb+p/iDFQ7+CbauPxNGMkxy0u0q
	e3zZCe6+qc+iUBfmiblgfq+9yJ1PZJYDNsbmYXbNDaji4Zfsqq8fVvv6I6rm5iip
	pu18Lsy22Jydkt2DAkdglkmt8KcGEIxwHtbdmY9LlAqt3xLr2FJ3Bvykx3sSiTj6
	kePL6Dk4xjUfXBCONyx/AepoH1rrqFaj181PAKu8t3FGU7373Mgsw2OXkjRXdlhn
	LrtJTHOd9iV6Z6Pd7mA/Xor1gkdvc9W2gHou0n84jA==
X-ME-Sender: <xms:m6LEZgzV8ud4wO2lkXvvxHqXnwQ8OgBKYCMCIyfmGng7pa_aNg9v0Q>
    <xme:m6LEZkSa0wQCKX3NLD1W088D1TPAuOwsQWMGMpbzZ0F8Jx8B4inLz78H146jTKgOi
    NAj_tp95RrNoFuuQA>
X-ME-Received: <xmr:m6LEZiUfwlBlhAdqSWLbwRye63iJ-e920nyX3KeUNREIfLCeWOAAjPUUX1VBSFNOl7spBjQzVzUoFcHY31X21soS-gttJfsGrNi4UTt8ga_JYrUNew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:m6LEZujsodtVqD8Bu3fOUOE4Zjz9QDR0Bdck5CGh0vgHI7YNjSX3Fg>
    <xmx:m6LEZiAT7tAzUKnSHl1KAjWuAaE7-bAQEcFch7hTHpZ2-xCPUtMcIA>
    <xmx:m6LEZvKA87ybqeRJsPn3reL40O4TC9CRvPfljRYZQNSZYUZgNG7jWQ>
    <xmx:m6LEZpDkPGf6aJUODLwS3wI0L8GOWSX4dDDgTzur_iJwwe70iDcf4Q>
    <xmx:m6LEZj6t4lJzt2tER1MQFWGS4kZ7HsznSliSRtMnaleR1hJbz9z-0I5e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22c054df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:43 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/20] builtin/merge-tree: fix leaking `-X` strategy options
Message-ID: <53db2fc7206cc11cae4930eba8c413fce4715afb.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

The `-X` switch for git-merge-tree(1) will push each option into a local
`xopts` vector that we then end up parsing. The vector never gets freed
though, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge-tree.c             | 13 ++++++++++---
 t/t4301-merge-tree-write-tree.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9bca9b5f33c..c00469ed3db 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -533,6 +533,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
+	int ret;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -625,7 +626,9 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			strbuf_list_free(split);
 		}
 		strbuf_release(&buf);
-		return 0;
+
+		ret = 0;
+		goto out;
 	}
 
 	/* Figure out which mode to use */
@@ -664,7 +667,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
+		ret = real_merge(&o, merge_base, argv[0], argv[1], prefix);
 	else
-		return trivial_merge(argv[0], argv[1], argv[2]);
+		ret = trivial_merge(argv[0], argv[1], argv[2]);
+
+out:
+	strvec_clear(&xopts);
+	return ret;
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index eea19907b55..37f1cd7364c 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,6 +2,7 @@
 
 test_description='git merge-tree --write-tree'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
-- 
2.46.0.164.g477ce5ccd6.dirty

