Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A64C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0768C6108E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFHQOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:14:39 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36672 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhFHQOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 12:14:39 -0400
Received: by mail-wr1-f47.google.com with SMTP id e11so12001495wrg.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=EFVbDjK6SqZ0+OxD+Qns6eJAHEOMQW2yiWPKzfdNB6s=;
        b=LGhLk82XXKn2iL8hkd/u3i5bPEjR+ttmxb1RQUaK84f25WUWKACJ/xLl+YxK+nA9gj
         Whg9zbvPRAqFfYPMgo4cYY8cKA6TL+5IbK5ZjY3B52vRPQNvxkBvgF1arAR2oe3RCSeq
         OdL20jnMnADj5K8obVbDDycj4bqjrpyZRLnahnNN1nkkax0by8l2TxegcxF1oKrpiQ73
         nJ5nkmXW1oBHSbtxlN7rBn+imqHGbXvziHeqzZMR14lD0ld3meS4EeveDE+ghSleUQ1B
         FOaiHaYEXMxcOLOHXfd6CoIJLK/0/pVRP61mwKLbpM4d2y/R6Od57fx/2tm+2UgQIxnc
         buoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=EFVbDjK6SqZ0+OxD+Qns6eJAHEOMQW2yiWPKzfdNB6s=;
        b=rrr2UfxdiyyonO6rsymirHFF+QJ0T/WBZMRAQGLwG9oW/4AyRQVoK013E0i4RWkXoo
         fftVW38SYIR2AQvPhBaSSttWdPXONoZmYo2Re/aKyUcgVCRhPv3Ym1ztWaa90nkeYiVD
         56l4NQePk18QWD5rdAlhHxENsuJS+u3aoaK1jVCF31+1Rj51QpJKYBhqnLYnQAXfok89
         AtYnq6f+GrDSQ9HZHMlvGzcGte1Qwg/v5Fx0cZN3aw78H6C1KhnbDlcHJo0WrSaMhPLj
         x7Q7NHqVBl8x4tSl4KQgCPDrZveohYhJN0MBg387nJEEiXiKezhvo4xiOYgKbG0scnTT
         Oinw==
X-Gm-Message-State: AOAM533k0up9wIpPQHa37FMDUNr2pglnc8uxMtbQsnq6nZcXdjR6viLZ
        vtUObMkH1HP/3bdeXgVX0DQhlMYzfFE=
X-Google-Smtp-Source: ABdhPJxGHVolyK5rvz6zgMRQ9+Sd7/7TW7rtO2RwRjO/BQ5uIrQCATZCSexKtxQ5E0qGZWLM0HyqrQ==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr23042347wre.402.1623168705206;
        Tue, 08 Jun 2021 09:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm20331237wrr.48.2021.06.08.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:11:44 -0700 (PDT)
Message-Id: <140c1e89e0ec69c5c5e8a99b632c1cf25c2325d4.1623168703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
References: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
        <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 16:11:39 +0000
Subject: [PATCH v4 1/4] merge-ort: replace string_list_df_name_compare with
 faster alternative
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Gathering accumulated times from trace2 output on the mega-renames
testcase, I saw the following timings (where I'm only showing a few
lines to highlight the portions of interest):

    10.120 : label:incore_nonrecursive
        4.462 : ..label:process_entries
           3.143 : ....label:process_entries setup
              2.988 : ......label:plist special sort
           1.305 : ....label:processing
        2.604 : ..label:collect_merge_info
        2.018 : ..label:merge_start
        1.018 : ..label:renames

In the above output, note that the 4.462 seconds for process_entries was
split as 3.143 seconds for "process_entries setup" and 1.305 seconds for
"processing" (and a little time for other stuff removed from the
highlight).  Most of the "process_entries setup" time was spent on
"plist special sort" which corresponds to the following code:

    trace2_region_enter("merge", "plist special sort", opt->repo);
    plist.cmp = string_list_df_name_compare;
    string_list_sort(&plist);
    trace2_region_leave("merge", "plist special sort", opt->repo);

In other words, in a merge strategy that would be invoked by passing
"-sort" to either rebase or merge, sorting an array takes more time than
anything else.  Serves me right for naming my merge strategy this way.

Rewrite the comparison function in a way that does not require finding
out the lengths of the strings when comparing them.  While at it, tweak
the code for our specific case -- no need to handle a variety of modes,
for example.  The combination of these changes reduced the time spent in
"plist special sort" by ~25% in the mega-renames case.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.622 s ±  0.059 s     5.235 s ±  0.042 s
    mega-renames:     10.127 s ±  0.073 s     9.419 s ±  0.107 s
    just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c | 67 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 142d44d74d63..061f15701359 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2746,31 +2746,58 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 /*** Function Grouping: functions related to process_entries() ***/
 
-static int string_list_df_name_compare(const char *one, const char *two)
+static int sort_dirs_next_to_their_children(const char *one, const char *two)
 {
-	int onelen = strlen(one);
-	int twolen = strlen(two);
+	unsigned char c1, c2;
+
 	/*
-	 * Here we only care that entries for D/F conflicts are
-	 * adjacent, in particular with the file of the D/F conflict
-	 * appearing before files below the corresponding directory.
-	 * The order of the rest of the list is irrelevant for us.
+	 * Here we only care that entries for directories appear adjacent
+	 * to and before files underneath the directory.  We can achieve
+	 * that by pretending to add a trailing slash to every file and
+	 * then sorting.  In other words, we do not want the natural
+	 * sorting of
+	 *     foo
+	 *     foo.txt
+	 *     foo/bar
+	 * Instead, we want "foo" to sort as though it were "foo/", so that
+	 * we instead get
+	 *     foo.txt
+	 *     foo
+	 *     foo/bar
+	 * To achieve this, we basically implement our own strcmp, except that
+	 * if we get to the end of either string instead of comparing NUL to
+	 * another character, we compare '/' to it.
+	 *
+	 * If this unusual "sort as though '/' were appended" perplexes
+	 * you, perhaps it will help to note that this is not the final
+	 * sort.  write_tree() will sort again without the trailing slash
+	 * magic, but just on paths immediately under a given tree.
 	 *
-	 * To achieve this, we sort with df_name_compare and provide
-	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
-	 * We use the mode S_IFDIR for everything else for simplicity,
-	 * since in other cases any changes in their order due to
-	 * sorting cause no problems for us.
+	 * The reason to not use df_name_compare directly was that it was
+	 * just too expensive (we don't have the string lengths handy), so
+	 * it was reimplemented.
 	 */
-	int cmp = df_name_compare(one, onelen, S_IFDIR,
-				  two, twolen, S_IFDIR);
+
 	/*
-	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
-	 * that 'foo' comes before 'foo/bar'.
+	 * NOTE: This function will never be called with two equal strings,
+	 * because it is used to sort the keys of a strmap, and strmaps have
+	 * unique keys by construction.  That simplifies our c1==c2 handling
+	 * below.
 	 */
-	if (cmp)
-		return cmp;
-	return onelen - twolen;
+
+	while (*one && (*one == *two)) {
+		one++;
+		two++;
+	}
+
+	c1 = *one ? *one : '/';
+	c2 = *two ? *two : '/';
+
+	if (c1 == c2) {
+		/* Getting here means one is a leading directory of the other */
+		return (*one) ? 1 : -1;
+	} else
+		return c1 - c2;
 }
 
 static int read_oid_strbuf(struct merge_options *opt,
@@ -3481,7 +3508,7 @@ static void process_entries(struct merge_options *opt,
 	trace2_region_leave("merge", "plist copy", opt->repo);
 
 	trace2_region_enter("merge", "plist special sort", opt->repo);
-	plist.cmp = string_list_df_name_compare;
+	plist.cmp = sort_dirs_next_to_their_children;
 	string_list_sort(&plist);
 	trace2_region_leave("merge", "plist special sort", opt->repo);
 
-- 
gitgitgadget

