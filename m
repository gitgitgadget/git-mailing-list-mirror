Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF464D6C27
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545565; cv=none; b=I0v0czk/N/SlLF7fIC4LAyLpaCFJQNmkt4PABIeF0XK1jVsuvJJUPU21M0+WOX5fslM4o01Tfl+BHDTzICPJvNqaVJLfYXkSi0mvNZgDpJytmnbh4pfyVSvSYg4UygzOQHdj4eD6bBESNYEG9NYosM5PSnwUF3pVD6WIImlyr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545565; c=relaxed/simple;
	bh=EIfDrVsQXKaHDY+JQGxbFglyU1FDXFH/oOtcJ/Fyo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucCKm6UnZt9yz6kcShdm+bgZJkKTcfNRXj4ClUso6k5tcqxfB6zpkRvElukTleNIZduGSWeSckkyOXWXf4rSphFiWDkHcvyhuCU/FfNgwnF3e8loav5pkxTMs4fpv+cB8yD9PoN0s+ZmttGYZxIchuh/niWNqZCygElXdNrvs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DWqUYgCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKFSXMnR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DWqUYgCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKFSXMnR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1E781400082
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 07:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545550;
	 x=1791631950; bh=91Ia1odWJz23A0JLkNBPc8/K/ZOlH0WanxQVoUC124I=; b=
	DWqUYgCDC5WA7230SmDniQhhS6XLcDdMnuEZYTxAvOwcqJWOIB7/Gu883/pvrll7
	HfgI8/Q/yue5dv9QGCBLBIh9UdTY5GcBC208WJpdh2pzBaLh2Ol/uikOtJPMt5Le
	XGHxxdEMMl8lG0HXm1+0OvzkokNXaZ4IhCO6zPS15mq90WvJor2Hd6hxtn58SO9z
	Fxeb2xFK6s6iLMhv1oGcqXYKn9fmn8jtCf9ODv1ZGh1Hzxn8Gd3ARnUvM/7w86WU
	ADzpqoV5nuvVmITSYSU4arDczgO5tTG1zAgBKdqEO7xaM3HIy+j6GRL1wqtWAgC2
	dG6157dOc/9w/y8ZNff8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545550; x=
	1791631950; bh=91Ia1odWJz23A0JLkNBPc8/K/ZOlH0WanxQVoUC124I=; b=F
	KFSXMnR3dyC4zrFN67MRhZfvfo8dIjvWHO+SpZ+pQL02fSvWTguclUJS9JvRTS9b
	ehl47mJdBsQD4nQWTHBYqHkhqP+JUb7Td0vSrwTnMf9FVaozYStT63LSAX1ZfDGm
	Wdu9JGfybsfv9ueEaPJODchrlcXHuZ9H+upoVG76GUd3hWwXA4KrQLj6LOSNvZwt
	woHFmtwFONLYuIgRohCuV6NkhMRFediiRRAGG4igZe/vjYvqWhhSYzHrOUE8+ZbX
	YLsDW1UhWcWCcVbMBagV7pxwMpfsCWGPCYt8XNYnZpAAk06ANo1lQHeDM5NPtjTN
	0KReIOh2pBUzd9kVTQqLQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545550; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:A6epyn3LfGC6QrUIg/zkp+EddmJEB2bVZcd+mpvmHCnGwFG
	xtLcoo9seV2cNDrzLyjfnEv5aZPDR68XPIUnpKLxg0wq6eoAGvgaJ9oaCOy/il1y
	EAUaaDHB2rQoXtN8vrkXCzrGbej2RY7Hr9tvnIN8wiqlW7FY5uFIgLnNDpkjzcf2
	AoOIbIcp+8TR9O6b7WneHRCj3iFMgYpDVd0tylhMbuTcYVpozGiCGK5suhUXeezG
	qjSXgMc5l5/ieSeDyvqRnus7aBh1G7YO93jNlNoQEezCAkJrakfkRom7YpoHm9Zj
	dMWrHXidt4uyJIYYMlcU4qlWkA1wnx0pzjTlx+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DCAEQvtYKTpt+zFUujXknOJMzRr5jNNtDeUG/MbzMl0=:EIfDrVsQXKaHDY+JQGxbFglyU1FDXFH/oOtcJ/Fyo1E=;
X-ME-Sender: <xms:ztDIanZVjl0-rfwFJYZJBdWrNDFp4nUeKKpvDGEiV9YwVwGCgYOnKA>
    <xme:ztDIatYnWTbT8FJCyNnWF1srkO83xloYkrHkMwdfaeGCvpQd9DuQVEW78XZqyjeKL
    yT3t9FAGFadWB7i9OlQjYq1cez9OKEFncBPI9wiQzAm4mreRxHRTA>
X-ME-Received: <xmr:ztDIau9H8vjmtc2zpbvFBWMv3nd2sJrpWUkRwNFMA8jaX7j9lYXf2TuMhYQnoV374xRWtQ>
X-ME-Proxy-Cause: dmFkZTGIFXcvy6JwZG2U3q2+0b186kihLyHUse9rty+Cn42lRxVENfm4OSYJ5wo7Esv6v2
    TTyuw6uIqsk9ZdmXZF8qUgJT765hbrwksT5zu2zPOOg8nnrn96/M33cJcIrd94VtMsNb6J
    /7UQlKOfZCHNXW8IBaiuRjBawZRQvnFweZrD7P7DOOZeLsfMTNbur2fiPgL9ncWS3PtUKL
    8AGJt0goX3+ROv3YqKAed9NMrmoUhKcPKL/T8TBN7Zx3d5Ic/+sycNiBOBo0z29IIpjIac
    YxzJoOUp1/2OK4FXnM2w+XJ09NzNwGxe/+3Bu9kT81q0QWwuqrAzRMYlHXT3HXFUXYaFWf
    c2aZ8/pjlIF/GKYd5rKsZf1lhgyB9ClkOGW44Fx35qD20jUjNKNHFtNWqap32PNThoNRxt
    9r4P7aRXjsKUcLrR9DuLPwGf9r5Jbcv1tbQ8Kzk0rpS5nqlqxvOoCTtER0/K54KkqiNHrZ
    DRXCFsC6Tzf8fl01rA/Wjghr63wxV3bYbMeyKfi7J+Vk0RG131qL2itEudfEN+rSkORQTt
    QJO94P7rSMqJmLDr6KeYmrC8q9z8zJcIY3O8ThZYq+r2yDnlY0IO/GMok1i2+uOr9IN+9y
    K5UVNszkDGmysIOR6eOb8LcTyGtAkScpdOIIIMI1dzzLClAZPTfF/qTFya1w
X-ME-Proxy: <xmx:ztDIashoPRezjZ7GGQv6Sk127KW04adopdZhuTrgjvhFp8TSY0oFOw>
    <xmx:ztDIaueC6sYnCuinK1a2T4AFDwmfHeUZFG3iNu1AMUNjILJPg1SBKg>
    <xmx:ztDIajqU_7D_WkA7FzuYVAwLFsDOHM_TsMptqR3kvl9gVhhvkLps7Q>
    <xmx:ztDIajBMYXWHY2E648PWsUPq4NOrn713Yif-5LlLsbkhnNuwLH1eFA>
    <xmx:ztDIap4sFXH01oHEjAopA4FuA7QltHy6Z8pR7IbASxeiDACCo4RRvP7f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bceecb96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:04 +0200
Subject: [PATCH v2 7/8] ci: drop now-dead Python 2 coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-7-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
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
2.56.0.170.g584c36229d.dirty

