Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C1F1FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbdEICiH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:38:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33093 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbdEICiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:38:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so13090389pgc.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UdDyEaMR+s+AlVZRAwUuADh3+pLRmQdIIobEIN420II=;
        b=pDMgg9lZnQrT5J1Q/ATnUdPfgpLeJkAeB/KM7dNuZ3RvpS30xUeSNl0S+vQvGXyktK
         Nw5Sd9YKVtb7lbDlhKtIMjKpxtcxFYTaNBa2DNApEgkQpULnG7b2bb9oaFxBEe0ipPk+
         DD6fszm7fQdGTqgE3ByiHfX2cDtui0wRgvRsnwOKUpQX3sdVx3IbrZqFWEJOblO8pI4B
         veBTUNkqkR0keoWEhYYjQqnojwsoBnb0QXxYYZoKdDhw4PhhT7CMpWeuH83uT3sxIguF
         UrGW0bdYE65I+eF3+lr7eASeNmn6szYQdeGLV17z/0cFziHfpkCcsB7pbG1oBO1CXgzF
         vTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UdDyEaMR+s+AlVZRAwUuADh3+pLRmQdIIobEIN420II=;
        b=IY0vpRI4FEjlL26bp3v9r5wqHyWgjQ6qcRyUrghdiBAW/foao2n0moqRUTpX7vqkjl
         7hzCcdmU41DRtfuQsF+M0PZG0cBTp+O0n7d0BEPKIFwDdS13arUSiGuGUqFKHLFVGwOg
         SFKKodtg1r6lKTV4dr+OzAmMgdNT/4hGBRQNGiEoRemhJPWT8U94+K0D7+YeazuHI6g0
         OyvrWLysDGRJltD69lGsS/Bz59fDND8IohDyfqbnSHJy9dlak9ae7tb6X4aumUQb6W15
         vcZ4jrpzVuaN5LNiZ/XnhgJXF5zLv5+Up+6TpVmOyykiGRp2AAVJMGRv3K5mI6+5KxdQ
         M6sg==
X-Gm-Message-State: AN3rC/4caBaYCkciuq8IKfRlaWyTD2K55sQUB5DYyWD9xucxHEGYYNZb
        Va/Nc0Z4Qd31wRjCmLMgoA==
X-Received: by 10.98.22.9 with SMTP id 9mr21705254pfw.125.1494297484633;
        Mon, 08 May 2017 19:38:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id w23sm23608910pfl.133.2017.05.08.19.38.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:38:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff.c: Fix whitespace issues due to a mismerge(?)
References: <20170508184354.31671-1-sbeller@google.com>
        <xmqqo9v26ax1.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 09 May 2017 11:38:03 +0900
In-Reply-To: <xmqqo9v26ax1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 09 May 2017 11:06:50 +0900")
Message-ID: <xmqq8tm669h0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for spotting.  
>
> I do not think you have to worry about any bug in Git-the-program
> with this merge.  If you try to reproduce the merge yourself (which
> by the way is easy to do, with "M=4af9a7d344 && git checkout $M^ &&
> git merge $M^2"), you'll see that quite a lot of changes made to
> "builtin/apply.c" had to be hand-ported to the corresponding lines
> that are now in "apply.c" at the top-level, because in the meantime
> 13b5af22 ("apply: move libified code from builtin/apply.c to
> apply.{c,h}", 2016-04-22) moved things around while the merged side
> branch has been cooking.  
>
> It is very likely that manual killing and yanking in Emacs
> introduced the screw-up.

I did your patch manually by hand and saw that a few hunks are still
left whitespace-broken by your patch, so I committed this one
instead.  Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 8 May 2017 19:30:24 -0700
Subject: [PATCH] apply.c: fix whitespace-only mismerge

4af9a7d3 ("Merge branch 'bc/object-id'", 2016-09-19) involved
merging a lot of changes made to builtin/apply.c on the side branch
manually to apply.c as an intervening commit 13b5af22 ("apply: move
libified code from builtin/apply.c to apply.{c,h}", 2016-04-22)
moved a lot of the lines changed on the side branch to a different
file apply.c at the top-level, requiring manual patching of it.
Apparently, the maintainer screwed up and made the code indent in a
funny way while doing so.

Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 338 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 169 insertions(+), 169 deletions(-)

diff --git a/apply.c b/apply.c
index 0e2caeab9c..acebd1cb49 100644
--- a/apply.c
+++ b/apply.c
@@ -4091,181 +4091,181 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
 
-	 if (res)
-		 return error(_("could not write temporary index to %s"),
-			      state->fake_ancestor);
+	if (res)
+		return error(_("could not write temporary index to %s"),
+			     state->fake_ancestor);
 
-	 return 0;
- }
+	return 0;
+}
 
- static void stat_patch_list(struct apply_state *state, struct patch *patch)
- {
-	 int files, adds, dels;
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
+{
+	int files, adds, dels;
 
-	 for (files = adds = dels = 0 ; patch ; patch = patch->next) {
-		 files++;
-		 adds += patch->lines_added;
-		 dels += patch->lines_deleted;
-		 show_stats(state, patch);
-	 }
+	for (files = adds = dels = 0 ; patch ; patch = patch->next) {
+		files++;
+		adds += patch->lines_added;
+		dels += patch->lines_deleted;
+		show_stats(state, patch);
+	}
 
-	 print_stat_summary(stdout, files, adds, dels);
- }
+	print_stat_summary(stdout, files, adds, dels);
+}
 
- static void numstat_patch_list(struct apply_state *state,
-				struct patch *patch)
- {
-	 for ( ; patch; patch = patch->next) {
-		 const char *name;
-		 name = patch->new_name ? patch->new_name : patch->old_name;
-		 if (patch->is_binary)
-			 printf("-\t-\t");
-		 else
-			 printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		 write_name_quoted(name, stdout, state->line_termination);
-	 }
- }
-
- static void show_file_mode_name(const char *newdelete, unsigned int mode, const char *name)
- {
-	 if (mode)
-		 printf(" %s mode %06o %s\n", newdelete, mode, name);
-	 else
-		 printf(" %s %s\n", newdelete, name);
- }
-
- static void show_mode_change(struct patch *p, int show_name)
- {
-	 if (p->old_mode && p->new_mode && p->old_mode != p->new_mode) {
-		 if (show_name)
-			 printf(" mode change %06o => %06o %s\n",
-				p->old_mode, p->new_mode, p->new_name);
-		 else
-			 printf(" mode change %06o => %06o\n",
-				p->old_mode, p->new_mode);
-	 }
- }
-
- static void show_rename_copy(struct patch *p)
- {
-	 const char *renamecopy = p->is_rename ? "rename" : "copy";
-	 const char *old, *new;
-
-	 /* Find common prefix */
-	 old = p->old_name;
-	 new = p->new_name;
-	 while (1) {
-		 const char *slash_old, *slash_new;
-		 slash_old = strchr(old, '/');
-		 slash_new = strchr(new, '/');
-		 if (!slash_old ||
-		     !slash_new ||
-		     slash_old - old != slash_new - new ||
-		     memcmp(old, new, slash_new - new))
-			 break;
-		 old = slash_old + 1;
-		 new = slash_new + 1;
-	 }
-	 /* p->old_name thru old is the common prefix, and old and new
-	  * through the end of names are renames
-	  */
-	 if (old != p->old_name)
-		 printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-			(int)(old - p->old_name), p->old_name,
-			old, new, p->score);
-	 else
-		 printf(" %s %s => %s (%d%%)\n", renamecopy,
-			p->old_name, p->new_name, p->score);
-	 show_mode_change(p, 0);
- }
-
- static void summary_patch_list(struct patch *patch)
- {
-	 struct patch *p;
-
-	 for (p = patch; p; p = p->next) {
-		 if (p->is_new)
-			 show_file_mode_name("create", p->new_mode, p->new_name);
-		 else if (p->is_delete)
-			 show_file_mode_name("delete", p->old_mode, p->old_name);
-		 else {
-			 if (p->is_rename || p->is_copy)
-				 show_rename_copy(p);
-			 else {
-				 if (p->score) {
-					 printf(" rewrite %s (%d%%)\n",
-						p->new_name, p->score);
-					 show_mode_change(p, 0);
-				 }
-				 else
-					 show_mode_change(p, 1);
-			 }
-		 }
-	 }
- }
-
- static void patch_stats(struct apply_state *state, struct patch *patch)
- {
-	 int lines = patch->lines_added + patch->lines_deleted;
-
-	 if (lines > state->max_change)
-		 state->max_change = lines;
-	 if (patch->old_name) {
-		 int len = quote_c_style(patch->old_name, NULL, NULL, 0);
-		 if (!len)
-			 len = strlen(patch->old_name);
-		 if (len > state->max_len)
-			 state->max_len = len;
-	 }
-	 if (patch->new_name) {
-		 int len = quote_c_style(patch->new_name, NULL, NULL, 0);
-		 if (!len)
-			 len = strlen(patch->new_name);
-		 if (len > state->max_len)
-			 state->max_len = len;
-	 }
- }
-
- static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
- {
-	 if (state->update_index) {
-		 if (remove_file_from_cache(patch->old_name) < 0)
-			 return error(_("unable to remove %s from index"), patch->old_name);
-	 }
-	 if (!state->cached) {
-		 if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
-			 remove_path(patch->old_name);
-		 }
-	 }
-	 return 0;
- }
-
- static int add_index_file(struct apply_state *state,
-			   const char *path,
-			   unsigned mode,
-			   void *buf,
-			   unsigned long size)
- {
-	 struct stat st;
-	 struct cache_entry *ce;
-	 int namelen = strlen(path);
-	 unsigned ce_size = cache_entry_size(namelen);
-
-	 if (!state->update_index)
-		 return 0;
-
-	 ce = xcalloc(1, ce_size);
-	 memcpy(ce->name, path, namelen);
-	 ce->ce_mode = create_ce_mode(mode);
-	 ce->ce_flags = create_ce_flags(0);
-	 ce->ce_namelen = namelen;
-	 if (S_ISGITLINK(mode)) {
-		 const char *s;
-
-		 if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		     get_oid_hex(s, &ce->oid)) {
+static void numstat_patch_list(struct apply_state *state,
+			       struct patch *patch)
+{
+	for ( ; patch; patch = patch->next) {
+		const char *name;
+		name = patch->new_name ? patch->new_name : patch->old_name;
+		if (patch->is_binary)
+			printf("-\t-\t");
+		else
+			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
+		write_name_quoted(name, stdout, state->line_termination);
+	}
+}
+
+static void show_file_mode_name(const char *newdelete, unsigned int mode, const char *name)
+{
+	if (mode)
+		printf(" %s mode %06o %s\n", newdelete, mode, name);
+	else
+		printf(" %s %s\n", newdelete, name);
+}
+
+static void show_mode_change(struct patch *p, int show_name)
+{
+	if (p->old_mode && p->new_mode && p->old_mode != p->new_mode) {
+		if (show_name)
+			printf(" mode change %06o => %06o %s\n",
+			       p->old_mode, p->new_mode, p->new_name);
+		else
+			printf(" mode change %06o => %06o\n",
+			       p->old_mode, p->new_mode);
+	}
+}
+
+static void show_rename_copy(struct patch *p)
+{
+	const char *renamecopy = p->is_rename ? "rename" : "copy";
+	const char *old, *new;
+
+	/* Find common prefix */
+	old = p->old_name;
+	new = p->new_name;
+	while (1) {
+		const char *slash_old, *slash_new;
+		slash_old = strchr(old, '/');
+		slash_new = strchr(new, '/');
+		if (!slash_old ||
+		    !slash_new ||
+		    slash_old - old != slash_new - new ||
+		    memcmp(old, new, slash_new - new))
+			break;
+		old = slash_old + 1;
+		new = slash_new + 1;
+	}
+	/* p->old_name thru old is the common prefix, and old and new
+	 * through the end of names are renames
+	 */
+	if (old != p->old_name)
+		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
+		       (int)(old - p->old_name), p->old_name,
+		       old, new, p->score);
+	else
+		printf(" %s %s => %s (%d%%)\n", renamecopy,
+		       p->old_name, p->new_name, p->score);
+	show_mode_change(p, 0);
+}
+
+static void summary_patch_list(struct patch *patch)
+{
+	struct patch *p;
+
+	for (p = patch; p; p = p->next) {
+		if (p->is_new)
+			show_file_mode_name("create", p->new_mode, p->new_name);
+		else if (p->is_delete)
+			show_file_mode_name("delete", p->old_mode, p->old_name);
+		else {
+			if (p->is_rename || p->is_copy)
+				show_rename_copy(p);
+			else {
+				if (p->score) {
+					printf(" rewrite %s (%d%%)\n",
+					       p->new_name, p->score);
+					show_mode_change(p, 0);
+				}
+				else
+					show_mode_change(p, 1);
+			}
+		}
+	}
+}
+
+static void patch_stats(struct apply_state *state, struct patch *patch)
+{
+	int lines = patch->lines_added + patch->lines_deleted;
+
+	if (lines > state->max_change)
+		state->max_change = lines;
+	if (patch->old_name) {
+		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
+		if (!len)
+			len = strlen(patch->old_name);
+		if (len > state->max_len)
+			state->max_len = len;
+	}
+	if (patch->new_name) {
+		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
+		if (!len)
+			len = strlen(patch->new_name);
+		if (len > state->max_len)
+			state->max_len = len;
+	}
+}
+
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+{
+	if (state->update_index) {
+		if (remove_file_from_cache(patch->old_name) < 0)
+			return error(_("unable to remove %s from index"), patch->old_name);
+	}
+	if (!state->cached) {
+		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
+			remove_path(patch->old_name);
+		}
+	}
+	return 0;
+}
+
+static int add_index_file(struct apply_state *state,
+			  const char *path,
+			  unsigned mode,
+			  void *buf,
+			  unsigned long size)
+{
+	struct stat st;
+	struct cache_entry *ce;
+	int namelen = strlen(path);
+	unsigned ce_size = cache_entry_size(namelen);
+
+	if (!state->update_index)
+		return 0;
+
+	ce = xcalloc(1, ce_size);
+	memcpy(ce->name, path, namelen);
+	ce->ce_mode = create_ce_mode(mode);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = namelen;
+	if (S_ISGITLINK(mode)) {
+		const char *s;
+
+		if (!skip_prefix(buf, "Subproject commit ", &s) ||
+		    get_oid_hex(s, &ce->oid)) {
 			free(ce);
-			return error(_("corrupt patch for submodule %s"), path);
+		       return error(_("corrupt patch for submodule %s"), path);
 		}
 	} else {
 		if (!state->cached) {
-- 
2.13.0-rc2-265-gd6850fbf8f

