Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A33F1071
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453708; cv=none; b=avjhXZs3UzKwBVIDQkBe0hgew3q/YD9znJy5+PFx9F1NEx7JxOjzIAxrtgYrMLMa7Hkm+8YNtDiZ/GnL4SUza4ZH+O3vfTIAnxdzNanlVuMrvH0R2n8AXDXH9au/4ccoiG8BgsH5vZSlR5+rN44mz08RlkxoA/AsVcaG0fab/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453708; c=relaxed/simple;
	bh=phAQqEr/EIrPGQ1OrtarkjExH8VoPYpvMMV7PvNLoSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG2ER7PUYuKOc5tbqodBIBhJQn6dWyZuC1Bk7LGxlWim3K1Svcqkdw/nl48cpTExO9hZw9JIwDzxPnhoZ8tZfOt1HOHqgMkjXcIQIoDoKJy4VkzK6CD55cQAKVXIIvWnW3Z3op+bEgrMB4SnvXGd158ou73+VrKNbbx2OoWp/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gMxHBSN3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlykS4KS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gMxHBSN3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlykS4KS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B1DBEC00B3
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 08 Oct 2026 06:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453706;
	 x=1791540106; bh=5/kMoPrW45qumDsf636MokuijnhdDWUzPYo4yerFGeo=; b=
	gMxHBSN36uL6IReSiWz87sVgmM2D80WjYP3GOSMm1TtEdZMuZ64qOO935plBxZhp
	QU51RtKzdQgFkoVx+jkSk08Rwl4+A5IPv5Exa9Ys9X6NwOa9+7tvlla0UX/tmVqI
	GBeQxKZRuuXCIzLFKnBxN0qmBdSfjmYTxUudQZNEjoZtG23ZGQjIC7DX0qf8dhVC
	gp4LEL2nWMN+PoCnvZXQggu4+PRoFbHAW2Zx1W4RiDJWdNDxgli01qFcmFDj8/D6
	3UFmoSTDiCe5GIJLB7VzBUcuj5MxCIFcb2tDRZsmUbLOABmgQc9HPbaLA8DQFX8B
	Uy4tPalipXWdzIDpuO+4Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453706; x=
	1791540106; bh=5/kMoPrW45qumDsf636MokuijnhdDWUzPYo4yerFGeo=; b=G
	lykS4KSBiByyiBhW9u7LVkh+RzhFJXLj+2z/vyhseEeC1SoYa7GYffkw7R6eMpgJ
	Neg2/be+z7cFlZPO9wAA9akROZ3aoF+BPXkbb34HaKbwF8lyhWvAr2S+NpGGroEv
	4mhEiIBu8ey0w/1qF2fLDCSLvkDilUIkn+95hAC0ngOHvHp1n1ZPj+jETIzhr0WB
	Ns9H5aafMvvXbavAGtnwM8IMO/DUZ8hLw7XwV1Gfa3BOQ6ZZ8R0PVe4yumlYRz4g
	GN07PkPY/b4wO9snEVTY7jMp6RU5q03PKeyDjgQquuZIwsuyBOgVXJsknj4Zn+5F
	WrQyCWI9PSzZ9AA3WlVpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453706; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Imrukq/imkf/WXsb/1aposs9dBEJxxaGA1o7n7ybemhVhbi
	clb0qhoL05g9iEZmYJj4ElnuWBVExuOFePDrb0Spo7ZENA3X2mJ1TDs92hzmtQ0T
	pX694B2+HZtNYY054LcqJO4gvqT5BsCirAWBVjJJybgPVjOwvOwcYsf9qXTHSYIV
	e//cbHbQniGZGGpDR1NL9u0nhz/DqPwgfgtWKo9Glz/iBHLa/q9s0LNp12rNB4qm
	Vb+Ba5Ry4GZ7q25jaHDEx/N3xmV1HVHvjEObG1VoeVBK6Hh+UVsW+2KUqlsrzCGv
	OeJ1v185NtXtp9WsvzAt78ELhl/barL4jI8ZXcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ORDc619b+OgXSw9/CScA1gxoXRH6Os/G316YyYtLQWo=:phAQqEr/EIrPGQ1OrtarkjExH8VoPYpvMMV7PvNLoSc=;
X-ME-Sender: <xms:CmrHamXO99LEDPu6lhU4Ge97YY1qFF6GYmTz1RjOBOcdBU8ZdBfGGw>
    <xme:CmrHaqCW3wOak5-_TSNzBR9d_ft0_6gfbRw6ukZrk0TsRV-wlIBvEouvaXfXSGZMk
    gqRqxvEhHvNZXwTUTVIlDf-tIU1feg_vAScpx8PlqXv_llRp2WzlAI>
X-ME-Received: <xmr:CmrHanzqhFdwmV0MQ4OhksOizdr2g_ltMozjlxOngEtY60RNxFbD3g>
X-ME-Proxy-Cause: dmFkZTFM6ftuP4DOLoqyy3KouLyF6qZyzpmE9dvjtChdfgUMA6B/oLo0lzuUj5oruLPxSJ
    XyyZHElFuitD7Ehl0c8Q9cS0izTMXiocDDDG8SIYKjxvTy3l1kafihkKQluaoEpKImE+FZ
    C2bcvBA+x5wFX9xQGiMQQed9L+UY3z+Pcllo73MHxL8Wz56CmFzaNcsZtPKWedCPGFySyb
    lgy4tqyZhCH+GlfnXN1u7ZGS7bjwtUFPWVngmaoRHha2Zm9HVGmahRtv/snQSVc76cTata
    G7Ne8Mj2hZlQIz6OojcDB7ZXJi9bg/nHrWqeb9GUFDgVkVNnqpyYUGuLteRl5yOK2XdRYl
    7b3Im+KsI5zyHQM3F7xieWmLKPD5T/xGxdrH+72VmiSOMccUx1mdNjyagIoLBJZ0niMKwh
    jJtcFQ5rkT+yxjGrO0jLZsXbjrqUF4JCt88aQ/sHNMhpmCs9euEJcYKtrAMj+iusuBKjcu
    nlQnyZKXuI8O9D8DG3M2KogI9/UiYq73ECQ8w1KTp7bRRhfvMS9H81DhB/aayRax/PHiVl
    O0YQtz4Vg2jMJtzQRpkAHDcSL49xIpQFiqsFKDbbb6VwjiiE4bPjTj3F0nNrxOdq5j4FzM
    iDFTg5px5++xiNHsrKIY4L5s/uDIsyHDFAvf7DUW2wkNkIY8xQ+h6GWAY8yA
X-ME-Proxy: <xmx:CmrHanDCXUmxaHqjcB6IM2Xo6j1IVBbhyfZji65aDWnasgacP4VOiA>
    <xmx:CmrHakblPUNVAIAdema9bIbPp8YUzCbnvOG2kOnxji_2rgX9P_69Qg>
    <xmx:CmrHavgDcViLWgln6I_AIpXKSlX74MHiDIS14WMDS9l67b__ZM56Ig>
    <xmx:CmrHam6KIlh9fzqpFanuh8I9eIrJIbwNcZLyhRfkcsMf0GNaeLJRtA>
    <xmx:CmrHauxaUHWYk35m-SpvAuXKfdxEnd174pVxfO3unja1Jt6sRCn9b05R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 848af4b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:25 +0200
Subject: [PATCH 7/8] ci: drop now-dead Python 2 coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-7-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the preceding commit we've dropped the last job that still used
Ubuntu 20.04. We still had some conditional logic for that specific
image that made us use Python 2 instead of Python 3, but this is dead
code now.

We could of course exercise Python 2 in any of our other CI jobs. But it
reached end of life in 2020 already, and none of the distros that we use
have it packaged anymore. Furthermore, it seems like the world has
finally adapted to Python 3. So it doesn't feel all that useful to still
exercise it.

Drop the logic and instead use Python 3 unconditionally.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8783b48951..4b1733ad15 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -61,7 +61,7 @@ ubuntu-*|i386/debian-*|debian-*)
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
-		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
+		${CC_PACKAGE:-${CC:-gcc}} python3
 
 	# Starting with Ubuntu 25.10, sudo can now be provided via either
 	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
diff --git a/ci/lib.sh b/ci/lib.sh
index d99e7b9da1..3ec10488d4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -335,16 +335,7 @@ esac
 
 case "$distro" in
 ubuntu-*)
-	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
-	# have it anymore. We thus only test with Python 2 on older LTS
-	# releases.
-	if test "$distro" = "ubuntu-20.04"
-	then
-		PYTHON_PACKAGE=python2
-	else
-		PYTHON_PACKAGE=python3
-	fi
-	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 
 	export GIT_TEST_HTTPD=true
 

-- 
2.56.0.406.ga2d225a756.dirty

