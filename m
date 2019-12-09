Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3777B20692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjuqx1nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIPgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:36:17 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:39221 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIPgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:36:17 -0500
Received: by mail-yw1-f54.google.com with SMTP id h126so5932450ywc.6
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CDpcsfAcletFMDfO+FhPWOWEgSpxPwpB0pHYXJBn+1k=;
        b=Rjuqx1nwHXHwd8Hl7SFgGWTpUhKrgLMFE7NXuw0NgReorcmMGDe4j+10VNzVgvy0g3
         yEZiM4WPFctD1YGr3RBPZbLIkcosb2arv226NrExi/b36hue5vYmF+qOdOOCbQDG1046
         0e5eK2J5YBGEVECd6l1GaPQ1THBwfs3SmQbA1zXi/Nx+3K1kIH1EX4czGJ55xFZvLS62
         kf8jmVPgGUtP5KPCplG0wRklfKYwM9mp3eXxMYmkKeWh3dChGCYq1GFS27bvfZJiojoT
         6jxZQ0Mzza6KAJU1zvusN5+wTcUsLj464B2pFd1q2kubkrbb5gbmmvzwSo+G3FrIge20
         /NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CDpcsfAcletFMDfO+FhPWOWEgSpxPwpB0pHYXJBn+1k=;
        b=X/9MeNINJnCaRskRMVZYw9B/ShiFiFXqgGXedpiuVsYcQLpfU8q+ydJquDs+7Z50jg
         VOdjccWwdj/tSumbhPFT7He3GYVrQgR8fSZ2yEIh9BWTU7+cnON07eG7RFia8eKS8HoL
         acpr+NzBhtWT4vo6EoPUbrf+a4IdccDv2MiBVOENm5KtEGrE3tWHs7fgrIF/LqLbkxV9
         CjRmD3tNdpE6KDc0ZKQnWsSmQVBek1V2pDBjkUFjEOy7KPlPSe0loIWDOOW6dXE1vqW+
         s415K/Y/D6yksWAh0FNs2L69HurL6nej9lVP7wgQVZoHFzSw7on5Rrwh3vVpk2KwJp6z
         aPuw==
X-Gm-Message-State: APjAAAUFP/ML9Lvh4sJPWTf8tbIBUd4IdpwSmn5tCNA+AfScb2wVLtj8
        EG8tBbluhUJ1zMTSd+9/FM4Dbz0lj7A=
X-Google-Smtp-Source: APXvYqxYqbfzHJ6R27wrW/C2umFnGKKhrdqLe/i17qsQ3pZky46cukePfwb4PpWdk7eedoFh+hpm+Q==
X-Received: by 2002:a81:29c1:: with SMTP id p184mr20298113ywp.13.1575905773418;
        Mon, 09 Dec 2019 07:36:13 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i17sm51515ywg.66.2019.12.09.07.36.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:36:12 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Mon. Dec 9)
Message-ID: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
Date:   Mon, 9 Dec 2019 10:36:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-09.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-09-commits.txt

---

pu	6111d532a73feb1d5c4a6b07265ca282f4807b39
jch	eba02921db5f965dd3f07ce03b80b85082414d1c
next	e0522318ac56aeb88f14e72ba2db25912e9972de
master	083378cc35c4dbcc607e4cdd24a5fca440163d17
master@{1}	d9f6f3b6195a0ca35642561e530798ad1469bd41


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	d89f09c8 clone: add --sparse mode
builtin/clone.c
d89f09c8 753) result = 1;
d89f09c8 1136) return 1;

Derrick Stolee	e091228e sparse-checkout: update working directory in-process
builtin/sparse-checkout.c
e091228e 85) return 0;

Derrick Stolee	bab3c359 sparse-checkout: create 'init' subcommand
builtin/sparse-checkout.c
bab3c359 221) return 1;
bab3c359 275) return 1;

Derrick Stolee	af09ce24 sparse-checkout: init and set in cone mode
builtin/sparse-checkout.c
af09ce24 346) return;

Derrick Stolee	96cc8ab5 sparse-checkout: use hashmaps for cone patterns
dir.c
96cc8ab5 654) pl->use_cone_patterns = 0;
96cc8ab5 656) goto clear_hashmaps;
96cc8ab5 678) hashmap_add(&pl->parent_hashmap, &translated->ent);
96cc8ab5 679) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
96cc8ab5 680) free(data);
96cc8ab5 681) return;
96cc8ab5 687) goto clear_hashmaps;
96cc8ab5 703) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
96cc8ab5 704) free(data);
96cc8ab5 705) free(translated);
96cc8ab5 1264) return MATCHED;

Johannes Schindelin	b4bbbbd5 apply --allow-overlap: fix a corner case
apply.c
b4bbbbd5 2672) match_beginning = 0;

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1745) if (advice_unknown_index_extension) {

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
remote-curl.c
6da1f1a9 354) return 0;

Matheus Tavares	beebb9d2 object-store: allow threaded access to object reading
packfile.c
beebb9d2 1465) return;

sha1-file.c
beebb9d2 1431) return;
beebb9d2 1440) return;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1583)     return -1;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	0d50cf5e sequencer: move check_todo_list_from_file() to rebase-interactive.c
rebase-interactive.c
0d50cf5e 210) goto out;
0d50cf5e 215) goto out;
0d50cf5e 224) fprintf(stderr, _(edit_todo_list_advice));

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 329) FREE_AND_NULL(cmd_line_value.regexp);

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 330) return CONFIG_INVALID_PATTERN;
3bcdd852 375) goto free_strings;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	393adf7a sequencer: directly call pick_commits() from complete_action()
sequencer.c
393adf7a 5272) goto cleanup;

Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
add-interactive.c
5e82b9e4 629) return -1;
5e82b9e4 632) putchar('\n');
5e82b9e4 634) return 0;

Derrick Stolee	44a4693b progress: create GIT_PROGRESS_DELAY
progress.c
44a4693b 308) return start_progress_delay(title, total, get_default_delay(), 1);

Hans Jerry Illikainen	72b006f4 gpg-interface: prefer check_signature() for GPG verification
builtin/fmt-merge-msg.c
72b006f4 511) strbuf_addstr(&sig, "gpg verification failed.\n");

gpg-interface.c
72b006f4 223) return error_errno(_("could not create temporary file"));
72b006f4 226) error_errno(_("failed writing detached signature to '%s'"),
72b006f4 228) delete_tempfile(&temp);
72b006f4 229) return -1;
72b006f4 244) gpg_status = &buf;

log-tree.c
72b006f4 461) show_sig_lines(opt, status, "No signature\n");
72b006f4 535) } else if (verify_message.len <= gpg_message_offset)

Jeff King	7b143c16 pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
7b143c16 903) return 0;

Jeff King	7cb9754e pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
7cb9754e 2834) allow_pack_reuse = git_config_bool(k, v);
7cb9754e 2835) return 0;

Jeff King	4f0bd8b9 pack-objects: improve partial packfile reuse
builtin/pack-objects.c
4f0bd8b9 1124) return 1;
4f0bd8b9 2681) (reuse_packfile_bitmap &&
4f0bd8b9 2682)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

pack-bitmap.c
4f0bd8b9 808) return;
4f0bd8b9 811) return;
4f0bd8b9 823) return;
4f0bd8b9 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Johannes Schindelin	d7633578 built-in add -i: re-implement the `diff` command
add-interactive.c
d7633578 934) static int run_diff(struct add_i_state *s, const struct pathspec *ps,
d7633578 938) int res = 0;
d7633578 942) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
d7633578 944) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
d7633578 945) return -1;
d7633578 947) if (!files->items.nr) {
d7633578 948) putchar('\n');
d7633578 949) return 0;
d7633578 952) opts->prompt = N_("Review diff");
d7633578 953) opts->flags = IMMEDIATE;
d7633578 954) count = list_and_choose(s, files, opts);
d7633578 955) opts->flags = 0;
d7633578 956) if (count >= 0) {
d7633578 957) struct argv_array args = ARGV_ARRAY_INIT;
d7633578 959) argv_array_pushl(&args, "git", "diff", "-p", "--cached",
d7633578 961)     s->r->hash_algo->empty_tree),
d7633578 963) for (i = 0; i < files->items.nr; i++)
d7633578 964) if (files->selected[i])
d7633578 965) argv_array_push(&args,
d7633578 966) files->items.items[i].string);
d7633578 967) res = run_command_v_opt(args.argv, 0);
d7633578 968) argv_array_clear(&args);
d7633578 971) putchar('\n');
d7633578 972) return res;

Johannes Schindelin	c54ef5e4 built-in add -i: re-implement `revert` in C
add-interactive.c
c54ef5e4 686) static void revert_from_diff(struct diff_queue_struct *q,
c54ef5e4 689) int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
c54ef5e4 691) for (i = 0; i < q->nr; i++) {
c54ef5e4 692) struct diff_filespec *one = q->queue[i]->one;
c54ef5e4 695) if (!(one->mode && !is_null_oid(&one->oid))) {
c54ef5e4 696) remove_file_from_index(opt->repo->index, one->path);
c54ef5e4 697) printf(_("note: %s is untracked now.\n"), one->path);
c54ef5e4 699) ce = make_cache_entry(opt->repo->index, one->mode,
c54ef5e4 700)       &one->oid, one->path, 0, 0);
c54ef5e4 701) if (!ce)
c54ef5e4 704) add_index_entry(opt->repo->index, ce, add_flags);
c54ef5e4 707) }
c54ef5e4 709) static int run_revert(struct add_i_state *s, const struct pathspec *ps,
c54ef5e4 713) int res = 0, fd;
c54ef5e4 717) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
c54ef5e4 722) struct diff_options diffopt = { NULL };
c54ef5e4 725) return -1;
c54ef5e4 727) if (!files->items.nr) {
c54ef5e4 728) putchar('\n');
c54ef5e4 729) return 0;
c54ef5e4 732) opts->prompt = N_("Revert");
c54ef5e4 733) count = list_and_choose(s, files, opts);
c54ef5e4 734) if (count <= 0)
c54ef5e4 735) goto finish_revert;
c54ef5e4 737) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
c54ef5e4 738) if (fd < 0) {
c54ef5e4 739) res = -1;
c54ef5e4 740) goto finish_revert;
c54ef5e4 743) if (is_initial)
c54ef5e4 744) oidcpy(&oid, s->r->hash_algo->empty_tree);
c54ef5e4 746) tree = parse_tree_indirect(&oid);
c54ef5e4 747) if (!tree) {
c54ef5e4 749) goto finish_revert;
c54ef5e4 751) oidcpy(&oid, &tree->object.oid);
c54ef5e4 754) ALLOC_ARRAY(paths, count + 1);
c54ef5e4 755) for (i = j = 0; i < files->items.nr; i++)
c54ef5e4 756) if (files->selected[i])
c54ef5e4 757) paths[j++] = files->items.items[i].string;
c54ef5e4 758) paths[j] = NULL;
c54ef5e4 760) parse_pathspec(&diffopt.pathspec, 0,
c54ef5e4 764) diffopt.output_format = DIFF_FORMAT_CALLBACK;
c54ef5e4 765) diffopt.format_callback = revert_from_diff;
c54ef5e4 766) diffopt.flags.override_submodule_config = 1;
c54ef5e4 767) diffopt.repo = s->r;
c54ef5e4 769) if (do_diff_cache(&oid, &diffopt))
c54ef5e4 770) res = -1;
c54ef5e4 772) diffcore_std(&diffopt);
c54ef5e4 773) diff_flush(&diffopt);
c54ef5e4 775) free(paths);
c54ef5e4 776) clear_pathspec(&diffopt.pathspec);
c54ef5e4 778) if (!res && write_locked_index(s->r->index, &index_lock,
c54ef5e4 780) res = -1;
c54ef5e4 782) res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
c54ef5e4 785) if (!res)
c54ef5e4 786) printf(Q_("reverted %d path\n",
c54ef5e4 791) return res;

Johannes Schindelin	ab1e1ccc built-in add -i: re-implement `add-untracked` in C
add-interactive.c
ab1e1ccc 609) if (d->only_names) {
ab1e1ccc 610) printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
ab1e1ccc 612) return;
ab1e1ccc 794) static int get_untracked_files(struct repository *r,
ab1e1ccc 798) struct dir_struct dir = { 0 };
ab1e1ccc 800) struct strbuf buf = STRBUF_INIT;
ab1e1ccc 802) if (repo_read_index(r) < 0)
ab1e1ccc 805) prefix_item_list_clear(files);
ab1e1ccc 806) setup_standard_excludes(&dir);
ab1e1ccc 807) add_pattern_list(&dir, EXC_CMDL, "--exclude option");
ab1e1ccc 808) fill_directory(&dir, r->index, ps);
ab1e1ccc 810) for (i = 0; i < dir.nr; i++) {
ab1e1ccc 811) struct dir_entry *ent = dir.entries[i];
ab1e1ccc 813) if (index_name_is_other(r->index, ent->name, ent->len)) {
ab1e1ccc 814) strbuf_reset(&buf);
ab1e1ccc 815) strbuf_add(&buf, ent->name, ent->len);
ab1e1ccc 816) add_file_item(&files->items, buf.buf);
ab1e1ccc 820) strbuf_release(&buf);
ab1e1ccc 824) static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
ab1e1ccc 828) struct print_file_item_data *d = opts->list_opts.print_item_data;
ab1e1ccc 829) int res = 0, fd;
ab1e1ccc 833) if (get_untracked_files(s->r, files, ps) < 0)
ab1e1ccc 834) return -1;
ab1e1ccc 836) if (!files->items.nr) {
ab1e1ccc 837) printf(_("No untracked files.\n"));
ab1e1ccc 838) goto finish_add_untracked;
ab1e1ccc 841) opts->prompt = N_("Add untracked");
ab1e1ccc 842) d->only_names = 1;
ab1e1ccc 843) count = list_and_choose(s, files, opts);
ab1e1ccc 844) d->only_names = 0;
ab1e1ccc 845) if (count <= 0)
ab1e1ccc 846) goto finish_add_untracked;
ab1e1ccc 848) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
ab1e1ccc 849) if (fd < 0) {
ab1e1ccc 850) res = -1;
ab1e1ccc 851) goto finish_add_untracked;
ab1e1ccc 854) for (i = 0; i < files->items.nr; i++) {
ab1e1ccc 855) const char *name = files->items.items[i].string;
ab1e1ccc 856) if (files->selected[i] &&
ab1e1ccc 857)     add_file_to_index(s->r->index, name, 0) < 0) {
ab1e1ccc 859) break;
ab1e1ccc 863) if (!res &&
ab1e1ccc 864)     write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
ab1e1ccc 867) if (!res)
ab1e1ccc 868) printf(Q_("added %d path\n",
ab1e1ccc 872) putchar('\n');
ab1e1ccc 873) return res;

Johannes Schindelin	0c3944a6 add-interactive: make sure to release `rev.prune_data`
add-interactive.c
0c3944a6 538) if (ps)
0c3944a6 539) clear_pathspec(&rev.prune_data);

Johannes Schindelin	a8c45be9 built-in add -i: implement the `update` command
add-interactive.c
a8c45be9 504) prefix_item_list_clear(files);
a8c45be9 505) s.files = &files->items;
a8c45be9 548) string_list_sort(&files->items);
a8c45be9 593) const char *highlighted = NULL;
a8c45be9 600) if (c->prefix_length > 0 &&
a8c45be9 601)     is_valid_prefix(item->string, c->prefix_length)) {
a8c45be9 602) strbuf_reset(&d->name);
a8c45be9 603) strbuf_addf(&d->name, "%s%.*s%s%s", d->color,
a8c45be9 604)     (int)c->prefix_length, item->string, d->reset,
a8c45be9 605)     item->string + c->prefix_length);
a8c45be9 606) highlighted = d->name.buf;
a8c45be9 618) strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
a8c45be9 631) list(s, &files->items, NULL, &opts->list_opts);
a8c45be9 637) static int run_update(struct add_i_state *s, const struct pathspec *ps,
a8c45be9 641) int res = 0, fd;
a8c45be9 648) if (!files->items.nr) {
a8c45be9 649) putchar('\n');
a8c45be9 650) return 0;
a8c45be9 653) opts->prompt = N_("Update");
a8c45be9 654) count = list_and_choose(s, files, opts);
a8c45be9 655) if (count <= 0) {
a8c45be9 656) putchar('\n');
a8c45be9 657) return 0;
a8c45be9 660) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
a8c45be9 661) if (fd < 0) {
a8c45be9 662) putchar('\n');
a8c45be9 663) return -1;
a8c45be9 666) for (i = 0; i < files->items.nr; i++) {
a8c45be9 667) const char *name = files->items.items[i].string;
a8c45be9 668) if (files->selected[i] &&
a8c45be9 669)     add_file_to_index(s->r->index, name, 0) < 0) {
a8c45be9 671) break;
a8c45be9 675) if (!res && write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
a8c45be9 678) if (!res)
a8c45be9 679) printf(Q_("updated %d path\n",
a8c45be9 682) putchar('\n');
a8c45be9 683) return res;
a8c45be9 995) static void choose_prompt_help(struct add_i_state *s)
a8c45be9 997) color_fprintf_ln(stdout, s->help_color, "%s",
a8c45be9 999) color_fprintf_ln(stdout, s->help_color, "1          - %s",
a8c45be9 1001) color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
a8c45be9 1003) color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
a8c45be9 1005) color_fprintf_ln(stdout, s->help_color, "foo        - %s",
a8c45be9 1007) color_fprintf_ln(stdout, s->help_color, "-...       - %s",
a8c45be9 1009) color_fprintf_ln(stdout, s->help_color, "*          - %s",
a8c45be9 1011) color_fprintf_ln(stdout, s->help_color, "           - %s",
a8c45be9 1013) }
a8c45be9 1083) struct list_and_choose_options opts = {
a8c45be9 1088) struct prefix_item_list files = PREFIX_ITEM_LIST_INIT;
a8c45be9 1109) print_file_item_data.color = data.color;
a8c45be9 1110) print_file_item_data.reset = data.reset;
a8c45be9 1115) opts.list_opts.header = header.buf;
a8c45be9 1144) prefix_item_list_clear(&files);
a8c45be9 1146) strbuf_release(&print_file_item_data.name);

Johannes Schindelin	8746e072 built-in add -i: implement the `patch` command
add-interactive.c
8746e072 462) other_adddel = s->mode == FROM_INDEX ?
8746e072 463) &file_item->worktree : &file_item->index;
8746e072 467) if (stat.files[i]->is_binary) {
8746e072 468) if (!other_adddel->binary)
8746e072 469) s->binary_count++;
8746e072 472) if (stat.files[i]->is_unmerged) {
8746e072 473) if (!other_adddel->unmerged)
8746e072 474) s->unmerged_count++;
8746e072 475) adddel->unmerged = 1;
8746e072 542) if (unmerged_count)
8746e072 543) *unmerged_count = s.unmerged_count;
8746e072 544) if (binary_count)
8746e072 545) *binary_count = s.binary_count;
8746e072 628) if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
8746e072 645) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
8746e072 724) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
8746e072 876) static int run_patch(struct add_i_state *s, const struct pathspec *ps,
8746e072 880) int res = 0;
8746e072 882) size_t unmerged_count = 0, binary_count = 0;
8746e072 884) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
8746e072 886) return -1;
8746e072 888) if (unmerged_count || binary_count) {
8746e072 889) for (i = j = 0; i < files->items.nr; i++) {
8746e072 890) struct file_item *item = files->items.items[i].util;
8746e072 892) if (item->index.binary || item->worktree.binary) {
8746e072 893) free(item);
8746e072 894) free(files->items.items[i].string);
8746e072 895) } else if (item->index.unmerged ||
8746e072 897) color_fprintf_ln(stderr, s->error_color,
8746e072 899)  files->items.items[i].string);
8746e072 900) free(item);
8746e072 901) free(files->items.items[i].string);
8746e072 903) files->items.items[j++] = files->items.items[i];
8746e072 905) files->items.nr = j;
8746e072 908) if (!files->items.nr) {
8746e072 909) if (binary_count)
8746e072 910) fprintf(stderr, _("Only binary files changed.\n"));
8746e072 912) fprintf(stderr, _("No changes.\n"));
8746e072 913) return 0;
8746e072 916) opts->prompt = N_("Patch update");
8746e072 917) count = list_and_choose(s, files, opts);
8746e072 918) if (count >= 0) {
8746e072 919) struct argv_array args = ARGV_ARRAY_INIT;
8746e072 921) argv_array_pushl(&args, "git", "add--interactive", "--patch",
8746e072 923) for (i = 0; i < files->items.nr; i++)
8746e072 924) if (files->selected[i])
8746e072 925) argv_array_push(&args,
8746e072 926) files->items.items[i].string);
8746e072 927) res = run_command_v_opt(args.argv, 0);
8746e072 928) argv_array_clear(&args);
8746e072 931) return res;

Johannes Schindelin	c08171d1 built-in add -i: allow filtering the modified files list
add-interactive.c
c08171d1 447) if (s->skip_unseen)
c08171d1 448) continue;
c08171d1 460) adddel = s->mode == FROM_INDEX ?
c08171d1 487) static int get_modified_files(struct repository *r,
c08171d1 497) struct collection_status s = { 0 };
c08171d1 508) for (i = 0; i < 2; i++) {
c08171d1 512) if (filter == INDEX_ONLY)
c08171d1 513) s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
c08171d1 515) s.mode = (i == 0) ? FROM_WORKTREE : FROM_INDEX;
c08171d1 516) s.skip_unseen = filter && i;
c08171d1 531) if (s.mode == FROM_INDEX)

Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles are inherited by child processes
t/helper/test-run-command.c
eea4a7f4 203) static int inherit_handle(const char *argv0)
eea4a7f4 205) struct child_process cp = CHILD_PROCESS_INIT;
eea4a7f4 210) xsnprintf(path, sizeof(path), "out-XXXXXX");
eea4a7f4 211) tmp = xmkstemp(path);
eea4a7f4 213) argv_array_pushl(&cp.args,
eea4a7f4 215) cp.in = -1;
eea4a7f4 216) cp.no_stdout = cp.no_stderr = 1;
eea4a7f4 217) if (start_command(&cp) < 0)
eea4a7f4 221) close(tmp);
eea4a7f4 222) if (unlink(path))
eea4a7f4 225) if (close(cp.in) < 0 || finish_command(&cp) < 0)
eea4a7f4 228) return 0;
eea4a7f4 231) static int inherit_handle_child(void)
eea4a7f4 233) struct strbuf buf = STRBUF_INIT;
eea4a7f4 235) if (strbuf_read(&buf, 0, 0) < 0)
eea4a7f4 237) printf("Received %s\n", buf.buf);
eea4a7f4 238) strbuf_release(&buf);
eea4a7f4 240) return 0;
eea4a7f4 251) exit(inherit_handle(argv[0]));
eea4a7f4 253) exit(inherit_handle_child());

Johannes Schindelin	2e697ced built-in add -i: offer the `quit` command
add-interactive.c
2e697ced 1129) if (i < 0 || i >= commands.items.nr)
2e697ced 1130) util = NULL;
2e697ced 1132) util = commands.items.items[i].util;
2e697ced 1134) if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
2e697ced 1140) if (util)

Johannes Schindelin	f37c2264 built-in add -i: prepare for multi-selection commands
add-interactive.c
f37c2264 88) FREE_AND_NULL(list->selected);
f37c2264 195) static void list(struct add_i_state *s, struct string_list *list, int *selected,
f37c2264 208) opts->print_item(i, selected ? selected[i] : 0, list->items + i,
f37c2264 249) int singleton = opts->flags & SINGLETON;
f37c2264 250) int immediate = opts->flags & IMMEDIATE;
f37c2264 253) ssize_t res = singleton ? LIST_AND_CHOOSE_ERROR : 0;
f37c2264 255) if (!singleton) {
f37c2264 256) free(items->selected);
f37c2264 257) CALLOC_ARRAY(items->selected, items->items.nr);
f37c2264 260) if (singleton && !immediate)
f37c2264 270) list(s, &items->items, items->selected, &opts->list_opts);
f37c2264 273) fputs(singleton ? "> " : ">> ", stdout);
f37c2264 278) if (immediate)
f37c2264 279) res = LIST_AND_CHOOSE_QUIT;
f37c2264 295) int choose = 1;
f37c2264 297) ssize_t from = -1, to = -1;
f37c2264 307) if (*p == '-') {
f37c2264 308) choose = 0;
f37c2264 309) p++;
f37c2264 310) sep--;
f37c2264 313) if (sep == 1 && *p == '*') {
f37c2264 314) from = 0;
f37c2264 315) to = items->items.nr;
f37c2264 316) } else if (isdigit(*p)) {
f37c2264 327) from = strtoul(p, &endp, 10) - 1;
f37c2264 328) if (endp == p + sep)
f37c2264 329) to = from + 1;
f37c2264 330) else if (*endp == '-') {
f37c2264 331) to = strtoul(++endp, &endp, 10);
f37c2264 333) if (endp != p + sep)
f37c2264 334) from = -1;
f37c2264 340) if (from < 0) {
f37c2264 341) from = find_unique(p, items);
f37c2264 342) if (from >= 0)
f37c2264 343) to = from + 1;
f37c2264 346) if (from < 0 || from >= items->items.nr ||
f37c2264 347)     (singleton && from + 1 != to)) {
f37c2264 350) break;
f37c2264 351) } else if (singleton) {
f37c2264 352) res = from;
f37c2264 356) if (to > items->items.nr)
f37c2264 357) to = items->items.nr;
f37c2264 359) for (; from < to; from++)
f37c2264 360) if (items->selected[from] != choose) {
f37c2264 361) items->selected[from] = choose;
f37c2264 362) res += choose ? +1 : -1;
f37c2264 368) if ((immediate && res != LIST_AND_CHOOSE_ERROR) ||
f37c2264 369)     !strcmp(input.buf, "*"))
f37c2264 588) static void print_file_item(int i, int selected, struct string_list_item *item,
f37c2264 621) printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
f37c2264 1028) static void print_command_item(int i, int selected,

René Scharfe	0bb313a5 xdiff: unignore changes in function context
xdiff/xemit.c
0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
0bb313a5 225) xchp = xchp->next;

Rohit Ashiwal	c068bcc5 sequencer: allow callers of read_author_script() to ignore fields
sequencer.c
c068bcc5 840) free(kv.items[date_i].util);

Rohit Ashiwal	cbd8db17 rebase -i: support --committer-date-is-author-date
sequencer.c
cbd8db17 890) return NULL;
cbd8db17 989) return -1;
cbd8db17 1428) goto out;
cbd8db17 1432) goto out;
cbd8db17 2603) opts->allow_ff = 0;
cbd8db17 2604) opts->committer_date_is_author_date = 1;

Rohit Ashiwal	08187b4c rebase -i: support --ignore-date
sequencer.c
08187b4c 903) return NULL;
08187b4c 920) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
08187b4c 1508) res = -1;
08187b4c 1509) goto out;
08187b4c 2608) opts->allow_ff = 0;
08187b4c 2609) opts->ignore_date = 1;
08187b4c 3639) push_dates(&cmd, opts->committer_date_is_author_date);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
add-interactive.c
5e82b9e4 36) static void init_add_i_state(struct add_i_state *s, struct repository *r)
5e82b9e4 54) }
5e82b9e4 194) if (!list->nr)
5e82b9e4 195) return;
5e82b9e4 197) if (opts->header)
5e82b9e4 201) for (i = 0; i < list->nr; i++) {
5e82b9e4 202) opts->print_item(i, list->items + i, opts->print_item_data);
5e82b9e4 215) putchar('\n');
5e82b9e4 305) }
5e82b9e4 320) static void add_file_item(struct string_list *files, const char *name)
5e82b9e4 322) struct file_item *item = xcalloc(sizeof(*item), 1);
5e82b9e4 324) string_list_append(files, name)->util = item;
5e82b9e4 325) }
5e82b9e4 333) static int pathname_entry_cmp(const void *unused_cmp_data,
5e82b9e4 338) const struct pathname_entry *e1 =
5e82b9e4 340) const struct pathname_entry *e2 =
5e82b9e4 343) return strcmp(e1->name, name ? (const char *)name : e2->name);
5e82b9e4 355) static void collect_changes_cb(struct diff_queue_struct *q,
5e82b9e4 359) struct collection_status *s = data;
5e82b9e4 360) struct diffstat_t stat = { 0 };
5e82b9e4 363) if (!q->nr)
5e82b9e4 364) return;
5e82b9e4 366) compute_diffstat(options, &stat, q);
5e82b9e4 368) for (i = 0; i < stat.nr; i++) {
5e82b9e4 369) const char *name = stat.files[i]->name;
5e82b9e4 370) int hash = strhash(name);
5e82b9e4 375) entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
5e82b9e4 377) if (!entry) {
5e82b9e4 378) add_file_item(s->files, name);
5e82b9e4 380) entry = xcalloc(sizeof(*entry), 1);
5e82b9e4 381) hashmap_entry_init(&entry->ent, hash);
5e82b9e4 382) entry->name = s->files->items[s->files->nr - 1].string;
5e82b9e4 383) entry->item = s->files->items[s->files->nr - 1].util;
5e82b9e4 384) hashmap_add(&s->file_map, &entry->ent);
5e82b9e4 387) file_item = entry->item;
5e82b9e4 388) adddel = s->phase == FROM_INDEX ?
5e82b9e4 389) &file_item->index : &file_item->worktree;
5e82b9e4 390) adddel->seen = 1;
5e82b9e4 391) adddel->add = stat.files[i]->added;
5e82b9e4 392) adddel->del = stat.files[i]->deleted;
5e82b9e4 393) if (stat.files[i]->is_binary)
5e82b9e4 394) adddel->binary = 1;
5e82b9e4 396) free_diffstat_info(&stat);
5e82b9e4 399) static int get_modified_files(struct repository *r, struct string_list *files,
5e82b9e4 403) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
5e82b9e4 405) struct collection_status s = { FROM_WORKTREE };
5e82b9e4 407) if (discard_index(r->index) < 0 ||
5e82b9e4 408)     repo_read_index_preload(r, ps, 0) < 0)
5e82b9e4 411) string_list_clear(files, 1);
5e82b9e4 412) s.files = files;
5e82b9e4 413) hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
5e82b9e4 415) for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
5e82b9e4 417) struct setup_revision_opt opt = { 0 };
5e82b9e4 419) opt.def = is_initial ?
5e82b9e4 420) empty_tree_oid_hex() : oid_to_hex(&head_oid);
5e82b9e4 422) init_revisions(&rev, NULL);
5e82b9e4 423) setup_revisions(0, NULL, &rev, &opt);
5e82b9e4 425) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
5e82b9e4 426) rev.diffopt.format_callback = collect_changes_cb;
5e82b9e4 427) rev.diffopt.format_callback_data = &s;
5e82b9e4 429) if (ps)
5e82b9e4 430) copy_pathspec(&rev.prune_data, ps);
5e82b9e4 432) if (s.phase == FROM_INDEX)
5e82b9e4 433) run_diff_index(&rev, 1);
5e82b9e4 435) rev.diffopt.flags.ignore_dirty_submodules = 1;
5e82b9e4 436) run_diff_files(&rev, 0);
5e82b9e4 439) hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
5e82b9e4 442) string_list_sort(files);
5e82b9e4 444) return 0;
5e82b9e4 447) static void render_adddel(struct strbuf *buf,
5e82b9e4 450) if (ad->binary)
5e82b9e4 451) strbuf_addstr(buf, _("binary"));
5e82b9e4 452) else if (ad->seen)
5e82b9e4 453) strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
5e82b9e4 454)     (uintmax_t)ad->add, (uintmax_t)ad->del);
5e82b9e4 456) strbuf_addstr(buf, no_changes);
5e82b9e4 457) }
5e82b9e4 481) static void print_file_item(int i, struct string_list_item *item,
5e82b9e4 484) struct file_item *c = item->util;
5e82b9e4 485) struct print_file_item_data *d = print_file_item_data;
5e82b9e4 487) strbuf_reset(&d->index);
5e82b9e4 488) strbuf_reset(&d->worktree);
5e82b9e4 489) strbuf_reset(&d->buf);
5e82b9e4 491) render_adddel(&d->worktree, &c->worktree, _("nothing"));
5e82b9e4 492) render_adddel(&d->index, &c->index, _("unchanged"));
5e82b9e4 493) strbuf_addf(&d->buf, d->modified_fmt,
5e82b9e4 496) printf(" %2d: %s", i + 1, d->buf.buf);
5e82b9e4 497) }
5e82b9e4 499) static int run_status(struct add_i_state *s, const struct pathspec *ps,
5e82b9e4 502) if (get_modified_files(s->r, files, ps) < 0)
5e82b9e4 503) return -1;
5e82b9e4 506) putchar('\n');
5e82b9e4 508) return 0;
5e82b9e4 573) struct add_i_state s = { NULL };
5e82b9e4 588) struct print_file_item_data print_file_item_data = {
5e82b9e4 591) struct list_options opts = {
5e82b9e4 594) struct strbuf header = STRBUF_INIT;
5e82b9e4 595) struct string_list files = STRING_LIST_INIT_DUP;
5e82b9e4 597) int res = 0;
5e82b9e4 606) init_add_i_state(&s, r);
5e82b9e4 617) strbuf_addstr(&header, "      ");
5e82b9e4 618) strbuf_addf(&header, print_file_item_data.modified_fmt,
5e82b9e4 620) opts.header = header.buf;
5e82b9e4 622) if (discard_index(r->index) < 0 ||
5e82b9e4 623)     repo_read_index(r) < 0 ||
5e82b9e4 624)     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
5e82b9e4 628) res = run_status(&s, ps, &files, &opts);
5e82b9e4 644) string_list_clear(&files, 1);
5e82b9e4 645) strbuf_release(&print_file_item_data.buf);
5e82b9e4 646) strbuf_release(&print_file_item_data.index);
5e82b9e4 647) strbuf_release(&print_file_item_data.worktree);
5e82b9e4 648) strbuf_release(&header);
5e82b9e4 651) return res;

Derrick Stolee	4bd0593e test-tool: use 'read-graph' helper
t/helper/test-read-graph.c
4bd0593e 23) die_errno(_("Could not open commit-graph '%s'"), graph_name);
4bd0593e 27) return 1;

Hans Jerry Illikainen	67a6ea63 gpg-interface: limit search for primary key fingerprint
gpg-interface.c
67a6ea63 184) replace_cstring(field, NULL, NULL);

Hans Jerry Illikainen	392b862e gpg-interface: refactor the free-and-xmemdupz pattern
gpg-interface.c
392b862e 115) *field = NULL;

James Coglan	fbccf255 graph: automatically track display width of graph lines
graph.c
fbccf255 904) graph_line_write_column(line, col, '|');

James Coglan	0195285b graph: rename `new_mapping` to `old_mapping`
graph.c
0195285b 421) REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);

Jeff King	103fb6d4 fsck: accept an oid instead of a "struct tag" for fsck_tag()
fsck.c
103fb6d4 837) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
103fb6d4 841) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
103fb6d4 848) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
103fb6d4 853) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
103fb6d4 857) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
103fb6d4 863) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
103fb6d4 868) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");

Jeff King	228c78fb commit, tag: don't set parsed bit for parse failures
tag.c
228c78fb 152) FREE_AND_NULL(item->tag);

Jeff King	ad7a4032 send-pack: check remote ref status on pack-objects failure
send-pack.c
ad7a4032 580) receive_status(&reader, remote_refs);

Jeff King	f66e0401 pack-objects: avoid pointless oe_map_new_pack() calls
pack-objects.c
f66e0401 122) if (pack->in_pack)
f66e0401 125) ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);

Jeff King	b8b00f16 fsck: drop blob struct from fsck_finish()
fsck.c
b8b00f16 1027) if (is_promisor_object(oid))

Jeff King	38370253 fsck: don't require an object struct for report()
fsck.c
38370253 980) return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
38370253 991) return report(options, &obj->oid, obj->type,
38370253 994)       obj->type);
38370253 1029) ret |= report(options,

Jeff King	6da40b22 fsck: accept an oid instead of a "struct blob" for fsck_blob()
fsck.c
6da40b22 958) return report(options, oid, OBJ_BLOB,

Jeff King	c5b4269b fsck: accept an oid instead of a "struct commit" for fsck_commit()
fsck.c
c5b4269b 781) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
c5b4269b 783) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
c5b4269b 790) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
c5b4269b 804) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
c5b4269b 810) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");

Jeff King	78543993 fsck: don't require an object struct for fsck_ident()
fsck.c
78543993 733) return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 740) return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 744) return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
78543993 750) return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
78543993 754) return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
78543993 762) return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");

Jeff King	b2f2039c fsck: accept an oid instead of a "struct tree" for fsck_tree()
fsck.c
b2f2039c 622) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
b2f2039c 669) retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
b2f2039c 671) retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
b2f2039c 679) retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
b2f2039c 681) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
b2f2039c 685) retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");

Jeff King	73390290 fsck: use oids rather than objects for object_name API
fsck.c
73390290 400) fsck_put_object_name(options, &entry.oid, "%s%s/",
73390290 469) fsck_put_object_name(options, oid, "%s^%d",
73390290 472) fsck_put_object_name(options, oid, "%.*s~%d",
73390290 495) fsck_put_object_name(options, &tag->tagged->oid, "%s", name);

Jeff King	82ef89b3 fsck: don't require object structs for display functions
builtin/fsck.c
82ef89b3 64) type = oid_object_info(the_repository, oid, NULL);
82ef89b3 309) printf_ln(_("unreachable %s %s"),
82ef89b3 310)   printable_type(&obj->oid, obj->type),
82ef89b3 311)   describe_object(&obj->oid));
82ef89b3 367) fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
82ef89b3 425)    printable_type(&obj->oid, obj->type),
82ef89b3 426)    describe_object(&obj->oid));
82ef89b3 439)   describe_object(&commit->object.oid));

Jeff King	cc579000 fsck: don't require an object struct in verify_headers()
fsck.c
cc579000 717) return report(options, oid, type,

Johannes Schindelin	68db1cbf built-in add -i: support `?` (prompt help)
add-interactive.c
68db1cbf 50) init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
68db1cbf 263) if (!strcmp(input.buf, "?")) {
68db1cbf 264) opts->print_help(s);
68db1cbf 265) continue;
68db1cbf 559) static void command_prompt_help(struct add_i_state *s)
68db1cbf 561) const char *help_color = s->help_color;
68db1cbf 562) color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
68db1cbf 563) color_fprintf_ln(stdout, help_color, "1          - %s",
68db1cbf 565) color_fprintf_ln(stdout, help_color, "foo        - %s",
68db1cbf 567) color_fprintf_ln(stdout, help_color, "           - %s",
68db1cbf 569) }

Johannes Schindelin	76b74323 built-in add -i: show unique prefixes of the commands
add-interactive.c
76b74323 80) static void prefix_item_list_clear(struct prefix_item_list *list)
76b74323 82) string_list_clear(&list->items, 1);
76b74323 83) string_list_clear(&list->sorted, 0);
76b74323 84) }
76b74323 86) static void extend_prefix_length(struct string_list_item *p,
76b74323 89) size_t *len = p->util;
76b74323 91) if (!*len || memcmp(p->string, other_string, *len))
76b74323 92) return;
76b74323 95) char c = p->string[*len];
76b74323 103) if (!c || ++*len > max_length || !isascii(c)) {
76b74323 104) *len = 0;
76b74323 105) break;
76b74323 108) if (c != other_string[*len - 1])
76b74323 109) break;
76b74323 110) }
76b74323 113) static void find_unique_prefixes(struct prefix_item_list *list)
76b74323 117) if (list->sorted.nr == list->items.nr)
76b74323 118) return;
76b74323 120) string_list_clear(&list->sorted, 0);
76b74323 122) list->sorted.items = xmalloc(st_mult(sizeof(*list->sorted.items),
76b74323 123)      list->items.nr));
76b74323 124) list->sorted.nr = list->sorted.alloc = list->items.nr;
76b74323 126) for (i = 0; i < list->items.nr; i++) {
76b74323 127) list->sorted.items[i].string = list->items.items[i].string;
76b74323 128) list->sorted.items[i].util = list->items.items + i;
76b74323 131) string_list_sort(&list->sorted);
76b74323 133) for (i = 0; i < list->sorted.nr; i++) {
76b74323 134) struct string_list_item *sorted_item = list->sorted.items + i;
76b74323 135) struct string_list_item *item = sorted_item->util;
76b74323 136) size_t *len = item->util;
76b74323 138) *len = 0;
76b74323 139) while (*len < list->min_length) {
76b74323 140) char c = item->string[(*len)++];
76b74323 142) if (!c || !isascii(c)) {
76b74323 143) *len = 0;
76b74323 144) break;
76b74323 148) if (i > 0)
76b74323 149) extend_prefix_length(item, sorted_item[-1].string,
76b74323 151) if (i + 1 < list->sorted.nr)
76b74323 152) extend_prefix_length(item, sorted_item[1].string,
76b74323 157) static ssize_t find_unique(const char *string, struct prefix_item_list *list)
76b74323 159) int index = string_list_find_insert_index(&list->sorted, string, 1);
76b74323 162) if (list->items.nr != list->sorted.nr)
76b74323 167) if (index < 0)
76b74323 168) item = list->sorted.items[-1 - index].util;
76b74323 169) else if (index > 0 &&
76b74323 170)  starts_with(list->sorted.items[index - 1].string, string))
76b74323 171) return -1;
76b74323 172) else if (index + 1 < list->sorted.nr &&
76b74323 173)  starts_with(list->sorted.items[index + 1].string, string))
76b74323 174) return -1;
76b74323 175) else if (index < list->sorted.nr)
76b74323 176) item = list->sorted.items[index].util;
76b74323 178) return -1;
76b74323 179) return item - list->items.items;
76b74323 233) static ssize_t list_and_choose(struct add_i_state *s,
76b74323 240) find_unique_prefixes(items);
76b74323 247) list(s, &items->items, &opts->list_opts);
76b74323 289) if (index < 0)
76b74323 290) index = find_unique(p, items);
76b74323 292) if (index < 0 || index >= items->items.nr)
76b74323 460) static int is_valid_prefix(const char *prefix, size_t prefix_len)
76b74323 462) return prefix_len && prefix &&
76b74323 468) strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
76b74323 469) *prefix != '-' &&				/* deselection */
76b74323 470) !isdigit(*prefix) &&				/* selection */
76b74323 471) (prefix_len != 1 ||
76b74323 472)  (*prefix != '*' &&				/* "all" wildcard */
76b74323 473)   *prefix != '?'));				/* prompt help */
76b74323 548) struct command_item *util = item->util;
76b74323 550) if (!util->prefix_length ||
76b74323 551)     !is_valid_prefix(item->string, util->prefix_length))
76b74323 552) printf(" %2d: %s", i + 1, item->string);
76b74323 586) struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
76b74323 599) for (i = 0; i < ARRAY_SIZE(command_list); i++) {
76b74323 600) struct command_item *util = xcalloc(sizeof(*util), 1);
76b74323 601) util->command = command_list[i].command;
76b74323 602) string_list_append(&commands.items, command_list[i].string)
76b74323 603) ->util = util;
76b74323 638) struct command_item *util =
76b74323 639) commands.items.items[i].util;
76b74323 640) res = util->command(&s, ps, &files, &opts);
76b74323 649) prefix_item_list_clear(&commands);

Johannes Schindelin	867bc1d2 rebase-merges: move labels' whitespace mangling into `label_oid()`
sequencer.c
867bc1d2 4539) }

Johannes Schindelin	6348bfba built-in add -i: implement the main loop
add-interactive.c
6348bfba 192) int i, last_lf = 0;
6348bfba 204) if ((opts->columns) && ((i + 1) % (opts->columns))) {
6348bfba 205) putchar('\t');
6348bfba 206) last_lf = 0;
6348bfba 209) putchar('\n');
6348bfba 210) last_lf = 1;
6348bfba 214) if (!last_lf)
6348bfba 237) struct strbuf input = STRBUF_INIT;
6348bfba 238) ssize_t res = LIST_AND_CHOOSE_ERROR;
6348bfba 245) strbuf_reset(&input);
6348bfba 251) fflush(stdout);
6348bfba 253) if (strbuf_getline(&input, stdin) == EOF) {
6348bfba 254) putchar('\n');
6348bfba 255) res = LIST_AND_CHOOSE_QUIT;
6348bfba 256) break;
6348bfba 258) strbuf_trim(&input);
6348bfba 260) if (!input.len)
6348bfba 261) break;
6348bfba 268) p = input.buf;
6348bfba 270) size_t sep = strcspn(p, " \t\r\n,");
6348bfba 271) ssize_t index = -1;
6348bfba 273) if (!sep) {
6348bfba 274) if (!*p)
6348bfba 275) break;
6348bfba 276) p++;
6348bfba 277) continue;
6348bfba 280) if (isdigit(*p)) {
6348bfba 282) index = strtoul(p, &endp, 10) - 1;
6348bfba 283) if (endp != p + sep)
6348bfba 284) index = -1;
6348bfba 287) if (p[sep])
6348bfba 288) p[sep++] = '\0';
6348bfba 296) res = index;
6348bfba 297) break;
6348bfba 300) p += sep;
6348bfba 301) }
6348bfba 303) if (res != LIST_AND_CHOOSE_ERROR)
6348bfba 304) break;
6348bfba 307) strbuf_release(&input);
6348bfba 308) return res;
6348bfba 544) static void print_command_item(int i, struct string_list_item *item,
6348bfba 557) }
6348bfba 575) struct list_and_choose_options main_loop_opts = {
6348bfba 582) } command_list[] = {
6348bfba 631) i = list_and_choose(&s, &commands, &main_loop_opts);
6348bfba 632) if (i == LIST_AND_CHOOSE_QUIT) {
6348bfba 633) printf(_("Bye.\n"));
6348bfba 634) res = 0;
6348bfba 635) break;
6348bfba 637) if (i != LIST_AND_CHOOSE_ERROR) {
6348bfba 642) }

Johannes Schindelin	4d17fd25 remote-curl: unbreak http.extraHeader with custom allocators
http.c
4d17fd25 417) string_list_clear(&extra_http_headers, 0);

Johannes Schindelin	2e0afafe Add git-bundle: move objects and references by archive
builtin/bundle.c
2e0afafe 115) return 1;

Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffering
usage.c
116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
116d1fa6 17) abort();
116d1fa6 22) *p = '\0'; /* vsnprintf() failed, clip at prefix */

Johannes Schindelin	f83dff60 Start to implement a built-in version of `git add --interactive`
add-interactive.c
f83dff60 571) int run_add_i(struct repository *r, const struct pathspec *ps)

builtin/add.c
f83dff60 197) return !!run_add_i(the_repository, pathspec);

Matthew Rogers	cd552227 rebase -r: let `label` generate safer labels
sequencer.c
cd552227 4514) strbuf_addstr(buf, "rev-");
cd552227 4515) strbuf_add_unique_abbrev(buf, oid, default_abbrev);

Mike Hommey	0aa0c2b2 revision: free topo_walk_info before creating a new one in init_topo_walk
revision.c
0aa0c2b2 3214) static void reset_topo_walk(struct rev_info *revs)
0aa0c2b2 3216) struct topo_walk_info *info = revs->topo_walk_info;
0aa0c2b2 3218) clear_prio_queue(&info->explore_queue);
0aa0c2b2 3219) clear_prio_queue(&info->indegree_queue);
0aa0c2b2 3220) clear_prio_queue(&info->topo_queue);
0aa0c2b2 3221) clear_indegree_slab(&info->indegree);
0aa0c2b2 3222) clear_author_date_slab(&info->author_date);
0aa0c2b2 3224) FREE_AND_NULL(revs->topo_walk_info);
0aa0c2b2 3225) }
0aa0c2b2 3232) reset_topo_walk(revs);

Phillip Wood	2d05ef27 sequencer: fix empty commit check when amending
sequencer.c
2d05ef27 1361) goto out;

Robin H. Johnson	73c3253d bundle: framework for options before bundle file
builtin/bundle.c
73c3253d 138) return 1;
73c3253d 143) static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
73c3253d 145) int bundle_fd = -1;
73c3253d 147) struct option options[] = {
73c3253d 152) argc = parse_options_cmd_bundle(argc, argv, prefix,
73c3253d 156) memset(&header, 0, sizeof(header));
73c3253d 157) if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
73c3253d 158) return 1;
73c3253d 159) if (!startup_info->have_repository)
73c3253d 161) return !!unbundle(the_repository, &header, bundle_fd, 0) ||
73c3253d 162) list_bundle_refs(&header, argc, argv);
73c3253d 187) else if (!strcmp(argv[0], "unbundle"))
73c3253d 188) result = cmd_bundle_unbundle(argc, argv, prefix);

Robin H. Johnson	79862b6b bundle-create: progress output control
builtin/bundle.c
79862b6b 85) else if (progress == 1)
79862b6b 86) argv_array_push(&pack_opts, "--progress");
79862b6b 87) else if (progress == 2)
79862b6b 88) argv_array_push(&pack_opts, "--all-progress");
79862b6b 90) argv_array_push(&pack_opts, "--all-progress-implied");

Slavica Đukić	8c159044 built-in add -i: implement the `help` command
add-interactive.c
8c159044 511) static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
8c159044 515) color_fprintf_ln(stdout, s->help_color, "status        - %s",
8c159044 517) color_fprintf_ln(stdout, s->help_color, "update        - %s",
8c159044 519) color_fprintf_ln(stdout, s->help_color, "revert        - %s",
8c159044 521) color_fprintf_ln(stdout, s->help_color, "patch         - %s",
8c159044 523) color_fprintf_ln(stdout, s->help_color, "diff          - %s",
8c159044 525) color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
8c159044 528) return 0;

Slavica Đukić	3d965c76 built-in add -i: use color in the main loop
add-interactive.c
3d965c76 51) init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
3d965c76 52) init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
3d965c76 53) init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
3d965c76 249) color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
3d965c76 250) fputs("> ", stdout);
3d965c76 293) color_fprintf_ln(stdout, s->error_color,
3d965c76 547) struct print_command_item_data *d = print_command_item_data;
3d965c76 554) printf(" %2d: %s%.*s%s%s", i + 1,
3d965c76 555)        d->color, (int)util->prefix_length, item->string,
3d965c76 556)        d->reset, item->string + util->prefix_length);
3d965c76 574) struct print_command_item_data data = { "[", "]" };
3d965c76 612) if (s.use_color) {
3d965c76 613) data.color = s.prompt_color;
3d965c76 614) data.reset = s.reset_color;

Slavica Đukić	1daaebca built-in add -i: color the header in the `status` command
add-interactive.c
1daaebca 20) static void init_color(struct repository *r, struct add_i_state *s,
1daaebca 24) char *key = xstrfmt("color.interactive.%s", slot_name);
1daaebca 27) if (!s->use_color)
1daaebca 28) dst[0] = '\0';
1daaebca 29) else if (repo_config_get_value(r, key, &value) ||
1daaebca 30)  color_parse(value, dst))
1daaebca 31) strlcpy(dst, default_color, COLOR_MAXLEN);
1daaebca 33) free(key);
1daaebca 34) }
1daaebca 40) s->r = r;
1daaebca 42) if (repo_config_get_value(r, "color.interactive", &value))
1daaebca 43) s->use_color = -1;
1daaebca 45) s->use_color =
1daaebca 46) git_config_colorbool("color.interactive", value);
1daaebca 47) s->use_color = want_color(s->use_color);
1daaebca 49) init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
1daaebca 189) static void list(struct add_i_state *s, struct string_list *list,
1daaebca 198) color_fprintf_ln(stdout, s->header_color,
1daaebca 505) list(s, files, opts);


