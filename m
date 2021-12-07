Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15076C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbhLGSaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbhLGSaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC0C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso2414280wms.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iym60S0qXyTgAvuOhVslb71oiMgHgcq1pihkSy6GHKs=;
        b=d47WFlmdfo6S5l7TkeewlsSnnernQ3n1AnMopkJjF5vLRRTzB9uxVGnHZqSsc0NR8m
         4WL+6SrsNBOHRnyv3Q2k+l+WZ6nl5tR/wgyhWgN7xW0kA1bfQJeREUaWyNDOJLqg7qJ9
         SxYtfARFotZh/m64O42HFFEGB9A+i4zHXpKWnHfMOTpxH8LieaiVo5WOpPnSnsQOaOIh
         JQ4iIAiRzAJdFB1iJH0VRJBRvd2WTYoTsYCVbLXnW5sY2ryjCzmVRln5O08OlimcgH9n
         GR/KbJOVYnb3LjsQdfjrEPQBpCIBnseTtCrq6r2h0+RwfqWceciWwGfjAaP6ARKwyDpV
         GkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iym60S0qXyTgAvuOhVslb71oiMgHgcq1pihkSy6GHKs=;
        b=Wvmm1SzjKartgc/r1DN1zFBDPp4Js25ML5tbuj6Uiq5MRVKO8XaQQXSNl/wTz6vxMy
         xSUbNtQobbqSe4T/zuoEKkqhe+v/f1F3y8P7LGMqbnDNadnntrJzpSaIxVgc2Rj8zFie
         faQ9bT93SOX0yXiJP5wsqu+34uW6syDE2Jd9j77Kh1v7Vuw+5ccXu86+VudPF07NSHJc
         jX0Y5Okl+3zLizX9IDH+GytxcUrOojcKhAsH9bMuxdRxvJgu+lF7LJwmVj6zV48arxLt
         KIo841rU3qhVt+HwcxzgGtPNong18J2wzzGzIxyLiuSgaf8INoW6buF5nbb+uQr45BUu
         nGkQ==
X-Gm-Message-State: AOAM531dGo6uqRHVckBdMYbyR1tHVei61WlSVEk45GQipnMfAuEa3hhN
        PAehni4bqWDCuTriaQdh2Tt2Xl7R/8xOYA==
X-Google-Smtp-Source: ABdhPJxAuw8YoHLfp9J7m1lsj84n9X20jdT/wN5KKpvjBBJhdmI0yDl/j9jMcIgHXd9JNkqMVnBqzw==
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr9110039wmj.14.1638901596899;
        Tue, 07 Dec 2021 10:26:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] usage API: Add and use die_message()
Date:   Tue,  7 Dec 2021 19:26:28 +0100
Message-Id: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small set of fixes to usage.[ch]'s API use that will go towards
enabling nicer things down the road. See [1] for the v1 summary

I believe this should address all the feedback Junio had on the
v1.

Aside from the substantially rewritten 6/6 and much simplified 4/6 the
end-state is almost the same, but things are better split up,
explained etc. now.

1. https://lore.kernel.org/git/cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  usage.c: add a die_message() routine
  usage.c API users: use die_message() for "fatal :" + exit 128
  usage.c API users: use die_message() for error() + exit 128
  gc: return from cmd_gc(), don't call exit()
  usage.c + gc: add and use a die_message_errno()
  config API: use get_error_routine(), not vreportf()

 builtin/fast-import.c | 12 +++++++-----
 builtin/gc.c          | 14 ++++++++------
 builtin/notes.c       |  9 +++++----
 config.c              |  3 ++-
 git-compat-util.h     |  4 +++-
 http-backend.c        |  3 ++-
 parse-options.c       |  2 +-
 run-command.c         | 16 +++++-----------
 usage.c               | 42 ++++++++++++++++++++++++++++++++++++++----
 9 files changed, 71 insertions(+), 34 deletions(-)

Range-diff against v1:
1:  5a9ab85fa56 ! 1:  65ae6fe7cbe usage.c: add a die_message() routine
    @@ Commit message
         this is so that caller can pass the return value to "exit()", instead
         of having to hardcode "exit(128)".
     
    -    A subsequent commit will migrate various callers that benefit from
    -    this function over to it. For now we're just adding the routine and
    -    making die_builtin() in usage.c itself use it.
    +    Note that as with the other routines the "die_message_builtin" needs
    +    to return "void" and otherwise conform to the "report_fn"
    +    signature.
    +
    +    As we'll see in a subsequent commit callers will want to replace
    +    e.g. their default "die_routine" with a "die_message_routine".
    +
    +    For now we're just adding the routine and making die_builtin() in
    +    usage.c itself use it. In order to do that we need to add a
    +    get_die_message_routine() function, which works like the other
    +    get_*_routine() functions in usage.c. There is no
    +    set_die_message_rotine(), as it hasn't been needed yet. We can add it
    +    if we ever need it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ git-compat-util.h: NORETURN void usage(const char *err);
      int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
      int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
      void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
    +@@ git-compat-util.h: static inline int const_error(void)
    + typedef void (*report_fn)(const char *, va_list params);
    + 
    + void set_die_routine(NORETURN_PTR report_fn routine);
    ++report_fn get_die_message_routine(void);
    + void set_error_routine(report_fn routine);
    + report_fn get_error_routine(void);
    + void set_warn_routine(report_fn routine);
     
      ## usage.c ##
     @@ usage.c: static NORETURN void usage_builtin(const char *err, va_list params)
    @@ usage.c: static NORETURN void usage_builtin(const char *err, va_list params)
     -	trace2_cmd_error_va(err, params);
     -
     -	vreportf("fatal: ", err, params);
    --
    -+	die_message_builtin(err, params);
    ++	report_fn die_message_fn = get_die_message_routine();
    + 
    ++	die_message_fn(err, params);
      	exit(128);
      }
      
    +@@ usage.c: static int die_is_recursing_builtin(void)
    +  * (ugh), so keep things static. */
    + static NORETURN_PTR report_fn usage_routine = usage_builtin;
    + static NORETURN_PTR report_fn die_routine = die_builtin;
    ++static report_fn die_message_routine = die_message_builtin;
    + static report_fn error_routine = error_builtin;
    + static report_fn warn_routine = warn_builtin;
    + static int (*die_is_recursing)(void) = die_is_recursing_builtin;
    +@@ usage.c: void set_die_routine(NORETURN_PTR report_fn routine)
    + 	die_routine = routine;
    + }
    + 
    ++report_fn get_die_message_routine(void)
    ++{
    ++	return die_message_routine;
    ++}
    ++
    + void set_error_routine(report_fn routine)
    + {
    + 	error_routine = routine;
     @@ usage.c: void NORETURN die_errno(const char *fmt, ...)
      	va_end(params);
      }
    @@ usage.c: void NORETURN die_errno(const char *fmt, ...)
     +	va_list params;
     +
     +	va_start(params, err);
    -+	die_message_builtin(err, params);
    ++	die_message_routine(err, params);
     +	va_end(params);
     +	return 128;
     +}
2:  36c050c90c2 ! 2:  f5a98901498 usage.c API users: use die_message() where appropriate
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    usage.c API users: use die_message() where appropriate
    +    usage.c API users: use die_message() for "fatal :" + exit 128
     
    -    Change code that either called error() and proceeded to exit with 128,
    -    or emitted its own "fatal: " messages to use the die_message()
    -    function added in a preceding commit.
    +    Change code that printed its own "fatal: " message and exited with a
    +    status code of 128 to use the die_message() function added in a
    +    preceding commit.
     
    -    In order to do that we need to add a get_die_message_routine()
    -    function, which works like the other get_*_routine() functions in
    -    usage.c. There is no set_die_message_rotine(), as it hasn't been
    -    needed yet. We can add it if we ever need it.
    +    This change also demonstrates why the return value of
    +    die_message_routine() needed to be that of "report_fn". We have
    +    callers such as the run-command.c::child_err_spew() which would like
    +    to replace its error routine with the return value of
    +    "get_die_message_routine()".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fast-import.c: static void dump_marks(void);
      		end_packfile();
      		unkeep_all_packs();
     
    - ## builtin/notes.c ##
    -@@ builtin/notes.c: static void prepare_note_data(const struct object_id *object, struct note_data *
    - static void write_note_data(struct note_data *d, struct object_id *oid)
    - {
    - 	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
    --		error(_("unable to write note object"));
    -+		int status = die_message(_("unable to write note object"));
    -+
    - 		if (d->edit_path)
    --			error(_("the note contents have been left in %s"),
    --				d->edit_path);
    --		exit(128);
    -+			die_message(_("the note contents have been left in %s"),
    -+				    d->edit_path);
    -+		exit(status);
    - 	}
    - }
    - 
    -
    - ## git-compat-util.h ##
    -@@ git-compat-util.h: static inline int const_error(void)
    - typedef void (*report_fn)(const char *, va_list params);
    - 
    - void set_die_routine(NORETURN_PTR report_fn routine);
    -+report_fn get_die_message_routine(void);
    - void set_error_routine(report_fn routine);
    - report_fn get_error_routine(void);
    - void set_warn_routine(report_fn routine);
    -
      ## http-backend.c ##
     @@ http-backend.c: static NORETURN void die_webcgi(const char *err, va_list params)
      {
    @@ run-command.c: static void *run_thread(void *data)
      
      	if (in_async()) {
      		struct async *async = pthread_getspecific(async_key);
    -
    - ## usage.c ##
    -@@ usage.c: static void die_message_builtin(const char *err, va_list params)
    -  */
    - static NORETURN void die_builtin(const char *err, va_list params)
    - {
    --	die_message_builtin(err, params);
    -+	report_fn die_message_fn = get_die_message_routine();
    -+
    -+	die_message_fn(err, params);
    - 	exit(128);
    - }
    - 
    -@@ usage.c: static int die_is_recursing_builtin(void)
    -  * (ugh), so keep things static. */
    - static NORETURN_PTR report_fn usage_routine = usage_builtin;
    - static NORETURN_PTR report_fn die_routine = die_builtin;
    -+static report_fn die_message_routine = die_message_builtin;
    - static report_fn error_routine = error_builtin;
    - static report_fn warn_routine = warn_builtin;
    - static int (*die_is_recursing)(void) = die_is_recursing_builtin;
    -@@ usage.c: void set_die_routine(NORETURN_PTR report_fn routine)
    - 	die_routine = routine;
    - }
    - 
    -+report_fn get_die_message_routine(void)
    -+{
    -+	return die_message_routine;
    -+}
    -+
    - void set_error_routine(report_fn routine)
    - {
    - 	error_routine = routine;
    -@@ usage.c: int die_message(const char *err, ...)
    - 	va_list params;
    - 
    - 	va_start(params, err);
    --	die_message_builtin(err, params);
    -+	die_message_routine(err, params);
    - 	va_end(params);
    - 	return 128;
    - }
-:  ----------- > 3:  c7d67fd41fa usage.c API users: use die_message() for error() + exit 128
-:  ----------- > 4:  f224a281a10 gc: return from cmd_gc(), don't call exit()
3:  8747afecdcd ! 5:  2b4a3910654 usage.c + gc: add and use a die_message_errno()
    @@ Metadata
      ## Commit message ##
         usage.c + gc: add and use a die_message_errno()
     
    -    Change code the "error: " output when we exit with 128 due to gc.log
    -    errors to use a "fatal: " prefix instead. This adds a sibling function
    -    to the die_errno() added in a preceding commit.
    +    Change the "error: " output when we exit with 128 due to gc.log errors
    +    to use a "fatal: " prefix instead. To do this add a
    +    die_message_errno() a sibling function to the die_errno() added in a
    +    preceding commit.
     
    -    Since it returns 128 instead of -1 (like die_message()) we'll need to
    -    adjust report_last_gc_error().
    +    Before this we'd expect report_last_gc_error() to return -1 from
    +    error_errno() in this case. It already treated a status of 0 and 1
    +    specially. Let's just document that anything that's not 0 or 1 should
    +    be returned.
     
    -    Let's adjust it while we're at it to not conflate the "should skip"
    -    and "exit with this non-zero code" conditions, as the caller is no
    -    longer hardcoding "128", but relying on die_errno() to return a
    -    nen-zero exit() status.
    -
    -    Since we're touching this code let's also use "return ret" in place of
    -    an "exit(ret)". This is kinder to any cleanup our our "cmd_main()" in
    -    "git.c" might want to do.
    +    We could also retain the "ret < 0" behavior here without hardcoding
    +    128 by returning -128, and having the caller do a "return -ret", but I
    +    think this makes more sense, and preserves the path from
    +    die_message*()'s return value to the "return" without hardcoding
    +    "128".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
    + /*
    +  * Returns 0 if there was no previous error and gc can proceed, 1 if
       * gc should not proceed due to an error in the last run. Prints a
    -  * message and returns -1 if an error occurred while reading gc.log
    +- * message and returns -1 if an error occurred while reading gc.log
    ++ * message and returns with a non-[01] status code if an error occurred
    ++ * while reading gc.log
       */
    --static int report_last_gc_error(void)
    -+static int report_last_gc_error(int *skip)
    + static int report_last_gc_error(void)
      {
    - 	struct strbuf sb = STRBUF_INIT;
    - 	int ret = 0;
    - 	ssize_t len;
    - 	struct stat st;
    - 	char *gc_log_path = git_pathdup("gc.log");
    -+	*skip = 0;
    - 
    - 	if (stat(gc_log_path, &st)) {
    +@@ builtin/gc.c: static int report_last_gc_error(void)
      		if (errno == ENOENT)
      			goto done;
      
    @@ builtin/gc.c: static int report_last_gc_error(void)
      	else if (len > 0) {
      		/*
      		 * A previous gc failed.  Report the error, and don't
    -@@ builtin/gc.c: static int report_last_gc_error(void)
    - 			       "until the file is removed.\n\n"
    - 			       "%s"),
    - 			    gc_log_path, sb.buf);
    --		ret = 1;
    -+		*skip = 1;
    - 	}
    - 	strbuf_release(&sb);
    - done:
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
    - 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
    - 		}
      		if (detach_auto) {
    --			int ret = report_last_gc_error();
    + 			int ret = report_last_gc_error();
    + 
     -			if (ret < 0)
     -				/* an I/O error occurred, already reported */
    --				exit(128);
    --			if (ret == 1)
    -+			int skip;
    -+			int ret = report_last_gc_error(&skip);
    -+
    -+			if (skip)
    +-				return 128;
    + 			if (ret == 1)
      				/* Last gc --auto failed. Skip this one. */
      				return 0;
    -+			if (ret)
    ++			else if (ret)
     +				/* an I/O error occurred, already reported */
     +				return ret;
      
4:  e0e6427cbd3 ! 6:  42132406731 config API: don't use vreportf(), make it static in usage.c
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    config API: don't use vreportf(), make it static in usage.c
    +    config API: use get_error_routine(), not vreportf()
     
    -    In preceding commits the rest of the vreportf() users outside of
    -    usage.c have been migrated to die_message(), leaving only the
    -    git_die_config() function added in 5a80e97c827 (config: add
    -    `git_die_config()` to the config-set API, 2014-08-07).
    -
    -    Let's have its callers call error() themselves if they want to emit a
    -    message, which is exactly what git_die_config() was doing for them
    -    before emitting its own die() message.
    +    Change the git_die_config() function added in 5a80e97c827 (config: add
    +    `git_die_config()` to the config-set API, 2014-08-07) to use the
    +    public callbacks in the usage.[ch] API instead of the the underlying
    +    vreportf() function.
     
    -    This means that we can make the vreportf() in usage.c "static", and
    -    only expose functions such as usage(), die(), warning() etc.
    +    In preceding commits the rest of the vreportf() users outside of
    +    usage.c was migrated to die_message(), so we can now make it "static".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/fast-import.c ##
    -@@ builtin/fast-import.c: static void git_pack_config(void)
    - 	}
    - 	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
    - 		pack_idx_opts.version = indexversion_value;
    --		if (pack_idx_opts.version > 2)
    --			git_die_config("pack.indexversion",
    --					"bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
    -+		if (pack_idx_opts.version > 2) {
    -+			error("bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
    -+			git_die_config("pack.indexversion");
    -+		}
    - 	}
    - 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
    - 		max_packsize = packsizelimit_value;
    -
    - ## builtin/notes.c ##
    -@@ builtin/notes.c: static int git_config_get_notes_strategy(const char *key,
    - 
    - 	if (git_config_get_string(key, &value))
    - 		return 1;
    --	if (parse_notes_merge_strategy(value, strategy))
    --		git_die_config(key, _("unknown notes merge strategy %s"), value);
    -+	if (parse_notes_merge_strategy(value, strategy)) {
    -+		error(_("unknown notes merge strategy %s"), value);
    -+		git_die_config(key);
    -+	}
    - 
    - 	free(value);
    - 	return 0;
    -
      ## config.c ##
    -@@ config.c: int repo_config_get_string(struct repository *repo,
    - 	git_config_check_init(repo);
    - 	ret = git_configset_get_string(repo->config, key, dest);
    - 	if (ret < 0)
    --		git_die_config(key, NULL);
    -+		git_die_config(key);
    - 	return ret;
    - }
    - 
    -@@ config.c: int repo_config_get_string_tmp(struct repository *repo,
    - 	git_config_check_init(repo);
    - 	ret = git_configset_get_string_tmp(repo->config, key, dest);
    - 	if (ret < 0)
    --		git_die_config(key, NULL);
    -+		git_die_config(key);
    - 	return ret;
    - }
    - 
    -@@ config.c: int repo_config_get_pathname(struct repository *repo,
    - 	git_config_check_init(repo);
    - 	ret = git_configset_get_pathname(repo->config, key, dest);
    - 	if (ret < 0)
    --		git_die_config(key, NULL);
    -+		git_die_config(key);
    - 	return ret;
    - }
    - 
    -@@ config.c: int git_config_get_expiry(const char *key, const char **output)
    - 		return ret;
    - 	if (strcmp(*output, "now")) {
    - 		timestamp_t now = approxidate("now");
    --		if (approxidate(*output) >= now)
    --			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
    -+		if (approxidate(*output) >= now) {
    -+			error(_("Invalid %s: '%s'"), key, *output);
    -+			git_die_config(key);
    -+		}
    - 	}
    - 	return ret;
    - }
    -@@ config.c: void git_die_config_linenr(const char *key, const char *filename, int linenr)
    - 		    key, filename, linenr);
    - }
    - 
    --NORETURN __attribute__((format(printf, 2, 3)))
    --void git_die_config(const char *key, const char *err, ...)
    -+NORETURN
    -+void git_die_config(const char *key)
    +@@ config.c: void git_die_config(const char *key, const char *err, ...)
      {
      	const struct string_list *values;
      	struct key_value_info *kv_info;
    ++	report_fn error_fn = get_error_routine();
      
    --	if (err) {
    --		va_list params;
    --		va_start(params, err);
    + 	if (err) {
    + 		va_list params;
    + 		va_start(params, err);
     -		vreportf("error: ", err, params);
    --		va_end(params);
    --	}
    ++		error_fn(err, params);
    + 		va_end(params);
    + 	}
      	values = git_config_get_value_multi(key);
    - 	kv_info = values->items[values->nr - 1].util;
    - 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
    -
    - ## config.h ##
    -@@ config.h: struct key_value_info {
    - };
    - 
    - /**
    -- * First prints the error message specified by the caller in `err` and then
    -- * dies printing the line number and the file name of the highest priority
    -- * value for the configuration variable `key`.
    -+ * Dies printing the line number and the file name of the highest
    -+ * priority value for the configuration variable `key`.
    -+ *
    -+ * Consider calling error() first with a more specific formatted
    -+ * message of your own.
    -  */
    --NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
    -+NORETURN void git_die_config(const char *key);
    - 
    - /**
    -  * Helper function which formats the die error message according to the
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int git_has_dir_sep(const char *path)
    @@ git-compat-util.h: static inline int git_has_dir_sep(const char *path)
      NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
      NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
     
    - ## imap-send.c ##
    -@@ imap-send.c: static int git_imap_config(const char *var, const char *val, void *cb)
    - 		server.port = git_config_int(var, val);
    - 	else if (!strcmp("imap.host", var)) {
    - 		if (!val) {
    --			git_die_config("imap.host", "Missing value for 'imap.host'");
    -+			error("Missing value for 'imap.host'");
    -+			git_die_config("imap.host");
    - 		} else {
    - 			if (starts_with(val, "imap:"))
    - 				val += 5;
    -
      ## usage.c ##
     @@
      #include "git-compat-util.h"
-- 
2.34.1.898.g5a552c2e5f0

