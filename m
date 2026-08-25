Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E20481AB7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667169; cv=none; b=hfhuwYTNEDK5P/a5/tethEq1ZHUSJgUCEhklqE52+Tz+nqZyoLqC377qOQ6azEKwTlGaCj8UEIJ+pSCMSQLp2APV539oPp5rkxGjCxdsuUwtrDWGfjd39GGyKoplz+XrqSJfG7DIlO9aXK9d6Tq72LVO6gOwrUi0pX0B6ivMY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667169; c=relaxed/simple;
	bh=Fn3gGKs8lc9S+UcNSLUVW4pC/g/6BwEz4NIa8lNpMZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iY4d70UeBYPi+2RTMsX4ReZw6QTDDG0bSovM1BevqC29hrRq7K1huBRCtPX1A8pZxBz8zK+DnR8GAqL2aUPeGX/WWwhMWDk0wKmpRiC0CzKw16EaoHcmBcqLQ/KfdsVU4ST4hbRYmoN/d/d9CS3GOkWcwpqkfOKSgvVZe6EUhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1PuJuhk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9S2bUi7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1PuJuhk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9S2bUi7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E86981D00129
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 25 Aug 2026 10:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667166;
	 x=1787753566; bh=hcd/JlEjOofqIG0uRukpB3xFQNj45L8uM690f2pCQ7U=; b=
	J1PuJuhk6ziogUawC1+Br+UEh0n3KTIcTRZcGMb+TNmk2ISVliBdINn41ARTcMYi
	G6RiYFooMefy8tSwOu9x551J9AqEfg7wQMVl3TyQco7w274pE10mstEnY+RxOR3R
	Wkc7f8f1f5WrlcvvTiePwC1iXwDT/iljG4asQ0XtnPtB+GFiRhwLeea7VJts6h5v
	bBnPQWcjIoKoiUQcylvMozibMYgQItw6YHOlPq64UxE8sFrMTzn15MUeUX0r/ite
	D/jLR4T17Bb7AU/PZbXY138RC4R5GyrQNVtAYB9Z4GZf2C8hirKOygTrGR2+skjk
	bWtu2iyw7OQg5Z3lhYrU7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667166; x=
	1787753566; bh=hcd/JlEjOofqIG0uRukpB3xFQNj45L8uM690f2pCQ7U=; b=J
	9S2bUi7rB53ESuS7vmUBcE51qw8oDcOqclgAs0wic6Rw+VJ+MLoq7x3a4LTvrU7d
	UFXhWxc7TwzfnoQ8o0KrBRsHDq3No/QoF0dfER4EZ4np5fvZJCitUk3YR3rN1nx+
	8kW6Pje8twdL0DmTX9O04AFmx/y+/eXyI3Pe3bkw+/GqfFS08FmI5Sd2fXR7gLn2
	gBCsCEhSFGs0ze/kZ9cuklVuagsLkPsWS+ovohcBkHllr8tFrkpu2+CoXVJ2zqaX
	etDIId/lqVL2Xz4jUnBxOtZ2kv06r/uWAf0yNEt1JBWDrsP31ha9AENh0ohLN37i
	0Jw5CvYvrzgqujCy7zeQQ==
X-ME-Sender: <xms:3qKNajOqch7OLFnXpopaHgSqJhQhTZ350flnftk8vi9KFf31dMqfDA>
    <xme:3qKNak5eYMPnDskk-mnkUEMNOK5p3xolAyRnbG-W6XNkPNKkYtY-2xRWb_RfiE3ov
    LLLjd-hdksncTWmFdsG7SWBUrTPuLEv927rpIpw2VPpmxYnvPzcLTY>
X-ME-Received: <xmr:3qKNan6mzNRBRZFH5t8qWhXtm1SW3a2ojemRYpFJCT_A2zySI5OOJkBYmFHBmn0TNhaROdcA3N4AvEtKbfWXZppvSNvTmKuRJcWymZqCbg>
X-ME-Proxy-Cause: dmFkZTGPBdwbSbO06IkE+pgLK5uTczUziWqOH/uYnonJp+gR1K8s9KcJmzkNCHgJyCUUlT
    GIVTAYDD9iABWD0ngtRRNh+q8eMI6Mz2svbNVxcaYR8P93dtpnXukEnXiP+6Rd8wVnuHjA
    n4DhE/Ks6YesUECbn5dbB5cLGbVmxOsg0RgiRACzFD2T0hBG5tFm+D/ARGqI+bE/7v/e2Z
    8Ux8bIVApVmD8d95tIENQoJP02kWqXe8/Aj6NuXYnsNb1x7KOR61Rf6lTNYCrE0vNMhCPv
    XRuISTZqaYRuTW2MzYpaa/XyGleqgi6+SnJzpnlMNChsoFQ4jgHnxWyohNEhiF3k6c62Qs
    LOtSjZbp+aHuFCR+kqLyB15oQnzTX1VIId2w7egJFkrodUbLznYU5MOueiFwu0+2tGoTnU
    PzCz+ylyxT9HYH5FBhBrnxB4E56Zwv3EdeEa3R0j3Fw0E2K9khVj+sKpG2F/hDgnnlVgC6
    Y3YVjcAonvPpjPifmYuY/l0ho0XI84kNyG/pbwVk8f6oNlqYGyFpgNiyC9EJd325QXBX8U
    WXu7Ilc1lN/Xf6McwrEY+VSLhe9OKJGs8KRH6MaSoCHFI81bSIpOK9YbJcwb9uKV8eYgKt
    J1dy7VFLMg8V0WvO9trRBMvbJtWprsKUmzS8W73u0+dmQt2PeGOg65SqghHA
X-ME-Proxy: <xmx:3qKNas2YVaEJki0XTUUwhzDxHlguaXh_Cl6b9hwQwY8ub-sDuu5eeQ>
    <xmx:3qKNarUy29zLCCpyCsmgCfq-n9yO13wuWdMR5OA9MjXBGWyXGFy1-w>
    <xmx:3qKNav4ham_MjU1OqFxu8dpnI-TQvYlnu8woUE-9LsSpPg_nsfA7lQ>
    <xmx:3qKNaqK24XNo_V1l3ntmXwX4lh0sZ2ARuR-XVVVMSnHwscvrRp-0gg>
    <xmx:3qKNan-1xSDg2IMbsLo2XMj8d93y4RzRh7KxFX5wnPoDHxd2ORXg5zSy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea43b6cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:54 +0200
Subject: [PATCH 5/8] builtin/clone: move setup of alternates for non-shared
 local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-5-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
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
regressions. The second patch ensures that we properly handle relative
alternates for a referenced worktree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 34 +++++++++++++++++++++++-----------
 t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08c8f5a94f..2e3473fddf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,7 +181,7 @@ static int add_one_alternate(struct string_list_item *item, void *cb_data)
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
 		get_common_dir(&commondir, src_repo);
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
2.55.0.822.g20453c30eb.dirty

