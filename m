Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25451F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeF3Iie (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:38:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37692 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeF3Iia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:38:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id c11-v6so9014726lja.4
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IqIgFUCHcjAtjYVG5mPAh9O/Wpb9pM4ziuMfYHI0d/A=;
        b=lRt/t6DqoMk1JFEvAhmWddFIm5jKPICHmItmouAp6YGs+0lG5kdkyIk2PKyXhJT0jR
         P7KpiSCEDPR7nu85AnLLHZqvS0voyz+nF6NIxI3I/JDI9mxXkbnkd3pNyzkiZvNdx6SM
         Uf9sJ8kIWRLLeRP+3S73jI15arvvE8mxLWPF1bioJjz3Oi2tZuoED9iLlu2J5AVWe5mg
         Kh2ZVGFHNyzOlo96oV0ywZiJkBsBNLYLha46zzptR065MwR1ouPsOl45MwvkAgFVn0zS
         rCPclRVQBmn5Ds7vRJQAcO83lnMDDzHQGmz9072pQUU667uyYgbg61hH3Xe1krf7PwTQ
         sYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IqIgFUCHcjAtjYVG5mPAh9O/Wpb9pM4ziuMfYHI0d/A=;
        b=T0En5FLd219QZ80wOWOUjBhKnWEucw+lzgz0tpesAjKTfRPxs0a7llYzSOU8QdbU3N
         GrfnqErwNa+AlwFtpUbzAcmMf1KYoulRkTXow4DD8SwSZ59lVWkHoMNjGzVOcAXxSzCJ
         /BSXF7Tbme/ybs26e/uXu7JqjnbSS6oqAO1W8WQ1jMG+KEcxmjSIBzrr7EYgY6z0EptP
         S1OMqPmgvrbAF2JuGvL2wsHC5E7sG1ygrbZCNRo13aswi9WWaqTcPs+aJV192JnGMuNc
         bc/hsopyKHCYvI0MfoFF60OV7RqdAVz61UpWPKtf/GQiqE4VeRqZofUkbIARXhH9sLa7
         b/mw==
X-Gm-Message-State: APt69E1I94YuxtB5zf1Rq/oIKmm+A3WO56WkDUgGD0IIu+4o0fdGewqc
        1T0O8McaEz7jKhwBZi25npw=
X-Google-Smtp-Source: AAOMgpfCBm3L8x+4GMwOaDYsfpXqEXfhcgitkOlYZyzkN4NZ5VKGYd3Hm0eDcuqiJ2EDUimuW4mT/Q==
X-Received: by 2002:a2e:9f10:: with SMTP id u16-v6mr11764606ljk.42.1530347908883;
        Sat, 30 Jun 2018 01:38:28 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w75-v6sm993945lff.41.2018.06.30.01.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:38:27 -0700 (PDT)
Date:   Sat, 30 Jun 2018 10:38:26 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/15] apply.c: stop using index compat macros
Message-ID: <20180630083825.GA2436@duynguyen.home>
References: <20180616054157.32433-1-pclouds@gmail.com>
 <20180616054157.32433-3-pclouds@gmail.com>
 <xmqqbmbypyis.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbmbypyis.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 10:27:23AM -0700, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > ---
> >  apply.c | 34 +++++++++++++++++++---------------
> >  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> Until all the codepaths that reach these callsites to index_*
> functions from cmd_main() are converted to pass "struct index_state
> *" throughout, a step like this patch does fundamentally changes
> nothing.  The only two issues worth addressing in this area still
> remain.  All the lines we see here still depend on the existence of
> "the_index" instance, and they can only operate on that single
> "the_index" instance and nothing else.
> 
> It is true that the dependency has been made more explicit, but it
> already is explicit (to see them you just say "no-the-index-macros"
> and see what fails to compile).
> 
> I see others are enthused with this series, but seeing the changes
> like these I am not all that impressed.

I agree there is nothing to be impressed about these patches. These,
standalone, are worthless changes. I would not do this if I could not
delete all these the_index by the end. The changes are separated this
way in order to reduce diff noise (indentation, function name changes)
in later patches.

> 
> Would it become hard to review if we combine this step *and* the
> next logical step (i.e. pass the "struct index_state" throughout the
> callflow) into a single patch? The functions in apply.c are fairly
> well isolated and there won't be all that heavy interaction with the
> outside world if we convert this file (and it alone) without
> touchning the other files.

A singe patch conversion would look like below. But for that to
happen, convert.c, rerere, ws.c and read-cache.c have to be converted
first to not use the_index. A single patch to convert apply.c probably
pulls a lot more outside changes than just apply.c

> If a division in that direction is possible, it may make a better
> orgainzation (i.e.  instead of doing whole-tree superficial
> conversion that needs to be fixed up again later, do a deep full
> conversion on selected files before going on to next set of files).

I think that's the direction in the following patches, where I try to
kick the_index out of one file each time until they are gone.

I'm ok with dropping these patches and incorporate them in the "real
conversion" patches too. Let me know which way you want.

Anyway the "everything in apply.c" patch would look like this, which
is a combined patch of the following commits on my branch [1]

18d1848077 read-cache.c: kill read_index()
e8445d01a5 repository.c: replace hold_locked_index() with repo_hold_locked_index()
cc970ac179 ws.c: remove implicit dependency on the_index
b8a14120c4 rerere.c: remove implicit dependency on the_index
6b68ac65dc ll-merge.c: remove implicit dependency on the_index
5d990e1b71 apply.c: use apply_state->repo->index instead of the_index
cb3f1ad8e8 apply.c: make init_apply_state() take a struct repository
a0bcf49024 apply.c: pass struct apply_state to more functions
4265838aec apply.c: use the right index instead of the_index
4fbbdbca80 read-cache.c: remove an implicit dependency on the_index
ef8bd1e81d convert.c: remove an implicit dependency on the_index

[1] https://gitlab.com/pclouds/git/commits/really-kill-the-index

-- 8< --
diff --git a/apply.c b/apply.c
index 57a7d3cafd..0ec5b1ec57 100644
--- a/apply.c
+++ b/apply.c
@@ -75,10 +75,12 @@ static int parse_ignorewhitespace_option(struct apply_state *state,
 }
 
 int init_apply_state(struct apply_state *state,
+		     struct repository *repo,
 		     const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
+	state->repo = repo;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -2126,10 +2128,12 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 
 	if (!use_patch(state, patch))
 		patch->ws_rule = 0;
+	else if (patch->new_name)
+		patch->ws_rule = whitespace_rule(state->repo->index,
+						 patch->new_name);
 	else
-		patch->ws_rule = whitespace_rule(patch->new_name
-						 ? patch->new_name
-						 : patch->old_name);
+		patch->ws_rule = whitespace_rule(state->repo->index,
+						 patch->old_name);
 
 	patchsize = parse_single_patch(state,
 				       buffer + offset + hdrsize,
@@ -3371,14 +3375,16 @@ static struct patch *previous_patch(struct apply_state *state,
 	return previous;
 }
 
-static int verify_index_match(const struct cache_entry *ce, struct stat *st)
+static int verify_index_match(struct apply_state *state,
+			      const struct cache_entry *ce,
+			      struct stat *st)
 {
 	if (S_ISGITLINK(ce->ce_mode)) {
 		if (!S_ISDIR(st->st_mode))
 			return -1;
 		return 0;
 	}
-	return ie_match_stat(&the_index, ce, st,
+	return ie_match_stat(state->repo->index, ce, st,
 			     CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
@@ -3460,7 +3466,8 @@ static int load_preimage(struct apply_state *state,
 	return 0;
 }
 
-static int three_way_merge(struct image *image,
+static int three_way_merge(struct apply_state *state,
+			   struct image *image,
 			   char *path,
 			   const struct object_id *base,
 			   const struct object_id *ours,
@@ -3476,7 +3483,9 @@ static int three_way_merge(struct image *image,
 	status = ll_merge(&result, path,
 			  &base_file, "base",
 			  &our_file, "ours",
-			  &their_file, "theirs", NULL);
+			  &their_file, "theirs",
+			  state->repo->index,
+			  NULL);
 	free(base_file.ptr);
 	free(our_file.ptr);
 	free(their_file.ptr);
@@ -3512,17 +3521,17 @@ static int load_current(struct apply_state *state,
 	if (!patch->is_new)
 		BUG("patch to %s is not a creation", patch->old_name);
 
-	pos = index_name_pos(&the_index, name, strlen(name));
+	pos = index_name_pos(state->repo->index, name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
-	ce = the_index.cache[pos];
+	ce = state->repo->index->cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
 			return error_errno("%s", name);
-		if (checkout_target(&the_index, ce, &st))
+		if (checkout_target(state->repo->index, ce, &st))
 			return -1;
 	}
-	if (verify_index_match(ce, &st))
+	if (verify_index_match(state, ce, &st))
 		return error(_("%s: does not match index"), name);
 
 	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
@@ -3588,7 +3597,7 @@ static int try_threeway(struct apply_state *state,
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
-	status = three_way_merge(image, patch->new_name,
+	status = three_way_merge(state, image, patch->new_name,
 				 &pre_oid, &our_oid, &post_oid);
 	if (status < 0) {
 		if (state->apply_verbosity > verbosity_silent)
@@ -3681,19 +3690,19 @@ static int check_preimage(struct apply_state *state,
 	}
 
 	if (state->check_index && !previous) {
-		int pos = index_name_pos(&the_index, old_name,
+		int pos = index_name_pos(state->repo->index, old_name,
 					 strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
 			return error(_("%s: does not exist in index"), old_name);
 		}
-		*ce = the_index.cache[pos];
+		*ce = state->repo->index->cache[pos];
 		if (stat_ret < 0) {
-			if (checkout_target(&the_index, *ce, st))
+			if (checkout_target(state->repo->index, *ce, st))
 				return -1;
 		}
-		if (!state->cached && verify_index_match(*ce, st))
+		if (!state->cached && verify_index_match(state, *ce, st))
 			return error(_("%s: does not match index"), old_name);
 		if (state->cached)
 			st_mode = (*ce)->ce_mode;
@@ -3737,7 +3746,7 @@ static int check_to_create(struct apply_state *state,
 	struct stat nst;
 
 	if (state->check_index &&
-	    index_name_pos(&the_index, new_name, strlen(new_name)) >= 0 &&
+	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (state->cached)
@@ -3826,7 +3835,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (state->check_index) {
 			struct cache_entry *ce;
 
-			ce = index_file_exists(&the_index, name->buf,
+			ce = index_file_exists(state->repo->index, name->buf,
 					       name->len, ignore_case);
 			if (ce && S_ISLNK(ce->ce_mode))
 				return 1;
@@ -4002,10 +4011,10 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
-		return read_index_from(&the_index, state->index_file,
+		return read_index_from(state->repo->index, state->index_file,
 				       get_git_dir());
 	else
-		return read_index(&the_index);
+		return repo_read_index(state->repo);
 }
 
 /* This function tries to read the object name from the current index */
@@ -4016,10 +4025,10 @@ static int get_current_oid(struct apply_state *state, const char *path,
 
 	if (read_apply_cache(state) < 0)
 		return -1;
-	pos = index_name_pos(&the_index, path, strlen(path));
+	pos = index_name_pos(state->repo->index, path, strlen(path));
 	if (pos < 0)
 		return -1;
-	oidcpy(oid, &the_index.cache[pos]->oid);
+	oidcpy(oid, &state->repo->index->cache[pos]->oid);
 	return 0;
 }
 
@@ -4094,9 +4103,9 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
 
-		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
+		ce = make_index_entry(&result, patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
-			return error(_("make_cache_entry failed for path '%s'"),
+			return error(_("make_index_entry failed for path '%s'"),
 				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
 			free(ce);
@@ -4247,7 +4256,7 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
-		if (remove_file_from_index(&the_index, patch->old_name) < 0)
+		if (remove_file_from_index(state->repo->index, patch->old_name) < 0)
 			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
@@ -4301,7 +4310,7 @@ static int add_index_file(struct apply_state *state,
 				       "for newly created file %s"), path);
 		}
 	}
-	if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
+	if (add_index_entry(state->repo->index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 		free(ce);
 		return error(_("unable to add cache entry for %s"), path);
 	}
@@ -4315,7 +4324,9 @@ static int add_index_file(struct apply_state *state,
  *   0 if everything went well
  *   1 if a recoverable error happened
  */
-static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
+static int try_create_file(struct apply_state *state, const char *path,
+			   unsigned int mode, const char *buf,
+			   unsigned long size)
 {
 	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -4337,7 +4348,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return 1;
 
-	if (convert_to_working_tree(path, buf, size, &nbuf)) {
+	if (convert_to_working_tree(state->repo->index, path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
@@ -4373,7 +4384,7 @@ static int create_one_file(struct apply_state *state,
 	if (state->cached)
 		return 0;
 
-	res = try_create_file(path, mode, buf, size);
+	res = try_create_file(state, path, mode, buf, size);
 	if (res < 0)
 		return -1;
 	if (!res)
@@ -4382,7 +4393,7 @@ static int create_one_file(struct apply_state *state,
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return 0;
-		res = try_create_file(path, mode, buf, size);
+		res = try_create_file(state, path, mode, buf, size);
 		if (res < 0)
 			return -1;
 		if (!res)
@@ -4404,7 +4415,7 @@ static int create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			res = try_create_file(newpath, mode, buf, size);
+			res = try_create_file(state, newpath, mode, buf, size);
 			if (res < 0)
 				return -1;
 			if (!res) {
@@ -4435,7 +4446,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
 
-	remove_file_from_index(&the_index, patch->new_name);
+	remove_file_from_index(state->repo->index, patch->new_name);
 	for (stage = 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
@@ -4445,7 +4456,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
-		if (add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		if (add_index_entry(state->repo->index, ce, ADD_CACHE_OK_TO_ADD) < 0) {
 			free(ce);
 			return error(_("unable to add cache entry for %s"),
 				     patch->new_name);
@@ -4619,7 +4630,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		}
 		string_list_clear(&cpath, 0);
 
-		rerere(0);
+		rerere(state->repo, 0);
 	}
 
 	return errs;
@@ -4697,7 +4708,8 @@ static int apply_patch(struct apply_state *state,
 						  state->index_file,
 						  LOCK_DIE_ON_ERROR);
 		else
-			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			repo_hold_locked_index(state->repo, &state->lock_file,
+					       LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4893,7 +4905,7 @@ int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		res = write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK);
+		res = write_locked_index(state->repo->index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
 			error(_("Unable to write new index file"));
 			res = -128;
-- 8< --
