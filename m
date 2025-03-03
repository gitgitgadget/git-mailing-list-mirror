Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4AD23537A
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034697; cv=none; b=AScjOVoMrSbonmqivjiId7pfW99nWZwAAR2b+9ikFQUk8mOci5WYYuipWLSuoczJSkM2/6LFGEUaOmcrP92UaqoIL0OMfklKinfyWhmoDc3XsbfaYXNaDX1YqQgLAQ3KBvzZvkQ+f63i6BjHct0Twt1UroRTnmI4xFlbnID0p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034697; c=relaxed/simple;
	bh=Ipp6UTknnyBpslf0ZHPMdFsMTdxuRukMWuQPDTNLejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsy0hqD6R8rnEdiQz8OntL+TaFUevY+qNuqq31hG0Kz5h/F/KmCgBtmfiUEWW7Byg2LG7hKbTn04qK5sqJpyr5I61S2OD85C/FTSGM9rx6EmOlWRFvXnUOYr+SVRRlSa5Lo+Zgamu+mHurAYVE7yr785ZxBAThtdoM4Fj8EqmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l35ff28g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnlXNO/A; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l35ff28g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnlXNO/A"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DD731382C53;
	Mon,  3 Mar 2025 15:44:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034694; x=
	1741121094; bh=1uSac8a1irqbE6bWxWPxcJRVOaABW0Sn98QshbOPoLE=; b=l
	35ff28gwMnu0nTtXYk8zqUZAu4J1dp5y/f2FmOjgC+ZEqUt1dieiG4QZgoeoGkhR
	OsVzSXKHLTJmzFEdWThQdWv75KmTasds0Os1EzqwGuE8j4DAUHg+L00OuFf3yLOh
	/o6xLMBR36L1mjMusbmNFq6oC0CbG1S+fZCKZDcjZUWWfea+hYdm64gWe5udt/TW
	Awiovrl/s8Tkc3C40FK91ugcztwIXbLfQGWG7wsqoUEGIMrR7ouATd8iJhVtYPeE
	uBGW2W7nSqu6jxraSoSDkiOOrM7sLhohP6+B2hLl/VEmtUEOZJsrnK7poYD/BosE
	IXGHPwj5bxHymR9Qn4xcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034694; x=1741121094; bh=1
	uSac8a1irqbE6bWxWPxcJRVOaABW0Sn98QshbOPoLE=; b=fnlXNO/AaYfVMIThR
	AMtBV68ccBBJOGiYUCknHfYLxjzQDpe66iS39xDBsMIZFdmUKCrWtpPMz32mMczo
	5OVVgoocQGXPYYjwPlCXmyjbnXm3fWunrlPFJiSOBU9RL5SfpzXqzkEev5TtUnWH
	J6n4wiQ/QZUoAZhac+8c3qDToKFqjEFTqOhA5tNq2xOpSnoKSRmpFO7D/gf2YCT9
	8Fbhio+6H3lHToOVd44W8vuSQYH86MrACyvIq7p/7jcjBfhXjMAixdWxGWf3KI7x
	W3B2jo3ib1TKbwMfQqCpE4M072QiWIXR9zmhV/qrah0D7ZVxJl9zL32FnLqbwkF3
	EX/JQ==
X-ME-Sender: <xms:xhTGZwyUSnsrIgM1313HOTS6vVCvFEe8PutI8wKAt6ZWPTz9NODgIQ>
    <xme:xhTGZ0TtyartIZbnuSBcXAP-2IUnJjxBfMNFRly6lekV0hOvBBkJefiXXa6ST0BCD
    -Ol6HXX1nBOLyoQ_w>
X-ME-Received: <xmr:xhTGZyV2Nc3Sf3l9SysNkk4TafK6Mh5BrlAGIzDK4PBrUSXbgdYsm05JDIT5p6aUi_CEDgAgJW7cqTK0qN8tb7yZ2i8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:xhTGZ-j356zWmUmAk4-AGKe6jJ8_OHMrR3KVRihjJpMiBTkbX830Jw>
    <xmx:xhTGZyDCov0nLmMpxTQftEOv6YbNM-bonVhZMya9APwJs5PKNmytyw>
    <xmx:xhTGZ_IDHG-11GY8zdrhxMQAgXUArbo7KbxotGofr-AvC4EyLgzAAw>
    <xmx:xhTGZ5CrLmyutNRGr4ms4QA7I4EPTFrCyyBAOMh5r9i7NJg8_3UMTQ>
    <xmx:xhTGZ9M1sn44F_fZWGzc4k8Ke4qz9WOXEXDT4rtO3c7A_ppp-JTnu0ML>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:53 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 01/34] t0450: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:43:59 -0500
Message-ID: <20250303204443.360595-2-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 1f010d6bdf (doc: use .adoc extension for AsciiDoc files,
2025-01-20), we no longer matched any files in this test.  The result is
that we did not test for mismatches in the documentation and --help
output.

Adjust the test to look at the renamed *.adoc files.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/t0450-txt-doc-vs-help.sh                    | 50 +++++++++----------
 ...t-help-mismatches => adoc-help-mismatches} |  0
 2 files changed, 25 insertions(+), 25 deletions(-)
 rename t/t0450/{txt-help-mismatches => adoc-help-mismatches} (100%)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 853101b86e..2f7504ae7e 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='assert (unbuilt) Documentation/*.txt and -h output
+test_description='assert (unbuilt) Documentation/*.adoc and -h output
 
 Run this with --debug to see a summary of where we still fail to make
 the two versions consistent with one another.'
@@ -11,11 +11,11 @@ test_expect_success 'setup: list of builtins' '
 	git --list-cmds=builtins >builtins
 '
 
-test_expect_success 'list of txt and help mismatches is sorted' '
-	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
-	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+test_expect_success 'list of adoc and help mismatches is sorted' '
+	sort -u "$TEST_DIRECTORY"/t0450/adoc-help-mismatches >expect &&
+	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/adoc-help-mismatches
 	then
-		BUG "please keep the list of txt and help mismatches sorted"
+		BUG "please keep the list of adoc and help mismatches sorted"
 	fi
 '
 
@@ -40,20 +40,20 @@ help_to_synopsis () {
 	echo "$out"
 }
 
-builtin_to_txt () {
-       echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
+builtin_to_adoc () {
+       echo "$GIT_BUILD_DIR/Documentation/git-$1.adoc"
 }
 
-txt_to_synopsis () {
+adoc_to_synopsis () {
 	builtin="$1" &&
 	out_dir="out/$builtin" &&
-	out="$out_dir/txt.synopsis" &&
+	out="$out_dir/adoc.synopsis" &&
 	if test -f "$out"
 	then
 		echo "$out" &&
 		return 0
 	fi &&
-	b2t="$(builtin_to_txt "$builtin")" &&
+	b2t="$(builtin_to_adoc "$builtin")" &&
 	sed -n \
 		-E '/^\[(verse|synopsis)\]$/,/^$/ {
 			/^$/d;
@@ -109,29 +109,29 @@ do
 		fi
 	'
 
-	txt="$(builtin_to_txt "$builtin")" &&
-	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
+	adoc="$(builtin_to_adoc "$builtin")" &&
+	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-	if test -f "$txt"
+	if test -f "$adoc"
 	then
 		test_set_prereq "$preq"
 	fi &&
 
-	# *.txt output assertions
-	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
-		check_dashed_labels "$(txt_to_synopsis "$builtin")"
+	# *.adoc output assertions
+	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
+		check_dashed_labels "$(adoc_to_synopsis "$builtin")"
 	'
 
-	# *.txt output consistency assertions
+	# *.adoc output consistency assertions
 	result=
-	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-help-mismatches
 	then
 		result=failure
 	else
 		result=success
 	fi &&
 	test_expect_$result "$preq" "$builtin -h output and SYNOPSIS agree" '
-		t2s="$(txt_to_synopsis "$builtin")" &&
+		t2s="$(adoc_to_synopsis "$builtin")" &&
 		if test "$builtin" = "merge-tree"
 		then
 			test_when_finished "rm -f t2s.new" &&
@@ -140,17 +140,17 @@ do
 		fi &&
 		h2s="$(help_to_synopsis "$builtin")" &&
 
-		# The *.txt and -h use different spacing for the
+		# The *.adoc and -h use different spacing for the
 		# alignment of continued usage output, normalize it.
-		align_after_nl "$builtin" <"$t2s" >txt &&
+		align_after_nl "$builtin" <"$t2s" >adoc &&
 		align_after_nl "$builtin" <"$h2s" >help &&
-		test_cmp txt help
+		test_cmp adoc help
 	'
 
-	if test_have_prereq "$preq" && test -e txt && test -e help
+	if test_have_prereq "$preq" && test -e adoc && test -e help
 	then
 		test_debug '
-			if test_cmp txt help >cmp 2>/dev/null
+			if test_cmp adoc help >cmp 2>/dev/null
 			then
 				echo "=== DONE: $builtin ==="
 			else
@@ -161,7 +161,7 @@ do
 
 		# Not in test_expect_success in case --run is being
 		# used with --debug
-		rm -f txt help tmp 2>/dev/null
+		rm -f adoc help tmp 2>/dev/null
 	fi
 done <builtins
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/adoc-help-mismatches
similarity index 100%
rename from t/t0450/txt-help-mismatches
rename to t/t0450/adoc-help-mismatches
-- 
2.49.0.rc0

