Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09A020986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756471AbcJGVI0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:26 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34787 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756084AbcJGVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id n189so3237000qke.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQuHV9kydiPMg42sJc6IdQt8Zz1FJrmas942m05RCIU=;
        b=zkPJJV4wpKZJAgBaTVRRN3CvHtmp11q2Npb8lvCIgwubRarUbmUrJoq+ekyyq/kONT
         flGcixAVFpxi5N4TBGA4vnimooUE5tbpu9hSjoNSIV/yY/TojY0hMhJ8Xh6DMEMOljJM
         CeSVETxQuWK86YO1r0F4/wpfJfeyBjOdzx4z8R2tXhdlcsFv9l6vdM1EDMJvEyMCjtw9
         1QxZMTNST9wKd4rJT+x1kf4nLrg4ukYKwbCD71xiaKntsNr03AaiQeTE3jJZOgTn3LQv
         2LqIat3+oXpkAPei8AGQ145wnzf3PZOZjmLkiumFXGCU3hZBmC1qlHykoesEhNLOCWNw
         IiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQuHV9kydiPMg42sJc6IdQt8Zz1FJrmas942m05RCIU=;
        b=ZBXm7BBd5zE26i+j/2IQKymVcciylacJFPDsxCpkrwSckOSjnt+143J4c/CM8SavAx
         ZuGdExIb1UavFDm7wTRzAkxTyMVil2vVviAs3MpZ4JTVsNgOMUXLEYbQoqXwD78yQ6YY
         q5/w1o0o3s4cU5jDg8r5cRQcMd/WJqm+SLdJKbRWu4b1fZPUMxf7w4BxIcHn2+k30qhz
         zDiv33+Acz3c0bz3MzGYAEttJei743AZdCZ6Vj9wjW+IBlD6ILCDwfqnFIG5cdDI7T29
         ni2pV4MHBVOo+Qz1X+iMnAyLdnymLXASBVqWynwOPdj/p6bm5FfCI4q4J8XN6WCt6UPO
         gHJw==
X-Gm-Message-State: AA6/9RkGHk7gX9WHOGlZ8rKlp6Ur8uSjT7hoqSft2CHX16w9PWMFU/a2QRuxe2tm0c0G9/+j
X-Received: by 10.55.203.23 with SMTP id d23mr13913576qkj.143.1475874451688;
        Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v4 6/7] t/t7030-verify-tag: Add --format specifier tests
Date:   Fri,  7 Oct 2016 17:07:20 -0400
Message-Id: <20161007210721.20437-7-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

Verify-tag now provides --format specifiers to inspect and ensure the
contents of the tag are proper. We add two tests to ensure this
functionality works as expected: the return value should indicate if
verification passed, and the format specifiers must be respected.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7030-verify-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 07079a4..ce37fd9 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -125,4 +125,20 @@ test_expect_success GPG 'verify multiple tags' '
 	test_cmp expect.stderr actual.stderr
 '
 
+test_expect_success 'verifying tag with --format' '
+	cat >expect <<-\EOF &&
+	tagname : fourth-signed
+	EOF
+	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF &&
+	tagname : 7th forged-signed
+	EOF
+	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
+	test_cmp expect actual-forged
+'
+
 test_done
-- 
2.10.0

