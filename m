Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A22C0282
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203870; cv=none; b=m7tMMXCRt2eD54WHCt00zaklB2AaPj9LSlyxhqQWfv7xeAFdnbMUGONlliG9UFgF/OJrBPA/dy9w02leSUNfOQLrImPg/p9InwRGLIuTVL0l1PC0KX6YZdReeV3pHJOllD9JqBxqGFuxQ1nZRliRHIUWLx5HqLf2aNn+eej2gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203870; c=relaxed/simple;
	bh=egjZWa/DCNTNz5sy0dr3m0I1udptqz582vZojkIXX7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euCnLNxIFEYhKCglfh2AAuCM4uKZJQTtYseFg7t0OG6MQ5R1XjUvs7XAOeLiE9eoXc4pwy0TAub70ZtirXtDwG2hZsrv774VF629pqhjZCgyWL56EYoSEhZcAuHQJCG5H9kSSpUKpgufGfnoSyvnBYznbQ0hkZ0PbWQ8lze5CCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DELb384L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRiUmyLj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DELb384L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRiUmyLj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A916CEC01FD;
	Thu, 23 Oct 2025 03:17:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Oct 2025 03:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203867;
	 x=1761290267; bh=p984xQUIkMzUtS5ar08nqO7OeP14PdHnPsoF5dKcXK8=; b=
	DELb384L98SykDL4C7RHGHPtbBgngYprPPkE/Qccbnz/+spi6cQFhc+f/5rh6XWN
	BCGva3e/IwiyJCczXnGjyiOV2Ivb9TBQW5s8w1YYsn41AICG3VJ6OhllyNokaBSD
	M8SImxulx1pi4Xp+Sn/OHHqKyhK9tG/+qub26HRnYORMswRk9maFc+6ZcSj1j6fC
	AbQ6RsjBbLGo/ztRwZcsQRtUtO0DqeCNerbjv/HDE7gj4fkm92tqNz7hNpnHFkdl
	GX0vb4gJ/2ftIefUObqUFSQ3ihmIjwuQ9KqPjepHGKOuTyCSDS4sa4kSFp3O4BVK
	8fRgZpfiZaHJC8unQjNu+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203867; x=
	1761290267; bh=p984xQUIkMzUtS5ar08nqO7OeP14PdHnPsoF5dKcXK8=; b=V
	RiUmyLj0B4heAVsyDZbNiz4qFSMKDMKt7HQD96dSUWZstPT5h5lP6lbW5snHXVC7
	AeK9GRaX+5c9fVdlnMPnXMhUT0YEcdp9OoDYsgZd2Jn0bsu0+K+iSrxTvOyES6jq
	N4f6aypy2k/J6EUvqEY46mW0k1YjqxDOMA0IGaNZxHRRp5ymthdQ6wqzOsG60oK2
	GGFxiah2qfd8yid2icaril/jbDchlP9gdX/Mqd7Fi++Eiy9NcbYZ3FXUchL4L4sc
	vZO8faOiF/TBrKApBbr5wOD43o9dC/Qnh7rO/AHbAWpGuxBYv3CDZmTNkEkFx0zn
	fVjdRdD3bz8nRFavNgwlw==
X-ME-Sender: <xms:m9b5aIDofarESadY8x0sVdExQwJ7DgbhLNwICpdv5WOSERMGjY1zUg>
    <xme:m9b5aB_2UL5vUowhWHVidJIWzmmKUVzAa8W1u9f90-xovjNBfnYDShrq2GpGIeoOW
    b2jPmO6RJlHinPZGzR7den5AbjGZVJINgBC6-QWpgvqG0xcbU6w_Q>
X-ME-Received: <xmr:m9b5aI-tqsDsWHjHXxeMP833jzzVQa4BlikEErod1H9gxY6xkBGxwAdN8cCVNvDKqy6QmuLI7xWTptiYjWIkaoX9S0JKg4cDyqocvGptSQMVIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghk
    ihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:m9b5aIfjOEuM3fXw_Kp92Y4h2rFoS0Tj_6zJ4hWoueqBPj4Ud5Rd-w>
    <xmx:m9b5aBGmeWCBK08Jzb-CG3G_RJDMXiMwYL_qimM-RuoRmRQEAmCt6w>
    <xmx:m9b5aGd8PD-z9PUTrhSFWC_nseIQZD8Dq3uAdI7nILmwSMsSsgjhhw>
    <xmx:m9b5aLGLTLNzPBoyMhSClpVpxdwolsgzflPVq6BP1mEuFgMdG9E1fA>
    <xmx:m9b5aNqIOaS6Nc8MxzxvRmwmQzmFfjx7Hxg83fj50p7cJBq3WSopI_Mc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:17:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 747eb472 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:17:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:17:38 +0200
Subject: [PATCH 1/3] ci: use Debian instead of deprecated i386/ubuntu
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-rust-cbindgen-v1-1-c19b61b03127@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: b4 0.14.3

Ubuntu has ended support for 32 bit platforms and is not maintaining any
release anymore that has 32 bit support. But we still use i386/ubuntu in
our CI pipeline to test for compatibility with 32 bit systems, even
though that specific image does not receive updates anymore.

Besides being end-of-life, this image also doesn't have all packages
available to it anymore. This creates problems with a subsequent patch,
where we're about to pull in cbindgen for generating Rust to C bindings.

Drop the Ubuntu image and use Debian instead, which continues to
maintain its 32 bit port.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 3 +--
 .gitlab-ci.yml             | 2 +-
 ci/install-dependencies.sh | 6 +++---
 ci/lib.sh                  | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cc54824c388..0b16970cd7e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -395,9 +395,8 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
-        # Supported until 2025-04-02.
         - jobname: linux32
-          image: i386/ubuntu:focal
+          image: i386/debian:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b419a84e2cc..85feebf72d6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,7 +63,7 @@ test:linux:
       - jobname: linux-musl-meson
         image: alpine:latest
       - jobname: linux32
-        image: i386/ubuntu:20.04
+        image: i386/debian:latest
       - jobname: linux-meson
         image: ubuntu:rolling
         CC: gcc
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 50628ee2dd6..b7b3cf35edf 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -39,7 +39,7 @@ fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
 	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
 	;;
-ubuntu-*|i386/ubuntu-*|debian-*)
+ubuntu-*|i386/debian-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
@@ -48,9 +48,9 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		SVN='libsvn-perl subversion'
 		LANGUAGES='language-pack-is'
 		;;
-	i386/ubuntu-*)
+	i386/debian-*)
 		SVN=
-		LANGUAGES='language-pack-is'
+		LANGUAGES='locales-all'
 		;;
 	*)
 		SVN='libsvn-perl subversion'
diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d401..865a0675371 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -250,7 +250,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
+	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.51.1.930.gacf6e81ea2.dirty

