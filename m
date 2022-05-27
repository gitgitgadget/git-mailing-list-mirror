Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B099C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbiE0PNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiE0PNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:13:38 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBDF1CFF3
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:13:37 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s32-20020a4a96a3000000b0040e504332adso851591ooi.10
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PcWUwSlXw+hxVZOu9O88sHZS4luc/zYq02RcDE3bhq0=;
        b=L5RH6wuwReonfB7rTSwrNkUKkdyP+rGNBWkVP+ereaWPuAlnnn6thP0C+Bcl8hYTec
         nmU4k6gyCub+jbsdSe/IGqc7+DHsxQMe8j4bP8gGkdLJcEUMmVMV1sgrep2uqV+x/Xts
         AvpqPXz+XIZT6JRkjAVVLAdJWQMhy12xaNIhmx5B1lmXxsUdOvzIMfar7r+OKIGiVaUz
         oDfTi5tEUVsULhzv0XJ8IToEuCRI8ISidys4c10oCQxqoUSWXbot9qO0h6K7CctHzEag
         aEwqq9AaBr6UUMLK5kENsC9BMWzwnjK8s+vmd5GsaXqvw3DoMvmRlX6Tfl2D/F3J3mR8
         2luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PcWUwSlXw+hxVZOu9O88sHZS4luc/zYq02RcDE3bhq0=;
        b=e4j8BuFvzwFHCyefJEknJuYhXHFKx9lgOQ2PDsd2LryIbzOomGEn4WoG34mXP5w1DL
         HUB2naqEfJmYCzQUS2MkFY1tKwadOsBSHMtDQbNRzm4w9g5eUQnoSI9laqr0zMudXbjC
         sPyDDuSwnyTTf0Sg3VzJNN0MvKrM5nBGOaVR8osqD3lV64/v2kqKgW7BdjKfEq16qyMt
         dZw7g6S4NswI97bAAlPAMxerCcNUE0zvqqJ8omWF/PsVSKu0PQ1PpQiFaKicpnOPC2zH
         gXdWAT4gQ46nhEYdFbjle2xOe2hcGf392qobthY0zDiWwo/++RNpN+pN8rxDujRuNb49
         S18A==
X-Gm-Message-State: AOAM531DEH5Gn7by9YqS0Rifdx0YRGApZDhoP8UyuaswNbmRb2UOi3//
        1V/GIXatzKzxnq9wF+aqwR3y
X-Google-Smtp-Source: ABdhPJxXi64wtZqBdCTEko9b5tyJyECYKyv/Uz89+F9tGi2yndlmz2/ZqsYbvPeCFfrLz2nGf3iCuQ==
X-Received: by 2002:a4a:c894:0:b0:40e:85a3:484b with SMTP id t20-20020a4ac894000000b0040e85a3484bmr10638629ooq.11.1653664416573;
        Fri, 27 May 2022 08:13:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9d56:33a:55eb:168? ([2600:1700:e72:80a0:9d56:33a:55eb:168])
        by smtp.gmail.com with ESMTPSA id j17-20020a4a8891000000b0035eb4e5a6bbsm1976678ooa.17.2022.05.27.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 08:13:36 -0700 (PDT)
Message-ID: <0884b97b-0745-5cad-3034-a679be5d6c3a@github.com>
Date:   Fri, 27 May 2022 11:13:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [WIP v2 2/5] mv: check if out-of-cone file exists in index with
 SKIP_WORKTREE bit
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220527100804.209890-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
> Originally, moving a <source> file which is not on-disk but exists in
> index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
> out with "bad source".
> 
> Change the checking logic, so that such <source>
> file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
> instead of "bad source"; also user now can supply a "--sparse" flag so
> this operation can be carried out successfully.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 26 +++++++++++++++++++++++++-
>  t/t7002-mv-sparse-checkout.sh |  4 ++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba83..32ad4d5682 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  		length = strlen(src);
>  		if (lstat(src, &st) < 0) {
> +			/*
> +			 * TODO: for now, when you try to overwrite a <destination>
> +			 * with your <source> as a sparse file, if you supply a "--sparse"
> +			 * flag, then the action will be done without providing "--force"
> +			 * and no warning.
> +			 *
> +			 * This is mainly because the sparse <source>
> +			 * is not on-disk, and this if-else chain will be cut off early in
> +			 * this check, thus the "--force" check is ignored. Need fix.
> +			 */

I wonder if this is worth the comment here, or if we'd rather see
the mention in the commit message. You have documented tests that
fail in this case, so we already have something that marks this
as "TODO" in a more discoverable place.

> +			int pos = cache_name_pos(src, length);
> +			if (pos >= 0) {
> +				const struct cache_entry *ce = active_cache[pos];
> +
> +				if (ce_skip_worktree(ce)) {
> +					if (!ignore_sparse)
> +						string_list_append(&only_match_skip_worktree, src);
> +					else
> +						modes[i] = SPARSE;


> +				}
> +				else
> +					bad = _("bad source");

style nit:

	} else {
		bad = _("bad source");
	}

> +			}
>  			/* only error if existence is expected. */
> -			if (modes[i] != SPARSE)
> +			else if (modes[i] != SPARSE)
>  				bad = _("bad source");

For this one, the comment makes it difficult to connect the 'else
if' to its corresponding 'if'. Perhaps:

	} else if (modes[i] != SPARSE) {
		/* only error if existence is expected. */
		bad = _("bad source");
	}

>  		} else if (!strncmp(src, dst, length) &&
>  				(dst[length] == 0 || dst[length] == '/')) {

In general, I found this if/else-if chain hard to grok, and
a lot of it is because we have "simple" cases at the end
and the complicated parts have ever-increasing nesting. This
is mostly due to the existing if/else-if chain in this method.

Here is a diff that replaces that if/else-if chain with a
'goto' trick to jump ahead, allowing some code to decrease in
tabbing:

---- >8 ----

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba831..1ca2c21da89 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -186,53 +186,68 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
 			/* only error if existence is expected. */
-			if (modes[i] != SPARSE)
+			if (modes[i] != SPARSE) {
 				bad = _("bad source");
-		} else if (!strncmp(src, dst, length) &&
-				(dst[length] == 0 || dst[length] == '/')) {
+				goto act_on_entry;
+			}
+		}
+		if (!strncmp(src, dst, length) &&
+		    (dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
-		} else if ((src_is_dir = S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) == 0)
+			goto act_on_entry;
+		}
+		if ((src_is_dir = S_ISDIR(st.st_mode))
+		    && lstat(dst, &st) == 0) {
 			bad = _("cannot move directory over file");
-		else if (src_is_dir) {
+			goto act_on_entry;
+		}
+		if (src_is_dir) {
+			int j, dst_len, n;
 			int first = cache_name_pos(src, length), last;
 
-			if (first >= 0)
+			if (first >= 0) {
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
-			else if (index_range_of_same_dir(src, length,
-							 &first, &last) < 1)
+				goto act_on_entry;
+			} else if (index_range_of_same_dir(src, length,
+							   &first, &last) < 1) {
 				bad = _("source directory is empty");
-			else { /* last - first >= 1 */
-				int j, dst_len, n;
-
-				modes[i] = WORKING_DIRECTORY;
-				n = argc + last - first;
-				REALLOC_ARRAY(source, n);
-				REALLOC_ARRAY(destination, n);
-				REALLOC_ARRAY(modes, n);
-				REALLOC_ARRAY(submodule_gitfile, n);
-
-				dst = add_slash(dst);
-				dst_len = strlen(dst);
-
-				for (j = 0; j < last - first; j++) {
-					const struct cache_entry *ce = active_cache[first + j];
-					const char *path = ce->name;
-					source[argc + j] = path;
-					destination[argc + j] =
-						prefix_path(dst, dst_len, path + length + 1);
-					modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
-					submodule_gitfile[argc + j] = NULL;
-				}
-				argc += last - first;
+				goto act_on_entry;
 			}
-		} else if (!(ce = cache_file_exists(src, length, 0))) {
+
+			/* last - first >= 1 */
+			modes[i] = WORKING_DIRECTORY;
+			n = argc + last - first;
+			REALLOC_ARRAY(source, n);
+			REALLOC_ARRAY(destination, n);
+			REALLOC_ARRAY(modes, n);
+			REALLOC_ARRAY(submodule_gitfile, n);
+
+			dst = add_slash(dst);
+			dst_len = strlen(dst);
+
+			for (j = 0; j < last - first; j++) {
+				const struct cache_entry *ce = active_cache[first + j];
+				const char *path = ce->name;
+				source[argc + j] = path;
+				destination[argc + j] =
+					prefix_path(dst, dst_len, path + length + 1);
+				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
+				submodule_gitfile[argc + j] = NULL;
+			}
+			argc += last - first;
+			goto act_on_entry;
+		}
+		if (!(ce = cache_file_exists(src, length, 0))) {
 			bad = _("not under version control");
-		} else if (ce_stage(ce)) {
+			goto act_on_entry;
+		}
+		if (ce_stage(ce)) {
 			bad = _("conflicted");
-		} else if (lstat(dst, &st) == 0 &&
-			 (!ignore_case || strcasecmp(src, dst))) {
+			goto act_on_entry;
+		}
+		if (lstat(dst, &st) == 0 &&
+		    (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
 				/*
@@ -246,34 +261,40 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = _("Cannot overwrite");
 			}
-		} else if (string_list_has_string(&src_for_dst, dst))
+			goto act_on_entry;
+		}
+		if (string_list_has_string(&src_for_dst, dst)) {
 			bad = _("multiple sources for the same target");
-		else if (is_dir_sep(dst[strlen(dst) - 1]))
+			goto act_on_entry;
+		}
+		if (is_dir_sep(dst[strlen(dst) - 1])) {
 			bad = _("destination directory does not exist");
-		else {
-			/*
-			 * We check if the paths are in the sparse-checkout
-			 * definition as a very final check, since that
-			 * allows us to point the user to the --sparse
-			 * option as a way to have a successful run.
-			 */
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(src, &the_index)) {
-				string_list_append(&only_match_skip_worktree, src);
-				skip_sparse = 1;
-			}
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(dst, &the_index)) {
-				string_list_append(&only_match_skip_worktree, dst);
-				skip_sparse = 1;
-			}
-
-			if (skip_sparse)
-				goto remove_entry;
+			goto act_on_entry;
+		}
 
-			string_list_insert(&src_for_dst, dst);
+		/*
+		 * We check if the paths are in the sparse-checkout
+		 * definition as a very final check, since that
+		 * allows us to point the user to the --sparse
+		 * option as a way to have a successful run.
+		 */
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(src, &the_index)) {
+			string_list_append(&only_match_skip_worktree, src);
+			skip_sparse = 1;
+		}
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(dst, &the_index)) {
+			string_list_append(&only_match_skip_worktree, dst);
+			skip_sparse = 1;
 		}
 
+		if (skip_sparse)
+			goto remove_entry;
+
+		string_list_insert(&src_for_dst, dst);
+
+act_on_entry:
 		if (!bad)
 			continue;
 		if (!ignore_errors)

---- >8 ----

But mostly the reason for this refactor is that the following
diff should be equivalent to yours:

---- >8 ----

diff --git a/builtin/mv.c b/builtin/mv.c
index d8b5c24fb5..add48e23b4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -185,11 +185,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
-			/* only error if existence is expected. */
-			if (modes[i] != SPARSE) {
+			int pos;
+			const struct cache_entry *ce;
+
+			pos = cache_name_pos(src, length);
+			if (pos < 0) {
+				/* only error if existence is expected. */
+				if (modes[i] != SPARSE)
+					bad = _("bad source");
+				goto act_on_entry;
+			}
+
+			ce = active_cache[pos];
+			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
 				goto act_on_entry;
 			}
+
+			if (!ignore_sparse)
+				string_list_append(&only_match_skip_worktree, src);
+			else
+				modes[i] = SPARSE;
+			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
 		    (dst[length] == 0 || dst[length] == '/')) {
---- >8 ---

To me, this is a bit easier to parse, since we find the error
cases and jump to the action before continuing on the "happy
path". It does involve that first big refactor first, so I'd
like to hear opinions of other contributors before you jump to
taking this suggestion.

Thanks,
-Stolee
