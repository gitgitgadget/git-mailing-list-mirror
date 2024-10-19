Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4B188CB5
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368026; cv=none; b=XoPpzugmsoG2Lj6QLDfBp+PpgLKSYpae0Q7u8PE8pkvMSa3ha9Pi3pobefGYL6zD+Mx6tNkOHovgVNun1hMgMmmiGm8qOG3Do8PPOQWLcXhBivW6Sst1sCEWy97HSJ1Htv0uZjlPsAtucCDwIa9KrbJam3a/CQqhu2eLIMlUP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368026; c=relaxed/simple;
	bh=mQWXbJCo3ZthSAMX1YkIYlCRwPG5xAphUX33efYRg00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A22mD7p0kjUlm8LLY5uFAEyYbpup/7ExsnOsLs0vIX8isd8ryEn2sGz7nfulA8VAJkLvwS68yudb/xjWeKpqyq9oEMbvp1KvNvG5Tk3429gFWr+oPwsAjLKTZzKrvGi/bZ6weSv1MvKvSzQU0tOlnjySkQ3I/nobni0hQWAN3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GpfkOuM+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3kF92AT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GpfkOuM+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3kF92AT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C25D1140092;
	Sat, 19 Oct 2024 16:00:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 19 Oct 2024 16:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368023;
	 x=1729454423; bh=8npD8EdiYf6ydygU9OnYqaJXF5OLp1GzMK34kNOvddw=; b=
	GpfkOuM+J+Ej7AP2pVyTMQJCzN22ouvgIndUb90chXiLbe5MZ1jSm1tbwqe4ROK6
	g8BgK389+PgZh+0RVrC+aRS3DDsjKwelzuqNraVJ2M4MEP7Xk6iH3ujXlk011AAJ
	p1396tbeUwJteBqIdYfuFYBN/Zz8Vr5heKz5by+qvl97KDTA3Fp9irHELONJR6aO
	vQFcINKyGSo0cJl8QgMcIQB9OMuzSb3RULiUhc2QQa8O8vup5Plkbapau7tpBucB
	qjfaWFxsu494dMZWNdMJrRTX7o+PLlocNkxxdNi3IigzQY/FMA2+qA7FC5paAwmH
	7UU21eA7VYD0wWbnkw4apA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368023; x=
	1729454423; bh=8npD8EdiYf6ydygU9OnYqaJXF5OLp1GzMK34kNOvddw=; b=l
	3kF92AT2Te3VhDyGLwvwUO299bHnDbIXs081zcFRIhlV1OR67N06d4e3l79zVU9g
	fPf1epxI8PWPlgLkwOnq5Hq8TW2CPDWmawnV+gpyZVL9hfO+BCtQoKxbIpFSp6CR
	nBHdGZBRbprqk/+4Sft+akG2DCChByS4M4DVNYXNVhPq1a7Vmx7r6F1cQGdMNLmg
	u5Vmhtca8nqJKY8zKngUY7cqlJyinTBBsF985oEwnt5SWJHyifypxjg9YVGqULLC
	4diNaOsTPl8F6PA95/DZ1ZBaC5NhdtC4QK6xIlrm7TEyGKLjiO+mFkdNJ9o087v5
	Oz7sVk0Qp65/Qfyebcx/A==
X-ME-Sender: <xms:1w8UZ32btWvC968UpmaRzZ5KOKJN6TcZYyBRZpcw_MAafqLwXOTru_c>
    <xme:1w8UZ2GeNwvcoAEwn8R4ZLFQQNfHDSwJP5gV_zCnpjwnZGN3dfDNdSCGUU7lQL0X7
    0MNSiPtc_gZ7fETuQ>
X-ME-Received: <xmr:1w8UZ37txdXSDNUYi9mvwtHQPDVA2C6f7LBAIy0oXWJJGWvPnMJRtsuImsY6yI3oSaYRNf2IZFgdGXTQjFqypWl6YyhRbCbbajf8BbkQpb7Rtjz6z4AamEwFbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:1w8UZ82-sFHFSpwuHJS_R8hwTVdJIvm8Rme3uo5KMdt35jS3Ww-qNw>
    <xmx:1w8UZ6Ev7Xo25lkGN_aWWVXP6vGS4iNu5iKnq4iwDCBAk1meLbsVpA>
    <xmx:1w8UZ9-JGnejkrHyQVXdKDpTMq-3bg1k1T9YiPbQ-iDDHYeN8KNOOg>
    <xmx:1w8UZ3mfXHzon6FoPA-N0-TdscSoFuKEYSoMlFfzSpSCoKWyZHVc8g>
    <xmx:1w8UZ4Yx4-c70jfkCcZXJYUp5ssR7pZHNphhO-6lDAqU59sNeWspmVUC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 3/6] Documentation/git-update-ref.txt: demote symlink to last section
Date: Sat, 19 Oct 2024 21:59:20 +0200
Message-ID: <ca786bff9783d671d5e3c36ffa35ade6029eada5.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: ca786bff9783d671d5e3c36ffa35ade6029eada5
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Move the discussion of file system symbolic links to a new “Notes”
section (inspired by the one in git-symbolic-ref(1)) since this is
mostly of historical note at this point, not something that is needed in
the main section of the documentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index ec268b1426d..c03e65404e8 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -29,14 +29,6 @@ It also allows a "ref" file to be a symbolic pointer to another
 ref file by starting with the four-byte header sequence of
 "ref:".
 
-More importantly, it allows the update of a ref file to follow
-these symbolic pointers, whether they are symlinks or these
-"regular file symbolic refs".  It follows *real* symlinks only
-if they start with "refs/": otherwise it will just try to read
-them and update them as a regular file (i.e. it will allow the
-filesystem to follow them, but will overwrite such a symlink to
-somewhere else with a regular filename).
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
@@ -185,6 +177,17 @@ An update will fail (without changing <ref>) if the current user is
 unable to create a new log file, append to the existing log file
 or does not have committer information available.
 
+NOTES
+-----
+
+Symbolic refs were initially implemented using symbolic links.  This is
+now deprecated since not all filesystems support symbolic links.
+
+This command follows *real* symlinks only if they start with "refs/":
+otherwise it will just try to read them and update them as a regular
+file (i.e. it will allow the filesystem to follow them, but will
+overwrite such a symlink to somewhere else with a regular filename).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

