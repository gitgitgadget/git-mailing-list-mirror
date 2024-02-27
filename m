Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC9537F3
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025375; cv=none; b=Nwc6KKcoh/rLbnD/34uqPc4d8JTDyJazOFJG4meKjoM+6hk/ZFi0dOXHiEKWniTO4T8FueO6rF8d+LU+bvt9Wb+lxNwvAbG+bW+WtgX3Z8SjWTyN4WIwmasEja7YxP3/m0DftO8oBO4xJ+qtKJc8OcYx8/rc4MJDn+szRFm2R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025375; c=relaxed/simple;
	bh=OLs0x86k5dQEw6JGJPwQvHkwGZK8WpJVl/TslXlrtkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq4KrMg0BW/NC4y4PerpGWWhZsLHMLWPrOsHXCvy9dFkXGJodyweL8+2cWcKuqLXCgBRH5bObJkk0q2v/zCXBsDB+cuV5z0ZeVKqmYFEuTmdFiCYt8XAM2TkbJnsh6Yxwtq2nJtfHPx/b8EaERo/eDkvl2Hs3Hg7pQthT2hn+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=Q0PT5Gan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYp1JmYU; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="Q0PT5Gan";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYp1JmYU"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 415695C00BB;
	Tue, 27 Feb 2024 04:16:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 04:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709025371;
	 x=1709111771; bh=wBH8bbXYme91rPp8sZwRt5uXgD8fz6vv9xvlXY6fvcI=; b=
	Q0PT5GanGj4Wd/odesZ5Vf8HqF/kEJu1nQombVdZ5VxWbQf4Bznx+aLkNXjUYMJ4
	R6Sk1Y08R5zCUh8VOwQ6uqwzcy9f4r0KZmXnvicRFVMdeW5UZrX9DY8DRdWMoxNt
	YNtGt7bvDPacnIh62jr4RVQQavAkbL6aegqNgPFxvVFZak2TSNY6VN71cDt1fq+m
	6Q0P6DQ/T4VDi74fKc7PIWuLY+VDItBVOipG2bZknO4jtGTqolTib211s2aI9Ro+
	He5SQmilFmCCzlpgfDQP5q9xrdmVdSITzXqzigpWgbpCUyUpNhw4lRJEyeEytfCN
	MJs6RDPUMtP/An0Bou9McQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709025371; x=1709111771; bh=wBH8bbXYme91rPp8sZwRt5uXgD8f
	z6vv9xvlXY6fvcI=; b=oYp1JmYUVEqMuKSFksDwTI5byLyuVPGUI7g6W4v8Gzn5
	HqAyFG4lCgca39YpIczMjARN9Soztj+PUnhasLdIqz8nXRiUUmnmIXpTOmn0QIGX
	jlL2d6STcg35LjLp+5OQ9yynnTCD+EWRB2icu5nq3Le/oA08pZ2UcJMpvNfbfRin
	R1FZyv9ZS1fyiWeLHk2T+EldI4SJ8nUCXm6AsHz6Wx30eEJfBjb+i/zRivjfow5G
	PhTTuoyU3fJ5FEeyUHl788fIyFlRkn2Hb1BJIEbP4meUZkow8QeQ/2Dx3PS5x7OO
	MAN9uxKkj5iESr9B/jzrvftSGa87qmgH46cFydtU0w==
X-ME-Sender: <xms:W6jdZXWUC8-712Gdj2AjlJ32O6G4RJldI6xyxSiriHfBoVbkFir5Bw>
    <xme:W6jdZflvISnXQlBuIqGWqEyrUjjVlsWYEQ-PCD0IaJp5lcOkF3c4Az8hX2hOj8oxf
    j7gy9QsLGmoWcu5LZE>
X-ME-Received: <xmr:W6jdZTa7wqwBeFbmlp5lT1dChYalNuo76pc5Ns7F-7D-Ht6PNCPHrfR9_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduieegheeijeeuvdetud
    efvedtjeefgeeufefghfekgfelfeetteelvddtffetgfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvth
    htrdhorhhg
X-ME-Proxy: <xmx:W6jdZSWmxzEu2Eero9G0X4nrEHV-rqIjovFgo-qkSazp-Jenk8oVlQ>
    <xmx:W6jdZRnApg0ZdrNefPOPRs_DkZproP60DbTDMQlJbdh4uq0FmZSOsg>
    <xmx:W6jdZffciOYCnJ_4pEdi_CVrVaYVLhhdow-3cyrSbZq03u2dPDbmnQ>
    <xmx:W6jdZRtxnYSXkkDmVQk0kizAxGTPVWIVccSfwd2MVbjgbbWQMSaQ3w>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 04:16:10 -0500 (EST)
Date: Tue, 27 Feb 2024 01:16:09 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
Message-ID: <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
 <xmqqbk83nlw5.fsf@gitster.g>
 <Zd2eLxPelxvP8FDk@localhost>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd2eLxPelxvP8FDk@localhost>

`git commit --cleanup=scissors -v` currently prints two scissors lines:
one at the start of the comment lines, and the other right before the
diff. This is redundant, and pushes the diff further down in the user's
editor than it needs to be.

Make wt_status_add_cut_line remember if it has added a cut line before,
and avoid adding a redundant one.

Add a test for this.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
v2: Make wt_status_add_cut_line remember if it has added a cut line,
rather than making later callers try to figure out if it has been called
before. Add a test.

Note that other parts of the code do already try to figure out if the
*merge* logic has added scissors already, which is where
merge_contains_scissors comes from. Patch 2/2 unifies that machinery.

 builtin/commit.c            |  4 ++--
 t/t7502-commit-porcelain.sh |  5 +++++
 wt-status.c                 | 12 ++++++++----
 wt-status.h                 |  3 ++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6d1fa71676..e0a6d43179 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -926,7 +926,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
-				wt_status_add_cut_line(s->fp);
+				wt_status_add_cut_line(s);
 			status_printf_ln(
 				s, GIT_COLOR_NORMAL,
 				whence == FROM_MERGE ?
@@ -947,7 +947,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_char);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT && !merge_contains_scissors)
-				wt_status_add_cut_line(s->fp);
+				wt_status_add_cut_line(s);
 		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_char);
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index a87c211d0b..b37e2018a7 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -736,6 +736,11 @@ test_expect_success 'message shows date when it is explicitly set' '
 	  .git/COMMIT_EDITMSG
 '
 
+test_expect_success 'message does not have multiple scissors lines' '
+	git commit --cleanup=scissors -v --allow-empty -e -m foo &&
+	test $(grep -c -e "--- >8 ---" .git/COMMIT_EDITMSG) -eq 1
+'
+
 test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 
 	echo >>negative &&
diff --git a/wt-status.c b/wt-status.c
index ea13f5d8db..2d576f7a44 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1108,12 +1108,15 @@ void wt_status_append_cut_line(struct strbuf *buf)
 		strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
-void wt_status_add_cut_line(FILE *fp)
+void wt_status_add_cut_line(struct wt_status *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 
+	if (s->added_cut_line)
+		return;
+	s->added_cut_line = 1;
 	wt_status_append_cut_line(&buf);
-	fputs(buf.buf, fp);
+	fputs(buf.buf, s->fp);
 	strbuf_release(&buf);
 }
 
@@ -1144,11 +1147,12 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	 * file (and even the "auto" setting won't work, since it
 	 * will have checked isatty on stdout). But we then do want
 	 * to insert the scissor line here to reliably remove the
-	 * diff before committing.
+	 * diff before committing, if we didn't already include one
+	 * before.
 	 */
 	if (s->fp != stdout) {
 		rev.diffopt.use_color = 0;
-		wt_status_add_cut_line(s->fp);
+		wt_status_add_cut_line(s);
 	}
 	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */
diff --git a/wt-status.h b/wt-status.h
index 819dcad723..5e99ba4707 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -130,6 +130,7 @@ struct wt_status {
 	int rename_score;
 	int rename_limit;
 	enum wt_status_format status_format;
+	unsigned char added_cut_line; /* boolean */
 	struct wt_status_state state;
 	struct object_id oid_commit; /* when not Initial */
 
@@ -147,7 +148,7 @@ struct wt_status {
 
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_append_cut_line(struct strbuf *buf);
-void wt_status_add_cut_line(FILE *fp);
+void wt_status_add_cut_line(struct wt_status *s);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-- 
2.43.0
