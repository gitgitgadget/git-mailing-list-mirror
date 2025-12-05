Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBB2DA765
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922824; cv=none; b=E5PNSE1D8oFBkJ46iRkElaYlMi/Nl9Ag2m+9l0tuoPOXCNuT/BzosXepP61ghj9JOtF3dZF3r35jGP5uEGVjom4M22scIcWasMEbM35diSV5MT6Z7UECWXfCMGPiQUAhK7kpL4jgXNGk5U33tzPSHLmW8W2YZ3a9GJ+0o20EBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922824; c=relaxed/simple;
	bh=q0n+qxjkgFmizxvLTgwwVmFGDwIRRYmyO+bJwSleJI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1D/S5Y9NyLFkXFWusG+B56qUT8a8fON7/CkREr9WrjbDXk8yvqPF3Y5rd5qEr7BEARGgmtGe+3kr70W0oiez+aCCxGCJEZeVMLXDq/2ogk9r4lS/OVspgOYX7kAnOSPoh3kz6CoDmj6stPrbIgKq6Gutajur946RCcQ1GPlsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VmtdXxSO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFKUywWH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VmtdXxSO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFKUywWH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EAF11D0018E
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 03:20:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Dec 2025 03:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764922814;
	 x=1765009214; bh=lkoh1p8YhsBzO4QSpjXZgcfJyaIia9PUQFI/kYFAc60=; b=
	VmtdXxSOWFO+G6hNO/yVLtv5G5/0V/2VDe1P1nTgcfdZVpqqxgXo5SCmh44Tk71F
	PBKQ1VK4OB+FzvrcMulO17M7ZIGEiveZ0AhhBwIG6j+hmDOs/I8NbCkupsKz2Ier
	VBCShhdrcl45J+AErzqY7yuGXAeOQ2HKnnLRxyUoAXJ1S0ytZL2umpa4rDY8aTbf
	mWviYrKD/amBTRbwDSq/sZevGV3tpmlkVHYP2f6a9Ofac7/RPT8auon5lslE8GWa
	XvmoZmTLUp4K1U8cUDCuP1Crqwzep8knDwbtfx8giyeDGuJfHubptPxs2mhN7I3i
	dUtX5IzqrYg1EzHFfWHhXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764922814; x=
	1765009214; bh=lkoh1p8YhsBzO4QSpjXZgcfJyaIia9PUQFI/kYFAc60=; b=W
	FKUywWHaF0Z2kfMHzVIOxx4pQsLd+Q+3O9P/QeRfvHfPh9pJKwgDjAuEa57Oq85S
	Cogwzrgo92PkyGaqtHRNlM+7uHvFBFOG+w3tOaqV83ARdZuNWBXuAHTlTLcZOMAe
	4izkpUW72dWInVRHolJE/QrV9j5x+mXQW5r0FS8yPhPWqSxgBJrJC6rAnccZG4+W
	fdMS54nvvRK3DzG7sP+pppuZo1iCWchFV51Xr957oeLCpkXiLhqzs/C8Y/DRP2ef
	PzWpwngLCv0hR3CaGIrg3PZhffTVMmoZKYxT3lFovNIbR8xoEjoFMksj3hJD4zFz
	Uac8Umq1XK55kaqjws6qQ==
X-ME-Sender: <xms:vpUyaW4pZpv0GGMIInv3UGLlKY065NorrT7sWB8FrMgz4VdkHyU6KQ>
    <xme:vpUyaW2MwC9SdA6m-y95zsUCKYqSZKLINF8voVCOITK_IS8qIYIqd4YPYYiOW1wF2
    bbPW3SimqNakWzc8krSclvKUXIu8TA3Bx__u-kT2qGUhluGK8k3Qw>
X-ME-Received: <xmr:vpUyabEjxMmdPPjhUUTQ-d7KS_sLGqbpRImJB1Lhlyo57BYUPHzEbXK4ileqp2bvzCXOI0i3BKjpoEmt10aqB04c2TO5Ig7u6HvQNj1TZa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:vpUyaYS5Ne4J_Ny9bMcZs8X8nwM51WX_Ql97RUVVR1alDIb93nMDxA>
    <xmx:vpUyaaCKYdCj7f3rJ4kKiNJbfvlZAAz5-twS5ohda-gY_CysHsL_6A>
    <xmx:vpUyaQ2zPqlhO1eKghUVoshIEhb6pX1XkDz5rOc4ankm_hgGU5wM3Q>
    <xmx:vpUyaQX0isnArLKeYkj3BKDjlWQBxAisdJHVBY37gMry7F1BVgpz_A>
    <xmx:vpUyafZx29hIjOd31xWceenW72jb1giN8laFoJBrhqX9fnJEuyLbPkz9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 5 Dec 2025 03:20:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0178a8a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 5 Dec 2025 08:20:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Dec 2025 09:19:58 +0100
Subject: [PATCH 1/3] builtin/repack: fix geometric repacks with promisor
 remotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-odb-related-fixes-v1-1-ef4250abb584@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
In-Reply-To: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When repacking a repository with promisor remotes git-repack(1) knows to
pass "--exclude-promisor-objects" to git-pack-objects(1). This option
ensures that the new pack will not contain any promised object that do
not yet exist locally.

This command line option is incompatible with "--stdin-packs": the
latter option enables the rev-walk-based machinery to figure out which
objects to add to the pack, whereas the former tells git-pack-objects(1)
to merge all packs passed via stdin into one large pack. As we do not
know to filter those packs via the passed-in revisions it is clear that
at the current point in time nothing sensible comes out of combining
these two options.

But there is one case where git-repack(1) decides to pass both options:
when performing a geometric repack we always pass "--stdin-packs" to
identify the packs that should be merged. So if one performs a geometric
repack in a partial clone we'll end up with both options, and that
causes the repack to fail.

Fix this issue by never passing "--exclude-promisor-objects" when we
have a geometric split factor. We don't need the option anyway when
doing a geometric repack as we will only ever pack loose objects or
merge multiple packs. And neither of those cases can yield a promisor
object.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            |  5 +++--
 t/t7703-repack-geometric.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d9012141f6..4621eed3e6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -294,9 +294,10 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--all");
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
+
+		if (repo_has_promisor_remote(repo))
+			strvec_push(&cmd.args, "--exclude-promisor-objects");
 	}
-	if (repo_has_promisor_remote(repo))
-		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (!write_midx) {
 		if (write_bitmaps > 0)
 			strvec_push(&cmd.args, "--write-bitmap-index");
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9fc1626fbf..6d2c712bff 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -445,4 +445,30 @@ test_expect_success '--geometric -l disables writing bitmaps with non-local pack
 	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
 '
 
+test_expect_success '--geometric works with promisor packs' '
+	test_when_finished "rm -fr remote local" &&
+
+	git init remote &&
+	test_commit -C remote first file first &&
+	test_commit -C remote second file second &&
+	git -C remote config set uploadpack.allowfilter 1 &&
+	git -C remote config set uploadpack.allowanysha1inwant 1 &&
+	git -C remote repack -Ad &&
+
+	git clone --filter=blob:none file://"$(pwd)"/remote local &&
+	git -C local rev-list --objects --missing=print HEAD >missing-objects &&
+	test_grep "^?" missing-objects &&
+
+	# Assert that promisor packs are left alone and that we still manage to
+	# create new geometric packs.
+	ls local/.git/objects/pack/*.promisor >promisors-before &&
+	ls local/.git/objects/pack/*.pack >packs-before &&
+	test_commit -C local change &&
+	git -C local repack --geometric=2 &&
+	ls local/.git/objects/pack/*.promisor >promisors-after &&
+	ls local/.git/objects/pack/*.pack >packs-after &&
+	! cmp packs-before packs-after &&
+	test_cmp promisors-before promisors-after
+'
+
 test_done

-- 
2.52.0.239.gd5f0c6e74e.dirty

