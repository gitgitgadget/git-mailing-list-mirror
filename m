Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2930DEDE
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370153; cv=none; b=XGWRei935lcJRJOr63BcUJQs5mhNeECPWPIL64CPiqlq8fADC9msA+K36cQ/tP2CRwUGTYlsDAyG+lDBwHw7jQMAr4me8v3BqearSDkLAL9nfljz42ypVaP4A5ulp5sJhRjd9D5pgHaiPEPew2MgagiclZTqdHrL1wgEyAwvZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370153; c=relaxed/simple;
	bh=6RX61WnB3S98preIKxrBD2TbPXMS3jwLO1H2d/J5H8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phbRus3V29o4SvunEwbY0qWMBpl4mHmlG1zMY5UX6iQIYGQdqtJ2ObXWeV6sCgL7myOWVktUJXj5RKDg50cN8e1lEHbh01MveHmKWTi/jYDTqYP5d46apdVFApErOKBGU+2mgDYcalWWq4iOSA8LXzyl2Tano/2nUDf7HoUsYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z3Y/LfI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0rHtA2W; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z3Y/LfI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0rHtA2W"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A5F01D00344;
	Mon, 13 Oct 2025 11:42:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 13 Oct 2025 11:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760370150;
	 x=1760456550; bh=QQP4PVeSjyB7oMjNvbu7Cszje/R0/9gkRzgD+svXlgc=; b=
	Z3Y/LfI+fmZZJyJFN/xDwIDcgM3qzLBnQyJ4XHz/dB+RRcSEpnu+QWd6Q/ZQx0Yy
	eIFYXjxT+zjCm78MIPUNjXw7oDi3KvmPHAjgIfdKLaKxwHjLVHDawbIpDtIh8Pgx
	LX87zsjzpVjH6ar4SqcOe2P9v30jaGrfHtzrxiiWUyb0P8LDh2IjNlaqPxgDuZ1i
	p/yH3g3/pTyte9p2xkLDdDcJE2AulDVA61L9mth9FN+EPGNKGUf2nX9G0+F3W7oI
	6smdSpuP/o1ybzMkQm5Nlo+RUzVML9ML4HtzZfbNhyV/ETCmig95zrh8RMKpwdtI
	zFRIs3Z/BdvLfzIplYkzog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760370150; x=
	1760456550; bh=QQP4PVeSjyB7oMjNvbu7Cszje/R0/9gkRzgD+svXlgc=; b=x
	0rHtA2WB94zuZZUI5drniMLajvcYx5fz2d2jJWSJ7b5Mx+M7F+19I7zTDZyuSpqs
	A2e2b6+iHYmADSSPiFxkavlKb51eDcXXXCyQei+f8ruWL0t8uQ5CON2939XdnMlS
	ugqSdt36PUliskfz+SsSXkbebrYbGs8zrik9/zh1jqX2uWKNTHM8+gyBnqrN/fum
	gTzj5sih/H8ivPkINvBzqf4Sg1jFbcb8wIWLv3MfcALI/KZemDOgP76cC7wGfOoA
	Jgzu68MBYaP4wMYVKKJLvqp9Ja4PEXzNZNXxfYNIGEy8LZjGizLER5r+OFIKVZh2
	BR9oec4suAiuA2M4Bo74Q==
X-ME-Sender: <xms:5R3taGaFbaRys5-m6R_xQU1pC3w-aHZKehwPK0AAuINmZj_mtZyEVZE>
    <xme:5R3taAYxsjlKYZwSp4Dk9yW_JUiFpVdMR-wdBxlguvAb5qPv8zGpIFSn2wcZH3T6c
    dSXLKe3RQQmMSJI-5_QxnrVFE8Vid_xNnzQytgKyBp4eTcaRkRW7Q>
X-ME-Received: <xmr:5R3taF9RXHwa2Lq0q82NeMMCtbdErY07okzTDoG0wbfauANmrSOiZdlXl0HKEtJpiRYUcjJPrBN4jNCQVZqhwjPek_xDqwJg5WKw1fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtth
    gvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffh
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhk
    rdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:5R3taHgNHiMEbpz892SXST43HHobsb4nMsFuTAqBUP2Ia4zc1nH0Tw>
    <xmx:5R3taNfBxhs27p6mbYVdMhsHVVagw6-q0MNFuiP3SLYwzvXvFabCTA>
    <xmx:5R3taGoAkthvt0wWIno7gd6YBMSm_kuHWHlLiXDCiFSOLWvulzpl9w>
    <xmx:5R3taKB8LDg6WegwsHw8U0QlnG3bAHebAUbobOMKVV72xchysHneBg>
    <xmx:5R3taATl3f0wcQ4YRLK2RjXVeUxdQK7Im0gqsvCMwIVX5PKuALmu-646>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:42:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2] doc: patch-id: convert to the modern synopsis style
Date: Mon, 13 Oct 2025 17:42:15 +0200
Message-ID: <v2-38645ea253c.1760369708.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.352.g356bc2d8d49
In-Reply-To: <978261e3be4.1760043036.git.code@khaugsbakk.name>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Convert this command documentation to the modern synopsis style based on
similar work.[1] Concretely:

• Change the Synopsis section from `verse` to a `synopsis` block which
  will automatically apply the correct formatting to various elements
  (although this Synopsis is very simple)
• Use backticks (`) for code-like things which will also use the correct
  formatting for interior placeholders (`<orderfile>`)
• Use inline-verbatim on options listing

† 1: E.g.,
     • 026f2e3b (doc: convert git-log to new documentation format,
       2025-07-07)
     • b983aaab (doc: convert git-switch manpage to new synopsis style,
       2025-05-25)
     • 16543967 (doc: convert git-mergetool manpage to new synopsis
       style, 2025-05-25)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name (applied): kh/doc-patch-id-1
    
    Topic summary: The documentation for "git patch-id" has been converted
    to the modern "synopsis" style.
    
    Update git-patch-id(1) to the new synopsis style.  This is done based on
    observing what Jean-Noël Avila has done on other documentation pages.
    
    I don’t know what high-level plans Jean-Noël and the maintainer have for
    the rewrite so I don’t know if posting this update is somehow
    inappropriate in light of that.
    
    § Changes in v2
    
    Add more inline-verbatim (`) based on feedback from Jean-Noël.  Details:
    
    • More inline-verbatim markup
      • From feedback
      • Also: on config value (`true`)
    • Tweak commit message; refer to “options listing” for the left-flushed
      options to distinguish from running text
    • Fix mistake from v1 in markup for `-O<orderfile>`
    
    § Notes to the maintainer[1] (unchanged in v2)
    
    This depends on the topic kh/doc-patch-id-markup-fix (39969438 (doc:
    patch-id: fix accidental literal blocks, 2025-09-29) merged into
    v2.50.0 (because that’s what the topic is based on).
    
    (is there a “reference” convention for mentioning a topic + commit?)
    
      † 1: Inspired by
           • <cover.1759097191.git.me@ttaylorr.com>
           • SubmittingPatches: guidance for topic names and multi-series efforts
             • <cover.1759873165.git.me@ttaylorr.com>
    
    This is part one of a multi-series effort focusing on this
    documentation page. Technically that intent started with topic
    kh/doc-patch-id-markup-fix, but I published that before I learned
    about the idea presented in <cover.1759873165.git.me@ttaylorr.com>.
    So this gets named “part one” in the cover letter (and maybe on the
    topic name).
    
    The current plan for parts 2–5:
    
    2. Various smaller fixups (many small patches/commits)
    3. Mention the two config variables in git-config(1)
    4. Make it more clear that you can feed multiple diffs to this command
    5. An “Examples” section
    
    Why a multi-part series?  It started with the idea of (1) emphasizing
    that this command can take multiple patches, and (2) making an
    Examples. But then I saw other things to fix. And they ought to go
    first... eventually I ended up with many commits or ideas.
    
    I wanted to see if this was easier to review.
    
    • Focus on uncontroversial changes first
    • Make all the series either small, simple/trivial, or both
    • Leave the changes that might spark discussion last; the ones that have
      to do with authoring new paragraphs/sections
    
    (I realize that multi-part series are probably mostly used for
    super-technical changes that take 50+ patches in total and that only
    three people on the list have the time and capacity to review at any
    given point in time.)

 Documentation/git-patch-id.adoc | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 45da0f27acd..92a1af36a27 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -7,8 +7,8 @@ git-patch-id - Compute unique ID for a patch
 
 SYNOPSIS
 --------
-[verse]
-'git patch-id' [--stable | --unstable | --verbatim]
+[synopsis]
+git patch-id [--stable | --unstable | --verbatim]
 
 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ the same time also reasonably unique, i.e., two patches that have the same
 
 The main usecase for this command is to look for likely duplicate commits.
 
-When dealing with 'git diff-tree' output, it takes advantage of
+When dealing with `git diff-tree` output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
 commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
@@ -30,35 +30,35 @@ This can be used to make a mapping from patch ID to commit ID.
 OPTIONS
 -------
 
---verbatim::
+`--verbatim`::
 	Calculate the patch-id of the input as it is given, do not strip
 	any whitespace.
 +
-This is the default if patchid.verbatim is true.
+This is the default if `patchid.verbatim` is `true`.
 
---stable::
+`--stable`::
 	Use a "stable" sum of hashes as the patch ID. With this option:
 +
 --
 - Reordering file diffs that make up a patch does not affect the ID.
   In particular, two patches produced by comparing the same two trees
-  with two different settings for "-O<orderfile>" result in the same
+  with two different settings for `-O<orderfile>` result in the same
   patch ID signature, thereby allowing the computed result to be used
   as a key to index some meta-information about the change between
   the two trees;
 
 - Result is different from the value produced by git 1.9 and older
-  or produced when an "unstable" hash (see --unstable below) is
+  or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
-  of "-O<orderfile>", thereby making existing databases storing such
+  of `-O<orderfile>`, thereby making existing databases storing such
   "unstable" or historical patch-ids unusable.
 
 - All whitespace within the patch is ignored and does not affect the id.
 --
 +
-This is the default if patchid.stable is set to true.
+This is the default if `patchid.stable` is set to `true`.
 
---unstable::
+`--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
 	by git 1.9 and older and whitespace is ignored.  Users with pre-existing

Interdiff against v1:
  diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
  index bfbf23f49c4..92a1af36a27 100644
  --- a/Documentation/git-patch-id.adoc
  +++ b/Documentation/git-patch-id.adoc
  @@ -34,7 +34,7 @@ OPTIONS
   	Calculate the patch-id of the input as it is given, do not strip
   	any whitespace.
   +
  -This is the default if patchid.verbatim is true.
  +This is the default if `patchid.verbatim` is `true`.
   
   `--stable`::
   	Use a "stable" sum of hashes as the patch ID. With this option:
  @@ -48,15 +48,15 @@ This is the default if patchid.verbatim is true.
     the two trees;
   
   - Result is different from the value produced by git 1.9 and older
  -  or produced when an "unstable" hash (see --unstable below) is
  +  or produced when an "unstable" hash (see `--unstable` below) is
     configured - even when used on a diff output taken without any use
  -  of `-O<orderfile>", thereby making existing databases storing such
  +  of `-O<orderfile>`, thereby making existing databases storing such
     "unstable" or historical patch-ids unusable.
   
   - All whitespace within the patch is ignored and does not affect the id.
   --
   +
  -This is the default if patchid.stable is set to true.
  +This is the default if `patchid.stable` is set to `true`.
   
   `--unstable`::
   	Use an "unstable" hash as the patch ID. With this option,

Range-diff against v1:
1:  978261e3be4 ! 1:  38645ea253c doc: patch-id: convert to the modern synopsis style
    @@ Commit message
           (although this Synopsis is very simple)
         • Use backticks (`) for code-like things which will also use the correct
           formatting for interior placeholders (`<orderfile>`)
    -    • Use backticks on options
    +    • Use inline-verbatim on options listing
     
         † 1: E.g.,
              • 026f2e3b (doc: convert git-log to new documentation format,
    @@ Commit message
     
     
      ## Notes (series) ##
    -    Topic name: kh/patch-id-doc-part-one
    +    Topic name (applied): kh/doc-patch-id-1
     
         Topic summary: The documentation for "git patch-id" has been converted
         to the modern "synopsis" style.
    @@ Notes (series)
         the rewrite so I don’t know if posting this update is somehow
         inappropriate in light of that.
     
    -    § Notes to the maintainer[1]
    +    § Changes in v2
    +
    +    Add more inline-verbatim (`) based on feedback from Jean-Noël.  Details:
    +
    +    • More inline-verbatim markup
    +      • From feedback
    +      • Also: on config value (`true`)
    +    • Tweak commit message; refer to “options listing” for the left-flushed
    +      options to distinguish from running text
    +    • Fix mistake from v1 in markup for `-O<orderfile>`
    +
    +    § Notes to the maintainer[1] (unchanged in v2)
     
         This depends on the topic kh/doc-patch-id-markup-fix (39969438 (doc:
         patch-id: fix accidental literal blocks, 2025-09-29) merged into
    @@ Documentation/git-patch-id.adoc: This can be used to make a mapping from patch I
      	Calculate the patch-id of the input as it is given, do not strip
      	any whitespace.
      +
    - This is the default if patchid.verbatim is true.
    +-This is the default if patchid.verbatim is true.
    ++This is the default if `patchid.verbatim` is `true`.
      
     ---stable::
     +`--stable`::
    @@ Documentation/git-patch-id.adoc: This can be used to make a mapping from patch I
        patch ID signature, thereby allowing the computed result to be used
        as a key to index some meta-information about the change between
        the two trees;
    -@@ Documentation/git-patch-id.adoc: This is the default if patchid.verbatim is true.
    + 
      - Result is different from the value produced by git 1.9 and older
    -   or produced when an "unstable" hash (see --unstable below) is
    +-  or produced when an "unstable" hash (see --unstable below) is
    ++  or produced when an "unstable" hash (see `--unstable` below) is
        configured - even when used on a diff output taken without any use
     -  of "-O<orderfile>", thereby making existing databases storing such
    -+  of `-O<orderfile>", thereby making existing databases storing such
    ++  of `-O<orderfile>`, thereby making existing databases storing such
        "unstable" or historical patch-ids unusable.
      
      - All whitespace within the patch is ignored and does not affect the id.
    -@@ Documentation/git-patch-id.adoc: This is the default if patchid.verbatim is true.
    + --
      +
    - This is the default if patchid.stable is set to true.
    +-This is the default if patchid.stable is set to true.
    ++This is the default if `patchid.stable` is set to `true`.
      
     ---unstable::
     +`--unstable`::
-- 
2.51.0.352.g356bc2d8d49

