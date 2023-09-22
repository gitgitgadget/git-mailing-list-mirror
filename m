Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A9CE7ABA
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjIVTu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjIVTu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C21A1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32179d3c167so2332179f8f.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412247; x=1696017047; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT2CBYB/0JY4coSxZiEVxYor0gYU1ttNV7K0PMDln8U=;
        b=GGorpvKJxa72Lz9VYhy3dAh+mf7uuafvcVwEgYWQOJWOedVVB5VZYAhUPJqlGuhNBi
         G/3Mp18aHg1YF0+xrNshMlhOHr3ox6USAkrYSHWJRtmEbwvlOwkwPFBOxO79c4wvT+sB
         y/khHatSQ9Yxsn31ddHB48/EHyBfgEuAIysOrn8bYe8FAlVQRUgKORVaSc40i500LvTL
         Kto49/m6zU22JZ8FmBviFyLBIcouR2hfORTqhaEZ5L3wQko9n6Hg+hXCnqUGe6AIrDZL
         49w5hQttwOC4iVc5OrMceVj7geQbmAXBPLB+lXY16gjZYZ8VPHSxaTbQJEAhVo8W8VJQ
         LYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412247; x=1696017047;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT2CBYB/0JY4coSxZiEVxYor0gYU1ttNV7K0PMDln8U=;
        b=GsV1T0b3A04jMJdBiX7Sb7zDz55e+ns7hElb2rvQuZFLPMeACuK7O4blBqIS9GQLYl
         cEZ045dJ/DkEUluLcPiGgm8gx7ATmyExlkHUv4fBpJry+IaxkxvwX46PdLVXcgO6WIvC
         zaFdBWccbiwOLfscvjWL1TzSWFEj+Oef0jGuH5bNP3GtEJjWWyu2DmLQcTKP7diigaS3
         akKgPFPCbVXqRUZeylNyH+d1Uorpqr/lYCzn/9nieKYlWI5D+qpv4/5w5jkeigqRJXAl
         i2M15gnOgRYYbk6GkHFO2cdE1Y7qp7kJpAOPJrverCoZ7597iPKBAH4+E+j/h7wvHGQl
         WPmA==
X-Gm-Message-State: AOJu0Yyu7TH3D8QbxiABoGFWgw+HY6ULmkLNOzdkjnqdJcwdfNirCzlQ
        Wm4g28ar/+rYa/21Xga0c/dZg6d9biE=
X-Google-Smtp-Source: AGHT+IHpSVv5z2nffi+f5CBhjXWgSrT8Ce3WjcE7R1h13q3kk8jiIzYrmnJm8V8+QB+M3o5lY+wLKw==
X-Received: by 2002:a5d:4a04:0:b0:31f:f9e5:ef05 with SMTP id m4-20020a5d4a04000000b0031ff9e5ef05mr610756wrq.1.1695412246788;
        Fri, 22 Sep 2023 12:50:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6849000000b0031989784d96sm5200116wrw.76.2023.09.22.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:46 -0700 (PDT)
Message-ID: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:36 +0000
Subject: [PATCH v3 0/9] Trailer readability cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
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

Patch 4 is a renaming change to reduce overloaded language in the codebase.
It is inspired by 229d6ab6bf (doc: trailer: examples: avoid the word
"message" by itself, 2023-06-15) [4], which did a similar thing for the
interpret-trailers documentation.

Patches 5-8 clean up the area around handling the trailer block start and
end of the input. In particular we rename find_patch_start() to
find_end_of_log_message(). These patches address the new approach I cited in
[5].


Updates in v3
=============

 * Patches 4 and 6 (--no-divider and trailer block start/end cleanups) have
   been reorganized to Patches 5-8. This ended up touching commit.c in a
   minor way, but otherwise all of the changes here are cleanups and do not
   change any behavior.


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
[5]
https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#m0131f9829c35d8e0103ffa88f07d8e0e43dd732c

Linus Arver (9):
  trailer: separate public from internal portion of trailer_iterator
  trailer: split process_input_file into separate pieces
  trailer: split process_command_line_args into separate functions
  trailer: rename *_DEFAULT enums to *_UNSPECIFIED
  commit: ignore_non_trailer computes number of bytes to ignore
  trailer: find the end of the log message
  trailer: use offsets for trailer_start/trailer_end
  trailer: only use trailer_block_* variables if trailers were found
  trailer: make stack variable names match field names

 builtin/commit.c |   2 +-
 builtin/merge.c  |   2 +-
 commit.c         |   2 +-
 commit.h         |   4 +-
 sequencer.c      |   2 +-
 trailer.c        | 220 ++++++++++++++++++++++++++++-------------------
 trailer.h        |  27 +++---
 7 files changed, 154 insertions(+), 105 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1563%2Flistx%2Ftrailer-libification-prep-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1563/listx/trailer-libification-prep-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1563

Range-diff vs v2:

  1:  4f116d2550f =  1:  4f116d2550f trailer: separate public from internal portion of trailer_iterator
  2:  c00f4623d0b =  2:  c00f4623d0b trailer: split process_input_file into separate pieces
  3:  f78c2345fad =  3:  f78c2345fad trailer: split process_command_line_args into separate functions
  5:  52958c3557c =  4:  47186a09b24 trailer: rename *_DEFAULT enums to *_UNSPECIFIED
  -:  ----------- >  5:  da52cec42e1 commit: ignore_non_trailer computes number of bytes to ignore
  4:  f5f507c4c6c !  6:  ab8a6ced143 trailer: teach find_patch_start about --no-divider
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: teach find_patch_start about --no-divider
     +    trailer: find the end of the log message
      
     -    Currently, find_patch_start only finds the start of the patch part of
     -    the input (by looking at the "---" divider) for cases where the
     -    "--no-divider" flag has not been provided. If the user provides this
     -    flag, we do not rely on find_patch_start at all and just call strlen()
     -    directly on the input.
     +    Previously, trailer_info_get() computed the trailer block end position
     +    by
      
     -    Instead, make find_patch_start aware of "--no-divider" and make it
     -    handle that case as well. This means we no longer need to call strlen at
     -    all and can just rely on the existing code in find_patch_start. By
     -    forcing callers to consider this important option, we avoid the kind of
     -    mistake described in be3d654343 (commit: pass --no-divider to
     -    interpret-trailers, 2023-06-17).
     +    (1) checking for the opts->no_divider flag and optionally calling
     +        find_patch_start() to find the "patch start" location (patch_start), and
     +    (2) calling find_trailer_end() to find the end of the trailer block
     +        using patch_start as a guide, saving the return value into
     +        "trailer_end".
      
     -    This patch will make unit testing a bit more pleasant in this area in
     -    the future when we adopt a unit testing framework, because we would not
     -    have to test multiple functions to check how finding the start of a
     -    patch part works (we would only need to test find_patch_start).
     +    The logic in (1) was awkward because the variable "patch_start" is
     +    misleading if there is no patch in the input. The logic in (2) was
     +    misleading because it could be the case that no trailers are in the
     +    input (yet we are setting a "trailer_end" variable before even searching
     +    for trailers, which happens later in find_trailer_start()). The name
     +    "find_trailer_end" was misleading because that function did not look for
     +    any trailer block itself --- instead it just computed the end position
     +    of the log message in the input where the end of the trailer block (if
     +    it exists) would be (because trailer blocks must always come after the
     +    end of the log message).
      
     +    Combine the logic in (1) and (2) together into find_patch_start() by
     +    renaming it to find_end_of_log_message(). The end of the log message is
     +    the starting point which find_trailer_start() needs to start searching
     +    backward to parse individual trailers (if any).
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## trailer.c ##
      @@ trailer.c: static ssize_t last_line(const char *buf, size_t len)
     -  * Return the position of the start of the patch or the length of str if there
     -  * is no patch in the message.
     + }
     + 
     + /*
     +- * Return the position of the start of the patch or the length of str if there
     +- * is no patch in the message.
     ++ * Find the end of the log message as an offset from the start of the input
     ++ * (where callers of this function are interested in looking for a trailers
     ++ * block in the same input). We have to consider two categories of content that
     ++ * can come at the end of the input which we want to ignore (because they don't
     ++ * belong in the log message):
     ++ *
     ++ * (1) the "patch part" which begins with a "---" divider and has patch
     ++ * information (like the output of git-format-patch), and
     ++ *
     ++ * (2) any trailing comment lines, blank lines like in the output of "git
     ++ * commit -v", or stuff below the "cut" (scissor) line.
     ++ *
     ++ * As a formula, the situation looks like this:
     ++ *
     ++ *     INPUT = LOG MESSAGE + IGNORED
     ++ *
     ++ * where IGNORED can be either of the two categories described above. It may be
     ++ * that there is nothing to ignore. Now it may be the case that the LOG MESSAGE
     ++ * contains a trailer block, but that's not the concern of this function.
        */
      -static size_t find_patch_start(const char *str)
     -+static size_t find_patch_start(const char *str, int no_divider)
     ++static size_t find_end_of_log_message(const char *input, int no_divider)
       {
     ++	size_t end;
     ++
       	const char *s;
       
     - 	for (s = str; *s; s = next_line(s)) {
     +-	for (s = str; *s; s = next_line(s)) {
     ++	/* Assume the naive end of the input is already what we want. */
     ++	end = strlen(input);
     ++
     ++	/* Optionally skip over any patch part ("---" line and below). */
     ++	for (s = input; *s; s = next_line(s)) {
       		const char *v;
       
      -		if (skip_prefix(s, "---", &v) && isspace(*v))
     -+		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v))
     - 			return s - str;
     +-			return s - str;
     ++		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v)) {
     ++			end = s - input;
     ++			break;
     ++		}
       	}
       
     +-	return s - str;
     ++	/* Skip over other ignorable bits. */
     ++	return end - ignored_log_message_bytes(input, end);
     + }
     + 
     + /*
     +@@ trailer.c: continue_outer_loop:
     + 	return len;
     + }
     + 
     +-/* Return the position of the end of the trailers. */
     +-static size_t find_trailer_end(const char *buf, size_t len)
     +-{
     +-	return len - ignored_log_message_bytes(buf, len);
     +-}
     +-
     + static int ends_with_blank_line(const char *buf, size_t len)
     + {
     + 	ssize_t ll = last_line(buf, len);
     +@@ trailer.c: void process_trailers(const char *file,
     + void trailer_info_get(struct trailer_info *info, const char *str,
     + 		      const struct process_trailer_options *opts)
     + {
     +-	int patch_start, trailer_end, trailer_start;
     ++	int end_of_log_message, trailer_start;
     + 	struct strbuf **trailer_lines, **ptr;
     + 	char **trailer_strings = NULL;
     + 	size_t nr = 0, alloc = 0;
      @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
       
       	ensure_configured();
     @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
      -	else
      -		patch_start = find_patch_start(str);
      -
     -+	patch_start = find_patch_start(str, opts->no_divider);
     - 	trailer_end = find_trailer_end(str, patch_start);
     - 	trailer_start = find_trailer_start(str, trailer_end);
     +-	trailer_end = find_trailer_end(str, patch_start);
     +-	trailer_start = find_trailer_start(str, trailer_end);
     ++	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
     ++	trailer_start = find_trailer_start(str, end_of_log_message);
       
     + 	trailer_lines = strbuf_split_buf(str + trailer_start,
     +-					 trailer_end - trailer_start,
     ++					 end_of_log_message - trailer_start,
     + 					 '\n',
     + 					 0);
     + 	for (ptr = trailer_lines; *ptr; ptr++) {
     +@@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
     + 	info->blank_line_before_trailer = ends_with_blank_line(str,
     + 							       trailer_start);
     + 	info->trailer_start = str + trailer_start;
     +-	info->trailer_end = str + trailer_end;
     ++	info->trailer_end = str + end_of_log_message;
     + 	info->trailers = trailer_strings;
     + 	info->trailer_nr = nr;
     + }
  6:  0463066ebe0 !  7:  091805eb7d9 trailer: use offsets for trailer_start/trailer_end
     @@ Commit message
          reference the input string in format_trailer_info(), so update that
          function to take a pointer to the input.
      
     +    While we're at it, rename trailer_start to trailer_block_start to be
     +    more explicit about these offsets (that they are for the entire trailer
     +    block including other trailers). Ditto for trailer_end.
     +
          Signed-off-by: Linus Arver <linusa@google.com>
      
     + ## sequencer.c ##
     +@@ sequencer.c: static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
     + 	if (ignore_footer)
     + 		sb->buf[sb->len - ignore_footer] = saved_char;
     + 
     +-	if (info.trailer_start == info.trailer_end)
     ++	if (info.trailer_block_start == info.trailer_block_end)
     + 		return 0;
     + 
     + 	for (i = 0; i < info.trailer_nr; i++)
     +
       ## trailer.c ##
     +@@ trailer.c: static size_t find_end_of_log_message(const char *input, int no_divider)
     +  * Return the position of the first trailer line or len if there are no
     +  * trailers.
     +  */
     +-static size_t find_trailer_start(const char *buf, size_t len)
     ++static size_t find_trailer_block_start(const char *buf, size_t len)
     + {
     + 	const char *s;
     + 	ssize_t end_of_title, l;
      @@ trailer.c: void process_trailers(const char *file,
       	LIST_HEAD(head);
       	struct strbuf sb = STRBUF_INIT;
     @@ trailer.c: void process_trailers(const char *file,
       	/* Print the lines before the trailers */
       	if (!opts->only_trailers)
      -		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
     -+		fwrite(sb.buf, 1, info.trailer_start, outfile);
     ++		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
       
       	if (!opts->only_trailers && !info.blank_line_before_trailer)
       		fprintf(outfile, "\n");
     @@ trailer.c: void process_trailers(const char *file,
       	/* Print the lines after the trailers as is */
       	if (!opts->only_trailers)
      -		fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
     -+		fwrite(sb.buf + info.trailer_end, 1, sb.len - info.trailer_end, outfile);
     ++		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
       
       	if (opts->in_place)
       		if (rename_tempfile(&trailers_tempfile, file))
     @@ trailer.c: void process_trailers(const char *file,
       void trailer_info_get(struct trailer_info *info, const char *str,
       		      const struct process_trailer_options *opts)
       {
     --	int patch_start, trailer_end, trailer_start;
     -+	size_t patch_start, trailer_end = 0, trailer_start = 0;
     +-	int end_of_log_message, trailer_start;
     ++	size_t end_of_log_message = 0, trailer_block_start = 0;
       	struct strbuf **trailer_lines, **ptr;
       	char **trailer_strings = NULL;
       	size_t nr = 0, alloc = 0;
      @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
     + 	ensure_configured();
     + 
     + 	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
     +-	trailer_start = find_trailer_start(str, end_of_log_message);
     ++	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
     + 
     +-	trailer_lines = strbuf_split_buf(str + trailer_start,
     +-					 end_of_log_message - trailer_start,
     ++	trailer_lines = strbuf_split_buf(str + trailer_block_start,
     ++					 end_of_log_message - trailer_block_start,
     + 					 '\n',
     + 					 0);
     + 	for (ptr = trailer_lines; *ptr; ptr++) {
     +@@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
     + 	strbuf_list_free(trailer_lines);
       
       	info->blank_line_before_trailer = ends_with_blank_line(str,
     - 							       trailer_start);
     +-							       trailer_start);
      -	info->trailer_start = str + trailer_start;
     --	info->trailer_end = str + trailer_end;
     -+	info->trailer_start = trailer_start;
     -+	info->trailer_end = trailer_end;
     +-	info->trailer_end = str + end_of_log_message;
     ++							       trailer_block_start);
     ++	info->trailer_block_start = trailer_block_start;
     ++	info->trailer_block_end = end_of_log_message;
       	info->trailers = trailer_strings;
       	info->trailer_nr = nr;
       }
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
       	    !opts->separator && !opts->key_only && !opts->value_only &&
       	    !opts->key_value_separator) {
      -		strbuf_add(out, info->trailer_start,
     -+		strbuf_add(out, msg + info->trailer_start,
     - 			   info->trailer_end - info->trailer_start);
     +-			   info->trailer_end - info->trailer_start);
     ++		strbuf_add(out, msg + info->trailer_block_start,
     ++			   info->trailer_block_end - info->trailer_block_start);
       		return;
       	}
     + 
      @@ trailer.c: void format_trailers_from_commit(struct strbuf *out, const char *msg,
       	struct trailer_info info;
       
     @@ trailer.c: void format_trailers_from_commit(struct strbuf *out, const char *msg,
       
      
       ## trailer.h ##
     -@@ trailer.h: struct trailer_info {
     +@@ trailer.h: int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
     + struct trailer_info {
     + 	/*
     + 	 * True if there is a blank line before the location pointed to by
     +-	 * trailer_start.
     ++	 * trailer_block_start.
     + 	 */
       	int blank_line_before_trailer;
       
       	/*
     @@ trailer.h: struct trailer_info {
      -	 * is no trailer block found, these 2 pointers point to the end of the
      -	 * input string.
      +	 * Offsets to the trailer block start and end positions in the input
     -+	 * string. If no trailer block is found, these are set to 0.
     ++	 * string. If no trailer block is found, these are both set to the
     ++	 * "true" end of the input, per find_true_end_of_input().
     ++	 *
     ++	 * NOTE: This will be changed so that these point to 0 in the next
     ++	 * patch if no trailers are found.
       	 */
      -	const char *trailer_start, *trailer_end;
     -+	size_t trailer_start, trailer_end;
     ++	size_t trailer_block_start, trailer_block_end;
       
       	/*
       	 * Array of trailers found.
  -:  ----------- >  8:  1762f78a613 trailer: only use trailer_block_* variables if trailers were found
  -:  ----------- >  9:  a784c45ed71 trailer: make stack variable names match field names

-- 
gitgitgadget
