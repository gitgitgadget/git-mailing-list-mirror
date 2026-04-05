Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807030FC0F
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775385195; cv=none; b=nm3C3SAJpUhn+hV5QDPAcEI6DnNxbld6lxAfcQkcxS/o2OfiS97HZCLjcob1XlpZ91nKHEIcEnFT47Y6zOfi6320QBd+hbmpKHYyZdJLhZOR4WMakZQIcOUqgP+YwDOIz4NQZ+1H2dIiYZj8ZHc+9DjOB9bq4czqDurRBa65fAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775385195; c=relaxed/simple;
	bh=BW99STgPr70J1xyps3rT1+9BmqyMDfmHclZ4+v5SNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGTh/eMiy/elb6FG7KFm9+cVTNxjkFsDZsk0KAlkJnu1EDqn6WsvUiWrAxj2ngmNbhxQlrwHUWOyKaCHxltVCAxKN/BoW/ALsHmqI967oyh6K84M7iOL5Gvm7LgJR+LcHmJnS13yzH/uc6nGkKaBz0rubkJCZXB3KAAgJvApNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=A7fMvbPQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUL35kfG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="A7fMvbPQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUL35kfG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BB0DCEC00C0;
	Sun,  5 Apr 2026 06:33:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Apr 2026 06:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775385192;
	 x=1775471592; bh=VFR1Pr0kjjQcc9Qbx5uUKGKXcww038EDVU4JrLyTKwM=; b=
	A7fMvbPQ6t+GVK0oYXvKIGGi6+GPM9zr7b8M9kHaEeiFCau/alktD+O7t+1jCIOo
	Gd6zY3MASg8WO2Y3tdcrwLqQZs/IVwkptGYsc1W5SucJh9M7ShB7MNwL9nMmssuR
	nEapUStMu8VYtQDJToToVzzQ3hg2GCbTk9D5c1UM/wFjGScBvgF/CTR87xm1CKQx
	cyvw3jWSc/dR8tbVWj88eFU6efm1wiv0jvA7dDZyUMMEr6CI+rErxvmHG6ihrGKx
	aJXnUF20paHKpTd/AyNrSoYQX30nEfEIga1xe/ypdii5thDhYfZoj6mAZEzV6PI0
	zQU2imUGuGgwRiw84eEsjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775385192; x=
	1775471592; bh=VFR1Pr0kjjQcc9Qbx5uUKGKXcww038EDVU4JrLyTKwM=; b=K
	UL35kfGZ9FM9vLO4q/HaC1OSkEvS4CR4WpRTTi93rDqPHUHxWr5jOwpEG37kYo3d
	NF0WiTKlWM06VZZEPtmYNB5XKQwo1YFYLFzJROZ9bwdnM3+6trKhaD0lS7lmTIwq
	R8wF4XotK+EVvuY1O16+xAvWHa+J76Df1IoBvumidpRJj3qhSQVH2ixq06DVh7HU
	8B1orhgpabHS9KnxTVK8o+xP1Vr4H0f7o6ETfNnz0Y6wbzkuuLdBQRbNiw94faQk
	nYWL3mYG41T1HdWjjk2raex1Z4i9A1EaGOHkKtxRQ/Xju5ZsxEw5z5SVyGw6MTiT
	CVqHRWA6VjdC5J6FO8Yhg==
X-ME-Sender: <xms:aDrSafMxUbk67p4vzo4ebQ1FJveQlvIWa2heIEbGTDob19amKO6UeEI>
    <xme:aDrSaf81Cnmqx4mk2iNoy8zWft1JtGMHFND2dukXrJ26Efm2oTpSX2yFr6xl32ggr
    q7BDh5GhK5s_D87MEC3IHmLMnvkCeIyv3dwRE-F85f05CEPKSodzg>
X-ME-Received: <xmr:aDrSab4NOdNcPZ9d0O-5sEdyAHQILQGNZOhCT4vlHUWLuOYYfWQETcmLn70WPoN5T7a55PgaznEwpV9f4A_qoM1J4ovWFYkMMEhqmt7akcZN6fYNuxxbzDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:aDrSae3Wpcirhn9UfkHfEHqrrftlHOPqt3ZZYAF2Feig1_bneo9LAA>
    <xmx:aDrSaaDu9_8V3dnybUgC9FBHfp4t9t2G2gyle1X9UgQNYJOr61neDA>
    <xmx:aDrSaY1FDBa1oEaNaGOk7QBzbVKZ6CXx4BVjRf4YfHMisG68XJnqBQ>
    <xmx:aDrSacv9RqlXYaQMuu3hv3q8GlAwvSBRl4spoXhYnFde3eHTu2pg5w>
    <xmx:aDrSaak1HVy0QO9cFVBih2V5RY9Z8LDvSqG5M7dXytCjYvTcwXplcMQ_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 06:33:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/2] doc: replace git config --list/-l with `list`
Date: Sun,  5 Apr 2026 12:31:59 +0200
Message-ID: <V2_doc_config_--list_replace_all.56a@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz> <V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Replace uses of `git config --list` (short or long) with the subcommand
`list` since `--list` is deprecated.

We will change the “man page” phrasing in gitcvs-migration(7) in the
next commit, since we are already visiting that sentence. But note
that we leave the “man page” phrasing in the sentence that we touch in
gittutorial(7) since it’s a tutorial and not a manual page. We can be
more wordy in a tutorial context.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: Now do all the deprecated --list/-l changes in one step
    v1: (was spread over the three patches)

 Documentation/git-var.adoc              | 2 +-
 Documentation/gitcvs-migration.adoc     | 2 +-
 Documentation/gitprotocol-v2.adoc       | 2 +-
 Documentation/gittutorial.adoc          | 2 +-
 Documentation/technical/api-trace2.adoc | 2 +-
 Documentation/user-manual.adoc          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index b606c2d6499..697c10adedc 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -22,7 +22,7 @@ OPTIONS
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of `git config -l`.)
+	is deprecated in favor of `git config list`.)
 
 EXAMPLES
 --------
diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
index 1cd1283d0f8..2883834b714 100644
--- a/Documentation/gitcvs-migration.adoc
+++ b/Documentation/gitcvs-migration.adoc
@@ -49,7 +49,7 @@ them first before running git pull.
 ================================
 The 'pull' command knows where to get updates from because of certain
 configuration variables that were set by the first 'git clone'
-command; see `git config -l` and the linkgit:git-config[1] man
+command; see `git config list` and the linkgit:git-config[1] man
 page for details.
 ================================
 
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index c7db103299a..ec2562fb0a1 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -659,7 +659,7 @@ use by the client, MUST indicate prerequisites (in any) with standard
 applicable.
 +
 The advertised URI may alternatively contain a plaintext file that `git
-config --list` would accept (with the `--file` option). The key-value
+config list` would accept (with the `--file` option). The key-value
 pairs in this list are in the `bundle.*` namespace (see
 linkgit:git-config[1]).
 
diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
index f89ad30cf65..519b8d8be2c 100644
--- a/Documentation/gittutorial.adoc
+++ b/Documentation/gittutorial.adoc
@@ -432,7 +432,7 @@ bob$ git config --get remote.origin.url
 -------------------------------------
 
 (The complete configuration created by `git clone` is visible using
-`git config -l`, and the linkgit:git-config[1] man page
+`git config list`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
 Git also keeps a pristine copy of Alice's `master` branch under the
diff --git a/Documentation/technical/api-trace2.adoc b/Documentation/technical/api-trace2.adoc
index cf493dae03f..918e517c2e6 100644
--- a/Documentation/technical/api-trace2.adoc
+++ b/Documentation/technical/api-trace2.adoc
@@ -1253,7 +1253,7 @@ it.
 $ git config --system color.ui never
 $ git config --global color.ui always
 $ git config --local color.ui auto
-$ git config --list --show-scope | grep 'color.ui'
+$ git config list --show-scope | grep 'color.ui'
 system  color.ui=never
 global  color.ui=always
 local   color.ui=auto
diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 76969871176..3cd94c7afa1 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -2865,7 +2865,7 @@ stored in Git configuration variables, which you can see using
 linkgit:git-config[1]:
 
 -------------------------------------------------
-$ git config -l
+$ git config list
 core.repositoryformatversion=0
 core.filemode=true
 core.logallrefupdates=true
-- 
2.53.0.32.gf6228eaf9cc

