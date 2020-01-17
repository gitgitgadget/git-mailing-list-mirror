Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D0C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58321D56
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1Zgl9ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgAQXiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:38:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36425 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgAQXiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 18:38:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so9241696wma.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 15:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KU7Ex1GOimJIGSMmjvV1rG/DpIi3fe/U6rd5WN4zxJg=;
        b=m1Zgl9ZBom+Jd/Ps0KqqP2BVcjP78hMHG4Ca1LrDD+k19Ahogz4SAnZ7URL9+BNVoj
         a2TN5rr4RwoQ24HkAw/7Z0OiXNkxHSlOC6bTJjMRSAKnjgKOVLLT/WO5eqH6VHVZfaSY
         DSsIYtuYBewrh1LXe1DQ735SGRxdu7U1h8wF3QxiC0FWjLOyFAOvfW4eNCqNLQe1bpqe
         jwwZMr3ryRTdbb9moy7ztveXDUDuby+PmNzfSS1/OEMDM4JZ064WLSajAxohveBSkAHG
         djTVD+IK9hD+PsPul1xlMBXJZ1P+rg1HRSlyOdBD7xxbVgK8disNhTq1z86ubmEekOHe
         owOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KU7Ex1GOimJIGSMmjvV1rG/DpIi3fe/U6rd5WN4zxJg=;
        b=BewcmgqEXR+4s4O8IwuOdI1psIyrL7VLNburf1xliqzPvci7T+Yc7IF/ZIficfzs5z
         BJ3bOs3iNTyjTEf1M/NgPmRVGLt4htAcXl07nFycO0Nhpkxp6jtr7COvJX1J6MIhkLg5
         lrdm8h9cSqEVgjPQvgRhE00mJi/ombC1z/ikofHY8VZ72e96odn6Ez4KJaLHC2P+hEhY
         f3rM3LvIDB2kaizVdgqTSOnDLz2+jg02vJqiuAFcGs56OvoFCMoFgh7OzY//ZMCkeSoi
         c3iCwdYIOhJ4SmS3YJEu3oiRJiRUD/wkLimdfHcJVK8IFxLqla8qyKchgowmp24LCWMd
         ZFgQ==
X-Gm-Message-State: APjAAAXya5bn5FxzOos0h9YhaJQe7VaO8QksWsTqBsblRvd5g3HJ6AGg
        FDLprQW6zl6fLqhISAKAUlZEdB7R
X-Google-Smtp-Source: APXvYqy7PAjKd2IcugsEqRuHB1ahPmLtN3CIYg4BRb/5XGek5TAb4ZBVEpDoWhMaSfHx12TnTiWvvA==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr6909025wmg.86.1579304284968;
        Fri, 17 Jan 2020 15:38:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm11285081wmc.47.2020.01.17.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:38:04 -0800 (PST)
Message-Id: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.git.1579209506.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 23:38:00 +0000
Subject: [PATCH v2 0/3] Re-fix rebase -i with SHA-1 collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Triggered by one of brian's SHA-256 patch series, I looked at the reason why
the SHA-1 collision test case passed when it shouldn't. Turns out that the
regression test was not quite thorough enough, and the interactive rebase 
did regress recently.

While in the area, I realized that the same bug exists in the code backing
the rebase.missingCommitsCheck feature: the backed-up todo list uses
shortened commit IDs that may very well become ambiguous during the rebase.
For good measure, this patch series fixes that, too.

Finally, I saw that git rebase --edit-todo reported the line in an awkward,
maybe even incorrect, way when there was an ambiguous commit ID, and I also
fixed that.

To make sure that the code can be easily adapted to SHA-256 after these
patches, I actually already made those adjustments on top and offered them
up at https://github.com/bk2204/git/pull/1.

Changes since v1:

 * Turned the error condition when parsing the todo list with just-expanded
   commit IDs failed into a BUG().

Johannes Schindelin (3):
  parse_insn_line(): improve error message when parsing failed
  rebase -i: re-fix short SHA-1 collision
  rebase -i: also avoid SHA-1 collisions with missingCommitsCheck

 rebase-interactive.c          |  8 +++++---
 sequencer.c                   | 18 ++++++++++++++----
 t/t3404-rebase-interactive.sh | 17 +++++++++++++++--
 3 files changed, 34 insertions(+), 9 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-529%2Fdscho%2Fre-fix-rebase-i-with-sha-collisions-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-529/dscho/re-fix-rebase-i-with-sha-collisions-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/529

Range-diff vs v1:

 1:  2ae2e435b0 = 1:  2ae2e435b0 parse_insn_line(): improve error message when parsing failed
 2:  ad50cd1b92 ! 2:  102fa568dc rebase -i: re-fix short SHA-1 collision
     @@ -66,12 +66,9 @@
      +	strbuf_swap(&new_todo.buf, &buf2);
      +	strbuf_release(&buf2);
      +	new_todo.total_nr -= new_todo.nr;
     -+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0) {
     -+		fprintf(stderr, _(edit_todo_list_advice));
     -+		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
     -+		todo_list_release(&new_todo);
     -+		return error(_("invalid todo list after expanding IDs"));
     -+	}
     ++	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
     ++		BUG("invalid todo list after expanding IDs:\n%s",
     ++		    new_todo.buf.buf);
      +
       	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
       		todo_list_release(&new_todo);
 3:  e7d9ea8992 = 3:  486e9413a6 rebase -i: also avoid SHA-1 collisions with missingCommitsCheck

-- 
gitgitgadget
