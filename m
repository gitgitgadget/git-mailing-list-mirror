Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F5CC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9ED207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvxcGkLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHCPAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCPAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:00:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55631C061756
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 07:50:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b25so28383619qto.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KGx2p4lc22IoaXPyva6m3l9SUhX/GHF/bVigAubLZrk=;
        b=YvxcGkLVkmGnmihoIlVXLzafaVtUuTS+cOG1AMtdH/GhyAT6Wklf0kwppN+5n3b0Yg
         fI37WvmGum2hMVNog+LtZeIZ8wAZIB8KnToJvNVu/Qnsn4kLycGrVe+uRbRnwlUPgoo7
         JmAtUHaU76yUHM/7o/l20+N+3NgGoFwG8zH+FuPgyi9UY/fLjvOdFcn7l0+DBYg9EhNs
         4o/LJi2xLLuTOmGebA2uNAruEpCm2v5MjXQnFQx5ewEbcdpkBXbsfnMMJc0mAe1cVtIn
         rJ3Y5D69pxQzjlNLhwQUAc9D4x0962imWCVpDJZm7AihP0qu7v5/rLd0lu1ZLdy2Q9Ph
         XMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KGx2p4lc22IoaXPyva6m3l9SUhX/GHF/bVigAubLZrk=;
        b=co7u7inmadmOn582g3Edj1P43Hlc2iWRai3CeReSd59s2XnAcX5GfT8AKJcnaXu+vy
         YD/TOSeNsaFCZYuEppVBb8nDpbwJCZWAlId/li2iWJTH2tq8uX97LBOZonffgxTsYkAh
         d1NsqdoxbQSaTTINqRZRzzRyhOXbujx6hkCL8LBH29neD/7MuzPt60aiXpX7i8absHaX
         m7Fc0ceUJMUiGlVT+/mAmuZB3Drg7xsIYWZAJI2IsshwjtIgUQzjyA/XQ20KbQOegy2V
         MRNkCOAqiooISj502Zo3F0DVkpRu9w3xcYgTpDhRHKns6KRYHQC9YN6s7j3UFr5X7zEh
         /AqQ==
X-Gm-Message-State: AOAM532qyzNA3CiR1tO49bT669yEbCXg1LGoX2bzTA/2p2rsLvCn4P8e
        KNqGWrZrvg9GquZpwgCmRcHmAI5oP1Q=
X-Google-Smtp-Source: ABdhPJwpPYPeag85mSQwijZ0deY1b7p/wx4gWD44U7lsgvki2kTrKEYhK8MO2ibvokGhWHYXzA8foQ==
X-Received: by 2002:aed:3461:: with SMTP id w88mr16791170qtd.180.1596466207953;
        Mon, 03 Aug 2020 07:50:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdad:2336:408b:dfdf? ([2600:1700:e72:80a0:bdad:2336:408b:dfdf])
        by smtp.gmail.com with ESMTPSA id b2sm21031798qto.82.2020.08.03.07.50.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 07:50:07 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (August 3, 2020)
Message-ID: <f47a1b6b-f17f-c95f-ff0a-bcc4d12bdbb4@gmail.com>
Date:   Mon, 3 Aug 2020 10:50:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Please ignore all of the strvec_push* lines, as those are routine refactors,
and the lack of coverage is due to the previous code being uncovered. This is
not an issue with Peff's commit.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-08-03-commits.txt

---

seen	a4f4416e52c27b4f211311ee0b851e72179b5df4
jch	851d073fe0c0632d14b39ab8434af1d710ae908b
next	b10cc79966954619f1f5981f20a3a6476b5dd483
master	85b4e0a6dc8407de6f69808d9ee6debdf167ced3
master@{1}	bd42bbe1a46c0fe486fc33e82969275e27e4dc19


Uncovered code in 'seen' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1638) return NULL;
812a5889 1645) return branch->refname;
812a5889 1660) return NULL;
812a5889 1774) return NULL;

Derrick Stolee	c74ad39b maintenance: add auto condition for commit-graph task
builtin/gc.c
c74ad39b 734) oid = &peeled;
c74ad39b 736) return 0;
c74ad39b 740) return 0;
c74ad39b 742) return 0;
c74ad39b 761) result = 1;
c74ad39b 762) break;
c74ad39b 781) return 0;
c74ad39b 783) return 1;

Derrick Stolee	2bc0598a maintenance: add commit-graph task
builtin/gc.c
2bc0598a 828) return 1;
2bc0598a 836) chain_path = get_commit_graph_chain_filename(r->objects->odb);
2bc0598a 837) if (unlink(chain_path)) {
2bc0598a 841) free(chain_path);
2bc0598a 843) if (!run_write_commit_graph())
2bc0598a 844) return 0;
2bc0598a 847) return 1;

Derrick Stolee	46b9d9a3 maintenance: add prefetch task
builtin/gc.c
46b9d9a3 882) result = 1;
46b9d9a3 883) goto cleanup;

Derrick Stolee	b3a53c21 maintenance: create auto condition for loose-objects
builtin/gc.c
b3a53c21 951) return 0;
b3a53c21 953) return 1;

Derrick Stolee	27d1a32d maintenance: add loose-objects task
builtin/gc.c
27d1a32d 1005) return 1;
27d1a32d 1022) result = 1;

Derrick Stolee	642b98f6 maintenance: add incremental-repack auto condition
builtin/gc.c
642b98f6 1042) return 0;
642b98f6 1048) return 0;
642b98f6 1050) return 1;

Derrick Stolee	bfe797a6 maintenance: add incremental-repack task
builtin/gc.c
bfe797a6 1078) static int rewrite_multi_pack_index(void)
bfe797a6 1080) struct repository *r = the_repository;
bfe797a6 1081) char *midx_name = get_midx_filename(r->objects->odb->path);
bfe797a6 1083) unlink(midx_name);
bfe797a6 1084) free(midx_name);
bfe797a6 1086) return multi_pack_index_write();
bfe797a6 1101) return 1;
bfe797a6 1191) return 0;
bfe797a6 1195) return 1;
bfe797a6 1197) return rewrite_multi_pack_index();
bfe797a6 1199) return 1;
bfe797a6 1201) return !!rewrite_multi_pack_index();
bfe797a6 1203) return 1;
bfe797a6 1205) return !!rewrite_multi_pack_index();

Derrick Stolee	3814a14c maintenance: auto-size incremental-repack batch
builtin/gc.c
3814a14c 1160) result_size = TWO_GIGABYTES;

Derrick Stolee	417ead9f maintenance: initialize task array
builtin/gc.c
417ead9f 1318) result = 1;

Derrick Stolee	f22b2460 midx: use start_delayed_progress()
midx.c
f22b2460 972) progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),

Emily Shaffer	c1debc60 parse-options: parse into argv_array
parse-options-cb.c
c1debc60 212) if (unset) {
c1debc60 214) return 0;
c1debc60 217) if (!arg)
c1debc60 218) return -1;
c1debc60 221) return 0;

Emily Shaffer	fe6127f2 hook: add list command
builtin/hook.c
fe6127f2 44) printf(_("no commands configured for hook '%s'\n"),
fe6127f2 46) return 0;

hook.c
fe6127f2 85) return NULL;

Emily Shaffer	c45caa8c hook: add 'run' subcommand
builtin/hook.c
c45caa8c 85) usage_msg_opt(_("a hookname must be provided to operate on."),

hook.c
c45caa8c 95) emplace_hook(&hook_head, legacy_hook_path);

Junio C Hamano	328d5528 Merge branch 'es/config-hooks' into seen
parse-options-cb.c
328d5528 208) int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
328d5528 210) struct strvec *v = opt->value;
328d5528 213) strvec_clear(v);
328d5528 220) strvec_push(v, arg);

Junio C Hamano	5b26a7ec SQUASH???
builtin/config.c
5b26a7ec 258) int v = git_parse_maybe_bool(value_);
5b26a7ec 259) if (v < 0)
5b26a7ec 262) strbuf_addstr(buf, v ? "true" : "false");
5b26a7ec 425) int v = git_parse_maybe_bool(value);
5b26a7ec 426) if (v < 0)

Lin Sun	6571d827 Support auto-merge for meld to follow the vim-diff behavior
builtin/config.c
6571d827 99) new_type = TYPE_BOOL_OR_STR;
6571d827 260) strbuf_addstr(buf, value_);
6571d827 427) return xstrdup(value);
6571d827 429) return xstrdup(v ? "true" : "false");

Matheus Tavares	e26e8bfc grep: honor sparse checkout patterns
builtin/grep.c
e26e8bfc 579) if (file_exists(sparse_file)) {
e26e8bfc 583) free(sparse_file);
e26e8bfc 584) free(patterns);
e26e8bfc 585) return NULL;

Matheus Tavares	a2371e32 t/helper/test-config: facilitate addition of new cli options
t/helper/test-config.c
a2371e32 103) goto print_usage_error;
a2371e32 160) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 167) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 175) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 205) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 232) printf("Value not found for \"%s\"\n", argv[1]);

Matheus Tavares	92bca22f config: correctly read worktree configs in submodules
t/helper/test-config.c
92bca22f 109) goto print_usage_error;
92bca22f 114) fprintf(stderr, "Cannot use --submodule with read_early_config\n");
92bca22f 115) return TC_USAGE_ERROR;
92bca22f 130) fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
92bca22f 132) free(subrepo);
92bca22f 133) ret = TC_USAGE_ERROR;
92bca22f 134) goto out;
92bca22f 187) fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
92bca22f 188) ret = TC_USAGE_ERROR;
92bca22f 189) goto out;
92bca22f 210) fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
92bca22f 211) ret = TC_USAGE_ERROR;
92bca22f 212) goto out;
92bca22f 239) fprintf(stderr, "Invalid syntax. Usage: test-tool config"

Matheus Tavares	b77651be t/helper/test-config: return exit codes consistently
t/helper/test-config.c
b77651be 161) ret = TC_VALUE_NOT_FOUND;
b77651be 168) ret = TC_VALUE_NOT_FOUND;
b77651be 176) ret = TC_VALUE_NOT_FOUND;
b77651be 206) ret = TC_VALUE_NOT_FOUND;
b77651be 218) ret = TC_CONFIG_FILE_ERROR;
b77651be 219) goto out;
b77651be 233) ret = TC_VALUE_NOT_FOUND;
b77651be 241) ret = TC_USAGE_ERROR;

Taylor Blau	f7a39a87 upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
upload-pack.c
f7a39a87 1256) strbuf_release(&buf);
f7a39a87 1257) return config_error_nonbool(var);

Taylor Blau	850afedc list_objects_filter_options: introduce 'list_object_filter_config_name'
list-objects-filter-options.c
850afedc 23) break;
850afedc 36) break;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Aaron Lipman	0188ee9f bisect: introduce first-parent flag
builtin/bisect--helper.c
0188ee9f 457) first_parent_only = 1;

Jeff King	22f9b7f3 strvec: convert builtin/ callers away from argv_array name
builtin/am.c
22f9b7f3 1679) strvec_push(&cp.args, am_path(state, "patch"));

builtin/bisect--helper.c
22f9b7f3 176) strvec_clear(&argv);

builtin/bundle.c
22f9b7f3 89) strvec_push(&pack_opts, "--progress");
22f9b7f3 91) strvec_push(&pack_opts, "--all-progress");
22f9b7f3 93) strvec_push(&pack_opts, "--all-progress-implied");

builtin/clone.c
22f9b7f3 832) strvec_push(&args, "--progress");

builtin/describe.c
22f9b7f3 604) strvec_push(&args, "--always");

builtin/fetch.c
22f9b7f3 1529) strvec_push(argv, "-v");

builtin/gc.c
22f9b7f3 579) strvec_push(&repack, "-f");
22f9b7f3 581) strvec_pushf(&repack, "--depth=%d", aggressive_depth);
22f9b7f3 583) strvec_pushf(&repack, "--window=%d", aggressive_window);

builtin/pull.c
22f9b7f3 535) strvec_push(&args, opt_progress);
22f9b7f3 541) strvec_push(&args, opt_append);
22f9b7f3 543) strvec_push(&args, opt_upload_pack);
22f9b7f3 548) strvec_push(&args, opt_prune);
22f9b7f3 558) strvec_push(&args, "--recurse-submodules=on-demand");
22f9b7f3 564) strvec_push(&args, max_children);
22f9b7f3 568) strvec_push(&args, opt_keep);
22f9b7f3 572) strvec_push(&args, opt_unshallow);
22f9b7f3 574) strvec_push(&args, opt_update_shallow);
22f9b7f3 576) strvec_push(&args, opt_refmap);
22f9b7f3 578) strvec_push(&args, opt_ipv4);
22f9b7f3 580) strvec_push(&args, opt_ipv6);
22f9b7f3 582) strvec_push(&args, "--show-forced-updates");
22f9b7f3 584) strvec_push(&args, "--no-show-forced-updates");
22f9b7f3 673) strvec_push(&args, opt_progress);
22f9b7f3 677) strvec_push(&args, opt_diffstat);
22f9b7f3 683) strvec_push(&args, opt_squash);
22f9b7f3 685) strvec_push(&args, opt_commit);
22f9b7f3 687) strvec_push(&args, opt_edit);
22f9b7f3 689) strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
22f9b7f3 697) strvec_push(&args, opt_gpg_sign);
22f9b7f3 878) strvec_push(&args, "--rebase-merges");
22f9b7f3 884) strvec_push(&args, opt_diffstat);
22f9b7f3 888) strvec_push(&args, opt_gpg_sign);
22f9b7f3 890) strvec_push(&args, "--no-autostash");

builtin/rebase.c
22f9b7f3 826) strvec_push(&am.args, opts->gpg_sign_opt);
22f9b7f3 861) strvec_clear(&am.args);
22f9b7f3 872) strvec_split(&format_patch.args,
22f9b7f3 883) strvec_clear(&am.args);
22f9b7f3 905) strvec_clear(&am.args);
22f9b7f3 914) strvec_push(&am.args, "--rerere-autoupdate");
22f9b7f3 916) strvec_push(&am.args, "--no-rerere-autoupdate");
22f9b7f3 918) strvec_push(&am.args, opts->gpg_sign_opt);

builtin/receive-pack.c
22f9b7f3 686) strvec_pushf(&proc->env_array,
22f9b7f3 729) strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
22f9b7f3 1795) strvec_push(&child.args, "--show-resolving-progress");

builtin/remote.c
22f9b7f3 1466) strvec_push(&fetch_argv, "-v");

builtin/repack.c
22f9b7f3 158) strvec_pushf(&cmd->args, "--window=%s", args->window);
22f9b7f3 160) strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
22f9b7f3 162) strvec_pushf(&cmd->args, "--depth=%s", args->depth);
22f9b7f3 164) strvec_pushf(&cmd->args, "--threads=%s", args->threads);
22f9b7f3 166) strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
22f9b7f3 170) strvec_pushf(&cmd->args, "--no-reuse-object");

builtin/replace.c
22f9b7f3 234) strvec_push(&cmd.args, type_name(type));

builtin/submodule--helper.c
22f9b7f3 861) strvec_push(&cpr.args, "--quiet");
22f9b7f3 1030) strvec_push(&cpr.args, "--quiet");
22f9b7f3 1723) strvec_push(&child->args, "--progress");
22f9b7f3 1727) strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);

builtin/worktree.c
22f9b7f3 626) strvec_push(&cp.args, "--quiet");

Jeff King	ef8d7ac4 strvec: convert more callers away from argv_array name
column.c
ef8d7ac4 372) strvec_pushf(argv, "--width=%d", opts->width);
ef8d7ac4 374) strvec_pushf(argv, "--indent=%s", opts->indent);

compat/terminal.c
ef8d7ac4 276) strvec_pushl(&cp.args, "infocmp", "-L", "-1", NULL);

connect.c
ef8d7ac4 1236) strvec_push(args, "-6");

daemon.c
ef8d7ac4 490) static int upload_archive(const struct strvec *env)
ef8d7ac4 493) strvec_push(&cld.args, "upload-archive");
ef8d7ac4 803) strvec_clear(&env);
ef8d7ac4 924) strvec_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
ef8d7ac4 925) strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",

exec-cmd.c
ef8d7ac4 342) strvec_clear(&nargv);

Jeff King	d70a9eb6 strvec: rename struct fields
daemon.c
d70a9eb6 495) strvec_pushv(&cld.env_array, env->v);

run-command.c
d70a9eb6 852) execve(argv.v[0], (char *const *) argv.v,

t/helper/test-run-command.c
d70a9eb6 251) arg_offset = args.nr;
d70a9eb6 278) cp.argv = args.v;
d70a9eb6 284) const char *arg = args.v[j + arg_offset];
d70a9eb6 301) (int)j, args.v[j + arg_offset]);

Jeff King	fe4a0a28 argv-array: add pop function
strvec.c
fe4a0a28 63) return;

Jeff King	b992657e argv-array: add detach function
strvec.c
b992657e 103) return xcalloc(1, sizeof(const char *));

Jeff King	f6d8942b strvec: fix indentation in renamed calls
builtin/rebase.c
f6d8942b 873)      opts->git_format_patch_opt.buf);

daemon.c
f6d8942b 926)      ntohs(sin6_addr->sin6_port));

Jeff King	c972bf4c strvec: convert remaining callers away from argv_array name
midx.c
c972bf4c 1421) strvec_push(&cmd.args, "--delta-islands");

pager.c
c972bf4c 71) static void setup_pager_env(struct strvec *env)
c972bf4c 91) strvec_push(env, argv[i]);
c972bf4c 100) strvec_push(&pager_process->args, pager);
c972bf4c 129) strvec_push(&pager_process.env_array, "GIT_PAGER_IN_USE");

remote-curl.c
c972bf4c 1158) strvec_pushl(&args, "-v", "-v", NULL);
c972bf4c 1164) strvec_push(&args, "--update-shallow");
c972bf4c 1277) strvec_push(&child.args, "--dry-run");
c972bf4c 1305) strvec_push(&args, "--dry-run");
c972bf4c 1309) strvec_push(&args, "--signed=if-asked");
c972bf4c 1313) strvec_push(&args, "--quiet");

sequencer.c
c972bf4c 3666) strvec_push(&cmd.args, opts->gpg_sign);

submodule.c
c972bf4c 689) strvec_pushf(&cp.args, "--src-prefix=%s%s/",
c972bf4c 691) strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
c972bf4c 1786) strvec_push(&cp.args, "-uno");
c972bf4c 1791) strvec_push(&cp.args, "--ignored");

t/helper/test-run-command.c
c972bf4c 75) strvec_pushl(&cp->args, "sh", test, NULL);
c972bf4c 77) strvec_push(&cp->args, "--quiet");
c972bf4c 79) strvec_push(&cp->args, "-i");
c972bf4c 81) strvec_push(&cp->args, "-v");
c972bf4c 83) strvec_push(&cp->args, "-V");
c972bf4c 85) strvec_push(&cp->args, "-x");
c972bf4c 87) strvec_push(&cp->args, "--write-junit-xml");
c972bf4c 223) struct strvec args = STRVEC_INIT;
c972bf4c 244) strvec_clear(&args);
c972bf4c 246) strvec_pushl(&args, "sh", "-c",
c972bf4c 249) strvec_pushl(&args, "test-tool", "run-command",
c972bf4c 257) strvec_push(&args, argv[j]);
c972bf4c 271) strvec_push(&args, buf);
c972bf4c 304) strvec_clear(&args);
c972bf4c 314) strvec_clear(&args);
c972bf4c 341) strvec_pushl(&cp.args,

tmp-objdir.c
c972bf4c 102) strvec_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);

upload-pack.c
c972bf4c 301) strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);

Johannes Schindelin	c5aa6db6 argv_array: offer to split a string by whitespace
strvec.c
c5aa6db6 72) to_split++;

Junio C Hamano	a8ba57e4 Merge branch 'bc/sha-256-part-3' into jch
builtin/verify-pack.c
a8ba57e4 22) strvec_push(argv, "--verify-stat-only");

setup.c
a8ba57e4 497) return config_error_nonbool(var);

Michael Forney	ea3f7e59 revision: use repository from rev_info when parsing commits
revision.c
ea3f7e59 1062) if (repo_parse_commit(revs->repo, p) < 0)

Phillip Wood	b61f854f rebase -i: support --ignore-date
sequencer.c
b61f854f 893) return NULL;
b61f854f 1477) res = -1;
b61f854f 1478) goto out;

Phillip Wood	fce7916a rebase -i: support --committer-date-is-author-date
sequencer.c
fce7916a 1395) goto out;
fce7916a 1399) goto out;

René Scharfe	0aa49583 upload-pack: use buffered I/O to talk to rev-list
upload-pack.c
0aa49583 642) goto error;

René Scharfe	e2aa486c midx: use buffered I/O to talk to pack-objects
midx.c
e2aa486c 1453) error_errno(_("could not close stdin of pack-objects"));
e2aa486c 1454) result = 1;
e2aa486c 1455) finish_command(&cmd);
e2aa486c 1456) goto cleanup;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	cd85b447 remote-curl: make --force-with-lease work with non-ASCII ref names
remote-curl.c
cd85b447 128) return -1;

Jeff King	ec91ffca verify_repository_format(): complain about new extensions in v0 repo
setup.c
ec91ffca 472) return config_error_nonbool(var);
ec91ffca 508) return -1;
ec91ffca 517) return -1;

Junio C Hamano	6e6029a8 fmt-merge-msg: allow merge destination to be omitted again
fmt-merge-msg.c
6e6029a8 29) return config_error_nonbool(key);

SZEDER Gábor	17e6275f commit-graph: simplify chunk writes into loop
commit-graph.c
17e6275f 1766) return -1;


