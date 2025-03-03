Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF323A98E
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034703; cv=none; b=QQdNNwkZVN3wdu6DZE0WL0eKC6O4dNiugodeaLKrlCmIkDhzjP3hWcaui6jIF4673X1yOk93PSazIRn6jW4dlKjjwPXHQY3Il8VGuIiszOjeT1jYYCJ7SxlF0nX+rD3PSojfAEoHyEY/tWvG/zl+lnAiieZyrXBtmeg0GJ6m6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034703; c=relaxed/simple;
	bh=tI0KnyJSQceN3wDcgQcU5dNRL/cniylIRMlzvhGH1yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIBPI4JOQFZYfDMyBKKBX0uKUWY2MzNSv6XyKFzHsHXRZeaT5hmYRydvfpQ/9BSjvd37Vt2SGZGtirXvj94CijECrtYErKuqHD6UoZ92SA3kGlrmbe8sT02duRq6Z1iKgNQJehXFjGS5/TRuh6ic0ET0PMFaM7l0V2irfiCzhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N34i+rrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wzjCUQIE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N34i+rrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wzjCUQIE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 514341382C59;
	Mon,  3 Mar 2025 15:45:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034701; x=
	1741121101; bh=jLzGAjztgaWWNtE9aPjwsN8cZIGe7hbUzN6xL6b+e9g=; b=N
	34i+rrJpTJhfn5vH3jwot7hLQmHgsE8XXF4/Ndv9DQCm1o0u4u1rt/HnZcGcBoU+
	+Ygt6GD0HrJd0a6qpX+CTXiRMq5TChx9Kn7oiC5hXvI5W/z5W4HizimB+LR0XsRH
	SxT6E9L0lh4llqcb4btRCyJeM+JGUBBSardLz002e+KxDaV4HKBILCwg+v1Vgd4V
	BG4+NRbEsJHUa9EB3eqoje5CtJthFOgH5AWDvr9Q6/Eve1NvbQ+3OIffZkqGMOKk
	IfBbk05zfcZp6F4qy55hsf5Dbi9k6m3N6vpOSIhE7ynWuW+hFDDbzY6ojuEkJ6FG
	7WwCYUQofRzzR2OdCbhSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034701; x=1741121101; bh=j
	LzGAjztgaWWNtE9aPjwsN8cZIGe7hbUzN6xL6b+e9g=; b=wzjCUQIEjh9aWIcla
	V/zRlVhIu8qxEhoLqd/c5LjEiyqN4pVq0/1lRfkpOaifRIqap2k7FNL6T07BDBz8
	jE5rXT6kctCBjs1y2qiXSuGyhi86x6go0zK2EGIB/OtkAyPHDXoXXB7isDnWm2Nz
	YsaGFHPGapGsPMCXjzGJNW6rqesH291rewpKNF8wMpPnOHNI7rvf0yrjAck1q4sx
	mEeunOn2rxOSkWHGLdkNBb1ho0SqfxDDaom7JqdXCXJTChJmmOmOt0JqFWlewh+b
	0HNQ9+I3IIFivtCOMQNOoDCCc7q9RRBGBXI6/D8VF8cpefuY0dVRCvD8TnnupkRm
	1T0gQ==
X-ME-Sender: <xms:zRTGZ2Sx1nsEMy3yRUb5tu528QI4tXcWC8DhNFxrVAjA3YIs47Tm6g>
    <xme:zRTGZ7x77yV0rAfU6Mby3KZxbIdeVPxXE1ezs2ypj9up8O-QYz6QCIh5k86QMlHMz
    Vz4STGeGNwHUAKifw>
X-ME-Received: <xmr:zRTGZz3v0mCuF1QSfhW3LxWUAohbhX8U86aNsOAFcfNzcmDXb5-Wc2tfuCm7PlKUEgXFwHVegPSJ4IIfSFpExAndjI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zRTGZyAX4HPJ4lXR3tEiNFHD1dh8Sgy2fTPi2Tvh5wN_77BW2SYnXA>
    <xmx:zRTGZ_hc9PgRmjObO5owKHXPX2dMvDnGnhjXbfTvJ3LReha09Ijdkg>
    <xmx:zRTGZ-oBGdGwaO-ZEYaFZlmq99sK6026zjEMXLKmM6axFLs1FnyeOA>
    <xmx:zRTGZyies6F_7VrOsSeBGxutRmX4YoYHkAp02i-0ptHyVg3T18KSeg>
    <xmx:zRTGZ8v64_4XSEB0kvIzPNAUWTv4tDbVpnD-nbth5sBZDevZ-SIR6cnY>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:00 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 11/34] doc: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:09 -0500
Message-ID: <20250303204443.360595-12-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update a few more instances of Documentation/*.txt files which have been
renamed to *.adoc.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/gitattributes.adoc                      | 6 +++---
 Documentation/technical/api-simple-ipc.adoc           | 2 +-
 Documentation/technical/hash-function-transition.adoc | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 7eaca89972..a22d1ef1e1 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -513,7 +513,7 @@ If the filter command (a string value) is defined via
 `filter.<driver>.process` then Git can process all blobs with a
 single filter invocation for the entire life of a single Git
 command. This is achieved by using the long-running process protocol
-(described in technical/long-running-process-protocol.txt).
+(described in Documentation/technical/long-running-process-protocol.adoc).
 
 When Git encounters the first file that needs to be cleaned or smudged,
 it starts the filter and performs the handshake. In the handshake, the
@@ -1177,11 +1177,11 @@ integer has a meaningful effect.
 
 For example, this line in `.gitattributes` can be used to tell the merge
 machinery to leave much longer (instead of the usual 7-character-long)
-conflict markers when merging the file `Documentation/git-merge.txt`
+conflict markers when merging the file `Documentation/git-merge.adoc`
 results in a conflict.
 
 ------------------------
-Documentation/git-merge.txt	conflict-marker-size=32
+Documentation/git-merge.adoc	conflict-marker-size=32
 ------------------------
 
 
diff --git a/Documentation/technical/api-simple-ipc.adoc b/Documentation/technical/api-simple-ipc.adoc
index c4fb152b23..972178b042 100644
--- a/Documentation/technical/api-simple-ipc.adoc
+++ b/Documentation/technical/api-simple-ipc.adoc
@@ -36,7 +36,7 @@ Comparison with sub-process model
 ---------------------------------
 
 The Simple-IPC mechanism differs from the existing `sub-process.c`
-model (Documentation/technical/long-running-process-protocol.txt) and
+model (Documentation/technical/long-running-process-protocol.adoc) and
 used by applications like Git-LFS.  In the LFS-style sub-process model,
 the helper is started by the foreground process, communication happens
 via a pair of file descriptors bound to the stdin/stdout of the
diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index 7102c7c8f5..f047fd80ca 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -394,7 +394,7 @@ inflated again in step 3, for a total of two inflations.
 
 Step 4 is probably necessary for good read-time performance. "git
 pack-objects" on the server optimizes the pack file for good data
-locality (see Documentation/technical/pack-heuristics.txt).
+locality (see Documentation/technical/pack-heuristics.adoc).
 
 Details of this process are likely to change. It will take some
 experimenting to get this to perform well.
-- 
2.49.0.rc0

