Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbhL3XgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbhL3XgR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E18C061746
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so53145680wrw.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jt+pEdaNvy6+eLb7fLZGKq6uyZ8j2uRNVRhVEtft+jI=;
        b=ZBPsU79xsk20rRinC3gKLLCnqiprnIIuEy18ffUhKPGOgRZuxImPRA4fyMYMXUkPY0
         Q2mcdTQAtm+5ef2HVNwRUHkKYmMF/fuyXyPkUl7J0hGYTCgcWkUO3KxJHLt+TiiR8ePL
         j2+iy94bfVAdgZSFk09W4TQSuSm+nKB+nY8bhi7nt6KiB5akmDyzsGZ0M8OfJErDiVlD
         1d024Y3u6voc+c9wQmbBPd5pIKECQ0cGrIsC8yUAKwJnBOUx3nv72s9XhTzpsI0YIKGK
         Q89Q00nypW4nJNLx4XzrZDjy8R6HnBrWQ2r6dyigM4V77qJ0A3uBhi4ttUgxA3iN4kZv
         5SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jt+pEdaNvy6+eLb7fLZGKq6uyZ8j2uRNVRhVEtft+jI=;
        b=I/0avPKQ+Vd8PB6PWHiYO4SudUWE+KwAshO3C7QCPOYpMFM6pGrxkHn5DxUtkQLagU
         vCaWVWF5o+a4UNt9fCw51bsLTbGFhTM3xfYNF/c+0J+Jwf8p7tPd4DYCysC3CzD95Giw
         pGqk/2Iz9+a1j6e4gajRGuLYE1QvRS/0JqmWMFhnhMblS5K3CLKFWAZy5SrFg5OBSQWm
         v3OAnd7K/0XmlnTmEBR0NVgfhimSflN/vM9OqK/zbPd1G0GdZd7pV//Bfd3xrssfNsnA
         GDNT49keumOihSxNkkuDatUx9KI66ehJC6MkjtLFJe8XGujZv6uiKV1eCFfOLN+6QwSe
         dEXg==
X-Gm-Message-State: AOAM533cc4NX7fm/mhz9yHN7dM6lEhAEJSW6x218BZhjc3P1wtq3TgbA
        ggwawpmN/qn3OLiECeGsJkrxeS3fI+k=
X-Google-Smtp-Source: ABdhPJy6Sf6CC/4Y4/d3SPdGsEdor1zX80A9A5N5Hy50wusqi+gok71uLky7swkZM7MVcATzmg0VGQ==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr26997105wrq.106.1640907375494;
        Thu, 30 Dec 2021 15:36:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm25020531wrg.105.2021.12.30.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:15 -0800 (PST)
Message-Id: <81e736b847e8765d05af2704226254c4c667e142.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:06 +0000
Subject: [PATCH v3 6/9] merge-ort: format messages slightly different for use
 in headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When users run
    git show --remerge-diff $MERGE_COMMIT
or
    git log -p --remerge-diff ...
stdout is not an appropriate location to dump conflict messages, but we
do want to provide them to users.  We will include them in the diff
headers instead...but for that to work, we need for any multiline
messages to replace newlines with both a newline and a space.  Add a new
flag to signal when we want these messages modified in such a fashion,
and use it in path_msg() to modify these messages this way.  Also, allow
a special prefix to be specified for these headers.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c       | 42 ++++++++++++++++++++++++++++++++++++++++--
 merge-recursive.c |  4 ++++
 merge-recursive.h |  2 ++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 998e92ec593..481305d2bcf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -634,17 +634,49 @@ static void path_msg(struct merge_options *opt,
 		     const char *fmt, ...)
 {
 	va_list ap;
-	struct strbuf *sb = strmap_get(&opt->priv->output, path);
+	struct strbuf *sb, *dest;
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (opt->record_conflict_msgs_as_headers && omittable_hint)
+		return; /* Do not record mere hints in tree */
+	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));
 		strbuf_init(sb, 0);
 		strmap_put(&opt->priv->output, path, sb);
 	}
 
+	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
+
 	va_start(ap, fmt);
-	strbuf_vaddf(sb, fmt, ap);
+	strbuf_vaddf(dest, fmt, ap);
 	va_end(ap);
 
+	if (opt->record_conflict_msgs_as_headers) {
+		int i_sb = 0, i_tmp = 0;
+
+		/* Start with the specified prefix */
+		if (opt->msg_header_prefix)
+			strbuf_addf(sb, "%s ", opt->msg_header_prefix);
+
+		/* Copy tmp to sb, adding spaces after newlines */
+		strbuf_grow(sb, sb->len + 2*tmp.len); /* more than sufficient */
+		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
+			/* Copy next character from tmp to sb */
+			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
+
+			/* If we copied a newline, add a space */
+			if (tmp.buf[i_tmp] == '\n')
+				sb->buf[++i_sb] = ' ';
+		}
+		/* Update length and ensure it's NUL-terminated */
+		sb->len += i_sb;
+		sb->buf[sb->len] = '\0';
+
+		strbuf_release(&tmp);
+	}
+
+	/* Add final newline character to sb */
 	strbuf_addch(sb, '\n');
 }
 
@@ -4246,6 +4278,9 @@ void merge_switch_to_result(struct merge_options *opt,
 		struct string_list olist = STRING_LIST_INIT_NODUP;
 		int i;
 
+		if (opt->record_conflict_msgs_as_headers)
+			BUG("Either display conflict messages or record them as headers, not both");
+
 		trace2_region_enter("merge", "display messages", opt->repo);
 
 		/* Hack to pre-allocate olist to the desired size */
@@ -4347,6 +4382,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
 	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
 
+	if (opt->msg_header_prefix)
+		assert(opt->record_conflict_msgs_as_headers);
+
 	/*
 	 * detect_renames, verbosity, buffer_output, and obuf are ignored
 	 * fields that were used by "recursive" rather than "ort" -- but
diff --git a/merge-recursive.c b/merge-recursive.c
index bc73c52dd84..9ec1e6d043a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3714,6 +3714,10 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 	assert(opt->priv == NULL);
 
+	/* Not supported; option specific to merge-ort */
+	assert(!opt->record_conflict_msgs_as_headers);
+	assert(!opt->msg_header_prefix);
+
 	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
diff --git a/merge-recursive.h b/merge-recursive.h
index 0795a1d3ec1..b88000e3c25 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -46,6 +46,8 @@ struct merge_options {
 	/* miscellaneous control options */
 	const char *subtree_shift;
 	unsigned renormalize : 1;
+	unsigned record_conflict_msgs_as_headers : 1;
+	const char *msg_header_prefix;
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
-- 
gitgitgadget

