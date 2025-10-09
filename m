Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4241F7580
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043286; cv=none; b=oap2+kTspL8qWBgPIMKHEL57fPfHNFBpITsghzSFxbRrL7cDfK55QQRUY5obE5ZSvtSnX1fStFHRmezKjIkV258HvHmaZRgK5mPbCwGPCb7R2CZIM1NsKsdlMG/SLrOja22vmI05NVmxF7YL5IIYKWEVvZtt8zGHbvHzItfeaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043286; c=relaxed/simple;
	bh=SBUm49X7u9nvMJnhhYwFI5PDfCXRsihH5o0r1tNX3A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UiMcvWSya2UH2raPaIFu7LO4Xwqd0ykkB/j8ZCf4NRe9aOqj/VQGGz9L0owWVEHPlBqBp3OKCa5Dw+LF023up7u+gXqllnbpYgqu9r4jsBMPydWr/TJ7lvWElSoHi9VBnrp2JJG+WUB71CLcvOI9OfvCy+wUQVCOul9LxIRYNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=i709/dRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnrLzY1L; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="i709/dRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnrLzY1L"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B74EEC0109;
	Thu,  9 Oct 2025 16:54:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Oct 2025 16:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1760043283; x=1760129683; bh=sM
	Q3hLhv+TZZf1jRAL91SBWMBabPAAU6H6cz6ZOnlj8=; b=i709/dRkac/Fmz4rVj
	3fIx90dlQfCC41z6mG1WEG3KI615MV3snaXZ/5ddLLEmD+K+SfooNE2rJn+p5N1X
	F60+uC5G7Q3qIAsd+5QgE/k2l9H9CrWkgpYJ6FK80a9sTxCL4SiI5i7yK1saGZyC
	jWsO4r9JbEazw2chVtGkMehPqbdtvqj19KaHFX/OrLqOYHWASiQ0+4vR9trr58NV
	LSQeKWnbxYWRPgTKJCHtJ1G0d8GMg00lY5btWugGOVVn2sJ/0FzSXwbaFEGe46gH
	jv8MKjw9jr/hNUYrYtKKfBWVLY/fgIGo6XkQgTHbf8ygT9b45LqNTQugsrrjcEgQ
	XTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760043283; x=1760129683; bh=sMQ3hLhv+TZZf1jRAL91SBWMBabP
	AAU6H6cz6ZOnlj8=; b=NnrLzY1LxrLzCIkJj73Snj0nBdwCIQaylijktjbT04mE
	OeHZGlo8r8PMOKtJnJgv9p904qtd8odIVxPoYPeBPceTApQdtNitnOuts2jDamE3
	0AA5CWXEaEa2xNPmVFADZcypaOn1M4bvhVgcbVf75TJO+zIetE7y1seenQNb3r54
	w4pRI41bETVBrieLCUffkZ5acp+iMmN/kj/9wSI8rSETLiJAD0VxWR7WuAzc0Bp/
	+Ml+xdd5MIo4Pd+4T78PEO1kGFBn3obvha74urzzUkf5kuKH0mfq48lUS7TZLp1r
	5YQFX/+P2MUnDTKdpq2AZBEFlnb06O1SzHyetmJVyQ==
X-ME-Sender: <xms:EyHoaGfSH0bglF87lgLNqWz5lIBoQojiNrFis7plSFk-8Y6-HoggmqA>
    <xme:EyHoaHoXW22vDRMUcnq2_pdUUIr_Me0GcUJ-167FtncvARPYkQtPObSl_3WyyaeAt
    wFwniiZ9PxkfL4ipBjC-CE9u0qjkWbK_E5vIcEbflmJykSjnY0j3rc>
X-ME-Received: <xmr:EyHoaE6j1gujvuNsigEC92tHQj5m3KUUhCRjU3EGprubMeMVYXrE1wFNfyyUiztpUdSc9F7fWECK0lPtRUAZk9zZtEV2YofkPx8f-XBhnbTrnHKLsH-cetKW-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeigtdertdejnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeffffehteegkeefieejffevkeehfefhteduuefggfehkeefkeeugfdvhedukeejkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:EyHoaNofzvnYg_BLsF0yPdctDvhUPgHU70a4Gr_ni4shHPSR7utCXw>
    <xmx:EyHoaGjnumAzm3L59saSC0R2uWl-OMg8k9I3gvIXN3UWOtYaUX4Erg>
    <xmx:EyHoaHJ47akIsOcXwfdQBZFa_FpjB_sZaQ3Oh-YBVVOUp495DA8ARg>
    <xmx:EyHoaGC-PQfg2MwufSyP_cB7de4DOlPIOFUAKivpBTtJVjXuSZRkjQ>
    <xmx:EyHoaDQ5QEzY85nbacCs2FxHweDJr_cC4op7SFz78AxgqckJhW6gKBW9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 16:54:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: patch-id: convert to the modern synopsis style
Date: Thu,  9 Oct 2025 22:53:53 +0200
Message-ID: <978261e3be4.1760043036.git.code@khaugsbakk.name>
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

Convert this command documentation to the modern synopsis style based on
similar work.[1] Concretely:

• Change the Synopsis section from `verse` to a `synopsis` block which
  will automatically apply the correct formatting to various elements
  (although this Synopsis is very simple)
• Use backticks (`) for code-like things which will also use the correct
  formatting for interior placeholders (`<orderfile>`)
• Use backticks on options

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
    Topic name: kh/patch-id-doc-part-one
    
    Topic summary: The documentation for "git patch-id" has been converted
    to the modern "synopsis" style.
    
    Update git-patch-id(1) to the new synopsis style.  This is done based on
    observing what Jean-Noël Avila has done on other documentation pages.
    
    I don’t know what high-level plans Jean-Noël and the maintainer have for
    the rewrite so I don’t know if posting this update is somehow
    inappropriate in light of that.
    
    § Notes to the maintainer[1]
    
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

 Documentation/git-patch-id.adoc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 45da0f27acd..bfbf23f49c4 100644
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
@@ -30,19 +30,19 @@ This can be used to make a mapping from patch ID to commit ID.
 OPTIONS
 -------
 
---verbatim::
+`--verbatim`::
 	Calculate the patch-id of the input as it is given, do not strip
 	any whitespace.
 +
 This is the default if patchid.verbatim is true.
 
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
@@ -50,7 +50,7 @@ This is the default if patchid.verbatim is true.
 - Result is different from the value produced by git 1.9 and older
   or produced when an "unstable" hash (see --unstable below) is
   configured - even when used on a diff output taken without any use
-  of "-O<orderfile>", thereby making existing databases storing such
+  of `-O<orderfile>", thereby making existing databases storing such
   "unstable" or historical patch-ids unusable.
 
 - All whitespace within the patch is ignored and does not affect the id.
@@ -58,7 +58,7 @@ This is the default if patchid.verbatim is true.
 +
 This is the default if patchid.stable is set to true.
 
---unstable::
+`--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
 	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
-- 
2.51.0.352.g356bc2d8d49

