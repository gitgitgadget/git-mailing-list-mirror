Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429AA20209
	for <e@80x24.org>; Wed, 24 May 2017 21:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035935AbdEXVkr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:40:47 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34517 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033533AbdEXVkm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:42 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so147332869pfj.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vSP2lSsoHc30TAsh1D9tWqU18xtvLby2lMlXYdQV8UA=;
        b=rHBOya3eEmDiSgN13xGVkYmF7kvB0+hbOdP3Z8VNDfnA/uAHdipq9e7HurGHbWzGLl
         LgNEC2K/kzaYNy1AjFl/JxQwmuXm9lQwl6iZJsMEA+JQyR7H0Kyxbxa4DcPe0szDp9hR
         Z/Ky0d/doqgvJaRv3h2+a8fQ2JL4LX0DtEvj45FF5b4okTUNhfBe2Wt19wuoLfPnvhWf
         nksoYN8SJQ3B79XKCPvCHy5yIbIJfFoXECJ16rokGESLgTfCfGJFBQ+wnofmrm4WLTpG
         utkh6ItzwLRTmKAycotWOdsOk8A1qKA3xcWTGI3zqJE+rH3XkGMjziwIurSQhawvKTPH
         w9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vSP2lSsoHc30TAsh1D9tWqU18xtvLby2lMlXYdQV8UA=;
        b=USjdVIMo/Pssn7IWts/vSgxsHyhydjwV6Y/HfjLSLeG+E55UwPMXwQPXMApD3AEtrW
         TOilig79NkrE7475L1tcPOpyaP4oavjtoCqtCfA0RyXxCnzT89h+5q+Vbo70yqaoMqjs
         UqrWfxgMGEtyXUceEEHP2jt4bt7iKLHbNjXwdgkHexX4HjbjbUhhsl+NY7h7y/MdaOn9
         QiTea5m1pK+pLHEmXNk4sJTxbnbExdi+uK8fxZeFjGPAbZ7uT8oyHZPOrRYuZ4m+GEyi
         55LG5NJBY8PQjDO/TO2A9/n/7Rk0ZEepzW09cwjlU35M4XhDLXzYEd2sVJs3Mc8gmYOS
         ls9Q==
X-Gm-Message-State: AODbwcArTmn41iLiCqDWUdbYe86UsCol/4frtec24iw7wZKwMsR4Gz6D
        AWuzaDbzlWl6EYZk
X-Received: by 10.99.184.2 with SMTP id p2mr41909886pge.126.1495662041487;
        Wed, 24 May 2017 14:40:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id o66sm9497229pga.64.2017.05.24.14.40.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 00/17] Diff machine: highlight moved lines.
Date:   Wed, 24 May 2017 14:40:19 -0700
Message-Id: <20170524214036.29623-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com/>
References: <20170523024048.16879-1-sbeller@google.com/>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5:
* removed the color passing to the submodule to make the tests pass again.
* fixed an indentation issue that was introduced from v3 -> v4.
* I merged it with origin/next and tests pass here.

Thanks,
Stefan

diff to v4:
diff --git a/diff.c b/diff.c
index 23e70d348e..1292d3c4ad 100644
--- a/diff.c
+++ b/diff.c
@@ -751,7 +751,7 @@ static void mark_color_as_moved(struct diff_options *o,
 }
 
 static void emit_diff_line(struct diff_options *o,
-				     struct diff_line *e)
+			   struct diff_line *e)
 {
 	const char *ws;
 	int has_trailing_newline, has_trailing_carriage_return;
@@ -804,7 +804,7 @@ static void emit_diff_line(struct diff_options *o,
 }
 
 static void append_diff_line(struct diff_options *o,
-				       struct diff_line *e)
+			     struct diff_line *e)
 {
 	struct diff_line *f;
 	ALLOC_GROW(o->line_buffer,
diff --git a/submodule.c b/submodule.c
index 428c996c97..19c63197fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -550,8 +550,6 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 
 	/* TODO: other options may need to be passed here. */
 	argv_array_push(&cp.args, "diff");
-	if (o->use_color)
-		argv_array_push(&cp.args, "--color=always");
 	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",

v4:
* interdiff to v3 (what is currently origin/sb/diff-color-move) below.
* renamed the "buffered_patch_line" to "diff_line". Originally I planned
  to not carry the "line" part as it can be a piece of a line as well.
  But for the intended functionality it is best to keep the name.
  If we'd want to add more functionality to say have a move detection
  for words as well, we'd rename the struct to have a better name then.
  For now diff_line is the best. (Thanks Jonathan Nieder!)
* tests to demonstrate it doesn't mess with --color-words as well as
  submodules. (Thanks Jonathan Tan!)
* added in the statics (Thanks Ramsay!)
* smaller scope for the hashmaps (Thanks Jonathan Tan!)
* some commit messages were updated, prior patch 4-7 is squashed into one
  (Thanks Jonathan Tan!)
* the tests added revealed an actual fault: now that the submodule process
  is not attached to a dupe of our stdout, it would stop coloring the
  output. We need to pass on use-color explicitly.
* updated the NEEDSWORK comment in the second last patch.

Thanks for bearing,
Stefan

v3:
* see interdiff below.
* fixing one invalid computation (Thanks Junio!)
* I reasoned more about submodule and word diffing, see the commit message
  of the last patch:
  
    A note on the options '--submodule=diff' and '--color-words/--word-diff':
    In the conversion to use emit_line in the prior patches both submodules
    as well as word diff output carefully chose to call emit_line with sign=0.
    All output with sign=0 is ignored for move detection purposes in this
    patch, such that no weird looking output will be generated for these
    cases. This leads to another thought: We could pass on '--color-moved' to
    submodules such that they color up moved lines for themselves. If we'd do
    so only line moves within a repository boundary are marked up.

* better name for emit_line outside of diff.[ch]

v2:
* emit_line now takes an argument that indicates if we want it
  to emit the line prefix as well. This should allow for a more faithful
  refactoring in the beginning. (Thanks Jonathan!)
* fixed memleaks (Thanks Brandon!)
* "git -c color.moved=true log -p" works now! (Thanks Jeff)
* interdiff below, though it is large.
* less intrusive than v1 (Thanks Jonathan!)

v1:

For details on *why* see the commit message of the last commit.

The first five patches are slight refactorings to get into good
shape, the next patches are funneling all output through emit_line_*.

The second last patch introduces an option to buffer up all output
before printing, and then the last patch can color up moved lines
of code.

Any feedback welcome.

Thanks,
Stefan

Stefan Beller (17):
  diff: readability fix
  diff: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff: introduce more flexible emit function
  diff.c: convert fn_out_consume to use emit_line
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff.c: emit_line includes whitespace highlighting
  diff: buffer all output if asked to
  diff.c: color moved lines differently

 Documentation/config.txt   |  14 +-
 diff.c                     | 858 +++++++++++++++++++++++++++++++++------------
 diff.h                     |  59 +++-
 submodule.c                |  87 ++---
 submodule.h                |   9 +-
 t/t4015-diff-whitespace.sh | 267 ++++++++++++++
 6 files changed, 1016 insertions(+), 278 deletions(-)

-- 
2.13.0.18.g7d86cc8ba0

