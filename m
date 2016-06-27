Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853872018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbcF0Sdk (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:33:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34951 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0Sdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:33:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so26996310wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:33:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z99Lu0SMDeCqQlPsr1PQ/YvLnFl1PN9gU1bWsYP22eU=;
        b=TaglfljKUQ20f2ocPe1HS35RL8FpTtOnl1stbnWtkJ7NI5HJcdhAVkABUb60qc5fgl
         2fVP8pmzoVgS+EtI/EAH5rPu61QrL0GQYU8g9MqnU1JPrW6Nab28mG02R9a6u5ZQDvDf
         4LkqzQ082Cyi+MRVK+6THxd3o93wQlLZjHgcuo81HjRR0heEdcHvNd2m0MVCX/NcvpKG
         TkGNfwjXaqCCeeKQfmvdkzdkKAvMLHr5GZijc23U7u4IkaCDoIbh1v1+Zhrdr0NGkifc
         drhGYoIP55gMerxc+0zZiHU5YWLV0muf+qknBHfD0gLkJ5B1Hg+e7O5FTmxGDPJMeIF4
         r02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z99Lu0SMDeCqQlPsr1PQ/YvLnFl1PN9gU1bWsYP22eU=;
        b=YgNCifTO22WQpWdmzTEfATbAtIH338mjSHzzm/Y5yxG6lDO7So2JTPREKTMocrcyas
         Q41E1EM+rk3n12c1k2jxjJuEjhnRMZQ95YOpHd7oq8xUG1uzMVxvwn6EZsQuAmHrT6Ig
         eLzj/Vay+N+2NeXZv8dsACpzxE6rSabviYx6YKxnK8wxSMJras68vzi3hiRJOPXHffra
         Ngz7lDwAFydVDKDDgB340hNuwA1SI7kEZq9uflV0vtTOsRjYKUUkU5v0+BDN8wRo9ITX
         ZTMsAImwS0+yoaxyyIz2GlI+246Df36TCcJV5ENG1YQvGDnLXStazl81AYDhpe2KgXyA
         iB5A==
X-Gm-Message-State: ALyK8tKMM6ZSGzp8/4XBhQbxfrAaUYRizSk6MXVIOPYOrQoWTFe4b4K0JKmgYyfXu8STetiGZ5besGDO5VqG2g==
X-Received: by 10.194.123.166 with SMTP id mb6mr2383206wjb.94.1467052417740;
 Mon, 27 Jun 2016 11:33:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Mon, 27 Jun 2016 11:33:36 -0700 (PDT)
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 27 Jun 2016 20:33:36 +0200
Message-ID: <CAP8UFD2HnDSkEcRaNPiBtuoYz=u9y4YMRc0hB0ZSJGjZxmrnMQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/41] libify apply and use lib in am, part 2
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

On Mon, Jun 27, 2016 at 8:23 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and the previous one, as a
> reply to this email.

Here is the diff:

diff --git a/apply.c b/apply.c
index 777798a..2ac22d3 100644
--- a/apply.c
+++ b/apply.c
@@ -1516,8 +1516,8 @@ static int parse_fragment_header(const char
*line, int len, struct fragment *fra
  * Find file diff header
  *
  * Returns:
- *  -1 in case of error
- *  -2 if no header was found
+ *  -1 if no header was found
+ *  -128 in case of error
  *   the size of the header in bytes (called "offset") otherwise
  */
 static int find_header(struct apply_state *state,
@@ -1553,8 +1553,9 @@ static int find_header(struct apply_state *state,
                        struct fragment dummy;
                        if (parse_fragment_header(line, len, &dummy) < 0)
                                continue;
-                       return error(_("patch fragment without header
at line %d: %.*s"),
+                       error(_("patch fragment without header at line
%d: %.*s"),
                                     state->linenr, (int)len-1, line);
+                       return -128;
                }

                if (size < len + 6)
@@ -1567,23 +1568,27 @@ static int find_header(struct apply_state *state,
                if (!memcmp("diff --git ", line, 11)) {
                        int git_hdr_len = parse_git_header(state,
line, len, size, patch);
                        if (git_hdr_len < 0)
-                               return -1;
+                               return -128;
                        if (git_hdr_len <= len)
                                continue;
                        if (!patch->old_name && !patch->new_name) {
-                               if (!patch->def_name)
-                                       return error(Q_("git diff
header lacks filename information when removing "
+                               if (!patch->def_name) {
+                                       error(Q_("git diff header
lacks filename information when removing "
                                                        "%d leading
pathname component (line %d)",
                                                        "git diff
header lacks filename information when removing "
                                                        "%d leading
pathname components (line %d)",
                                                        state->p_value),
                                                     state->p_value,
state->linenr);
+                                       return -128;
+                               }
                                patch->old_name = xstrdup(patch->def_name);
                                patch->new_name = xstrdup(patch->def_name);
                        }
-                       if (!patch->is_delete && !patch->new_name)
-                               return error("git diff header lacks
filename information "
+                       if (!patch->is_delete && !patch->new_name) {
+                               error("git diff header lacks filename
information "
                                             "(line %d)", state->linenr);
+                               return -128;
+                       }
                        patch->is_toplevel_relative = 1;
                        *hdrsize = git_hdr_len;
                        return offset;
@@ -1604,12 +1609,12 @@ static int find_header(struct apply_state *state,

                /* Ok, we'll consider it a patch */
                if (parse_traditional_patch(state, line, line+len, patch))
-                       return -1;
+                       return -128;
                *hdrsize = len + nextlen;
                state->linenr += 2;
                return offset;
        }
-       return -2;
+       return -1;
 }

 static void record_ws_error(struct apply_state *state,
@@ -2100,8 +2105,8 @@ static int use_patch(struct apply_state *state,
struct patch *p)
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
  *
  * Returns:
- *   -1 on error,
- *   -2 if no header was found,
+ *   -1 if no header was found or parse_binary() failed,
+ *   -128 on another error,
  *   the number of bytes consumed otherwise,
  *     so that the caller can call us again for the next patch.
  */
@@ -2128,7 +2133,7 @@ static int parse_chunk(struct apply_state
*state, char *buffer, unsigned long si
                                       patch);

        if (patchsize < 0)
-               return -1;
+               return -128;

        if (!patchsize) {
                static const char git_binary[] = "GIT binary patch\n";
@@ -2172,8 +2177,10 @@ static int parse_chunk(struct apply_state
*state, char *buffer, unsigned long si
                 * empty to us here.
                 */
                if ((state->apply || state->check) &&
-                   (!patch->is_binary && !metadata_changes(patch)))
-                       return error(_("patch with only garbage at
line %d"), state->linenr);
+                   (!patch->is_binary && !metadata_changes(patch))) {
+                       error(_("patch with only garbage at line %d"),
state->linenr);
+                       return -128;
+               }
        }

        return offset + hdrsize + patchsize;
@@ -3781,11 +3788,11 @@ static void prepare_symlink_changes(struct
apply_state *state, struct patch *pat
                if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
                    (patch->is_rename || patch->is_delete))
                        /* the symlink at patch->old_name is removed */
-                       register_symlink_changes(state,
patch->old_name, SYMLINK_GOES_AWAY);
+                       register_symlink_changes(state,
patch->old_name, APPLY_SYMLINK_GOES_AWAY);

                if (patch->new_name && S_ISLNK(patch->new_mode))
                        /* the symlink at patch->new_name is created
or remains */
-                       register_symlink_changes(state,
patch->new_name, SYMLINK_IN_RESULT);
+                       register_symlink_changes(state,
patch->new_name, APPLY_SYMLINK_IN_RESULT);
        }
 }

@@ -3800,9 +3807,9 @@ static int path_is_beyond_symlink_1(struct
apply_state *state, struct strbuf *na
                        break;
                name->buf[name->len] = '\0';
                change = check_symlink_changes(state, name->buf);
-               if (change & SYMLINK_IN_RESULT)
+               if (change & APPLY_SYMLINK_IN_RESULT)
                        return 1;
-               if (change & SYMLINK_GOES_AWAY)
+               if (change & APPLY_SYMLINK_GOES_AWAY)
                        /*
                         * This cannot be "return 0", because we may
                         * see a new one created at a higher level.
@@ -3944,7 +3951,7 @@ static int check_patch(struct apply_state
*state, struct patch *patch)
        }

        if (!state->unsafe_paths && check_unsafe_path(patch))
-               return -1;
+               return -128;

        /*
         * An attempt to read from or delete a path that is beyond a
@@ -3972,10 +3979,14 @@ static int check_patch_list(struct apply_state
*state, struct patch *patch)
        prepare_symlink_changes(state, patch);
        prepare_fn_table(state, patch);
        while (patch) {
+               int res;
                if (state->apply_verbosely)
                        say_patch_name(stderr,
                                       _("Checking patch %s..."), patch);
-               err |= check_patch(state, patch);
+               res = check_patch(state, patch);
+               if (res == -128)
+                       return -128;
+               err |= res;
                patch = patch->next;
        }
        return err;
@@ -4597,9 +4608,10 @@ static int write_out_results(struct apply_state
*state, struct patch *list)
  * Try to apply a patch.
  *
  * Returns:
- *  -1 if an error happened
+ *  -128 if a bad error happened (like patch unreadable)
+ *  -1 if patch did not apply and user cannot deal with it
  *   0 if the patch applied
- *   1 if the patch did not apply
+ *   1 if the patch did not apply but user might fix it
  */
 static int apply_patch(struct apply_state *state,
                       int fd,
@@ -4614,7 +4626,7 @@ static int apply_patch(struct apply_state *state,

        state->patch_input_file = filename;
        if (read_patch_file(&buf, fd))
-               return -1;
+               return -128;
        offset = 0;
        while (offset < buf.len) {
                struct patch *patch;
@@ -4626,8 +4638,8 @@ static int apply_patch(struct apply_state *state,
                nr = parse_chunk(state, buf.buf + offset, buf.len -
offset, patch);
                if (nr < 0) {
                        free_patch(patch);
-                       if (nr == -1) {
-                               res = -1;
+                       if (nr == -128) {
+                               res = -128;
                                goto end;
                        }
                        break;
@@ -4649,7 +4661,8 @@ static int apply_patch(struct apply_state *state,
        }

        if (!list && !skipped_patch) {
-               res = error(_("unrecognized input"));
+               error(_("unrecognized input"));
+               res = -128;
                goto end;
        }

@@ -4661,21 +4674,27 @@ static int apply_patch(struct apply_state *state,
                state->newfd = hold_locked_index(state->lock_file, 1);

        if (state->check_index && read_cache() < 0) {
-               res = error(_("unable to read index file"));
+               error(_("unable to read index file"));
+               res = -128;
                goto end;
        }

-       if ((state->check || state->apply) &&
-           check_patch_list(state, list) < 0 &&
-           !state->apply_with_reject) {
-               res = -1;
-               goto end;
+       if (state->check || state->apply) {
+               int r = check_patch_list(state, list);
+               if (r == -128) {
+                       res = -128;
+                       goto end;
+               }
+               if (r < 0 && !state->apply_with_reject) {
+                       res = -1;
+                       goto end;
+               }
        }

        if (state->apply) {
                int write_res = write_out_results(state, list);
                if (write_res < 0) {
-                       res = -1;
+                       res = -128;
                        goto end;
                }
                if (write_res > 0) {
@@ -4687,7 +4706,7 @@ static int apply_patch(struct apply_state *state,

        if (state->fake_ancestor &&
            build_fake_ancestor(list, state->fake_ancestor)) {
-               res = -1;
+               res = -128;
                goto end;
        }

@@ -4772,7 +4791,6 @@ int apply_all_patches(struct apply_state *state,
 {
        int i;
        int res;
-       int retval = -1;
        int errs = 0;
        int read_stdin = 1;

@@ -4783,7 +4801,7 @@ int apply_all_patches(struct apply_state *state,
                if (!strcmp(arg, "-")) {
                        res = apply_patch(state, 0, "<stdin>", options);
                        if (res < 0)
-                               goto rollback_end;
+                               goto end;
                        errs |= res;
                        read_stdin = 0;
                        continue;
@@ -4795,21 +4813,22 @@ int apply_all_patches(struct apply_state *state,
                fd = open(arg, O_RDONLY);
                if (fd < 0) {
                        error(_("can't open patch '%s': %s"), arg,
strerror(errno));
-                       goto rollback_end;
+                       res = -128;
+                       goto end;
                }
                read_stdin = 0;
                set_default_whitespace_mode(state);
                res = apply_patch(state, fd, arg, options);
                close(fd);
                if (res < 0)
-                       goto rollback_end;
+                       goto end;
                errs |= res;
        }
        set_default_whitespace_mode(state);
        if (read_stdin) {
                res = apply_patch(state, 0, "<stdin>", options);
                if (res < 0)
-                       goto rollback_end;
+                       goto end;
                errs |= res;
        }

@@ -4828,7 +4847,8 @@ int apply_all_patches(struct apply_state *state,
                                 "%d lines add whitespace errors.",
                                 state->whitespace_error),
                              state->whitespace_error);
-                       goto rollback_end;
+                       res = -128;
+                       goto end;
                }
                if (state->applied_after_fixing_ws && state->apply)
                        warning("%d line%s applied after"
@@ -4846,14 +4866,15 @@ int apply_all_patches(struct apply_state *state,
                res = write_locked_index(&the_index, state->lock_file,
COMMIT_LOCK);
                if (res) {
                        error(_("Unable to write new index file"));
-                       goto rollback_end;
+                       res = -128;
+                       goto end;
                }
                state->newfd = -1;
        }

-       retval = !!errs;
+       res = !!errs;

-rollback_end:
+end:
        if (state->newfd >= 0) {
                rollback_lock_file(state->lock_file);
                state->newfd = -1;
@@ -4864,5 +4885,7 @@ rollback_end:
                set_warn_routine(state->saved_warn_routine);
        }

-       return retval;
+       if (res > -1)
+               return res;
+       return (res == -1 ? 1 : 128);
 }
diff --git a/apply.h b/apply.h
index c6cf33d..51a930a 100644
--- a/apply.h
+++ b/apply.h
@@ -1,14 +1,14 @@
 #ifndef APPLY_H
 #define APPLY_H

-enum ws_error_action {
+enum apply_ws_error_action {
        nowarn_ws_error,
        warn_on_ws_error,
        die_on_ws_error,
        correct_ws_error
 };

-enum ws_ignore {
+enum apply_ws_ignore {
        ignore_ws_none,
        ignore_ws_change
 };
@@ -24,8 +24,8 @@ enum ws_ignore {
  * See also "struct string_list symlink_changes" in "struct
  * apply_state".
  */
-#define SYMLINK_GOES_AWAY 01
-#define SYMLINK_IN_RESULT 02
+#define APPLY_SYMLINK_GOES_AWAY 01
+#define APPLY_SYMLINK_IN_RESULT 02

 struct apply_state {
        const char *prefix;
@@ -94,8 +94,8 @@ struct apply_state {
        void (*saved_warn_routine)(const char *warn, va_list params);

        /* These control whitespace errors */
-       enum ws_error_action ws_error_action;
-       enum ws_ignore ws_ignore_action;
+       enum apply_ws_error_action ws_error_action;
+       enum apply_ws_ignore ws_ignore_action;
        const char *whitespace_option;
        int whitespace_error;
        int squelch_whitespace_errors;
diff --git a/builtin/apply.c b/builtin/apply.c
index ddd61de..066cb29 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -87,13 +87,13 @@ int cmd_apply(int argc, const char **argv, const
char *prefix)
        };

        if (init_apply_state(&state, prefix, &lock_file))
-               exit(1);
+               exit(128);

        argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
                        apply_usage, 0);

        if (check_apply_state(&state, force_apply))
-               exit(1);
+               exit(128);

        ret = apply_all_patches(&state, argc, argv, options);
