Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B61C1AA9
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086500; cv=none; b=VCbdOt3BMjbAxUNCjxaLCH6/UrE97gnjVj8OjWk7rjRp1Vige9qMCddexHXxEfMLwTiJATjrIeOm6LBZ5AMre55jqs7p63UIIlrlneAWwDfpDX6COQa8nt9hsSQJD9KEHimE9Q9Alh3htQLzRLNFyYNXGz/NIx6GG9UyvopsHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086500; c=relaxed/simple;
	bh=JfQN+apR2upH93Pj7iBvgAxUVYpRBmqNod0Ij2qbapk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nULwA504Vkp/7UGOFHBVTfzVZpPiPcRINz/BfLHW/Xid1EEUCAEhajrzJuK5H1z7vdHa8CuY6TLB6pz+DsqkDnlQPJNQUKjd6pi67OES+K2+TWs0MXVv63URoM5B8MMhQqaqcl7X6ma9T4w4gK4KyMZXPD9ikNbrpxslk1hlZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uuxb6rLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NM1J8cEJ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uuxb6rLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NM1J8cEJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DB92311401E7;
	Fri, 13 Dec 2024 05:41:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 05:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086497;
	 x=1734172897; bh=+kVRtqQRDJ0/6fFfpQp8mD3oEkcGjWe2OMWDwqGCd84=; b=
	Uuxb6rLnzLtzTssqtKq/bQ8xXvENXFsNFiLuP1aszKZrpuOnUqHhauJEwUKq+j/s
	A6ofTnFGkzXOXmVIZEpi/VI2/ZjDfIP+z5IOqzAUTi+4J7WB3U8iJb9hJjzANhz8
	PJhB5DEkerIFFSAx/XCPATME2slpj8JNfmNeOGqxRVJE3prLOsUTZSdYTzLBiOj5
	hVWDCjEKu+sieTQ4DvoF9+VUDrAF7kD98IpueetOo0tsKTB1E4Ntth+NPP70vvyM
	QWF+10c8jYd0lPiLAiLo7RF8/E8RR6NvYVr9myi89QyMmzlhoGPutDjACHJc84YY
	B8uySG9hjJjmq2M67Y6okw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086497; x=
	1734172897; bh=+kVRtqQRDJ0/6fFfpQp8mD3oEkcGjWe2OMWDwqGCd84=; b=N
	M1J8cEJ+LwE0jlIJd2KaIUq6lbvBcAD/3+32pbiFwthkl6p5CnOi9dQ5qykDv0GP
	lobUGnzbce+M8vbx5ISMho1zJP6k+FFMkHgWed/QZFg3omhUvWB4xSbtSlTUuIXe
	+i6e9wHELtQIQwm/6iffLCVxGrZXwzWqtnl4grsCFo0elW6LEc1JjZaJ0heC0+7A
	Wzqk5m0JiuFDwK2y4tgzsQvKFej217FSiTED802gEwFDqpMYhdNFmSwi6FF4mgbW
	5YFUrqM2vOJaklNxkqvAYbARnPVoZ2xiPhy/L5oPKuagBwkEXw+BAO5fcgdNY8Xm
	WuNS7rJb9XwRgtaUBlUVA==
X-ME-Sender: <xms:YQ9cZ6c1JYmzRMVA7-It2XeMeHOccULD4QWe348AjyUkN02Bg6Bqsg>
    <xme:YQ9cZ0P-9WIwH65aPppQuSRyfqLeuf4GneYJqhITWe98tYIYJj7ef8YJ1zaz0DIJT
    taqJxuMrKWCAKAUDw>
X-ME-Received: <xmr:YQ9cZ7jMUZw4iEJ3CYOrH-84x7K9YSSVMfEL3kFDOogGSvpT24xspsTvOE5CqzLEJXW21DqBmpPZcXAc-ElRT_2n__DhVl7wWQ1KhS6pGtuhYjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YQ9cZ3_mRJvzLNPAwWh74_pH2zoZsTpVIQOJEo6SawiLfhquGeLrag>
    <xmx:YQ9cZ2sCxN5psVa3ybf7aXoLLcLbuCeEDA-HfQ9yVizgm5o2NwCECg>
    <xmx:YQ9cZ-HFK3kyzIa8j71gpr181G8sTj1dShw_AT1g9kpDNPhqyRRoHQ>
    <xmx:YQ9cZ1P4dOehUW1olRds5bLKptKAxFBb2bzYUHNULHUBYaH_9YvQfw>
    <xmx:YQ9cZ6KmuAzjpKIEaMaqrQeYfE-EKowarYzuMpqj6RWSetrAnDh9AKSi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a17deec2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:18 +0100
Subject: [PATCH v2 3/8] t/unit-tests: rename clar-based unit tests to have
 a common prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-3-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

All of the code files for unit tests using the self-grown unit testing
framework have a "t-" prefix to their name. This makes it easy to
identify them and use globbing in our Makefile and in other places. On
the other hand though, our clar-based unit tests have no prefix at all
and thus cannot easily be discerned from other files in the unit test
directory.

Introduce a new "u-" prefix for clar-based unit tests. This prefix will
be used in a subsequent commit to easily identify such tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                              | 4 ++--
 t/meson.build                         | 4 ++--
 t/unit-tests/generate-clar-decls.sh   | 5 ++++-
 t/unit-tests/{ctype.c => u-ctype.c}   | 0
 t/unit-tests/{strvec.c => u-strvec.c} | 0
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 2506f3b7e3377ab1a376338c86a727b2ae92a6e9..6eafaf174aaa380ad8e6a86f75d003eb6c058fb3 100644
--- a/Makefile
+++ b/Makefile
@@ -1344,8 +1344,8 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
-CLAR_TEST_SUITES += ctype
-CLAR_TEST_SUITES += strvec
+CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/t/meson.build b/t/meson.build
index 13fe854ba0a18f9b83dbc48651f581198042ffd3..9e676e69363ed6311426500d98fe281e30d26bcb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,6 +1,6 @@
 clar_test_suites = [
-  'unit-tests/ctype.c',
-  'unit-tests/strvec.c',
+  'unit-tests/u-ctype.c',
+  'unit-tests/u-strvec.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 688e0885f4f28182c3afe19c067b6d59dcacccfc..3b315c64b3711bfccc5941852a0782e02cee82f0 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -11,6 +11,9 @@ shift
 
 for suite in "$@"
 do
-	sed -ne "s/^\(void test_$(basename "${suite%.c}")__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
+	suite_name=$(basename "$suite")
+	suite_name=${suite_name%.c}
+	suite_name=${suite_name#u-}
+	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"
diff --git a/t/unit-tests/ctype.c b/t/unit-tests/u-ctype.c
similarity index 100%
rename from t/unit-tests/ctype.c
rename to t/unit-tests/u-ctype.c
diff --git a/t/unit-tests/strvec.c b/t/unit-tests/u-strvec.c
similarity index 100%
rename from t/unit-tests/strvec.c
rename to t/unit-tests/u-strvec.c

-- 
2.47.1.668.gf74b3f243a.dirty

