Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCADFC18
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921317; cv=none; b=PfhRb5uIAwDMRF1EjbjtoAy4TjsbAY9uQmttFzH3Wg3fZcE7gpmB8fsYYhRHJR1mfHURKsUmPxJL2N0tzjI8rI+lMJ1bdEPfXjt5AEiPr2nPI4Apz42YSFZEfnGLaFsGC0Yucji3PMWR+MAObDcdfDsgY+nYEoE5hJv1pz87Kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921317; c=relaxed/simple;
	bh=dqTx/vJpe2NtmkhRWb7JKLehI6H2Z/abywaRpmjaiv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PC95iOKjXXWhSoqIEG3f2cf8D/oZ/2Ztr22dJ2Hko4JSu/pVkXIamk2JZWTS3LhYKy3HmOBU65B7ue5GZKU/Nuv7x0KnGR2ZMx7StgFFqFOkTKDgHhzFdx5FE3cMbmABlprGbb2UACMMyrxRdRV69v5K2Hwg5T23CwadLZ6ZcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=YoIIbLbX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gg7W2+sa; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="YoIIbLbX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gg7W2+sa"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A37085C0069;
	Sun, 25 Feb 2024 23:21:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 25 Feb 2024 23:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1708921313; x=1709007713; bh=Dx77DBEbKP
	LZ2x5K+oyfHzgQ/Wg2y4xaxXzo96jm7xg=; b=YoIIbLbXGbJOprPjF+l7P7ypuU
	enHgvV0gjQC9jKUUgv/2pOh0hCpvsC9GKRuPbg4/uUDN6x+b2bs9hFSdKkAYT2oL
	RZFDebsuDzzD8x1yAXax64Q/IjPZMzMgMxr1rPK3XjFaRvAdfEcMUEJQBJ3RCD3p
	6iTyj2LwHfpynYbnyq/5nmMieHNR3vaVBiLLF3236akvQJLQ0Nlw39JpQOi/9mmA
	pwDfz0w61pMIu1Tb+ozg+fTf0yIawPvWRqG6UeH0ri0Tl9hq9nvBsA1u2mweOS1m
	V2Jr9hYqzwwO/GLI9DJstYMg8hwJ5HXh93VsKVL48LGwZsyumwLE0vVpNXHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708921313; x=1709007713; bh=Dx77DBEbKPLZ2x5K+oyfHzgQ/Wg2y4xaxXz
	o96jm7xg=; b=Gg7W2+saC2LDoHbZufokuZPmQDjidO8Z5En7yt8yR/nR111YycO
	APLm0UPUCZUf9rADBiZMVLbSPmVg+G4ChCMOlnI7kgZ29ztDUHd7zgFsz+d2hiyu
	Sl7mnE7J7Jl2q3HdpMYrAM1+cQ3l0pjyEJgPqovGnBtlOvKCUwhKPf5Cg74YifGd
	jI7alIDT16FoE72wt7dRJWj9xIvnjwsgSdJc0E99doBTdF37P5Xe5bhrKD1/AyVJ
	/z7yhpb5TivTmTp3TO5Oey17eLNKY5gH/iUVIMELKmCN/ew7c+cs5wrKEIXC0iIb
	WzuW0wNJQ+YcKemIfZJk6Bpc5n4U8HoLFGA==
X-ME-Sender: <xms:4RHcZbUH0pLtRAAtwJueBbuABBcdnYdaL_oEB3ebkLQ6Pfe3zoEjew>
    <xme:4RHcZTkCLI_FwBiBIrzAHoD2v4OlTPmkW5qFTsQKEBejWWqo9ftJkJf96hg9BFT0F
    jxxofpjrd-CHaXLdXM>
X-ME-Received: <xmr:4RHcZXaAqPHFGFzNDAtCF9yzCligT8k7-7tyH8-09kU5RXcJgF2hxI2pGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduvdelheettdfgvddvleegue
    efudegudevffekjeegffefvdeikeehvdehleekhfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrd
    horhhg
X-ME-Proxy: <xmx:4RHcZWUi1E3ZQiZL0MGbWQ3lNQkXfn1BQliRsmVbvzodHf1JTcU0zA>
    <xmx:4RHcZVknmUEr_Hv90xPTxa9wuqeD0Cy5Vr6wubG0julTZo2m7_FRzA>
    <xmx:4RHcZTdTgnyHoDJI6RccctrwPU9uI0fG0FguLvxNLl0cc8eADdwzrA>
    <xmx:4RHcZVs1pZgnZFaCeBDFonKp_iySjN4eOCdwUgbmbXLlNGTqKrDkMA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 23:21:52 -0500 (EST)
Date: Sun, 25 Feb 2024 20:21:51 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] advice: Add advice.scissors to suppress "do not modify or
 remove this line"
Message-ID: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The scissors line before the diff in a verbose commit, or above all the
comments when using --cleanup=scissors, has the following two lines of
explanation after it:

Do not modify or remove the line above.
Everything below it will be ignored.

This is useful advice for new users, but potentially redundant for
experienced users, who might instead appreciate seeing two more lines of
information in their editor.

Add advice.scissors to suppress that explanation.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/config/advice.txt | 5 +++++
 advice.c                        | 1 +
 advice.h                        | 1 +
 wt-status.c                     | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2..33ab688b6c 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -104,6 +104,11 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	scissors::
+		Advice shown by linkgit:git-commit[1] in the commit message
+		opened in an editor, after a scissors line (containing >8),
+		saying not to remove the line and that everything after the line
+		will be ignored.
 	sequencerInUse::
 		Advice shown when a sequencer command is already in progress.
 	skippedCherryPicks::
diff --git a/advice.c b/advice.c
index 6e9098ff08..0588012562 100644
--- a/advice.c
+++ b/advice.c
@@ -71,6 +71,7 @@ static struct {
 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
 	[ADVICE_RM_HINTS]				= { "rmHints" },
+	[ADVICE_SCISSORS]				= { "scissors" },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
diff --git a/advice.h b/advice.h
index 9d4f49ae38..9725aa4199 100644
--- a/advice.h
+++ b/advice.h
@@ -39,6 +39,7 @@ enum advice_type {
 	ADVICE_RESET_NO_REFRESH_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
+	ADVICE_SCISSORS,
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
diff --git a/wt-status.c b/wt-status.c
index 459d399baa..19d4986351 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1104,7 +1104,8 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
 	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
+	if (advice_enabled(ADVICE_SCISSORS))
+		strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.43.0

