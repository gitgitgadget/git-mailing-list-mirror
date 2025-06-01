Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DE17A304
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748777851; cv=none; b=uFyoC8gOoRbI8yx5Jbuuk7ipMBfkWyGvbY+88P//Q72f/Kp34rOJrhW2s0ArkQbsBmLGjahGZ9ktzv7Wyho7z+KNtTOUs0jTfIqknzg5AcfcrMIY4IEZBGyeO+DBtBqyiGdU/RZ/MYpGuDgYCNTswN96ocsQHAs09pb8+A8LlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748777851; c=relaxed/simple;
	bh=S2axX4A5iCJeB9xzLyPVR24zrmHWJltO3YwMAdyXQLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ko+cqQJf9YMG93MTNgZuKDgQaH6d1nNYiXrbF6/PY4jj5nAvh0VHQmzZNoy/bdxlH+dlq08Z8Rba+HS7lhRKi0aWYKzmEqijk68GuLrZWpWAW1FohuHXKuuBjelgLm3dGI/p7qJVXbEzeuTKd0UF5YvgPMxjmP9vBdGLAuljXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZIHfKUnh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJIr9dsa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZIHfKUnh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJIr9dsa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C032B1140109;
	Sun,  1 Jun 2025 07:37:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 01 Jun 2025 07:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748777847;
	 x=1748864247; bh=LimazNnAbxNwcr5vbA4w0dRizIpFXZEEG9ZbNmlLswc=; b=
	ZIHfKUnhLwhfj+YsTSI/AJuVHtPVUQELi6x/W2KmszrvvbSFriidpECdRQo8jdsJ
	XXCrFfs2mmq2je/0qavlr5IWIGJa73PO9LhpowL9iH2myOto77BgIqi2rafWaxeR
	MsLMsdKccm3dOfzQvAMMASu2MtQoi3S1YZkQ39OZdnziuUKjVbxUfKJxPWGXpX2t
	IS0rphzlkvZ6hgv/c1y5Q2YWyRJjhO6RU/JzhmB74T4jtpLky17V+oYdoO8u4pam
	Wu9LWMINJHSViHOsVfoM5sKq/cxDSenlBoe+WjsKmQ2RVUbcEUWOC/jb6XESfKSd
	2MMh0+4l6rdqZuXo17z+JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748777847; x=
	1748864247; bh=LimazNnAbxNwcr5vbA4w0dRizIpFXZEEG9ZbNmlLswc=; b=L
	JIr9dsaELLNXm7l6bLXYDYNpRG2DPyEuhhr4pO5x0I8gL1eVGDQ5yVJggIzz2eJd
	SaQ+jMBnG2M5cjOoh5otYnHfrTKIlNStY+tZyXPyvqv/nk8XJ5ynBFaOesJv9OVM
	10Pj0KUTEA9rpuyFZCANNQaPCJ/EhFKH5YR3sk8L8TffnfplvgUSMp43S5P7Mf9m
	vO7SzA7iJ+VuZDCITgBzzRQXopMx0yYXKf1hcL/QXOCOvEhnG67bCSqQOTOwCs83
	j6bRiEfJrUODDUTgX+WHJDY+hbLlL8BZ9uAaAg015OP9OLcaSpYAQjEktYtm7AEg
	NgU9KcrUIWbbvSbtk0Cuw==
X-ME-Sender: <xms:dzs8aGkUUyMvWzCNU8joeRhaqmQ4y9tvb9fbIMZAierLiIna9u54K5c>
    <xme:dzs8aN0ieNWs4LSpAYtgJLT8Lnr_qhAclQswvhW-tHG--79Gr2vWxk0QoPafOWFw6
    Hssg4UrIgBO8DtDEg>
X-ME-Received: <xmr:dzs8aEq-lZTqZ1ZpIZluoAyD3JKys-POa0ri5i3sm2zUK2J0ZvNc4cjWKlm3yDuRdzm1QFbDkGcg52rGjmDDBmuDWhloKmF_cntKQ0Z3vvqINH-QfRjyV9OxkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeeikeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfej
    kefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvihhl
    rgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:dzs8aKnt06lM2RmLfRnkwT6LqoK34O4uMR60GrYwFPAIzpufCCx3GQ>
    <xmx:dzs8aE3L0ZhZbt5W8ivGXk3d309XdPragAJH262RZO7p-tyBGGYX0g>
    <xmx:dzs8aBta3T8K8HtsgXE9dMtcUOGEz4-QEzS_cGy30FBjOOPkB4rbMQ>
    <xmx:dzs8aAUxtf3j5t48Phwq1V9Ng6tW1VVK1ZGiFlV9XRyUK162ki_auA>
    <xmx:dzs8aB3BLz85IUteP9s1epLiqQryH7tAbOyLbviH8SMbTGWIdERT36FH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 07:37:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2] doc: column: fix blank lines around block delimiters
Date: Sun,  1 Jun 2025 13:36:53 +0200
Message-ID: <3c6d7b154048ef0053d15b4f86cc241211ef30dc.1748777208.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638d
In-Reply-To: <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
References: <b493b07f88bc5562e03c249006f01091afd7b5fd.1748725662.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

227c4f33a03 (doc: add a blank line around block delimiters,
2025-03-09) added blank lines around block delimiters as a
defensive measure.  For each block you had to mind the con-
text (like the commit says):

• Top-level: just add blank lines
• Block: use list continuation (+)

But list continuation was used here at the top level, which
results in literal `+` in the output formats.

Acked-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Finally trying the “After the list reached a consensus” step of
      SubmittingPatches
    • Add Ack
    • Use “around” consistently in subject and message

 Documentation/git-column.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-column.adoc b/Documentation/git-column.adoc
index 5a4f2b6fde9..8e0047214dc 100644
--- a/Documentation/git-column.adoc
+++ b/Documentation/git-column.adoc
@@ -50,7 +50,7 @@ EXAMPLES
 --------
 
 Format data by columns:
-+
+
 ------------
 $ seq 1 24 | git column --mode=column --padding=5
 1      4      7      10     13     16     19     22
@@ -59,7 +59,7 @@ $ seq 1 24 | git column --mode=column --padding=5
 ------------
 
 Format data by rows:
-+
+
 ------------
 $ seq 1 21 | git column --mode=row --padding=5
 1      2      3      4      5      6      7
@@ -68,7 +68,7 @@ $ seq 1 21 | git column --mode=row --padding=5
 ------------
 
 List some tags in a table with unequal column widths:
-+
+
 ------------
 $ git tag --list 'v2.4.*' --column=row,dense
 v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3

Range-diff against v1:
1:  b493b07f88b ! 1:  3c6d7b15404 doc: column: fix blank lines before block delimiters
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: column: fix blank lines before block delimiters
    +    doc: column: fix blank lines around block delimiters
     
         227c4f33a03 (doc: add a blank line around block delimiters,
         2025-03-09) added blank lines around block delimiters as a
    @@ Commit message
         But list continuation was used here at the top level, which
         results in literal `+` in the output formats.
     
    +    Acked-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-column.adoc ##

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
2.50.0.rc0.47.g3c6d7b15404.dirty

