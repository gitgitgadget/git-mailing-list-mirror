Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FEE208EA
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHDDwT (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:19 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:39928 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:19 -0400
Received: by mail-it0-f74.google.com with SMTP id w196-v6so7252670itb.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BNqFtbdJHpeO6++dE/CVOXx994Oi4fSmaLMiPOtZIvk=;
        b=V/5cFfdajd+GJhYwwNIe8alkxzX0CDlDp4pHblBy7CdRCfmNOK694hkPJPIHvrpbCt
         hr9A7Rgnu8o5noOnUzWkjmTfPSAY11547DvtqRyOQm1vrpC4EeXYm7TVYOWt1mhU3MyJ
         6b5EycYk2IxyTOjOnXdaxabmLUPHannANuDL+O7tTTbQZC++raOfSqT91Wtb5e4dkxII
         J2GyFo5UR/+9rc3Zc2B5/6GWAXslrf344cd4HZu9wiTJoqvVSgMqtsAUjLoTdgvvTFzc
         ByZB5mC967d+4oqtTXydaRA6iBf7rSj1kh9anRIpTG9ONGMwgmhOAXK4bXv+LdKvynPd
         SnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BNqFtbdJHpeO6++dE/CVOXx994Oi4fSmaLMiPOtZIvk=;
        b=a0+RLaca5X+7Tg0lVuTWM9OgOHUXCMqNiYhwC0iJTzzUhzI5i8Fv8rVjEnl7CMyea4
         leymJhKWjYkgnEcbRUKKxJFq5LchuUH90gq86cAEv6NbfILV4EyHX5dLTBe5szx2TeNq
         HuPAb59pvtZw8FSamYhs1eCIQqM315J2Xax9Pnr/KyfQMWr8iL4XdjepqtrydMq6A3Tg
         jMNO5SA1GVJIV8l3ghTaJb9KMf3L//BtW5sC/gNY829TiDaL8MOFVj1oxk7yu38TxwNi
         X0hj3/V6Q3HNdKF7Kaa2tvgr2tRE858V+5qF0Gcna8b9K7pShq+sU892Y3XjSKBARUOi
         zvnQ==
X-Gm-Message-State: AOUpUlEa2UKzfxNJWNp2rMSFIzLhpC++SBad+yTs2HJ7lM6U2i/1NcFK
        R7UUneyLeUpPqc4ryImAiG6RR6Q/EuvJGhtmM8GXRdEZwz8pc70uD629vKWib8FJUUFPMfUId0B
        wbHnkx4m/PMAOUO32gCuMPB5XVvRYPZWUkbX6GW4oU8miynYrKfjTl9UvfNcC
X-Google-Smtp-Source: AA+uWPyiv6nHqh1YBP4+w5+VaKVDSxSbCyC4nn9yy6UJOP22sy+L9evKTd3+v87IZsMyDHCSZJi2MGsZdBif
X-Received: by 2002:a6b:3384:: with SMTP id z126-v6mr3941092ioz.61.1533347610985;
 Fri, 03 Aug 2018 18:53:30 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:14 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 4/7] range-diff: indent special lines as context
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
index a4ff945427e..91d5f12180d 100644
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
index e3b0764b433..0cd23cbff41 100755
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
 	:    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
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
2.18.0.597.ga71716f1ad-goog

