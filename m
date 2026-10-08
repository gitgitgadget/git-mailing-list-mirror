Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DE483804
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453700; cv=none; b=n8QrEcK1h1+zH45wrpJOfGjL22bUdJpFSVNLOS/q7mbcSrZkelqeys8U3zEz5g5gjCll/UTKQSjU2eM0MWIjzJf2De44sgz2+vq084GsQ5KXs2P1i5xbkB/cwtp9moT8d5/y2+iXsyO/+TTQrDAvy6QKzSSw+6lR75Rn/wTsySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453700; c=relaxed/simple;
	bh=SxuwyhvsKwK1be7LnYWwzNMGmwaYVRsiH/Q6Kld6F/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSq+4UJ/Yjcc/l3T0Oa6mKZppbe78lk8UfTEv+kyna9Hbq10Fzg+Kuq7ZFqa3kskAFvkVD0oon0kUpbPorrcz2uLb2vJ6V5agM0aIau6TKzjfQeNR3MsgYt2amJ+DYvSGvUOn16UEHumnnHtcEN6ZmU3dNWji651D0H5gp2IJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jj6Udrb5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SE/bffGA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jj6Udrb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SE/bffGA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 41F09EC00B9
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 08 Oct 2026 06:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453698;
	 x=1791540098; bh=JcsJkB6HwkNR7RMTEuaKqAZV6RAsHycMC0vXnKFI1dI=; b=
	Jj6Udrb5G9s2iXuJdyMxxLW5q9GHmoZCVRc6YEthBjF0VLiSdo0+j7lo9harzE7h
	RVOpNon51mej+klRUQtVJhwLRus7OTpfEP1o6F0pcgGU0yiVD/tTt5YHj5mthvUj
	Jt0ek4EXmoUMmi65PMyCqyJng1AAEBH3IMmgFwLvHirTJuo7N6J8n3vIRxO/GHne
	GZrkxlGBVEkYxz2UDGWgcFgArGXVTg8UF60kd3jHRZnLAPXKdlAbXhjl1pDeONEr
	erlgakbRMgRK6EVVDkhwYOqN7kePMpLTZ9h6D4YH6e6TMaUUi8YmDpNAeDeoPb6X
	MynUX4FnODuJhh1IoWyiiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453698; x=
	1791540098; bh=JcsJkB6HwkNR7RMTEuaKqAZV6RAsHycMC0vXnKFI1dI=; b=S
	E/bffGAvNS80/lA5qYgPTDWeOORU6jSWIilm6FA8Ihj1C00FSuxR3iDdivF+jpuw
	hfcEmlvzJLvp2frJ9U4c9RTHhnVcRtEyR1G4zV8Yfv8qlFeM2coNH8vnGIF7yobR
	CAUtIBTOoKL+5/wIY7Rqa/ktwdBLLSWfGAha8H+f/g4MNS03lVIhU7gUzF/iz+Rt
	woWEAh19BwpSdD6gzgrfXGvFhaGflKg15VzrN8vSg+7w3HFXyO37ETtKXVnUWEtX
	25ZH/Y4vKT3bMeLEMSa/kHgjuJxVpOkPIC1NSp31cleh4t6eExTZej6G5EjhJD4B
	OyaJkI9yNiIIdIDHWrxIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453698; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RApYtDm3k6qhi927nc/kWRYtjgWFu0YzXLoxlTXSYwU83jG
	dOsLqOWfJa6WXbJyjO958wjsdq/DgHZDIrgvv5vvverqQm29/aBS0ufNNxf31RCw
	OoFZ6FnQY0KpqTkGF4guDjOhhheD7AN2PVGCD/AV6bja8Tn3OHqymMoNPehXkhkb
	izfiq60ht6OxP1PJvpUiDX/vllUaWxCkVsp+A8akLBHgj1MbxZH58hgXQx58fD8t
	QIN7M1THhKuzJ1rfSjHBUp9hDc+I37N8lC3XSL++G6f1qnlEj0h4JYlS0p1H5TQY
	Kugr1INJfk9y3vQPTP6IcmGzlIIpYKV+c0Bmb6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dgsBJ0aN7/VNwG3KO0FCt7dDqXL870evX9JsTaOOQz0=:SxuwyhvsKwK1be7LnYWwzNMGmwaYVRsiH/Q6Kld6F/c=;
X-ME-Sender: <xms:AmrHamKAmiO5cNn0xKnysVlCfeUv51Ioa5gR4DweKg9WqXxuW8BT-w>
    <xme:AmrHalmtSgBeRR-jmflJmQ4Xnc2snD9MWke310ph1vCAoQj69vNtgdn7py7ixT_Az
    pZVd7HzIdREo8_Rby1wJG4xLq0Pmn57OKNvZaChF6qX91FVWp5L3UQ>
X-ME-Received: <xmr:AmrHakHNE2h7EBbTbyoM0U-1rZRGHiVZA-3r7S-HfWq6TRQtHbSltQ>
X-ME-Proxy-Cause: dmFkZTF1TMUiJElJKzw4Q4owyK0NmN7jx85VJ9WFfw4Eq5MX1TznpKHyu5EGuqNrnD8GFj
    0Oc/d9I+HRtN5KtZFME8v5GJqqQDVsbWzoyWAfuf9v9Yj12bhi+OJpSeAjBQtQzrnTLny2
    65mHCxorYeKn5bWuoclobu054tDp9SmvXqaIODlYoK4Xr8hAym9RySIrJUYVJTH+GnmK+G
    rwmNtT/ntuZQ4AgC0iLy2eOQjs7dvl+aC3QduhiHDLvs1B/H7spORu+h74jjFFlJ4XMtr2
    MtPB6cEeavVTAld9ndnbzCnL6XS6Uy/9M6d+Eep0BZl8TPz+wcY3IdoJ69u37DhhuMzvLe
    7TdBGOx2bgyNI5FkvaI5olQ18l8M5KB+g3K3Tdsglr2EesBHwPWIxsXGZpRXdHlToB0vei
    KQsRE1QmbP6cop/xfqDG9Iluo6XAweTPlwGrkQgWzdE+NPtl2ONSu4cm+t1+f29d5zh3YX
    f/XUhfI7pO/8b3gJTY5TbZ/5aaZcFHva2uFOw9WiZwmc5XzDGZE+aHuTzXaIehHSt9mEXG
    8Ir6HQhof1NlXCfhsv3E1SUHJx3jzH0iEfM4loQCmFk67+fpeGuAl5fsC+0hXoTBHrnDrd
    hLhmDEhPTA8Zy0ur9EJhfiy756RCYz8SdBXulWSc/Tcx5Z+0ch/YU9bGIzRw
X-ME-Proxy: <xmx:AmrHalFOjZnbkCIgntd0ELaOA2weS24t2u1Xmpf9opGV_pzAxi_lJQ>
    <xmx:AmrHahOalDD6b2XK7nAex4CmEotjtZIifpYF8Vjpl26B1ibOjdonMA>
    <xmx:AmrHakEtyL9F3QDhDepjn3ef6kbGQaQ7l77x6uyiis_Wza8X8TEsZw>
    <xmx:AmrHaoO0ogSsS-fC_z-n3FRaJU7lHWOyAV8D9aLVJBEJxGJpNcUkPA>
    <xmx:AmrHakWQaGn52XJIzJAe_7EIDkbK-taBuz4Hda7P2rHyviGw5rAeNwVb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c80d3925 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:22 +0200
Subject: [PATCH 4/8] ci: switch away from unsupported i386/ubuntu image
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-4-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The linux32 job is used to exercise Git on a 32 bit platform. That job
uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
nowadays. Furthermore, Ubuntu has dropped support for 32 bit entirely
with the 20.04 release, so we cannot easily upgrade it to a more recent
image anymore.

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
2.56.0.406.ga2d225a756.dirty

