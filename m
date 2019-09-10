Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D618B1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 05:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390663AbfIJFRM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 01:17:12 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:41609 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfIJFRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 01:17:11 -0400
Received: by mail-io1-f47.google.com with SMTP id r26so34537223ioh.8
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1DL1U4y3BNoDQ1oLhHX7q+YhidI7yLBSjM0eyp6cBo=;
        b=Z/bOANR2JmFOfDkZNbeQ2qQvMJHDRuTxMZCvzB3miS+J8WyTKSI3ZI4zvMdeP/4paE
         5z4fmBcqbDz3XskYs77E2PKejFnjRMB+ycUdsK6TjMhcsEDeSPJwKJ3uj2/31RVo07+o
         kYeyW/T9mNhCDvux7pxJ/XOsHwb+FNJ/biNl2jbKKeAGCm8pALyoCZGvqMLT/eCI0BR5
         MA+ywdjfreeOuVWpHcR6PkK60TZ/lKDAIDbO0/sNRu05+9aNd0Qvq6wXx2oyDv+Px57e
         dTnRC+WXQbMbIJnlE093kGFrLnGyXjAmryw7N7VuBn1xLlPMBDn+KuA1y6KFfi/b4HLd
         VZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1DL1U4y3BNoDQ1oLhHX7q+YhidI7yLBSjM0eyp6cBo=;
        b=otkDv/2VnlHR2MgKhO0fjRSROzaioMdTVoAcxz08XOKjth9ZM+GyYuFIY52h8XSYQq
         wBgKSC+EQ4mgom76ktL6aCIU2m1aLr2Jt6iB9p/jyWAc8ZZYefbm2zO4Tp4JtwBhKn1H
         zY0aGaD1t/6U5Mvs6eN9Q3oiURTRMa0ZE2c6K64NR2442I/tkPkeTaFQ3ruIr8OKHtgZ
         f8uYhTCYczG9OMNjSNSvyAdIeqczr557hrKdrY59Rbn5TBmz7++FMk+ImOQD6FxeC90X
         hScyM6Lmg2HoUwrHhtjA8XTWDQJnANZW7H8Kn/5txiA/ZFKohSQyA6eaCoN/jom/J/PP
         acoQ==
X-Gm-Message-State: APjAAAVCpkv+70EgVKKSXqE95mQcqfom7SZ0bBMlKi0+9YIBtcaImxY4
        pBpQzBkPHj82PyZfdKZA6lsuMB+8
X-Google-Smtp-Source: APXvYqzI8ZMGT4XDHQ6syccooIEnmgxlgcXGMMIbAJJgxnQ0O0JpHlQ/bWskr8eGU5x18BYZi7rEJA==
X-Received: by 2002:a5e:8402:: with SMTP id h2mr3270757ioj.38.1568092630659;
        Mon, 09 Sep 2019 22:17:10 -0700 (PDT)
Received: from ericfreese.hsd1.co.comcast.net ([2601:285:8280:27a7::c608])
        by smtp.gmail.com with ESMTPSA id k17sm1913204ioj.10.2019.09.09.22.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 22:17:10 -0700 (PDT)
From:   Eric Freese <ericdfreese@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Freese <ericdfreese@gmail.com>
Subject: [RFC PATCH 1/1] for-each-ref: do not output empty lines
Date:   Mon,  9 Sep 2019 23:17:05 -0600
Message-Id: <20190910051705.2765-2-ericdfreese@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910051705.2765-1-ericdfreese@gmail.com>
References: <20190910051705.2765-1-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the format string expands to an empty string for a given ref, do not
print the empty line.

This is helpful when wanting to print only certain kinds of refs that
you can't already filter for.

For example, to exclude symbolic refs, use format string:
  "%(if)%(symref)%(then)%(else)%(refname)%(end)"

Or to include only symbolic refs, use:
  "%(if)%(symref)%(then)%(refname)%(end)"

Signed-off-by: Eric Freese <ericdfreese@gmail.com>
---
 ref-filter.c            | 3 ++-
 t/t6300-for-each-ref.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7338cfc671..b5b3c4ddf6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2395,9 +2395,10 @@ void show_ref_array_item(struct ref_array_item *info,
 	if (format_ref_array_item(info, format, &final_buf, &error_buf))
 		die("%s", error_buf.buf);
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	if (final_buf.len)
+		putchar('\n');
 	strbuf_release(&error_buf);
 	strbuf_release(&final_buf);
-	putchar('\n');
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce746..1f070e63e2 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -42,7 +42,7 @@ test_atom() {
 		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
-	printf '%s\n' "$3" >expected
+	{ test -n "$3" && printf '%s\n' "$3"; } >expected
 	test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
 		git for-each-ref --format='%($2)' $ref >actual &&
 		sanitize_pgp <actual >actual.clean &&
@@ -313,7 +313,7 @@ test_expect_success 'Check format of strftime-local date fields' '
 '
 
 test_expect_success 'exercise strftime with odd fields' '
-	echo >expected &&
+	>expected &&
 	git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
 	test_cmp expected actual &&
 	long="long format -- $ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID" &&
-- 
2.23.0

