Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF8204567
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697390; cv=none; b=q1CDHohsMkVT2p3z7JbZsk35+FR8+PlalqbAONd3d0QCJtrbcXHuDLwx7T0RkFmRLcmHBWHaEEwHakPyHad3oa4yXK82isjCLH9C0go3ugQ6D3oAXJTdCs5zEGWURcCWNWr7SI2Dt4cvwlVgOJYuCfaehm9TQXIxxNLQd0/S4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697390; c=relaxed/simple;
	bh=31bIg9TG/JR5p3GesVhqk5OWPcJIH/92Tm5wj268XYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhXs4qFDt0UzSAbAvGteXWuwHHhzRQpYZ/mjgdwrgyyEUGORa8le4jkFsPz/m76a9OgTq+rf4at6Tr9VNh6FnfBKxkZW3d7bUIFwEOLVeaqgtGrCWNiJCy/WkJQV0zql5e5LdYwx086kOuOETbqUSHoxysTSFNCs5pbdR5jXId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0GcHjgAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnDk1oq9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0GcHjgAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnDk1oq9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B596C11401ED;
	Fri, 20 Dec 2024 07:23:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 20 Dec 2024 07:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697387;
	 x=1734783787; bh=BNtQCVhf6XM4IT5IA75ojY7FtTwIIEV7kGA1nQ0uvhg=; b=
	0GcHjgAMKM/g6Z5Vz4jYqJQsZW9SyXFtmqWYXqn5WeyeURMazFUjVVXlewqeNthu
	7etlu+2vUvAt5bRqWRYHmiaJbhMctUedUk/1OjGM5aI1quEJDszBxs7jyBhv7Zij
	pLds/cAa69ToTlHH+N56CmfUG9sXXhqawHdYt3pojZswwMCUBtUWtkQ6nfO0oITP
	33/GOYN25E9uNxyWapWEuftafDLwzi1rfV+LB2MHeU/EIUc5ekXNKD6Yut6aeoYH
	+gUJ93/5469s+buZlFgcyHq6nLZ2PbhPH014zWzyXvrJpimHXGrPC7wTHc14xtdD
	aEAEZZAPHn/41PNWRQshhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697387; x=
	1734783787; bh=BNtQCVhf6XM4IT5IA75ojY7FtTwIIEV7kGA1nQ0uvhg=; b=h
	nDk1oq9rT/1wMnPJ4zl4AIg2hindsRgX/KmfHxTII70KV16ytkM5fie7J4W2FCSE
	2G8uM49+ckveu855lEsT7QY/XmbKzHyGwbXAexH19i8gM3KxuV2/T6msWuM0IsNn
	Qw5csibhjmZ+CLmS4JzBKzp8PhKmpdiGy5rXByZ5kRgxdhBhYUF4aUDd91NAYTmE
	SzHOKmM6/RQXToQSiTq/9YPRuksAfaDp12ciELjzoHQl8HNLpd95UIcOafHK6Qci
	aI8oG7E2zROH9q9T0cr2Z7RT4H4QHXzFM5eH2VKDSXQSe8VUOzm1xMcjdTGjyjm+
	BRGTRWTzX9RzfLR270d2g==
X-ME-Sender: <xms:q2FlZ1QlVwRfT5X9i0XfNcbbhvUTVmPoKzceybSsELvkJBsQOJJerA>
    <xme:q2FlZ-x4Cq6vhpcY6wdko1SHeCDWpNYUI5F-4wyM3oPMeE2Q8WUmJlUrUqw4Aiqtf
    owGXY0VfiaS3fKrxQ>
X-ME-Received: <xmr:q2FlZ63cCZzm3RSec3O1UNpDR4iQENzW8pF37gtoVfgITnb3SJs_YrM9yaIEyPUmoUugCpspUewVYXQdOGfOvUohVo--zTguIg8-rd-T3OuBE_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q2FlZ9DP1QZ4Yg4yA_V4LctmBrGr8-qmGj3pw0zUIUfsSNHkK5SfJg>
    <xmx:q2FlZ-gfwjHQIjrNiDTaAwBr7ba6Epm2KK5YDbGMnXg70CvfVlozzw>
    <xmx:q2FlZxqiGLNRmSe6xQnjh-XVdcbsmshEJxl__zkckFzVM1oeOqht8w>
    <xmx:q2FlZ5jytdE25fPxroMIf9HL1b-2Q67Q0Rgt7PlopneE8tZy1ZkE7Q>
    <xmx:q2FlZ2c8CtfMcU8f1W9MLVzsSEtMeLuJ27da8g98UxX7nMmiiuBH0qxR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7734b51f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 13:22:45 +0100
Subject: [PATCH v2 1/5] GIT-VERSION-GEN: fix overriding version via
 environment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

GIT-VERSION-GEN tries to derive the version that Git is being built from
via multiple different sources in the following order:

  1. A file called "version" in the source tree's root directory, if it
     exists.

  2. The current commit in case Git is built from a Git repository.

  3. Otherwise, we use a fallback version stored in a variable which is
     bumped whenever a new Git version is getting tagged.

It used to be possible to override the version by overriding the
`GIT_VERSION` Makefile variable (e.g. `make GIT_VERSION=foo`). This
worked somewhat by chance, only: `GIT-VERSION-GEN` would write the
actual Git version into `GIT-VERSION-FILE`, not the overridden value,
but when including the file into our Makefile we would not override the
`GIT_VERSION` variable because it has already been set by the user. And
because our Makefile used the variable to propagate the version to our
build tools instead of using `GIT-VERSION-FILE` the resulting build
artifacts used the overridden version.

But that subtle mechanism broke with 4838deab65 (Makefile: refactor
GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits
because the version information is not propagated via the Makefile
variable anymore, but instead via the files that `GIT-VERSION-GEN`
started to write. And as the script never knew about the `GIT_VERSION`
environment variable in the first place it uses one of the values listed
above instead of the overridden value.

Fix this issue by making `GIT-VERSION-GEN` handle the case where
`GIT_VERSION` has been set via the environment.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index de0e63bdfbac263884e2ea328cc2ef11ace7a238..27f9d6a81f77248c652649ae21d0ec51b8f2d247 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
 
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
-if test -f "$SOURCE_DIR"/version
+if test -n "$GIT_VERSION"
+then
+    VN="$GIT_VERSION"
+elif test -f "$SOURCE_DIR"/version
 then
 	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
 elif {
@@ -51,7 +54,13 @@ else
 	VN="$DEF_VER"
 fi
 
-GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
+# Only strip leading `v` in case we have derived VN manually. Otherwise we
+# retain whatever the user has set in their environment.
+if test -z "$GIT_VERSION"
+then
+    GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
+fi
+
 GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
 GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
 if test -z "$GIT_USER_AGENT"

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

