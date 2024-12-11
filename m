Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569B1EE7BB
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914397; cv=none; b=dn0eqQoGuZtZXWfP/MVUxdxrDLoQDB6a4ZOQEl4zvlO6lG9La6pIVIUIDdRByPXwGR9Zxzc8uKM/nWcvU6SVuuw0Na68n8v05PUO+4KQlSDD1ad7rhW2FznbfMlePhk3YbW4tthVeAHgnV4SQ9/55Njwbam3W6eni7I/FK1Fq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914397; c=relaxed/simple;
	bh=1j4n035rafMjR3M7/XHF1VlZ9ALyOWk+hLgNLWT6EsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejmwEX7P1v+le7fQhgx3Ebk1PuxlZyGZpOKYFSYAgG57M4eLGNMJzHutr84LgCK/BtS0SnxEgHYPOgvAHBM66NoXmVNDc0E1T2Tegj64FD/rvKIXkSzJ3HC8zan8d3yg7IxB8SkmD7HZH4K3qpHNXzA/Wv8AGWbkfZJ2vi7djDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OfS7XKPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wsNSSk7a; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OfS7XKPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wsNSSk7a"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 393FF114026C
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 05:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914393;
	 x=1734000793; bh=eKNOXYKuAqQpO6whnuFFWUxWuuqOPApvwbgXN4jeY7M=; b=
	OfS7XKPlR86tiipXcKuupt8/H/Vg+o24tA9J4NBP6UJ6IXes7zX+L4K3ruL6DV49
	rOnJcHkwJVZEaSqA9/vMUi3aC2p52HR1IRiB9AQqhQV0a16435h+P+/65L/EqBX7
	WSkPEo7HCdk2e2DDy145Ix8xIvIz1+imRRgVYlPYh0/DljPYUrELXMxWvAyiACJX
	0e+NjEY+bZj5bWqaa6wVqtcnZXjJqdOLxtQrjrN8mGTjMYo/R/7ciEDMw7B1Q7Yv
	oyqCJSW+xbtM0Hif0qoamKVjVULS21gPw+of5ZxtFf4h4H1X2Zlql7fqnnyPSC3g
	Ge1bexA3OilJjwEPLxiUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914393; x=
	1734000793; bh=eKNOXYKuAqQpO6whnuFFWUxWuuqOPApvwbgXN4jeY7M=; b=w
	sNSSk7at/rN3x/cH4nwY59XsQ0g0nTNe6mW6YplR/Drjz5SD1HDrWpcIr1INu2pE
	uTu8C8HTKraN2W/9WntClyth96YKCEYNKscSXkWXzzoOtmytHVFkGWA3qrUAcT6+
	SGEEKWM81DXmj3dH5kgUlA8qpmRqff9lnXJq0attX+Rgk+tAtKB0tN6PwLbN5swr
	MW2bHgKD0beunF20IlJ2FRMopCI0y6++E4Dh1mDcpaSmJcyaCo2uj56z0oc/OyTO
	OE7Y8KnfamWSrxv9tYp9051vnOFn0iBOyYNzd+9s36+eRlOpO7Dd811s6AWfsYpt
	cbEBByf4QpnvSqYEPdN1w==
X-ME-Sender: <xms:GG9ZZ1snLFjagbxD5DQ1l1qlp6gYC02SMUEXrDrTkhdIXpM_f2FnGw>
    <xme:GG9ZZ-efArAT0gVU09GXHIcBHxXmAUYYsEFx4VAJwbKxbk6scr7sCS07aNTa2V74Y
    pqqWCoYMMV_NkY-VA>
X-ME-Received: <xmr:GG9ZZ4z3G__J1re-5nGpcPCXqOBaa9Vvu2BzHPzhjqTDbnd25VyfKa8TShB3u_fVCy-4XovMSq6qsoj9jrviurf_jMgBuWgSZv2Ar5KMn2u6Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GG9ZZ8OaQ6FCnE1UuEzEMKlaZaxetwJKtsV8CwWImkE_UavKq4N4_w>
    <xmx:GG9ZZ1_b22jx4B6n8AMlticxmaLSQmOJGSpcgGetqJc6HLiPsfLJ1A>
    <xmx:GG9ZZ8VdLkvrpJ5m7MYIvEdQ8qD5WCPZSO-xdKepojugcxuzU45TMQ>
    <xmx:GG9ZZ2d8NmW0XHEytMbTq_FEPdn5152eAl7sl193BlsaMkHOZmOHUA>
    <xmx:GW9ZZ3kbXF22x1d3c3tfuc541yibkwTopjVejjvzv053hagyL_XDZgOW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e6b5ce9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:34 +0100
Subject: [PATCH 3/8] t/unit-tests: rename clar-based unit tests to have a
 common prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-3-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

All of the code files for unit tests using the self-grown unit testing
framework have have a "t-" prefix to their name. This makes it easy to
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
2.47.1.447.ga7e8429e30.dirty

