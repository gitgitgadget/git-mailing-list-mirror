Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DA2749C3
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354582; cv=none; b=S5G0cbenZtbi2vPSEcadi0ExcUAscMRyZqX5xmZ4nQ6J0V0c0BZ8fAEPEdU+SEjtUr1U5x0DyDwUX127WWRasFxgfZi+XcpxYeGKKPCGB0/w/mlDsinN4Aze6UJlY+tWMMz8LTFmsNz5Q2O8BBxPBfwtUeRzPRL0LtuK4ynej8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354582; c=relaxed/simple;
	bh=c2GbsGspFZR3lirGFU7w9n1/J79MWgVeFgL+cL+ko84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGrqnTLM+xzAZediUhdEsVFVoxHT7wcPegPHWTO6ZSiaHqZrLk9aygJqiHv6A6zYCTn7TrC+ao3Z3Rf0x9u98pKr8LzGXz94a2BbKrawYklNmjX1eZDZjYM43osiEuZphq39L8us4bkb6tdT0qrcbHT4ILW9i1XVGnVQFxmVuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MJgawUDf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i//YCTaa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJgawUDf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i//YCTaa"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8999E114013C;
	Tue, 27 May 2025 10:02:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354579;
	 x=1748440979; bh=3YbthJwIfpjZx1aJvCBfV2O4hAlTG/S1eKSRS/i3FrE=; b=
	MJgawUDf5nmPgZdbAUwOB7QthzTVJoBYtpXiDRJfjK7WbCuabEZ9YZpeAVc5ds/j
	ihaavk4udrdTodw/XwjWCUehaDOK8AVeci54ab6G4qnFSl+kOKeu58++K5YuSe5l
	UeuNVLeil96rchp4Mwz348No+Enn4d5wsyQvz6YU2nJlIxKO+vcVD0K1lw9pupqY
	yu7ETkAK3r7xErmVyFOwK1UgeEBXNQeINIiw9ndEHlP48ZLGlvdGnOOoKoMrUn8v
	km3WRxaCui0dAXnOSVOZJ9z+b8Hq/SeQ3aI4ofYSSWFDhAwU6D7C5d8wlPpDd6VN
	EshMBA4vHvdwM5t/61LPxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354579; x=
	1748440979; bh=3YbthJwIfpjZx1aJvCBfV2O4hAlTG/S1eKSRS/i3FrE=; b=i
	//YCTaafHsdKjTEBuk5cptHYwID60WcOcmw8vEQKNd0TYMNX5w20y061CdLh0wQM
	Mkd85qeBSjrFNqkOF51U87hjzbwpwRdRRBHUvSnBSQv3z0wypgt+i7tAtBGtRhu5
	B6u8LGzhprHFA2UTbEhy5Us1QuIZNm2rIiZBD22GFJxv4I1SdvLNvDBBrKu+P6Jz
	hUdozhMY+n868bGFuYT8J/is0EtdU+VBHq05YHJLz1fLPyVK1mengne6422GmHiq
	H9AD1c72WwB4DNABKJO2XZpEww/BTikpnDHbWVBh+tBGv94FrYG+TTGW+Fg8gOIx
	8PyEvskTtha5MXZb6UDLg==
X-ME-Sender: <xms:E8Y1aHAbNtYtB47C8tg5j166tPHAzgFOo2kBXSM-Jw7kWYD7VUPXWw>
    <xme:E8Y1aNhq5oR71RxS9XL8V2LmsU0lkcOB9U6EUxTAfPw9KxARK1ftlEjWDrxg8_xa7
    geiFiNwXjsH2AKCuA>
X-ME-Received: <xmr:E8Y1aCnmmWBpXSQE5KzZV2E1pBbZWeXr2LLfUsfusSWIKVxTdm7zLro2YdtF7t25szvUXxgdCiizyoN8nnfeEgOPdNLCZO0WuyczraWIc6S7UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:E8Y1aJxB_2Z_niW4y4ZnzfXdW_w7OCsA5tajkxcVmfEWfYMTtnYTDA>
    <xmx:E8Y1aMTbtC9R40zIXzZOOIapcfMHk5Wo2oHzSM9JJsXCYhv42usz5Q>
    <xmx:E8Y1aMZGCt9yC58F7IVzszO4YvRJJTRb4wLPExs6mIpNnYyq8MwAaQ>
    <xmx:E8Y1aNSXG5hp2K-I8cyAyFAT_VG_61ZkosI7fE9mpwu7O01AI1YUGA>
    <xmx:E8Y1aNJbdmSr8PLRq54SLce4p694_Cu8RQ9QhmWbL2tA0DLI3G2224yA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:02:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca9c1489 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:50 +0200
Subject: [PATCH v2 2/6] t/test-lib: don't print shell traces to stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-2-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

We have several flags like "--verbose", "--verbose-only" or "-x" that
cause us to generate shell traces. The generated tracing output is split
up in these cases so that the test's stdout is printed to file
descriptor 3 whereas its stderr is printed to file descriptor 4.
Depending on which options have been given, we then end up either:

  - Redirecting both file descriptors to a file.

  - Redirecting them to stdout and stderr, respectively.

  - Closing them in case we're running in none-verbose mode.

The second case causes problems though when passing output to a TAP
parser. We print the test's stdout to the console's stdout, and that
results in broken TAP output.

Fix the issue by instead redirecting the test's stdout to the shell's
stderr. This makes it impossible to discern stdout from stderr, but
going by my own experience I never came across a usecase where I would
have needed this distinction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0000-basic.sh | 35 +++++++++++++++++++----------------
 t/test-lib.sh    |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 35c5c2b4f9b..16b785f3b91 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -219,41 +219,44 @@ test_expect_success 'subtest: --verbose option' '
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	mv t1234-verbose/out t1234-verbose/out+ &&
-	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
-	> expecting success of 1234.1 '\''passing test'\'': true
+	mv t1234-verbose/err t1234-verbose/err+ &&
+	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
+	check_sub_test_lib_test_err t1234-verbose \
+		<<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
+	> ok 2 - test with output
+	> not ok 3 - failing test
+	> #	false
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF_OUT
+	> expecting success of 1234.1 '\''passing test'\'': true
 	> Z
 	> expecting success of 1234.2 '\''test with output'\'': echo foo
 	> foo
-	> ok 2 - test with output
 	> Z
 	> expecting success of 1234.3 '\''failing test'\'': false
-	> not ok 3 - failing test
-	> #	false
 	> Z
-	> # failed 1 among 3 test(s)
-	> 1..3
-	EOF
+	EOF_ERR
 '
 
 test_expect_success 'subtest: --verbose-only option' '
 	run_sub_test_lib_test_err \
 		t1234-verbose \
 		--verbose-only=2 &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
+	check_sub_test_lib_test_err t1234-verbose <<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
-	> Z
-	> expecting success of 1234.2 '\''test with output'\'': echo foo
-	> foo
 	> ok 2 - test with output
-	> Z
 	> not ok 3 - failing test
 	> #	false
 	> # failed 1 among 3 test(s)
 	> 1..3
-	EOF
+	EOF_OUT
+	> Z
+	> expecting success of 1234.2 '\''test with output'\'': echo foo
+	> foo
+	> Z
+	EOF_ERR
 '
 
 test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index af722d383d9..6ce8570226c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -707,7 +707,7 @@ then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
 elif test "$verbose" = "t"
 then
-	exec 4>&2 3>&1
+	exec 4>&2 3>&2
 else
 	exec 4>/dev/null 3>/dev/null
 fi
@@ -949,7 +949,7 @@ maybe_setup_verbose () {
 	test -z "$verbose_only" && return
 	if match_pattern_list $test_count "$verbose_only"
 	then
-		exec 4>&2 3>&1
+		exec 4>&2 3>&2
 		# Emit a delimiting blank line when going from
 		# non-verbose to verbose.  Within verbose mode the
 		# delimiter is printed by test_expect_*.  The choice

-- 
2.49.0.1266.g31b7d2e469.dirty

