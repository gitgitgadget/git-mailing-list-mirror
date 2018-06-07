Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6C11F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeFGFHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:07:05 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42737 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeFGFHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:07:01 -0400
Received: by mail-ot0-f194.google.com with SMTP id 92-v6so10014554otw.9
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9K1+ESpkb1kmbcIOFyu0Y+oDPPMaf2X78NboyotTDc=;
        b=W9v7psft5LFOaZW4fscc32lKS0R+FiGK3Y//XEJy75aRLmqnNwoIU69LPHhqBGbOWQ
         IagC12TKkyJ4kDNIp0gPa7wz5TmAjmjobmDHols8oP9RU6NiOkrZq/chcF0gdD8Eik5p
         Ok6Ai4kefjHaYmqJPeS8bl+jfiXKWubBKLD+esSpItZrtxNVG/mlBYOMxDmIwe4dPg2w
         bvTVCoKI4DNoGWn+4sTx5blhwQ7cXCcrNDZjA9SjvwnqZ9QTp5+oYlOgPz0/D5SrLm06
         /Hj8M0Wd3rKePco/0SY0IpauJBqQw3OOUJDIoD906g7UxrRwnIwomts2UvgOHVxN8ndr
         Vqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9K1+ESpkb1kmbcIOFyu0Y+oDPPMaf2X78NboyotTDc=;
        b=n0hrCBCnq94AYo4jlnk9EMvvv0MDz/Q+f/i9Vfwhsp06X5cP12CW9IE4zQ3G045BAp
         Kp42PWX+xaoGiO0A+Jdh5hQo14qb/sTwegbs5eMg/3PLXAJ9RtnUZMM1UnorUITCO/iF
         k+VZ1H+lWRS+mRfQdNe2LQku85kepNbVyNTw4NGXO0wlaWgvdAVvhEsKrqn2WVOseJ9e
         h1zgDM4xhqaAD9WFcyADDVjO0CkiOUf8dTcaKLN/OuV5+uA/V6I2MXiDSnFVx+a86Ni5
         MLxLiMKLYBK+a6GgTVTT7ESNPXplNWkICPhD2gdaucSsO7DM/GpXvg82KBWreB5ETvrF
         Vgmg==
X-Gm-Message-State: APt69E20p0c6Fw0q/zvyYHLTfWGaEhgqlGRAO3o78De1ycy1/S53Q5EN
        ePBGgeGjMNyJtluwMXGTQS75bw==
X-Google-Smtp-Source: ADUXVKI825J/btm5irYzkumZIxipTpCX4jhcjqL9DWMRg8NZTL1keWlFKcw/xfba8OzeQkpUfQIw6g==
X-Received: by 2002:a9d:3666:: with SMTP id w93-v6mr169963otb.394.1528348020718;
        Wed, 06 Jun 2018 22:07:00 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id v141-v6sm13002019oie.34.2018.06.06.22.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:07:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t3422: new testcases for checking when incompatible options passed
Date:   Wed,  6 Jun 2018 22:06:53 -0700
Message-Id: <20180607050654.19663-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase is split into three types: am, merge, and interactive.  Various
options imply different types, and which mode we are using determine which
sub-script (git-rebase--$type) is executed to finish the work.  Not all
options work with all types, so add tests for combinations where we expect
to receive an error rather than having options be silently ignored.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3422-rebase-incompatible-options.sh | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t3422-rebase-incompatible-options.sh

diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
new file mode 100755
index 0000000000..04cdae921b
--- /dev/null
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='test if rebase detects and aborts on incompatible options'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_seq 2 9 >foo &&
+	git add foo &&
+	git commit -m orig &&
+
+	git branch A &&
+	git branch B &&
+
+	git checkout A &&
+	test_seq 1 9 >foo &&
+	git add foo &&
+	git commit -m A &&
+
+	git checkout B &&
+	# This is indented with HT SP HT.
+	echo "	 	foo();" >>foo &&
+	git add foo &&
+	git commit -m B
+'
+
+#
+# Rebase has lots of useful options like --whitepsace=fix, which are
+# actually all built in terms of flags to git-am.  Since neither
+# --merge nor --interactive (nor any options that imply those two) use
+# git-am, using them together will result in flags like --whitespace=fix
+# being ignored.  Make sure rebase warns the user and aborts instead.
+#
+
+test_run_rebase () {
+	opt=$1
+	shift
+	test_expect_failure "$opt incompatible with --merge" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --merge A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --strategy-option=ours" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --strategy=ours A
+	"
+
+	test_expect_failure "$opt incompatible with --interactive" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --interactive A
+	"
+
+	test_expect_failure "$opt incompatible with --exec" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --exec 'true' A
+	"
+
+}
+
+test_run_rebase --whitespace=fix
+test_run_rebase --ignore-whitespace
+test_run_rebase --committer-date-is-author-date
+test_run_rebase -C4
+
+test_done
-- 
2.18.0.rc0.46.g9cee8fce43

