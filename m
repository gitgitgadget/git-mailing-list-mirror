Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1C1A4F04
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908493; cv=none; b=f1bXB/nBipSGwC7ZP5eHKAmt7s4tBYQ3ilmNK5Ck9c3r77KYuw8Fc1UaG/amcEci5mv5xXWOjLsaJqmciAd7jA5Co1cNkLEGQHBacsfHyokYnEWzQKX8/l5TtGnOCJlXXdYIKBIcWN11iEoXkb4ROkVdT2M3nNpFRQ5OUmozzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908493; c=relaxed/simple;
	bh=2BmG3z9TqUOrVHBHSy55Fu9COOiEUUD27aTmDVa4T9I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhoZxlE8Wyf25d/zIDW+Vb2+CFQDK8bpRb4jaj6K7mJvRVK/IWx954Qq1Sbk87TgdZI2Fj6i1vylJv+le4eab2zva2DHl6fwvpe+eSMlS8ZWnIbvB8YcuLGZ83FtYHAzbJTeBVdI/3BAu7J5bMlJEFctzIJoLzXLOYUL9H5Msx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o9ownwk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg3e9Gme; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o9ownwk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg3e9Gme"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 688AA11401EE
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 14 Oct 2024 08:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908491; x=1728994891; bh=YMaCYBozvq
	tlOyofry3RKba5sBd48rRHsvJAXIcichM=; b=o9ownwk/z0kJXzeVSStqPl5C7Y
	Y4ZDRMhQwx1LRXGZoPBXkMszD9E229KDRLz8rQV31J3gLfgiFVhYhVbY8JyorZT+
	spy5DJAzBKMrwYqK9sVIUiiXJqJ49MeRo6rGplK4VUiv5Gxx7RACGLmkfYQ0EiOR
	iGOMK4MjB258tYjL1LpTjPPnMQJt3heZCHauGp5syCdj9A7LeGr16FEPZrTQq4tH
	cKxklt3mEGlpHfkpFjps1rHKzOQaXVGX4GaMK2myZ1trU/WX1YVQdTONYR/KpZry
	5/3ELlgxhM2AkgTIXQd47rKDNQZvSUlz6sOL8rKRG5K1JnIPQ/RQ/6/JLl2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908491; x=1728994891; bh=YMaCYBozvqtlOyofry3RKba5sBd4
	8rRHsvJAXIcichM=; b=Rg3e9GmesAU3MhZ+D42LioMmThw9xpPFAKG4zrpSsgnq
	iqc/Tdujk3gBA4oBXGUKTJziajhmLiZ5kawHwtz9Nq9tgaVwXoRlZkKLjpFlbHVU
	aMs1Dvu4VRhHrEFc5MdQdeRUvbMm6k4wfdm1T5bFF7u01K5xH9XXTgqGJeyuCI0A
	j58rHDkRbydjp3aZP3BpYR/cvmYfXTldrZfj8+bNPgI2PDQ0SQgrG9QqaAGklCfC
	WydlaOMpqfzvhkhgxM0sobJCRcyBwQBcBZbc12vsLYDO6pgd7hXNUBLUuC4q+IpS
	obz1BLYgLMRIJpETU8cKbp3n+5wHgolN/b9yGTJrAw==
X-ME-Sender: <xms:ywwNZ1EMHYZsyx9GJ02S6BzS59Rz2yHIBQGj3obbDGz6gH-jhHH_CQ>
    <xme:ywwNZ6UgERT9dklNtzpPgEoSEa4eerloMsJlozdBgKPmU8C54hnxN3XqUaIDO8ik7
    7nSLiHBHt5phlUmOw>
X-ME-Received: <xmr:ywwNZ3J8GxT5pMKV8eMvv9Nhx3Qew-rZmlFvJuyudWzGVC2Ff6MB9au-wjgFiCRJaGBOW0nYgk_Y858iK4yReL3gZZWJm8rVUYJcj9tYn4oWZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ywwNZ7HUfRtG4XZ2UvsAmqjOgxoOWy375Q7V6G_NZCXWetV3zVKnpw>
    <xmx:ywwNZ7VZGo9dSYX-cqS9sxAM8V6hCO39pn2h2caf0kK4VhJkkM8h4Q>
    <xmx:ywwNZ2Nsk8TUw3108MqDkRLwQHfAkNo9h7W6R6Cg7oVLN30S8OW11A>
    <xmx:ywwNZ62pB14LZ9sMgghD1c5oMNvghgIYo1jUBoaxmvrxCmCVU8FNtg>
    <xmx:ywwNZydlPno-Jb41qQjU-JsRKJ5xv1Gwih1CRKQgXTUTh8s71vQYAZN4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 458cef55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:18 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/10] t3404: work around platform-specific behaviour on
 macOS 10.15
Message-ID: <a82a6b3df70c36e5e2416ddd8c3b0cad644b925f.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

Two of our tests in t3404 use indented HERE docs where leading tabs on
some of the lines are actually relevant. The tabs do get removed though,
and we try to fix this up by using sed(1) to replace leading tabs in the
actual output, as well. But macOS 10.15 uses an oldish version of sed(1)
that has BSD lineage, which does not understand "\t", and thus we fail
to strip those leading tabs and fail the test.

Address this issue by using `q_to_tab` such that we do not have to strip
leading tabs from the actual output.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..7ce75237803 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/second
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/second
+	Qrefs/heads/third
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
@@ -2178,19 +2177,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/third
 	Failed to update the following refs with --update-refs:
-		refs/heads/second
+	Qrefs/heads/second
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
 	tail -n 6 err >err.last &&
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err.last >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err.last >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
-- 
2.47.0.dirty

