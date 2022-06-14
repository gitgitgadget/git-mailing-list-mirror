Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D4C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiFNUTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357493AbiFNUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 16:18:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC76BA7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:18:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u2so7416869iln.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=aUHJMk+sYlFRWMlX56tsrdCpsdONH8yNurYq39d6jyA=;
        b=E+pKjFXX+To/r1MEUrIyFfKmpAyB7oB4nVRcBk/awDQti1vZZ7JIJu0WmVMOmeYrI5
         S0X6lbi4EjUhiSROVP3t9r4EMiHtjn92na7FZPnBuJ7hEkjLIdRTpbwHKPIptYtduCrL
         acQlsbAjgs6Hc5DN+Witz642YxfMC0ECwyyRMwN4yUZX9UcFDTi0FFusNI9ftxnAUdVa
         wXNTlCTrcju224p6zFDON09S/QnoykuKXSYGV87ukv8n57cPWCB9cCBy96s+A/wmAlwv
         bqN63BJ39Y2Y1Pu2t1Uulc8d92TVok9WiQH3kYFbFXzXjmOpYh1kDkZX6BPtnSANYCz8
         LkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=aUHJMk+sYlFRWMlX56tsrdCpsdONH8yNurYq39d6jyA=;
        b=f2Q5I7tU4Z2Dj06zLy4JeaaswZJ+yX85U2F5VqeMjm1vCeJHNW5quEdv8vIOND6tJq
         2ioX4FzyYAYqcdEudATFqOZlGISRGG7N9YlDZyoBDR9ko3lyM2S+mS1D0BgEGYJeMN8w
         mMAkeLVBxKKhgYoPCjKfDhgZi0gUmjRlIplSMIZ+lHFoN4d7To9d/hbRMAyAX38NFecj
         ZmmgAVWWMNh7jGdStb3h72qkdOSz8etTqZ+H6B79hhoZjJamq7QoLiWf26qe1rmoKxRT
         UKNcGp6MzeGmVOW/R7EbvjaV96SIK13nA3oLmL74Y7e5uzJ8KOAYRt8X4FkqC7Z7Jtrd
         OIyQ==
X-Gm-Message-State: AJIora+nGCBd+Nd7PkAJyQV0Y3nKXU8Uo1S+9OBbYUAyDzkO9psQf55T
        x8/8JV3BAIImSUNwucdL1xoX2oKzrXDIjnYQjbYBtcahpLS9WFrFIsJi0Eh+8WhaMV/0d78Jt6t
        QgzvdJW95L+gXwIGOhwH8aC3ZpDITIUzThOLRY4EPoUsrnUmuOwlogkRYlCo8rShWspwPpA==
X-Google-Smtp-Source: AGRyM1ulSuEkvdRHrANxHDjwverwfG9s+dS6yAWX99E5kSlJuOu5irLpG2RRv4fQhPrANzd/oSG7yw==
X-Received: by 2002:a05:6e02:1207:b0:2d3:b5fb:a802 with SMTP id a7-20020a056e02120700b002d3b5fba802mr3990970ilq.319.1655237897601;
        Tue, 14 Jun 2022 13:18:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id j130-20020a026388000000b003321afe0463sm5242126jac.103.2022.06.14.13.18.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:18:17 -0700 (PDT)
Message-ID: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
Date:   Tue, 14 Jun 2022 16:18:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Derrick Stolee <derrickstolee@github.com>
Subject: Git Test Coverage Report for v2.37.0-rc0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It's been a long time, but I decided it might be a good idea to revive my
git-test-coverage project and re-run the coverage checks for v2.37.0-rc0
versus v2.36.1.

For those who haven't seen this before: I run 'make coverage-test' in the
Git codebase and then compare the uncovered lines to the changes in each
file since some recent version. This gives us a view of the lines that were
modified but aren't covered by tests.

Keep in mind that this doesn't mean we should always add tests, but that
it is worth looking closely at the lines to be sure we did not add a
regression during this release cycle.

I'll reply to this email with my own assessment of these lines and whether
or not they are critical to cover or not.

Thanks,
-Stolee

---

Uncovered code in 'v2.37.0-rc0' not in 'v2.36.1'
--------------------------------------------------------

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason	5e480176 stash: always have the owner of "stash_info" free it
builtin/stash.c
5e480176 200) break;
5e480176 909) goto usage;
5e480176 942) usage:
5e480176 943) do_usage = 1;
5e480176 944) goto cleanup;

Ævar Arnfjörð Bjarmason	86f4e312 connect.c: refactor sending of agent & object-format
connect.c
86f4e312 490) reader->hash_algo = &hash_algos[GIT_HASH_SHA1];

Ævar Arnfjörð Bjarmason	2108fe4a revisions API users: add straightforward release_revisions()
merge-recursive.c
2108fe4a 1163) release_revisions(&revs);

Ævar Arnfjörð Bjarmason	6d40f0ad cache-tree.c: use bug() and BUG_if_bug()
cache-tree.c
6d40f0ad 725) bug("there are unmerged index entries:");
6d40f0ad 729) bug("%d %.*s", ce_stage(ce),

Ævar Arnfjörð Bjarmason	53ca5694 parse-options.c: use new bug() API for optbug()
parse-options.c
53ca5694 17) static void optbug(const struct option *opt, const char *reason)
53ca5694 19) if (opt->long_name && opt->short_name)
53ca5694 20) bug("switch '%c' (--%s) %s", opt->short_name,
53ca5694 22) else if (opt->long_name)
53ca5694 23) bug("option '%s' %s", opt->long_name, reason);
53ca5694 25) bug("switch '%c' %s", opt->short_name, reason);
53ca5694 450) optbug(opts, "uses incompatible flags "
53ca5694 454) optbug(opts, "invalid short name");
53ca5694 456) optbug(opts, "short name already used");
53ca5694 463) optbug(opts, "uses feature "
53ca5694 473) optbug(opts, "should not accept an argument");
53ca5694 497) optbug(opts, "multi-word argh should use dash to separate words");

Ævar Arnfjörð Bjarmason	5b2f5d92 parse-options.c: use optbug() instead of BUG() "opts" check
parse-options.c
5b2f5d92 477) optbug(opts, "OPTION_CALLBACK needs one callback");
5b2f5d92 479) optbug(opts, "OPTION_CALLBACK can't have two callbacks");
5b2f5d92 483) optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
5b2f5d92 485) optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
5b2f5d92 488) optbug(opts, "OPT_ALIAS() should not remain at this point. "
5b2f5d92 491) break;

Ævar Arnfjörð Bjarmason	338959da remote.c: remove braces from one-statement "for"-loops
remote.c
338959da 149) for (i = 0; i < remote->url_nr; i++)
338959da 153) for (i = 0; i < remote->pushurl_nr; i++)

Ævar Arnfjörð Bjarmason	323822c7 remote.c: don't dereference NULL in freeing loop
remote.c
323822c7 151) FREE_AND_NULL(remote->url);

Ævar Arnfjörð Bjarmason	29fda24d run-command API: rename "env_array" to "env"
builtin/receive-pack.c
29fda24d 783) strvec_pushf(&proc->env,
29fda24d 825) strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");

daemon.c
29fda24d 497) strvec_pushv(&cld.env, env->v);
29fda24d 907) strvec_pushf(&cld.env, "REMOTE_ADDR=%s", buf);
29fda24d 908) strvec_pushf(&cld.env, "REMOTE_PORT=%d",
29fda24d 915) strvec_pushf(&cld.env, "REMOTE_ADDR=[%s]", buf);
29fda24d 916) strvec_pushf(&cld.env, "REMOTE_PORT=%d",

http-backend.c
29fda24d 479) strvec_pushf(&cld.env, "GIT_COMMITTER_NAME=%s", user);
29fda24d 481) strvec_pushf(&cld.env,

pager.c
29fda24d 102) setup_pager_env(&pager_process->env);
29fda24d 132) strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");

Ævar Arnfjörð Bjarmason	07b1d8f1 receive-pack: use bug() and BUG_if_bug()
builtin/receive-pack.c
07b1d8f1 1820) bug("connectivity check has not been run on ref %s",

Ævar Arnfjörð Bjarmason	ae1b383d revisions API: have release_revisions() release "topo_walk_info"
revision.c
ae1b383d 3494) static void reset_topo_walk(struct rev_info *revs)
ae1b383d 3496) release_revisions_topo_walk_info(revs->topo_walk_info);
ae1b383d 3497) revs->topo_walk_info = NULL;

Ævar Arnfjörð Bjarmason	fd3aaf53 run-command: add an "ungroup" option to run_process_parallel()
run-command.c
fd3aaf53 1645) code = pp->start_failure(pp->ungroup ? NULL :
fd3aaf53 1646)  &pp->children[i].err,
fd3aaf53 1649) if (!pp->ungroup) {
fd3aaf53 1650) strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
fd3aaf53 1651) strbuf_reset(&pp->children[i].err);

Ævar Arnfjörð Bjarmason	1f6cf450 fetch-pack: move --keep=* option filling to a function
fetch-pack.c
1f6cf450 855) xsnprintf(hostname, sizeof(hostname), "localhost");

Ævar Arnfjörð Bjarmason	0139c58a revisions API users: add "goto cleanup" for release_revisions()
builtin/diff-files.c
0139c58a 80) result = -1;
0139c58a 81) goto cleanup;

builtin/submodule--helper.c
0139c58a 1144) ret = -1;
0139c58a 1145) goto cleanup;
0139c58a 1149) ret = -1;
0139c58a 1150) goto cleanup;

sequencer.c
0139c58a 5382) goto cleanup;
0139c58a 5387) goto cleanup;

t/helper/test-fast-rebase.c
0139c58a 143) goto cleanup;
0139c58a 150) goto cleanup;

Ævar Arnfjörð Bjarmason	f196c1e9 revisions API users: use release_revisions() needing REV_INFO_INIT
bisect.c
f196c1e9 1063) res = BISECT_FAILED;
f196c1e9 1064) goto cleanup;

Ævar Arnfjörð Bjarmason	0cc05b04 usage.c: add a non-fatal bug() function to go with BUG()
t/helper/test-trace2.c
0cc05b04 214) return 0;

Ævar Arnfjörð Bjarmason	b78ce337 revisions API users: use release_revisions() in http-push.c
http-push.c
b78ce337 1944) release_revisions(&revs);

Chris Down	0cf1defa bisect: output state before we are ready to compute bisection
builtin/bisect--helper.c
0cf1defa 427) return;

Christian Couder	511cfd3b http: add custom hostname to IP address resolutions
http.c
511cfd3b 398) if (!strcmp("http.curloptresolve", var)) {
511cfd3b 399) if (!value) {
511cfd3b 400) return config_error_nonbool(var);
511cfd3b 401) } else if (!*value) {
511cfd3b 402) curl_slist_free_all(host_resolutions);
511cfd3b 403) host_resolutions = NULL;
511cfd3b 405) host_resolutions = curl_slist_append(host_resolutions, value);
511cfd3b 407) return 0;
511cfd3b 1148) curl_slist_free_all(host_resolutions);
511cfd3b 1149) host_resolutions = NULL;

Derrick Stolee	b56166ca multi-pack-index: use --object-dir real path
builtin/multi-pack-index.c
b56166ca 61) opts.object_dir = xstrdup(get_object_directory());
b56166ca 277) goto usage;

Derrick Stolee	ac8acb4f sparse-index: complete partial expansion
sparse-index.c
ac8acb4f 327) pl = NULL;

Derrick Stolee	080ab56a cache-tree: implement cache_tree_find_path()
cache-tree.c
080ab56a 104) struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
080ab56a 108) struct cache_tree_sub it_sub = {
080ab56a 111) struct cache_tree_sub *down = &it_sub;
080ab56a 113) while (down) {
080ab56a 114) slash = strchrnul(path, '/');
080ab56a 115) namelen = slash - path;
080ab56a 116) down->cache_tree->entry_count = -1;
080ab56a 117) if (!*slash) {
080ab56a 119) pos = cache_tree_subtree_pos(down->cache_tree, path, namelen);
080ab56a 120) if (0 <= pos)
080ab56a 121) return down->cache_tree->down[pos]->cache_tree;
080ab56a 122) return NULL;
080ab56a 124) down = find_subtree(it, path, namelen, 0);
080ab56a 125) path = slash + 1;
080ab56a 128) return NULL;

Derrick Stolee	c1d024b8 http: make http_get_file() external
http.c
c1d024b8 1992) int http_get_file(const char *url, const char *filename,

Derrick Stolee	834e3520 remote: allow relative_url() to return an absolute url
remote.c
834e3520 2819) return xstrdup(url);

Frantisek Hrbata	35919bf1 transport: unify return values and exit point from transport_push()
transport.c
35919bf1 1294) goto done;
35919bf1 1297) goto done;

Garrit Franke	6b52f48b cli: add -v and -h shorthands
git.c
6b52f48b 900) argv[0] = "help";

Jeff Hostetler	9915e08f t/helper/hexdump: add helper to print hexdump of stdin
t/helper/test-hexdump.c
9915e08f 7) int cmd__hexdump(int argc, const char **argv)
9915e08f 11) int have_data = 0;
9915e08f 14) len = xread(0, buf, sizeof(buf));
9915e08f 15) if (len < 0)
9915e08f 16) die_errno("failure reading stdin");
9915e08f 17) if (!len)
9915e08f 18) break;
9915e08f 20) have_data = 1;
9915e08f 22) for (i = 0; i < len; i++)
9915e08f 23) printf("%02x ", (unsigned char)buf[i]);
9915e08f 26) if (have_data)
9915e08f 27) putchar('\n');
9915e08f 29) return 0;

Jeff Hostetler	f954c7b8 fsmonitor: never set CE_FSMONITOR_VALID on submodules
fsmonitor.c
f954c7b8 584) continue;

Jeff Hostetler	95a4e78a fsmonitor: optimize processing of directory events
fsmonitor.c
95a4e78a 207) if (pos < 0)
95a4e78a 208) pos = -pos - 1;
95a4e78a 211) for (i = pos; i < istate->cache_nr; i++) {
95a4e78a 212) if (!starts_with(istate->cache[i]->name, name))
95a4e78a 213) break;
95a4e78a 214) istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
95a4e78a 245) if ((unsigned char)istate->cache[i]->name[len] > '/')
95a4e78a 246) break;
95a4e78a 247) if (istate->cache[i]->name[len] == '/')
95a4e78a 248) istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;

Jeff Hostetler	1e7be10d fsmonitor-settings: remote repos on macOS are incompatible
fsmonitor-settings.c
1e7be10d 211) case FSMONITOR_REASON_ERROR:
1e7be10d 212) strbuf_addf(&msg,
1e7be10d 214)     r->worktree);
1e7be10d 215) goto done;
1e7be10d 217) case FSMONITOR_REASON_REMOTE:
1e7be10d 218) strbuf_addf(&msg,
1e7be10d 220)     r->worktree);
1e7be10d 221) goto done;

Jeff Hostetler	5c58fbd2 fsmonitor-settings: VFS for Git virtual repos are incompatible
fsmonitor-settings.c
5c58fbd2 223) case FSMONITOR_REASON_VFS4GIT:
5c58fbd2 224) strbuf_addf(&msg,
5c58fbd2 226)     r->worktree);
5c58fbd2 227) goto done;

Jeff Hostetler	62a62a28 fsmonitor-settings: bare repos are incompatible with FSMonitor
fsmonitor-settings.c
62a62a28 108) lookup_fsmonitor_settings(r);
62a62a28 128) if (!r->settings.fsmonitor)
62a62a28 129) r->settings.fsmonitor = alloc_settings();
62a62a28 132) r->settings.fsmonitor->reason = reason;
62a62a28 176) r = the_repository;
62a62a28 188) r = the_repository;
62a62a28 190) lookup_fsmonitor_settings(r);
62a62a28 201) case FSMONITOR_REASON_UNTESTED:
62a62a28 203) goto done;

Jeff Hostetler	ddc5dacf fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
fsmonitor-settings.c
ddc5dacf 229) case FSMONITOR_REASON_NOSOCKETS:
ddc5dacf 230) strbuf_addf(&msg,
ddc5dacf 232)     r->worktree);
ddc5dacf 233) goto done;

Johannes Schindelin	de1f68a9 archive --add-virtual-file: allow paths containing colons
archive.c
de1f68a9 557) char *save = path;
de1f68a9 558) path = prefix_filename(args->prefix, path);
de1f68a9 559) free(save);

Johannes Schindelin	237a1d13 archive: optionally add "virtual" files
archive.c
237a1d13 344) err = error_errno(_("cannot read '%s'"), path);

Jonathan Tan	7709acf7 fetch-pack: make unexpected peek result non-fatal
fetch-pack.c
7709acf7 1396) if (reader->line)

Josh Steadmon	ce3986bb run-command: don't spam trace2_child_exit()
run-command.c
ce3986bb 987) if (ret != -1)
ce3986bb 988) trace2_child_exit(cmd, ret);

Junio C Hamano	afe8a907 tree-wide: apply equals-null.cocci
builtin/mailsplit.c
afe8a907 123) if (!(dir = opendir(name))) {

http-fetch.c
afe8a907 58) if (!preq)

http-push.c
afe8a907 256) if (!obj_req) {
afe8a907 321) if (!preq) {
afe8a907 523) if (request->headers)
afe8a907 786) if (!c)
afe8a907 814) if (!c)
afe8a907 1896) if (!ref_lock) {

http-walker.c
afe8a907 62) if (!req) {
afe8a907 109) if (obj_req->repo->next) {
afe8a907 228) if (slot->finished)
afe8a907 233) if (slot->finished)
afe8a907 446) if (!preq)
afe8a907 492) if (!obj_req)
afe8a907 496) if (obj_req->req)

http.c
afe8a907 874) if (ssl_cainfo)
afe8a907 877) if (http_proxy_ssl_ca_info)
afe8a907 1126) if (slot->curl) {
afe8a907 1167) if (cert_auth.password) {
afe8a907 1173) if (proxy_cert_auth.password) {
afe8a907 2147) if (preq->packfile) {
afe8a907 2438) if (!freq->slot)
afe8a907 2495) if (freq->slot) {

merge-recursive.c
afe8a907 2120) if (!collision_ent)

Kevin Locke	c37c6dc6 setup: don't die if realpath(3) fails on getcwd(3)
setup.c
c37c6dc6 463) trace2_data_string("setup", the_repository,
c37c6dc6 465) trace2_data_string("setup", the_repository,
c37c6dc6 467) free((char*)tmp_original_cwd);
c37c6dc6 468) tmp_original_cwd = NULL;
c37c6dc6 469) return;

Kleber Tarcísio	c0befa0c commit-graph: close file before returning NULL
commit-graph.c
c0befa0c 518) fclose(fp);
c0befa0c 519) return NULL;

Neeraj Singh	23a3a303 update-index: use the bulk-checkin infrastructure
builtin/update-index.c
23a3a303 68) flush_odb_transaction();

René Scharfe	2c2db194 tempfile: add mks_tempfile_dt()
tempfile.c
2c2db194 67) rmdir(tempfile->filename.buf);
2c2db194 227) errno = EINVAL;
2c2db194 228) return NULL;
2c2db194 238) int orig_errno = errno;
2c2db194 239) strbuf_release(&sb);
2c2db194 240) errno = orig_errno;
2c2db194 241) return NULL;
2c2db194 247) int orig_errno = errno;
2c2db194 248) strbuf_setlen(&sb, directorylen);
2c2db194 249) rmdir(sb.buf);
2c2db194 250) strbuf_release(&sb);
2c2db194 251) errno = orig_errno;
2c2db194 252) return NULL;

Tao Klerks	e6a65355 untracked-cache: support '--untracked-files=all' if configured
dir.c
e6a65355 2789) new_untracked_cache(istate, -1);

Taylor Blau	2bd44278 t/helper: add 'pack-mtimes' test-tool
t/helper/test-pack-mtimes.c
2bd44278 35) usage(pack_mtimes_usage);

Taylor Blau	5b92477f builtin/gc.c: conditionally avoid pruning objects via loose
builtin/gc.c
5b92477f 337) strvec_push(&repack, "--cruft");
5b92477f 338) if (prune_expire)
5b92477f 339) strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);

Taylor Blau	4090511e builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
builtin/pack-objects.c
4090511e 1368) return -1;

Taylor Blau	5045759d builtin/pack-objects.c: ensure included `--stdin-packs` exist
builtin/pack-objects.c
5045759d 3238)     oid_to_hex(oid), p->pack_name);

Taylor Blau	a7d49383 builtin/pack-objects.c: --cruft with expiration
builtin/pack-objects.c
a7d49383 3540) progress_state = start_progress(_("Enumerating cruft objects"), 0);
a7d49383 3559) progress_state = start_progress(_("Traversing cruft objects"), 0);

Taylor Blau	4571324b builtin/repack.c: allow configuring cruft pack generation
builtin/repack.c
4571324b 86) return git_config_string(&cruft_po_args->window_memory, var, value);
4571324b 88) return git_config_string(&cruft_po_args->depth, var, value);
4571324b 90) return git_config_string(&cruft_po_args->threads, var, value);

Taylor Blau	f9825d1c builtin/repack.c: support generating a cruft pack
builtin/repack.c
f9825d1c 680) strvec_pushf(&cmd.args, "--cruft-expiration=%s",
f9825d1c 691) return ret;
f9825d1c 708) fprintf(in, "%s.pack\n", item->string);
f9825d1c 992) return ret;

Taylor Blau	2fb90409 reachable: add options to add_unseen_recent_objects_to_traversal
reachable.c
2fb90409 120) return 0;
2fb90409 131) return 0;
2fb90409 162) return 0;

Taylor Blau	5dfaf49a pack-mtimes: support writing pack .mtimes files
pack-objects.c
5dfaf49a 175) REALLOC_ARRAY(pdata->cruft_mtime, pdata->nr_alloc);

pack-write.c
5dfaf49a 330) unlink(mtimes_name);
5dfaf49a 331) fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);

Taylor Blau	94cd775a pack-mtimes: support reading .mtimes files
pack-mtimes.c
94cd775a 35) ret = -1;
94cd775a 36) goto cleanup;
94cd775a 39) ret = error_errno(_("failed to read %s"), mtimes_file);
94cd775a 40) goto cleanup;
94cd775a 47) goto cleanup;
94cd775a 58) goto cleanup;
94cd775a 64) goto cleanup;
94cd775a 70) goto cleanup;
94cd775a 80) goto cleanup;
94cd775a 85) if (data)
94cd775a 86) munmap(data, mtimes_size);
94cd775a 102) return ret; /* not a cruft pack */
94cd775a 108) goto cleanup;

packfile.c
94cd775a 342) munmap((void *)p->mtimes_map, p->mtimes_size);
94cd775a 343) p->mtimes_map = NULL;

Taylor Blau	44f9fd64 pack-bitmap.c: check preferred pack validity when opening MIDX bitmap
pack-bitmap.c
44f9fd64 362)     bitmap_git->midx->pack_names[i]);
44f9fd64 368) preferred->pack_name);
44f9fd64 369) goto cleanup;

Taylor Blau	d9fef9d9 chunk-format.h: extract oid_version()
chunk-format.c
d9fef9d9 192) default:

Taylor Blau	b7573536 builtin/pack-objects.c: --cruft without expiration
builtin/pack-objects.c
b7573536 3514) progress_state = start_progress(_("Enumerating cruft objects"), 0);
b7573536 3577) continue;
b7573536 3802) if (errno == ENOENT)
b7573536 3803) return 0;
b7573536 3804) return error_errno("unable to stat %s", oid_to_hex(oid));
b7573536 4132) cruft = 0;
b7573536 4133) cruft_expiration = 0;



