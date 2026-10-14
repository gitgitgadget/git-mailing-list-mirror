Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBF4A5EDC
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966651; cv=none; b=U2q4wbopIp2dthH7voznRTEgWN8Jh2+ZzQnUVF6mBrvSVfF7hBkPF8WssC6H60INhgRfmA22cgxVMIs1M2CthkvuE1UyqR8VZGL6LHBdmDKLTqwIB6P+45J1m0H6jxm0tdkKhflRgAmOlutmkzFAmw//14LQQ0FmG2+EHO8EW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966651; c=relaxed/simple;
	bh=YxUYzUV8DN/MAyUeVeCfCQAGeEaUi0e6EsRnm7Uj9oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vA+HFUDEK5uFWMEHS+9Wvn0NrDv86ffdgLH8U79ZSE5GYCJSScH43W0WsFGCiW9gXAq7BIQoa2V1v1PHak1jFP/+FnFbXi1zHyS6qXG1q0+G1qCGGERDuRX/Lc344useu8F0sWBTuHBQCAWQn0YjlldZiWF3AtD44C104xvcvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MMrtxeNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4oN2B3x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MMrtxeNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4oN2B3x"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96572140013F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 04:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966646;
	 x=1792053046; bh=VLAXSgHm7A2asm0APgciowWUYmEp/sTNy6KjuqwehEs=; b=
	MMrtxeNFVwM88kjBPnusy/rrbfg1Cfc8VeFcmTdhZw1JNLslY08dEbgdeDoyif1H
	TR6ga7CMk9znUf5DOX06OVqQx62ncwMEjtyAWHwmX0mHxShetsPlniHDAXg2E/Q4
	FJfbW+vANL6XR17fwmI/F6Z8oIsjUpy2BuF+F62lrq+DLJdOxaYKMtCVXP9fRdb5
	tJsCkVV4iAhFui4Hdo2Y3YZ4UMusNhtpMls6y1sJKoBk/98NoF6SKmZ+RxXglF3z
	EoJhdAU3RLj53J8uFczO1In0UFCUYiyAr6dHT8oZjfHt8f7fHz/wdDH85eriiYsc
	HrJKGxfNJpoLyi0TYwGIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966646; x=
	1792053046; bh=VLAXSgHm7A2asm0APgciowWUYmEp/sTNy6KjuqwehEs=; b=N
	4oN2B3x/GXVmz2En46BUAtZkYJZ/7qJvba4YZokMxyOlxsCPl3EArygOUhoe0078
	R7SyYeit+wqsdNA1PBGUKLsGhYustDficRdH4eYNNyUn327qxT9jKnQSR0RxbyWH
	hVAPRmPsL4IAqM8NHoQiHDsL4NGUJRkB8FGqwW5D5wtTCdVcHG4HskYZLF0eiq9b
	xfWTsqr+sWsYbQ9XJEd+yuG00zSOFPfqBqFil95K1TC6RezYFJBvdu2+B1ntVkKX
	oE/s0oW6CuiUG2xE5I1+0qMgmqO4sFckYUSg/ZJlmxUpSzDqUaTBd83mjJ5w0AzA
	jD8/126vkoXLn/1bPHyLw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966646; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eR4u/Ho/fVyiBSYBSOKXACusOnXVDJkkPXe5IpxgOwf9bBN
	WK3cqStM1vXnhA8uiLVqjFOKFODVabtJomuneY0hFX2Du6XT3pniT7TBYAogb5nE
	9GRTIQIoSGc2Rj6LORSi2nkhXAe5TzrcJHPnjRFAhzfY3MOgM3batG/QZiYlYqLs
	cymvUBp04nXI+m60QEFYPkZ8onciHJJnqPnIfoyFZnMNjJgC0jfwG/U3qeebH9Ac
	1yVZShUeyMyqxrtiS7EjBfDgin24zSyePmlf9RifzjXiGCTKXVdvpTwKzujsuH/R
	4jaW1mJbMwrwqH3QrJ1VH0L60qYRLu/DbIZAVNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aoR9ILT5UZIKgwQOT4jVO6ymNAxYONy5dydWqXJbGPY=:YxUYzUV8DN/MAyUeVeCfCQAGeEaUi0e6EsRnm7Uj9oM=;
X-ME-Sender: <xms:tj3PajZT7-W6n4R2skhCLZuQwxBUdobNvzK7DvE0JX_6XSRYwduIqw>
    <xme:tj3PapTYnZDuk3yt_XeXbLiIyU093wSCZS2p_FmKWfYUxGOY-n0IyvfkXmfI9Gfgv
    VxltVRuRba39fB1VLC88uNWzbMmTPZRCN6wTsNIfYcBurzv8ds9yI0>
X-ME-Received: <xmr:tj3PauTBTAepwgv5o5Z6yu8PPFqiLNwfgTKbmlIrNJEFFqPVG7NiRQ>
X-ME-Proxy-Cause: dmFkZTGKoZzBGtqq4bgbHPLbZBER0CRKL4htx/SRZgubolx4/0iDKq+fRjG4rWbvAKs+4K
    jZPx6ANmbBSEIidmQoU/jhNhlQ/6DxgEJoGd3j0oULe7i6yXU78rJ27HVC7yHoirTfy2I0
    k7V6uo/GUoqOzw6ORIXgwyVH5D5Tl3j5qo0J0OKpy3KdbVuTPNFmt65EsWIBeo4ZFoyC0I
    cSt6cHxqawOZrdkaK5FTgADZXYQLE32qEmKMNaZP7XDJVx/peJU7E9EBDc4pdzZ6RUf6Zi
    sW1lHS+yFnQ7rsqjT/iNJGQKRLvLg242/zhQJqE5bPfB6zfBPHYV1W4OyXNpa0DOskXdZE
    MQVr/NAdbr98pCd7jmciY8ufobYxKnYlvBCO44vSVFwPUOs6qo1nenoD9lDyT38SkZ1Tuw
    IHAQau7hui7N2NNWY5MVfTeDE+t22iwfkVK6SBay1V9OE5BvHSXdYCbPzhmD9ap7IEb66b
    WriqEMHXHI2uDC4n/NxZ/tUJMUwGdiY79Ww8Xoj3OR4f+wYWwKZZwXgHNl3un7rahYms54
    JwUunEPW/rvOIiv+aYqcQLKhH8hymGapYhvUOyUWJp/BeBub6ZML85inNSp0nb8tHRsSMC
    czkvRiXfDD67NGBQCFcl1yQip0d1t+8YsmowK4hzi2t85r7xIyrkATxZE3ig
X-ME-Proxy: <xmx:tj3PalSQsg27yFF5_H49Ck4RfKIugHNxyNi9Sqlduf043_0MNKKk9w>
    <xmx:tj3Par6oOF08lagIovz_9rzfrCp6N3CFPsRU7DrJqJrag19PUAaHKA>
    <xmx:tj3Pap3m3u_K2sfVsU6ciDrK8KOJGHzQDvW5tthyBBVNMzMt60KFSg>
    <xmx:tj3PauCGDnqkhhuPockAPKFEBryfVF16-BkYaUUNZBWnU0nQJSzjBw>
    <xmx:tj3PatxR7pKXAAkx_CUJQCe5JbWf12bWLPQb1cVXCy2qZIFfmmtgDCME>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66db7e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:30 +0200
Subject: [PATCH v3 4/8] ci: switch away from unsupported i386/ubuntu image
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-4-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

