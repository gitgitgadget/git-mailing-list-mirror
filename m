Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BA81F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbeKTQjN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:39:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33341 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:39:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so438944pgu.0
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4QV3tjF1dLhoYiGEnKVkdAEUBkl/LTRlEmdjv5PrZ6E=;
        b=jpnwUhkCFTsXPpS6Eo19ksckyUggO/DhUhGf4FRYNiC7yZFAfoheIiYIf3uojBlPMC
         7LB+q00unBiXa66cuBK6WKhzS9ZIQHbISIsqifCywhp9kQcofTDreDsHHTCGg+6w43zW
         ZkISTe7bTNbUuLVIb/wCDNOYBu2gGGWHV+fFwewRrZpseVNJephlGQUOFuxYlE4wpDLl
         Vj8FHdo/iWq4myhFObPae4DRaPrj7ws7dN2HjGdnLEDbQTkz7RwNWFqFG/1xVEFL/GRA
         n5oL4hstftqE118YmkZhhJMBs8JhXM5RrDQjwWf0uCpabwLi2dhwSMLGomZmJqPcsMkC
         1xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QV3tjF1dLhoYiGEnKVkdAEUBkl/LTRlEmdjv5PrZ6E=;
        b=XFvUBlt0K5FtjvV4zvDg5rx0fAue3ZCsOtgcNdJeCVrMagknX8QoUQ4SQ71+7J+j99
         Zxkp9YL7ZLlPwcThqqK1r+BDl33pL0Dxw5NXReB0Qa7ZIghP42ca8NppWEflDLWhL/8o
         UaXpLKhaHh3VgVS66vgLjfIuZo3v6xIEGIJwlNVibh8oqZ2RTDamOWi4wcU7QzXPoOwS
         1RAkL8IS0nL29rF/c8ztVI0FZHWd599mFsEb+wUpcpzsyQjPHtMu+v/L9TZtKvpg783n
         +y0HCnsOQMPB8EbT8iFBRaRuUGKSxSqxpa5ZavmJgheuV4QSMEcFv7PSwn3s0Q8a9ZxH
         FhxA==
X-Gm-Message-State: AA+aEWbYgto0kbTOzgPo9M0CVBxvtNUYFEPcmVDN+npEnnZ1DfeRqMKv
        lXmMJIHkt/bX1ZPnX8wy8kpZQ9XQ
X-Google-Smtp-Source: AFSGD/XtWzjspzZGmlsiWk9xlWkxIuLHgTXcHRQIXqMGDE9XPVbbnQ4I8c/72HITBTYNcjCKIkZpcA==
X-Received: by 2002:a63:86c2:: with SMTP id x185mr707538pgd.230.1542694309363;
        Mon, 19 Nov 2018 22:11:49 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v89sm10651306pfk.12.2018.11.19.22.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:11:48 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:11:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH 1/5] eoie: default to not writing EOIE section
Message-ID: <20181120061147.GB144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060920.GA144753@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3b1d9e04 (eoie: add End of Index Entry (EOIE) extension,
2018-10-10) Git defaults to writing the new EOIE section when writing
out an index file.  Usually that is a good thing because it improves
threaded performance, but when a Git repository is shared with older
versions of Git, it produces a confusing warning:

  $ git status
  ignoring EOIE extension
  HEAD detached at 371ed0defa
  nothing to commit, working tree clean

Let's introduce the new index extension more gently.  First we'll roll
out the new version of Git that understands it, and then once
sufficiently many users are using such a version, we can flip the
default to writing it by default.

Introduce a '[index] recordEndOfIndexEntries' configuration variable
to allow interested users to benefit from this index extension early.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Rebased.  No other change from v1.

As Jonathan pointed out, it would be nice to have tests here.  Ben,
any advice for how I could write some in a followup change?  E.g. does
Derrick Stolee's tracing based testing trick apply here?

 Documentation/config/index.txt |  7 +++++++
 read-cache.c                   | 11 ++++++++++-
 t/t1700-split-index.sh         | 11 +++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 4b94b6bedc..8e138aba7a 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -1,3 +1,10 @@
+index.recordEndOfIndexEntries::
+	Specifies whether the index file should include an "End Of Index
+	Entry" section. This reduces index load time on multiprocessor
+	machines but produces a message "ignoring EOIE extension" when
+	reading the index using Git versions before 2.20. Defaults to
+	'false'.
+
 index.threads::
 	Specifies the number of threads to spawn when loading the index.
 	This is meant to reduce index load time on multiprocessor machines.
diff --git a/read-cache.c b/read-cache.c
index 4ca81286c0..1e9c772603 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2689,6 +2689,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
+static int record_eoie(void)
+{
+	int val;
+
+	if (!git_config_get_bool("index.recordendofindexentries", &val))
+		return val;
+	return 0;
+}
+
 /*
  * On success, `tempfile` is closed. If it is the temporary file
  * of a `struct lock_file`, we will therefore effectively perform
@@ -2936,7 +2945,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * read.  Write it out regardless of the strip_extensions parameter as we need it
 	 * when loading the shared index.
 	 */
-	if (offset) {
+	if (offset && record_eoie()) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_eoie_extension(&sb, &eoie_c, offset);
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 2ac47aa0e4..0cbac64e28 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -25,14 +25,17 @@ test_expect_success 'enable split index' '
 	git update-index --split-index &&
 	test-tool dump-split-index .git/index >actual &&
 	indexversion=$(test-tool index-version <.git/index) &&
+
+	# NEEDSWORK: Stop hard-coding checksums.
 	if test "$indexversion" = "4"
 	then
-		own=3527df833c6c100d3d1d921a9a782d62a8be4b58
-		base=746f7ab2ed44fb839efdfbffcf399d0b113fb4cb
+		own=432ef4b63f32193984f339431fd50ca796493569
+		base=508851a7f0dfa8691e9f69c7f055865389012491
 	else
-		own=5e9b60117ece18da410ddecc8b8d43766a0e4204
-		base=4370042739b31cd17a5c5cd6043a77c9a00df113
+		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
+		base=39d890139ee5356c7ef572216cebcd27aa41f9df
 	fi &&
+
 	cat >expect <<-EOF &&
 	own $own
 	base $base
-- 
2.20.0.rc0.387.gc7a69e6b6c

