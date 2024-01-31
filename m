Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547554C6D
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664152; cv=none; b=MiL8ukg4Mdu40NZotQ4hvzpLdHI2PX7L2GgyesaCa/a+djm9uRCwNM0YJk78EDltoB7tB/yTYTn3MwA1GWlq/ALGD0EEoGcLlk7RX+w12IruMWSQX+LULqUZekcJa/wkVus88fttDwbu9PRFvbdQhN45QwTLn/yblupVN7o+pJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664152; c=relaxed/simple;
	bh=YGC/bFgJK/uOsv2ojvDELXphgBk1VkQxSO+dx9fu2gM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hWDWxibPFut2uDlnGl24H9AOqJXuVfhL1IEYPyJQRHlFlQajIugIKjTtE6J1uaqc+8YmB39wafc3VAPW9amqTZaA3IKHgccrdAxElCRwRBwXjayZeidqegQQ+P4h1T6Q4vCkhQY/gmBmFVyOcb85FZH9TQlAtEHqOysXtELUpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBjR8cA2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBjR8cA2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ae38df9d2so2569927f8f.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664147; x=1707268947; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaCkUHYbmZ0QVWwPXdPeU/Cr/jKr+ahKTOzBt25o4+Q=;
        b=QBjR8cA2lJ1Di1pWARy1Gzl+FnHHfggqqq1DT2gAHJJnPFbPVrapgasozADoKqjxmZ
         poAqP/q2ksrq0GjN2gTYIeK7EYvAX+M+vymwDkyTMfEX5lfVB2nea9Y1P5vqLwzTxeaG
         RPiT77QflmMey8wzKFfSAo4yjpFWNxuA+1gWyF+JT62uMJp2X2fyf0j28iFq80peO+SD
         mN05gKPNd8A/xnleD1PuKkY6LLymcFG11Roiksi53a59k42/CXXDSz1JeFnUMaHkiKXf
         YPR1GMS6jJ6NceYDnfAdMSesL0wpQeooQYc2sqg0RqhG2oOwpnUXwvsfwsBwBM9nEYk2
         xbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664147; x=1707268947;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaCkUHYbmZ0QVWwPXdPeU/Cr/jKr+ahKTOzBt25o4+Q=;
        b=n4NxNrP2bnxxeUvq4VL3e/rdQ9i0CKarmGoH887+wH9ez70RSEP9y+Ncq6lYbDb+OX
         ykZLt+o1mPOmlPAvJ0TTcXqEgUWEkHs737GYo7sYEvMLX/zNP3VcL0/w7o1LqAQmfhL7
         cLYsCvpzFAwKVCcWu8T+Weh1YdfFv3ns9/0vRpBBFUz+WhhWYO7WPvDpR38vANy8SpTz
         I6YutwmC8YVj+pBtiIcvd1pTPFmvS/eVM/Xrlkb4XM/PXgrQ5T/nCCK/TT+c868TlU2C
         fs537rfc1BphnudiX7WRwAwb+J5vu159HY6k/+9QYQlzb/uV5r1FWRakOaTGKdJLiev6
         dpOA==
X-Gm-Message-State: AOJu0Ywnp3JLPCZ6NUrotDcU9oyO69Vmg7WXDPeBZ/nCG4NF2C6qadb0
	Ag2HxPWsXkOJFMBzGNwBb+molUFo1NUZ7w59AhD6ntIb2nPgjjfSap4biGZM
X-Google-Smtp-Source: AGHT+IHb7/lcp7dNn2Bhrqxgq9KmbagTo/YF2WR7vYMNu24v+OvVyCvFcfsd2AyZqdKc6j0Ow2G2dQ==
X-Received: by 2002:a5d:598a:0:b0:33a:eb49:bbab with SMTP id n10-20020a5d598a000000b0033aeb49bbabmr155472wri.13.1706664146741;
        Tue, 30 Jan 2024 17:22:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b0033af35a024csm5320351wrb.12.2024.01.30.17.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:26 -0800 (PST)
Message-ID: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:14 +0000
Subject: [PATCH v3 00/10] Enrich Trailer API
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>

This patch series is the first 10 patches of a larger cleanup/bugfix series
(henceforth "larger series") I've been working on. The main goal of this
series is to begin the process of "libifying" the trailer API. By "API" I
mean the interface exposed in trailer.h. The larger series brings a number
of additional cleanups (exposing and fixing some bugs along the way), and
builds on top of this series.

When the larger series is merged, we will be in a good state to additionally
pursue the following goals:

 1. "API reuse inside Git": make the API expressive enough to eliminate any
    need by other parts of Git to use the interpret-trailers builtin as a
    subprocess (instead they could just use the API directly);
 2. "API stability": add unit tests to codify the expected behavior of API
    functions; and
 3. "API documentation": create developer-focused documentation to explain
    how to use the API effectively, noting any API limitations or
    anti-patterns.

The reason why the larger series itself doesn't tackle these goals directly
is because I believe that API code should be thought from the ground up with
a libification-focused perspective. Some structs and functions exposed in
the API today should probably not be libified (read: kept in trailer.h) as
is. For example, the "trailer_iterator" struct has a "private" member and it
feels wrong to allow API users to peek inside here (and take at face value
our future API users' pinky promise that they won't depend on those private
internals not meant for public consumption).

One pattern we could use here to cleanly separate "what is the API"
(publicly exposed) and "what is the implementation" (private) is the
pointer-to-implementation ("pimpl") idiom. There may be other appropriate
patterns, but I've chosen this one because it's a simple, low-level concept
(put structs in foo.c instead of foo.h), which has far-reaching high-level
consequences (API users must rely exclusively on the API to make use of such
private structs, via opaque pointers). The pimpl idiom for C comes from the
book "C Interfaces and Implementations" (see patch "trailer: make
trailer_info struct private").

The idea of turning a public struct into a private one is a fundamental
question of libification because it forces us to reconsider all of the data
structures we have and how they're actually used by already existing users.
For the trailer API, those existing users are the "interpret-trailers"
builtin command, and anything else that includes the "trailer.h" header file
(e.g., sequencer.c). One advantage of this idiom is that even the compiler
understands it --- the compiler will loudly complain if you try to access
the innards of a private struct through an opaque pointer.

Another advantage of this idiom is that it helps to reduce the probability
of breaking changes in the API. Because a private struct's members are out
of view from our users (they only know about opaque pointers to the private
struct, not its members), we are free to modify the members of the struct at
any time, as much as we like, as long as we don't break the semantics of the
exposed API functions (which is why unit-testing these API functions will be
crucial long-term).

If this pimpl idiom turns out to be a mistake, undoing it is easy --- just
move the relevant struct definition from foo.c to the header file. So it's a
great way to try things out without digging ourselves into a pit of despair
that will be difficult to get out of.

With the libification-focused goals out of the way, let's turn to this patch
series in more detail.

Currently, we have "process_trailers()" in trailer.h which does many
different things (parse command-line arguments, create temporary files, etc)
that are independent of the concept of "trailers". Keeping this function as
an API function would make unit-testing it difficult. While there is no
technical reason why we couldn't write unit tests for the smaller functions
that are called within process_trailers(), doing so would involve testing
private ("static" in trailer.c) functions instead of API functions, which
defeats the goal of "API stability" mentioned earlier above.

As an alternative to how things are done in this patch series, we could keep
trailer.h intact and decide to unit-test the existing "trailer_info_get()"
function which does most of the trailer parsing work (and is used by
sequencer.c). However this function wouldn't be easy to test either, because
the resulting "trailer_info" struct merely contains the unparsed "trailers"
lines. So the unit test (if it wants to inspect the result of parsing these
lines) would have to invoke additional parsing functions itself. And at that
point it would no longer be a unit test in the traditional sense, because it
would be invoking multiple functions at once.

In summary this series breaks up "process_trailers()" into smaller pieces,
exposing many of the parts relevant to trailer-related processing in
trailer.h. This will force us to eventually introduce unit tests for these
API functions, but that is a good thing for API stability.

In the future after libification is "complete", users external to Git will
be able to use the same trailer processing API used by the
interpret-trailers builtin. For example, a web server may want to parse
trailers the same way that Git would parse them, without having to call
interpret-trailers as a subprocess. This use case was the original
motivation behind my work in this area.

Thanks to the aggressive refactoring in this series, I've been able to
identify and fix several bugs in our existing implementation. Those fixes
build on top of this series but were not included here, in order to keep
this series small. Below is a "shortlog" of those fixes I have locally:

 * "trailer: trailer replacement should not change its position" (If we
   found a trailer we'd like to replace, preserve its position relative to
   the other trailers found in the trailer block, instead of always moving
   it to the beginning or end of the entire trailer block.)
 * "interpret-trailers: preserve trailers coming from the input" (Sometimes,
   the parsed trailers from the input will be formatted differently
   depending on whether we provide --only-trailers or not. Make the trailers
   that were not modified and which are coming directly from the input get
   formatted the same way, regardless of this flag.)
 * "interpret-trailers: do not modify the input if NOP" (Refrain from
   subtracting or adding a newline around the patch divider "---" if we are
   not adding new trailers.)
 * "trailer formatter: split up format_trailer() monolith" (Fix a bug in
   git-log where we still printed a blank newline even if we didn't want to
   format anything.)
 * "interpret-trailers: fail if given unrecognized arguments" (E.g., for
   "--where", only accept recognized WHERE_* enum values. If we get
   something unrecognized, fail with an error instead of silently doing
   nothing. Ditto for "--if-exists" and "--if-missing".)


Notable changes in v3
=====================

 * Squashed Patch 4 into Patch 3 ("trailer: unify trailer formatting
   machinery"), to avoid breaking the build ("-Werror=unused-function"
   violations)
 * NEW (Patch 10): Introduce "trailer template" terminology for readability
   (no behavioral change)
 * (API function) Rename default_separators() to
   trailer_default_separators()
 * (API function) Rename new_trailers_clear() to free_trailer_templates()
 * trailer.h: for single-parameter functions, anonymize the parameter name
   to reduce verbosity


Notable changes in v2
=====================

 * (cover letter) Discuss goals of the larger series in more detail,
   especially the pimpl idiom
 * (cover letter) List bug fixes pending in the larger series that depend on
   this series
 * Reorder function parameters to have trailer options at the beginning (and
   out parameters toward the end)
 * "sequencer: use the trailer iterator": prefer C string instead of strbuf
   for new "raw" field
 * Patch 1 (was Patch 2) also renames ensure_configured() to
   trailer_config_init() (forgot to rename this one previously)

Linus Arver (10):
  trailer: prepare to expose functions as part of API
  trailer: move interpret_trailers() to interpret-trailers.c
  trailer: unify trailer formatting machinery
  sequencer: use the trailer iterator
  trailer: make trailer_info struct private
  trailer: spread usage of "trailer_block" language
  trailer: prepare to move parse_trailers_from_command_line_args() to
    builtin
  trailer: move arg handling to interpret-trailers.c
  trailer: delete obsolete argument handling code from API
  trailer: introduce "template" term for readability

 builtin/interpret-trailers.c | 183 ++++++--
 builtin/shortlog.c           |   7 +-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 sequencer.c                  |  35 +-
 trailer.c                    | 835 +++++++++++++++++------------------
 trailer.h                    | 105 +++--
 7 files changed, 631 insertions(+), 538 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1632

Range-diff vs v2:

  1:  e2d3ed9b5b6 !  1:  72cc12a3066 trailer: prepare to expose functions as part of API
     @@ Commit message
          them by their "trailer" moniker, just like all the other functions
          already exposed by trailer.h.
      
     -    The the opportunity to start putting trailer processions options (opts)
     +    Take the opportunity to start putting trailer processions options (opts)
          as the first parameter. This will be the pattern going forward in this
          series.
      
  2:  eaca39fd7ea !  2:  cafa39d1048 trailer: move interpret_trailers() to interpret-trailers.c
     @@ trailer.h: struct process_trailer_options {
      +void trailer_config_init(void);
      +void format_trailers(const struct process_trailer_options *opts,
      +		     struct list_head *trailers, FILE *outfile);
     -+void free_trailers(struct list_head *trailers);
     ++void free_trailers(struct list_head *);
      +
       /*
        * Format the trailers from the commit msg "msg" into the strbuf "out".
  3:  9b7747d550e !  3:  5c7a2354df0 trailer: unify trailer formatting machinery
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
       		} else if (atom->u.contents.option == C_BARE)
      
       ## trailer.c ##
     -@@ trailer.c: static void print_tok_val(FILE *outfile, const char *tok, const char *val)
     - 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
     +@@ trailer.c: static char last_non_space_char(const char *s)
     + 	return '\0';
       }
       
     +-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
     +-{
     +-	char c;
     +-
     +-	if (!tok) {
     +-		fprintf(outfile, "%s\n", val);
     +-		return;
     +-	}
     +-
     +-	c = last_non_space_char(tok);
     +-	if (!c)
     +-		return;
     +-	if (strchr(separators, c))
     +-		fprintf(outfile, "%s%s\n", tok, val);
     +-	else
     +-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
     +-}
     +-
      -void format_trailers(const struct process_trailer_options *opts,
      -		     struct list_head *trailers, FILE *outfile)
      -{
     @@ trailer.c: static void unfold_value(struct strbuf *val)
       /*
        * Parse trailers in "str", populating the trailer info and "head"
        * linked list structure.
     -@@ trailer.c: static void format_trailer_info(struct strbuf *out,
     - 
     +@@ trailer.c: void trailer_info_release(struct trailer_info *info)
     + 	free(info->trailers);
       }
       
     --void format_trailers_from_commit(struct strbuf *out, const char *msg,
     --				 const struct process_trailer_options *opts)
     +-static void format_trailer_info(struct strbuf *out,
     +-				const struct trailer_info *info,
     +-				const char *msg,
     +-				const struct process_trailer_options *opts)
      +void format_trailers_from_commit(const struct process_trailer_options *opts,
      +				 const char *msg,
      +				 struct strbuf *out)
       {
     +-	size_t origlen = out->len;
     +-	size_t i;
      +	LIST_HEAD(head);
     - 	struct trailer_info info;
     - 
     --	trailer_info_get(&info, msg, opts);
     --	format_trailer_info(out, &info, msg, opts);
     -+	parse_trailers(opts, &info, msg, &head);
     ++	struct trailer_info info;
      +
     -+	/* If we want the whole block untouched, we can take the fast path. */
     -+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     -+	    !opts->separator && !opts->key_only && !opts->value_only &&
     -+	    !opts->key_value_separator) {
     ++	parse_trailers(opts, &info, msg, &head);
     + 
     + 	/* If we want the whole block untouched, we can take the fast path. */
     + 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     + 	    !opts->separator && !opts->key_only && !opts->value_only &&
     + 	    !opts->key_value_separator) {
     +-		strbuf_add(out, msg + info->trailer_block_start,
     +-			   info->trailer_block_end - info->trailer_block_start);
     +-		return;
     +-	}
     +-
     +-	for (i = 0; i < info->trailer_nr; i++) {
     +-		char *trailer = info->trailers[i];
     +-		ssize_t separator_pos = find_separator(trailer, separators);
     +-
     +-		if (separator_pos >= 1) {
     +-			struct strbuf tok = STRBUF_INIT;
     +-			struct strbuf val = STRBUF_INIT;
     +-
     +-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
     +-			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
     +-				if (opts->unfold)
     +-					unfold_value(&val);
     +-
     +-				if (opts->separator && out->len != origlen)
     +-					strbuf_addbuf(out, opts->separator);
     +-				if (!opts->value_only)
     +-					strbuf_addbuf(out, &tok);
     +-				if (!opts->key_only && !opts->value_only) {
     +-					if (opts->key_value_separator)
     +-						strbuf_addbuf(out, opts->key_value_separator);
     +-					else
     +-						strbuf_addstr(out, ": ");
     +-				}
     +-				if (!opts->key_only)
     +-					strbuf_addbuf(out, &val);
     +-				if (!opts->separator)
     +-					strbuf_addch(out, '\n');
     +-			}
     +-			strbuf_release(&tok);
     +-			strbuf_release(&val);
     +-
     +-		} else if (!opts->only_trailers) {
     +-			if (opts->separator && out->len != origlen) {
     +-				strbuf_addbuf(out, opts->separator);
     +-			}
     +-			strbuf_addstr(out, trailer);
     +-			if (opts->separator) {
     +-				strbuf_rtrim(out);
     +-			}
     +-		}
     +-	}
     +-
     +-}
     +-
     +-void format_trailers_from_commit(struct strbuf *out, const char *msg,
     +-				 const struct process_trailer_options *opts)
     +-{
     +-	struct trailer_info info;
      +		strbuf_add(out, msg + info.trailer_block_start,
      +			   info.trailer_block_end - info.trailer_block_start);
      +	} else
      +		format_trailers(opts, &head, out);
     -+
     + 
     +-	trailer_info_get(&info, msg, opts);
     +-	format_trailer_info(out, &info, msg, opts);
      +	free_trailers(&head);
       	trailer_info_release(&info);
       }
     @@ trailer.h: void trailer_info_release(struct trailer_info *info);
      -		     struct list_head *trailers, FILE *outfile);
      +		     struct list_head *trailers,
      +		     struct strbuf *out);
     - void free_trailers(struct list_head *trailers);
     + void free_trailers(struct list_head *);
       
       /*
      - * Format the trailers from the commit msg "msg" into the strbuf "out".
  4:  f1171f5202f <  -:  ----------- trailer: delete obsolete formatting functions
  5:  5ba842b5005 =  4:  bf2b8e1a3c4 sequencer: use the trailer iterator
  6:  f0ac2f6c4b9 =  5:  c19c1dcc592 trailer: make trailer_info struct private
  7:  291aa83af55 =  6:  0a9a7438c3f trailer: spread usage of "trailer_block" language
  8:  64ee07d0b53 !  7:  97e5d86ddf0 trailer: prepare to move parse_trailers_from_command_line_args() to builtin
     @@ Commit message
          themselves). The interpret-trailers builtin is the only caller of this
          function.
      
     -    Also rename "conf_info" to "trailer_conf" for readability, dropping the
     -    low-value "_info" suffix as we did earlier in this series for
     -    "trailer_info" to "trailer_block".
     +    Rename add_arg_item() to trailer_add_arg_item() because it will have to
     +    be exposed as an API function in the next patch. Rename
     +    new_trailers_clear() to free_new_trailers() because it will be promoted
     +    into an API function; the API already has free_trailers(), so using the
     +    "free_*" naming style will keep it consistent. Also rename "conf_info"
     +    to "trailer_conf" for readability, dropping the low-value "_info" suffix
     +    as we did earlier in this series for "trailer_info" to "trailer_block".
      
          Helped-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
     + ## builtin/interpret-trailers.c ##
     +@@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct option *opt,
     + 	return trailer_set_if_missing(opt->value, arg);
     + }
     + 
     +-static void new_trailers_clear(struct list_head *trailers)
     ++static void free_new_trailers(struct list_head *trailers)
     + {
     + 	struct list_head *pos, *tmp;
     + 	struct new_trailer_item *item;
     +@@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     + 	struct new_trailer_item *item;
     + 
     + 	if (unset) {
     +-		new_trailers_clear(trailers);
     ++		free_new_trailers(trailers);
     + 		return 0;
     + 	}
     + 
     +@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     + 		interpret_trailers(&opts, &trailers, NULL);
     + 	}
     + 
     +-	new_trailers_clear(&trailers);
     ++	free_new_trailers(&trailers);
     + 
     + 	return 0;
     + }
     +
       ## trailer.c ##
      @@ trailer.c: struct trailer_block {
       	size_t trailer_nr;
     @@ trailer.c: static ssize_t find_separator(const char *line, const char *separator
       		item = list_entry(pos, struct arg_item, list);
       		if (token_matches_item(tok->buf, item, tok_len)) {
      @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
     + 	return new_item;
       }
       
     - static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
     +-static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
      -			 const struct conf_info *conf,
     -+			 const struct trailer_conf *conf,
     - 			 const struct new_trailer_item *new_trailer_item)
     +-			 const struct new_trailer_item *new_trailer_item)
     ++static void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     ++				 const struct trailer_conf *conf,
     ++				 const struct new_trailer_item *new_trailer_item)
       {
       	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
       	new_item->token = tok;
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
       	if (new_trailer_item) {
       		if (new_trailer_item->where != WHERE_DEFAULT)
       			new_item->conf.where = new_trailer_item->where;
     +@@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
     + 	list_for_each(pos, &conf_head) {
     + 		item = list_entry(pos, struct arg_item, list);
     + 		if (item->conf.command)
     +-			add_arg_item(config_head,
     +-				     xstrdup(token_from_item(item, NULL)),
     +-				     xstrdup(""),
     +-				     &item->conf, NULL);
     ++			trailer_add_arg_item(config_head,
     ++					     xstrdup(token_from_item(item, NULL)),
     ++					     xstrdup(""),
     ++					     &item->conf, NULL);
     + 	}
     + }
     + 
      @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head,
       {
       	struct strbuf tok = STRBUF_INIT;
     @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
       		} else {
      -			parse_trailer(&tok, &val, &conf, tr->text,
      -				      separator_pos);
     +-			add_arg_item(arg_head,
     +-				     strbuf_detach(&tok, NULL),
     +-				     strbuf_detach(&val, NULL),
     +-				     conf, tr);
      +			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
     - 			add_arg_item(arg_head,
     - 				     strbuf_detach(&tok, NULL),
     - 				     strbuf_detach(&val, NULL),
     ++			trailer_add_arg_item(arg_head,
     ++					     strbuf_detach(&tok, NULL),
     ++					     strbuf_detach(&val, NULL),
     ++					     conf, tr);
     + 		}
     + 	}
     + 
      @@ trailer.c: struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
       
       	for (i = 0; i < trailer_block->trailer_nr; i++) {
  9:  1b4bdde65bc !  8:  465dc51cdcb trailer: move arg handling to interpret-trailers.c
     @@ Commit message
          trailer: move arg handling to interpret-trailers.c
      
          We don't move the "arg_item" struct to interpret-trailers.c, because it
     -    is now a struct that contains information about trailers that should be
     -    injected into the input text's own trailers. We will rename this
     -    language as such in a follow-up patch to keep the diff here small.
     +    is now a struct that contains information about trailers that could be
     +    added into the input text's own trailers. This is a generic concept that
     +    extends beyond trailers defined as CLI arguments (it applies to trailers
     +    defined in configuration as well). We will rename "arg_item" to
     +    "trailer_template" in a follow-up patch to keep the diff here small.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct op
       	return trailer_set_if_missing(opt->value, arg);
       }
       
     --static void new_trailers_clear(struct list_head *trailers)
     +-static void free_new_trailers(struct list_head *trailers)
      -{
      -	struct list_head *pos, *tmp;
      -	struct new_trailer_item *item;
     @@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct op
      +	ssize_t separator_pos;
       
       	if (unset) {
     - 		new_trailers_clear(trailers);
     + 		free_new_trailers(trailers);
      @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
       	if (!arg)
       		return -1;
     @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct optio
      +		 */
      +		trailer_conf_set(where, if_exists, if_missing, conf_current);
      +
     -+		add_arg_item(strbuf_detach(&tok, NULL),
     -+			     strbuf_detach(&val, NULL),
     -+			     conf_current,
     -+			     trailers);
     ++		trailer_add_arg_item(strbuf_detach(&tok, NULL),
     ++				     strbuf_detach(&val, NULL),
     ++				     conf_current,
     ++				     trailers);
      +	} else {
      +		struct strbuf sb = STRBUF_INIT;
      +		strbuf_addstr(&sb, arg);
     @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **
      +	* In command-line arguments, '=' is accepted (in addition to the
      +	* separators that are defined).
      +	*/
     -+	cl_separators = xstrfmt("=%s", default_separators());
     ++	cl_separators = xstrfmt("=%s", trailer_default_separators());
       
       	argc = parse_options(argc, argv, prefix, options,
       			     git_interpret_trailers_usage, 0);
     @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **
      +		interpret_trailers(&opts, &arg_trailers, NULL);
       	}
       
     --	new_trailers_clear(&trailers);
     -+	new_trailers_clear(&arg_trailers);
     +-	free_new_trailers(&trailers);
     ++	free_new_trailers(&arg_trailers);
       
       	return 0;
       }
     @@ trailer.c: static LIST_HEAD(conf_head);
       
       static char *separators = ":";
       
     -+const char *default_separators(void)
     ++const char *trailer_default_separators(void)
      +{
      +	return separators;
      +}
     @@ trailer.c: ssize_t find_separator(const char *line, const char *separators)
        * Obtain the token, value, and conf from the given trailer.
        *
      + * The conf needs special handling. We first read hardcoded defaults, and
     -+ * override them if we find a matching trailer configuration in the config.
     ++ * override them if we find a matching trailer configuration.
      + *
        * separator_pos must not be 0, since the token cannot be an empty string.
        *
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
       	return new_item;
       }
       
     --static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
     --			 const struct trailer_conf *conf,
     --			 const struct new_trailer_item *new_trailer_item)
     -+void add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     -+		  struct list_head *arg_head)
     -+
     +-static void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     +-				 const struct trailer_conf *conf,
     +-				 const struct new_trailer_item *new_trailer_item)
     ++void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     ++			  struct list_head *arg_head)
       {
       	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
       	new_item->token = tok;
     @@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
       	list_for_each(pos, &conf_head) {
       		item = list_entry(pos, struct arg_item, list);
       		if (item->conf.command)
     --			add_arg_item(config_head,
     --				     xstrdup(token_from_item(item, NULL)),
     -+			add_arg_item(xstrdup(token_from_item(item, NULL)),
     - 				     xstrdup(""),
     --				     &item->conf, NULL);
     -+				     &item->conf,
     -+				     config_head);
     +-			trailer_add_arg_item(config_head,
     +-					     xstrdup(token_from_item(item, NULL)),
     ++			trailer_add_arg_item(xstrdup(token_from_item(item, NULL)),
     + 					     xstrdup(""),
     +-					     &item->conf, NULL);
     ++					     &item->conf,
     ++					     config_head);
       	}
       }
       
     @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
       			strbuf_release(&sb);
       		} else {
       			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
     --			add_arg_item(arg_head,
     --				     strbuf_detach(&tok, NULL),
     -+			add_arg_item(strbuf_detach(&tok, NULL),
     - 				     strbuf_detach(&val, NULL),
     --				     conf, tr);
     -+				     conf,
     -+				     arg_head);
     +-			trailer_add_arg_item(arg_head,
     +-					     strbuf_detach(&tok, NULL),
     ++			trailer_add_arg_item(strbuf_detach(&tok, NULL),
     + 					     strbuf_detach(&val, NULL),
     +-					     conf, tr);
     ++					     conf,
     ++					     arg_head);
       		}
       	}
       
     @@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
     -+void new_trailers_clear(struct list_head *trailers)
     ++void free_new_trailers(struct list_head *trailers)
      +{
      +	struct list_head *pos, *p;
      +
     @@ trailer.h: struct new_trailer_item {
       void duplicate_trailer_conf(struct trailer_conf *dst,
       			    const struct trailer_conf *src);
       
     -+const char *default_separators(void);
     ++const char *trailer_default_separators(void);
      +
     -+void add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     -+		  struct list_head *arg_head);
     ++void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     ++			  struct list_head *arg_head);
      +
       struct process_trailer_options {
       	int in_place;
     @@ trailer.h: struct new_trailer_item {
      @@ trailer.h: void format_trailers(const struct process_trailer_options *opts,
       		     struct list_head *trailers,
       		     struct strbuf *out);
     - void free_trailers(struct list_head *trailers);
     --
     -+void new_trailers_clear(struct list_head *new_trailers);
     + void free_trailers(struct list_head *);
     ++void free_new_trailers(struct list_head *);
     + 
       /*
        * Convenience function to format the trailers from the commit msg "msg" into
     -  * the strbuf "out". Reuses format_trailers internally.
 10:  ed67ebf8647 !  9:  885ac87a544 trailer: delete obsolete argument handling code from API
     @@ Commit message
          This commit was not squashed with its parent in order to keep the diff
          separate (to make the additive changes in the parent easier to read).
      
     +    Note that we remove the "new_trailer_item" struct, because it has some
     +    overlap with "arg_item" struct that also deals with trailers coming from
     +    the command line. The latter will be renamed to "trailer_template" in
     +    the next patch.
     +
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## trailer.c ##
     @@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
      -			strbuf_release(&sb);
      -		} else {
      -			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
     --			add_arg_item(strbuf_detach(&tok, NULL),
     --				     strbuf_detach(&val, NULL),
     --				     conf,
     --				     arg_head);
     +-			trailer_add_arg_item(strbuf_detach(&tok, NULL),
     +-					     strbuf_detach(&val, NULL),
     +-					     conf,
     +-					     arg_head);
      -		}
      -	}
      -
  -:  ----------- > 10:  bcd3fc9660e trailer: introduce "template" term for readability

-- 
gitgitgadget
