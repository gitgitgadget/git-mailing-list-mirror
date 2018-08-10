Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9CD1F46C
	for <e@80x24.org>; Fri, 10 Aug 2018 00:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHJChl (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 22:37:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:42212 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJChl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 22:37:41 -0400
Received: by mail-yw1-f73.google.com with SMTP id r144-v6so10494966ywg.9
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=obGFnMFAdF2LhD3FGthBH441p8+KKR0au3QlgT0zPLE=;
        b=YUieMUliz7wNMYjDP/tlu7Mxr9GTHO6SioIpp4154bXm4FLpgTAGMQeOf+bL8wpRZ4
         45jJJAp92hHcmna8EUGvT0spl9z0/WNgZ7O7ent+rScuoFtOF3cEiaA0vfx6Kx4GWrlV
         iSaVq26+0S4SUkDp0BLFo2l0v3Mo5k9D1xB0GJJYnf1EOBYRiVYM+PfcIcZv3YxmfRR9
         7Q7UnPssoPqqI3KyEP3rEtzC+wP7TIudrQIAb+ZcezDuCUlsVFpf/+HT0+cqQ69P3J82
         OwKWjQ3t3M0JRFZVNOWcZat5iF0sIRBV9TzuPX53eddFlTMbGO5L79ORQM7FViYSj/rR
         /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=obGFnMFAdF2LhD3FGthBH441p8+KKR0au3QlgT0zPLE=;
        b=CYDYDufXpKQRjZWG7u/3IEkT8ZcOTkMHjx/icCRaGDr3x9DvhTvc8ECyg+R/ERZB9p
         vVs8PgikjNvX9KKCPnpqmggQU8hZ/YReczILmjH2AaogTiIvzrLG1ESG99JMQVgD7BIT
         NythrjikIGYWqwJj39+2xFWc2gcAA6Z06jZJ5/3WyQhPDRq/Y/pnSd5y2uvszuCE8v9/
         H+D04kwFRGExbDvVJvt7s1HFAf/DT44G3hX49rb5pUZv4lA2Kq4welF0spoUs+sj+sPq
         YzGxDXVE5qlarwU4261mQuN9++1u/cishVQs/PmkMqeBBxWOvZJT4wNKH7SunWkGfQHo
         N2bg==
X-Gm-Message-State: AOUpUlE9Tt/rfaPVSIFPZsim8x3OJYxwnghvSPNK/HLPC5pe6Ju7FR3D
        R9kSneXnOvM6x5jljahu6FIkkJKf9dWh
X-Google-Smtp-Source: AA+uWPxL5FQkAAyUbePbg4hUu212LLuBJChR4hW7Lg8+lfHC0RfNTqowKAZbKz37myp2X12ioju/7lbpwbcN
X-Received: by 2002:a25:8592:: with SMTP id x18-v6mr612473ybk.14.1533859824924;
 Thu, 09 Aug 2018 17:10:24 -0700 (PDT)
Date:   Thu,  9 Aug 2018 17:10:10 -0700
In-Reply-To: <20180810001010.58870-1-sbeller@google.com>
Message-Id: <20180810001010.58870-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180724003619.185290-1-sbeller@google.com> <20180810001010.58870-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/2] WIP range-diff: print some statistics about the range
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index a977289b7dc..fbabce5f91f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -264,6 +264,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
+int completely_different, slightly_different, same;
+
 static void output_pair_header(struct diff_options *diffopt,
 			       int patch_no_width,
 			       struct strbuf *buf,
@@ -288,15 +290,19 @@ static void output_pair_header(struct diff_options *diffopt,
 	if (!b_util) {
 		color = color_old;
 		status = '<';
+		slightly_different++;
 	} else if (!a_util) {
 		color = color_new;
 		status = '>';
+		completely_different++;
 	} else if (strcmp(a_util->patch, b_util->patch)) {
 		color = color_commit;
 		status = '!';
+		slightly_different++;
 	} else {
 		color = color_commit;
 		status = '=';
+		same++;
 	}
 
 	strbuf_reset(buf);
@@ -439,12 +445,15 @@ int show_range_diff(const char *range1, const char *range2,
 		res = error(_("could not parse log for '%s'"), range2);
 
 	diffopt->color_moved = COLOR_MOVED_DEFAULT;
+
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2, creation_factor);
 		output(&branch1, &branch2, diffopt);
 	}
 
+	printf("patch ranges are %d same, %d slightly different and %d completely different\n", same, slightly_different, completely_different);
+
 	string_list_clear(&branch1, 1);
 	string_list_clear(&branch2, 1);
 
-- 
2.18.0.597.ga71716f1ad-goog

