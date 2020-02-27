Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA4C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 06:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACFA2467B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 06:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0clADHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgB0Gpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:45:54 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42479 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0Gpy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 01:45:54 -0500
Received: by mail-pg1-f179.google.com with SMTP id h8so933635pgs.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 22:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jGoIxHWnGDGc3o9oZKkAx7XT+NElhWtQHN5Bt41B8lc=;
        b=U0clADHU09WuN3BWitdSkeUw1jLAIgcYEUrcCuRLI3bVUsZST/ZciX2yMjwPu1aAd9
         WejeOJB4U9A2T26MLCx5VWpBQN8tCv39+DfCxoAhJZQAjmi1Rpkl8DsTe45x2bAEdUAV
         1vk+KfPzi25IBljMs7xXAcWfyGJXpZhoIS0WMwI1ZuVEIIjttaYTlVRQ5V4Z5iqbe4AN
         3fiWqjB+8/V41IF97+4KpEli+LdZbWnIZxkRsbfzmG7HfADPi9la8aKhaydZKT6SbT/b
         Im6ZSf/iX1/KRlQ4LEUrIzUFTiyHh37DmZWs37s4V3qN1raWph4lE2yhQlP0N0CcqsE8
         iXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jGoIxHWnGDGc3o9oZKkAx7XT+NElhWtQHN5Bt41B8lc=;
        b=SPMuz8PnR2wzd6BLLVltkBLGuqi+DAB2QWDZK8KNlG4Qn24CO5mk4UhWrZCptbJV4J
         JAepCzcEFgDyrRgJbfRBIeRHU+5b/SaYJ4odiYtm+1BmL9iDfKPDJOzMl57Oi3qxr/5G
         GA7qgAugBzPIyUKM8XJ/45mccXOMB720Ri8yyVPFA+kLvRdp7NxYWy8asEMAmP/2reIg
         0IORGLTIAKrLFTmSOiaRMfYXUGWDJ02fSo8r+//f6MAhT1/BUhbJGuwbmABYVWcdfGfy
         k1HrOfiB9nsPs6+vIBA8NUZ/wd3W6Dj32yIrrd6UGei7K7uo8RclLaCk5jjNcnEzWYrt
         HqBA==
X-Gm-Message-State: APjAAAUYjXef7IczMUmoBY4aicM8trSLtGI0FUs2XiGY7XvP1+5xWZao
        cGBwHmDx7hJ4BhSgPlA0Z1Siy7Nm
X-Google-Smtp-Source: APXvYqzBVZTiY+EmXH1CLpcN8hZzGUnUfEUd4jvppAaVwyrqKP/Zlhp5P5wrPvo0QZMGn8Ssu/Jxzw==
X-Received: by 2002:a62:1958:: with SMTP id 85mr2482117pfz.221.1582785952156;
        Wed, 26 Feb 2020 22:45:52 -0800 (PST)
Received: from [10.197.24.34] ([139.104.2.35])
        by smtp.gmail.com with ESMTPSA id 13sm5333022pfi.78.2020.02.26.22.45.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 22:45:50 -0800 (PST)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Feb 26, 2020)
Message-ID: <90529cab-54ef-4537-ec32-5c2c658e4005@gmail.com>
Date:   Thu, 27 Feb 2020 01:45:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-26-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-26.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-26.htm

---

pu	0499e6851714dfb1c1955459f7877dd0e19dfb87
jch	f0fb2e280f2e7a3834e630326ef106d8fcccce21
next	5900a2a8f925f2c0ac44ac71f8d2c1959bdec53b
master	2d2118b814c11f509e1aa76cb07110f7231668dc
master@{1}	51ebf55b9309824346a6589c9f3b130c6f371b8f


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Benno Evers	f1b15bc8 describe: dont abort too early when searching tags
builtin/describe.c
f1b15bc8 397) fprintf(stderr, _("finished search at %s\n"),
f1b15bc8 398) oid_to_hex(&c->object.oid));

brian m. carlson	9bf55b8e tag: store SHA-256 signatures in a header
builtin/mktag.c
9bf55b8e 148) !memcmp(tagger_line, "gpgsig-sha256 ", 14)) {
9bf55b8e 149) char *p = strpbrk(tagger_line + 1, "\n");
9bf55b8e 150) if (!p)
9bf55b8e 153) tagger_line = p + 1;
9bf55b8e 154) while (*tagger_line == ' ' && (p = strpbrk(tagger_line, "\n")))
9bf55b8e 155) tagger_line = p + 1;
9bf55b8e 156) if (!p)

builtin/tag.c
9bf55b8e 133) return sign_with_header(buffer, get_signing_key());

gpg-interface.c
9bf55b8e 376) return parse_buffer_signed_by_header(buf, size, payload, signature);

brian m. carlson	e02a7141 worktree: allow repository version 1
worktree.c
e02a7141 470) strbuf_release(&err);

brian m. carlson	768e30ea hash: implement and use a context cloning function
sha1-file.c
768e30ea 98) static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
768e30ea 100) git_SHA256_Clone(&dst->sha256, &src->sha256);
768e30ea 101) }
768e30ea 118) static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)

brian m. carlson	e8356e2d fast-import: add options for rewriting submodules
fast-import.c
e8356e2d 2183) return -1;
e8356e2d 3058) return;
e8356e2d 3316) die_errno("cannot read '%s'", f);

brian m. carlson	12373043 fast-import: permit reading multiple marks files
fast-import.c
12373043 1149) insert_mark(marks, mark, e);

brian m. carlson	3c9331a1 builtin/init-db: add environment variable for new repo hash
builtin/init-db.c
3c9331a1 378) int env_algo = hash_algo_by_name(env);
3c9331a1 379) if (env_algo == GIT_HASH_UNKNOWN)
3c9331a1 381) repo_fmt->hash_algo = env_algo;

brian m. carlson	8b8f7189 builtin/init-db: allow specifying hash algorithm on command line
builtin/init-db.c
8b8f7189 376) repo_fmt->hash_algo = hash;
8b8f7189 599) hash_algo = hash_algo_by_name(object_format);
8b8f7189 600) if (hash_algo == GIT_HASH_UNKNOWN)

brian m. carlson	efa7ae36 init-db: move writing repo version into a function
builtin/init-db.c
efa7ae36 192) repo_version = GIT_REPO_VERSION_READ;
efa7ae36 200) git_config_set("extensions.objectformat",

Denton Liu	448bea61 sequencer: make apply_rebase() accept a path
sequencer.c
448bea61 5143) apply_autostash(rebase_path_autostash());

Denton Liu	fa717471 sequencer: use file strbuf for read_oneliner()
sequencer.c
fa717471 438) goto done;
fa717471 444) goto done;

Denton Liu	b3137f2e reset: extract reset_head() from rebase
reset.c
b3137f2e 37) ret = -1;
b3137f2e 38) goto leave_reset_head;
b3137f2e 43) goto leave_reset_head;
b3137f2e 65) goto leave_reset_head;
b3137f2e 71) goto leave_reset_head;
b3137f2e 76) goto leave_reset_head;
b3137f2e 80) ret = -1;
b3137f2e 81) goto leave_reset_head;
b3137f2e 89) goto leave_reset_head;
b3137f2e 108) } else if (old_orig)
b3137f2e 109) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

Denton Liu	e71223c6 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
e71223c6 1028) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	06ebea5c rebase: generify reset_head()
builtin/rebase.c
06ebea5c 868) reset_head(the_repository, &opts->orig_head, "checkout",
06ebea5c 869)    opts->head_name, 0,

Denton Liu	186dbeed rebase: use read_oneliner()
builtin/rebase.c
186dbeed 618) } else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))

Derrick Stolee	3d2f906e diff: halt tree-diff early after max_changes
tree-diff.c
3d2f906e 438) break;

Derrick Stolee	92667ee9 commit-graph: examine commits by generation number
commit-graph.c
92667ee9 89) else if (a->date > b->date)
92667ee9 90) return 1;
92667ee9 91) return 0;
92667ee9 1296) QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);

Emily Shaffer	54391444 bugreport: summarize contents of alternates file
bugreport.c
54391444 282) while (strbuf_getline(&alternate, file) != EOF) {
54391444 283) if (!access(alternate.buf, F_OK))
54391444 284) exists++;
54391444 286) broken++;
54391444 289) strbuf_addf(alternates_info,
54391444 295) fclose(file);
54391444 296) strbuf_release(&alternate);
54391444 297) strbuf_release(&alternates_path);

Emily Shaffer	7e925ee2 bugreport: add git-remote-https version
bugreport.c
7e925ee2 23)     strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");

Emily Shaffer	8edf9c76 bugreport: add uname info
bugreport.c
8edf9c76 39) strbuf_addf(sys_info, "uname() failed with code %d\n", errno);

Emily Shaffer	6c0f5520 bugreport: add config values from safelist
bugreport.c
6c0f5520 73) strbuf_addf(config_info, "%s:\n", bugreport_config_safelist[idx]);
6c0f5520 74) for_each_string_list_item(it, list) {
6c0f5520 75) kv_info = it->util;
6c0f5520 76) strbuf_addf(config_info, "  %s (%s)\n", it->string,
6c0f5520 77)     kv_info ? config_scope_name(kv_info->scope)

Emily Shaffer	679ab92c bugreport: add tool to generate debugging info
bugreport.c
679ab92c 406) strbuf_release(&report_path);

Emily Shaffer	13b1ca98 bugreport: collect list of populated hooks
bugreport.c
13b1ca98 126) strbuf_addstr(hook_info, iter->string);
13b1ca98 127) strbuf_complete_line(hook_info);

Emily Shaffer	7a4dc0e0 bugreport: count loose objects
bugreport.c
7a4dc0e0 132) static int loose_object_cb(const struct object_id *oid, const char *path,
7a4dc0e0 134) int *loose_object_count = data;
7a4dc0e0 136) if (loose_object_count) {
7a4dc0e0 137) (*loose_object_count)++;
7a4dc0e0 138) return 0;
7a4dc0e0 141) return 1;

Emily Shaffer	7a226a68 bugreport: add packed object summary
bugreport.c
7a226a68 193) pack_count++;
7a226a68 198) open_pack_index(pack);
7a226a68 199) object_count += pack->num_objects;

Emily Shaffer	6bf7dba7 help: move list_config_help to builtin/help
builtin/help.c
6bf7dba7 123) puts(var);
6bf7dba7 124) continue;

Emily Shaffer	b1cdb5e9 bugreport: list contents of $OBJDIR/info
bugreport.c
b1cdb5e9 216) return;
b1cdb5e9 225) strbuf_addbuf(contents, dirpath);
b1cdb5e9 226) strbuf_addstr(contents, d->d_name);
b1cdb5e9 227) strbuf_complete_line(contents);
b1cdb5e9 229) if (d->d_type == DT_DIR) {
b1cdb5e9 230) strbuf_addstr(dirpath, d->d_name);
b1cdb5e9 231) list_contents_of_dir_recursively(contents, dirpath);
b1cdb5e9 233) strbuf_setlen(dirpath, path_len);

Emily Shaffer	a6ea0fe2 bugreport: gather git version and build info
help.c
a6ea0fe2 641) strbuf_addstr(buf, "no commit associated with this build\n");

Garima Singh	b6d925e7 bloom: core Bloom filter implementation for changed paths
bloom.c
b6d925e7 247) for (i = 0; i < diff_queued_diff.nr; i++)
b6d925e7 248) diff_free_filepair(diff_queued_diff.queue[i]);
b6d925e7 249) filter->data = NULL;
b6d925e7 250) filter->len = 0;
b6d925e7 267) return -1;

t/helper/test-bloom.c
b6d925e7 20) printf("No filter.\n");
b6d925e7 21) return;

Garima Singh	282c08a9 commit-graph: write Bloom filters to commit graph file
commit-graph.c
282c08a9 328) chunk_repeated = 1;
282c08a9 335) chunk_repeated = 1;
282c08a9 342) break;
282c08a9 371) graph->chunk_bloom_indexes = NULL;
282c08a9 372) graph->chunk_bloom_data = NULL;
282c08a9 373) graph->bloom_filter_settings = NULL;
282c08a9 1087) progress = start_delayed_progress(
282c08a9 1089) ctx->commits.nr);
282c08a9 1112) progress = start_delayed_progress(
282c08a9 1114) ctx->commits.nr);
282c08a9 1288) progress = start_delayed_progress(

Garima Singh	6bdbf235 commit-graph: compute Bloom filters for changed paths
commit-graph.c
6bdbf235 1290) ctx->commits.nr);

Jeff King	dc9f0216 commit-graph: examine changed-path objects in pack order
commit-graph.c
dc9f0216 62) return; /* should never happen, but be lenient */
dc9f0216 67) static int commit_pos_cmp(const void *va, const void *vb)
dc9f0216 69) const struct commit *a = *(const struct commit **)va;
dc9f0216 70) const struct commit *b = *(const struct commit **)vb;
dc9f0216 71) return commit_pos_at(&commit_pos, a) -
dc9f0216 72)        commit_pos_at(&commit_pos, b);

Paolo Bonzini	e8ef1e8d am: convert "resume" variable to a struct
builtin/am.c
e8ef1e8d 2345) resume.mode = RESUME_APPLY;

Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
builtin/commit-graph.c
a599e2c9 75) *to = 0;
a599e2c9 76) return 0;
a599e2c9 86) *to |= COMMIT_GRAPH_INPUT_APPEND;

Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
commit-graph.c
5d5916fd 1751) break;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Heba Waly	a423e650 advice: revamp advise API
advice.c
a423e650 185) return get_config_value(PUSH_UPDATE_REJECTED) &&
a423e650 186)        get_config_value(PUSH_UPDATE_REJECTED_ALIAS);

Jeff King	3f83fd5e pack-objects: read delta base oid into object_id struct
builtin/pack-objects.c
3f83fd5e 1647) if (!in_same_island(&delta->idx.oid, base_oid))

Jeff King	6ac9760a packed_object_info(): use object_id internally for delta base
packfile.c
6ac9760a 1245) return -1;
6ac9760a 1249) return -1;
6ac9760a 1253) return -1;

Jeff King	2fecc48c packfile: drop nth_packed_object_sha1()
packfile.c
2fecc48c 1878) return -1;

Jeff King	b99b6bcc packed_object_info(): use object_id for returning delta base
sha1-file.c
b99b6bcc 1478) oidclr(oi->delta_base_oid);

Junio C Hamano	985e6002 Merge branch 'jk/nth-packed-object-id' into jch
pack-bitmap.c
985e6002 799) nth_packed_object_id(&oid, pack, entry->nr);

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1476)     return -1;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Elijah Newren	8a997ed1 rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
8a997ed1 695) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	e98c4269 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
e98c4269 2523) opts->keep_redundant_commits = 1;

Elijah Newren	10cdb9f3 rebase: rename the two primary rebase backends
builtin/rebase.c
10cdb9f3 1664) if (is_merge(&options))

Elijah Newren	d48e5e21 rebase (interactive-backend): make --keep-empty the default
sequencer.c
d48e5e21 1529) return originally_empty;

Hariom Verma	4ef34648 receive.denyCurrentBranch: respect all worktrees
builtin/receive-pack.c
4ef34648 998) else if (git_work_tree_cfg)
4ef34648 999) work_tree = git_work_tree_cfg;
4ef34648 1001) work_tree = "..";
4ef34648 1008) git_dir = get_git_dir();

Jeff King	792f8119 rev-list: factor out bitmap-optimized routines
builtin/rev-list.c
792f8119 401) return -1;
792f8119 444) return -1;

Jeff King	84243da1 pack-bitmap: implement BLOB_LIMIT filtering
pack-bitmap.c
84243da1 799) nth_packed_object_oid(&oid, pack, entry->nr);

Jeff King	4f3bd560 pack-bitmap: implement BLOB_NONE filtering
pack-bitmap.c
4f3bd560 732) continue;

Jeff King	4eb707eb rev-list: allow commit-only bitmap traversals
pack-bitmap.c
4eb707eb 626)     (obj->type == OBJ_TAG && !revs->tag_objects))
4eb707eb 627) continue;

Jeff King	608d9c93 rev-list: allow bitmaps when counting objects
builtin/rev-list.c
608d9c93 410) return -1;

Pranit Bauva	6c69f222 bisect: libify `bisect_next_all`
bisect.c
6c69f222 1024) return BISECT_FAILED;

Pranit Bauva	45b63708 bisect: libify `check_good_are_ancestors_of_bad` and its dependents
bisect.c
45b63708 920) warning_errno(_("could not create file '%s'"),

René Scharfe	2ce6d075 use strpbrk(3) to search for characters from a given set
builtin/show-branch.c
2ce6d075 539) if (strpbrk(av, "*?[")) {

Tanushree Tumane	bfacfce7 bisect--helper: introduce new `decide_next()` function
builtin/bisect--helper.c
bfacfce7 320) return -1;
bfacfce7 321) return 0;

Tanushree Tumane	292731c4 bisect--helper: change `retval` to `res`
builtin/bisect--helper.c
292731c4 227) res = -1;
292731c4 233) res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
292731c4 410) res = -1;
292731c4 416) res = -1;
292731c4 582) res = -1;
292731c4 594) res = -1;
292731c4 606) res = -1;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Bert Wesarg	1a83068c remote: clean-up by returning early to avoid one indentation
builtin/remote.c
1a83068c 287) return 0;

Bert Wesarg	f2a2327a config: provide access to the current line number
config.c
f2a2327a 3346) return cf->linenr;

Bert Wesarg	88f8576e pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
rebase.c
88f8576e 26) return REBASE_MERGES;



