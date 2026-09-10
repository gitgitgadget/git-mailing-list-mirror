Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F44A6CFC
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052981; cv=none; b=s96X9LCl0xovzLZgj4ZnGKH8kIJZxdC5FghWpS3UqmRLdp/CCClmgpYOpV5TjQmK1KJz4NQPTBckpgvqJ1Jies4dFBRSScqHSWe5OaXRWjxTD9iPQ7PcINZWOU86ByZ6L/JhSwCRi7HgPXVFp5e7ZDxvxy7Uxc5Sr0eOKc61Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052981; c=relaxed/simple;
	bh=QuOyBxfcDmowIrfAiQtkUj5qz5T+L3TQcoJdxQQ0rAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XATg/2ErJPHep3X13FMzLENCp83PI2A0/blDl4Su7o9muHkEptPXzQK2+gyo3LCMvEVMR62lOiAYsWFuHYp3u10yT7xOVpgV79Sz4GnqjKMKNzjp6xcqleXSswd683v+BaUyBwrFVVwgDSwk1GG9IrMHzAT6dAkz9oCBVoQYexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ML0q7vP7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlTK03I0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ML0q7vP7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlTK03I0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E58514000C1;
	Thu, 10 Sep 2026 11:09:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052972;
	 x=1789139372; bh=pPjJWkmRnQwlKgnq95fIMUwfIxNSMFkegiUNk0r4YJk=; b=
	ML0q7vP71/xNcwJ6bsDDDCpXToIoYi04uchD7UOpHMEofwMnISrXsro1fiQwg6aq
	7K9d7PCVrfGHZ19EeDrmyXsYVcNbA97ZfPTOT2F8xd+SagtyaQ4qAc52RMorTptA
	VdPcPz8ab46V3gjnoUrHMWxgvSRQzITAS3gT66zHDdQS67FIfz48OUhWvJ4eI0uN
	iYsaPT6B0CHPgg4nsF2CwpaZE6tu57DI5wEDqCaVdPIBvrTzzluPadXNuASEo+Lc
	5Nc3fNxwUpHfrWR+tkshZ9D+cM2Pnu2WT7LpUfgxkeiBlEnAPRJ2u7HmS/DYcCTe
	9/JRmAuXMTXJGJbJWIen0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052972; x=
	1789139372; bh=pPjJWkmRnQwlKgnq95fIMUwfIxNSMFkegiUNk0r4YJk=; b=O
	lTK03I0HGbxHbYYt0J9ZUQ9hPUkr3zUprbAiRtTM5XJ+Cz2WCsVhtG0uwX2dJ336
	BfwaAEvNSXQq9oeUY9/sGVC2qempaSmxbdyOdBvOXcXZyvBIe0RAXdgk7zo1radr
	ruoTZv4POgb+SUuDTPZazm92MN6NVmfkh9F7BHewG62kJqMmrqOHvM5h0TtxraFE
	xrWCqvvEgWui7jn49kDXlkQeO4iZ2Rfd1B2uUrwqKCBOG5BQRD0dWX/uxkmZx4Pl
	ejufhUKk2wYdt2xrQ2Q2q+Pil3pUeZnTEN+t79WW/0UK7EWkxOvrnpIW3g7t7RtK
	rlgPzxYgbhrRPCAWFmUbg==
X-ME-Sender: <xms:LMiialYj83Wm3NE6LkcX_z57pAxHM9ehwnTHCYD_b7o-hdaEPy6kRw>
    <xme:LMiiajQ2uuxuQk7Q0GccdjzchIdgLSNlwRZA50HCWJy9tVyGjzD_wll01ATlVlxvK
    BTjFY9leXSenGZD81heds9XFpNT-a9P_9ICAKCl4AXNNeC0A_J-5Q>
X-ME-Received: <xmr:LMiiagRf_srhSvszrt6SU9g004vaO3M0xq2BdyN0Kf4Fe3r42vZZkA>
X-ME-Proxy-Cause: dmFkZTF+5Wy56B+Wx3ySnb5Cx59QKPLOQu236q+2W/W769TPaDnZkuuZ6ySVZ9pJSqX60I
    4KnoBOIFigUDciwRh5/L/RnGKTaoNEewuq0njqzCEJrAVeBHtLobMSK78B+3FkPz/ggIMU
    xsdVnfs4PMJwMJ+arLr5XiQP6/sGsYur6cm7OCaOVgBA33g+KiJVV+ugxArXrsWGshcu/l
    x9zxt9yXxZkS12K7MVcatieR8K8p2/XFAPtZI8wbyrgYzrTVG29lrkrjg3Gx/XNfNTsgx5
    OxmR1v95cylk+grcUqYbD44VqN0IFxxmM0WSX9o2us26bpuTNI0rP+P/UYLTgPd4ZQ2Fet
    6cghCZTtjMJu5fD1mlocGE7bffMrEVXjwK+wvwFNSzCsoiWjPqRBEMrr5SdHKq8e4q25KU
    72K5bhLMt/z+fw1XwOkNcWfNu0AOIxBJxSqFWMpUGH4R+asW6KMKxRyUzWbw6pFWYZ3CZQ
    u5WWYKjD0NIDLK4jkS7J4Mix8efi2uD7WfjOeztsU7J+0fxhiDC43IL2jPs0V6PBmuhFnE
    DuDfQTtYVi21fBgYmt6HKLo7OQz5+0fbPnYIbqTYALltLbXD4FAP+o5EDu3hhP1FpvAtxs
    UmdBdsdDZm/FM/bPCkTmk/NCNj6fBhEvx5FwYFfUnO35K6VVk+BJJNbO8RzA
X-ME-Proxy: <xmx:LMiiavQ2_YzNoqxIoR9C715jLhFu9Lof-ERCwe_7RF-byo1hEJ57wA>
    <xmx:LMiiat5aNf3uicms-oYRlsItmxARbV8JfUL5KWxvXjF7DpFull58Qg>
    <xmx:LMiiaj1-_ws2F7wz35je8fjMC9Ayzin9KdopjTk_hXPy4IRmOAxA-A>
    <xmx:LMiiagDWqEPbQ_gC_iOwcP1nr3pZFCUp-CM2wygLQoKHT8rTdJKEYw>
    <xmx:LMiiaqsJj6xNlHPw0rXkSfSG7Dl9CIMPCTJYsMjqG0CK1PbWiP4e6cpK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7919a86d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:16 +0200
Subject: [PATCH v5 6/9] builtin/clone: move setup of alternates for
 non-shared local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-6-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Similar as in the preceding commit, move the setup of alternates for
local clones with "--no-shared" into `collect_alternates()`. With this
step, the complete setup of alternates is now handled by that function.

Note that besides moving stuff around, it also fixes a bug: previously,
we did not know to resolve the referenced repository's common directory.
Consequently, when referencing a worktree we failed to resolve
alternates. But as `collect_alternates()` already knows to resolve the
commondir for "--local" we can simply reuse this resolved path for our
purpose.

Add two tests, the first one of which exercises this bug to avoid future
regressions. The second test ensures that we properly handle relative
alternates for a referenced worktree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 34 +++++++++++++++++++++++-----------
 t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d397fd36b2..17353a8e1f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,7 +181,7 @@ static int collect_one_alternate(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void copy_alternates(struct strbuf *src, const char *src_repo)
+static void read_alternates(struct strvec *alternates, const char *src_repo)
 {
 	/*
 	 * Read from the source objects/info/alternates file
@@ -195,29 +195,41 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	 * to turn entries with paths relative to the original
 	 * absolute, so that they can be used in the new repository.
 	 */
-	FILE *in = xfopen(src->buf, "r");
+	FILE *in;
+	struct strbuf path = STRBUF_INIT;
 	struct strbuf line = STRBUF_INIT;
 
+	strbuf_addf(&path, "%s/objects/info/alternates", src_repo);
+
+	in = fopen(path.buf, "r");
+	if (!in) {
+		if (errno == ENOENT)
+			goto out;
+		die_errno("could not read alternates file '%s'", path.buf);
+	}
+
 	while (strbuf_getline(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			odb_add_to_alternates_file(the_repository->objects,
-						   line.buf);
+			strvec_push(alternates, line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			odb_add_to_alternates_file(the_repository->objects,
-						   abs_path);
+			strvec_push(alternates, abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
 		free(abs_path);
 	}
+
+out:
+	strbuf_release(&path);
 	strbuf_release(&line);
-	fclose(in);
+	if (in)
+		fclose(in);
 }
 
 static void collect_alternates(struct strvec *alternates,
@@ -242,6 +254,8 @@ static void collect_alternates(struct strvec *alternates,
 		get_common_dir(&commondir, local_source_repo);
 		if (option_shared)
 			strvec_pushf(alternates, "%s/objects", commondir.buf);
+		else
+			read_alternates(alternates, commondir.buf);
 
 		strbuf_release(&commondir);
 	}
@@ -320,11 +334,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 
-		/* Files that cannot be copied bit-for-bit... */
-		if (!fspathcmp(iter->relative_path, "info/alternates")) {
-			copy_alternates(src, src_repo);
+		/* Alternates were already handled earlier. */
+		if (!fspathcmp(iter->relative_path, "info/alternates"))
 			continue;
-		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 39a0c318df..9e4b98fdb8 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -383,4 +383,29 @@ test_expect_success 'dissociate from repo with commit graph' '
 	git clone --no-local --reference graph.git --dissociate orig clone
 '
 
+test_expect_success 'local clone from linked worktree carries over alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
+test_expect_success 'local clone from linked worktree resolves relative alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	echo "../../../base/.git/objects" >derived/.git/objects/info/alternates &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
 test_done

-- 
2.55.0.1074.ge7621b4bad.dirty

