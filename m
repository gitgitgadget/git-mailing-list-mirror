Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8D43AB2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162743; cv=none; b=UQ31CT5bGdYtxxIobp3Vn0Mj7kFWbbx5gzKJy8f0guxPTEp7vx/YbIQWfSNqNYvyJXNn5TNx9JfKDzVKcdjZWviZTnvo2RE2NW39npzR2Tbn7O8wgk1r0+DB2v37JDHY3nXhOIGUvCcENj+ZR8y1T0oWXJJleLydEJCjoXnlMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162743; c=relaxed/simple;
	bh=C5cwareO0W7oYeLcgZkeCKuwuCjDCFyEOhsDpvAgKxI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV/oGVWZElRmwRozZmLuJES7foCOFBing+T8YfL2o2KrIqiNzIqeZWrcDTIrVmTr8DG6eQApR7LKvcZV1//LGoCEbl0EppVfkpqzFImDuJ+0NAKZr2SOzkgbn4ftDra/W022XjbVp0CcKShPeSr9NeinKOU8aV6X8rie3pZOrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZNJgrPrn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evXBMWHF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNJgrPrn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evXBMWHF"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 77E48138FF1E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162741; x=1724249141; bh=8MsbH4+FTr
	HtG/Xv2YoGxlTRjel4tAHFGdg9PDQNSMg=; b=ZNJgrPrnuth6YkfurjrCVTtME8
	z/UM6gl2jbY5sQ8yxxh3LNAOyvgnHB0rsZcM0V+Tt/3tY/VtLVqoUprX8DOUDTnF
	TmGT7NdywBiI+FN5qNpdQ0ldsYSo4Iuivjqkot0GMw+JzGr4XrMB5lXttFhO+30W
	s6Q9WpyMzRMAQlGEdfWK0wZXkejOUcHuyM6KXZ5EOzAm1itmitNeQeHwEZ+BFhry
	LbndWZR9mgrSe5iGVcXdaENav2zlCeu3cVr0DnkwDG+p/ZK+6Z1KL7+0BrOqJ1ot
	hbYN2Q5qHc3jQL4JLs4EbE9mFyLgVyYCQzRPK4ZqJoyD3qx1IYndi6+6Hb4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162741; x=1724249141; bh=8MsbH4+FTrHtG/Xv2YoGxlTRjel4
	tAHFGdg9PDQNSMg=; b=evXBMWHFn5i0fxBpwJKEfA5BdUDdZSfweiY2zjdPw85i
	hh+s4alfOFaJc9FHSPePAtuahPkCPSuMxBSPWmohn3xw4GoXS33lUdmBpFFrHjwE
	ja+eRgjWIM0+xCUrCFJc+5IaIGVFK7VDjh3AlbKOScChNgXjgqXQCChJKtifr8Zw
	a9x8bsi199SqcqlLWIzuyPYrwxQtlIQCPqn+OeJ4iGj41Rcjt3UbFBLZM975NFT4
	BOSW/Z1zRd1lCPFpuyaGYAEaXxumF9O8QvShUjJR9GlziK1EuL7sNIHb0F0HOdxs
	T9Y90LZ2a0N3Ti304DYEd9bt0sQkVJdVxaL4bmJcDg==
X-ME-Sender: <xms:tKLEZqNamHpI6b1eo_k05p6l8n3tLhqpyQIDbZ0D7TCD1FhqDDnE2g>
    <xme:tKLEZo8lh0RgDD4st6t-KFEae-by71ntzPNSLgYyhxIU-Cd_8a6oJUkZeLTPb9pLm
    U_9KAq1ggIEirO1uw>
X-ME-Received: <xmr:tKLEZhTQfTJCcS4JmoOdoWNInzCLydsPmI3UvGTsce3v4zc68GbrphajxFmfth3pg5sfgoSnRLSYtdnZreH7ZOpa0z8_jHuX890kwwhhss6QZjuXwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepkeelhedtfeduie
    elveffteekhfefieeuvdegtdffiedvtdduueefveejffduieelnecuffhomhgrihhnpehh
    thhtphdrshhhpdhhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:taLEZqv81vcWRmPLDBJmnV1kuOPQs3bynb6hDt7la-o_an5SucNM7A>
    <xmx:taLEZif7ciEd9757V45OPKZKhrAJ28XzG92m9AHRugskjsHyxvvHxQ>
    <xmx:taLEZu2VdGYyOPxwk5SVh0uqHR6lT9pnzjTmhaWH0OD9CQIXo2TDeg>
    <xmx:taLEZm9VcI3wywEDgRUe7bSb_RZiCb_Y2bkbn00yTwMjuU1AE2LFYQ>
    <xmx:taLEZmHSsk5mDr2_9shUhD0DDclPSqpzKSGAGeuFH5bdzRe-jdNxs3aa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 901dc1b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:09 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/20] builtin/send-pack: fix leaking refspecs
Message-ID: <5d8e0a3d8b4c063d0c707a1bed8c692e6719c47f.1724159575.git.ps@pks.im>
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

We never free data associated with the assembled refspec in
git-send-pack(1), causing a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c           | 1 +
 t/t5400-send-pack.sh          | 1 +
 t/t5401-update-hooks.sh       | 2 ++
 t/t5408-send-pack-stdin.sh    | 2 ++
 t/t5548-push-porcelain.sh     | 1 +
 t/t5812-proto-disable-http.sh | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 17cae6bbbdf..ef0df808249 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -338,5 +338,6 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	free_refs(remote_refs);
 	free_refs(local_refs);
+	refspec_clear(&rs);
 	return ret;
 }
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e133..248c74d8ef2 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -9,6 +9,7 @@ test_description='See why rewinding head breaks send-pack
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cnt=64
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index d8cadeec733..3c1ea6086e7 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='Test the update hook infrastructure.'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index e8737df6f95..c3695a4d4e3 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='send-pack --stdin tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_ref () {
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 6282728eaf3..ecb3877aa4b 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,6 +4,7 @@
 #
 test_description='Test git push porcelain output'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 769c717e88b..f69959c64ca 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test disabling of git-over-http in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-httpd.sh"
-- 
2.46.0.164.g477ce5ccd6.dirty

