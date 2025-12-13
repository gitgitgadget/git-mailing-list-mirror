Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E261B0437
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765633683; cv=none; b=k2IGS4KrZKS/+YmwR9Qb/11Jrw7Lhfxz09kDzvyzlDvlW6et6Y9Z1CC6b4tGPFTjQoWcSniT+BtTFXBdpVV+OsbSPDa4Wsqmosy/kBBOXsKfywHup7lByDiT1cqHHvofIKxaG71fJxwiKVju8xiXmr2IGsmmh+bQj7AMVxK1V/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765633683; c=relaxed/simple;
	bh=EGOwYcLNp5/H6c2nLEPW0ZQKeOqsKkoAmpe/pbogt7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMMfsv/A1QWA6kpco182BH7JsuTdY54zDmA7vCFERl4cn0+3pKavQcHzMdq+hhwIOelLQD4XjrWtCiB1g+GdIhkRB5hPSVGO3roTExRqrrm0zNoOAlTnspatckysNe/UyZa6U989l9JRI5UNeBFpVfrvHcfLyStV/5sV8CU8Qbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RCRZiDoX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibdXKOj4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RCRZiDoX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibdXKOj4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90A347A003A;
	Sat, 13 Dec 2025 08:48:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 08:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765633680;
	 x=1765720080; bh=HIiI0o2jRJNTYtu6hKZkjC50/+DqMBkV7p0oxIqP7Tc=; b=
	RCRZiDoXgkVzLVi/aME3An0kN6Bv0RVt+BMIGEx6iV7x1PTRsseEuz7oshKM8lOe
	Eq/zAu8FKt64dXYrBJtGkGmP3pxzZNRjUNHImUBN9rzwLkTgElksFCTdbJ1m+yNX
	gJJ+xWIhkyjYyDxfR9HqqfWzF19KbZ5hjS+WeBzBjqV2BkjacNNZb8fOk5lUm74B
	4352IAjUZqxmGhQAyq7zEDlrYMHbgk1SNtzFoCczEEznj3Jx6HnWTxR1nwtNf+Ju
	qA/LJ0JL9WORepGyfmOoOW9+4T6YHr64BqYI/kfcEUqQzNZfS85hbfOy0wflGOTF
	MHLiyT76cAdLox1deheJKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765633680; x=
	1765720080; bh=HIiI0o2jRJNTYtu6hKZkjC50/+DqMBkV7p0oxIqP7Tc=; b=i
	bdXKOj4A6YwDuSdKhXDHq1lz0K4+cNf2raJKbXc7r6BG9BKnjALzmGbY9ohGweT/
	sQiF0bc8VbKdHS/su5l9wf8aK64ImocA3cHTFgw4qzF5I+MkG2KgWj+WgowjeenP
	0BPBid5SoSzvjs73EjDk/UgU5oVB8ry1JS6/tJE87rnCmWMv4eZp3xPhAm5sEBog
	Y5BXvQtgEKxwVCy9b3YEeh2L81ehNStsy1mIrJDQDz3RvtrLkFe4ldaM0MHBR+WA
	f7w/KEx6Pq2knyclt2FNie6oTHr5uYhBgIZRu3QOVxJ1YieTIkIQBpKChfeA89fu
	ea+sQSd/YEK4YZ4MZ+A6g==
X-ME-Sender: <xms:kG49aYXOzTQX9yttjjsTMre2nNUlGm1QHtt1jGEajit07fgVpnrDu9I>
    <xme:kG49adTad6rZ_Eq_o2QJrgKwI9_n0BNyXsnG206Z0QMyJe6g-bGGm4EnGJQxhgfvP
    enwjB8TKChFAAp0vyt4sCsZCNfzSwIBAv_8rNyKesaN7G4NQbLH1xA>
X-ME-Received: <xmr:kG49aal4xx65Ks4_gXC4MJfNVaD5rv33ehUg9bU-ZM2A2ZaCUc7iw6wOJ5-Cx8hfNpKfEE41fbQVrvLf_TRfk6QZBapxjbd6xAa2XLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdr
    ohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kG49ab6Vb22v4ZUGavRaUMCKZCGwiOxdPnmRdcCiL8zYcjc1MPn6gw>
    <xmx:kG49aYjRDRxw7tRr79JFrgUUQC80Cqi7jek1yH0KdvEup0ati-GNQg>
    <xmx:kG49aQFi6wPvjz2R2raQEHYDLpKQoZoPq2vz_45cvrKIhegYhrxiNQ>
    <xmx:kG49aWRevu-UUQ1rCtC7cdbGB4egO9pRNiYF3QGKl5FjE2gATucXmQ>
    <xmx:kG49afiFsKO_aIDGixzEQvl-l8-CVswfakEDVnkOptCqcXcLhEvGJnYU>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 08:47:58 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 2/3] replay: improve --contained and add to doc
Date: Sat, 13 Dec 2025 14:46:57 +0100
Message-ID: <V2_doc_replay_--contained.131@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_conflict.12f@msgid.xyz>
References: <CV_replay_conflict.101@msgid.xyz> <V2_CV_replay_conflict.12f@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There is no documentation for `--contained`.

Start by copying the text from `replay_options` in `builtin/
replay.c`. But some people think that the existing text is a
bit unclear; what does it mean for a branch to be contained
in a revision range? Let’s include the implied commits here:
the branches that point at commits in the range.

Also use “update” instead of “advance”. “Update” is the verb
commonly used in this context.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Don’t just copy `--contained` over. Improve it on both sites after discussing
    with reviewers.
    
    Also mention that `--onto` is required.

 Documentation/git-replay.adoc | 4 ++++
 builtin/replay.c              | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 6fbb527b9d8..1e2469b9034 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -42,6 +42,10 @@ The history is replayed on top of the <branch> and <branch> is updated to
 point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
+--contained::
+	Update all branches that point at commits in
+	<revision-range>. Requires `--onto`.
+
 --ref-action[=<mode>]::
 	Control how references are updated. The mode can be:
 +
diff --git a/builtin/replay.c b/builtin/replay.c
index 6606a2c94bc..9e5ad64cad6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -377,7 +377,7 @@ int cmd_replay(int argc,
 			   N_("revision"),
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
-			 N_("advance all branches contained in revision-range")),
+			 N_("update all branches that point at commits in <revision-range>")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
-- 
2.52.0.10.g08704017180

