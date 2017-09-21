Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BD5202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 20:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdIUUsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 16:48:35 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:51874 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIUUse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 16:48:34 -0400
Received: by mail-wr0-f178.google.com with SMTP id z39so5454248wrb.8
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RewrOqa+9azbnGP0PgdqZsTH6VLZf8f0NJa36Sh4ruw=;
        b=R+8lNpNg99Krl2qp+tnJvI1mXHia3KLffHLe2FJ2OWOD6Pta0vXT7uSUlck2KpOyKS
         4kojMf8qz8anW8+ChDLGRtg+ac6MHXQiIsNG2ksXTzRf6hoS+STrK84IYMb7G22pBck4
         5L/Vd2kffZejgoz/PrxNQ5kJ59vnbKiwAX4Z1Pk2+g42HkoNZBqvoEQBVt/7KT4r22AW
         1rJCk9DjMhFRGgekgO5xNIStZOC6tHynbcgMcAI24r1VvWHJ7vzVYe6TL51aLrGWV19N
         zO7qDEbhORxgdabupqueVxoeQb2z2ee4sFfOzS7aoxldclmyjYzol7r+dGwoS8x9VfGp
         2DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RewrOqa+9azbnGP0PgdqZsTH6VLZf8f0NJa36Sh4ruw=;
        b=OcgB6Y6Mmp4+pIMSXNwqDnm9MvCCT8uxR8FNJ7bc8sIGro09YGyu349xMudDE8I7gC
         jb5Jp7wtTgCS08ZbD3ifAaV/ntqG8EQrJ/DlGEOqyxYcFcXk4pI0UeQPVnEivG9yRJPc
         YF1EeKIe6Duv9zbh//MGXQ6vMCUttbmbh/9NHxwjrfh3UsoFhs+wFhf8j/nWnEyK58tI
         rQ0FlDRzRUdfzya1OSuvQ6zfFocwhIm0rMJRg7vXB3+cqjQhPIAtDGQkEB39JHmJgvnH
         aSUCJB8xWTRpYGBMjO3ePNspNRxoC460ps49TN15892KOaIqGJlOiUvyFF3ai3squuHY
         qeQw==
X-Gm-Message-State: AHPjjUjW6SPyn1oN8gr7Qe50Q9xkwVvYhzNZ6SD2jJ813l0uztYlzyGU
        XX2ZneVZ50IfNDQqelC1TYt0/w==
X-Google-Smtp-Source: AOwi7QA6srRdbIDYLOLar8Ii9Ivjs6MyY9LhvHIRyl82ZA2zasTTixfwuI/7Ij1WORbapUxTFsOG0A==
X-Received: by 10.223.198.130 with SMTP id j2mr3063889wrg.52.1506026912985;
        Thu, 21 Sep 2017 13:48:32 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB5FCC.dip0.t-ipconnect.de. [93.219.95.204])
        by smtp.gmail.com with ESMTPSA id q140sm2444444wmd.17.2017.09.21.13.48.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 13:48:32 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] travis-ci: fix "skip_branch_tip_with_tag()" string comparison
Date:   Thu, 21 Sep 2017 22:48:30 +0200
Message-Id: <20170921204830.66831-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

09f5e97 ("travis-ci: skip a branch build if equal tag is present",
2017-09-17) introduced the "skip_branch_tip_with_tag" function with
a broken string comparison. Fix it!

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

previous discussion:
https://public-inbox.org/git/3B175D35-5B1C-43CD-A7E9-85693335B10A@gmail.com/

Sorry that this trivial fix took so long.

Cheers,
Lars


Notes:
    Base Commit: a81423d7cf (a81423d7cfdc57238783f05394dddd1064c99165)
    Diff on Web: https://github.com/larsxschneider/git/commit/6b532a42f0
    Checkout:    git fetch https://github.com/larsxschneider/git travisci/fix-skip-branch-v1 && git checkout 6b532a42f0

 ci/lib-travisci.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 9c4ae9bdd0..c3b46f4a7d 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -14,7 +14,7 @@ skip_branch_tip_with_tag () {
 	# of a tag.

 	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
-		$TAG != $TRAVIS_BRANCH
+		[ "$TAG" != "$TRAVIS_BRANCH" ]
 	then
 		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
 		exit 0
--
2.14.1

