Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D911F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKOMga (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfKOMg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so10845015wrw.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WYyMXuw7hO4USLhsFbwckPai4JubVXMA6ECZykRTltk=;
        b=CIOUd/8GikrRznFeB3crGBnUbePP/Pc1NmiieMLz0kpCKM5O/U6J1Q5GybnX8U6aBk
         2RKyK3oruPo45WOb3+/SB9SDT2sQg6Q+VSKk06jfJxq1JldRX9Cx+6xMaECmieBwlCcI
         ViLIM1qV+BJQCFprlntY7TKN11Ex7fEfN7TAilMnRlE4BCA5zVZIQidYBV8PDNXoO/56
         iFMaWq9uEvjArYCQekpcTLr7zqbJqJ2zXdiXNOKVWv50WSagxHWSQ1TlgC1w2m5EmIAi
         A4+ihAHkurt5Uwe/eInV3XfLQ/wOH9J/g8QsYI/lOFyf1i/m9XAyBhK1a2DHNAKeJbIT
         Yhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WYyMXuw7hO4USLhsFbwckPai4JubVXMA6ECZykRTltk=;
        b=Ggv+I0rM39GbrVPgYmsqUIUiG9o/29KaWOCjnZSBDghUtH5B8bjK7At6TnY4RKjaq8
         sSgaFDibmFxlHzD7QwBoAdlLE7P8f151UeMhGXyxokLLl4xyQuGvei+SfXbpihQGV7qo
         l+GqG2RwCY68+GpzlVqiBNo/vZc02dOPEffdqwlFj20CVbowMa0ppsDp7ABigmJ2rRc0
         fXj62CwvASy8BFvdRcrp0JBNYqEs18mTqII14JxswCZhSKbN19mq3M8o8UbCEsMu1DTG
         PdUAEcKbFPHpfdatQJPfDPLndVY8itWzrk/I/VNWaF02sN9GA8/Or6U7C0lovHnpRiRi
         HdKA==
X-Gm-Message-State: APjAAAXQ3KHmIr03E/aQ+wGoj4Goeqz5i8cXSFFP1f+SEXuwHwv0rmId
        ljBKRaqICVZ7fvFhqy/FlHghICCE
X-Google-Smtp-Source: APXvYqxyvnzk0FCdg0gOxz/n40Qlb+8+hAzJHauZdQpEU+BoFRgGPxcW9N0nxlRW0OhbzPWg9VWD5Q==
X-Received: by 2002:a05:6000:1605:: with SMTP id u5mr14300293wrb.252.1573821386226;
        Fri, 15 Nov 2019 04:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i13sm10829932wrp.12.2019.11.15.04.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:25 -0800 (PST)
Message-Id: <5c31bbd24ab937f5906f967f007d5bcd305779e2.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:18 +0000
Subject: [PATCH 4/8] built-in add -i: re-implement `revert` in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a relatively straight-forward port from the Perl version, with
the notable exception that we imitate `git reset -- <paths>` in the C
version rather than the convoluted `git ls-tree HEAD -- <paths> | git
update-index --index-info` followed by `git update-index --force-remove
-- <paths>` for the missed ones.

While at it, we fix the pretty obvious bug where the `revert` command
offers to unstage files that do not have staged changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index b0bda0cd2d..191a10b97d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -653,6 +653,114 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static void revert_from_diff(struct diff_queue_struct *q,
+			     struct diff_options *opt, void *data)
+{
+	int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *one = q->queue[i]->one;
+		struct cache_entry *ce;
+
+		if (!(one->mode && !is_null_oid(&one->oid))) {
+			remove_file_from_index(opt->repo->index, one->path);
+			printf(_("note: %s is untracked now.\n"), one->path);
+		} else {
+			ce = make_cache_entry(opt->repo->index, one->mode,
+					      &one->oid, one->path, 0, 0);
+			if (!ce)
+				die(_("make_cache_entry failed for path '%s'"),
+				    one->path);
+			add_index_entry(opt->repo->index, ce, add_flags);
+		}
+	}
+}
+
+static int run_revert(struct add_i_state *s, const struct pathspec *ps,
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
+{
+	int res = 0, fd;
+	size_t count, i, j;
+
+	struct object_id oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
+					     NULL);
+	struct lock_file index_lock;
+	const char **paths;
+	struct tree *tree;
+	struct diff_options diffopt = { NULL };
+
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		putchar('\n');
+		return 0;
+	}
+
+	opts->prompt = N_("Revert");
+	count = list_and_choose(s, files, opts);
+	if (count <= 0)
+		goto finish_revert;
+
+	fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
+	if (fd < 0) {
+		res = -1;
+		goto finish_revert;
+	}
+
+	if (is_initial)
+		oidcpy(&oid, s->r->hash_algo->empty_tree);
+	else {
+		tree = parse_tree_indirect(&oid);
+		if (!tree) {
+			res = error(_("Could not parse HEAD^{tree}"));
+			goto finish_revert;
+		}
+		oidcpy(&oid, &tree->object.oid);
+	}
+
+	ALLOC_ARRAY(paths, count + 1);
+	for (i = j = 0; i < files->items.nr; i++)
+		if (files->selected[i])
+			paths[j++] = files->items.items[i].string;
+	paths[j] = NULL;
+
+	parse_pathspec(&diffopt.pathspec, 0,
+		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH,
+		       NULL, paths);
+
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = revert_from_diff;
+	diffopt.flags.override_submodule_config = 1;
+	diffopt.repo = s->r;
+
+	if (do_diff_cache(&oid, &diffopt))
+		res = -1;
+	else {
+		diffcore_std(&diffopt);
+		diff_flush(&diffopt);
+	}
+	free(paths);
+	clear_pathspec(&diffopt.pathspec);
+
+	if (!res && write_locked_index(s->r->index, &index_lock,
+				       COMMIT_LOCK) < 0)
+		res = -1;
+	else
+		res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
+						   NULL, NULL, NULL);
+
+	if (!res)
+		printf(Q_("reverted %d path\n",
+			  "reverted %d paths\n", count), (int)count);
+
+finish_revert:
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -748,6 +856,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	} command_list[] = {
 		{ "status", run_status },
 		{ "update", run_update },
+		{ "revert", run_revert },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

