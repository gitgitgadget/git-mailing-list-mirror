Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E434520248
	for <e@80x24.org>; Sat,  2 Mar 2019 00:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCBAlB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 19:41:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42080 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCBAlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 19:41:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so12212495pgl.9
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=phqXwEuB6wAvE6fP0y6dmo8jCJfuFGFgc72i0z9wQqQ=;
        b=QAWsnRODqH2wiTOzjsyCm+BBWUDnd5MrzYvr39xeoqDrB6+9WipsdlSt2b2zeML5Ld
         QIjYzS3OfxWoWgsQOdUo6/Xbe0S2IgknLlhUKxOnU/eabv7XsJrOrV9jULi1Q6kHqfn9
         ICQaxhEjMHLfWITXgyisX4QtMpmn0iZYNE95sX457H+vsHTGTscPHUy/SHGM79KQMcIm
         U68r5hoNZtmLb6cszMR9aVMIOvps8S3WwmXGM3XBIPzNZ0kKwTRjcLBNHM/db/ONuQ8+
         GkE2w6H4shHOGCAHyiUbR8hccYN2ZF+x06iqaWYMXBH76eSeG6CVU/vwTI3yF2H4y20a
         /oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=phqXwEuB6wAvE6fP0y6dmo8jCJfuFGFgc72i0z9wQqQ=;
        b=bwACwaSTdkhB4hBdbb6a7HNE1zajXTWaBwr+A4nFC6d9njw5lBs4nr0TVcnsbtJOhI
         dB509KEA6RwAD8zkLsHQFjnOPuVZKy/EPkvdcSM5hdUrE58XoURhVNAsGAc4JX6eoz+p
         U9bFFItKVOhq7gjgI4/fLKTI2hSuvlGgYxj6vi+tlrf201i9rml6+QL4M98zN1fxqs7w
         fSPy3NZ4wGiAfPa3E1/qeyVb1y73kG/QchqneNMcJ2qGzOhJyGjVco6bm4dsMDLhOvFl
         tRudyICsNDurvsziw+OIsGWJYBj4dfw8pXsUFmT/1keG9U5bGvqp6FOCg7IfLTepGjMX
         lTtA==
X-Gm-Message-State: AHQUAuYrrnRLnpLeCEC8pNiS/rpnOdlqzU6H2m9RT02guJ8104FoyMgo
        NFQgglijOTRTKwGD+33DK8aB8VYkWQ1EXQ==
X-Google-Smtp-Source: AHgI3IajM+83zvVB/yaud7V0C9gMZYNQlYbCumNdDTAtTTD2sLgiA2L7PDg64t3bL4UMneizZ7xAPg==
X-Received: by 2002:a62:1ac3:: with SMTP id a186mr8550585pfa.48.1551487259296;
        Fri, 01 Mar 2019 16:40:59 -0800 (PST)
Received: from localhost ([205.175.106.122])
        by smtp.gmail.com with ESMTPSA id a17sm145062pgd.92.2019.03.01.16.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 16:40:58 -0800 (PST)
Date:   Fri, 1 Mar 2019 16:40:53 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Invocations of 'git config <name>' print a trailing newline after
writing the value assigned to the given configuration variable.

This has an unexpected interaction with 63e2a0f8e9 (builtin/config:
introduce `color` type specifier, 2018-04-09), which causes a newline to
be printed after a color's ANSI escape sequence.

In this case, printing a terminating newline is not desirable. Callers
may want to print out such a configuration variable in a sub-shell in
order to color something else, in which case they certainly don't want a
newline.

This bug has survived because there was never a test that would have
caught it. The old test used 'test_decode_color', which checks that its
input begins with a color, but stops parsing once it has parsed a single
color successfully. In this case, it was ignoring the trailing '\n'.

To do what callers expect, only print a newline when the type is not
'color', and print the escape sequence itself for an exact comparison.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/config.c  | 3 ++-
 t/t1300-config.sh | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..c8f088af38 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -258,7 +258,8 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				strbuf_setlen(buf, buf->len - 1);
 		}
 	}
-	strbuf_addch(buf, term);
+	if (type != TYPE_COLOR)
+		strbuf_addch(buf, term);
 	return 0;
 }
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 428177c390..ec1b3a852d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -907,9 +907,8 @@ test_expect_success 'get --expiry-date' '
 test_expect_success 'get --type=color' '
 	rm .git/config &&
 	git config foo.color "red" &&
-	git config --get --type=color foo.color >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	echo "<RED>" >expect &&
+	printf "\\033[31m" >expect &&
+	git config --get --type=color foo.color >actual &&
 	test_cmp expect actual
 '
 
-- 
2.20.1
