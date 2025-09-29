Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D619A2A3
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759178875; cv=none; b=eTEjqqKFUIJzAFBmQKLjFlu428+3uoGLg9jtHOFHJhFY/yIL11KM9pBZV9cVoUcq+wWWpFO3g9ACEFjfs1xKxQk+MQ+t665hsTWWv2jTcOeasaGgwfzw2/+fzpSvLCBLDrD6v8ckM8JE/cTWQJR+bygR+pY6PUSbK5Xo58gJ3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759178875; c=relaxed/simple;
	bh=2+3agxI/JOo7NzLCPYiNruKg0mNncLc5eISRhXqbjn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ8nVo/9HvRw9+s9FaXPai/zBxXOWjnrMeFsxlzAW4ncq39BVow8Qdtd8poNf1K4waWU1MM+TbE+9uknECMr0Cts6lRtdJuwE6Se+ef+pbZoPi6ykXqxvoU7HDFCysN+ME1A43eka3a7+jhQ2rFS7yCS3FpdMZDnWwKtUAQjpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=A29hmUVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPMtiuN1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="A29hmUVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPMtiuN1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86EF014000D5;
	Mon, 29 Sep 2025 16:47:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Sep 2025 16:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759178870;
	 x=1759265270; bh=87dxbMHMdGEyndYYW4L9UR3PZtJ+GhnvFusLEYu7ht0=; b=
	A29hmUVQjoQwFN3dBbBPLhI9wt+4AW50itnXX0NOqdch7gtJ+yFvuBuD84J6qnJQ
	EEhsTEQeNXyY7KbwXERpJGtTZjNvHfYCVPLc61ayr0hBieRXxdokshgX3+vlI42y
	5Xk9sOVNSHzCckVeFjSMdAxS2KnaZTH4t3TWRzw4gN0ymKPlN+CypD0mgXj7tknW
	KIFlx0uCElLW/O8Vx7J5sUAvGhiqTKqYE/2O1pgxtW8Zbqnw8oajsV6p0k3hyPjN
	byBi6raipJPS+k1yIwJNVRY7fQhpTNPTYoG1/ZT4J/wkWbTQ8UbuyUWydvyRaXge
	9AIwq6XkOmzr3UnccBdZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759178870; x=
	1759265270; bh=87dxbMHMdGEyndYYW4L9UR3PZtJ+GhnvFusLEYu7ht0=; b=F
	PMtiuN1H4dErZChXR8+tLZDvZol1xgQFM4fGO4e/ilisKeYHt3pDgrwyQNT4lrvl
	MWNdIQIY2QHRhEZ4s6r5Z396muYFGfhpNZFwLfuunGdEabZlEaQKS0VqnQFbhO/z
	Ua+uifUp8bOBOdDZBMhZN73qVcV3vmqoLbmsx9RCAMYdjTQJ5YOCDiTLf4+Mkz8S
	5Q+RlxkSQ6amCrR6eI8mkQMYyhRNzdAVob+UnADvFpEXfa2FZMaDBPj/tW28R0Nq
	qdMQqCyJ/13rxmv4XR1x6gJAil71yu8hQoU9EFiekop+55IzZ5L67QbZKjE+JO3H
	GTAJzgih0rFCcVtzdmbxQ==
X-ME-Sender: <xms:dvDaaEztqbICoRXgk7XzYWyfjNTRD0CIou7flYFnEPG7uC5IVbr3Apo>
    <xme:dvDaaOTwL0AdNMJ7twOnLacVP5N8NzH5WJqyiKDtpczuRrrvNPpw0B3L54we_XJnf
    U5YDWzOPJP-zJWo8C_ht7PD7B5haGcBIc4Cm095Dozn1WzxSS31>
X-ME-Received: <xmr:dvDaaD9fT2VhkdXX5NR6XQrgFoyJwrdEncqLhXn9y_bDsIGT8SbN4VZPZ3ruNJVO-JzovWQMV9yQv9gk4Xx1DpI7QmlM2KLnaSY_KI7BbU_Xhn30QYH0-M3n2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeihe
    egfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:dvDaaNpwTAotxg7ZvEvIUgbXqxSN932H5eBmc0Mie9PE5aMoOdDpsg>
    <xmx:dvDaaIlmrg7g5-MlZQaNRFzmIOsHUkBn0iB3XUbI6FpZdPVkUYEj6g>
    <xmx:dvDaaMKpROJ1Vs0BcVIMvPfC2EgUFR3UtDoOq6Hf9OXx1E7XOzNTVQ>
    <xmx:dvDaaFxGLZ6mVAeTW9I2jJVcxYmpmwMS-0HLSvmVCI7nbxBd2emQRw>
    <xmx:dvDaaIKR25toI81fuACQpdnhkNyL9I-NNlHytqKCX7J2ISQSAeZgjgyw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 16:47:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] doc: patch-id: fix accidental literal blocks
Date: Mon, 29 Sep 2025 22:47:28 +0200
Message-ID: <v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.327.gddebdc8c038
In-Reply-To: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

All the final paragraphs on these three options are rendered as
literal blocks. The intent was surely to keep each of them wed to their
respective description list items. But the attempt at maintaining the
indentation level of the block causes each them to be interpreted as a
code block, since code blocks can be represented using indentation.

We need to use list continuation (+) in order to keep them wed to
their blocks.

There is also an unordered list which sandwiches two paragraphs on an
option. We don’t need to do anything about that since it attaches to the
description list item without list continuation (i.e. it is already
correct). But for consistency let’s use list continuation and an open
block on it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Rewrite the commit message.  Especially with an eye towards
    explaining (and not hedging) why and how things work the way they do; in
    particular that the unordered list is already fine and doesn’t need a
    list continuation.  But let’s go ahead and do it anyway since it doesn’t
    hurt and keeps things more consistent.
    
    Also describe the problem immediately instead of burying the lede/lead
    with “The options here are apparently written ...”.
    
    Also less “the the” mistakes.

 Documentation/git-patch-id.adoc | 43 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 1d15fa45d51..45da0f27acd 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -33,27 +33,30 @@ OPTIONS
 --verbatim::
 	Calculate the patch-id of the input as it is given, do not strip
 	any whitespace.
-
-	This is the default if patchid.verbatim is true.
++
+This is the default if patchid.verbatim is true.
 
 --stable::
 	Use a "stable" sum of hashes as the patch ID. With this option:
-	 - Reordering file diffs that make up a patch does not affect the ID.
-	   In particular, two patches produced by comparing the same two trees
-	   with two different settings for "-O<orderfile>" result in the same
-	   patch ID signature, thereby allowing the computed result to be used
-	   as a key to index some meta-information about the change between
-	   the two trees;
-
-	 - Result is different from the value produced by git 1.9 and older
-	   or produced when an "unstable" hash (see --unstable below) is
-	   configured - even when used on a diff output taken without any use
-	   of "-O<orderfile>", thereby making existing databases storing such
-	   "unstable" or historical patch-ids unusable.
-
-	 - All whitespace within the patch is ignored and does not affect the id.
-
-	This is the default if patchid.stable is set to true.
++
+--
+- Reordering file diffs that make up a patch does not affect the ID.
+  In particular, two patches produced by comparing the same two trees
+  with two different settings for "-O<orderfile>" result in the same
+  patch ID signature, thereby allowing the computed result to be used
+  as a key to index some meta-information about the change between
+  the two trees;
+
+- Result is different from the value produced by git 1.9 and older
+  or produced when an "unstable" hash (see --unstable below) is
+  configured - even when used on a diff output taken without any use
+  of "-O<orderfile>", thereby making existing databases storing such
+  "unstable" or historical patch-ids unusable.
+
+- All whitespace within the patch is ignored and does not affect the id.
+--
++
+This is the default if patchid.stable is set to true.
 
 --unstable::
 	Use an "unstable" hash as the patch ID. With this option,
@@ -61,8 +64,8 @@ OPTIONS
 	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
 	databases storing patch-ids produced by git 1.9 and older (who do not deal
 	with reordered patches) may want to use this option.
-
-	This is the default.
++
+This is the default.
 
 GIT
 ---

Interdiff against v1:

Range-diff against v1:
1:  0520e8f9caf ! 1:  e5ad12cc3b3 doc: patch-id: fix accidental literal blocks
    @@ Metadata
      ## Commit message ##
         doc: patch-id: fix accidental literal blocks
     
    -    The options here are apparently written with the assumption that you
    -    can continue a block like e.g. a description list by maintaining the
    -    same indentation level.  This is not the the case; you need to use list
    -    continuation (+) for the elements following the first paragraph if you
    -    want to be guaranteed a predictable output
    +    All the final paragraphs on these three options are rendered as
    +    literal blocks. The intent was surely to keep each of them wed to their
    +    respective description list items. But the attempt at maintaining the
    +    indentation level of the block causes each them to be interpreted as a
    +    code block, since code blocks can be represented using indentation.
     
    -    This is kind of subtle since only the last paragraph of each option gets
    -    rendered in an unintended way, namely as literal blocks.  This is easier
    -    to see in the HTML output since the man page output just has a slightly
    -    larger indentation on these paragraphs.
    +    We need to use list continuation (+) in order to keep them wed to
    +    their blocks.
     
    -    Let’s use list continuation throughout, collapse the indentation in
    -    front of all paragraphs except the first one, and wrap the unordered
    -    list in an open block (`--`).
    +    There is also an unordered list which sandwiches two paragraphs on an
    +    option. We don’t need to do anything about that since it attaches to the
    +    description list item without list continuation (i.e. it is already
    +    correct). But for consistency let’s use list continuation and an open
    +    block on it.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.327.gddebdc8c038

