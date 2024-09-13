Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874A323D
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206777; cv=none; b=iMbfHnqeTgscNpCkkCC7kjUp6b2r3k3NTr0xKohj/wUi/o+7LCxK8MfA9NnqhDkzPgfUXzqT8GBusaca16ZFWejfol8le/rkg2m3Ne9BQJIGaLDuRY7mmPBWVL7qHjEGoXSkUlnj5HIhFdhUpfzEYOQPWPDBtjpnlU8rlXXQdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206777; c=relaxed/simple;
	bh=2mQpO0ZboyXjJjn74F2xbwnMZ6EeEP7PoWSluTqc3O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abtLbid8sCTixLqzVU32lDXFJgSXzMAQb1X9XcpQeUrWc2A02RE6Zs/yFKXPXXVV+YQpyt4ErGpamk+sOZvijV2s7egwaD9lb15puR1yaV4I5G+TsHlCfgnCAaZ3MtFposQJqVGLZArnGxPz+HkBE3xyKMzoJSCZ+Q++2i+0KeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MeRpR0PL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOzXLFPA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MeRpR0PL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOzXLFPA"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B325138025F;
	Fri, 13 Sep 2024 01:52:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 13 Sep 2024 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726206774; x=1726293174; bh=mOx/cuDRPc
	dLERWWu0DuiblHxxgv8CWCaFxuWTvcOpU=; b=MeRpR0PLsA4AIXhZ4+9hnq/sSV
	xv/u+9x6qqcp/x+vZcOBTWBkxwG34BiLQU1yxqErX3BNslMp9PqpARsdAnkcHHfH
	WkbIflYh7EZXDK+H7tfDAIRodFpJWQFeizM1kBOfe1UuSlMzrgZ4pXwT4m0MePoe
	vencu8kEx8faV7gbAW47HAuN1s2D4zUku6TIis2nYKehOE0vajpyv/kY1emUrG0s
	pCC62K7DpelSchAgxhv3VYJU+oPOO2xAFU54ZDzEglPWbytUfuL2Jcdmhp2+mOKP
	b2mx+acd1KEZqKHUWLYRdpB076ILIMYnBKxUNCsLUIeRCesWV045vcRUXqmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726206774; x=1726293174; bh=mOx/cuDRPcdLERWWu0DuiblHxxgv
	8CWCaFxuWTvcOpU=; b=AOzXLFPAdIuss7iWvwmUZUVPGIojCtZBnVaZfuPObKa4
	UeIHTveaX5g87QdhJ7EYOlkXg7EVHOO5VYaJqEWCJD3pF98xSwrp3/icZAI0Tiqw
	m9wgOCw+e34GnJbU1hl6wMkrHW17pI+doCkAyUPt234Nr377OBzBMyenBvddc92f
	Y4hex4IdzyJDDFV8dNAkGWyBBw8Chz6Lq2YbKnRRTSALeuV7zg4/MNlmlO5uafib
	L7xyqvUWx6MukNb9d5mOE9Wy/EaUF080rKX6Jfa3698T9ipnf7LEyS18YSPC6kCb
	uk1yi81zFJL8X1QHccCSCuGf4lGAzgNx1/DugFjyYQ==
X-ME-Sender: <xms:NtPjZgMd1KpIs08HIrV0wgHYhkJpRb9aip9483oQUwHw9b6gsiu9ug>
    <xme:NtPjZm8oG-9OX_pcYxfsDiA6yeqcCurd9962I1PZbHbYfy8ETT2dDGDJEt159L2H0
    Eh2HhjlnEaHkSNqtw>
X-ME-Received: <xmr:NtPjZnRJmLQhdOWZ8hvYCi3FJwUFoc2YU3BUj-8_RhfhGevOV5zFC1X26cmJGnaEqo0aWqGnQpaG3mFaBRtkk5T5DyUH8qpncuWiHF0tGMxZGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevhfeffedtte
    eluefgtdeugfdtkeeugfelkedtheegieekudduueevgeehudekffenucffohhmrghinhep
    ghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:NtPjZovqqEqq2UueUjgzx7jv-v5xkDqNqPHbhbApchNtf6755zGd4g>
    <xmx:NtPjZoeDDIuOR_Skvdxen079K0PB5Y29mSsFxCW1Jk3TbGnCJjtK9w>
    <xmx:NtPjZs3m2UWGmqpLOL8zap-lu1hThwKHF85Myi8ySYeWZVBBAJzZzA>
    <xmx:NtPjZs8EvYBDPwxJh5qBWBB7iSjcG3bc9xwzVPMBLT2Uw3O01z2bTA>
    <xmx:NtPjZg55ueu0olvsCz8D3UsZuXJ5ogNZkzZh3Ox_ntzS_Oz8cZHjZ-Dx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 01:52:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aed3448e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 05:52:41 +0000 (UTC)
Date: Fri, 13 Sep 2024 07:52:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
Message-ID: <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912094238.GA589050@coredump.intra.peff.net>

In the preceding commits we had to convert the linux32 job to be based
on Ubuntu 20.04 instead of Ubuntu 16.04 due to a limitation in GitHub
Workflows. This was the only job left that still tested against this old
but supported Ubuntu version, and we have no other jobs that test with a
comparatively old Linux distribution.

Add a new job to GitLab CI that tests with Ubuntu 16.04 to cover the
resulting test gap. GitLab doesn't modify Docker images in the same way
GitHub does and thus doesn't fall prey to the same issue. There are two
compatibility issues uncovered by this:

  - Ubuntu 16.04 does not support HTTP/2 in Apache. We thus cannot set
    `GIT_TEST_HTTPD=true`, which would otherwise cause us to fail when
    Apache fails to start.

  - Ubuntu 16.04 cannot use recent JGit versions as they depend on a
    more recent Java runtime than we have available. We thus disable
    installing any kind of optional dependencies that do not come from
    the package manager.

These two restrictions are fine though, as we only really care about
whether Git compiles and runs on such old distributions in the first
place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Test runs of this can be found at [1]. Note that the Alpine Linux jobs
fail, due to an upstream regression in libcurl [2].

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/210
[2]: <ZuPKvYP9ZZ2mhb4m@pks.im>

 .gitlab-ci.yml             | 3 +++
 ci/install-dependencies.sh | 5 +++++
 ci/lib.sh                  | 9 ++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2589098eff7..80b1668ebeb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,9 @@ test:linux:
       fi
   parallel:
     matrix:
+      - jobname: linux-old
+        image: ubuntu:16.04
+        CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 735ee6f4639..08656a15308 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -55,6 +55,11 @@ ubuntu-*|ubuntu32-*)
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
+	ubuntu-16.04)
+		# Does not support JGit, but we also don't really care about
+		# the others. We rather care whether Git still compiles and
+		# runs fine overall.
+		;;
 	ubuntu-*)
 		mkdir --parents "$CUSTOM_PATH"
 
diff --git a/ci/lib.sh b/ci/lib.sh
index 51f8f59a296..74b430be238 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -336,7 +336,14 @@ ubuntu-*)
 	fi
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
-	export GIT_TEST_HTTPD=true
+	case "$distro" in
+	ubuntu-16.04)
+		# Apache is too old for HTTP/2.
+		;;
+	*)
+		export GIT_TEST_HTTPD=true
+		;;
+	esac
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever

base-commit: f33406dbcc16e699be71aa4982133c325838ae1b
-- 
2.46.0.551.gc5ee8f2d1c.dirty

