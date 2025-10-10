Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889F27F171
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089109; cv=none; b=Qq/tbPn0oGcVBaAhIje/w8FoER3K4MNCrVr0vufMp7YDlOvmMB3cQK5UFEXbydHZMcTK9lMs7zxcJIy58KKW4yiLQm5p6j4MWFJpqhDxxMROkljc7iAeHm4d+I/TvAe5M9ZRDguA5Pbxpatg0e1VmPNm0YvuVSfoUI2fO1mkdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089109; c=relaxed/simple;
	bh=7U82a9eIlxmRY37aVV23gqFh54vooqR01Kiqa8fNeBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxIIOyUvIRF/6LAmNw0oSCv0aWypz0ABPvihW/zuwN6w7WuJHMiz9/872kYdpdvsBfAhcy1/p/tvIFd25GTf42U++nZfbIcYh8bWb9tv5oT3rJVo6HiVPMhsZr5/6YHe3lNbxk2f1np4XRsBYEhDUe30WPw4gzjr55ZsFghrMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nCr9w+A9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/qlgNbR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nCr9w+A9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/qlgNbR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 29B151D0007E;
	Fri, 10 Oct 2025 05:38:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 05:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760089095;
	 x=1760175495; bh=NY1g3P19ytJkk6DPLyR48C/DIbOoHhqSpAv6pSVKLfw=; b=
	nCr9w+A9yMCJXFWQh2zUvNxVcDqodKlt9YhphoD+F9ogQtDq/3jwRg+M+cri+gpj
	4ApbUVAouXfiJkkt0Txv4nPZr4gEHLhItlZiHXoWuU/r2M283GR+rs06wM9tGhym
	jFsh5gpu0+Qf6hpprowSRsPt6vAzoy6T9Kjd+MEvYRuEaEsGdH7ngw7zasGGn/jz
	Mo/qpGiTZfMGFAbTXd402LG1nQ7e4at+HBBjGPKPpJG8FaZ74HofBMnPeVeJVKjR
	0GpZ9L9rvYLWoILgINwS9qts197yqpqGqpwLbskjCLZzh7bX0s4L3zTdr0q+jD3U
	OfqxjmzpLDNj87QeVIkDZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760089095; x=
	1760175495; bh=NY1g3P19ytJkk6DPLyR48C/DIbOoHhqSpAv6pSVKLfw=; b=J
	/qlgNbRHSnBQKlaaVHV2uViI/09VbknjvG+eDAjSibNQG1GQ2aofws5teic2t3DE
	9jug6k/qFETYqFrSSSuuxSsS8cK+B+zyzC3MwnLR1tf4TbCD2a+MvnlhxbnlrHbf
	cRKKrtMp93rJSJzQEZWsHSEge5reTJ4wUYNVDJCPylBXcxBzoE84xD71gIPgUPXh
	YsaZZtWszQxKS82AD/lkkBC47VLqhoLixrsRY31iY5LkoEPcbb2n8IOBOQ8hgTDQ
	UBKhdgnNIvl3c8pZnkI7avAFW+2Ova2Dbs3LYVBEV8e9xCRuin07jbqyq+rRWcLX
	CpTjheq4CO0gcMv7od5IA==
X-ME-Sender: <xms:BtToaAuN_rGzbqBOVDEmPqjLTYQUo0sxLf-Vxrj-o__AdQoN8YyYmnk>
    <xme:BtToaE7nD77h123kZemGLcAs79mG38yVdIa59cNdRfZRVZvZsQjHzv13ebUkWYykA
    o-fVmquk6ZOzzu2auPrbgcq6_DUkBZl0MzOGVjISMptNK9l-gWaEw>
X-ME-Received: <xmr:BtToaJKY-0q8zMMQsiEx5pWUQ8892IHhKAp6FVy4uuSVto7gXP0ZBI8YYLen-C3N-7iQgpmA6DdIm9lMo0cIX7bVBiRfUMvHQvnZ9Z-u7EemUVSSrHHX_NoJzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetie
    ehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvth
X-ME-Proxy: <xmx:BtToaM6llSNgKPkyOVbZOB0DGGdQWG9xaDWbemchnDMfcIVp8eKf3w>
    <xmx:BtToaEwo-IHRH8pG-_VHpnQLKzLiwSLMI7cfXZ594RNLXe9ruS0_Sg>
    <xmx:BtToaIbxfmNhY3I_BDU0wjZ7gNuDisxA2B56l_eMXmR6b57iyZpguA>
    <xmx:BtToaORDZrNNumY6U4PVc7JgXN2zH_5hM6X1SJ0xv0p3YmPo9ez-8w>
    <xmx:B9ToaFqiR_SMxH8JNlnSjFKKZ-vM0gyM6XBrZdxbUo9XyE1T0C15NwIB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 05:38:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2] doc: fix accidental literal blocks
Date: Fri, 10 Oct 2025 11:37:27 +0200
Message-ID: <v2-619841a5663.1760088970.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
In-Reply-To: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>
References: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>
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

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    • Add ack
    
    § Cover letter text
    
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

Interdiff against v1:

Range-diff against v1:
1:  7a955ecb1b5 ! 1:  619841a5663 doc: fix accidental literal blocks
    @@ Commit message
              • `Documentation/technical/`
              • `Documentation/gitprotocol*`
     
    +    Acked-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v2:
    +
    +    • Add ack
    +
    +    § Cover letter text
    +
         I have noticed and sent patches for these things in the past because I
         randomly spotted them, more or less.  This time though I have tried to
         go through the docs and actively look for them.  These should be the

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.352.g356bc2d8d49

