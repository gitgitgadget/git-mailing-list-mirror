Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9111F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfGHQiJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbfGHQiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so17906696wrs.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I66tsNV2uTuOAR7JVNCEJFP+b6dKf2BHOOpTBcnMnc0=;
        b=oEWXt39h+Gbhbu6IBGj8v1ZvDHmCTmqQ0j83zUXW3Hh5I+p3FQ+mZwt5VIDediAIwD
         vMpZ0V5lqkNURKQx6PcwUqfnO7RsrWSLRsPHULv8W0meHcl7bubw9S2qrwnjMbjwOkES
         uYzUA3qwR6y9jKxgrQumK6vimI6yDxeS2VpdXH69xN1p8UPXtrP1wEkoCrKzuS7t825A
         YJd+75cmbgmpnjgWLQKAN0tMqNBFlZ8lZbTHjVT11ieVnXAaAcM43F2QrJx379F6Vk2T
         PX/1mi3ur67c+Daa4vjEZ/GbMit579xvQGtYSqq1QD7YQ1Sh+9qR5ctNXNUoSbNnXB7C
         Qnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I66tsNV2uTuOAR7JVNCEJFP+b6dKf2BHOOpTBcnMnc0=;
        b=p1PnK7faej5ZyJfx4Z+KWRFxf29lxFjkMVzzQGLzErVuahiSPSnsQuvNDLy1hsGxFV
         Ll2KEXZfePv4FUfAHofdA/f6/MagxMQtj0CJSCZpNnzFb6N9UgVEg9B50XeRxmMJLg7q
         puUMKiEHmsHXb1klayI3J7gR32VAVH5nn6neDCcfDwuxXKVKlUJa+7meZuMYycHoESB/
         fNzHBNgoXjbVJr7qt7zItWwsn84ej2wCVP4kNT8KCkvOIIs4ib+67fysnl2+aRKjnFoA
         EL2CAF5BlURPPMSzlHOkFQc6Ku+ZswYafjaZjn1tGN+PoaZjWVNmUNKaIa44ec36McKl
         t6mg==
X-Gm-Message-State: APjAAAXlZjLchwIzakvVUnYH2LFQvQw0XRpSYtmCg64E76+2mCdLI9iO
        ZuE53ygbWfQ2bz5r4SgQaMBDAwou
X-Google-Smtp-Source: APXvYqzGDJswP5XYLdfN1fedKABUGQA1wrq8UekUlRPuHNoI/mkzC2ag9AtX/MmWPukBdrIW4Ls9rQ==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr18113643wrr.170.1562603885171;
        Mon, 08 Jul 2019 09:38:05 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id q16sm31205889wra.36.2019.07.08.09.38.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:04 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 10/14] range-diff: don't remove funcname from inner diff
Date:   Mon,  8 Jul 2019 17:33:11 +0100
Message-Id: <20190708163315.29912-11-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When postprocessing the inner diff in range-diff, we currently replace
the whole hunk header line with just "@@".  This matches how 'git
tbdiff' used to handle hunk headers as well.

Most likely this is being done because line numbers in the hunk header
are not relevant without other changes.  They can for example easily
change if a range is rebased, and lines are added/removed before a
change that we actually care about in our ranges.

However it can still be useful to have the function name that 'git
diff' extracts as additional context for the change.

Note that it is not guaranteed that the hunk header actually shows up
in the range-diff, and this change only aims to improve the case where
a hunk header would already be included in the final output.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c          | 7 ++++---
 t/t3206-range-diff.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 784fac301b..a5202d8b6c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -119,9 +119,10 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addch(&buf, '\n');
 			}
 			continue;
-		} else if (starts_with(line, "@@ "))
-			strbuf_addstr(&buf, "@@");
-		else if (!line[0] || starts_with(line, "index "))
+		} else if (skip_prefix(line, "@@ ", &p)) {
+			p = strstr(p, "@@");
+			strbuf_addstr(&buf, p ? p : "@@");
+		} else if (!line[0] || starts_with(line, "index "))
 			/*
 			 * A completely blank (not ' \n', which is context)
 			 * line is not valid in a diff.  We skip it
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 048feaf6dd..aebd4e3693 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -110,7 +110,7 @@ test_expect_success 'changed commit' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@ -8,7 +8,7 @@
-	     @@
+	     @@ A
 	      9
 	      10
 	    - B
@@ -169,7 +169,7 @@ test_expect_success 'changed commit with sm config' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@ -8,7 +8,7 @@
-	     @@
+	     @@ A
 	      9
 	      10
 	    - B
@@ -231,7 +231,7 @@ test_expect_success 'dual-coloring' '
 	:      14<RESET>
 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
 	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
-	:    <CYAN> @@<RESET>
+	:    <CYAN> @@ A<RESET>
 	:      9<RESET>
 	:      10<RESET>
 	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
-- 
2.22.0.510.g264f2c817a

