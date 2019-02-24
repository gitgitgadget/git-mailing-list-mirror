Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F5520248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfBXKLZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40571 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfBXKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so5207095eds.7
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0t9+UdupVVOtJmlTrOVow9yfYJ9/Loi3LBLWoky97BQ=;
        b=um8GqkgH+xpbmB80O8h1SQcXwF76Cny8y1qmQfNKd1/L033Xndz2IawsUguUF7ZVNk
         ARhG0BpEVP6A0iBLf3e4srpguV36onk5wCxqz3zqvLrKk+Lg2KAdubH/JpYEIOgJyx/O
         E7/Kbmy/06XQTJ0NUNKr2Zi//AZmw38uQxGBLNlierb93LR+EtpghtyZBQ10OiMfFRs6
         D3LM3Paa1b8PyPh3dMbjk4Zj4+DO/3cpG28brPIpNuV4a1Kui5/TZc74GQQJfT3417M2
         PI+LLqioXi8YEcN/1ikt/7q+Z7fZxr8YaBYtux2KlpkUVK0O+1/lYspNNU7/ks533aV1
         KLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0t9+UdupVVOtJmlTrOVow9yfYJ9/Loi3LBLWoky97BQ=;
        b=DTn4avXt1CjGI+0spkCFaSTIMT5Vdok4yUkStr2R61uyPwPgI+UTxeKUOdelLtvqQ8
         RshCRNh1vbj6jvCiwEC9iBSA4EM5RfDMGljpQOgzhHw9Lqsps4p0EBiVyzKlztEiSons
         YaZ8yhh466G6w6vQuEb5wAmKnScSZ5r14EEu5ABHjzSQ3cGP5X2N7RdwhAiX5y0EhZ0z
         fkA6yDTl7uGO2h/otKUmagIkut+1S01tz6Z0NkAbQbuvi6dmg2nomfOR8Pg3XKVreN4F
         DOEHMPvuO77g8/W89uzWnsDtTKqBd/d6EfGa2ewylZTle5stVQjicgC1sK+Rucyu/bEb
         2NEw==
X-Gm-Message-State: AHQUAuZ0z0ql7th6U1ZTWcJhxy6B5RknTy+th7HkRdWNUFm8+v/E3tgM
        ejNjhIgsB08Is+sbUXJzkUBPIlTD
X-Google-Smtp-Source: AHgI3IbtS/NCVJBoxkY1fDhWm+raeZQQttH9fLKLRHxfRmgT/MQ0BUbUyQhz7JQvIeF8fMsAkNfHyQ==
X-Received: by 2002:a17:906:3496:: with SMTP id g22mr9153961ejb.193.1551003082023;
        Sun, 24 Feb 2019 02:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a58sm1817312eda.91.2019.02.24.02.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:21 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:21 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:56 GMT
Message-Id: <1e8459ee7ceec845fd7c956e33c22d8158261d73.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/26] bisect.c: libify `handle_bad_merge_base` and its
 dependants
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negetive-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `handle_bad_merge_base()`.

Handle/libify this return in dependant methods - `check_merge_bases()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 87db1cc4be..b1ea658a75 100644
--- a/bisect.c
+++ b/bisect.c
@@ -751,7 +751,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 	return rev;
 }
 
-static void handle_bad_merge_base(void)
+static int handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
@@ -772,14 +772,14 @@ static void handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
-		exit(3);
+		return -3;
 	}
 
 	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
-	exit(1);
+	return -1;
 }
 
 static void handle_skipped_merge_base(const struct object_id *mb)
@@ -818,7 +818,8 @@ static int check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
-			handle_bad_merge_base();
+			res = handle_bad_merge_base();
+			break;
 		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
 		} else if (0 <= oid_array_lookup(&skipped_revs, mb)) {
-- 
gitgitgadget

