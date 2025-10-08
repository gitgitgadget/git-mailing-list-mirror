Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157F2B9A8
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924170; cv=none; b=GsEi5LO8Hp+5B2gqf51DhGTsm0aWanG+wlXr6DLWSFHb1xmeX1t3+PUNYUObwah9bp2bV2LL1mKe1A1xSR+HAemXF4QQGXT43qiY1Y0nAJEw7RJdnVbzVKnUpSXJ1Wx1StBIQ4FTBbSD/QCVi6h5Gm8CRCyMZq6Z70LNcElhYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924170; c=relaxed/simple;
	bh=ZZUv/ELZNv8xOO0DBAFPDCs4tJYUnygMuYc0gALR/gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQVtR8nROZXGDTXCow/PS/AKrctYjCTu0pHLIPBQ3kMmR3UWUSL6UMkxCj9DM5zOt3WInufMVgrSiDlW1dr38fkv5ypCYKe/6NYvzv0I9l4XfOgFXQM5Ux3TzLIHJGqL/ej0yITIghlJEeOrFwXeG5kxZFlRD5A83pCbvPZ8xeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nSmOvRLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYgy9ym7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nSmOvRLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYgy9ym7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 506421D005DF;
	Wed,  8 Oct 2025 07:49:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1759924167; x=1760010567; bh=5e
	Lh9JyMzcjVog4F1b5hf2zVHEFTw9904W2ThE6nuj8=; b=nSmOvRLCjXcimjjOd6
	hKiA8r0MIbxDpqmbq2KzDVRpD81XjUomPian7V8Yey0maaVCBBvTa7MTiXj/+iiH
	GQTMBiyKEtowj4xBrrBcTFr5e+0+22Ongd/6a4jExZTyhT5E60cJju3LAcXCtanV
	xxEsmJ9BtI47zSATqBjb5eS7AVG7GJYqY99l7aiJAe46PgdBGyBUa3Dzd4Ce5AdA
	L13vSGVnRsqdFoJGsoZMjVd7qohxC4CBaDQiBvWgKfuKWW/li6eIjfrBpiy1+iWO
	ncrTUc7GJYrAJdumIXODyCDhSZTWFxDBtm6vKvOXjtJ5w5teJDaNJJPaZZvIIq6T
	RGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759924167; x=1760010567; bh=5eLh9JyMzcjVog4F1b5hf2zVHEFT
	w9904W2ThE6nuj8=; b=lYgy9ym7GeTcuNP6gODnvCd6Cs/DQgwwFHv1RF2lRXyx
	v7maBlhMpMwpDaTJSdvVh7qVYdim4q3vo4sDtnyCDiQNWx7ShzHS7joUagLm+qhG
	Bq9W7LDL6fdw1C1kyZ6c6oBqDT1O3tGTz90ZaKgI68yOYNvuITunYxESfP4ROysX
	rfRBEM8WE3QcDlwDgIA+p7xrhp4GyRiPMDb5vz/VLhJbI0jbAdzohvzG7Q4FC7t3
	ZZdgOxC+8DYEFIGFcMeB+1mjeyz+El6i/DGfNxeFRlKv2Hpx8PJcMsGiQ+f61lic
	Y7ByHDBUfrnbMzoOTIgjpASqEh93Lb8tUWTDutRSpg==
X-ME-Sender: <xms:xk_maLAaji6yDcIB5kB3mK_cez22PCwOfc7XqYr2itNpObFBnsTiznM>
    <xme:xk_maHgcT5HGh2FdvQEnvl4ynlxSjVxR6Ev-dYupSTpT4K5UT1IUCGOi8cYn7jVYV
    M6Y_XdEFe7Ci_jjnqmLhjBi0RlknhnjdvOL4KGXTaofXvzwd1OopQ>
X-ME-Received: <xmr:xk_maEPlK3Vom3ua2PxA9_Ns1vD20t_KAu-oDaoJ-ad1k5v8RTL5WKkKJhxzIzCGSmK_oFWtqDYkBLRJ3jQmiKoPEdJ8OHo5m_GPfK1WZfXMg59QKBuKVw-20Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekgidtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnhepffffheetgeekfeeijeffveekheefhfetud
    eugffgheekfeekuefgvdehudekjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:xk_maI4YSe_e0vPm_VuyBbVRNf6YWOGhFmOg-7mfy7QBaOiMhh8Uug>
    <xmx:xk_maC2G3T4XvKz4SnI74D7Kklrex7szFB931F3Z4D3SPFBabVJTxA>
    <xmx:xk_maJZ68h_QOI8grl47a_1B0IqDDTJE-i-OceTujjuR0Ecetvry7g>
    <xmx:xk_maKCoPWYfnSbtngcdMnINTHTW-KY4o8svwWxz73FQCIi3URYshg>
    <xmx:x0_maOZA9srE9pRSM_HkKakaEuJrcULG9qiW4TCEhGYdrZ6bZQSIte8y>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 07:49:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: fix accidental literal blocks
Date: Wed,  8 Oct 2025 13:48:46 +0200
Message-ID: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Make sure that normal paragraphs in most user-facing docs[1] don’t
use literal blocks. This can easily happen if you try to maintain
indentation in order to continue a block; that might work in
e.g. Markdown variants, but not in AsciiDoc.

The fixes are straightforward, i.e. just deindent the block and maybe
add line continuations. The only exception is git-sparse-checkout(1)
where we also replace indentation used for *intended* literal blocks
with `----`.

† 1: These have not been considered:
     • `Documentation/howto/`
     • `Documentation/technical/`
     • `Documentation/gitprotocol*`

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I have noticed and sent patches for these things in the past because I
    randomly spotted them, more or less.  This time though I have tried to
    go through the docs and actively look for them.  These should be the
    only ones if my hunting approach was sound.
    
    About not considering those other docs:
    
    In general, the *technical* documentation has worse HTML output than the
    more user-facing docs, to the point where it looks like they might not
    have been written with output formats/publishing in mind. So there might
    not be a point to fixing them.
    
    I could have fixed one paragraph in gitprotocol-v2 but then that raises
    the question of what about the other paragraphs? That in turn made the
    commit message too long just for that point so I dropped it.

 Documentation/config/core.adoc         |  4 +-
 Documentation/git-config.adoc          | 18 +++----
 Documentation/git-rev-parse.adoc       | 14 ++---
 Documentation/git-shortlog.adoc        |  4 +-
 Documentation/git-sparse-checkout.adoc | 72 ++++++++++++++++----------
 5 files changed, 64 insertions(+), 48 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 3fbe83eef16..8866ed27714 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -75,8 +75,8 @@ The built-in file system monitor is currently available only on a
 limited set of supported platforms.  Currently, this includes Windows
 and MacOS.
 +
-	Otherwise, this variable contains the pathname of the "fsmonitor"
-	hook command.
+Otherwise, this variable contains the pathname of the "fsmonitor"
+hook command.
 +
 This hook command is used to identify all files that may have changed
 since the requested date/time. This information is used to speed up
diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 511b2e26bfb..a633ab8ec3a 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -117,15 +117,15 @@ OPTIONS
 
 --comment <message>::
 	Append a comment at the end of new or modified lines.
-
-	If _<message>_ begins with one or more whitespaces followed
-	by "#", it is used as-is.  If it begins with "#", a space is
-	prepended before it is used.  Otherwise, a string " # " (a
-	space followed by a hash followed by a space) is prepended
-	to it.  And the resulting string is placed immediately after
-	the value defined for the variable.  The _<message>_ must
-	not contain linefeed characters (no multi-line comments are
-	permitted).
++
+If _<message>_ begins with one or more whitespaces followed
+by "#", it is used as-is.  If it begins with "#", a space is
+prepended before it is used.  Otherwise, a string " # " (a
+space followed by a hash followed by a space) is prepended
+to it.  And the resulting string is placed immediately after
+the value defined for the variable.  The _<message>_ must
+not contain linefeed characters (no multi-line comments are
+permitted).
 
 --all::
 	With `get`, return all values for a multi-valued key.
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index cc32b4b4f0f..18383e52af7 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -174,13 +174,13 @@ for another option.
 
 	Allow oids to be input from any object format that the current
 	repository supports.
-
-	Specifying "sha1" translates if necessary and returns a sha1 oid.
-
-	Specifying "sha256" translates if necessary and returns a sha256 oid.
-
-	Specifying "storage" translates if necessary and returns an oid in
-	encoded in the storage hash algorithm.
++
+Specifying "sha1" translates if necessary and returns a sha1 oid.
++
+Specifying "sha256" translates if necessary and returns a sha256 oid.
++
+Specifying "storage" translates if necessary and returns an oid in
+encoded in the storage hash algorithm.
 
 Options for Objects
 ~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/git-shortlog.adoc b/Documentation/git-shortlog.adoc
index d8ab38dcc1f..aa92800c69c 100644
--- a/Documentation/git-shortlog.adoc
+++ b/Documentation/git-shortlog.adoc
@@ -44,8 +44,8 @@ OPTIONS
 	describe each commit.  '<format>' can be any string accepted
 	by the `--format` option of 'git log', such as '* [%h] %s'.
 	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
-
-	Each pretty-printed commit will be rewrapped before it is shown.
++
+Each pretty-printed commit will be rewrapped before it is shown.
 
 --date=<format>::
 	Show dates formatted according to the given date string. (See
diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 529a8edd9c1..b5fe5da0416 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -264,34 +264,50 @@ patterns in non-cone mode has a number of shortcomings:
     inconsistent.
 
   * It has edge cases where the "right" behavior is unclear.  Two examples:
-
-    First, two users are in a subdirectory, and the first runs
-       git sparse-checkout set '/toplevel-dir/*.c'
-    while the second runs
-       git sparse-checkout set relative-dir
-    Should those arguments be transliterated into
-       current/subdirectory/toplevel-dir/*.c
-    and
-       current/subdirectory/relative-dir
-    before inserting into the sparse-checkout file?  The user who typed
-    the first command is probably aware that arguments to set/add are
-    supposed to be patterns in non-cone mode, and probably would not be
-    happy with such a transliteration.  However, many gitignore-style
-    patterns are just paths, which might be what the user who typed the
-    second command was thinking, and they'd be upset if their argument
-    wasn't transliterated.
-
-    Second, what should bash-completion complete on for set/add commands
-    for non-cone users?  If it suggests paths, is it exacerbating the
-    problem above?  Also, if it suggests paths, what if the user has a
-    file or directory that begins with either a '!' or '#' or has a '*',
-    '\', '?', '[', or ']' in its name?  And if it suggests paths, will
-    it complete "/pro" to "/proc" (in the root filesystem) rather than to
-    "/progress.txt" in the current directory?  (Note that users are
-    likely to want to start paths with a leading '/' in non-cone mode,
-    for the same reason that .gitignore files often have one.)
-    Completing on files or directories might give nasty surprises in
-    all these cases.
++
+First, two users are in a subdirectory, and the first runs
++
+----
+git sparse-checkout set '/toplevel-dir/*.c'
+----
++
+while the second runs
++
+----
+git sparse-checkout set relative-dir
+----
++
+Should those arguments be transliterated into
++
+----
+current/subdirectory/toplevel-dir/*.c
+----
++
+and
++
+----
+current/subdirectory/relative-dir
+----
++
+before inserting into the sparse-checkout file?  The user who typed
+the first command is probably aware that arguments to set/add are
+supposed to be patterns in non-cone mode, and probably would not be
+happy with such a transliteration.  However, many gitignore-style
+patterns are just paths, which might be what the user who typed the
+second command was thinking, and they'd be upset if their argument
+wasn't transliterated.
++
+Second, what should bash-completion complete on for set/add commands
+for non-cone users?  If it suggests paths, is it exacerbating the
+problem above?  Also, if it suggests paths, what if the user has a
+file or directory that begins with either a '!' or '#' or has a '*',
+'\', '?', '[', or ']' in its name?  And if it suggests paths, will
+it complete "/pro" to "/proc" (in the root filesystem) rather than to
+"/progress.txt" in the current directory?  (Note that users are
+likely to want to start paths with a leading '/' in non-cone mode,
+for the same reason that .gitignore files often have one.)
+Completing on files or directories might give nasty surprises in
+all these cases.
 
   * The excessive flexibility made other extensions essentially
     impractical.  `--sparse-index` is likely impossible in non-cone

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.352.g356bc2d8d49

