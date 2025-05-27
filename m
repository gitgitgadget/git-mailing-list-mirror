Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D756211A35
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380814; cv=none; b=hmDeGcOIuAMayhZt7svkJCHMcn22nSygb98J/6cLwHFiwt/QbhhzDOlPSxdiqHICsm/DftNJzJ+n4LhQi8oglIZQ4bxMj9FLsOhe8FogJsCqorgFsPEe9E40SAui35OPv/nL4WAIX7LPHsLUh3MsZ8WBUy3TqeLlooPrzG9b8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380814; c=relaxed/simple;
	bh=Y/MLXhldS0AzWO3FyjVYZJ7TK027zrhF8jdikj9zQc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrDsS7HzrAVTEBXJvg3dFTrUFrDnGvFXrYdCqWvy87VWSz42IJ7YgNL+STP/zYW2mFBKt2aU8VsKgeLqOkxrwr/LgfrIyesv+bEjRAsrvKO55uc5NR30IluxcI4EWMkK9feWGHaPew/6kqiBQCt8GPI+xJZLq40qitljGtUk0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dIIWFP3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWHShP+A; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dIIWFP3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWHShP+A"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 488C4254016F;
	Tue, 27 May 2025 17:20:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 17:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380811;
	 x=1748467211; bh=nHv+6J9Fo5s37OJLIBJXaMS0bXcF7A4npW99YAhrsKo=; b=
	dIIWFP3SkXa0gy2pdbhIGcNd0QPS/gs8wqY60evPOQ+3ejTD8of/G9tV66Ix9aMF
	bNUqJOBT1ewbGYsaDTRd1uzTmVTP7R4wzwInafINxDztxKRlbyZ1uaVBuVszWgfO
	zj39MtCyWi17+q5OUbEmjibPeVqPwaRI2LJmM7MvplvhwGltzhvoWCBEN5j6IK4s
	0Zm/c8UJ7w857eAImEHdyMtvegrmDTdrs+bX96zRtzfPycTP/EWARZcDsSbpDSCj
	M5NAeNib4uw4QStD+2Qf9ziFNuiPf6gJupHCzKfCSZZB75PI1ws/YeHf/TKzJ2nf
	sMRgfMYKeo66Z+93pkR8CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380811; x=
	1748467211; bh=nHv+6J9Fo5s37OJLIBJXaMS0bXcF7A4npW99YAhrsKo=; b=l
	WHShP+Aki2LIaCTq378N0+FnMSzUfQ4+jkiWw/oVx8FDDW7K2XTuW/3D0SF9Opdv
	DJZa34Q4eNhgnXzJgYYU7jDuHx5QkSKhBV7nKNcggVlC77ZG7N5IaqnH7YF0MDLU
	oAQPkE8jMtYq6obXY3gm5uM5N5X9HxVn2ErIPg+uFk36BBWGP98W1gjhZHeNG9jy
	MPNrj6KwTjIxbZSXIuiCN1YM1Sg3Dr/okpCDGoVEEVL4EN9pavHpzmWYMwAM+iZF
	q+JeeRFCQFuac0mUYgzJRoPXl/MR6NTL10ctJcvSumPB3UnxLLzoehMseBSZzqJz
	bfACs9ZSeNPWYF7+mRGxg==
X-ME-Sender: <xms:iiw2aNpnZ2AS7yX1TY4IlaqvwruZdd5Vx1eMRUPXhZg36Wnn4J6SX2U>
    <xme:iiw2aPovQwS3ar4TJcTl9XFj5pMjuUAGbrj5V00chYKtQJdZeX31LdCbJ_YcXdm74
    RRKNfe62jbtoZIkeg>
X-ME-Received: <xmr:iiw2aKNhjiuZ0RvDEsOXnEFn3Yre45IUQRIkAR498JFy2ffdFjBsdEqTf1wAkaSyM_Vq9HIjnh29o5LAEQoVQw9NXLu1vOvTPy1mS3Rni49ZALyLrVVrQQYYrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfej
    kefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:iiw2aI5wfxjtjMN4301Nz7dhOAI470inI6J2TSajjt3v2uvrNPx4WA>
    <xmx:iiw2aM5EjhAkaGt8EK5OnAkwSRSt6jn8nmLhluHY3BPzbIMwbsbc_A>
    <xmx:iiw2aAj8MnE0bM5uMtUnjcJ9YMfXM-mOeuUjtyIeq2k-Oar5fO_xAQ>
    <xmx:iiw2aO4QIrt7YwD48MIPzcKMxUvDdV7aPksPsgGWUS-63yuO06mLCw>
    <xmx:iyw2aE3wIAfubdbiOQN7euIwgWD1lHlbNI09YUEZpkGOU3PY0xXuCpwF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 4/9] doc: notes: rework --[no-]stripspace
Date: Tue, 27 May 2025 23:19:33 +0200
Message-ID: <c68a91f81ba180acb1025b229dee3d1e61691e75.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Document this option by copying the bullet list from git-stripspace(1).
A bullet list is cleaner when there are this many points to consider.
We also get a more standardized description of the multiple-blank-lines
behavior.  Compare the repeating (git-notes(1)):

    empty lines other than a single line between paragraphs

With (git-stripspace(1)):

    multiple consecutive empty lines

And:

    leading [...] whitespace

With:

    empty lines from the beginning

Leading whitespace in the form of spaces (indentation) are not removed.
However, empty lines at the start of the message are removed.

Note that we drop the mentions of comment line handling because they are
wrong; this option does not control how lines which can be recognized as
comment lines are handled.  Only interactivity controls that:

• Comment lines are stripped after editing interactively
• Lines which could be recognized as comment lines are left alone when
  the message is given non-interactively

So it is misleading to document the comment line behavior on
this option.

Further, the text is wrong:

    Lines starting with `#` will be stripped out in non-editor cases
    like `-m`, [...]

Comment lines are still indirectly discussed on other options.  We will
deal with them in the next commit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • Together with one other other patch replaces v1 patch “doc: notes:
      mention comment character configuration”
    • I figured out that mentioning the comment character/comment lines
      doesn’t make sense here.  So all attempts to rephrase “comment
      character” or “lines that start with `#`” are gone

 Documentation/git-notes.adoc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 8706b33f2ee..d672794a942 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -184,11 +184,13 @@ OPTIONS
 
 `--stripspace`::
 `--no-stripspace`::
-	Strip leading and trailing whitespace from the note message.
-	Also strip out empty lines other than a single line between
-	paragraphs. Lines starting with `#` will be stripped out
-	in non-editor cases like `-m`, `-F` and `-C`, but not in
-	editor case like `git notes edit`, `-c`, etc.
+	Clean up whitespace. Specifically (see
+	linkgit:git-stripspace[1]):
++
+- remove trailing whitespace from all lines
+- collapse multiple consecutive empty lines into one empty line
+- remove empty lines from the beginning and end of the input
+- add a missing `\n` to the last line if necessary.
 
 `--ref <ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
-- 
2.49.0.780.g892193c3f50

