Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D99477E2E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545551; cv=none; b=HjM+m5xMvOB0E3AJ/VS1QiW+d1mg6bzrJSzBKdfo8fHuj+voOib6ta39SLJ53M1uYTX6Ci4m2Ks77gm3wG2Ci7nqdqEwyi5gjdNjOOJm1srtD998ar0fnwxYXafdcNU/DKEb3MVRcVcVJ4TkpsEP357purQe/4CoCartvnIqofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545551; c=relaxed/simple;
	bh=AqzxBxVw+P2wJdp+lEmp75tEWQmn/AMU8RhK+b/mWpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKg8zMuh1Lij+klIAhRPcMRsZm8x3qKUvHJdixlFTZP81iHhwFBpkm0puhF+yYb3/TlTajI5QHEoNv5tGONwI1nKwCItSiR0zk/oOuK0BjW3+hmGBs2PXUsp+NtCGiI9IhfNnLTQIvxQKz93K4ublixp6Vhi+EwFvO/nBMbZ/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DPgjnB0b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cm5X8Z2E; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DPgjnB0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cm5X8Z2E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A22DDEC016D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 07:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545537;
	 x=1791631937; bh=A9S6sx2RNy0azPLgm9Raw+tJjHzyR7IlpiFk2u+Z84E=; b=
	DPgjnB0bFngQEVaJZ/HUVW4mbRlxjD5x4ck1Fo2GhikHCGa0t6M2kSuV7vl9SCBa
	fsXNGLP7aOsRkWC8ie166x/TvHaXmn17oro1ouhfQKZQcqiJzAqKrrcCWKgq7aUf
	GSYRDbXzXttOcmkjdhc61J1YQtKryzy7qvrI4WaFuGUropnVrXI1qFv8T18Qp4sX
	R81+gQtQqm7zyx7BSVWr1N/FyGPeIfLw1B9Wr2AiKpOWkAfjP7j+vidJZeYfBJbt
	PDfY3NEV6vpJk+cs2zxpMAVKdySYaM8Majt9wzecsbioOp05hsdlQkJyJweAH/30
	VQUYd8yqw85MrH2gls21WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545537; x=
	1791631937; bh=A9S6sx2RNy0azPLgm9Raw+tJjHzyR7IlpiFk2u+Z84E=; b=c
	m5X8Z2E8++hNyFAPAKFMx5tra/lob+KXLWQP9GNwcLv8KHdR/p9pauMlWlCSV0s6
	bGuO4ajHwhSUTxN6YiqbmiHDiw82EMAMtUFB1Y28uYFFtswMi/kXafvO3g8zMPVp
	kZODEFUCwlWj2rq/C0WLxNljygiYr9jaNxoms5XLVYQs5aWWO6/TF1OEk9PKmPnE
	ACAmSU9a3AB56LBFlAvtOqGOrhvH/bn4mcXhEUvqIF2pEE+BfEgP/ZcZNUmA82zd
	anmqcKNO61w5ISjeg3srzjSAL1Fdyova606J2wl8d3gZZUZk9MTiib5iA0JC4CiV
	UmGVM935VIxJneNZwffpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545537; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lL0xcHtqJzf81fK4gYVCHCt47QmHsDRYn9UkUDLA34PcSl4
	lZEdNNNFs4fh2eeY23k69XmmuOh90OT4f/9y/XMO8J2PFb5vIG5GZ6QhswbvVUNI
	+lxLn+PQ4ASgWNp1cwV5wUj4/vibs8K04zYbi0q1rCZt318l3KxJ7HIox3xmSksh
	OxMwj0obD7m/27o4JY7WBhFKG+OiEB82TehAoUiiJaOxa/sp7O4xlnU5XipAXRC0
	i51MEpDNOtWBdukEVfc10Yg7X5Atq80U2bnUH9B6/QFCmlKPN2Xtezy1X32ksPA/
	so0dCUr0ox1uteba6F4WxIWuyZar80B3tKYychw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VG+1rgjRZJrxaw+sP1JZ53WziX2owo22pMYpRhK/o8s=:AqzxBxVw+P2wJdp+lEmp75tEWQmn/AMU8RhK+b/mWpE=;
X-ME-Sender: <xms:wdDIaorZEhl1oc23AMeUYJDEW59uqi3Z2cOTX9wpJRO2hvWzZbZ_1Q>
    <xme:wdDIalpc3za5ehQZepkfV7syscaecZxz63eN4_kxv5GmCTPITRwnfNyZjt4HPidOh
    3E6zwgKtV8F0aZ5xciUibGYPM_WLrDFVjkTIFKz9sxGfv72Y86dOA>
X-ME-Received: <xmr:wdDIaiM89aa2nkW-6DqgExHSeSgS2gkdS1qCYJLok-yi1O-i56LoR8qWrdYpu80n2Rc8-A>
X-ME-Proxy-Cause: dmFkZTEPDJwimDYLnMngzThAvtJ5eXXmSd/JVmLbDzdmNy52nwlDnwZkl7V6/NG9Sn+ONm
    Fu2G1VLZPCNRhZkjiX+Q/RwTIBhgvtDBYB4O6mPBufmOMMcgrXGlM9MN31ItpTA4MMnw6S
    SKBE0AHp3pOpAffAczTCUngEHr7/8/5ZovQ+EASXW4Srqt28A+oZw46XIIglAPkrM6je0u
    nmSMJS6a9mozTNlqPZEgcptNpUN/mJRtelK/jwQ13a3ZmgKtdhCt6pSvI9ifIonYRgJ/rU
    gN/2zzPArWUjfAQI54SyKuXCGCU0go9FrWfZ7R6m+jz1cSPIkVpk0WEOQaUjlp8FKVomS3
    mKjELNo0nikYkHure42n33dqsmsnkdjpmSxor+gvO3MXD6+FmzHAEtR8JQK0VnEoYF7yJ/
    nwX3v2zBHccLY2sz52dIr+j7HZIZ6gWauNQWsLfRdg1HcGv1zt5ngg4/M8oMskJy9V4ixz
    c0oSu+TCogEz01yyDZIeZ/fk7LC9zr4t0z9swxAVSIN3bxMjp5BM9qQZ+NSlekHlZgGOkS
    izrYcp0YTfm+Mzzwi/s5m9qUwLPNw/DTi0EbZAYOH0RPg/cXfk643oYNEeOFKb6Sl49jlU
    PsJdlZz8JUEw7jEOAa8vikZ6LIyRKxToWGEnSqQU0infRCQUSvpxj1zy7M4A
X-ME-Proxy: <xmx:wdDIauwa1g1oJGBOTPbQNIR0WPYbF6-gbQLucP8noCHmgre0h4Y2RQ>
    <xmx:wdDIaju0KmcZ4OwDBfRs0zMqngQEmNEUdblMr9d9RfDTgt3FPH37DQ>
    <xmx:wdDIav4MFuru0nMiVUAwS7wnSgo8RICNlg0yos2iFuzJexBmdXvjUg>
    <xmx:wdDIaqTPIkGLs3u2PPP0c1rJJC53iGZYFG1jLHVZ_p_QCqLNRdw1VA>
    <xmx:wdDIalJdtHVV7P9ojA99FGfviA-f_jjdLW_EfYNr0jai8P0scoxs6zn7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ec533aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:01 +0200
Subject: [PATCH v2 4/8] ci: switch away from unsupported i386/ubuntu image
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-4-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

The linux32 job is used to exercise Git on a 32 bit platform. That job
uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
nowadays. Furthermore, Ubuntu 20.04 is the last release that has support
for 32 bit, so we cannot upgrade the image to a later version, either.

Switch the job over to use i386/debian instead. Note that starting with
Debian 13, support for i386 has been reduced [1]. But Debian still
releases 32 bit Docker images for the latest release nowadays, so we
will have coverage until at least 2030.

[1]: https://www.debian.org/releases/trixie/release-notes/issues.en.html#i386-reduced-support

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 3 +--
 .gitlab-ci.yml             | 3 +--
 ci/install-dependencies.sh | 6 +-----
 ci/lib.sh                  | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b229739be8..6d1e37c8f1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -431,9 +431,8 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
-        # Supported until 2025-04-02.
         - jobname: linux32
-          image: i386/ubuntu:20.04
+          image: i386/debian:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f24835500..7d972f0c8b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -65,9 +65,8 @@ test:linux:
         CC: gcc
       - jobname: linux-musl-meson
         image: alpine:latest
-        # Supported until 2025-04-02.
       - jobname: linux32
-        image: i386/ubuntu:20.04
+        image: i386/debian:latest
       # A RHEL 8 compatible distro.  Supported until 2029-05-31.
       - jobname: almalinux-8
         image: almalinux:8
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d57dce5663..8783b48951 100755
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
 
@@ -48,10 +48,6 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		SVN='libsvn-perl subversion'
 		LANGUAGES='language-pack-is'
 		;;
-	i386/ubuntu-*)
-		SVN=
-		LANGUAGES='language-pack-is'
-		;;
 	*)
 		SVN='libsvn-perl subversion'
 		LANGUAGES='locales-all'
diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..d99e7b9da1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -262,7 +262,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
+	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.56.0.170.g584c36229d.dirty

