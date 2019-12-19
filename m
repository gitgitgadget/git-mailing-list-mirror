Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A7C3F68F
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5D320716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEJFRf0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLSSCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46472 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSSCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so5747240edi.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qifUwXTQRgoJduZELBS2JiiJjoa39hlFHKYFbJCfiRQ=;
        b=lEJFRf0cbUjkeCDuPQe0xfJGRqayJ2CM5mnbEVOBH4v+lgCo1Uw5FZ0XNzcbUZe7H6
         xeFeat0ZT3s9BNZvBOEpeEM5WuqKAYI/HvYSO4LxY+ZY9n3+f8qJJxzK9eeSQLnV5woA
         Ywge7a07LcNrUuBWfIboovDt6sAon3t//cA2HUo+p6SfhZ7BnyU98/foWppxyRKEGtah
         m0swkWL83SoJdjyznJU7qPzeBQEg2sQRcVR5CLvRNfRWdb2LRny26KobRxg60k6Qholr
         4j3IfmlC1DUDFA4taWPnhSjS9N6NxNdxKT7vxyhsh7AIG+3ltOMzDAX7kR+j18Qsgx+e
         1IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qifUwXTQRgoJduZELBS2JiiJjoa39hlFHKYFbJCfiRQ=;
        b=oZ2yDWaL6HxiDOyerumm/nq1GwRor2fCisK7Uon7BRpB57tCf4pqrUs4R9ljJY9Kmy
         alVY4PDCffb8acZ6nUJ1hC5OgaRX5V3Mjl2AtuQAKsoLcVj1drTzBJoqUH9E+asH8ZsZ
         SfIEgolelSysF8kZ0nOdI6HYmCH3hvmjmA6ehLvOwjDGEIZ76OJ0MPfx8dOA3xBljRzK
         mIo4qerhLg2FY9zfKYDw3L/0zToIhGi3jOzXKmLv9obGUwZJbmgwv0yJOrGJk1+M5vwp
         wmtHcjMLsBbkMQlDd2pxqe8rgmTtBh16cABXBhczW2q/TfcqnCfDuLg3ZGuoCPDLc0/Y
         QkOQ==
X-Gm-Message-State: APjAAAVe3FaekiPtZKGOFl8Kp2qnRQJ25uv+Iyjq77gQpQzyY+ipS0nD
        vCTGOZe1MeQr8W0Jl8UpOlijauPq
X-Google-Smtp-Source: APXvYqx8Yj921HehQmvZ+hBZWBKE5Rw8toqYmlWrQHaYBg9lYnNecN0Gk2BWU0IhcAApxL4/RhDLDQ==
X-Received: by 2002:a05:6402:b87:: with SMTP id cf7mr10784272edb.214.1576778518668;
        Thu, 19 Dec 2019 10:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id pv11sm639532ejb.75.2019.12.19.10.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:01:57 -0800 (PST)
Message-Id: <14d30dd0e17d5e017dea05e4751f378f2128be14.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:39 +0000
Subject: [PATCH v3 02/18] t7526: add tests for error conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Suggested-By: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t7526-commit-pathspec-file.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4e592f7472..b71c1013e7 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -61,4 +61,28 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git commit --pathspec-from-file=- --interactive -m "Commit" <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	test_must_fail git commit --pathspec-from-file=- --include -m "Commit" <empty_list 2>err &&
+	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
+
+	test_must_fail git commit --pathspec-from-file=- --only -m "Commit" <empty_list 2>err &&
+	test_i18ngrep -e "No paths with --include/--only does not make sense." err
+'
+
 test_done
-- 
gitgitgadget

