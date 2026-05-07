Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA12C0F81
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182965; cv=none; b=gqWhyC9snEOAPaXLeeEPCBqMBnwfWsW6H4ZfhiEKqRbPZoBPTppY/fiSbCJ0ZFsjgt/H8wDMWVG978EUhKzJm3hvCRXatgT5VatdUAOXhZ71G0A4LPLxBmzfEMP/dbrmd6oxQ2e3h/lcYgDO9PoPXPESDdBeZPcUroT6x3Wk2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182965; c=relaxed/simple;
	bh=0JVdfyqTsHJd/dll2tfn/IIeor4tIoiiFWffdJlueVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVc2W5Szv0DCmCBi1KiuqsrhXAcOutjcM/oc+UW+Rwlh9zscCNF/aMnC+ESD3oQfCErEejuz3MQFMIewv9i5P2tjjeIMsfKcxWopr8PTxrc3kfWzNKbCNxashb0uvW7rH2Tmn3YOOU4Ke45h0Ej7Qm/cLHskZOy8UaWHNuoLXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bsJFBZ54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJ3DL/sL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bsJFBZ54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJ3DL/sL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5189BEC00CD;
	Thu,  7 May 2026 15:42:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 07 May 2026 15:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778182963;
	 x=1778269363; bh=CdidIhNGZ7aNv0OlFIz3XLhne13fKtnIoS7ylBPxhXI=; b=
	bsJFBZ54+aTf6fJJpiKtpsRAyfUOaXPqmHkKkGJnc+Cl+AfDOBv2o98/XjKEXUwm
	etH0Cfttqrv7fILZzeMK3O8YlsJb6McNVBybdqyi/pZyX4quBP7y/PqoFZ3+PFNm
	TdfPgnN1xJWNzvEuEuutdfWR9d6poXPgrcOAKqHsooS9UP0m9bhX+PBBmdthyXMR
	Zu2Zae8jfEdm0r11UnncX2WBKleXj1xpDvFxKvEOUJF42rbvYA0Egt2FG/jhI3yA
	N23ve0jrG7jeoi451Zl4pTT57fYCYCZe/+qbYd8BSAlwKl0ONYgfuyW6yKPasXki
	4M8cl3qM08gHauQWDBKzgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778182963; x=
	1778269363; bh=CdidIhNGZ7aNv0OlFIz3XLhne13fKtnIoS7ylBPxhXI=; b=A
	J3DL/sLOJ+jvNfBYYL2nN1j0t2has31FIyhJ0nhxsHICpu1ihG70V/fc+5OtzbQW
	T0RQkYsSpbMMK8S5osxYifVSH5oO5AKCO5W/jl1gdrH/ZSe4RCF8vUkwU9rnThAq
	+UqaC8LUrsv0delj1wZbwBb8zR2JvoIKW++9yLBaZ8MhjEDjA4BqaBRDy/onVLdh
	P9RkBlnmpOJHS61j+JN8ffz3YmTkfOqxPpKrXxWZBwa9q6nlY1UhznyTsO93pRAm
	cP6R6HZH9sEnL5y+6q2Cl6vuGMp6o2dO/aL+v+pVWa4UFq8LwFO5lSyuX3NApcel
	VE8uXAnUjo/I6livH8Fag==
X-ME-Sender: <xms:M-v8aULHBppdvfmVLxCAGXjRLqRUNbswfWK3QQEhRQY88g6V0R2G-Cs>
    <xme:M-v8abkakkom40ghyaoodHxp0Jp_n2IiuHGCTIJ_9zyfouhn57jLkHF-c_7GnmdwE
    8APqTi0s81QgBdtH2GYXMQ-z1Yjnj71cgQFnmyuUBEbOpnKp0MKf7s>
X-ME-Received: <xmr:M-v8aSGfQUlq0t4vmLIA8gUni8azRcdnQ2wWNazs3iD5YKBcgHf97kzczlOfb3Q61jC5ydwK3WPuPyLuwNEI5VvQSjSFI0aeDBBOU-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:M-v8abHqHl8eedXbrp1HOF5RjhdXbTS2wvF5hykTO5Yn1kB6vjJ3ug>
    <xmx:M-v8afNukopYAOwWhTt6nNXyYXOe6brNGgoKpJRf51cUXPija2aTNw>
    <xmx:M-v8aaEQnZxQMqH8L5PbowGBVsOH8cs-_9yjdVWV4IWWrJDuQX4OGA>
    <xmx:M-v8aWPEDyzTL5QZwTl5Vgb32trc83eLV1T34pd1jxGq4tr5wo3aGw>
    <xmx:M-v8aTkGDp7bFiGMr4il9hRIxS_vQcTEdpPav4s_wUaskwv6OhCaEJKj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:42:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3] doc: add caveat about turning off commit-graph
Date: Thu,  7 May 2026 21:42:28 +0200
Message-ID: <V3_caveat_commit-graph.6b6@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V2_caveat_commit-graph.68b@msgid.xyz>
References: <V2_caveat_commit-graph.68b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The doc `technical/commit-graph.adoc` says that replace objects and
commit grafts turn off commit-graph:

    Commit grafts and replace objects can change the shape of the commit
    history. The latter can also be enabled/disabled on the fly using
    `--no-replace-objects`. This leads to difficulty storing both possible
    interpretations of a commit id, especially when computing generation
    numbers. The commit-graph will not be read or written when
    replace-objects or grafts are present.

But this isn’t mentioned in the user-facing doc. Let’s mention it on
git-replace(1) and git-commit-graph(1).

Acked-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: Add Ack
    v2: Incorporate “performance issues” suggestion on git-replace(1)

 Documentation/git-commit-graph.adoc | 6 ++++++
 Documentation/git-replace.adoc      | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/git-commit-graph.adoc b/Documentation/git-commit-graph.adoc
index 6d19026035f..f2a37e91634 100644
--- a/Documentation/git-commit-graph.adoc
+++ b/Documentation/git-commit-graph.adoc
@@ -146,6 +146,12 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph. See linkgit:git-replace[1].
+
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-replace.adoc b/Documentation/git-replace.adoc
index 0a65460adbd..436a0e58caf 100644
--- a/Documentation/git-replace.adoc
+++ b/Documentation/git-replace.adoc
@@ -145,6 +145,13 @@ commit instead of the replaced commit.
 There may be other problems when using 'git rev-list' related to
 pending objects.
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph, which can cause performance issues. See
+linkgit:git-commit-graph[1].
+
 SEE ALSO
 --------
 linkgit:git-hash-object[1]

Interdiff against v2:

Range-diff against v2:
1:  82faa72f7bf ! 1:  fb5ba74ea3e doc: add caveat about turning off commit-graph
    @@ Commit message
         But this isn’t mentioned in the user-facing doc. Let’s mention it on
         git-replace(1) and git-commit-graph(1).
     
    +    Acked-by: Derrick Stolee <stolee@gmail.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-commit-graph.adoc ##

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.54.0.13.g9c7419e39f8

