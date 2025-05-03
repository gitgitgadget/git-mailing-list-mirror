Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F22EB10
	for <git@vger.kernel.org>; Sat,  3 May 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234945; cv=none; b=IYf6OM5CMT0fZyLlpg9ZZuLgNFMrFNm84cPdJFsGA3ruQyyAfgMfNO0tRdiuXnqn6dr0tIqL08oLSCxHQYIV0Djq0M4EdJV6Rz+l+Qxhu1EYKh2MMM9+r1f2zgbLkkypl/URE2+g9e+goKCZUTxryQPa6vC5xgTYcx/fE0qpz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234945; c=relaxed/simple;
	bh=Qj7XiyTEjN/k+SUsdnEXxG1b7tAZo9m4ne5je3NPSTQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbMlGm/VfaMOhjaOkvRwPnorgLJgRjU6VzuEzIj6iCtV99Zp+SdPTBe5Vq1r/83tzqwetFvOmhJ45uevBqIJ8UX8SaeWRrz9CqEVrfnjOggkFSHdUEwCAIAD5pkJ5uaPJbcCH5DrTJScZC130GfhskBb6ESyG5KGAWxIDaDZkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UikvmFwJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ov4plW4Q; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UikvmFwJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov4plW4Q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71F3A1140205;
	Fri,  2 May 2025 21:15:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 21:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746234942; x=
	1746321342; bh=fFPIL8kNV4yMo6c1/TUCVjEhVdsSYwZjXqj96SIlN0I=; b=U
	ikvmFwJImenmoHuAXWtI1gnQUONPhnrNBfFJvQG/4j4n2hW+5mnXQYIcBZ6v/TIX
	B//ALcQI/4Z6jN3i8ejH/lcsngHdkBfYdnpScoelWTuPuIa3TmkwBs83N0PkzVY/
	uqjppmzt8hL4ykNajh6eG0ahyQLOiAGA+ummlTp4XHZtGwAO3QjSHL00GyYyo2+/
	yprv+80DqDqJN/CPfKhhthla7GrDwkZFlnbB9Z9LzHnC7XLXF7ZOkntncHf0bT0q
	v0mqOIrpGctJWqJawRIkmOt92YnJ3JZDVEgMtXBxzjFM80QtMKEuz4LR/zH13LGx
	1/HF5xtZucrjeG9zeJ2Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746234942; x=1746321342; bh=fFPIL8kNV4yMo6c1/TUCVjEhVdsS
	YwZjXqj96SIlN0I=; b=Ov4plW4QEHzRSeWcTSJu4yDfcMwtN04SiOwvHcWTHs2G
	+IIzRRm1PzkxTLETgx1PCGZ3ms89K400OHtzJixkEyF3EGxPu03kirCaM/frpoEv
	z03dlLlvFC5DaWW4JtdYs8BN52+ai9QFGny0/OADxkUTc/jSpl3bPzE8qXtZAuqH
	i5VUYwA93BC1lpC1X5y9cjzKmq2b8+6JKR8/7m3YqnAjFcz2OucK7K26Ieo/nKMG
	Hpc6w8RLaYW/IaHS5ntx+NJ7DSPSMAbdnoGqJBBblDfglkyLpIugETbCglWsmq6f
	yJruEkevXI6xHpmFYdi3wnY2PPPIREwwr9CGpMYxJA==
X-ME-Sender: <xms:Pm4VaP7-nf4AOuMdsNkUdxCgq94vZLoUYE114y2RiPFr7s1XDdD2Sg>
    <xme:Pm4VaE7ie_qtkk2Qg0q9Ul6NcoYhscM0FwibdFjJHpceKKOpnISrP4_dkvHPm36g7
    m4B1uVRXv0BxNp_8g>
X-ME-Received: <xmr:Pm4VaGfHWS-kO2b-lszHfNW2suVqerA2KGLfyRJN0vRxf6XzOYNadJTbXcznNf_xFVg9ElYBU8CinPU3T0ZlLkWPEm7Zcww9XOLP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pm4VaALdNzwdLK4mJ_ewY94mwaIe9nRXvDvHsffdDj-cIbGmWG5B3A>
    <xmx:Pm4VaDKqdIrPYBWQnwtoJ2oezeygCnxInbdEWcmqALQV1qWCw91zDQ>
    <xmx:Pm4VaJz_k4eLUSKDEBXZ7LJeZU5kHXufg6vUfOY0P2pJDB9u-LKTfQ>
    <xmx:Pm4VaPKOFxCvCKa4nZhuubIwS-5quZMxsB1YQDbjIhRA-doRyd2V1g>
    <xmx:Pm4VaD5wpK72jS9RGZut1QypVt4wKn4YfFKkIw0L0ixThmYSCm8JQ2NW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 21:15:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/3] git-{var,write-tree} docs: update mark-up of synopsis option descriptions
Date: Fri,  2 May 2025 18:15:36 -0700
Message-ID: <20250503011537.3035416-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503011537.3035416-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250503011537.3035416-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation for 'git var' and
'git write-tree' to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-var.adoc        |  6 +++---
 Documentation/git-write-tree.adoc | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 0680568dfd..909963b1c2 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -8,8 +8,8 @@ git-var - Show a Git logical variable
 
 SYNOPSIS
 --------
-[verse]
-'git var' (-l | <variable>)
+[synopsis]
+git var (-l | <variable>)
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ no value.
 
 OPTIONS
 -------
--l::
+`-l`::
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
diff --git a/Documentation/git-write-tree.adoc b/Documentation/git-write-tree.adoc
index f22041a9dc..4e1c3b9c0c 100644
--- a/Documentation/git-write-tree.adoc
+++ b/Documentation/git-write-tree.adoc
@@ -8,8 +8,8 @@ git-write-tree - Create a tree object from the current index
 
 SYNOPSIS
 --------
-[verse]
-'git write-tree' [--missing-ok] [--prefix=<prefix>/]
+[synopsis]
+git write-tree [--missing-ok] [--prefix=<prefix>/]
 
 DESCRIPTION
 -----------
@@ -18,21 +18,21 @@ tree object is printed to standard output.
 
 The index must be in a fully merged state.
 
-Conceptually, 'git write-tree' sync()s the current index contents
+Conceptually, `git write-tree` sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
-now, you need to have done a 'git update-index' phase before you did the
-'git write-tree'.
+now, you need to have done a `git update-index` phase before you did the
+`git write-tree`.
 
 
 OPTIONS
 -------
---missing-ok::
-	Normally 'git write-tree' ensures that the objects referenced by the
+`--missing-ok`::
+	Normally `git write-tree` ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this
 	check.
 
---prefix=<prefix>/::
+`--prefix=<prefix>/`::
 	Writes a tree object that represents a subdirectory
 	`<prefix>`.  This can be used to write the tree object
 	for a subproject that is in the named subdirectory.
-- 
2.49.0-601-ga5925c3955

