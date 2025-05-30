Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B091547C0
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611914; cv=none; b=uLeVv3CTSpZaRm+KvEO6/+yUZ1LCUsQP3zsR3e9IuYayhEqknDuw6r4eDOPNhvVRKZUuowFC1Lks48hBpWdcKgunA24IKJsMoUlf/F+orf0tQr3TxLpL3czvX6viIbFLagXbkqjHznT1QcJcYQFmX2WP8i8JRuZ1Ky+WtOk1ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611914; c=relaxed/simple;
	bh=8B/bP6w/heCZxNySXoUEJEiz/yx2macfdPzP7HRtvjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkLug7zT6kGgCx/uhNgmAkrnUTRAF0fya+d+kFp3KtPgzEKesxfsy2E5NGrxG4mVXH+cmi4k3S5JiPcQ7g5ceadfkZH4JxwghMRNNywLHo2EPsVZqsLIuxrLeqUk81gpC1X8IbXBSSbzMq44qSyyzW93urzTNSGuaoPtw2GyMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AYAUrLYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBPPNjBS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AYAUrLYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBPPNjBS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A22EC1380136;
	Fri, 30 May 2025 09:31:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 09:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611910;
	 x=1748698310; bh=EbcXKlVdregEL/3rijd+MaE1doTpchNEx7WE8cww6io=; b=
	AYAUrLYt20biRwtnd0ktFB3vYyn8KYuozmgazNgDTNuNiD0nFcc2Xnm4bAuTkCZN
	8j21oTLsRdfGo/VKCIIZiPdlKKpOpEP+sNV5WmndqJ9UrVbk6g6JXLi7t8SjmFDM
	smiID75aJXw3M/Sls0UVQP1rb3e2wtxdJD8IIRcYpZIIwjAH+UApX3JAIla1MiTl
	p5mDYuFp+SLoARIVS8DXc7ueF2P4P0tdEnX2mpoKPWEGnMqThSWoA4GoTLV+70SD
	M5hCuWTAw0En1CJKzfURsJ2Hss4yZhMU/b9K+IiiEp0rAX5315Dl+3CbkmD2irZA
	/+ezOilxhUsmOyAOnXlNww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611910; x=
	1748698310; bh=EbcXKlVdregEL/3rijd+MaE1doTpchNEx7WE8cww6io=; b=P
	BPPNjBSPtJw/ApZcxd6sXNuDZOGowCtmAUqcIXc6cnE5blQ6PpsNtujmvNbRy6TM
	j53GCFVA/bPbBEHTztKa4ozL0SYNlaYnNUzAJEZX26hQzSNeXLw7YFhbPDLszaOL
	vbaogd+o0UUXQzffaFm5QMLP8RbnhjyDxkFTJA0cvr0mRTa9jhP69itnWpIpM+at
	byQpt9JNHLB+eGcEWDtUSm0CCbTUJK37YGS9wQT0rS0lJ28b+HQjNRAf4QJDU1aY
	I6y1BQ3DnUNnWF9Zo5XSdBG1aiQnuf66IypRqe7uLirZ4Lnm3KnxKXyxH3jRBe5z
	SmpaodSK9dA3fxUwfRzWA==
X-ME-Sender: <xms:RrM5aNGoxwXFcfCpj4QjzzGJEbHDXLbj0_4PlMjQhWY_kU2Ik745kw>
    <xme:RrM5aCXDUP6FMXZ4PimVG1NMoZWz7S5lUoBmCNpEQLGfRLLR5udKBZj4xHf9BcXi8
    cUqh7vtllVZFWJ3kQ>
X-ME-Received: <xmr:RrM5aPKsMsvrKm4LYs_4wE6K3kEI8eu9UEoC_HHNcLim5WRnJmiJUPgThkY01ZPhY_zXRcIAf4o6OM8aKIO8kTTPzds3tdzJPGrxzjqoVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehrrghm
    shgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:RrM5aDF78JtFdYKHi5GJJpPDUXGq2trSUjgrAuU9q2UXJ0r4TnsdAw>
    <xmx:RrM5aDU-gr_Bf0Tu6HZQR6FMuCIV3oEWqGDaF3m9ia8jPvDUHiw9iQ>
    <xmx:RrM5aOO2Gl64dIc29NXPZBCnSF6kowT5VMVtCs-KW1DxzQl1PIFwmw>
    <xmx:RrM5aC1ikffU-6mPi_3ij-3RSU1xm0A_aiECPhDKnrbsaQ1gK0Lf_Q>
    <xmx:RrM5aGp8AFBMiHkAsM-Lqea-04Vg1c1W6KdINMa2UxZKhT61jcFQo8Hn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26c65d15 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:39 +0200
Subject: [PATCH v3 01/10] t: stop announcing prereqs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-1-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

We have a couple of cases where our tests end up announcing that a
certain prerequisite is or isn't fulfilled. While this is supposed to
help the developer it has the downside that it breaks the TAP format.

We could convert these cases to just have a "#" prefix, but it feels
rather unlikely that these are generally useful in the first place. We
already do announce why a specific test is being skipped, so we should
try to use this mechanism to the best extent possible.

Stop announcing these prereqs to fix the TAP format. Where possible,
convert the tests to rely on the prerequisites themselves to announce
why a test ran or didn't ran.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0050-filesystem.sh                  | 30 ++++++------------------------
 t/t3600-rm.sh                          |  5 -----
 t/t4000-diff-format.sh                 |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 16 +++++++---------
 t/t9903-bash-prompt.sh                 |  4 ----
 5 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 5c9dc90d0b0..ca8568067d3 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -10,53 +10,35 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
-if test_have_prereq CASE_INSENSITIVE_FS
-then
-	say "will test on a case insensitive filesystem"
-	test_case=test_expect_failure
-else
-	test_case=test_expect_success
-fi
-
 if test_have_prereq UTF8_NFD_TO_NFC
 then
-	say "will test on a unicode corrupting filesystem"
 	test_unicode=test_expect_failure
 else
 	test_unicode=test_expect_success
 fi
 
-test_have_prereq SYMLINKS ||
-	say "will test on a filesystem lacking symbolic links"
-
-if test_have_prereq CASE_INSENSITIVE_FS
-then
-test_expect_success "detection of case insensitive filesystem during repo init" '
+test_expect_success CASE_INSENSITIVE_FS "detection of case insensitive filesystem during repo init" '
 	test $(git config --bool core.ignorecase) = true
 '
-else
-test_expect_success "detection of case insensitive filesystem during repo init" '
+
+test_expect_success !CASE_INSENSITIVE_FS "detection of case insensitive filesystem during repo init" '
 	{
 		test_must_fail git config --bool core.ignorecase >/dev/null ||
 			test $(git config --bool core.ignorecase) = false
 	}
 '
-fi
 
-if test_have_prereq SYMLINKS
-then
-test_expect_success "detection of filesystem w/o symlink support during repo init" '
+test_expect_success SYMLINKS "detection of filesystem w/o symlink support during repo init" '
 	{
 		test_must_fail git config --bool core.symlinks ||
 		test "$(git config --bool core.symlinks)" = true
 	}
 '
-else
-test_expect_success "detection of filesystem w/o symlink support during repo init" '
+
+test_expect_success !SYMLINKS "detection of filesystem w/o symlink support during repo init" '
 	v=$(git config --bool core.symlinks) &&
 	test "$v" = false
 '
-fi
 
 test_expect_success "setup case tests" '
 	git config core.ignorecase true &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 98259e2adaa..1f16e6b5228 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -17,11 +17,6 @@ test_expect_success 'Initialize test directory' '
 	git commit -m "add normal files"
 '
 
-if test_have_prereq !FUNNYNAMES
-then
-	say 'Your filesystem does not allow tabs in filenames.'
-fi
-
 test_expect_success FUNNYNAMES 'add files with funny names' '
 	touch -- "tab	embedded" "newline${LF}embedded" &&
 	git add -- "tab	embedded" "newline${LF}embedded" &&
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index a51f881b1c9..32b14e3a714 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -36,7 +36,7 @@ test_expect_success 'git diff-files -p after editing work tree.' '
 # that's as far as it comes
 if [ "$(git config --get core.filemode)" = false ]
 then
-	say 'filemode disabled on the filesystem'
+	skip_all='filemode disabled on the filesystem'
 	test_done
 fi
 
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 7679780fb87..578d6c8b329 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -700,19 +700,17 @@ test_expect_success \
 # ----------------------------------------------------------------------
 # syntax highlighting
 
+test_lazy_prereq HIGHLIGHT '
+	highlight_version=$(highlight --version </dev/null 2>/dev/null) &&
+	test -n "$highlight_version"
+'
 
-highlight_version=$(highlight --version </dev/null 2>/dev/null)
-if [ $? -eq 127 ]; then
-	say "Skipping syntax highlighting tests: 'highlight' not found"
-elif test -z "$highlight_version"; then
-	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
-else
-	test_set_prereq HIGHLIGHT
+test_expect_success HIGHLIGHT '
 	cat >>gitweb_config.perl <<-\EOF
 	our $highlight_bin = "highlight";
-	$feature{'highlight'}{'override'} = 1;
+	$feature{"highlight"}{"override"} = 1;
 	EOF
-fi
+'
 
 test_expect_success HIGHLIGHT \
 	'syntax highlighting (no highlight, unknown syntax)' \
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654e..637a6f13a6d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -66,10 +66,6 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
 
-if test_have_prereq !FUNNYNAMES; then
-	say 'Your filesystem does not allow newlines in filenames.'
-fi
-
 test_expect_success FUNNYNAMES 'prompt - with newline in path' '
     repo_with_newline="repo
 with

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

