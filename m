Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490782EACFB
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904867; cv=none; b=CDrh50SNk56yLFMe0p/kqpuwSn1xGX5dcK1n1kBpSzx2x4X1iRvMaAA1GpBaOqK6+aHmpALZtFy7DG10hn6bOzEgDaDsxAZ23IibEJHUxxbuCHZbflk0xFL99E0qOICY0WcMESfVWY69k6sVkY+GF/xMhPVffA49TuzCpWqA6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904867; c=relaxed/simple;
	bh=OHrav56wnnpr2WmGA40My6eS/QFUFV4UXJSXzYxCFYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwwyBHwwGwX2I/iijpNlhNkWhl9f1I5d6WPd2TyUGlTJWTk/DHC+XlGGAWhl62Ye+1Tx3TbYfkv8cetsL0U6MuohWPK26JuZQURR+rE6bXX4CJ13JQat38DnjVPmNJVyN2LMKsF0c+z1m0x+E7DZnbAdiL2ccbORipVB8azy5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zu62Utmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEyXrU3p; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zu62Utmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEyXrU3p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 582401D006A4;
	Wed,  8 Oct 2025 02:27:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 02:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904865;
	 x=1759991265; bh=sDFyuOKuxRlo6LwyuIgr9w0jRfb/AzRoQMLQa1PYSeE=; b=
	Zu62Utmz3dhhp/zIET1qp3RAC4hJt3uHJiBL31DuwcGdu58QV0anhgqHxEd/gEti
	Hzx+wXmZ2diaD2wt6UhZ/6aIpBHmc4f/GjVYlhrjwa3czt/kibjk6j2qbMEzntlh
	1F9cmooPaRpxOtYvjGZZq+kVQFXfqscN105OOTWfA6lXDC696e8uCV51sKyTlKA/
	/7O7xpWXS+J1MVgcGUbKG6Cam+/01LdJcADHdvdx+UGOU1RLsuXgXRyAwyjOibyt
	ak4nmLqjTaskyjZ8jYjbI+44dbYs061gLUiJEljz0t5FvcuQpHLQWWav18lHacm9
	Z5Rs+si/NwX6yUseDroVbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904865; x=
	1759991265; bh=sDFyuOKuxRlo6LwyuIgr9w0jRfb/AzRoQMLQa1PYSeE=; b=E
	EyXrU3pM6Ig7HNwUzMHJftBN/OWxLxIZLbB2UXTMP3l4JxEtl66pYlUtus/0i0qG
	bNJ47/t9L+m8oruvmhsDeK2p/cA3ve5hgRpporx1CiitGaBSuc8DoYGaBHlT/pdk
	kEJej+kj7q0FSVtoe1QgDuRNmbdodLmdR2dkX0eWoIjkmcz2e2VzsacrEiL+j0v3
	5/ikc/Cm8wfXvri1QJ/jXBzMza1ZuZqx5dFfmfkZ6r2EOm0KVb+IKlK2m0/7WLLI
	Cx9DlbR7FfYdiKA0sXjiJ+vGMmpBSoiilgZkBhUrTa9flWQoebRP32AS6DM5E5Mz
	5mTD67QIOA99O7ATzd0lQ==
X-ME-Sender: <xms:YQTmaNU6DET9MgYiKwBeQOuT5b3dv-wVoA5jFZFMz1SBDNiOTcf5ig>
    <xme:YQTmaMpl1XbxYHjimgASBC7ljPrH9EUIEpVPZ9MQU9iTlh_27YbVLS2Y4w8OIrkjr
    Deror5e3Qw34DFmsBJWqYmlVgrefoK949hVnBuhmqBacCRtlVuRWg>
X-ME-Received: <xmr:YQTmaPmQFOhuXNiPx9aszFbolAMPk8Ji2ZtmX3YA44Ky0ol4qb4UI2PUGDMFrXA7wXmumbrkbXd7yxpWJC6yZfnEl0jBa4Cv0XskR-gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegvrhhitghsuhhnshhhihhnvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:YQTmaM2NdlM-h3aiO0_ZT_W8KKLOduHUXtzlsVodD7twHRtcrDSKxw>
    <xmx:YQTmaMQcG7T8eRgBW4hgzMQoPsl2GhRJJjSaSIVU59gks4VelqYtvA>
    <xmx:YQTmaFxVy2hGApcsSvswoquFpzy-ff0v_vx-lk50pq9zqSc0QMjuXA>
    <xmx:YQTmaMBQ10iN7z9gv6eEHX9lX-GwFWQqwjYjR9c4PnFkC3nl15_7LA>
    <xmx:YQTmaDqTTyNkN--K2M3ky2lLnlG0IXC6-_OvjWto_pyKshXLiEu2xzRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c75e68e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:17 +0200
Subject: [PATCH v2 6/6] rust: support for Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-6-d556ee83c381@pks.im>
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The initial patch series that introduced Rust into the core of Git only
cared about macOS and Linux. This specifically leaves out Windows, which
indeed fails to build right now due to two issues:

  - The Rust runtime requires `GetUserProfileDirectoryW()`, but we don't
    link against "userenv.dll".

  - The path of the Rust library built on Windows is different than on
    most other systems systems.

Fix both of these issues to support Windows.

Note that this commit fixes the Meson-based job in GitHub's CI. Meson
auto-detects the availability of Rust, and as the Windows runner has
Rust installed by default it already enabled Rust support there. But due
to the above issues that job fails consistently.

Install Rust on GitLab CI, as well, to improve test coverage there.

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Based-on-patch-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml     |  2 +-
 Makefile           | 14 ++++++++++++--
 meson.build        |  4 ++++
 src/cargo-meson.sh | 11 +++++++++--
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a47d839e39..b419a84e2c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,7 @@ test:mingw64:
     - saas-windows-medium-amd64
   before_script:
     - *windows_before_script
-    - choco install -y git meson ninja
+    - choco install -y git meson ninja rust-ms
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv
 
diff --git a/Makefile b/Makefile
index 7ea149598d..366fd173e7 100644
--- a/Makefile
+++ b/Makefile
@@ -929,10 +929,17 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+
 ifdef DEBUG
-RUST_LIB = target/debug/libgitcore.a
+RUST_TARGET_DIR = target/debug
 else
-RUST_LIB = target/release/libgitcore.a
+RUST_TARGET_DIR = target/release
+endif
+
+ifeq ($(uname_S),Windows)
+RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
+else
+RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
@@ -1538,6 +1545,9 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 ifdef WITH_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
+ifeq ($(uname_S),Windows)
+EXTLIBS += -luserenv
+endif
 endif
 
 ifdef SANITIZE
diff --git a/meson.build b/meson.build
index ec55d6a5fd..a9c865b2af 100644
--- a/meson.build
+++ b/meson.build
@@ -1707,6 +1707,10 @@ rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
+
+  if host_machine.system() == 'windows'
+    libgit_dependencies += compiler.find_library('userenv')
+  endif
 else
   libgit_sources += [
     'varint.c',
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 99400986d9..3998db0435 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -26,7 +26,14 @@ then
 	exit $RET
 fi
 
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
+	*-windows-*)
+		LIBNAME=gitcore.lib;;
+	*)
+		LIBNAME=libgitcore.a;;
+esac
+
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi

-- 
2.51.0.764.g787ff6f08a.dirty

