Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A20C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF8320758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+JBc4Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMKKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgGMKKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 06:10:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51073C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:10:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so12721150wmh.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=FrPE7kZfE7Iwm7ln5FtYJKUAauTUDfXOK1NfRtgazYk=;
        b=i+JBc4Ectz/Jw+RxdusGJEmisUuiWg/00vUDC98T69+cg8D2aDuD4CdtZUudXHL7Tw
         tzg7VgEoJXO5lZLQPrIaUlmOB0JEqEXJ6/nmnHf9LBRBS0d9lVGnIf8cbVbGWOGTXk/h
         GMyJhrdbS1vAh2UGIuHAAxYzqwVRmN0dPRtwp5Xbpsf9+xaCN3vLhlDIj6C4Xgdp1PEo
         8nRUOVNMuALCc9f7cHFZG0eJHU7r0Msw8ujuIjzDZyOYwcAOzxOv6r2fYVqBSpwa5n0H
         qL7/dHcaGqRM5KKBvPqnZQcYBKPAk6sh2qIpg1kyzgsSAV9mFG4r4LTTlAdFtO/4KIaX
         cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=FrPE7kZfE7Iwm7ln5FtYJKUAauTUDfXOK1NfRtgazYk=;
        b=QalTwwVtIbxhMGMf7ByDrmjD8692lzzvvJM24GPr6xBK5miIa7UPI67HuvuNY10KBd
         zYUOi2VInmZ5uGyccgVspkzwC/2GnUELRslQFOlEtOvOAEXq1w/uULbG9xz5LfZrPvn0
         SlQdJBfXly3z1FJUC3OjUhIbdYKftR/b7lFXhVhzRveMc0yFBhk7/zM2tCS+VTV0AFS7
         2FgOUU3WAf1Rxuh9l7+BRQo7dDRBkDplVLya47GSQgGHfm4bd/DBsSnyhtpxPdLcBT+R
         w9GqtpHgONNjkjH5xyi84comMJW1nAY3qr5iqTGo+Oi+vBog1gzZt/0FP7H6FuMb4TXs
         76+Q==
X-Gm-Message-State: AOAM530x1U8BAYGx5Wglf09Picx8EvWwjfAZ+3NlgK5YaHQAfR40IuWQ
        Pwc3jLw7NIFUqZATM3zmV8Q=
X-Google-Smtp-Source: ABdhPJyZxi8EISrZscGXEJ2mVo1uRcCVfDqsgCnJiWL/PD3PVGqQLnOlW+/IvadyMqMFTH/sWezhEQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr19131819wmj.73.1594635051942;
        Mon, 13 Jul 2020 03:10:51 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id v7sm23811549wrp.45.2020.07.13.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:10:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 0/5] fixup ra/rebase-i-more-options
Date:   Mon, 13 Jul 2020 11:10:40 +0100
Message-Id: <20200713101045.27335-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the comments on the last round, I've modified the
controversial conditional in the first patch as suggested by Junio and
updated patch 4 as suggested as well

Best Wishes

Phillip

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 ++++-
 builtin/rebase.c                       |  47 +++++--
 sequencer.c                            | 112 ++++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 180 +++++++++++++++++++++++++
 6 files changed, 353 insertions(+), 23 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v5:
1:  43ee10d4d5 ! 1:  5bb4226007 rebase -i: add --ignore-whitespace flag
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      
     +	if (options.type == REBASE_APPLY) {
     +		if (ignore_whitespace)
    -+			argv_array_push (&options.git_am_opts,
    -+					 "--ignore-whitespace");
    -+	} else if (ignore_whitespace) {
    -+			string_list_append (&strategy_options,
    -+					    "ignore-space-change");
    ++			argv_array_push(&options.git_am_opts,
    ++					"--ignore-whitespace");
    ++	} else {
    ++		/* REBASE_MERGE and PRESERVE_MERGES */
    ++		if (ignore_whitespace) {
    ++			string_list_append(&strategy_options,
    ++					   "ignore-space-change");
    ++		}
     +	}
     +
      	if (strategy_options.nr) {
2:  a2b57df19c ! 2:  e5fdb574ed rebase -i: support --committer-date-is-author-date
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      			allow_preemptive_ff = 0;
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      		if (ignore_whitespace)
    - 			argv_array_push (&options.git_am_opts,
    - 					 "--ignore-whitespace");
    + 			argv_array_push(&options.git_am_opts,
    + 					"--ignore-whitespace");
     +		if (options.committer_date_is_author_date)
     +			argv_array_push(&options.git_am_opts,
     +					"--committer-date-is-author-date");
    - 	} else if (ignore_whitespace) {
    - 			string_list_append (&strategy_options,
    - 					    "ignore-space-change");
    + 	} else {
    + 		/* REBASE_MERGE and PRESERVE_MERGES */
    + 		if (ignore_whitespace) {
     
      ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
3:  363a0140ad = 3:  cf5c9a2456 sequencer: rename amend_author to author_to_free
4:  46d9e108be ! 4:  0fc90eaff1 rebase -i: support --ignore-date
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     -		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
     -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
     +		OPT_BOOL(0, "ignore-date", &options.ignore_date,
    -+			 "ignore author date and use current date"),
    ++			 N_("ignore author date and use current date")),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
      				  N_("passed to 'git apply'"), 0),
      		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      					"--committer-date-is-author-date");
     +		if (options.ignore_date)
     +			argv_array_push(&options.git_am_opts, "--ignore-date");
    - 	} else if (ignore_whitespace) {
    - 			string_list_append (&strategy_options,
    - 					    "ignore-space-change");
    + 	} else {
    + 		/* REBASE_MERGE and PRESERVE_MERGES */
    + 		if (ignore_whitespace) {
     
      ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
    @@ sequencer.c: static const char *author_date_from_env_array(const struct argv_arr
     +/* Construct a free()able author string with current time as the author date */
     +static char *ignore_author_date(const char *author)
     +{
    -+	int len = strlen(author);
    ++	int len;
     +	struct ident_split ident;
     +	struct strbuf new_author = STRBUF_INIT;
     +
    -+	if (split_ident_line(&ident, author, len) < 0) {
    ++	if (split_ident_line(&ident, author, strlen(author)) < 0) {
     +		error(_("malformed ident line '%s'"), author);
     +		return NULL;
     +	}
5:  26d5eefdcb ! 5:  21cf5e5512 rebase: add --reset-author-date
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      			 &options.committer_date_is_author_date,
      			 N_("make committer date match author date")),
     -		OPT_BOOL(0, "ignore-date", &options.ignore_date,
    --			 "ignore author date and use current date"),
     +		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
    -+			 N_("ignore author date and use current date")),
    + 			 N_("ignore author date and use current date")),
     +		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
     +				N_("synonym of --reset-author-date")),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.27.0

