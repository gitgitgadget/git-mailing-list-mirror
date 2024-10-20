Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7DBA33
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443445; cv=none; b=aL1Qeirb9aXeQ1azydb2tBHFyDtaHyAoCACZyOzM/+0V+PIRZnUXnvTg/ywDypk6oljJtqDHF+cZRFVWews8u7VwJ7cURVVZTaBNFt2oipu9CDvqaMOEuhyzjj5nu9a2VQUfnaHCkFxA27pfnC8vS5Ol2YuPJT2jmwjP5MMiK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443445; c=relaxed/simple;
	bh=/PTfDwZAmG+SxknLWw6ILu2Ak7+b7k6riPXbWB2exXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEfp35XijJpxNgfPJfYbPp32ukSc0TGIq8PQLiKM7Eb444Gn3+yvpZhxGnJf7T0mrunadXp9w6Io2UDwiip2FqzUuvqI8fzHNYL+fjDBzbO6l3iE1CiSNPXZMtyf/UfA455CEGitWThf1kNzu269h3EemL8hbaMjKLFizSIUC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sekwUYqw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0YvsbIE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sekwUYqw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0YvsbIE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B95B213800A4;
	Sun, 20 Oct 2024 12:57:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 12:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1729443441; x=1729529841; bh=Eu
	fAKSvioaUXWfPTMuDjFriC2HE+gwWd+on5jSM2uSQ=; b=sekwUYqwSjFNpGz3YB
	6jPZrpawp/v5rY4brFW0GFCW7+drrVQExAmSeOTjCaodYxT1FN/ZMIvPE3QUSJ7e
	0lf0wNSW0TdLCO96lcH3+JNKcnDYrzB5/2veCSVl3ndLWQ/TEFHglk1WCiW3oyTE
	uudxW8mRm8//d+zKmNku+e3bs++YHQsoNMglXfLwTGrQYHtIzPGuGvAAUy5chjK+
	URJpXYwvhSzMB63d/f9qTYeR4Q9+9a+P35r7DYOVX1i3kgCpV/5g1Fw1Rw0CdGQD
	n0wQH8Rw50gIZdL5hpIJOHTiNmE6Cuzg7mNlyjfHddJYSfhopJJzhQyr873CexvY
	ZyFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1729443441; x=1729529841; bh=EufAKSvioaUXW
	fPTMuDjFriC2HE+gwWd+on5jSM2uSQ=; b=g0YvsbIEViA/Eoo7/OwU1x7+RtAsH
	eiKIsv5FnuKl8AQZ2yrS64er57Xt4Dv/koFw1UKncildJop6jNH+hmd65blSW576
	CI2MEu/g8eMwXVn2ribVRIe8pslX6jIKvNaAL0zpsPfyXgvEyYyGba0k8fIFeIgt
	BCdKySNzXmKVNwiqcKy0TJxBASbG9g+qdn9LpKCp3WOhoHH5cnr1CkMo9oeOvzfX
	qlOFOPT/2ioRrxwofaGA7OiNnpY/ymnaysKoyPq1jP7DaqBUyNC0ERDzT1p18DZF
	KXo480GVUuPcmcsOoWoWIF5TJYmCrsl26umhWib5VwLX4N8KqMOcOvetw==
X-ME-Sender: <xms:cTYVZyGd6MnkPP9KjutzE_UeRDyyhruYVu0GKmSi1VJliZV5dHAQnSY>
    <xme:cTYVZzWpmLVd70Mx-oYxM4q4sOe4CvfKHXPtazzjG3oS56pcvWnyb03j9st61Uk2_
    dvdLo3CW-4BuXLGag>
X-ME-Received: <xmr:cTYVZ8IBQmRX5GCnslZ4s8pXGpGl-UOxSAni6c69JeYb9YjP4ct_HACojmqpI41Q_kR5ZJ9ZLnuhj3Aq6FOEQPAEpVpmkCa9RBSFlb9kuL3wJ4_8AveUe0ZrHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegffeujeej
    leegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhsohhrvghfsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:cTYVZ8F3ah3N18sRMuSZe_tLHxmlc8k58J0jDFOlnMczNsC477UcOA>
    <xmx:cTYVZ4UnHC7nFL7mHethKBlO70RGc4mn45ZIUzPUg97x38RvjZa3kg>
    <xmx:cTYVZ_PtADMHMf3Z_AX0yH6jXvl53ryQHjkJAQOzqwzCnbz22SzMyw>
    <xmx:cTYVZ_0zzxW9cVcQ5JeJw1oF3h2-cAEO-PacKZfXOioUDBBEITSTvQ>
    <xmx:cTYVZ_T-r13lDQ_hovNSPP59dltlODMe_EFpTkgIjKxW7PHOcRTCaOWb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 12:57:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Josh Soref <jsoref@gmail.com>
Subject: [PATCH] SubmittingPatches: tags -> trailers
Date: Sun, 20 Oct 2024 18:57:01 +0200
Message-ID: <d3a1ba01104da8496d52308c07c5c274fd30b0c2.1729443395.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: d3a1ba01104da8496d52308c07c5c274fd30b0c2
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

“Trailer” is the preferred nomenclature in this project.  Also add a
definite article where I think it makes sense.

As we can see the rest of the document already prefers this term.  This
just gets rid of the last stragglers.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Commit message:
    
      “ “Trailer” is the preferred nomenclature in this project.
    
    Must surely be true since git-interpret-trailers(1) does not even
    contain the string “tag”.
    
    I did a grep in this directory:
    
        git grep tags ':(exclude)RelNotes'
    
    It didn’t look like there were any other mentions of “tags” in this
    sense.  Of course it was difficult to look through.
    
    +CC: Josh Soref <jsoref@gmail.com> based on
    e.g. ac9fff2bf1c (SubmittingPatches: discourage new trailers,
    2023-12-28)

 Documentation/SubmittingPatches | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d8a8caa7916..db17bc7fe2c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -412,13 +412,13 @@ Also notice that a real name is used in the `Signed-off-by` trailer. Please
 don't hide your real name.
 
 [[commit-trailers]]
-If you like, you can put extra tags at the end:
+If you like, you can put extra trailers at the end:
 
 . `Reported-by:` is used to credit someone who found the bug that
   the patch attempts to fix.
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
-. `Reviewed-by:`, unlike the other tags, can only be offered by the
+. `Reviewed-by:`, unlike the other trailers, can only be offered by the
   reviewers themselves when they are completely satisfied with the
   patch after a detailed analysis.
 . `Tested-by:` is used to indicate that the person applied the patch
@@ -436,7 +436,7 @@ While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
 highlighted above.
 
-Only capitalize the very first letter of tags, i.e. favor
+Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
 [[git-tools]]

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

