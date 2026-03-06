Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0852F6565
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808961; cv=none; b=F7OpNQzZO7zgI7ynMigIYtY7RPhSHLk7FfcnYrMvZB1BcElchaOoGGwGoT71alzkg2r9dSVG8x4ceNkm/2R2LOYLJinCDm8SggyfKIbZxk+9W38Nns27eap8ADjF8JpNufxi7/VpNR+hNqlCyK/TaUkfio4PgUlZNU3n2vCVxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808961; c=relaxed/simple;
	bh=wYpxyuq1HLs2msyzrIXjkWXv3rYVzUvguEIBHho9/uk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k5lFpY3R5xV57qaHMQBQF8d+5o5/k+IE6alJiZKCx3UfUQHUprIrWt3Zhg7wqssGzcIgEo/99PaFOr2E9A15uHrKr3j0p4JPXW1B3OxutLqOLnpnWuH5vfkfFhrgbVF8cmbVb+820MyUaOs7BdmyJP08qbYCfF6CHnnmNucVUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCyOPQsY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCyOPQsY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c4bde55cso2469497f8f.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808958; x=1773413758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UutZgFKDh6n1LdHE9RBDvwi/RkvSYorzTP7Sgk5LDQ=;
        b=kCyOPQsY1ZligpgFCBNI9w45GTVvf6PUbqFZsmN/SiaorFm8BtHOUqa2hgsLKKhsn5
         JW3L95dO4y7ySifYs5kzHFjYLFueLn70FXRta4Osp1cs49Qmk3upcyWCBODPDFL4dYMQ
         4jR0giVhEA8tplmQpeDRFsGwARrlplmlyEdzsbRmjwCQoyra3iA3rMP67JVcvSOTpSi5
         f0LpWCLnTTxs+2zmUSuuWSXnIMEd0DPZTQwk41RkMT/VXCJxE1eZ7JIbKwMndGKcSWn1
         r1LLrwQ2gQV8CayMsA1a/kUU5Tf9wL6YpaefdiLmq4kKQej6XpXZRjtAhDVbSuFF/r8K
         OkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808958; x=1773413758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UutZgFKDh6n1LdHE9RBDvwi/RkvSYorzTP7Sgk5LDQ=;
        b=pdhGp/1F8rHSrGUxZWeOvpYETyExM8pbHVAOOPajmoDOjE/0kgCttnJc1f9OoyWsCk
         eU7Vc52KQsnQmuLDl70KWKqf2fgK0Mb+/wwHE7mIXtjw3sy7a1/26djYnaU/5a2cR5Gh
         +N8B05RXSgT42lcLiwHI6CyvfNVPiN8kd3odD+oglmM1Jc7lxmGVKwTJx6oewk4MXt9a
         Cuc1Pr8X/ucNI1be4Ibeaj3dYd8bzBtEM44nKvwOEtcaffPQFCe2XveADn/xk/6zGX2w
         gAXeKoWJMSq3tTAHjEiNdqh5TUUqgdHDhH5LahBh3UMUZPhjMASSjG+ud2+srNWzQQI1
         B6EQ==
X-Gm-Message-State: AOJu0YwTn6cwMXS1dHviaPr1LoqGHi8POXTMrujADE+Ezj6ffKGZPiZW
	cQWYVy7A/+urB3pAAToUzcxXRhZChimsoC3sSQ4hDRoVbH5dkjI8khzW
X-Gm-Gg: ATEYQzxume0bj8b2kXAEM9Avky2JBGBZuF0n3GCWrQSwZMcHQ1tyRmnevEg9e57Uw23
	9c9mo9M5fAMLS2V3+T1F8taxcysQXQgtaRbaKE++Ps5qygGbSO4cXX2PbqqD2Vdlq8lb/Ov4BKi
	LCR4siOYaDeoRT/fA5MlYXCWH/lQuNVQtE8ejQXD7XiH/sVZuae4gN86Wi2xBthyhCS5p3guvbv
	mj4LlFdubYB3tt96Wd5kExhGxttKz/pF9sZ/3UU/R8A+CrRqBt0pKjbTtdfgir9h0wfwpVZjWQI
	OG3AVs9CVF9BvXRcKFqEdodUtdWZ+9XVVmcfM/pSeYsXM1AfkbcY/uT5yAvIfRzD7u7wOpl+b9a
	k6T4KDz5um/c1w5TZd9pVgQQsi/oiEDy7X+6FTuUZK/QOHNlC++V8J5d3GPtmVBIjCdra3ti4n9
	5H2QzBWaDMJM8Rn1uYi4EuuN9LaAKlH/aJ3bf/Rl4Wy3rElW+mMD8UjjM2V1NDSLfn0khCRr6IH
	d12+A==
X-Received: by 2002:a05:6000:2410:b0:439:c510:f97a with SMTP id ffacd0b85a97d-439da36a704mr4320436f8f.48.1772808957800;
        Fri, 06 Mar 2026 06:55:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae49177sm4460643f8f.35.2026.03.06.06.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 06:55:57 -0800 (PST)
Message-ID: <8a37a357-5a3b-4ca1-9949-6b2f28d3f208@gmail.com>
Date: Fri, 6 Mar 2026 14:55:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/5] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <dbaf6ea5-8a08-42c0-8184-16dcf40207dd@gmail.com>
 <19cbe42b2cd.bb6e3883730656.6495265672263159010@linux.beauty>
Content-Language: en-US
In-Reply-To: <19cbe42b2cd.bb6e3883730656.6495265672263159010@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 05/03/2026 13:49, Li Chen wrote:
>   >
>   > This all looks pretty good. The main thing I think we want to change is
>   > sharing the code that creates the temporary file in patch 3. I've push a
>   > version that does that and fixes my other small comments to
>   > https://github.com/phillipwood/git/commits/refs/heads/rebase-trailers-v8
>   > The range diff is below. If you're happy I can post that as a hopefully
>   > final v8. Of course if you want to work on it yourself you're very
>   > welcome to do that.
> 
> These changes all look good to me! Thank you very much for your patience and work! Please help
> post this as v8.

I've just posted v8, thanks for all your work on these patches

Phillip

> Regards,
> Li
> 
>   >
>   > 1:  b2685e34c22 ! 1:  0d08b361995 interpret-trailers: factor trailer rewriting
>   >      @@ Commit message
>   >           This separation makes it easier to move the helper into trailer.c in the
>   >           next commit.
>   >
>   >      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>   >           Signed-off-by: Li Chen <me@linux.beauty>
>   >
>   >        ## builtin/interpret-trailers.c ##
>   >       @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
>   > -:  ----------- > 2:  5a4d03ab375 interpret-trailers: refactor create_in_place_tempfile()
>   > 2:  1bac3025045 ! 3:  ab7e232a95d trailer: move process_trailers to trailer.h
>   >      @@ Metadata
>   >       Author: Li Chen <me@linux.beauty>
>   >
>   >        ## Commit message ##
>   >      -    trailer: move process_trailers to trailer.h
>   >      -
>   >      -    Move process_trailers() from builtin/interpret-trailers.c into trailer.c
>   >      -    and expose it via trailer.h.
>   >      -
>   >      -    This lets other call sites reuse the same trailer rewriting logic.
>   >      +    trailer: libify a couple of functions
>   >      +
>   >      +    Move create_in_place_tempfile() and process_trailers() from
>   >      +    builtin/interpret-trailers.c into trailer.c and expose it via trailer.h.
>   >      +
>   >      +    This reverts most of ae0ec2e0e0b (trailer: move interpret_trailers()
>   >      +    to interpret-trailers.c, 2024-03-01) and lets other call sites reuse
>   >      +    the same trailer rewriting logic.
>   >
>   >           Signed-off-by: Li Chen <me@linux.beauty>
>   >      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>   >
>   >        ## builtin/interpret-trailers.c ##
>   >      +@@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *opt, const char *arg,
>   >      +     return 0;
>   >      + }
>   >      +
>   >      +-
>   >      +-static struct tempfile *create_in_place_tempfile(const char *file)
>   >      +-{
>   >      +-    struct tempfile *tempfile = NULL;
>   >      +-    struct stat st;
>   >      +-    struct strbuf filename_template = STRBUF_INIT;
>   >      +-    const char *tail;
>   >      +-
>   >      +-    if (stat(file, &st)) {
>   >      +-        error_errno(_("could not stat %s"), file);
>   >      +-        return NULL;
>   >      +-    }
>   >      +-    if (!S_ISREG(st.st_mode)) {
>   >      +-        error(_("file %s is not a regular file"), file);
>   >      +-        return NULL;
>   >      +-    }
>   >      +-    if (!(st.st_mode & S_IWUSR)) {
>   >      +-        error(_("file %s is not writable by user"), file);
>   >      +-        return NULL;
>   >      +-    }
>   >      +-    /* Create temporary file in the same directory as the original */
>   >      +-    tail = find_last_dir_sep(file);
>   >      +-    if (tail)
>   >      +-        strbuf_add(&filename_template, file, tail - file + 1);
>   >      +-    strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
>   >      +-
>   >      +-    tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
>   >      +-
>   >      +-    strbuf_release(&filename_template);
>   >      +-
>   >      +-    return tempfile;
>   >      +-}
>   >      +-
>   >      + static void read_input_file(struct strbuf *sb, const char *file)
>   >      + {
>   >      +     if (file) {
>   >       @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
>   >            strbuf_complete_line(sb);
>   >        }
>   >      @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, con
>   >        static void interpret_trailers(const struct process_trailer_options *opts,
>   >                           struct list_head *new_trailer_head,
>   >                           const char *file)
>   >      +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
>   >      +     read_input_file(&input, file);
>   >      +
>   >      +     if (opts->in_place) {
>   >      +-        tempfile = create_in_place_tempfile(file);
>   >      ++        tempfile = trailer_create_in_place_tempfile(file);
>   >      +         if (!tempfile)
>   >      +             die(NULL);
>   >      +         fd = tempfile->fd;
>   >
>   >        ## trailer.c ##
>   >      +@@
>   >      + #include "commit.h"
>   >      + #include "trailer.h"
>   >      + #include "list.h"
>   >      ++#include "tempfile.h"
>   >      ++
>   >      + /*
>   >      +  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>   >      +  */
>   >      +@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
>   >      +     strbuf_release(&iter->key);
>   >      + }
>   >      +
>   >      ++struct tempfile *trailer_create_in_place_tempfile(const char *file)
>   >      ++{
>   >      ++    struct tempfile *tempfile = NULL;
>   >      ++    struct stat st;
>   >      ++    struct strbuf filename_template = STRBUF_INIT;
>   >      ++    const char *tail;
>   >      ++
>   >      ++    if (stat(file, &st)) {
>   >      ++        error_errno(_("could not stat %s"), file);
>   >      ++        return NULL;
>   >      ++    }
>   >      ++    if (!S_ISREG(st.st_mode)) {
>   >      ++        error(_("file %s is not a regular file"), file);
>   >      ++        return NULL;
>   >      ++    }
>   >      ++    if (!(st.st_mode & S_IWUSR)) {
>   >      ++        error(_("file %s is not writable by user"), file);
>   >      ++        return NULL;
>   >      ++    }
>   >      ++    /* Create temporary file in the same directory as the original */
>   >      ++    tail = find_last_dir_sep(file);
>   >      ++    if (tail)
>   >      ++        strbuf_add(&filename_template, file, tail - file + 1);
>   >      ++    strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
>   >      ++
>   >      ++    tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
>   >      ++
>   >      ++    strbuf_release(&filename_template);
>   >      ++
>   >      ++    return tempfile;
>   >      ++}
>   >      ++
>   >      + int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
>   >      + {
>   >      +     struct child_process run_trailer = CHILD_PROCESS_INIT;
>   >       @@ trailer.c: int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
>   >            strvec_pushv(&run_trailer.args, trailer_args->v);
>   >            return run_command(&run_trailer);
>   >      @@ trailer.h: void trailer_iterator_release(struct trailer_iterator *iter);
>   >         */
>   >        int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   >
>   >      ++/*
>   >      ++ * Create a tempfile ""git-interpret-trailers-XXXXXX" in the same
>   >      ++ * directory as file.
>   >      ++ */
>   >      ++struct tempfile *trailer_create_in_place_tempfile(const char *file);
>   >      ++
>   >      ++/*
>   >      ++ * Rewrite the contents of input by processing its trailer block according to
>   >      ++ * opts and (optionally) appending trailers from new_trailer_head.
>   >      ++ *
>   >      ++ * The rewritten message is appended to out (callers should strbuf_reset()
>   >      ++ * first if needed).
>   >      ++ */
>   >       +void process_trailers(const struct process_trailer_options *opts,
>   >       +              struct list_head *new_trailer_head,
>   >       +              struct strbuf *input, struct strbuf *out);
>   > 3:  3114f0dbb57 ! 4:  1f24917eb64 trailer: append trailers without fork/exec
>   >      @@ Commit message
>   >
>   >           Update amend_file_with_trailers() to use the in-process helper and
>   >           rewrite the target file via tempfile+rename, preserving the previous
>   >      -    in-place semantics.
>   >      +    in-place semantics. As the trailers are no longer added in a separate
>   >      +    process and trailer_config_init() die()s on missing config values it
>   >      +    is called early on in cmd_commit() and cmd_tag() so that they die()
>   >      +    early before writing the message file. The trailer arguments are now
>   >      +    also sanity checked.
>   >
>   >           Keep existing callers unchanged by continuing to accept argv-style
>   >           --trailer=<trailer> entries and stripping the prefix before feeding the
>   >           in-process implementation.
>   >
>   >           Signed-off-by: Li Chen <me@linux.beauty>
>   >      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>   >      -
>   >      - ## builtin/interpret-trailers.c ##
>   >      -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
>   >      -     struct strbuf out = STRBUF_INIT;
>   >      -     FILE *outfile = stdout;
>   >      -
>   >      --    trailer_config_init();
>   >      --
>   >      -     read_input_file(&input, file);
>   >      -
>   >      -     if (opts->in_place)
>   >      -@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc,
>   >      -             git_interpret_trailers_usage,
>   >      -             options);
>   >      -
>   >      -+    trailer_config_init();
>   >      -+
>   >      -     if (argc) {
>   >      -         int i;
>   >      -         for (i = 0; i < argc; i++)
>   >      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>   >      +
>   >      + ## builtin/commit.c ##
>   >      +@@ builtin/commit.c: int cmd_commit(int argc,
>   >      +     argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>   >      +                       builtin_commit_usage,
>   >      +                       prefix, current_head, &s);
>   >      ++    if (trailer_args.nr)
>   >      ++        trailer_config_init();
>   >      ++
>   >      +     if (verbose == -1)
>   >      +         verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>   >      +
>   >      +
>   >      + ## builtin/tag.c ##
>   >      +@@ builtin/tag.c: int cmd_tag(int argc,
>   >      +     if (cmdmode == 'l')
>   >      +         setup_auto_pager("tag", 1);
>   >      +
>   >      ++    if (trailer_args.nr)
>   >      ++        trailer_config_init();
>   >      ++
>   >      +     if (opt.sign == -1)
>   >      +         opt.sign = cmdmode ? 0 : config_sign_tag > 0;
>   >      +
>   >
>   >        ## trailer.c ##
>   >       @@
>   >        #include "string-list.h"
>   >        #include "run-command.h"
>   >        #include "commit.h"
>   >       +#include "strvec.h"
>   >      -+#include "tempfile.h"
>   >        #include "trailer.h"
>   >        #include "list.h"
>   >      -+
>   >      - /*
>   >      -  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>   >      -  */
>   >      + #include "tempfile.h"
>   >       @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head,
>   >            free(cl_separators);
>   >        }
>   >
>   >      -+void validate_trailer_args(const struct strvec *cli_args)
>   >      ++int validate_trailer_args(const struct strvec *cli_args)
>   >       +{
>   >       +    char *cl_separators;
>   >      ++    int ret = 0;
>   >       +
>   >       +    trailer_config_init();
>   >       +
>   >      @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
>   >       +        const char *txt = cli_args->v[i];
>   >       +        ssize_t separator_pos;
>   >       +
>   >      -+        if (!*txt)
>   >      -+            die(_("empty --trailer argument"));
>   >      -+
>   >      ++        if (!*txt) {
>   >      ++            ret = error(_("empty --trailer argument"));
>   >      ++            goto out;
>   >      ++        }
>   >       +        separator_pos = find_separator(txt, cl_separators);
>   >      -+        if (separator_pos == 0)
>   >      -+            die(_("invalid trailer '%s': missing key before separator"),
>   >      -+                txt);
>   >      ++        if (separator_pos == 0) {
>   >      ++            ret = error(_("invalid trailer '%s': missing key before separator"),
>   >      ++                    txt);
>   >      ++            goto out;
>   >      ++        }
>   >       +    }
>   >      -+
>   >      ++out:
>   >       +    free(cl_separators);
>   >      ++    return ret;
>   >       +}
>   >       +
>   >        static const char *next_line(const char *str)
>   >        {
>   >            const char *nl = strchrnul(str, '\n');
>   >      -@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
>   >      -     strbuf_release(&iter->key);
>   >      +@@ trailer.c: struct tempfile *trailer_create_in_place_tempfile(const char *file)
>   >      +     return tempfile;
>   >        }
>   >
>   >       -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
>   >      @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
>   >       -             path, NULL);
>   >       -    strvec_pushv(&run_trailer.args, trailer_args->v);
>   >       -    return run_command(&run_trailer);
>   >      -+static void new_trailer_items_clear(struct list_head *items)
>   >      -+{
>   >      -+    while (!list_empty(items)) {
>   >      -+        struct new_trailer_item *item =
>   >      -+            list_first_entry(items, struct new_trailer_item, list);
>   >      -+        list_del(&item->list);
>   >      -+        free(item);
>   >      -+    }
>   >      -+}
>   >      -+
>   >      -+void amend_strbuf_with_trailers(struct strbuf *buf,
>   >      ++int amend_strbuf_with_trailers(struct strbuf *buf,
>   >       +                const struct strvec *trailer_args)
>   >       +{
>   >       +    struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>   >       +    LIST_HEAD(new_trailer_head);
>   >       +    struct strbuf out = STRBUF_INIT;
>   >       +    size_t i;
>   >      ++    int ret = 0;
>   >       +
>   >       +    opts.no_divider = 1;
>   >       +
>   >       +    for (i = 0; i < trailer_args->nr; i++) {
>   >       +        const char *text = trailer_args->v[i];
>   >       +        struct new_trailer_item *item;
>   >       +
>   >      -+        if (!*text)
>   >      -+            die(_("empty --trailer argument"));
>   >      ++        if (!*text) {
>   >      ++            ret = error(_("empty --trailer argument"));
>   >      ++            goto out;
>   >      ++        }
>   >       +        item = xcalloc(1, sizeof(*item));
>   >      -+        item->text = text;
>   >      ++        item->text = xstrdup(text);
>   >       +        list_add_tail(&item->list, &new_trailer_head);
>   >       +    }
>   >       +
>   >      -+    trailer_config_init();
>   >       +    process_trailers(&opts, &new_trailer_head, buf, &out);
>   >       +
>   >       +    strbuf_swap(buf, &out);
>   >      ++out:
>   >       +    strbuf_release(&out);
>   >      ++    free_trailers(&new_trailer_head);
>   >       +
>   >      -+    new_trailer_items_clear(&new_trailer_head);
>   >      ++    return ret;
>   >       +}
>   >       +
>   >       +static int write_file_in_place(const char *path, const struct strbuf *buf)
>   >       +{
>   >      -+    struct stat st;
>   >      -+    struct strbuf filename_template = STRBUF_INIT;
>   >      -+    const char *tail;
>   >      -+    struct tempfile *tempfile;
>   >      -+    FILE *outfile;
>   >      -+
>   >      -+    if (stat(path, &st))
>   >      -+        return error_errno(_("could not stat %s"), path);
>   >      -+    if (!S_ISREG(st.st_mode))
>   >      -+        return error(_("file %s is not a regular file"), path);
>   >      -+    if (!(st.st_mode & S_IWUSR))
>   >      -+        return error(_("file %s is not writable by user"), path);
>   >      -+
>   >      -+    /* Create temporary file in the same directory as the original */
>   >      -+    tail = strrchr(path, '/');
>   >      -+    if (tail)
>   >      -+        strbuf_add(&filename_template, path, tail - path + 1);
>   >      -+    strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
>   >      -+
>   >      -+    tempfile = mks_tempfile_sm(filename_template.buf, 0, st.st_mode);
>   >      -+    strbuf_release(&filename_template);
>   >      ++    struct tempfile *tempfile = trailer_create_in_place_tempfile(path);
>   >       +    if (!tempfile)
>   >      -+        return error_errno(_("could not create temporary file"));
>   >      -+
>   >      -+    outfile = fdopen_tempfile(tempfile, "w");
>   >      -+    if (!outfile) {
>   >      -+        int saved_errno = errno;
>   >      -+        delete_tempfile(&tempfile);
>   >      -+        errno = saved_errno;
>   >      -+        return error_errno(_("could not open temporary file"));
>   >      -+    }
>   >      -+
>   >      -+    if (buf->len && fwrite(buf->buf, 1, buf->len, outfile) < buf->len) {
>   >      -+        int saved_errno = errno;
>   >      -+        delete_tempfile(&tempfile);
>   >      -+        errno = saved_errno;
>   >      ++        return -1;
>   >      ++
>   >      ++    if (write_in_full(tempfile->fd, buf->buf, buf->len) < 0)
>   >       +        return error_errno(_("could not write to temporary file"));
>   >      -+    }
>   >       +
>   >       +    if (rename_tempfile(&tempfile, path))
>   >       +        return error_errno(_("could not rename temporary file to %s"), path);
>   >      @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
>   >       +         * in-process implementation.
>   >       +         */
>   >       +        skip_prefix(txt, "--trailer=", &txt);
>   >      -+        if (!*txt)
>   >      -+            die(_("empty --trailer argument"));
>   >      ++        if (!*txt) {
>   >      ++            ret = error(_("empty --trailer argument"));
>   >      ++            goto out;
>   >      ++        }
>   >       +        strvec_push(&stripped_trailer_args, txt);
>   >       +    }
>   >       +
>   >      ++    if (validate_trailer_args(&stripped_trailer_args)) {
>   >      ++        ret = -1;
>   >      ++        goto out;
>   >      ++    }
>   >       +    if (strbuf_read_file(&buf, path, 0) < 0)
>   >       +        ret = error_errno(_("could not read '%s'"), path);
>   >       +    else
>   >       +        amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
>   >       +
>   >       +    if (!ret)
>   >       +        ret = write_file_in_place(path, &buf);
>   >      -+
>   >      ++out:
>   >       +    strvec_clear(&stripped_trailer_args);
>   >       +    strbuf_release(&buf);
>   >       +    return ret;
>   >      @@ trailer.h: void parse_trailers_from_config(struct list_head *config_head);
>   >        void parse_trailers_from_command_line_args(struct list_head *arg_head,
>   >                               struct list_head *new_trailer_head);
>   >
>   >      -+void validate_trailer_args(const struct strvec *cli_args);
>   >      ++int validate_trailer_args(const struct strvec *cli_args);
>   >       +
>   >        void process_trailers_lists(struct list_head *head,
>   >                        struct list_head *arg_head);
>   >      @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
>   >       + * Each element of trailer_args should be in the same format as the value
>   >       + * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
>   >       + */
>   >      -+void amend_strbuf_with_trailers(struct strbuf *buf,
>   >      ++int amend_strbuf_with_trailers(struct strbuf *buf,
>   >       +                const struct strvec *trailer_args);
>   >       +
>   >       +/*
>   >      @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
>   >         */
>   >        int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   >
>   >      -+/*
>   >      -+ * Rewrite the contents of input by processing its trailer block according to
>   >      -+ * opts and (optionally) appending trailers from new_trailer_head.
>   >      -+ *
>   >      -+ * The rewritten message is appended to out (callers should strbuf_reset()
>   >      -+ * first if needed).
>   >      -+ */
>   >      - void process_trailers(const struct process_trailer_options *opts,
>   >      -               struct list_head *new_trailer_head,
>   >      -               struct strbuf *input, struct strbuf *out);
>   > 4:  147595a9317 ! 5:  3c1fa9e8579 commit, tag: parse --trailer with OPT_STRVEC
>   >      @@ Commit message
>   >           amend_file_with_trailers().
>   >
>   >           Signed-off-by: Li Chen <me@linux.beauty>
>   >
>   >        ## builtin/commit.c ##
>   >       @@ builtin/commit.c: int cmd_commit(int argc,
>   >      @@ trailer.c: int amend_file_with_trailers(const char *path,
>   >       -         * in-process implementation.
>   >       -         */
>   >       -        skip_prefix(txt, "--trailer=", &txt);
>   >      --        if (!*txt)
>   >      --            die(_("empty --trailer argument"));
>   >      +-        if (!*txt) {
>   >      +-            ret = error(_("empty --trailer argument"));
>   >      +-            goto out;
>   >      +-        }
>   >       -        strvec_push(&stripped_trailer_args, txt);
>   >       -    }
>   >       -
>   >      +-    if (validate_trailer_args(&stripped_trailer_args)) {
>   >      ++    if (validate_trailer_args(trailer_args)) {
>   >      +         ret = -1;
>   >      +         goto out;
>   >      +     }
>   >            if (strbuf_read_file(&buf, path, 0) < 0)
>   >                ret = error_errno(_("could not read '%s'"), path);
>   >            else
>   >      @@ trailer.c: int amend_file_with_trailers(const char *path,
>   >
>   >            if (!ret)
>   >                ret = write_file_in_place(path, &buf);
>   >      -
>   >      + out:
>   >       -    strvec_clear(&stripped_trailer_args);
>   >            strbuf_release(&buf);
>   >            return ret;
>   >        }
>   >
>   >        ## trailer.h ##
>   >      -@@ trailer.h: void amend_strbuf_with_trailers(struct strbuf *buf,
>   >      +@@ trailer.h: int amend_strbuf_with_trailers(struct strbuf *buf,
>   >        /*
>   >         * Augment a file by appending trailers specified in trailer_args.
>   >         *
>   > 5:  864cf5f8eb6 ! 6:  99654d80547 rebase: support --trailer
>   >      @@ Commit message
>   >           non-interactive and interactive rebases.
>   >
>   >           Signed-off-by: Li Chen <me@linux.beauty>
>   >      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>   >
>   >        ## Documentation/git-rebase.adoc ##
>   >       @@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
>   >      @@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
>   >       +--trailer=<trailer>::
>   >       +    Append the given trailer to every rebased commit message, processed
>   >       +    via linkgit:git-interpret-trailers[1]. This option implies
>   >      -+    `--force-rebase` so that fast-forwarded commits are also rewritten.
>   >      ++    `--force-rebase`.
>   >       ++
>   >       +See also INCOMPATIBLE OPTIONS below.
>   >       +
>   >        -i::
>   >        --interactive::
>   >            Make a list of the commits which are about to be rebased.  Let the
>   >      +@@ Documentation/git-rebase.adoc: are incompatible with the following options:
>   >      +  * --[no-]reapply-cherry-picks when used without --keep-base
>   >      +  * --update-refs
>   >      +  * --root when used without --onto
>   >      ++ * --trailer
>   >      +
>   >      + In addition, the following pairs of options are incompatible:
>   >      +
>   >
>   >        ## builtin/rebase.c ##
>   >       @@
>   >      @@ builtin/rebase.c: int cmd_rebase(int argc,
>   >                         builtin_rebase_usage, 0);
>   >
>   >       +    if (options.trailer_args.nr) {
>   >      -+        validate_trailer_args(&options.trailer_args);
>   >      ++        if (validate_trailer_args(&options.trailer_args))
>   >      ++            die(NULL);
>   >       +        options.flags |= REBASE_FORCE;
>   >       +    }
>   >       +
>   >      @@ sequencer.c: void replay_opts_release(struct replay_opts *opts)
>   >            free(opts->ctx);
>   >        }
>   >       @@ sequencer.c: static int append_squash_message(struct strbuf *buf, const char *body,
>   >      +     if (is_fixup_flag(command, flag) && !seen_squash(ctx)) {
>   >      +         /*
>   >      +          * We're replacing the commit message so we need to
>   >      +-         * append the Signed-off-by: trailer if the user
>   >      +-         * requested '--signoff'.
>   >      ++         * append any trailers if the user requested
>   >      ++         * '--signoff' or '--trailer'.
>   >      +          */
>   >                if (opts->signoff)
>   >                    append_signoff(buf, 0, 0);
>   >
>   >      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>   >            if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
>   >                res = -1;
>   >            else if (!opts->strategy ||
>   >      +@@ sequencer.c: static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>   >      +     parse_strategy_opts(opts, buf->buf);
>   >      + }
>   >      +
>   >      ++static int read_trailers(struct replay_opts *opts, struct strbuf *buf)
>   >      ++{
>   >      ++    ssize_t len;
>   >      ++
>   >      ++    strbuf_reset(buf);
>   >      ++    len = strbuf_read_file(buf, rebase_path_trailer(), 0);
>   >      ++    if (len > 0) {
>   >      ++        char *p = buf->buf, *nl;
>   >      ++
>   >      ++        trailer_config_init();
>   >      ++
>   >      ++        while ((nl = strchr(p, '\n'))) {
>   >      ++            *nl = '\0';
>   >      ++            if (!*p)
>   >      ++                return error(_("trailers file contains empty line"));
>   >      ++            strvec_push(&opts->trailer_args, p);
>   >      ++            p = nl + 1;
>   >      ++        }
>   >      ++    } else if (!len) {
>   >      ++        return error(_("trailers file is empty"));
>   >      ++    } else if (errno != ENOENT) {
>   >      ++        return error(_("cannot read trailers files"));
>   >      ++    }
>   >      ++
>   >      ++    return 0;
>   >      ++}
>   >      ++
>   >      + static int read_populate_opts(struct replay_opts *opts)
>   >      + {
>   >      +     struct replay_ctx *ctx = opts->ctx;
>   >       @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
>   >      +             opts->keep_redundant_commits = 1;
>   >
>   >                read_strategy_opts(opts, &buf);
>   >      ++
>   >      ++        if (read_trailers(opts, &buf)) {
>   >      ++            ret = -1;
>   >      ++            goto done_rebase_i;
>   >      ++        }
>   >                strbuf_reset(&buf);
>   >      -+        if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
>   >      -+            char *p = buf.buf, *nl;
>   >      -+
>   >      -+            while ((nl = strchr(p, '\n'))) {
>   >      -+                *nl = '\0';
>   >      -+                if (!*p)
>   >      -+                    BUG("rebase-merge/trailer has an empty line");
>   >      -+                strvec_push(&opts->trailer_args, p);
>   >      -+                p = nl + 1;
>   >      -+            }
>   >      -+            strbuf_reset(&buf);
>   >      -+        }
>   >
>   >                if (read_oneliner(&ctx->current_fixups,
>   >      -                   rebase_path_current_fixups(),
>   >       @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_name,
>   >                write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>   >            else
>   >
>   >
> 

