Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC1267F7A
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908478; cv=none; b=CJWiogDqqRPBnAxXpeiyH0MairkRM1PPhW5WJQAWxwjGED1fjKTcpmkh7PWsLiTN+5iM2EtpzPTFylZvPem5YCmkonCnN2YNIpZnPzPHBSVZgIR0ThHH4GOspzSSDbbNjaUJ/BPe4uHwkce2NjhFrDTrQE6BbJmnvMXkkVjBg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908478; c=relaxed/simple;
	bh=pWr3UcaWANc8naJen7QnchaDNFox7PBbI03NK6qmi2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UunsBktGB4iQAAUjiGM9c4vNTxecHBsGz9FeCpG+kRwgLXCjzwvOIT15JPzW6GALgK8cXq82VZNTm+jygFJKJbHMEDm3qVeJNbsXsr4mhNS5a3novGTHyI2vy8dWj05oA17hUJyiZ6aBsMQ/bM5JzbZoLrvIIO+S11E+P/PMa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=euAgY9tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpYYslAV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="euAgY9tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpYYslAV"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EDD0213838C6;
	Tue, 25 Mar 2025 09:14:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 09:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908475;
	 x=1742994875; bh=wAM+E/mH1X/v6GuqkS1/CQ4VcAw05+8QixkS7TW35Cw=; b=
	euAgY9ttE0kyJuK46Fj0J/hdIDKd25wNGCSFif2+JB1D+raZQ0R+O1fUklezFJMX
	XGu7fm95IOOrVdm7u0jR2ErunOSFQdLL2yL7l4X8rar3RnIEZvTVLUykZef7JGhI
	Nq36L7wehIZdvnmPu+TJJaw2szAaLMVJaGdSmLR3qBSQXnzLy1y1wq9X5UzjCfV+
	HlG9TQy/u6sB7ddLDOU7Clh9GE/qFsmnj+SD8PhN1OxlbvVFTimz43IiiuphP92s
	8t2OOFVOTQ6Oyx5q2ofcJo7n2W1jmPUYBgYK6lxbAgNwVpCZf0iiwfHmbVYYQe/s
	gq2Q8eWPcwQm1S8lcuysFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908475; x=
	1742994875; bh=wAM+E/mH1X/v6GuqkS1/CQ4VcAw05+8QixkS7TW35Cw=; b=h
	pYYslAVougikrEp/BIXKVQoo3lmGq0OxY5v+EVYtubWGhBgfloVonlmERmwlo6/S
	oZUsQc8o4AgNaPDHUhZHXQhkUQDBqzz60YBlDvtrasKE99TWQDLMU+CkRaBki39m
	UQxpfNcZOigLiyGQb7VcWxjSZYQg7uGeGaPleYGp3tEPAT4swqcMAkIxwuWD0EgG
	Q+WDi9eZyzOhB7Nmj0Oo3tTenL8sebitEOtVUY96LdpnR4OTCtYPaiyhG/6O0T81
	RAbXpcgwmPzu8J+MHItMVVHw+feQCFx59ea5ajp/TkCjUK/6QsyygSJPeyakTm5a
	QN3Wa+vTOtJR8D0xCp8OA==
X-ME-Sender: <xms:O6ziZ0bWShySRhI4o42EHQdcKrl09gcvmz-1zxURC1XgrCmbFY4tgw>
    <xme:O6ziZ_Y73syCTPiwlxQpFjcQjFsJZ6AWlkruOiYu_28nvaxP7VryD3QF-4IBnq2AY
    pxzaPeu0cwiaTpMlQ>
X-ME-Received: <xmr:O6ziZ-_jpnYTmC52raJ04Wpvtk0mEp0hDnls6wqIgymnq5DkEhcVDvMzs9FYA3VFeCdsx3w2uuNeGFZVGsr9y-Vc611Lk34XIgxkIwP0CPDJ0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:O6ziZ-oyDx0M6eojNM42i8IoXObWSm3S8w_5qgjBcnR8dlvFVCo70A>
    <xmx:O6ziZ_qtMh9WK6iGqfFBvcJTuGHoDiFNmWacMno53aOvnZfXy2LFOg>
    <xmx:O6ziZ8RLQYC8BI9eK0F6-CzYmvnN7k_wWWnoXecta3FDCXccBAbAyQ>
    <xmx:O6ziZ_rrLIkp9pDaw85IqfsnO321QToag7NMTz9IJUcEloBjSdXJ-Q>
    <xmx:O6ziZwBQDjYHwNH23uLyKxt6fkmsGfu6iyergS_FzhFfg2y2ycDAWWJD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acb23c3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:31 +0100
Subject: [PATCH v2 13/20] t: refactor tests depending on Perl for textconv
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-b4-pks-t-perlless-v2-13-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We have a couple of tests that depend on Perl for textconv scripts.
Refactor these tests to instead be implemented via shell utilities so
that we can drop a couple of PERL_TEST_HELPERS prerequisites.

Note that not all of the conversions are a one-to-one equivalent to the
previous textconv scripts. But that's not really needed in the first
place: we only care that the textconv script does something, and that
can be verified trivially without having a full-blown invocation of
hexdump. So at times, the implementation of the textconv scripts is
reduced to their bare minimum and the expectations of those tests are
adapted accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4030-diff-textconv.sh       | 15 +++------------
 t/t4031-diff-rewrite-binary.sh | 19 +++++++------------
 t/t7815-grep-binary.sh         | 15 +++------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index c7d8eb12453..f904fc19f69 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -4,12 +4,6 @@ test_description='diff.*.textconv tests'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping diff textconv tests; Perl not available'
-	test_done
-fi
-
 find_diff() {
 	sed '1,/^index /d' | sed '/^-- $/,$d'
 }
@@ -26,13 +20,10 @@ cat >expect.text <<'EOF'
 +1
 EOF
 
-cat >hexdump <<'EOF'
-#!/bin/sh
-"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
-EOF
-chmod +x hexdump
-
 test_expect_success 'setup binary file with history' '
+	write_script hexdump <<-\EOF &&
+	tr "\000\001" "01" <"$1"
+	EOF
 	test_commit --printf one file "\\0\\n" &&
 	test_commit --printf --append two file "\\01\\n"
 '
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index cbe50b15772..15e012ccc7c 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -57,24 +57,19 @@ test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 	grep " rewrite file" diff
 '
 
-{
-	echo "#!$SHELL_PATH"
-	cat <<'EOF'
-"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
-EOF
-} >dump
-chmod +x dump
-
 test_expect_success 'setup textconv' '
+	write_script dump <<-\EOF &&
+	test-tool hexdump <"$1"
+	EOF
 	echo file diff=foo >.gitattributes &&
 	git config diff.foo.textconv "\"$(pwd)\""/dump
 '
 
-test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
+test_expect_success 'rewrite diff respects textconv' '
 	git diff -B >diff &&
-	grep "dissimilarity index" diff &&
-	grep "^-61" diff &&
-	grep "^-0" diff
+	test_grep "dissimilarity index" diff &&
+	test_grep "^-3d 0a 00" diff &&
+	test_grep "^+3d 0a 01" diff
 '
 
 test_done
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index b2730d200c8..3bd91da9707 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -4,12 +4,6 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping grep binary tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' "
 	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
@@ -120,13 +114,10 @@ test_expect_success 'grep respects not-binary diff attribute' '
 	test_cmp expect actual
 '
 
-cat >nul_to_q_textconv <<'EOF'
-#!/bin/sh
-"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
-EOF
-chmod +x nul_to_q_textconv
-
 test_expect_success 'setup textconv filters' '
+	write_script nul_to_q_textconv <<-\EOF &&
+	tr "\000" "Q" <"$1"
+	EOF
 	echo a diff=foo >.gitattributes &&
 	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
 '

-- 
2.49.0.472.ge94155a9ec.dirty

