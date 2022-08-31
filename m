Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0741ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiHaUbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiHaUbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:31:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F18DEA40
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m16so19705660wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=8UWocGFLaKvJ7Bd8PHZWSlyNCiESPLt0wLH6afVOi8s=;
        b=WuJevxYEyu/zxFSQzhVtJES7F+SHlEqVSZaaVCer+RbbNuNkghNnKZ/9AHwbvcVyUA
         6X3wZaCJ9kGL6wLsfAieQkzMzYrTSsV87reD3dddfgx6WTUTYn3sASQ44Y5UXLCh6P7s
         GPB1UiNSQ73OkjhmLuNNOpaODhP/+IOzYcJZycuHyZ/nxEzEJemfVXHxRIgnlrSD7Xnh
         by7wnWCwgikJvrHVmXQUstQXTlvFGBZ6oI+YOztgrtbi57A53xI7FmoZocTh6I6mSpAv
         ykjyG5wd6fmRjE86ECAMSeCKhre/kvceeKWURkNb3Th5RXrJa/jCt4jq+oVGU+wz/DoC
         xbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=8UWocGFLaKvJ7Bd8PHZWSlyNCiESPLt0wLH6afVOi8s=;
        b=Hyiltcj2cZ8ED1qJ1BhKQcCpRQxjEGYfzk6LaWLX9HPLkuBsFtVP/2JHLJmgyR8M/a
         w89Q2ceieGOosLTsgl1imZBQ4ozNTJJjt2z3QNzTbio4Y+RM4RZmWt3VD7OJTengkNnE
         eSW+Y1KIVMdYeC3Ikm/s+lA/vcX4HJyfEQyLCfl+g0N9J/Boe2fqPq2dA5fpPuSU7W+Y
         I0bdNPNSjXBWouxp7VT/rs8//tdevFDIFp2uecUz+lxkR1wQDacU4cr5F+o0bjhYndnD
         89xhWFpw2Gc+4CvC7G4J5EJLM+dZGf35kUDtEJ93nqJjxHkNLpbwAWyQU2jVN4MpDKzr
         fX3Q==
X-Gm-Message-State: ACgBeo10ZBcFTFIddvyTvF2IKFB+ULYLgl247K29KQ3NZvSlxd9nudOc
        1pvuGdMeYoAASDBKrDAknATQAsjjHp0=
X-Google-Smtp-Source: AA6agR7RDrHNgDz0qxynO7EEQgAIFWgUXhCf7lK3+PAUeVbEcoOw/gfprfPFG2RLf78C3Ol24PEcsg==
X-Received: by 2002:adf:e101:0:b0:225:a31:854b with SMTP id t1-20020adfe101000000b002250a31854bmr12325424wrz.143.1661977879983;
        Wed, 31 Aug 2022 13:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a844885f88sm2897888wmp.22.2022.08.31.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:31:18 -0700 (PDT)
Message-Id: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 20:31:14 +0000
Subject: [PATCH v4 0/3] built-in add -p: support diff-so-fancy better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain reported in
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
that there is a problem when running the built-in version of git add -p with
diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
The symptom is this:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'


This patch series addresses that and should fix
https://github.com/so-fancy/diff-so-fancy/issues/437

Changes since v3:

 * Instead of deviating from how the Perl version of git add -p did things,
   we now teach the built-in version to display hunk headers verbatim when
   no line range could be parsed out (instead of showing the line range
   anyways). This was a very good idea of Phillip's, dramatically
   simplifying the patch series.
 * Also, this iteration drops the first patch that claims to redefine what
   we consider bogus, but only hides an off-by-one. In its stead, there is
   now a patch that fixes said off-by-one.

Changes since v2:

 * Added the appropriate "Reported-by" trailer to the commit message.
 * Split out the logic to insert a space between the colored line range and
   the extra information, if needed.
 * That logic was now corrected to see whether that space is really needed.
 * To verify that the logic does what we need it to do, the added regression
   test now specifically tests for that (single) extra space that we want to
   be inserted.
 * Reworded a stale comment that claimed that we might suppress the entire
   colored hunk header (which we no longer do).
 * Rebased to the current tip of the main branch to avoid a merge conflict
   with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-blocking,
   2022-08-17).

Changes since v1:

 * Added a commit to ignore dirty submodules just like the Perl version
   does.

Johannes Schindelin (3):
  add -p: detect more mismatches between plain vs colored diffs
  add -p: gracefully handle unparseable hunk headers in colored diffs
  add -p: ignore dirty submodules

 add-patch.c                | 50 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 27 ++++++++++++++++++--
 2 files changed, 53 insertions(+), 24 deletions(-)


base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1336

Range-diff vs v3:

 1:  a01fa5d25e4 ! 1:  25187c3a3c2 t3701: redefine what is "bogus" output of a diff filter
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    t3701: redefine what is "bogus" output of a diff filter
     +    add -p: detect more mismatches between plain vs colored diffs
      
          When parsing the colored version of a diff, the interactive `add`
          command really relies on the colored version having the same number of
     -    lines as the non-colored version. That is an invariant.
     -
     -    However, in the 'detect bogus diffFilter output' test case in t3701, we
     -    essentially required a hunk header that contains parseable `@@ ... @@`
     -    hunk headers, and called all colored diffs without such hunks bogus.
     -
     -    The reason for this is that we would like to show the users the adjusted
     -    hunk headers _including_ the extra part after the `@@ ... @@`
     -    information, which usually contains things like the function name or
     -    soms such.
     -
     -    Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
     -    that does not produce such colored diffs as the built-in `add` command
     -    expects. Nevertheless, the Perl variant of the `add` command handles
     -    those nicely, essentially by ignoring the hunk header and saying "there
     -    is nothing else we can show except the original hunk header, even if we
     -    had to adjust the line range and the original hunk header might get that
     -    wrong".
     -
     -    In preparation for teaching the built-in interactive `add` to be a bit
     -    more lenient, let's change the 'detect bogus diffFilter output' test
     -    case so that it verifies that a mismatched number of lines causes the
     -    command to error out, but not an unparseable hunk header.
     +    lines as the plain (uncolored) version. That is an invariant.
     +
     +    We already have code to verify correctly when the colored diff has less
     +    lines than the plain diff. Modulo an off-by-one bug: If the last diff
     +    line has no matching colored one, the code pretends to succeed, still.
     +
     +    To make matters worse, when we adjusted the test in 1e4ffc765db (t3701:
     +    adjust difffilter test, 2020-01-14), we did not catch this because `add
     +    -p` fails for a _different_ reason: it does not find any colored hunk
     +    header that contains a parseable line range.
     +
     +    If we change the test case so that the line range _can_ be parsed, the
     +    bug is exposed.
     +
     +    Let's address all of the above by
     +
     +    - fixing the off-by-one,
     +
     +    - adjusting the test case to allow `add -p` to parse the line range
     +
     +    - making the test case more stringent by verifying that the expected
     +      error message is shown
     +
     +    Also adjust a misleading code comment about the now-fixed code.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## add-patch.c ##
     +@@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
     + 			if (colored_eol)
     + 				colored_p = colored_eol + 1;
     + 			else if (p != pend)
     +-				/* colored shorter than non-colored? */
     ++				/* non-colored has more lines? */
     ++				goto mismatched_output;
     ++			else if (colored_p == colored_pend)
     ++				/* last line has no matching colored one? */
     + 				goto mismatched_output;
     + 			else
     + 				colored_p = colored_pend;
     +
       ## t/t3701-add-interactive.sh ##
      @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
       	git reset --hard &&
       
       	echo content >test &&
      -	test_config interactive.diffFilter "sed 1d" &&
     -+	test_config interactive.diffFilter "sed q" &&
     ++	test_config interactive.diffFilter "sed 6d" &&
       	printf y >y &&
     - 	force_color test_must_fail git add -p <y
     +-	force_color test_must_fail git add -p <y
     ++	force_color test_must_fail git add -p <y >output 2>&1 &&
     ++	grep "mismatched output" output
       '
     + 
     + test_expect_success 'handle very large filtered diff' '
 2:  cbe833bd141 ! 2:  cd1c5100506 add -p: gracefully ignore unparseable hunk headers in colored diffs
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    add -p: gracefully ignore unparseable hunk headers in colored diffs
     +    add -p: gracefully handle unparseable hunk headers in colored diffs
      
          In
          https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
     @@ Commit message
          and therefore we cannot detect any part in that header that comes after
          the line range.
      
     -    Let's punt for now and simply show nothing apart from the line range in
     -    that case.
     +    As proposed by Phillip Wood, let's take that for a clear indicator that
     +    we should show the hunk headers verbatim. This is what the Perl version
     +    of the interactive `add` command did, too.
     +
     +    This commit is best viewed with `--color-moved --ignore-space-change`.
      
          [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
      
          Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## add-patch.c ##
     +@@ add-patch.c: struct hunk_header {
     + 	 * include the newline.
     + 	 */
     + 	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
     ++	unsigned suppress_colored_line_range:1;
     + };
     + 
     + struct hunk {
      @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
     - 	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
       	if (!eol)
       		eol = s->colored.buf + s->colored.len;
     --	p = memmem(line, eol - line, "@@ -", 4);
     + 	p = memmem(line, eol - line, "@@ -", 4);
      -	if (!p)
      -		return error(_("could not parse colored hunk header '%.*s'"),
      -			     (int)(eol - line), line);
     @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
      -	if (!p)
      -		return error(_("could not parse colored hunk header '%.*s'"),
      -			     (int)(eol - line), line);
     - 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
     --	header->colored_extra_start = p + 3 - s->colored.buf;
     -+	p = memmem(line, eol - line, "@@ -", 4);
      +	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
      +		header->colored_extra_start = p + 3 - s->colored.buf;
     -+	else
     -+		/* could not parse colored hunk header, showing nothing */
     ++	else {
     ++		/* could not parse colored hunk header, leave as-is */
      +		header->colored_extra_start = hunk->colored_start;
     ++		header->suppress_colored_line_range = 1;
     ++	}
     + 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
     +-	header->colored_extra_start = p + 3 - s->colored.buf;
       	header->colored_extra_end = hunk->colored_start;
       
       	return 0;
     +@@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
     + 				- header->colored_extra_start;
     + 		}
     + 
     +-		if (s->mode->is_reverse)
     +-			old_offset -= delta;
     +-		else
     +-			new_offset += delta;
     +-
     +-		strbuf_addf(out, "@@ -%lu", old_offset);
     +-		if (header->old_count != 1)
     +-			strbuf_addf(out, ",%lu", header->old_count);
     +-		strbuf_addf(out, " +%lu", new_offset);
     +-		if (header->new_count != 1)
     +-			strbuf_addf(out, ",%lu", header->new_count);
     +-		strbuf_addstr(out, " @@");
     ++		if (!colored || !header->suppress_colored_line_range) {
     ++			if (s->mode->is_reverse)
     ++				old_offset -= delta;
     ++			else
     ++				new_offset += delta;
     ++
     ++			strbuf_addf(out, "@@ -%lu", old_offset);
     ++			if (header->old_count != 1)
     ++				strbuf_addf(out, ",%lu", header->old_count);
     ++			strbuf_addf(out, " +%lu", new_offset);
     ++			if (header->new_count != 1)
     ++				strbuf_addf(out, ",%lu", header->new_count);
     ++			strbuf_addstr(out, " @@");
     ++		}
     + 
     + 		if (len)
     + 			strbuf_add(out, p, len);
      
       ## t/t3701-add-interactive.sh ##
      @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
     - 	force_color test_must_fail git add -p <y
     + 	grep "mismatched output" output
       '
       
      +test_expect_success 'handle iffy colored hunk headers' '
     @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output'
      +
      +	echo content >test &&
      +	printf n >n &&
     -+	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
     -+		add -p <n
     ++	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
     ++		add -p >output 2>&1 <n &&
     ++	grep "^[^@]*XX[^@]*$" output
      +'
      +
       test_expect_success 'handle very large filtered diff' '
 3:  7a9f0b107e6 < -:  ----------- add -p: insert space in colored hunk header as needed
 4:  e3e3a178f98 < -:  ----------- add -p: handle `diff-so-fancy`'s hunk headers better
 5:  cfa6914aee0 = 3:  116f0cf5cab add -p: ignore dirty submodules

-- 
gitgitgadget
