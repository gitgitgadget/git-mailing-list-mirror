Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7236D9F9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143208; cv=none; b=mX+VnxvDFpxcFFCJJi899GmvQc+BXndTIQ8kfT01AeD8XYrWCmhCBdEDF+Ky2eb9n6rbCoqE5OdG/tJKbwZla+r+R0o6+BQ5JvesY+l9ENPYKyx5n+D19prdQU+Uh2YWSPQ0x84yYBdfWq/ZpxnqvchpSf9RjbTHUrKnzYd8A/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143208; c=relaxed/simple;
	bh=h4H9F8GYSSX1cmaDFdlrUBhzqDDK6dfwdPXsyrujy5k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=inCEYNyu9lV5kXFVvn5gsn1evG/3D0nnhbWiIz/egLRN8eJxK9I+lpoHX9r/ePUxkpai3hokreMBLRys7homWgtHOz5BEIe5PrxBRZxcMR/W1Kdy4zeiTHsheVGuvpRhcpbYgAUlja196QhD5akvWQbJTthFNk2lXSlNG12oC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk; spf=none smtp.mailfrom=git.strova.dk; dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b=AE1pBkKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1sNEPE8c; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b="AE1pBkKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1sNEPE8c"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16C39140023A;
	Tue, 10 Mar 2026 07:46:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Tue, 10 Mar 2026 07:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strova.dk; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1773143206; x=1773229606; bh=aG
	vRy3p7bIrnNrST/eJcMV4slobB2fvJQX4UbEcn7Ac=; b=AE1pBkKcaybXJNTVXS
	8Vs5Nb7qONN6qTNnI8f2MzHgzzxAdqB9h3zaD+Admt0+0mUcSGw4ggDy9fFGLgcm
	A/sh6cZ8NWMya4JMwp+XetuhgBQQ2pGNfUTtBfXehfRQPDTxHqkAeGxhXqOBh5ce
	2MWtDTy8QWHKhjwBDe5o8UNJgbxps7EchVvlOdlYoNhlh1/EkzFkfQJvuBGXe3Kk
	dXEgIdHK3kYkpKXHYuIAAs001BZ6Z8x/5UYpWR7R7AyXyyFE7FicbvHAItk8EH0P
	zeqCCmQKHR3ThJ6/0zEb4qaSb648WcbAshsYAgfKuscQ3jMmnbSuCmor+6z+84PB
	Yuog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773143206; x=1773229606; bh=aGvRy3p7bIrnNrST/eJcMV4slobB
	2fvJQX4UbEcn7Ac=; b=1sNEPE8cfSMXVuRIPWIRMYLTktN3KHBPjM29TmY7KOND
	AJ+azKpeVx8n69XfJ8Vu1MTtyRe92idYZE1sLYfDqiL5j9Aa6qNbqvLi5EQXzXTF
	9ewsSc1bflsY87ZC2CtVFGIQmgzuLRNDG8XHfEMNsFRKGGKZQTVD9y0tiNocnbZ4
	cH1vwgrkyP4bjdyfO8GUdzoYsxsKcNVOqb8vfEqtZCSKmFXR/3gSUupfm++09KwT
	MPgDMyBH3js9n/RKGPrFeI0Ei0qpc/N+XKTz7S+qbuu10qUa+xTlOMUg3xvujzt7
	r7We3bMmK01jET8u7ZfYbzYCYsLDZlCg2DuhoRQA3A==
X-ME-Sender: <xms:pQSwaY7KwIk8OR-tGUcoRBTdxazAnXPStwVTKdEyQcBAIuFQJijFXg>
    <xme:pQSwaUumiJfaVAu0LIwhig80UYz-1cGttQxPqVKLQGdlDUUzBPMCMWpK0D75RwIZA
    vNw65DCwX7rwLcRrLAWSIRCAA2KcJDy2CiA1isQN5qfYLj8adjvm1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrthhhihgr
    shcutfgrvhdfuceomhesghhithdrshhtrhhovhgrrdgukheqnecuggftrfgrthhtvghrnh
    epudeghfettefghfekgfeltefggfeuhfehfefhgfegudeggeeiteevieelteeiieeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesghhith
    drshhtrhhovhgrrdgukhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohh
    hntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pQSwaWhraIensrgeceNr5IA44vB5GmljzNCi1GyQgaeOLEfzZSadEg>
    <xmx:pQSwaRGLIv4qgca_3TRwxRj_W4ikZw6MYfolXwgmvkZJogzYoMM9Lg>
    <xmx:pQSwad_XLKN-2NcTm3BnASHdU-Nt4NsA8Z_dlVWzzjB1TAcOfSh5Fw>
    <xmx:pQSwaQw_B7Z_iWIrDqLkp_cKOFWrVWhLwRouy1RtdNynEizLd3uOwA>
    <xmx:pgSwaYm60To4RBqlLpBKVGtuUwi5GQmfsGH29-mg9zpZoeWHoB6-5A5q>
Feedback-ID: ic5d648a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D293700065; Tue, 10 Mar 2026 07:46:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 11:46:01 +0000
From: "Mathias Rav" <m@git.strova.dk>
To: git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
Subject: [PATCH] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The `--object-id` option was added in commit e1068f0ad4
("merge-file: add an option to process object IDs", 2023-11-01)
together with a call to setup_git_directory() to avoid crashing
when run outside a repository.

However, the call to setup_git_directory() is redundant when run inside
a repository, as merge-file runs with RUN_SETUP_GENTLY, so the
repository has already been set up. The redundant call is harmless when
worktrees are not used, but when run inside a worktree, the
repo_set_gitdir() function ends up being called twice.

Calling repo_set_gitdir() used to be silently accepted, but commit
2816b748e5 ("odb: handle changing a repository's commondir", 2025-11-19)
changed this to a BUG in repository.c with the error message:
"cannot reinitialize an already-initialized object directory".

Guard the call to setup_git_directory() behind a repo pointer check,
to ensure that we continue to give the correct "not a git repo" error
whilst avoiding the BUG when running inside a worktree.

Signed-off-by: Mathias Rav <m@git.strova.dk>
---
 builtin/merge-file.c  | 4 ++--
 t/t6403-merge-file.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..a8768c6e0c 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
 int cmd_merge_file(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
@@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (object_id)
+	if (object_id && !repo)
 		setup_git_directory();
 
 	for (i = 0; i < 3; i++) {
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 06ab4d7aed..60cc43775f 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -506,6 +506,15 @@ test_expect_success '--object-id fails without repository' '
 	grep "not a git repository" err
 '
 
+test_expect_success 'run inside worktree with --object-id' '
+	empty="$(test_oid empty_blob)" &&
+	git worktree add work &&
+	(cd work && git merge-file --object-id $empty $empty $empty) >actual &&
+	git worktree remove work &&
+	git merge-file --object-id $empty $empty $empty >expected &&
+	test_cmp actual expected
+'
+
 test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
 	cat >expect.c <<-\EOF &&
 	int g(size_t u)
-- 
2.53.0

