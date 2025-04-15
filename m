Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DC288CA3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711040; cv=none; b=AGU+ElNnfmOOJZTW2J00T3QpgOsQ6RG5mWSmpTxvpdtAjVM6AUb7aqwIa5quRmu2m7LlvSuaO4AqBrPZTRGuAlKFknCRESkPSc5iXwU+/d8lbV8D1RIECyktYHYOO33izO4k1TB6sv7DSaLIo9mnmL+4ErbpWaR+0dopc4q10eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711040; c=relaxed/simple;
	bh=V9vrXurmkYJgWyoH7kbXoDrJfgsQYcJrgToGhRR5GRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2d0PO4D+mChu607QPyGMRs63aOlGY7/r6TIxCHDCl9xdfJ18p6Kc3j/z6ESBezXfL/Jyj0tQoINIiTj1/m1CCQMQrTSQtt7RyRaP1FluPC9rN46rvlnPrKcHUDl4pkptXVET+n1o7rDhR3j78TMrPhLZzR9IKBhTPkKKmBo9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m7Hp3ljm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h24KJsBI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m7Hp3ljm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h24KJsBI"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A419925402A0;
	Tue, 15 Apr 2025 05:57:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744711037;
	 x=1744797437; bh=ab2Rr84K4wwwrfQSRN099LAqhrSMofyZLz66wj7KGu0=; b=
	m7Hp3ljmXZi4FoP5Oe5LJ/qtE6lLjhDU3lP0fxHyiG2QlgP87pr1o4rR3Dj+5etO
	KOfNdlkUlGashVmIqAyScSUE6wb6hcdPB3x7SsfgaETnGcjLd+ogSKCvpliBjRzx
	XtkmDvGwpiXueSRMk+KgcaK1xy34TLtNFACSfOdT+XhuwfL5gjMAeAU+CFvR7IzI
	oi+XqjAZ1IdBWQZULRrF5lkuSwLD7TF6z60Ydbo9bW1m1rnshlUlMrc/32hEgaDg
	pHWtMlsaQLot3lA/ybK0G/IPAjlRX9RiQu5Z5EjlLGVfxcBvtyNPCB2RiR2ilob+
	ZnFMI3fVgXaQteWKbwb6ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744711037; x=
	1744797437; bh=ab2Rr84K4wwwrfQSRN099LAqhrSMofyZLz66wj7KGu0=; b=h
	24KJsBIdAGf5wfla2bkVfATvVxhqEsxGzVII7hkzf9TOv/zqsdcmg2mVWdXGH2Uy
	700MMp0HYuhglvDfmVTHKZ2eLb7Qth5s6NPC7LTweIxjG5SnxAaxWccKsvaZzBDj
	Cmfld0p5aDLT7DRjfPgH0pAsGwIFus5OJ8FoxyPDxSyk/3JvDNx1w7cggzG4IUKk
	uwe1vqnhSfKSXJ+9tpbYlyzbxUx68m4eR3bEXq2ePmq7Da/hO4vxQGPW9flS6foe
	FFYV4LxXtntsSLJYZPo5h+qL8GX1dePGLr3cf+P6Bs1z44LE/1/9OYEzl6B9IrHl
	DpL4ny9u/20Z52HW7l3GQ==
X-ME-Sender: <xms:fS3-ZyFNM7g6xKpD7AxZrAqbCzMUUWe1idrfd9BBH0abp93tTMhxcA>
    <xme:fS3-ZzWZhYWKo_bvk23RttCB-QVwlbxbHT5PSGKYjDHjuxXbolRFmm8oE1nNy-8tQ
    SBoOM_Z5Jjhq9UMTw>
X-ME-Received: <xmr:fS3-Z8IxxAty5gmsT_m5cmYLrNprEhKIVmv3mcdtLUHpS-UJZ1EAczKk1ygTcUZXpfT8fGZ6J3V6YHYGNcGsgkF0J9MFi2W8dZzg5sS3PpoLvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fS3-Z8Hn-KaEVrwsmDsEKxB9pllXpB7GNT2vavQDvAPXBLPW9visSw>
    <xmx:fS3-Z4XXYfhdfm5TWXy_FdDeHrhvS42OexetUCOHGdooEbUP8XWr2Q>
    <xmx:fS3-Z_PdzC63YqW5DDvq-qSxSPpfZWQRtOxePv2WZ8vVaUlwpCuOFw>
    <xmx:fS3-Z_1jRMU1YPsnS6vn50khioGkOSsTdHQ6ferGGDsdGDkpxXz8hQ>
    <xmx:fS3-Z7phtNdFIQbhUhrS_PDbk5U9bqVsPpNFOA2iFIzF8SzeKbc-5tEl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:57:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b507b59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:57:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:57:08 +0200
Subject: [PATCH 1/4] filter-branch: stop depending on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-pks-drop-perl-v1-1-c6addf175858@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
In-Reply-To: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

While git-filter-branch(1) is written as a shell script, the
`--state-branch` feature depends on Perl to save and extract the object
ID mappings. This can lead to subtle breakage though:

  - We execute `perl` directly without respecting the `PERL_PATH`
    configured by the distribution. As such, it may happen that we use
    the wrong version of Perl.

  - We install the script unchanged even if Perl isn't available at all
    on the system, so using `--state-branch` would lead to failure
    altogether in that case.

Fix this by dropping Perl and instead implementing the feature with
shell scripting exclusively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-filter-branch.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3a51d4507c7..24fa317aaaa 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -295,15 +295,18 @@ then
 	if test -n "$state_commit"
 	then
 		echo "Populating map from $state_branch ($state_commit)" 1>&2
-		perl -e'open(MAP, "-|", "git show $ARGV[0]:filter.map") or die;
-			while (<MAP>) {
-				m/(.*):(.*)/ or die;
-				open F, ">../map/$1" or die;
-				print F "$2" or die;
-				close(F) or die;
-			}
-			close(MAP) or die;' "$state_commit" \
-				|| die "Unable to load state from $state_branch:filter.map"
+
+		git show "$state_commit:filter.map" >"$tempdir"/filter-map ||
+			die "Unable to load state from $state_branch:filter.map"
+		while read line
+		do
+			case "$line" in
+			*:*)
+				echo "${line%:*}" >../map/"${line#*:}";;
+			*)
+				die "Unable to load state from $state_branch:filter.map";;
+			esac
+		done <"$tempdir"/filter-map
 	else
 		echo "Branch $state_branch does not exist. Will create" 1>&2
 	fi
@@ -633,15 +636,13 @@ if test -n "$state_branch"
 then
 	echo "Saving rewrite state to $state_branch" 1>&2
 	state_blob=$(
-		perl -e'opendir D, "../map" or die;
-			open H, "|-", "git hash-object -w --stdin" or die;
-			foreach (sort readdir(D)) {
-				next if m/^\.\.?$/;
-				open F, "<../map/$_" or die;
-				chomp($f = <F>);
-				print H "$_:$f\n" or die;
-			}
-			close(H) or die;' || die "Unable to save state")
+		for file in ../map/*
+		do
+			from_commit=$(basename "$file")
+			to_commit=$(cat "$file")
+			echo "$from_commit:$to_commit"
+		done | git hash-object -w --stdin || die "Unable to save state"
+	)
 	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
 	if test -n "$state_commit"
 	then

-- 
2.49.0.805.g082f7c87e0.dirty

