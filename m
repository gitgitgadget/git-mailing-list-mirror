Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D305A20705
	for <e@80x24.org>; Thu,  8 Sep 2016 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758176AbcIHNrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 09:47:43 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33457 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757003AbcIHNrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 09:47:42 -0400
Received: by mail-pa0-f68.google.com with SMTP id h5so2448742pao.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yldtG1pf/obQvzoINk1LVAJ7FbdfCkmC1ByHi0QvaD4=;
        b=zvZtEt8e7oEyOrzfvs6CO1VCLfVq7vqTUQHMFj0anIfQT5J4khalDm3JDWnMF6MCGH
         RCb54vzPzQG6XaoF6JFfjja1Hi954FKdGzbO4C6fdSqVoHwfh26gEfcYT+dugifcSgKH
         PNz2RXugFAFAH0sFS25cYkj0gC+VUY5X0d0HRHKVnQmrHZq3Q30ChDB4QGUd2Fn57HLT
         qSIX89xw8C+sFS8c2oTJz/ljRYXZnNTJztCpp/e4ZmGCyUSWeZru/T4TcYG2JrSVkjmv
         +J0u3pfAAwjN0OlTmzszUm8W1XA10viQEhGpkkcwhmFkWh2APH8Hook2HvbErSNKUYmh
         LUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yldtG1pf/obQvzoINk1LVAJ7FbdfCkmC1ByHi0QvaD4=;
        b=Qzd3p6gHmVLqG9dZ7buVgiNd8lX/OVXwKZz3fYvFL5vKK9zJTz+dXeMb4pv9NHrB7o
         Ag3mrlCTvcp+JXAbIW8ROX0rvs1vSA0R9+a33ZEiGbLTG4d6NXp0LhbbGnT016uxxM7P
         0QkkQ/vQDPDNMFz1i7/HzUUrzOFJ1UT4wW9lKyiRDfwayV9sTZ1ZQuJpM1zZpHKnQP8D
         /MXlWHBn/+4734kPogZR3DUSeS8mJzdhuFMAYXpt4kEtj2OBuBzQN3TqCA7d2aLS87bh
         q5VxSZW2jUK9529aoeB+b2hK4xRuB2nH8XeoAZ9X2t97/29n9u/Qwovchgfz+Kw53iYi
         irew==
X-Gm-Message-State: AE9vXwNd4WlcAORwq1i8/8NmkLdLUyxuAWzT9cxTXqxvAmNe+R2YpOcvbwL2AM64UQapkw==
X-Received: by 10.66.139.227 with SMTP id rb3mr91122847pab.26.1473342461285;
        Thu, 08 Sep 2016 06:47:41 -0700 (PDT)
Received: from ash ([27.77.242.225])
        by smtp.gmail.com with ESMTPSA id p67sm56637976pfg.22.2016.09.08.06.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:47:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Sep 2016 20:47:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     git@drmicha.warpmail.net, max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] t0001: work around the bug that reads config file before repo setup
Date:   Thu,  8 Sep 2016 20:47:18 +0700
Message-Id: <20160908134719.27955-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160908134719.27955-1-pclouds@gmail.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-init somehow reads '.git/config' at current directory and sets
log_all_ref_updates based on this file. Because log_all_ref_updates is
not unspecified (-1) any more. It will not be written to the new repo's
config file (see create_default_files() function).

This will affect our tests in the next patch as we will compare the
config file and expect that core.logallrefupdates is already set to true
by "git init main-worktree".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t0001-init.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d64e5e3..393c940 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -385,7 +385,9 @@ test_expect_success MINGW 'bare git dir not hidden' '
 '
 
 test_expect_success 're-init from a linked worktree' '
+	mv .git/config work-around-init-reading-wrong-file &&
 	git init main-worktree &&
+	mv work-around-init-reading-wrong-file .git/config &&
 	(
 		cd main-worktree &&
 		test_commit first &&
-- 
2.8.2.524.g6ff3d78

