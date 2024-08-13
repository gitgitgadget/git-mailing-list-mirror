Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF7188CC0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541504; cv=none; b=nCBNaz6l65IxkVf1oL4VqSS0WhaBcBqogx5/rSY6d/hPEqjNF1ovXILsB6uyWCE65ahxbimf02WteSTub2reT7A/ETvIIFUGjtdOKnRFUbVqVyDUw+srOD7SI0efKfYPQ32X6IBIHy7WETAO1oJ1lruHOirVy8AuvMy5ntAdUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541504; c=relaxed/simple;
	bh=fHENi47NfIkPY9uLaYewiOQkaHaL1EyfTnxV+ewbN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGsFspKIYwvJPianXvVUhoUHchYapIU8TiSrv6W1U5r81mLVeam7GewQqgXCdpcVWvoJ/m3J1HIN9Jen33KwGj61b0/iASGvGruPyVTEoko7Y2fGfr4+Ew4cQ6Ae3MdhY3EMPLIC/BY6IwzEHW0bcIQZ5mOOaZJsnoYOYwuONuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IE+biBkS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8nfd0kE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IE+biBkS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8nfd0kE"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 052F1138FD25;
	Tue, 13 Aug 2024 05:31:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541502; x=1723627902; bh=Iavsl7yNoX
	i27c6wjO4COJj8MMmnHYhMC7QvatEYelk=; b=IE+biBkS6FB7x5CHpHnWfdYNbq
	hNzvH9h34kpTuljFbSCldLI3zEAZcGPN3oaZuN8RC/2k4+rnFiCUIi/EGE+x5BXs
	dIivc7knt/Ql+AYh1/pRF4oIrcqOOfiZLzMwjrfLK50hQbJ5/EMke97nqbSsB9FL
	W1GI66zeY4d/NPAxOPCHSvQ4n7PCyOrGMAQvDr2+c+kAGsp4vvjOWWiRiHV1MAbT
	zve0GVOJtRhqOfvVm7A9RB7AZSTezBlqNUeB8clRKYWuEpiHoylqWL25qZZoc+8n
	do3r5L3I+Jepv0BuBbbZBDGHxwX9yaPNAP0iFWR+itHIXL41OTtgocdFqmJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541502; x=1723627902; bh=Iavsl7yNoXi27c6wjO4COJj8MMmn
	HYhMC7QvatEYelk=; b=H8nfd0kEtWvCuk1gDuP+xCOX0jtuYJYuSfzgDU9khAJ2
	Srz2FnP5Pc8DgOwncmS+C0yDuWTYCZTEWQxJ4WCVFq8w0twjE3G3ddthLmR76rYi
	0sk7nsB/rVhiRd3y7CrilM3ciEZzVWi7e/MBeSr37mZjTz1e9PYhUpSf7ZgiNUm2
	w/oWnpJOyvTzLW3Ee/VmH+UA8Dtzy3BXCqKa9/H37NHTxdg7x2O9ZcJ9Jpukh4Yq
	i+qm/dplKuH/Ub3/wV+/lmu3IlFrLCB1Srn7xaY4ghE+rGAeNPzXHwJ1ipEANIzV
	E8s9ykJ+n3VsmMi4kD5E/xRGCijtE3BG6Pw0yJVT7Q==
X-ME-Sender: <xms:_Se7Zj0SbOSQEWDZkps2xvVZuX4SXeSGAXOYAHB3CJtXHJjaLlT7nw>
    <xme:_Se7ZiGumFgA-mbTE_WSzszJZpTmv8friDJzi7iTKhSPQxR-Z6k2L9dDhf0nD9VYj
    UxpS-IWvnLHaeSAJw>
X-ME-Received: <xmr:_Se7Zj4iQAGmGACRxc2s8Vb1Ct9MN0GhZiLR2hfWfX7WkIcHz-ALpD6Bj_PtommH2J-7FGfO02pzTEaQ90ZRXJdEPynLj4TEEjYno_hqT0TM9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghsse
    hjrghmvghslhhiuhdrihhopdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_Se7Zo20HcGHhv0fVhyDcGw8piG1RK8TGYUXARuvhYv02TQLcFme5Q>
    <xmx:_Se7ZmFSHN5kSYqrTTdOXB6asNyD9IBCsNKh29M9YsWXv84vv9bunw>
    <xmx:_Se7Zp_VZJT7QP9csbGSPasPTyomxipeMhnnrBVNz5nGRq8KeZyuCg>
    <xmx:_Se7ZjlgDQqmdNcUKNUy_liY0YexjnVP-PVL2l9WgmnKGliodtyCAA>
    <xmx:_Se7Zr6ApqYWO0GKobpaiyYV_VPav04b7JC3OLj7uzit7_hTEuOzPoVm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca301066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:24 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 11/22] builtin/fast-import: plug trivial memory leaks
Message-ID: <30d4e9ed437b70a46d9b625cdb9bc4230aca298f.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

Plug some trivial memory leaks in git-fast-import(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c        | 8 ++++++--
 t/t9300-fast-import.sh       | 1 +
 t/t9304-fast-import-marks.sh | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d21c4053a7..6dfeb01665 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -206,8 +206,8 @@ static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
 static struct hashmap object_table;
 static struct mark_set *marks;
-static const char *export_marks_file;
-static const char *import_marks_file;
+static char *export_marks_file;
+static char *import_marks_file;
 static int import_marks_file_from_stream;
 static int import_marks_file_ignore_missing;
 static int import_marks_file_done;
@@ -3274,6 +3274,7 @@ static void option_import_marks(const char *marks,
 			read_marks();
 	}
 
+	free(import_marks_file);
 	import_marks_file = make_fast_import_path(marks);
 	import_marks_file_from_stream = from_stream;
 	import_marks_file_ignore_missing = ignore_missing;
@@ -3316,6 +3317,7 @@ static void option_active_branches(const char *branches)
 
 static void option_export_marks(const char *marks)
 {
+	free(export_marks_file);
 	export_marks_file = make_fast_import_path(marks);
 }
 
@@ -3357,6 +3359,8 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	free(f);
 
 	string_list_insert(list, s)->util = ms;
+
+	free(s);
 }
 
 static int parse_one_option(const char *option)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1e68426852..3b3c371740 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,7 @@ test_description='test git fast-import utility'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 410a871c52..1f776a80f3 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test exotic situations with marks'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup dump of basic history' '
-- 
2.46.0.46.g406f326d27.dirty

