Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7CFC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbhK3UrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:47:13 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32925 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343780AbhK3UrF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Nov 2021 15:47:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 69BDB5C02CC;
        Tue, 30 Nov 2021 15:43:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Nov 2021 15:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Y3wuRgVYO71V/
        5zWFdLco+031rFjVW+Q3ghyW8EeFDg=; b=eeNhL3Fhsn4LQInuK8O/AnGivRez0
        OvTPkkZ5xH5ffw2oLg4XS+nJRw9s6+Zs7hanUqoVu08podpZvFd4kgNnomYJcJ72
        QXZH7vBxbMB2P1NrRgsh+g7KSdzusxa/arTKFD6/wWlMELGJNQ7tuNR+dGJXVjWl
        Amgg0tMu4E5Wg93d1fDQkRFCslskZGbOqm1zaawhH53RCmEp0yiV+4sdaxqxSE4y
        vopG6Qmgene0amU1yYLegv/b9Ec4BYUfDsm8+67G/afkEOu29QgJYIGRPe+eAq4g
        XIY7IrLVwEQq5c9tevHUbozn7IG2jWdYlZtjm5NcP/CqI2sL4SfniHodA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Y3wuRgVYO71V/5zWFdLco+031rFjVW+Q3ghyW8EeFDg=; b=efbS/MZh
        xH0jlh2NhV3URG0jzTDnIlgNxg8lgxlMhVoE4BySK22/mBbdWMEGgBfkmiLiHbO+
        fFbTcaBmYRugQs9siOWHPi9hToR5uOIjzyPvyapesEemmg8H1/1bBG+LY+csPiKE
        rjdYB0tBFruOqsXbr9x5OQz1tn+O7Jak3T8u6nk59iAE/lHw8Oc+9G+4pjCO+sdY
        vRfP0ZUwJAgDhAyqghExkJmzCKauJgxxpVhHexDyi1dqNorwZ4l0GtKnTfQhDpu1
        ryikpXQ/SZ6aN4HOHxm/haYYTsqXhtTr9z65K3peLWFyMyZWNFStFxFw3KidUpYN
        sRX+jMx0Ue1LQQ==
X-ME-Sender: <xms:AY2mYYYDZhyuFsPtRxtCdrtWx9U29r85W2E32PWOZ1COrNPahxChSw>
    <xme:AY2mYTYAGHogW74GhQXxN6Fmn_LnXynx3_SVvRg3KHg0v59Q8KDk9I6iCc-BwSeTx
    FohgiR9RYP0szIU1w>
X-ME-Received: <xmr:AY2mYS_zkIk6Oz2PaFa9BTf8D-c3P9Uw-qfWvz-jQBUs65OCCSf9JbBj7-lmd5DrZf7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedugddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:AY2mYSoxawPxJ9ek-v3KB9Ue8l5ANG7qeMjM_J2xJKiURw0dQepwRw>
    <xmx:AY2mYTpvy71MK-xdqFOSonauIUYmLMapQpu8JTEfdu378TXkg1EC3Q>
    <xmx:AY2mYQQU6-t4G2zmaewd8Mn_Rh8wBi5EpdaeKtYA8zVvhLcvEGVMNg>
    <xmx:AY2mYUD6PaprYMj8EKpfwhjMHXnGbnSHBCelJvdG0MFf3xvczQmzpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Nov 2021 15:43:43 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v3 3/3] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Tue, 30 Nov 2021 21:43:33 +0100
Message-Id: <20211130204333.174967-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130204333.174967-1-greenfoo@u92.eu>
References: <20211130204333.174967-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new test case file for the different available merge tools.
Right now it only tests the 'mergetool.vimdiff.layout' options. Other
merge tools might be interested in adding their own tests here too.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff        |  2 +-
 t/t7609-mergetool--lib.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100755 t/t7609-mergetool--lib.sh

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 8614253ef1..5085e4ad0e 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -552,6 +552,7 @@ merge_cmd_help() {
 	esac
 
 	return 0
+
 }
 
 
@@ -594,4 +595,3 @@ if test -n "$GIT_MERGETOOL_VIMDIFF_UNITTESTS"
 then
 	run_unit_tests
 fi
-
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
new file mode 100755
index 0000000000..35cc287124
--- /dev/null
+++ b/t/t7609-mergetool--lib.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git mergetool
+
+Testing basic merge tools options'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
+	GIT_MERGETOOL_VIMDIFF_UNITTESTS=1 bash $GIT_BUILD_DIR/mergetools/vimdiff
+'
+
+test_done
+
-- 
2.34.0

