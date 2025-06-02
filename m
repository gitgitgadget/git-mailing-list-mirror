Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2C1991CB
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846694; cv=none; b=TqkHaKdfHC4S6UWxqkIK3Vqks3E64IJr789JS2W8H36fn8gdAiTc4ZuXYXugby/pEOx5XVvtn2b1VH0RXcO4piyTL9S4rP3MFNWMxbG7qganMWcA9PAuRCFABKikluYzsrkwvhRaJ/D71rthroZyJ46PYKAMquYxBhBG6DmLqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846694; c=relaxed/simple;
	bh=qlhDurhU1skCxgOOv+aiecK0Gx8NKBrdw/oFW80XL44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkAWfgZ4Tpt3VJysjC3OXL1ReyQCeaw7WH/dzexyyrrsmCUmqHn4XBMBFN3dHRKN88eNLHgL+e6RDu5PtyW3Tte8v0PNwK0Hm7rY+BFI0e83G5SiWGcqt0ATM7vtxbGRJ0szx0LJx1owIG0WhADp1YwvwPmxqDu3KtfPk7TLYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zz6GGLC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPZaIuh6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zz6GGLC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPZaIuh6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 208091140142;
	Mon,  2 Jun 2025 02:44:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 02 Jun 2025 02:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846690;
	 x=1748933090; bh=Gdx3xYiV9aVysmbbAduxL9YKdPqDpTFf5EumWvsL2ww=; b=
	Zz6GGLC0Z1ZHMVO1L79yKDWsBqr2YVNLXx13pqc7PB+W9niJOzopz6K+hSonuLYV
	KeBPe2wKiIdGWic1PSqJ6PfMxzdEimu+pbhRJibwOh+3EsFLgpKa0JoH37jkaP1L
	jGIBCOKZ4zqorMJUUvGC6EHq8TuYNcf3RMdoYqYAx0HTVCHqol9NUWGzEWJednOg
	Rqdca/3vg70fsOrzkWU3kIRcBjc5H+T6z4XDsLhttERG1Zs12+B0jMXpKP5ps9mC
	ZGn7F/fpeqB1OKUxfuXPkolr0ovvl7i9vknZZK3fz0QYAFwkusbHohbnaIhGWeCE
	1ajtetcwoV3Eqb50/1j82Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846690; x=
	1748933090; bh=Gdx3xYiV9aVysmbbAduxL9YKdPqDpTFf5EumWvsL2ww=; b=P
	PZaIuh6PqQwRWE+CSquqmXK91tykEdbUlDILw3n54wxfcn3oZmmFxQTi51rrlxGC
	J0CC9cOvPrz09FUu7bOIeQsUmd9JfmQikIP8af+XkzO4HBIndZ7zSoWsEihQFO2T
	7z0kcIElFwTKaz26PShpELaG3D+xc+dWnxiAZRGPQ4R1CtP+gYEVmyp1NaDjpg8Z
	hxGkYd6BkK2NqIohKd/mxUluUKvU+zuikeVy9dz9osOFqLN5883D63EX0HGh/JAe
	6DMIqwi3Gek1J8l8ZDNW4Az1VfLTwxgisbb5qsSXOdp+hAEpLUxATZZ2rBPr7Iy0
	ItSGGcY+Or/exr0eXAnmg==
X-ME-Sender: <xms:Ykg9aNUoeAA9jXV7OcNedVC3oiAmv410pJwDGzhjxgK1T6yOeoRKUw>
    <xme:Ykg9aNncKsrk_hCIminj8Jg7oY29eA1IBf3qkibKq3I--yYaqA82fyQ4uHPUx2-7r
    rtgWcHTmRmzfhWV7w>
X-ME-Received: <xmr:Ykg9aJZWF1ScB9Ygmiu80YSjddE3kwZFslFnyRy3L9PP2P__GvDSRGcQU7I-zIiN25faCy7LSjLAhWW_wxDoS8Ip51jcUiXqPQmTAknvyimbQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrgh
X-ME-Proxy: <xmx:Ykg9aAUO5vBY-qku25xI25ylPlNRLQbI-ZyHX0azw2zCuAW_NoAgLg>
    <xmx:Ykg9aHk6bMGIIxtP_cFj8rJ9cidC_2ejjyiyEpdUbfk4GyGYETdcWQ>
    <xmx:Ykg9aNc3EO5eanOWNek4KzGi2_teiiy9CpCtgClmLyOL3suW4v1wnA>
    <xmx:Ykg9aBGC5E2kTcPLky5ziE6r7KvIUWDQGKe5kLXgvLinblAylPXxfw>
    <xmx:Ykg9aG57muuoyaDNvUFIndjNN9K7nRANd7o1Zb9g62jw-qWasZxy7OP2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc1a0882 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:41 +0200
Subject: [PATCH v4 01/10] t: stop announcing prereqs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-1-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
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
2.50.0.rc0.629.g846fc57c9e.dirty

