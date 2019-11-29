Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA1C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E4121771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjEwtj4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfK2VLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:11:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VLy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so36702255wrj.8
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l19lJjMla4QoR6B2vBTfLf3xnTPb5k6UmvlkzSljczM=;
        b=NjEwtj4CKPRGCg9iWZuOv1wIc2ejs75gEAnJKnl2Ej017zWzg+5j+J+hYMH91UwfB/
         qhGqQjayE9QcHQsdgs+mfppAIQ805ktSJFAhd10up80Nu+KWj9/ufBAZrxIRzHSbrdov
         x2uMbt0wOoc87p+U6WUpvKqmT5CX1+gDi+VL3TskNNzAaKDQ0W7t+iClJxNNFjfCCDSk
         SP6RLqsOl+yATcg2v+8ozQ67WeN/qWZPUkK/0ChauzbNLUiBxqs2+uvj9mvtwjSNUMCR
         58RGBE/7/RetWuU+OGCRFPW1tmYFyTS0os/s9lKQjKDOj4HYciocGMN8lupBEL71XFmf
         4ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l19lJjMla4QoR6B2vBTfLf3xnTPb5k6UmvlkzSljczM=;
        b=nD0VnZmJPHtnaDRGWoEILjbaBTjlDWkjiVdm2WVFX14FPvyyKWNlf3mQoVfkWRWrne
         YW614p4qYTbMiXgSg4H6So++pDjUQRphWOQyeQMoXpVlPj2Bjeio6hQdKRrxbmG+LLWh
         zDMIaYKorMpj1dCsobI3dd4PEkbjSuKLu6Jo6UiACr/Xs5NyHAUlsZGl7yzeOM4cWBWQ
         fQ7XWUDQnEGMgY0SaZIZG/+7cQ52p19p5cIBogRjPO+epjapvO8Or5+xpFExAdR5eXT8
         3vQoSfMr42fnGkRlrzSnRTgI/u+TcX0r767jESK/sTuciUoaxvFPnFxc+mK4ccVgIWUU
         ngwQ==
X-Gm-Message-State: APjAAAXO7OMMRBHQtAJpv2zZzEJJAEnm+0tdtvJAiUc0Vp+GDDuELlzm
        9Raiynh3BMTGm5REwmOjHajiWM56
X-Google-Smtp-Source: APXvYqxuil6DWQwssIJFRVyfEMe3Dyl8liY+otemzlBn4vfIxyz+h/5A5emGuiBctaZtLX3gEetabg==
X-Received: by 2002:a5d:574d:: with SMTP id q13mr9044195wrw.263.1575061910809;
        Fri, 29 Nov 2019 13:11:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm6611730wrl.3.2019.11.29.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:50 -0800 (PST)
Message-Id: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:40 +0000
Subject: [PATCH v2 0/9] built-in add -i: implement all commands in the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the js/builtin-add-i branch, this patch series implements the rest
of the commands in git add -i's main loop: update, revert, add_untracked, 
patch, diff, and quit. Apart from quit, these commands are all very similar
in that they first build a list of files, display it, let the user choose
which ones to act on, and then perform the action.

Note that the patch command is not actually converted to C, not completely
at least: the built-in version simply hands off to git add--interactive 
after letting the user select which files to act on.

The reason for this omission is practicality. Out of the 1,800+ lines of 
git-add--interactive.perl, over a thousand deal just with the git add -p 
part. I did convert that functionality already (to be contributed in a
separate patch series, see https://github.com/gitgitgadget/git/pull/173),
discovering that there is so little overlap between the git add --patch part
and the rest of git add --interactive that I could put the former into a
totally different file: add-patch.c.

Changes since v1:

 * As an introductory commit, we now release the pathspecs that we passed to
   the diff machinery.
 * The ternary in 1/8 (now 1/9) was adjusted from i ? to (i == 0) ? to make
   the flow more intuitive.
 * The commit message of 2/8 (now 3/9) no longer talks about an upgrade 
   command (which never existed)but about the update command (that I
   actually meant).

Johannes Schindelin (9):
  add-interactive: make sure to release `rev.prune_data`
  built-in add -i: allow filtering the modified files list
  built-in add -i: prepare for multi-selection commands
  built-in add -i: implement the `update` command
  built-in add -i: re-implement `revert` in C
  built-in add -i: re-implement `add-untracked` in C
  built-in add -i: implement the `patch` command
  built-in add -i: re-implement the `diff` command
  built-in add -i: offer the `quit` command

 add-interactive.c | 619 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 560 insertions(+), 59 deletions(-)


base-commit: 8c159044625e46de67cd8467f07424f38eb8301e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-171%2Fdscho%2Fadd-i-in-c-all-except-patch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-171/dscho/add-i-in-c-all-except-patch-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/171

Range-diff vs v1:

  -:  ---------- >  1:  1e02bf2d63 add-interactive: make sure to release `rev.prune_data`
  1:  1844c4d55e !  2:  fab098d86e built-in add -i: allow filtering the modified files list
     @@ -17,12 +17,21 @@
          and `diff-files` phases, and then skipping files in the second phase
          when they have not been seen in the first phase.
      
     +    Seeing as we change the meaning of the `phase` field, we rename it to
     +    `mode` to reflect that the order depends on the exact invocation of the
     +    `git add -i` command.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     + }
     + 
     + struct collection_status {
     +-	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } phase;
     ++	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } mode;
       
       	const char *reference;
       
     @@ -40,6 +49,15 @@
       			add_file_item(s->files, name);
       
       			entry = xcalloc(sizeof(*entry), 1);
     +@@
     + 		}
     + 
     + 		file_item = entry->item;
     +-		adddel = s->phase == FROM_INDEX ?
     ++		adddel = s->mode == FROM_INDEX ?
     + 			&file_item->index : &file_item->worktree;
     + 		adddel->seen = 1;
     + 		adddel->add = stat.files[i]->added;
      @@
       	free_diffstat_info(&stat);
       }
     @@ -59,7 +77,8 @@
       	struct object_id head_oid;
       	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
       					     &head_oid, NULL);
     - 	struct collection_status s = { FROM_WORKTREE };
     +-	struct collection_status s = { FROM_WORKTREE };
     ++	struct collection_status s = { 0 };
      +	int i;
       
       	if (discard_index(r->index) < 0 ||
     @@ -74,14 +93,23 @@
       		struct setup_revision_opt opt = { 0 };
       
      +		if (filter == INDEX_ONLY)
     -+			s.phase = i ? FROM_WORKTREE : FROM_INDEX;
     ++			s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
      +		else
     -+			s.phase = i ? FROM_INDEX : FROM_WORKTREE;
     ++			s.mode = (i == 0) ? FROM_WORKTREE : FROM_INDEX;
      +		s.skip_unseen = filter && i;
      +
       		opt.def = is_initial ?
       			empty_tree_oid_hex() : oid_to_hex(&head_oid);
       
     +@@
     + 		if (ps)
     + 			copy_pathspec(&rev.prune_data, ps);
     + 
     +-		if (s.phase == FROM_INDEX)
     ++		if (s.mode == FROM_INDEX)
     + 			run_diff_index(&rev, 1);
     + 		else {
     + 			rev.diffopt.flags.ignore_dirty_submodules = 1;
      @@
       static int run_status(struct add_i_state *s, const struct pathspec *ps,
       		      struct string_list *files, struct list_options *opts)
  2:  c324b47592 !  3:  58a581f4ee built-in add -i: prepare for multi-selection commands
     @@ -2,7 +2,7 @@
      
          built-in add -i: prepare for multi-selection commands
      
     -    The `upgrade`, `revert` and `add-untracked` commands allow selecting
     +    The `update`, `revert` and `add-untracked` commands allow selecting
          multiple entries. Let's extend the `list_and_choose()` function to
          accommodate those use cases.
      
     @@ -168,7 +168,8 @@
      +				}
       			}
       
     - 			p[sep] = '\0';
     + 			if (p[sep])
     + 				p[sep++] = '\0';
      -			if (index < 0)
      -				index = find_unique(p, items);
      +			if (from < 0) {
     @@ -199,7 +200,7 @@
      +					res += choose ? +1 : -1;
      +				}
      +
     - 			p += sep + 1;
     + 			p += sep;
       		}
       
      -		if (res != LIST_AND_CHOOSE_ERROR)
  3:  cba5f13152 =  4:  c311a29c77 built-in add -i: implement the `update` command
  4:  5c31bbd24a =  5:  f70723a160 built-in add -i: re-implement `revert` in C
  5:  5c498795b3 =  6:  952fbc8f79 built-in add -i: re-implement `add-untracked` in C
  6:  0c8a71e2e8 !  7:  cbd10da523 built-in add -i: implement the `patch` command
     @@ -51,9 +51,9 @@
       						    struct pathname_entry, ent);
      @@
       		file_item = entry->item;
     - 		adddel = s->phase == FROM_INDEX ?
     + 		adddel = s->mode == FROM_INDEX ?
       			&file_item->index : &file_item->worktree;
     -+		other_adddel = s->phase == FROM_INDEX ?
     ++		other_adddel = s->mode == FROM_INDEX ?
      +			&file_item->worktree : &file_item->index;
       		adddel->seen = 1;
       		adddel->add = stat.files[i]->added;
     @@ -84,7 +84,7 @@
       	struct object_id head_oid;
       	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
      @@
     - 		}
     + 			clear_pathspec(&rev.prune_data);
       	}
       	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
      +	if (unmerged_count)
  7:  499f3f19e0 =  8:  e4907112e4 built-in add -i: re-implement the `diff` command
  8:  dbcb340ede =  9:  5ba6cd31ab built-in add -i: offer the `quit` command

-- 
gitgitgadget
