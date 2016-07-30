Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE851F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 19:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbcG3Tu4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 15:50:56 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37730 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbcG3Tuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 15:50:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so193212939wmg.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 12:50:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/uemTzjb5DDq5w+HDwfX3CO3m6tqfBQoanP/9R4FE8=;
        b=xzMqiGUPcLoD9BFFzf99TK8qGYHbN97ju5L61spIso2dxtHLbn6Fb5FwWQoZk87q1N
         n2livgha3dmjqJpvL6LQgA7fVa3ol2wcUkoigxTrYrpuxk18edZJ2NLR8xL/k6c6vFuf
         DCMgMZtl9MY3dgiFbRKEBsI7vm4RbeUKKsE1RtHy35DB3MH1kba9Sn8Lo5KKT6gWWyQK
         22X0dhfnaxp8+QxWUnEtLn8Xtkfq81k+8fcngG43MXLSVkMctugkVc1Ky18dpqK3mrUx
         sEh2nH9K5RgHoZfo+pRVTD92VXBGqkHfZPQBOD4uQRINYsDkcf02T0qWPrbC5Sp1mca8
         LpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/uemTzjb5DDq5w+HDwfX3CO3m6tqfBQoanP/9R4FE8=;
        b=WFQ2puNytaAJz159aXumanR3JPPH2uWgyly/jdcFAvyPL0xLcjdGHq8gfXZBc7BSop
         7nmJ5oHVNmUw7Pf+x68O5QkGlPdVrKp1wLcPogWfJrAqdnRZSHDk9FWxY2MdGoYLtleu
         0el7YqpMRxDRxG8xcgjzjx4GERaEr/cS2DexSEq0U1/hro5deMLCw4biJ6LDDU1YGuHy
         xz6p5iflWylNKBI94gwHa1ytl8+3+q/RWcxuFevX5sJlgMFAxSjTPomWg4cTv8ri4W33
         Sh/vPKKPJgOvIe5sDSsnirwbENzdiiLZ1Uq1Wb0sP681GBe3+g6eDlBX8D3DSdirjVa1
         XG/Q==
X-Gm-Message-State: AEkoout97f2WmRx7V9jzhHI0U4p4e8cv4OwPHSc5/zZD86nfQJmgJz04qlnhcLJVHHfxPLBUCMQYm3WGT43zQQ==
X-Received: by 10.28.167.80 with SMTP id q77mr7047225wme.62.1469908253031;
 Sat, 30 Jul 2016 12:50:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sat, 30 Jul 2016 12:50:52 -0700 (PDT)
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sat, 30 Jul 2016 21:50:52 +0200
Message-ID: <CAP8UFD2CDCOHJ8ONq12F2Phceu2yE=5i1sSxtnse+gXrn9aSEw@mail.gmail.com>
Subject: Re: [PATCH v9 00/41] libify apply and use lib in am, part 2
To:	git <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 7:24 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and the previous one, as a
> reply to this email.

Here is the diff:

diff --git a/apply.c b/apply.c
index 2ac3a35..a73889e 100644
--- a/apply.c
+++ b/apply.c
@@ -132,8 +132,8 @@ int check_apply_state(struct apply_state *state,
int force_apply)
     }
     if (state->apply_with_reject) {
         state->apply = 1;
-        if (!state->be_silent)
-            state->apply_verbosely = 1;
+        if (state->apply_verbosity == verbosity_normal)
+            state->apply_verbosity = verbosity_verbose;
     }
     if (!force_apply && (state->diffstat || state->numstat ||
state->summary || state->check || state->fake_ancestor))
         state->apply = 0;
@@ -146,12 +146,10 @@ int check_apply_state(struct apply_state *state,
int force_apply)
     }
     if (state->check_index)
         state->unsafe_paths = 0;
-    if (state->be_silent && state->apply_verbosely)
-        return error(_("incompatible internal 'be_silent' and
'apply_verbosely' flags"));
     if (!state->lock_file)
         return error("BUG: state->lock_file should not be NULL");

-    if (state->be_silent) {
+    if (state->apply_verbosity <= verbosity_silent) {
         state->saved_error_routine = get_error_routine();
         state->saved_warn_routine = get_warn_routine();
         set_error_routine(mute_routine);
@@ -1637,7 +1635,7 @@ static void record_ws_error(struct apply_state *state,
         return;

     err = whitespace_error_string(result);
-    if (!state->be_silent)
+    if (state->apply_verbosity > verbosity_silent)
         fprintf(stderr, "%s:%d: %s.\n%.*s\n",
             state->patch_input_file, linenr, err, len, line);
     free(err);
@@ -1834,7 +1832,7 @@ static int parse_single_patch(struct apply_state *state,
         return error(_("new file %s depends on old contents"),
patch->new_name);
     if (0 < patch->is_delete && newlines)
         return error(_("deleted file %s still has contents"), patch->old_name);
-    if (!patch->is_delete && !newlines && context && !state->be_silent)
+    if (!patch->is_delete && !newlines && context &&
state->apply_verbosity > verbosity_silent)
         fprintf_ln(stderr,
                _("** warning: "
                  "file %s becomes empty but is not deleted"),
@@ -2929,7 +2927,7 @@ static int apply_one_fragment(struct apply_state *state,
             /* Ignore it, we already handled it */
             break;
         default:
-            if (state->apply_verbosely)
+            if (state->apply_verbosity > verbosity_normal)
                 error(_("invalid start of line: '%c'"), first);
             applied_pos = -1;
             goto out;
@@ -3044,7 +3042,7 @@ static int apply_one_fragment(struct apply_state *state,
                 state->apply = 0;
         }

-        if (state->apply_verbosely && applied_pos != pos) {
+        if (state->apply_verbosity > verbosity_normal && applied_pos != pos) {
             int offset = applied_pos - pos;
             if (state->apply_in_reverse)
                 offset = 0 - offset;
@@ -3060,13 +3058,13 @@ static int apply_one_fragment(struct apply_state *state,
          * of context lines.
          */
         if ((leading != frag->leading ||
-             trailing != frag->trailing) && !state->be_silent)
+             trailing != frag->trailing) && state->apply_verbosity >
verbosity_silent)
             fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
                          " to apply fragment at %d"),
                    leading, trailing, applied_pos+1);
         update_image(state, img, applied_pos, &preimage, &postimage);
     } else {
-        if (state->apply_verbosely)
+        if (state->apply_verbosity > verbosity_normal)
             error(_("while searching for:\n%.*s"),
                   (int)(old - oldlines), oldlines);
     }
@@ -3557,7 +3555,7 @@ static int try_threeway(struct apply_state *state,
          read_blob_object(&buf, pre_sha1, patch->old_mode))
         return error("repository lacks the necessary blob to fall
back on 3-way merge.");

-    if (!state->be_silent)
+    if (state->apply_verbosity > verbosity_silent)
         fprintf(stderr, "Falling back to three-way merge...\n");

     img = strbuf_detach(&buf, &len);
@@ -3588,7 +3586,7 @@ static int try_threeway(struct apply_state *state,
     status = three_way_merge(image, patch->new_name,
                  pre_sha1, our_sha1, post_sha1);
     if (status < 0) {
-        if (!state->be_silent)
+        if (state->apply_verbosity > verbosity_silent)
             fprintf(stderr,
                 "Failed to fall back on three-way merge...\n");
         return status;
@@ -3602,12 +3600,12 @@ static int try_threeway(struct apply_state *state,
             hashcpy(patch->threeway_stage[0].hash, pre_sha1);
         hashcpy(patch->threeway_stage[1].hash, our_sha1);
         hashcpy(patch->threeway_stage[2].hash, post_sha1);
-        if (!state->be_silent)
+        if (state->apply_verbosity > verbosity_silent)
             fprintf(stderr,
                 "Applied patch to '%s' with conflicts.\n",
                 patch->new_name);
     } else {
-        if (!state->be_silent)
+        if (state->apply_verbosity > verbosity_silent)
             fprintf(stderr,
                 "Applied patch to '%s' cleanly.\n",
                 patch->new_name);
@@ -3983,7 +3981,7 @@ static int check_patch_list(struct apply_state
*state, struct patch *patch)
     prepare_fn_table(state, patch);
     while (patch) {
         int res;
-        if (state->apply_verbosely)
+        if (state->apply_verbosity > verbosity_normal)
             say_patch_name(stderr,
                        _("Checking patch %s..."), patch);
         res = check_patch(state, patch);
@@ -4496,7 +4494,7 @@ static int write_out_one_reject(struct
apply_state *state, struct patch *patch)
     }

     if (!cnt) {
-        if (state->apply_verbosely)
+        if (state->apply_verbosity > verbosity_normal)
             say_patch_name(stderr,
                        _("Applied patch %s cleanly."), patch);
         return 0;
@@ -4513,7 +4511,7 @@ static int write_out_one_reject(struct
apply_state *state, struct patch *patch)
                 "Applying patch %%s with %d rejects...",
                 cnt),
             cnt);
-    if (!state->be_silent)
+    if (state->apply_verbosity > verbosity_silent)
         say_patch_name(stderr, sb.buf, patch);
     strbuf_release(&sb);

@@ -4541,11 +4539,11 @@ static int write_out_one_reject(struct
apply_state *state, struct patch *patch)
          frag;
          cnt++, frag = frag->next) {
         if (!frag->rejected) {
-            if (!state->be_silent)
+            if (state->apply_verbosity > verbosity_silent)
                 fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
             continue;
         }
-        if (!state->be_silent)
+        if (state->apply_verbosity > verbosity_silent)
             fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
         fprintf(rej, "%.*s", frag->size, frag->patch);
         if (frag->patch[frag->size-1] != '\n')
@@ -4595,7 +4593,7 @@ static int write_out_results(struct apply_state
*state, struct patch *list)
         struct string_list_item *item;

         string_list_sort(&cpath);
-        if (!state->be_silent) {
+        if (state->apply_verbosity > verbosity_silent) {
             for_each_string_list_item(item, &cpath)
                 fprintf(stderr, "U %s\n", item->string);
         }
@@ -4655,7 +4653,7 @@ static int apply_patch(struct apply_state *state,
             listp = &patch->next;
         }
         else {
-            if (state->apply_verbosely)
+            if (state->apply_verbosity > verbosity_normal)
                 say_patch_name(stderr, _("Skipped patch '%s'."), patch);
             free_patch(patch);
             skipped_patch++;
@@ -4713,13 +4711,13 @@ static int apply_patch(struct apply_state *state,
         goto end;
     }

-    if (state->diffstat && !state->be_silent)
+    if (state->diffstat && state->apply_verbosity > verbosity_silent)
         stat_patch_list(state, list);

-    if (state->numstat && !state->be_silent)
+    if (state->numstat && state->apply_verbosity > verbosity_silent)
         numstat_patch_list(state, list);

-    if (state->summary && !state->be_silent)
+    if (state->summary && state->apply_verbosity > verbosity_silent)
         summary_patch_list(list);

 end:
@@ -4883,7 +4881,7 @@ int apply_all_patches(struct apply_state *state,
         state->newfd = -1;
     }

-    if (state->be_silent) {
+    if (state->apply_verbosity <= verbosity_silent) {
         set_error_routine(state->saved_error_routine);
         set_warn_routine(state->saved_warn_routine);
     }
@@ -4892,3 +4890,80 @@ int apply_all_patches(struct apply_state *state,
         return res;
     return (res == -1 ? 1 : 128);
 }
+
+int apply_parse_options(int argc, const char **argv,
+            struct apply_state *state,
+            int *force_apply, int *options,
+            const char * const *apply_usage)
+{
+    struct option builtin_apply_options[] = {
+        { OPTION_CALLBACK, 0, "exclude", state, N_("path"),
+            N_("don't apply changes matching the given path"),
+            0, apply_option_parse_exclude },
+        { OPTION_CALLBACK, 0, "include", state, N_("path"),
+            N_("apply changes matching the given path"),
+            0, apply_option_parse_include },
+        { OPTION_CALLBACK, 'p', NULL, state, N_("num"),
+            N_("remove <num> leading slashes from traditional diff paths"),
+            0, apply_option_parse_p },
+        OPT_BOOL(0, "no-add", &state->no_add,
+            N_("ignore additions made by the patch")),
+        OPT_BOOL(0, "stat", &state->diffstat,
+            N_("instead of applying the patch, output diffstat for
the input")),
+        OPT_NOOP_NOARG(0, "allow-binary-replacement"),
+        OPT_NOOP_NOARG(0, "binary"),
+        OPT_BOOL(0, "numstat", &state->numstat,
+            N_("show number of added and deleted lines in decimal notation")),
+        OPT_BOOL(0, "summary", &state->summary,
+            N_("instead of applying the patch, output a summary for
the input")),
+        OPT_BOOL(0, "check", &state->check,
+            N_("instead of applying the patch, see if the patch is
applicable")),
+        OPT_BOOL(0, "index", &state->check_index,
+            N_("make sure the patch is applicable to the current index")),
+        OPT_BOOL(0, "cached", &state->cached,
+            N_("apply a patch without touching the working tree")),
+        OPT_BOOL(0, "unsafe-paths", &state->unsafe_paths,
+            N_("accept a patch that touches outside the working area")),
+        OPT_BOOL(0, "apply", force_apply,
+            N_("also apply the patch (use with --stat/--summary/--check)")),
+        OPT_BOOL('3', "3way", &state->threeway,
+             N_( "attempt three-way merge if a patch does not apply")),
+        OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
+            N_("build a temporary index based on embedded index information")),
+        /* Think twice before adding "--nul" synonym to this */
+        OPT_SET_INT('z', NULL, &state->line_termination,
+            N_("paths are separated with NUL character"), '\0'),
+        OPT_INTEGER('C', NULL, &state->p_context,
+                N_("ensure at least <n> lines of context match")),
+        { OPTION_CALLBACK, 0, "whitespace", state, N_("action"),
+            N_("detect new or modified lines that have whitespace errors"),
+            0, apply_option_parse_whitespace },
+        { OPTION_CALLBACK, 0, "ignore-space-change", state, NULL,
+            N_("ignore changes in whitespace when finding context"),
+            PARSE_OPT_NOARG, apply_option_parse_space_change },
+        { OPTION_CALLBACK, 0, "ignore-whitespace", state, NULL,
+            N_("ignore changes in whitespace when finding context"),
+            PARSE_OPT_NOARG, apply_option_parse_space_change },
+        OPT_BOOL('R', "reverse", &state->apply_in_reverse,
+            N_("apply the patch in reverse")),
+        OPT_BOOL(0, "unidiff-zero", &state->unidiff_zero,
+            N_("don't expect at least one line of context")),
+        OPT_BOOL(0, "reject", &state->apply_with_reject,
+            N_("leave the rejected hunks in corresponding *.rej files")),
+        OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
+            N_("allow overlapping hunks")),
+        OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+        OPT_BIT(0, "inaccurate-eof", options,
+            N_("tolerate incorrectly detected missing new-line at the
end of file"),
+            APPLY_OPT_INACCURATE_EOF),
+        OPT_BIT(0, "recount", options,
+            N_("do not trust the line counts in the hunk headers"),
+            APPLY_OPT_RECOUNT),
+        { OPTION_CALLBACK, 0, "directory", state, N_("root"),
+            N_("prepend <root> to all filenames"),
+            0, apply_option_parse_directory },
+        OPT_END()
+    };
+
+    return parse_options(argc, argv, state->prefix,
builtin_apply_options, apply_usage, 0);
+}
diff --git a/apply.h b/apply.h
index 51a930a..27a3a7a 100644
--- a/apply.h
+++ b/apply.h
@@ -13,6 +13,12 @@ enum apply_ws_ignore {
     ignore_ws_change
 };

+enum apply_verbosity {
+    verbosity_silent = -1,
+    verbosity_normal = 0,
+    verbosity_verbose = 1,
+};
+
 /*
  * We need to keep track of how symlinks in the preimage are
  * manipulated by the patches.  A patch to add a/b/c where a/b
@@ -51,14 +57,13 @@ struct apply_state {
     int allow_overlap;
     int apply_in_reverse;
     int apply_with_reject;
-    int apply_verbosely;
-    int be_silent;
     int no_add;
     int threeway;
     int unidiff_zero;
     int unsafe_paths;

     /* Other non boolean parameters */
+    enum apply_verbosity apply_verbosity;
     const char *fake_ancestor;
     const char *patch_input_file;
     int line_termination;
@@ -116,6 +121,10 @@ extern int apply_option_parse_directory(const
struct option *opt,
 extern int apply_option_parse_space_change(const struct option *opt,
                        const char *arg, int unset);

+extern int apply_parse_options(int argc, const char **argv,
+                   struct apply_state *state,
+                   int *force_apply, int *options,
+                   const char * const *apply_usage);
 extern int init_apply_state(struct apply_state *state,
                 const char *prefix,
                 struct lock_file *lock_file);
diff --git a/builtin/am.c b/builtin/am.c
index d5fff69..54c5728 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1529,35 +1529,8 @@ static int run_apply(const struct am_state
*state, const char *index_file)
     int res, opts_left;
     char *save_index_file;
     static struct lock_file lock_file;
-
-    struct option am_apply_options[] = {
-        { OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
-            N_("detect new or modified lines that have whitespace errors"),
-            0, apply_option_parse_whitespace },
-        { OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
-            N_("ignore changes in whitespace when finding context"),
-            PARSE_OPT_NOARG, apply_option_parse_space_change },
-        { OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
-            N_("ignore changes in whitespace when finding context"),
-            PARSE_OPT_NOARG, apply_option_parse_space_change },
-        { OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
-            N_("prepend <root> to all filenames"),
-            0, apply_option_parse_directory },
-        { OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
-            N_("don't apply changes matching the given path"),
-            0, apply_option_parse_exclude },
-        { OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
-            N_("apply changes matching the given path"),
-            0, apply_option_parse_include },
-        OPT_INTEGER('C', NULL, &apply_state.p_context,
-                N_("ensure at least <n> lines of context match")),
-        { OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
-            N_("remove <num> leading slashes from traditional diff paths"),
-            0, apply_option_parse_p },
-        OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
-            N_("leave the rejected hunks in corresponding *.rej files")),
-        OPT_END()
-    };
+    int force_apply = 0;
+    int options = 0;

     if (index_file) {
         save_index_file = get_index_file();
@@ -1565,13 +1538,14 @@ static int run_apply(const struct am_state
*state, const char *index_file)
     }

     if (init_apply_state(&apply_state, NULL, &lock_file))
-        die("init_apply_state() failed");
+        die("BUG: init_apply_state() failed");

     argv_array_push(&apply_opts, "apply");
     argv_array_pushv(&apply_opts, state->git_apply_opts.argv);

-    opts_left = parse_options(apply_opts.argc, apply_opts.argv,
-                  NULL, am_apply_options, NULL, 0);
+    opts_left = apply_parse_options(apply_opts.argc, apply_opts.argv,
+                    &apply_state, &force_apply, &options,
+                    NULL);

     if (opts_left != 0)
         die("unknown option passed thru to git apply");
@@ -1586,14 +1560,14 @@ static int run_apply(const struct am_state
*state, const char *index_file)
      * errors during the initial attempt.
      */
     if (state->threeway && !index_file)
-        apply_state.be_silent = 1;
+        apply_state.apply_verbosity = verbosity_silent;

-    if (check_apply_state(&apply_state, 0))
-        die("check_apply_state() failed");
+    if (check_apply_state(&apply_state, force_apply))
+        die("BUG: check_apply_state() failed");

     argv_array_push(&apply_paths, am_path(state, "patch"));

-    res = apply_all_patches(&apply_state, apply_paths.argc,
apply_paths.argv, 0);
+    res = apply_all_patches(&apply_state, apply_paths.argc,
apply_paths.argv, options);

     if (index_file)
         set_index_file(save_index_file);
diff --git a/builtin/apply.c b/builtin/apply.c
index 066cb29..81b9a61 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "lockfile.h"
 #include "apply.h"
@@ -17,80 +18,12 @@ int cmd_apply(int argc, const char **argv, const
char *prefix)
     int ret;
     struct apply_state state;

-    struct option builtin_apply_options[] = {
-        { OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
-            N_("don't apply changes matching the given path"),
-            0, apply_option_parse_exclude },
-        { OPTION_CALLBACK, 0, "include", &state, N_("path"),
-            N_("apply changes matching the given path"),
-            0, apply_option_parse_include },
-        { OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
-            N_("remove <num> leading slashes from traditional diff paths"),
-            0, apply_option_parse_p },
-        OPT_BOOL(0, "no-add", &state.no_add,
-            N_("ignore additions made by the patch")),
-        OPT_BOOL(0, "stat", &state.diffstat,
-            N_("instead of applying the patch, output diffstat for
the input")),
-        OPT_NOOP_NOARG(0, "allow-binary-replacement"),
-        OPT_NOOP_NOARG(0, "binary"),
-        OPT_BOOL(0, "numstat", &state.numstat,
-            N_("show number of added and deleted lines in decimal notation")),
-        OPT_BOOL(0, "summary", &state.summary,
-            N_("instead of applying the patch, output a summary for
the input")),
-        OPT_BOOL(0, "check", &state.check,
-            N_("instead of applying the patch, see if the patch is
applicable")),
-        OPT_BOOL(0, "index", &state.check_index,
-            N_("make sure the patch is applicable to the current index")),
-        OPT_BOOL(0, "cached", &state.cached,
-            N_("apply a patch without touching the working tree")),
-        OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
-            N_("accept a patch that touches outside the working area")),
-        OPT_BOOL(0, "apply", &force_apply,
-            N_("also apply the patch (use with --stat/--summary/--check)")),
-        OPT_BOOL('3', "3way", &state.threeway,
-             N_( "attempt three-way merge if a patch does not apply")),
-        OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
-            N_("build a temporary index based on embedded index information")),
-        /* Think twice before adding "--nul" synonym to this */
-        OPT_SET_INT('z', NULL, &state.line_termination,
-            N_("paths are separated with NUL character"), '\0'),
-        OPT_INTEGER('C', NULL, &state.p_context,
-                N_("ensure at least <n> lines of context match")),
-        { OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
-            N_("detect new or modified lines that have whitespace errors"),
-            0, apply_option_parse_whitespace },
-        { OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
-            N_("ignore changes in whitespace when finding context"),
-            PARSE_OPT_NOARG, apply_option_parse_space_change },
-        { OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
-            N_("ignore changes in whitespace when finding context"),
-            PARSE_OPT_NOARG, apply_option_parse_space_change },
-        OPT_BOOL('R', "reverse", &state.apply_in_reverse,
-            N_("apply the patch in reverse")),
-        OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
-            N_("don't expect at least one line of context")),
-        OPT_BOOL(0, "reject", &state.apply_with_reject,
-            N_("leave the rejected hunks in corresponding *.rej files")),
-        OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
-            N_("allow overlapping hunks")),
-        OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
-        OPT_BIT(0, "inaccurate-eof", &options,
-            N_("tolerate incorrectly detected missing new-line at the
end of file"),
-            APPLY_OPT_INACCURATE_EOF),
-        OPT_BIT(0, "recount", &options,
-            N_("do not trust the line counts in the hunk headers"),
-            APPLY_OPT_RECOUNT),
-        { OPTION_CALLBACK, 0, "directory", &state, N_("root"),
-            N_("prepend <root> to all filenames"),
-            0, apply_option_parse_directory },
-        OPT_END()
-    };
-
     if (init_apply_state(&state, prefix, &lock_file))
         exit(128);

-    argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
-            apply_usage, 0);
+    argc = apply_parse_options(argc, argv,
+                   &state, &force_apply, &options,
+                   apply_usage);

     if (check_apply_state(&state, force_apply))
         exit(128);
diff --git a/environment.c b/environment.c
index 7a53799..eb23d01 100644
--- a/environment.c
+++ b/environment.c
@@ -296,6 +296,8 @@ int odb_pack_keep(char *name, size_t namesz, const
unsigned char *sha1)
  * Temporarily change the index file.
  * Please save the current index file using get_index_file() before changing
  * the index file. And when finished, reset it to the saved value.
+ * Yeah, the libification of 'apply' took a short-circuit by adding this
+ * technical debt; please do not call this function in new codepaths.
  */
 void set_index_file(char *index_file)
 {
