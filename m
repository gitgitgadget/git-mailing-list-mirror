Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC30C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A16E2078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foDvYiFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJEM1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEM1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824FC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k10so9333517wru.6
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEoBMi9MN/2sJT0ee3kBf3jUbUNW5KYMWA5wIPZ+zh4=;
        b=foDvYiFPWJ6yDqohCx0s+n1dafikCu+iCACynZCx7b8boGbDLP7tKDfdrkK0M8JjTz
         Wyp0HEIRgYHIe4Sux4Wo1Gl1fBjXJCxy5irTdm7X6ipgMsz1k07iuwVsbZqR2NR4l5z2
         iPwxUYJu++aIZlPPfK6I9RmjisSb6RhpG8uEarfzDd/DbYSiMNAAQvV1VxuqdHrg2FN2
         8GtYZeYuuCZQ/b9by21Xdndsj23UE4WJdxXYbMCx/Rj3yatPwdOYS5IQv0BMlAG4ls/o
         mM4R8WM3e5mvUTJvtfBHjUdkn5i6Fz6H8pfS0Ji40WXvUf6iyWnVWhXhRBW5Rf49UBX1
         iyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEoBMi9MN/2sJT0ee3kBf3jUbUNW5KYMWA5wIPZ+zh4=;
        b=VtK6Jla0cavJAWFb9ONBqwONHGYIQHEhRY8XnSg3BsEDwl77eVJjuVnrm6v7UDiEyr
         T8hMsm7IwlUzbCUUQNzhEHTtQvBCapmuHcWWcCvYQ6P0GiThKJsiHLToAFT18HmchvwY
         xnTOngSt/+uz4lsvN+zkDeYHMGIduOu0abZnmBmVYcjbJIjRydNLXhmrsNsXt/DHdmSn
         s2mx+EiqUca1D322Zxsumtye3DEeS9tWh+o57C7d2u/WV36exCt8taz3mUbD/1wiAJ3/
         Wfv64TFQ2GImX0VDkIJJuY0egBxswkwVoCJb09M0MDiJnNCzVYXwkjC8Wq4hpSoekzKI
         skrw==
X-Gm-Message-State: AOAM530U5Ux0HI4sg2sCSJvV1UDLWRB6h0zor+mknDY3DBAJImGicZcV
        b1aSlsFaje8Kl6p2uZKENbFPZHULl1c=
X-Google-Smtp-Source: ABdhPJy4/btW/0p3SlPvlJHhIM5bLJEQPsmz4wwZyTHQK5JviPaSTu6e3CX27qnET6qVFJrSzLoYpA==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr16986803wrq.282.1601900856533;
        Mon, 05 Oct 2020 05:27:36 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 01/11] t6027: modernise tests
Date:   Mon,  5 Oct 2020 14:26:36 +0200
Message-Id: <20201005122646.27994-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6027 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6407-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..071d3f7343 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 . ./test-lib.sh
 
 test_expect_success setup '
-
 	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
@@ -35,33 +34,19 @@ test_expect_success setup '
 '
 
 test_expect_success resolve '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s resolve master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s recursive master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.28.0.662.ge304723957

