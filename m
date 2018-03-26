Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1701F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeCZBOk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33657 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeCZBOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id i194so2474773pgd.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxICdw0Y35Kaun6FJIdHVLfFFHNRJAvxtFlpUWTT/Ns=;
        b=n807jO354+gMltJGdxKiJ9kpnRKXSOOwpbNc/7LLVSoLf1ZlYrjIK9YPMAZ6VEG2qS
         z/7V9PeAUK86uK19nA5KvzsVsPg6Hk3yVVOZvOuXIpukiNew2xdfe+Ga0XC3iF42DWDV
         8OdN004Kaq7G6LI01YHhZ2uQrmo4i4r8MewP9WM+LrZG02sG2swIzG4nyRmISGbnulVf
         JlCUh7DaaGPkwfi9mW/VcCdTH6EmUZnVgRGS43K/4e516/oieo+mvZacpiU7+4y6xZ47
         L9HOp9THt5Vz6fr7R8fp7hCI1PZcVJucjri7g/zvKkwYN0XvPqgBLjDBWU+fazICCyPM
         cmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxICdw0Y35Kaun6FJIdHVLfFFHNRJAvxtFlpUWTT/Ns=;
        b=KW9B95Bd5FXX0hJJJAFTUPM3GDW0OAXacF+7OS8IOowebf5/neWzLxtES4IvpZnCMD
         nj5AWKmBYtLYBKkmOUtOn2vH7aFUo2L6hfeIkJqE94vZJDFn8gVcnxb5vAKqkQemSQBa
         p1DoQihK6mN1z4/9z7RE2/xU4zkQeI6wFAgBtrLErA4VUDsYj4eqW6NBxYKlbMd1VuId
         kj9c1nIYxSxokA+wjKJiAmu7M1+bK64bZhYaYYtpC9U6OkHV42W1kMrTuhzciPLBaArs
         Og0oz1kYLU9bQE2w7QusaYx6gfDfUC50EYafBwBTwi54a/R8l+tiC9F3kk524HX0k3Ok
         BRMw==
X-Gm-Message-State: AElRT7Hob+tvvE/oQhLLGKnuv3nhnG6tcAfLJYqWlNCn6ui89SeVYAi2
        0OkBHVgyuEpbOsWS9TvCes8HZZA=
X-Google-Smtp-Source: AG47ELufYPi1gTPd/tJpMut5gUB1u0GE6cxTZscaUrCPYoqoCOjqd6r5J2r7R0/EhzilY9FiIrDI4g==
X-Received: by 10.99.129.199 with SMTP id t190mr26728523pgd.376.1522026879045;
        Sun, 25 Mar 2018 18:14:39 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:38 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 2/6] stash: Add test for branch with no arguments
Date:   Sun, 25 Mar 2018 18:14:22 -0700
Message-Id: <20180326011426.19159-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7146e27bb5..261571d02a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -497,6 +497,10 @@ test_expect_success 'stash branch complains with too many refs' '
 	test_must_fail git stash branch stash-branch stash@{1} stash@{2}
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.16.2

