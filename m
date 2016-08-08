Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF382018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbcHHVX1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:23:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33482 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbcHHVX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:23:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17954988wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:23:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G8E0COad/aU+nmwEwRoqDrqNPRd2nLpVlTHvnikVil8=;
        b=aahFhLU7PTvH0rSr1doLDAkBMeO2tzoCePFByd2KkZncB4YuON1EB+XjSIS5bQ7r/X
         hdAhWZmDnKdPfVP/IdU7wS0Nq4wkhIURIuBRaJQqKWZMR9jixG50AES1quroYIVLT/Jw
         tFgKQVRtl+BZK18Wa+r+6Bfpq7qaeJlUCZ/WVvrialAJMTMpnZeuZTNM/qjF6QffnYSJ
         vEj+UScnQ5sprhJHFsEBR94sDvq2ERavL2PAAtxivA0ciXV49wIADxOkAk32XYM1tv+z
         /KIsXxk8TL6wv+I3615E39n7qXo/JOoH6bNnm6d1PcAKrRB0d8XVkZYZFGFtFFptyUJN
         8ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G8E0COad/aU+nmwEwRoqDrqNPRd2nLpVlTHvnikVil8=;
        b=hNZKArt7pYiDr8r6rNDpxKNGiltNuh5KKGAmVKjtX2bAi3H9frTc+fduBLClLhHYdL
         u4ond2V0oYOgHhu9c1JKv2nOEey/arc8JbG+x/oGf6mVbvbjEiYWkLywdObIxRG24O9G
         Sz7CXQr/0QR6EJa92ey9tlzIDdzRlDKQdvjpBiv4n77XfvFwy6AaNjiMVO3wVtMC2neH
         uF+tz+6okX9j9h3BFqZQOjZ/JRJlTEKINTfUwTMIJqBZ4HZAAqM1BlNuQB8k2S6vhCBk
         T0ykjQWrmcUSeXrf1InmmP+r7Gfdcj+64seiTPACOSj70gY++VNO+QrG5WZMOIPQPUxy
         0Vxg==
X-Gm-Message-State: AEkoous7y+rs/PXEjRcpPdUiqwmbhNQW/39qtCqMKbBzh53VQAkzNQS8jiM9g8TBe8whRhphOER7LkC8Jz9+mg==
X-Received: by 10.194.38.9 with SMTP id c9mr23862971wjk.78.1470691405141; Mon,
 08 Aug 2016 14:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 8 Aug 2016 14:23:24 -0700 (PDT)
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 8 Aug 2016 23:23:24 +0200
Message-ID: <CAP8UFD2t9PaC8hONJJuG2EUU=0NMUC1BaDDD2Hr0u21K5rhZ3Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/40] libify apply and use lib in am, part 2
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

On Mon, Aug 8, 2016 at 11:02 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and the previous one, as a
> reply to this email.

Here is the diff:

diff --git a/apply.c b/apply.c
index a73889e..2ec2a8a 100644
--- a/apply.c
+++ b/apply.c
@@ -4324,7 +4324,10 @@ static int try_create_file(const char *path,
unsigned int mode, const char *buf,
         size = nbuf.len;
         buf  = nbuf.buf;
     }
-    res = !write_or_whine_pipe(fd, buf, size, path);
+
+    res = write_in_full(fd, buf, size) < 0;
+    if (res)
+        error_errno(_("failed to write to '%s'"), path);
     strbuf_release(&nbuf);

     if (close(fd) < 0 && !res)
@@ -4626,7 +4629,7 @@ static int apply_patch(struct apply_state *state,
     int res = 0;

     state->patch_input_file = filename;
-    if (read_patch_file(&buf, fd))
+    if (read_patch_file(&buf, fd) < 0)
         return -128;
     offset = 0;
     while (offset < buf.len) {
@@ -4727,16 +4730,16 @@ static int apply_patch(struct apply_state *state,
     return res;
 }

-int apply_option_parse_exclude(const struct option *opt,
-                   const char *arg, int unset)
+static int apply_option_parse_exclude(const struct option *opt,
+                      const char *arg, int unset)
 {
     struct apply_state *state = opt->value;
     add_name_limit(state, arg, 1);
     return 0;
 }

-int apply_option_parse_include(const struct option *opt,
-                   const char *arg, int unset)
+static int apply_option_parse_include(const struct option *opt,
+                      const char *arg, int unset)
 {
     struct apply_state *state = opt->value;
     add_name_limit(state, arg, 0);
@@ -4744,9 +4747,9 @@ int apply_option_parse_include(const struct option *opt,
     return 0;
 }

-int apply_option_parse_p(const struct option *opt,
-             const char *arg,
-             int unset)
+static int apply_option_parse_p(const struct option *opt,
+                const char *arg,
+                int unset)
 {
     struct apply_state *state = opt->value;
     state->p_value = atoi(arg);
@@ -4754,8 +4757,8 @@ int apply_option_parse_p(const struct option *opt,
     return 0;
 }

-int apply_option_parse_space_change(const struct option *opt,
-                    const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+                       const char *arg, int unset)
 {
     struct apply_state *state = opt->value;
     if (unset)
@@ -4765,8 +4768,8 @@ int apply_option_parse_space_change(const struct
option *opt,
     return 0;
 }

-int apply_option_parse_whitespace(const struct option *opt,
-                  const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+                     const char *arg, int unset)
 {
     struct apply_state *state = opt->value;
     state->whitespace_option = arg;
@@ -4775,8 +4778,8 @@ int apply_option_parse_whitespace(const struct
option *opt,
     return 0;
 }

-int apply_option_parse_directory(const struct option *opt,
-                 const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+                    const char *arg, int unset)
 {
     struct apply_state *state = opt->value;
     strbuf_reset(&state->root);
diff --git a/apply.h b/apply.h
index 27a3a7a..e2b89e8 100644
--- a/apply.h
+++ b/apply.h
@@ -16,7 +16,7 @@ enum apply_ws_ignore {
 enum apply_verbosity {
     verbosity_silent = -1,
     verbosity_normal = 0,
-    verbosity_verbose = 1,
+    verbosity_verbose = 1
 };

 /*
@@ -94,7 +94,11 @@ struct apply_state {
      */
     struct string_list fn_table;

-    /* This is to save some reporting routines */
+    /*
+     * This is to save reporting routines before using
+     * set_error_routine() or set_warn_routine() to install muting
+     * routines when in verbosity_silent mode.
+     */
     void (*saved_error_routine)(const char *err, va_list params);
     void (*saved_warn_routine)(const char *warn, va_list params);

@@ -107,20 +111,6 @@ struct apply_state {
     int applied_after_fixing_ws;
 };

-extern int apply_option_parse_exclude(const struct option *opt,
-                      const char *arg, int unset);
-extern int apply_option_parse_include(const struct option *opt,
-                      const char *arg, int unset);
-extern int apply_option_parse_p(const struct option *opt,
-                const char *arg,
-                int unset);
-extern int apply_option_parse_whitespace(const struct option *opt,
-                     const char *arg, int unset);
-extern int apply_option_parse_directory(const struct option *opt,
-                    const char *arg, int unset);
-extern int apply_option_parse_space_change(const struct option *opt,
-                       const char *arg, int unset);
-
 extern int apply_parse_options(int argc, const char **argv,
                    struct apply_state *state,
                    int *force_apply, int *options,
diff --git a/cache.h b/cache.h
index 18b96fe..c9ad7f9 100644
--- a/cache.h
+++ b/cache.h
@@ -461,7 +461,6 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
-extern void set_index_file(char *index_file);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
@@ -472,6 +471,19 @@ extern const char *strip_namespace(const char
*namespaced_ref);
 extern const char *get_git_work_tree(void);

 /*
+ * Hack to temporarily change the index.
+ * Yeah, the libification of 'apply' took a short-circuit by adding
+ * this technical debt.
+ * Please use functions available when
+ * NO_THE_INDEX_COMPATIBILITY_MACROS is defined, instead of this
+ * function.
+ * If you really need to use this function, please save the current
+ * index file using get_index_file() before changing the index
+ * file. And when finished, reset it to the saved value.
+ */
+extern void set_index_file(char *index_file);
+
+/*
  * Return true if the given path is a git directory; note that this _just_
  * looks at the directory itself. If you want to know whether "foo/.git"
  * is a repository, you must feed that path, not just "foo".
diff --git a/environment.c b/environment.c
index eb23d01..55b2b6b 100644
--- a/environment.c
+++ b/environment.c
@@ -293,11 +293,15 @@ int odb_pack_keep(char *name, size_t namesz,
const unsigned char *sha1)
 }

 /*
- * Temporarily change the index file.
- * Please save the current index file using get_index_file() before changing
- * the index file. And when finished, reset it to the saved value.
- * Yeah, the libification of 'apply' took a short-circuit by adding this
- * technical debt; please do not call this function in new codepaths.
+ * Hack to temporarily change the index.
+ * Yeah, the libification of 'apply' took a short-circuit by adding
+ * this technical debt.
+ * Please use functions available when
+ * NO_THE_INDEX_COMPATIBILITY_MACROS is defined, instead of this
+ * function.
+ * If you really need to use this function, please save the current
+ * index file using get_index_file() before changing the index
+ * file. And when finished, reset it to the saved value.
  */
 void set_index_file(char *index_file)
 {
diff --git a/write_or_die.c b/write_or_die.c
index 26eeec8..9816879 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,7 +87,8 @@ int write_or_whine_pipe(int fd, const void *buf,
size_t count, const char *msg)
 {
     if (write_in_full(fd, buf, count) < 0) {
         check_pipe(errno);
-        warning("%s: write error (%s)\n", msg, strerror(errno));
+        fprintf(stderr, "%s: write error (%s)\n",
+            msg, strerror(errno));
         return 0;
     }
