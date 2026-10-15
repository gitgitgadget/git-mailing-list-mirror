Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603C4A13B7
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047459; cv=none; b=O3r/U8VjXa2vpYbxAk6zts5CkT4RU33V28vJrSvcOnczd5l7n5/musdVSheFUsnjdZCs/9ScG6WzL6PAf3WAUVtxnAkGUUBzB1JENyeWXuV2qUR5lS/uVc6aszW3bVFVIjatIVfzvrtfTuBUIjKiBvp/BNcc6xwjtsSyMlKeIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047459; c=relaxed/simple;
	bh=YxUYzUV8DN/MAyUeVeCfCQAGeEaUi0e6EsRnm7Uj9oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eU6vML+cd9bje8yN/cVgcW3N1rR6KzRh9RbTgLPOqjox91GY98i7LXb54HgjN1w4AENyn2kzzgIwZIbgnfOhCnsObRxU0LAlPqN3M6lRdPCvjhTxVFOdO8Lpysr6id2YRwyDOJFsyjYsIz9YCMN7am2uJNU99oPR+HDYVEVcwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RryxSMdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AySikp9m; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RryxSMdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AySikp9m"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EB057A018F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 02:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047446;
	 x=1792133846; bh=VLAXSgHm7A2asm0APgciowWUYmEp/sTNy6KjuqwehEs=; b=
	RryxSMdo36VJGrtljyidcVLr4GcEclieOnGcRwWZqtvwDDkadAYllNO5hjUrl601
	hWqom2NPdAkXgLpG5COCkAQPXd+gMtW9w1bBTJOF+bH5d/YlgJlVi1jrgja+5TeO
	EV43M2c7NokW+p0VviLl7aAqaZHBrkug1bi7qPNbh8vwvt6u0iLFrvVCuyg4fq8H
	JG5n8jjoU6fH/Kx9eXIgyBC1fXwr2yy92/Z9YGu0Ua3aPkH1R9WXZ4fR3JBew9Qa
	j+RSrClk1w/qIu09a66+vOkydzxuZg0deMp+jb3yO8CcWtVVPa9DdTigfRJf7VzN
	8lZn1CkttH+/QcIc6UREmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047446; x=
	1792133846; bh=VLAXSgHm7A2asm0APgciowWUYmEp/sTNy6KjuqwehEs=; b=A
	ySikp9mctkxehn7bZjSIq/DDkKuBe9t/xP6WAntx6meahAdpvLNBk5/4TLJQhCUw
	cOERCkHJeoEs3JN8/+r/7WC9EDgHxAWIDltEV+jujI2C1HTmBBjz3L7PiDOclkOP
	iA5uKEWPW1JStMTZBG478jjuXRY+KtsSj3bcqT4/HFmqD3sOCnBSaX6WfNxbvI21
	cz6P+rktBXscBSn/7HBohOtRVJRJe/EbUprpkN6UVkqF/lr0JhVGOvMG8fbnxsRJ
	TU8el1CvXvfSvZt44rCtHKE57TdZU/+Y2iOYNgbag89I4MdSLWOW7ZgpLy0FcKI/
	w4yrGJq5wWKh1rPxtqfmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047446; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lEcOKeytS6IVWwiMegUXaq41Pp4F1s00ba6jC/B4cD1R88E
	Dnb1LNzfcngMbynS38h/bufQJH+QOxwEdEKwXfIJ8XBkaCpTGNl93edvANfs56Oi
	y3rf9eDWnqMHX9wuMUojR7pO1J75XXkdMLRbcV4bSpOMylHwlCXQ5Rv+XcNJx7hO
	mQpc6TqKd+h/nSnczPdQvwlol0jvKds0zmnRsttLTC/UagSCG+O+uE3bN/xnFsBF
	cIpBs5QFmiIOeB8/CqFsaElxBxAOgcFN6KCN7gE8joXbaibY8VfoZZE3Rc2gGPjG
	Ba+Sgl21euBh2GC5sUfQ7J6kg9kTu9kkmfYDz7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:99FFGJ6LLyW4prMezjDZLKewFoAYc+anau5b79t7OrQ=:YxUYzUV8DN/MAyUeVeCfCQAGeEaUi0e6EsRnm7Uj9oM=;
X-ME-Sender: <xms:VnnQamXr3TsEEiVSVToy8kz2XK2ESPZMBSQ-PniW86kSO1mNjOdf_w>
    <xme:VnnQamQ5h21DBiQh2Ivpzmj8sfipMTN2_Gl6-h3hPsm0zzY96ZTjWekNj1gKZyYBI
    Q6Z1P3-DS0V7jEv6HrpkbmhXbvUF6hKBXrQ_DB1C-PmdNYbR69kzw>
X-ME-Received: <xmr:VnnQakOiFgkAst_OV_Ajs4j62GJGKxH1cSM-GulZhQcAzMKDzSAZZZV3hiKYt3BVuOlyR7c>
X-ME-Proxy-Cause: dmFkZTFVBIvTBEG7SUaFFmEHaeBczDryCtO0sLGJp8YiRntW6SPjMNzS9jx+Siu9imz6Dw
    73fKrVpVJzGqnF4Vnl2vGlC+B6CUNSEHXIwUyA4XL7m+nDvwf2pf6k/crVufjKxdQaMRZi
    VhMji5Rx/2XHDXbfP1LKO1v2Dq3/tCvaEf+FpFM/dNs3ZQSnKz/QjMN3k8GTxeZfjIkWCI
    belsgUzUYYUqoqzr/xZjl9xb5XGgOCmSFWMvp0Mnv1E4K5purTXR0gFDjjtf9JdoufCCTX
    JOiF7+YKySHYlMnqJ//cJWRb6ytaPnnPDGM4J2qvChHv6Hr5tKhbw50+7gEW3vW/zp0Rti
    MOUOd5Om7cdj3r7/OOLz90RyeH4IQTCsISNtAcKRfY4P3A1jloZEraqflbjNn3uiIje1tD
    kbrksXtInA56ioez7JaIoVRwn0jDNZGu+qkRvbdPJt16fMOdcpOBQgNslpztr2U/hE5rTX
    9JlUIvFnRq/q+5xcJTrUhcDrWniZp1t5MXc4sQ1qjd61FLaN4+VfHQKxq3SBM/afpCh/a/
    7Ltcd26wQP0ApSF0tpfg1ENDGDjIg9obZ4eAQKQzOb70FRVKqPk6GuYEBxL7rBRVWRslNy
    +ITRxiPGmM/g6MQLM/1BIcD6s43eWYQQG8uVDGT97Pf3Nhk2ARKi1cAuBrHQ
X-ME-Proxy: <xmx:VnnQakS4HMgMxWalrW2u9uHBHfrUk3tEJpip9d4k75hk8AgeAbmP9Q>
    <xmx:VnnQaihc7T5nfy6wuKjgujPLkWWwCOq-jryFqo4HRjxo7XJFNSoZGQ>
    <xmx:VnnQat9L7D-GRnBEUcZ-jfC6VAhVMKQC6ZiLIXKc--_fgtmv6-l0Nw>
    <xmx:VnnQapEeY-UP98ZxcXoTS8wv5kuZC_UfmsrRwHL3_Ehs9UH7TolrOA>
    <xmx:VnnQapHP0MilMgK0l8RVe6pkJTTY6KIeNYzTk-XH-HR3PkJdr16LujTO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 174cd3c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:13 +0200
Subject: [PATCH v4 4/8] ci: switch away from unsupported i386/ubuntu image
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-4-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
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
2.56.0.212.g129ede20d9.dirty

