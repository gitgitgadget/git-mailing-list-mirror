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
	by dcvr.yhbt.net (Postfix) with ESMTP id 403D71F97E
	for <e@80x24.org>; Tue, 13 Nov 2018 00:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeKMKet (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:34:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:34:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id w24-v6so5119013plq.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w71mYpvTg7730xMP7bCLOcehXAt9/1wK5hm3mwoqscc=;
        b=Z2G4mKMIejAGw0EhWycW1inS0v5p7ZP4qr4JQnfGdn10TSzVhsdb7E0g8YMBBilBxI
         ypOJO58OtnRGPY/Gk/R5Tjgn2vnnLvh9vY2ep3X7T6L0H2Fh7d6DT9YfKbvey1m9OJcK
         kcLvIQep1maLL7U1NA1WGMP5m7eMFLadrXig+fo5BWc6rbk6p7sjnMB94Ka6k9NbJoqb
         K6DO6UnARVq3HA6vJGGTX2JyQeN7Fi4n61klmSW7UfxP4i/pHM0oBVs3jNWMdaKMCbzf
         BXWTSXpJgGavbG7WGN6AgePNE7xp6I7Yser2DaSVlcw6AssGUQHRLZ/v/yWcZ4dv1S6T
         tbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w71mYpvTg7730xMP7bCLOcehXAt9/1wK5hm3mwoqscc=;
        b=SdVsfA/e/s1qNr2tzXJJqnLN1WdAFmXMO6ky7LudmhtkjwCRMAx+5hqWLlANXHN1pp
         KZQgxxd09XsH32csNyMEGcXhytfpJaaqDQNPgIIemy93Ao14vfqbzI21cJ0aBs1whlh3
         vLakTCVzl71qt2XL2BkCYL7h29vJ3guILRaieGMif3M7AVyXa0fKp+ZrXAkTubmyZ72m
         os9J2RMVe6Q/FOG+vQr+QQyOQjlX0qXHHnIceEFXYsBz/LtPmaF3fiFpTFEcjKwPIyZS
         om9PZeLhYMWHcYj9/Fo5Lti20WsCPii9z6CUaeltp4WJp8Icw4+chXxoTj6tVFhjZTLn
         nC+Q==
X-Gm-Message-State: AGRZ1gI/0xT76aHIedRAxQjdmBpY3duIfeXwlApCzgQ2hrk/PrdSDLYR
        p++XDotGqZ7KVohifUPtrOJY7IGt
X-Google-Smtp-Source: AJdET5dprxBWGEpPi7kjklzu0LtWS8n6qNH8oV9bCkKp3XsQUTuZ86IMdFlSeUnEvyxWFN+oRXOV0A==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8-v6mr2906821plo.94.1542069553925;
        Mon, 12 Nov 2018 16:39:13 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z13sm17054851pgf.84.2018.11.12.16.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:39:13 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:39:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 1/3] eoie: default to not writing EOIE section
Message-ID: <20181113003911.GB170017@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113003817.GA170017@google.com>
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
 Documentation/config.txt |  7 +++++++
 read-cache.c             | 11 ++++++++++-
 t/t1700-split-index.sh   | 11 +++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 41a9ff2b6a..d702379db4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2188,6 +2188,13 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
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
index f3a848d61c..4bfe93c4c2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2698,6 +2698,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
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
@@ -2945,7 +2954,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
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
2.19.1.930.g4563a0d9d0

