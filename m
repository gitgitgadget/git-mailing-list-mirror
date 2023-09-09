Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EBCEEB57F
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbjIIGQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjIIGQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F151BD3
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403012f27e3so4479095e9.3
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240179; x=1694844979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zw7aYlwbyVV6CmO1ksx1S1j8svjMdvFhXGthJwv1xs=;
        b=GIHCkXuCi9bxLPNvTros5b90CBlf/ce1/ef3Tdg0JGSIyJtuxawfT5xoXxTZkeBX9w
         SrYOw9pqPdCk0QcRF8JcYiB1ZT9jKHcvaDoT6f7Z9GB6mbyyKBCJEfVvzPk4jMfhVS+z
         sIb/so/hCWR4pjEcQcZpVyw/mrXtaPB/F6OzdTk9UI9Vsn80vYkOgSXIY8STPq+9qQWh
         Nkn5abMSxnay+jSnXvT9+H4P1zLfqBnvk/N4zNwqI6pMcYBGrtokN5WXFfHuoxuZtggP
         ZKRvV+DuL5YvT5mvyanXkuq7yVy/1kt8zn8BeLJbEv8inHkx2cxaPE7EoGQS9z/wGJmD
         6hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240179; x=1694844979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zw7aYlwbyVV6CmO1ksx1S1j8svjMdvFhXGthJwv1xs=;
        b=TfLeCNH6zri8EAXogkkECLzVyaeBp12XjtEY66vFVxmE4n7+9edRpUfeFLTrfwNA8s
         w7yXOFShZs0vA9QG9nIdZtSnN7zsgyZDSQUOMQFEMQSfiB4+KiQW4i7kD2ctmzf0Y4Jr
         nZxMiN/vyrevOiRMXCqTfNd7BHPYx92Whsio9diFEiFAwFS0ddTzaaEjaonyMTJ1gDLD
         2XUWIFALKX0ZB0uafNrBK/JOvG7Z2Hrrffts+88ymWT0WxCgL4KRq1IvY4jJGHRdTbmb
         AOO8bkNIO1lCIjmit0vNefyj6C8DGvPUWgs/EuU/fxNp/60qA8GP11thRIB6wOcUIj/K
         Tyfw==
X-Gm-Message-State: AOJu0YwuoS9LW1LhSW3wSDi1tNzLzSDa2f3ubYTIJIqz7s7PDLuKfdDg
        Ts3Sl/Od/33zo/i+T39hGLRrsXPyD/c=
X-Google-Smtp-Source: AGHT+IHlKeDDpGcFqWcxTurb2lDbGDU6fvJeAI1ha/WIoxM/GiuozFITXptRix6M2nR/FfeJCCuceg==
X-Received: by 2002:a5d:58fc:0:b0:319:52da:8f0b with SMTP id f28-20020a5d58fc000000b0031952da8f0bmr3618329wrd.17.1694240178859;
        Fri, 08 Sep 2023 23:16:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020adfe547000000b0031c71693449sm3881586wrm.1.2023.09.08.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:18 -0700 (PDT)
Message-ID: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:11 +0000
Subject: [PATCH v2 0/6] Trailer readability cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches were created while digging into the trailer code to better
understand how it works, in preparation for making the trailer.{c,h} files
as small as possible to make them available as a library for external users.
This series was originally created as part of [1], but are sent here
separately because the changes here are arguably more subjective in nature.
I think Patch 1 is the most important in this series. The others can wait,
if folks are opposed to adding them on their own merits at this point in
time.

These patches do not add or change any features. Instead, their goal is to
make the code easier to understand for new contributors (like myself), by
making various cleanups and improvements. Ultimately, my hope is that with
such cleanups, we are better positioned to make larger changes (especially
the broader libification effort, as in "Introduce Git Standard Library"
[2]).

Patch 1 was inspired by 576de3d956 (unpack_trees: start splitting internal
fields from public API, 2023-02-27) [3], and is in preparation for a
libification effort in the future around the trailer code. Independent of
libification, it still makes sense to discourage callers from peeking into
these trailer-internal fields.

Patches 2-3 aim to make some functions do a little less multitasking.

Patch 4 makes the find_patch_start function care about the "--no-divider"
option, because it that option matters for determining the start of the
"patch part" of the input.

Patch 5 is a renaming change to reduce overloaded language in the codebase.
It is inspired by 229d6ab6bf (doc: trailer: examples: avoid the word
"message" by itself, 2023-06-15) [4], which did a similar thing for the
interpret-trailers documentation.

Patch 6 makes trailer_info use offsets for trailer_start and trailer_end.


Updates in v2
=============

 * Patch 1: Drop the use of a #define. Instead just use an anonymous struct
   named internal.
 * Patch 2: Don't free info out parameter inside parse_trailers(). Instead
   free it from the caller, process_trailers(). Update comment in
   parse_trailers().
 * Patch 3: Reword commit message.
 * Patch 4: Mention be3d654343 (commit: pass --no-divider to
   interpret-trailers, 2023-06-17) in commit message.
 * Added Patch 6 to make trailer_info use offsets for trailer_start and
   trailer_end (thanks to Glen Choo for the suggestion).

[1]
https://lore.kernel.org/git/pull.1564.git.1691210737.gitgitgadget@gmail.com/T/#mb044012670663d8eb7a548924bbcc933bef116de
[2]
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/
[3]
https://lore.kernel.org/git/pull.1149.git.1677143700.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/6b4cb31b17077181a311ca87e82464a1e2ad67dd.1686797630.git.gitgitgadget@gmail.com/

Linus Arver (6):
  trailer: separate public from internal portion of trailer_iterator
  trailer: split process_input_file into separate pieces
  trailer: split process_command_line_args into separate functions
  trailer: teach find_patch_start about --no-divider
  trailer: rename *_DEFAULT enums to *_UNSPECIFIED
  trailer: use offsets for trailer_start/trailer_end

 trailer.c | 126 +++++++++++++++++++++++++++++-------------------------
 trailer.h |  19 ++++----
 2 files changed, 77 insertions(+), 68 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1563%2Flistx%2Ftrailer-libification-prep-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1563/listx/trailer-libification-prep-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1563

Range-diff vs v1:

 1:  0bce4d4b0d5 ! 1:  4f116d2550f trailer: separate public from internal portion of trailer_iterator
     @@ Commit message
          trailer: separate public from internal portion of trailer_iterator
      
          The fields here are not meant to be used by downstream callers, so put
     -    them behind an anonymous struct named as
     -    "__private_to_trailer_c__do_not_use" to warn against their use.
     +    them behind an anonymous struct named as "internal" to warn against
     +    their use. This follows the pattern in 576de3d956 (unpack_trees: start
     +    splitting internal fields from public API, 2023-02-27).
      
     -    Internally, use a "#define" to keep the code tidy.
     -
     -    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## trailer.c ##
     -@@ trailer.c: void format_trailers_from_commit(struct strbuf *out, const char *msg,
     - 	trailer_info_release(&info);
     - }
     - 
     -+#define private __private_to_trailer_c__do_not_use
     -+
     - void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
     - {
     - 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     +@@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
       	strbuf_init(&iter->key, 0);
       	strbuf_init(&iter->val, 0);
       	opts.no_divider = 1;
      -	trailer_info_get(&iter->info, msg, &opts);
      -	iter->cur = 0;
     -+	trailer_info_get(&iter->private.info, msg, &opts);
     -+	iter->private.cur = 0;
     ++	trailer_info_get(&iter->internal.info, msg, &opts);
     ++	iter->internal.cur = 0;
       }
       
       int trailer_iterator_advance(struct trailer_iterator *iter)
       {
      -	while (iter->cur < iter->info.trailer_nr) {
      -		char *trailer = iter->info.trailers[iter->cur++];
     -+	while (iter->private.cur < iter->private.info.trailer_nr) {
     -+		char *trailer = iter->private.info.trailers[iter->private.cur++];
     ++	while (iter->internal.cur < iter->internal.info.trailer_nr) {
     ++		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
       		int separator_pos = find_separator(trailer, separators);
       
       		if (separator_pos < 1)
     @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
       void trailer_iterator_release(struct trailer_iterator *iter)
       {
      -	trailer_info_release(&iter->info);
     -+	trailer_info_release(&iter->private.info);
     ++	trailer_info_release(&iter->internal.info);
       	strbuf_release(&iter->val);
       	strbuf_release(&iter->key);
       }
     @@ trailer.h: struct trailer_iterator {
      +	struct {
      +		struct trailer_info info;
      +		size_t cur;
     -+	} __private_to_trailer_c__do_not_use;
     ++	} internal;
       };
       
       /*
 2:  d023c297dca ! 2:  c00f4623d0b trailer: split process_input_file into separate pieces
     @@ trailer.c: static void unfold_value(struct strbuf *val)
      -				 struct list_head *head,
      -				 const struct process_trailer_options *opts)
      +/*
     -+ * Parse trailers in "str" and populate the "head" linked list structure.
     ++ * Parse trailers in "str", populating the trailer info and "head"
     ++ * linked list structure.
      + */
      +static void parse_trailers(struct trailer_info *info,
      +			     const char *str,
     @@ trailer.c: static void unfold_value(struct strbuf *val)
       			continue;
       		separator_pos = find_separator(trailer, separators);
      @@ trailer.c: static size_t process_input_file(FILE *outfile,
     + 					 strbuf_detach(&val, NULL));
       		}
       	}
     - 
     +-
      -	trailer_info_release(&info);
      -
      -	return info.trailer_end - str;
     -+	trailer_info_release(info);
       }
       
       static void free_all(struct list_head *head)
     @@ trailer.c: void process_trailers(const char *file,
       
       	if (!opts->only_input) {
       		LIST_HEAD(arg_head);
     +@@ trailer.c: void process_trailers(const char *file,
     + 	print_all(outfile, &head, opts);
     + 
     + 	free_all(&head);
     ++	trailer_info_release(&info);
     + 
     + 	/* Print the lines after the trailers as is */
     + 	if (!opts->only_trailers)
 3:  c8bb0136621 ! 3:  f78c2345fad trailer: split process_command_line_args into separate functions
     @@ Commit message
              (1) parse trailers from the configuration, and
              (2) parse trailers defined on the command line.
      
     -    Separate these concerns into parse_trailers_from_config and
     -    parse_trailers_from_command_line_args, respectively. Remove (now
     -    redundant) process_command_line_args.
     +    Separate (1) outside to a new function, parse_trailers_from_config.
     +    Rename the remaining logic to parse_trailers_from_command_line_args.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
 4:  1fc060041db ! 4:  f5f507c4c6c trailer: teach find_patch_start about --no-divider
     @@ Commit message
      
          Instead, make find_patch_start aware of "--no-divider" and make it
          handle that case as well. This means we no longer need to call strlen at
     -    all and can just rely on the existing code in find_patch_start.
     +    all and can just rely on the existing code in find_patch_start. By
     +    forcing callers to consider this important option, we avoid the kind of
     +    mistake described in be3d654343 (commit: pass --no-divider to
     +    interpret-trailers, 2023-06-17).
      
          This patch will make unit testing a bit more pleasant in this area in
          the future when we adopt a unit testing framework, because we would not
 5:  7c9b63c2616 ! 5:  52958c3557c trailer: rename *_DEFAULT enums to *_UNSPECIFIED
     @@ Commit message
          (2) "Default" can also mean the "trailer.*" configurations themselves,
              because these configurations are used by "default" (ahead of the
              hardcoded defaults in (1)) if no command line arguments are
     -        provided.
     +        provided. This concept of defaulting back to the configurations was
     +        introduced in 0ea5292e6b (interpret-trailers: add options for
     +        actions, 2017-08-01).
      
          In addition, the corresponding *_DEFAULT values are chosen when the user
          provides the "--no-where", "--no-if-exists", or "--no-if-missing" flags
 -:  ----------- > 6:  0463066ebe0 trailer: use offsets for trailer_start/trailer_end

-- 
gitgitgadget
