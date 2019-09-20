Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8EE1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 09:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408497AbfITJgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 05:36:14 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43464 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405989AbfITJgO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 05:36:14 -0400
Received: by mail-wr1-f53.google.com with SMTP id q17so6016016wrx.10
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsfFMr17sfLUzs3Y4Sv/cdF6wW5rTBGlDz7hfnSBPt4=;
        b=mM48OqqyJbqgymmJaa/zI/PzWX6CNUbEx7tqOsza9X0LaJNOYJgEXf4kjZWxZsJaxL
         b0kwr+pb/lmp/uP4xRcIl+iLJ0KxowIDKxBa7jK/aFvaEI/AqK1GXwD29yktLcB93L0O
         tP7r3bUTBbAvifPU17ZVJCQ73Ka0SwQbpC3Bn7aEi4/Vgl+2d6XPM+qHt3JrAyW4Zs6u
         OmSrJ0ku/KZzbRZjmEo3q4x8HMSUjQo1P7mdNTuiZNSAfOGsOOlXN0q6C8TaAf7xwbUD
         7fLFVAl3LY5p4vBvxskFkASeLrZTe+5smuaFI8lIxpuDljT51eTRKd5CiD5TQ6E5wdTZ
         +kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsfFMr17sfLUzs3Y4Sv/cdF6wW5rTBGlDz7hfnSBPt4=;
        b=cofnBlIjkcVjOCPH4xM6765W2N3K6d9AByURGlmOZlM9Of6vxmkuXk4bu2xBUv5MUT
         mIZzWZtZxf25ny+dZVY21yB1w6SZBZq31SpzkkFhza5huqbj47iKjuK8F0hrci7T3EQt
         czcIbYotRA4UhxE6ov9ocLP6YI+y/JTHTyqdoPVldRtu0663Wb/ugnxU21Ooao7HWk8Y
         jB12pmjkw0teBlvoQHW8Rd0VVuSOUjU3mjl8TIsy5NSJ4EH4vrDxxykHN+GsnISpsDKN
         H548EVmShRxwa5tmtmOOLlEnplutlkDPApfMfdx7m8nFl36PyMo/a5eeB1pc4Z6YVPUQ
         Luog==
X-Gm-Message-State: APjAAAUkccbsc8XuRhbRVNEJDmtVvWCsUtyCfiKlf2/Jg1gvioue1zJF
        FOSPXP+UskzQaV54IwFnFco=
X-Google-Smtp-Source: APXvYqxROQ5fPeIMO8Fz7nMIqI6hkg4IE/enqVw5GT1JK0rB+KVJ9vPbzVyxE5wYDZXfozP/NOa8Cw==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr10756006wru.198.1568972172831;
        Fri, 20 Sep 2019 02:36:12 -0700 (PDT)
Received: from localhost.localdomain (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id f197sm1574679wme.22.2019.09.20.02.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Sep 2019 02:36:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t/helper: ignore only executable files
Date:   Fri, 20 Sep 2019 11:36:09 +0200
Message-Id: <20190920093609.24935-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch conceptually reverts 44103f4197 (t/helper: ignore
everything but sources, 2017-12-12).  Back in those days we did have a
lot of separate test helper executables under 't/helper', and its
'.gitignore' did get out of sync every once in a while.

Since then, however, most of those separate executables were
integrated into a single 'test-tool' command [1], and new test helpers
are added as new subcommands, so the chances of that '.gitignore'
getting out of sync again are much lower.  And even if a contributor
were not careful enough and submits a patch that adds a new executable
under 't/helper' but forgets to update '.gitignore' accordingly, our
CI builds would catch it in a timely manner [2].

Ignoring everything but sources has the drawback that building an
older version of Git (e.g. during bisecting) creates all those
executables, and after going back to e.g. current 'master' the usual
cleanup commands like 'make clean' or 'git clean -fd' don't remove
them (the former doesn't know about them, and the latter doesn't
remove ignored files).

So let's ignore only the executable files under 't/helper/, i.e.
'test-tool' and the three other remaining executables that could not
be integrated into 'test-tool' (no need to ignore object files, as
they are already ignored by our toplevel '.gitignore').

[1] The topic starting with efd71f8913 (t/helper: add an empty
    test-tool program, 2018-03-24), and leading up to the merge commit
    27f25845cf (Merge branch 'nd/combined-test-helper', 2018-04-11).

[2] b92cb86ea1 (travis-ci: check that all build artifacts are
    .gitignore-d, 2017-12-31)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/helper/.gitignore | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 2bad28af92..48c7bb0bbb 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,5 +1,4 @@
-*
-!*.sh
-!*.[ch]
-!*.gitignore
-
+/test-tool
+/test-fake-ssh
+/test-line-buffer
+/test-svn-fe
-- 
2.23.0.331.g4e51dcdf11

