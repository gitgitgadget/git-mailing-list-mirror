Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C024A1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHKBVi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:21:38 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39001 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKBVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:21:38 -0400
Received: by mail-ua1-f74.google.com with SMTP id t14-v6so2352637uao.6
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=37pQQhcGYFIQlWr+w8JlX5r+BGYvPrPFxMIqRJuqJ2o=;
        b=jkpq0O2wKM9JMYLk4mtqmhjdQ1PoyV/r4MPb2Do3vQ79sp4BVotirxVWWM/YmCBk4X
         L3/VJEQIM9CLwTMyKnOIQz8ZXzXOJV/jOaRhac0G4av6GxcF05iHy+8zNcUTauAw0AuB
         xdrgKCnO6r3IDQ2PA2hXBBuq9g7cOa6mwyoF8lp1SfS+YEp6TjNcOuommQ8zqvCwhYKc
         4UWCJfjJfLbI19MfqdzgA5M6qQbMn3x63hywoRlMzNlUwB13Kk7zDBEu1aavxXbA/4FD
         yfqFQbEO50ldkOStvxLSWq2aW/T19VoIdNvTBpHEDc8GCvXnolfX8Ho1Z8cgthf/eMao
         FRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=37pQQhcGYFIQlWr+w8JlX5r+BGYvPrPFxMIqRJuqJ2o=;
        b=cUluaa9nHTLMGYH64ZnlXrzkxGwX4fFIRt6aKu/yTeMKgLBlsUOpSPfjrfmYK/kLmj
         BUOWppgS38/HXWzWrSVnViQeYfQYPMIdkHgYPMbMVdDJ9GvVQtUlhOPtvK1ka6zT8cBQ
         kRSvzEBwx11rXUHJIcOPolYh4Y46ULgRqE7kzbCcQQS/hYSs9TrNLiYSDd2QXCCBWvH7
         BdcEN9p4STmkYlK46KxqjdS+MhWl1T3JsP5tAD9aRe+fkL9l2w+49qkO3RSQcwi+wYQJ
         LurT/AXl1dSQ8WqMNTr5HezA6apGjzxLom/ZGR0WV0p7IqiUIGcOQV1x15tfABz9hQ68
         tUDg==
X-Gm-Message-State: AOUpUlFsxYT6J7Il2itMAVPJKDDaDQg2LiODcWQAoXK3/396jL3bH26I
        3wzEsQl667EFcPLuA+P3KsQM+z/wksm0
X-Google-Smtp-Source: AA+uWPxM9+77xCZozwCLIYC2cn+/rTHnvbDyJjyHwVBOnH6tY9qB7zNSG6ITcf+C9+9akQ4jPNgTkl1r5mV2
X-Received: by 2002:ab0:59c1:: with SMTP id k1-v6mr3790849uad.70.1533941385535;
 Fri, 10 Aug 2018 15:49:45 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:49:23 -0700
In-Reply-To: <20180810224923.143625-1-sbeller@google.com>
Message-Id: <20180810224923.143625-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 4/4] range-diff: indent special lines as context
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Stefan Beller <sbeller@google.com>
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
index 6e4192c8e79..a8db7c4f8d3 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -85,6 +85,7 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
+			strbuf_addch(&buf, ' ');
 			strbuf_addbuf(&buf, &line);
 		} else if (in_header) {
 			if (starts_with(line.buf, "Author: ")) {
@@ -121,6 +122,7 @@ static int read_patches(const char *range, struct string_list *list)
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
2.18.0.865.gffc8e1a3cd6-goog

