Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE2C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiBHIkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350627AbiBHIkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03EBC03FEC8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d16-20020a056a0010d000b004e0204c9753so555133pfu.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=PcDPigmq9mq3SJk3g82pK/HsmEj4Qxy6w2HHVzWfTMo=;
        b=MMkvtlBqf31YYdiSyeksNt4An+7U2EkuZR8RfQTzweFYZiHHtS6ActkyrqSY/ODCba
         CUnvmcLbAqJvwXXhy40LIAbOWmPEzetGZ7P2GDBQvG89drg5snvyDGK+3Myzqhura8+v
         iooy2TdQnn3ohWQ1IejyFfmIwn4TiCpGhRJDXmq7Aa51QvYkjHzHgq2ZxJzSSMGK5w2u
         rHpJjMwkIZzdCjd2DvaIp8MEh45F+0gfUbD4/siY3ncPYreRzi+gUHo1TmZazSxF2Y/x
         txpZafBw5biwI+1MGN4VUEJ43Dkyy8CBkaffn6FAV6tNwBPp1mdPRDlcEXBY6pSfy8Li
         dmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=PcDPigmq9mq3SJk3g82pK/HsmEj4Qxy6w2HHVzWfTMo=;
        b=tGJhjNEaSn3P/4pTmis+qeXKR8ZxJzi7i9ec7W62/JVFVMvPzcfY1XfmgQyQlv/l1r
         SqYw/xkDW7KyIEjJgpkJGzO1APVgR/0SBMzQJ0Ry15dsnS1k8iyegwTXqdQsaASsHU8m
         wYzQzEdCpIZ222TNyQYInVb2zENgZ/FHaSC1pHDWraASEwiK11Jbei6MyydZEqoSx3l9
         G7cEy+uPGdweFYGPakD61axX0Cpm5h1FfpoOwnUQdDlScmzS6lPXcTOR/SqXgBZCXgsf
         zzfUt2NeKNMuXmXVBGyxiRXNUEHIWHohHrAyA4rUF7+fWPRgrgAPlgKSw09RGSIr7W1L
         COtQ==
X-Gm-Message-State: AOAM5331CrYgSRv3iPLB0BS7GEGwmrBSPOilIpWRwyaAXnuY+f69huS6
        mzdixrGN3hxGRp7oL91OCS8MNord+5I97R8T7sLQa6lzel9EQK+HfSiQEpf0a2hhdWS6TdJMty3
        NnFGGk2TcWKzIjN7u1PN6q2287UJCf3CEKdbhdiEYfVUWWFX1vSoDCEeF6qUfqa0=
X-Google-Smtp-Source: ABdhPJwkhvPg+iloxT6YvXPI42dExdbk+ARNXX4e5pY6bbSw63LoAGc6dTJ1STiINDsaCzgCl2kP6AAGaNld/g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:16c1:: with SMTP id
 l1mr3311166pfc.52.1644309616383; Tue, 08 Feb 2022 00:40:16 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:44 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-9-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 08/16] submodule tests: test for init and update failure output
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Amend some submodule tests to test for the failure output of "git
submodule [update|init]". The lack of such tests hid a regression in
an earlier version of a subsequent commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7406-submodule-update.sh    | 14 ++++++++++++--
 t/t7408-submodule-reference.sh | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..7764c1c3cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -205,8 +205,18 @@ test_expect_success 'submodule update should fail due =
to local changes' '
 	 (cd submodule &&
 	  compare_head
 	 ) &&
-	 test_must_fail git submodule update submodule
-	)
+	 test_must_fail git submodule update submodule 2>../actual.raw
+	) &&
+	sed "s/^> //" >expect <<-\EOF &&
+	> error: Your local changes to the following files would be overwritten b=
y checkout:
+	> 	file
+	> Please commit your changes or stash them before you switch branches.
+	> Aborting
+	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
+	EOF
+	sed -e "s/checkout $SQ[^$SQ]*$SQ/checkout OID/" <actual.raw >actual &&
+	test_cmp expect actual
+
 '
 test_expect_success 'submodule update should throw away changes with --for=
ce ' '
 	(cd super &&
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.s=
h
index a3892f494b..c3a4545510 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -193,7 +193,19 @@ test_expect_success 'missing nested submodule alternat=
e fails clone and submodul
 		cd supersuper-clone &&
 		check_that_two_of_three_alternates_are_used &&
 		# update of the submodule fails
-		test_must_fail git submodule update --init --recursive
+		cat >expect <<-\EOF &&
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\''. Retry scheduled
+		fatal: submodule '\''sub-dissociate'\'' cannot add alternate: path ... d=
oes not exist
+		Failed to clone '\''sub-dissociate'\''. Retry scheduled
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\'' a second time, aborting
+		fatal: Failed to recurse into submodule path ...
+		EOF
+		test_must_fail git submodule update --init --recursive 2>err &&
+		grep -e fatal: -e ^Failed err >actual.raw &&
+		sed -e "s/path $SQ[^$SQ]*$SQ/path .../" <actual.raw >actual &&
+		test_cmp expect actual
 	)
 '
=20
--=20
2.33.GIT

