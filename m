Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324B2110
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806189; cv=none; b=kirjs64k936SjO+5vAgoOPbPplm2DuYPhEfVcL+wBV28NsvmV0nwKtvlYXu5eVIU8pirCwRyEuYhYYfUrLJzITfFkcuK0064qfZ8WlHjHmGQpkPCzaEXNb5QGuNajIRzWE+FmRXGV6+cCItOl9SGEZ7uyoH+nllXom5oQeDLnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806189; c=relaxed/simple;
	bh=pqJSFu/pF6rU4XrnPPb9Fb3iXTLpDlq00X8kNL2MSb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSm4zH3uV9NWvndq7VcWDHbNRw4KbywGQSm+zFs97wRwCqBGCadjZrhr4IF9AHOGK5GWpR0gzGp9NNdCB++51oiL8zybztwwb8Y+UG5QvkoAJ2jWm5Fi8TtnfCJ1myFe+7qEMdyifS63ga9F1C52cgCh/Qjc9+YeFSgBcIlBl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YS1aMfmE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ub214UlN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YS1aMfmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ub214UlN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ED35EC027B;
	Sun, 22 Feb 2026 19:23:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 22 Feb 2026 19:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771806186; x=1771892586; bh=KUKzXEC4x7
	RZ4fGCFTBT8veqcZ8gexsSCXmkLU4UHUQ=; b=YS1aMfmEih4NrqFy99tK0/1Bjd
	J0V4z19shsH2gaGSHj/rdiDADFoPYcKyj2XQwBn3rxtSEgI3aazKAUVF/82Ttmyh
	CEc+Lnh1Ejv7Se9PyxqZWhM2FoGHXCXIvmo4k/8wYw37Y1HgtJ5X3gZxz7iR/vCf
	Y2tXxCDgpqat0fLlBacItNUEM2/62Dro1KcrlY2CrvKZ4UJLeUxB3spUf1W7w2sS
	8xkgjshAId2w46VX3swZGQp/veTci99QYkYtSEtjpcbUlBF9nsCjZLEv4TT/g9NF
	yoFzUx0lwczgEdQzxobEUSLLlyosmDdyckI2xSacd2EOceA1v4juyzBlchTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771806186; x=1771892586; bh=KUKzXEC4x7RZ4fGCFTBT8veqcZ8gexsSCXm
	kLU4UHUQ=; b=Ub214UlNRzuACws3V/tIR61t8mzDlTwPjxC/s36Rbcaa+m4ZLGQ
	6PrmdhZSs/UVeS3Q27sFvy99jnYC+kwsYSseMO5pbQ2CMZ6HOkhesJFZ1GS9zs+S
	XphYJxXtk6yMFd+c1B2Lw7FqkQzRClrwRNgQFUCYp8509eo05u50g/oGtyRZi0gr
	DKb7PonvcyqXvXpFMIYQsk6zCy3HMQGQMBECkaGEOWAxw9JvE/36Yqjfi4lFL0/c
	wDmeBPWfX73BdYEp9Wt1gc0vjoJde3RBfqC5MmslAVTO+hQB5cOHJielC1Ab0vL0
	g9c6E1Wt0C3juGaErmSY/MpaBiX3+5SC4Ew==
X-ME-Sender: <xms:6p2baSAlq_6zAWJskl2Fw1a6mnkY4nnbd8-KdbQhHh4LddhFEtMg5g>
    <xme:6p2baT-Gi92tCQNPvDrajFlnAzVeRkfQl7-CaHr6MAhHbJHNWY6FkC3bQOMBPREr5
    wffU3wN5LxuCFFv6PkzgmN2PenFAAGtqrpqGDT0Zzz1fyUdMEJ2cg>
X-ME-Received: <xmr:6p2baS_LlkdUmf4B_h-qWCmCeKhMRsV1OMC7GCQ930bnLhMH6hyVh7Hrxu5TY55Xo6rf-AqOp3EAAXZ_2qjo0x92Btgq-nbjUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6p2baadA3-_nNavjsq5x9FuwiEClCua8u-ad6G0GsFKVlWQ9RrVm1Q>
    <xmx:6p2babEMeoyFHSMUrRiBqBL5OwGWyue-ZWUa9Ya_UCct2h2sBbG2SA>
    <xmx:6p2baYfuG7MiZq5GHirgegNGH0zMDaTGztbk0wPW69Jd_cw0zOYYpA>
    <xmx:6p2baVHjeL-wVubNtA7jHQSiynnY-SqlCa7SBdSSMl8qSqwrUS9Pbg>
    <xmx:6p2baT_VaDOOM_zg6S9IBIzCVkHX-WsxcO41L7wqE0AAcU9P76fn-9F1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 19:23:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <xmqq4in8quxn.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	22 Feb 2026 14:23:32 -0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
	<xmqq4in8quxn.fsf@gitster.g>
Date: Sun, 22 Feb 2026 16:23:04 -0800
Message-ID: <xmqqqzqcpatz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>  setup.c                       | 42 ++++++++++++++------
>>  setup.h                       |  2 +
>>  submodule.c                   |  2 +-
>>  t/meson.build                 |  1 +
>>  t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
>>  worktree.c                    |  6 ++-
>>  6 files changed, 110 insertions(+), 15 deletions(-)
>>  create mode 100755 t/t0009-git-dir-validation.sh
>
> We'd probably need to treat ENOTDIR the same way as ENOENT to deal
> with cases where we expect a directory "sm1" to be the root of a
> submodule working tree, and we have a modification that removes the
> submodule directory and replace it with a regular file "sm1".  In
> the code path touched by this patch in submodule.c, we would ask "is
> sm1/.git a git directory?" and the stat(2) call on that path in
> read_gitfile_gently() used to say "Ah, a failure, that means we
> cannot positively say that 'sm1/.git' is a git directory or a gitdir
> file."  Now we inspect the error code in an attempt to tell if it is
> a system failure (e.g., a corrupt filesystem), but catching only
> ENOENT is probably a bit too tight.  In the above scenario, asking
> about 'sm1/.git' when 'sm1' is a regular file will not result in
> ENOENT but in ENOTDIR (i.e., "the leading 'sm1' is not a directory so
> it makes no sense to ask about 'sm1/.git'").
>
> Is it always sensible to treat ENOTDIR and ENOENT as two equivalent
> errors for the purpose of read_gitfile_gently()?  I have no clear
> answer offhand myself.  This is part of what we need to think about
> and resolve while addressing the original "NEEDSWORK:" comment.


----- >8 -----
Subject: [PATCH] read_gitfile(): group ENOENT and ENOTDIR into a
 single MISSING error

The code from the previous step does not deal wellwith a case where
we check if "sm/.git" is a good directory after replacing "sm" with
a regular file.  ENOTDIR is returned when we ask about "sm/.git",
not ENOENT, and the code would want to handle both.

I am not convinced if this is a good change, though.  Outside the
submodule caller, the story might be different and we may want to
treat ENOTDIR differently from ENOENT.  I dunno.  That is why this
is not squashed into the patch (yet).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c     | 8 ++++----
 setup.h     | 2 +-
 submodule.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index b79a9233f5..d4afbed3eb 100644
--- a/setup.c
+++ b/setup.c
@@ -895,7 +895,7 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
-	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_STAT_MISSING:
 	case READ_GITFILE_ERR_IS_A_DIR:
 		/* non-fatal; follow return path */
 		break;
@@ -943,8 +943,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
-		if (errno == ENOENT)
-			error_code = READ_GITFILE_ERR_STAT_ENOENT;
+		if (errno == ENOENT || errno == ENOTDIR)
+			error_code = READ_GITFILE_ERR_STAT_MISSING;
 		else
 			error_code = READ_GITFILE_ERR_STAT_FAILED;
 		goto cleanup_return;
@@ -1589,7 +1589,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
 		if (!gitdirenv) {
 			switch (error_code) {
-			case READ_GITFILE_ERR_STAT_ENOENT:
+			case READ_GITFILE_ERR_STAT_MISSING:
 				/* no .git in this directory, move on */
 				break;
 			case READ_GITFILE_ERR_IS_A_DIR:
diff --git a/setup.h b/setup.h
index c23629cb4f..cc45f962fa 100644
--- a/setup.h
+++ b/setup.h
@@ -36,7 +36,7 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
-#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_STAT_MISSING 9
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
diff --git a/submodule.c b/submodule.c
index 52a7cf0e43..fc85a7a1d8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2413,7 +2413,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		const struct submodule *sub;
 		struct strbuf sub_gitdir = STRBUF_INIT;
 
-		if (err_code == READ_GITFILE_ERR_STAT_ENOENT) {
+		if (err_code == READ_GITFILE_ERR_STAT_MISSING) {
 			/* unpopulated as expected */
 			strbuf_release(&gitdir);
 			return;
-- 
2.53.0-455-g62fcd67e6e

