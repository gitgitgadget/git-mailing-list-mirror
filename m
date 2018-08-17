Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DB11F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeHQXtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:49:06 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:49529 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeHQXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:49:05 -0400
Received: by mail-qt0-f201.google.com with SMTP id b8-v6so7359283qto.16
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=P0NEQ1J3crXzV0yko1GCl6cX+asBhWZJb0TB0g/2ggM=;
        b=sKasPOEDkgYBfiE6i74UTOrbooqkYvMY2F+8NSkW4a3Pfgkg84ngYHEnMrihdoBYe+
         ja85L5hQfWD2SeOpyako1ion8MkNP0WkKlzS924umnyQiNN4MV7geeJGAKFQvDZeb65i
         qxGt0/GVX67SvZjnCqgkA1cFg2O6nw5FtMxEWt4tpO0xjSAa7zLYlRf5i4LMxKhacmQJ
         Ogl31toaQ7R6fMoEP2JwdDuqkokHQysJwuS3ylRRjgR8y/EtTVOFGwnLpfF8LkpYMvML
         q4w8HCceCHHhvkpqCf3K28DazPog6cPfh71AG8ITkqekNcoB9qVcjYM9VuLDxKnGCeMF
         Zqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=P0NEQ1J3crXzV0yko1GCl6cX+asBhWZJb0TB0g/2ggM=;
        b=sFdhbCl8uh3BuW89OdipRbgbrvBJI+ydm+uM9TKRHGih6xykEcofY0S7YgFIPPLw3U
         liHJLcqnTcoD391oODKgfzSVj71INHD6ACSaiBEiG/bwpeFw7p+ntRvXH1ZLcbUBTRQz
         Ik1mp9sR033Jfdv/BOrBJo1F1eQFQw9We+VGdwxLw4ygZArQlju7oLrufJHNb2o3KDTR
         Zk3gSgPaG291Wv8p4KlaZiV24j6eKubfAGZP/SSrDiG5LeFP3XxmWi7dV3Mq2Uxdb2mB
         vN+HnES4wznm1+jXcnuIpUam9xoFvU3J8mZXNhaDyDTpPkvigLq2DauOM9jOcso949tR
         b3ow==
X-Gm-Message-State: AOUpUlHDpot+1yk1Xf0D5TqVq82zNAgREydbT5fyKaOuhmfGjIfqDrLv
        IaT1u8Ek1SOSnidiU7qGn5hAUZ87KSFq
X-Google-Smtp-Source: AA+uWPyyAj97glHX+Q5aaykH4z41nszfce2xpcYm7uj8KUlq4ZfawnR1ftpPX17nTERtFQCzl2CAmRkkixwF
MIME-Version: 1.0
X-Received: by 2002:a0c:9b88:: with SMTP id o8-v6mr18546575qve.43.1534538653926;
 Fri, 17 Aug 2018 13:44:13 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:43:54 -0700
In-Reply-To: <20180817204354.108625-1-sbeller@google.com>
Message-Id: <20180817204354.108625-4-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet> <20180817204354.108625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 3/3] range-diff: indent special lines as context
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-diff coloring is a bit fuzzy when it comes to special lines of
a diff, such as indicating new and old files with +++ and ---, as it
would pickup the first character and interpret it for its coloring, which
seems annoying as in regular diffs, these lines are colored bold via
DIFF_METAINFO.

By indenting these lines by a white space, they will be treated as context
which is much more useful, an example [1] on the range diff series itself:

[...]
    + diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
    + new file mode 100644
    + --- /dev/null
    + +++ b/Documentation/git-range-diff.txt
    +@@
    ++git-range-diff(1)
[...]
    +
      diff --git a/Makefile b/Makefile
      --- a/Makefile
      +++ b/Makefile
[...]

The first lines that introduce the new file for the man page will have the
'+' sign colored and the rest of the line will be bold.

The later lines that indicate a change to the Makefile will be treated as
context both in the outer and inner diff, such that those lines stay
regular color.

[1] ./git-range-diff pr-1/dscho/branch-diff-v3...pr-1/dscho/branch-diff-v4
    These tags are found at https://github.com/gitgitgadget/git

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c          |  2 ++
 t/t3206-range-diff.sh | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index a906d25f139..3e9b9844012 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -90,6 +90,7 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
+			strbuf_addch(&buf, ' ');
 			strbuf_addbuf(&buf, &line);
 		} else if (in_header) {
 			if (starts_with(line.buf, "Author: ")) {
@@ -126,6 +127,7 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addch(&buf, ' ');
 			strbuf_add(&buf, line.buf + 1, line.len - 1);
 		} else {
+			strbuf_addch(&buf, ' ');
 			strbuf_addbuf(&buf, &line);
 		}
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 7dc7c80a1de..c94f9bf5ee1 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -133,9 +133,9 @@ test_expect_success 'changed message' '
 	    Z
 	    +    Also a silly comment here!
 	    +
-	    Zdiff --git a/file b/file
-	    Z--- a/file
-	    Z+++ b/file
+	    Z diff --git a/file b/file
+	    Z --- a/file
+	    Z +++ b/file
 	3:  147e64e = 3:  b9cb956 s/11/B/
 	4:  a63e992 = 4:  8add5f1 s/12/B/
 	EOF
@@ -152,9 +152,9 @@ test_expect_success 'dual-coloring' '
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
 	:    <REVERSE><GREEN>+<RESET>
-	:     diff --git a/file b/file<RESET>
-	:    <RED> --- a/file<RESET>
-	:    <GREEN> +++ b/file<RESET>
+	:      diff --git a/file b/file<RESET>
+	:      --- a/file<RESET>
+	:      +++ b/file<RESET>
 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
 	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
 	:      9<RESET>
-- 
2.18.0.265.g16de1b435c9.dirty

