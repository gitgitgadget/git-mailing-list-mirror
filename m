Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EAC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjEPR46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjEPR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:56:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581CD3
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A6F465C00FF;
        Tue, 16 May 2023 13:56:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 May 2023 13:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684259804; x=
        1684346204; bh=QQfCK7xt0TQxzeQRmCOhBfHqdfVFQ3VIA+4jYkq1VSw=; b=a
        tyay+EKFsAq9ROWuA2iVSZaTAPhWmfbvgJhu20fDzajIpWgNvCd0eTkZ3JmshweM
        wnKs30fM9j3Lze3Eg8uM6tdCAUINmgi5grlQwsgFhAlBr1MOXseF3nbpIl1N9irB
        8sg5hpNb7Q62Ft/Y2BxBmK3vn4Y0jpNWYNZ8N9sXV5RWspR5PEDhYBolZUSNo1Xk
        Ve3ttP2vhDyVhUHOzKbO1oBpdrpBOa3bjKS8x7/BPp3u/N0T5TXLHvWxxUjLbYUE
        f4deIIH/4V4U+MmdfNPOtk0CxUzOtPY8VLmkHEhGADcmVeFknqbEBx3Vlc2ZH8nO
        P42qOidSWzJHpi+m+JDGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684259804; x=
        1684346204; bh=QQfCK7xt0TQxzeQRmCOhBfHqdfVFQ3VIA+4jYkq1VSw=; b=h
        JatWEAB6Z0uMaTf9YvLicY6HM3SoClh2klbep187iKQuM5GBGhf+RILlMdzy2GxV
        iF4ueupjy57OjGdzk2Lg9ole09305KFWWHE4bEEm2VNQsWwvIzdiNzVJOD7avQAl
        Ow47pAJs/gffFB6ET/neZe/BkL39qaLNeD7IAQQZUkA2yw4smxSKov/O3/bpbe/q
        If7W4mveLShFBXJacMN13mFMtQFg2Pth7fboFB5Lo6yFx33k0Z6dvvLfiVy7EPf2
        MMxcwxCl/WQZxffUo/OuShUQYXZGHpFxAGhE31SxmYCnVI1H5K/VPXWwo29sMVeu
        M/s2Mo9g8g59iON7DdIpw==
X-ME-Sender: <xms:3MNjZAyYY13nRdrtWXen0vFYQt6foOw-lARK8_pkY0-UMPm50Ht9A8M>
    <xme:3MNjZEShCBm7BjmZiJ9M15I3sti33kQeOZgKjpYszfmd--Zl1v8rtKJ889rNFu8Mr
    1R1jbAulMfub4qYgQ>
X-ME-Received: <xmr:3MNjZCUaoANFLIytRUbMdSLipxSyH4sJ2_6JZa0OF_Q9be3jCeqt50tMu_Fm2OGeLrNyH4FUj1M7HLDAbEnRYou1Ys3gdKkJ2jgWoeIoJ4evG63q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefhud
    evveejtddttedvhfelffeuuefhffeugeeluedtgfdtuefhtefhudelleekteenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:3MNjZOjLp9dzSbvm45of4ftx7RiHKRE8082Awdl02-4WuyHcYFGoaw>
    <xmx:3MNjZCAGyPlJcs41dhB3clap6IDK0kzoGMNvvtbSMxGfCAVrEqOyHw>
    <xmx:3MNjZPL3EfZM7HE_scEkdgAW6tnUfcudTRWO211iMZz_BiduIhg7Ew>
    <xmx:3MNjZFO3Ae5hoP1p8fu7SPk1jClE-mobAOxnnzONcaY0IaxjIsiyjQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 13:56:43 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 2/3] t/t7004-tag: add regression test for successful tag creation
Date:   Tue, 16 May 2023 19:55:45 +0200
Message-Id: <d1490b8f0b70efca03ed6bf166756a2d93ff1e35.1684258780.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684258780.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684258780.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard tag message file is unlinked if the tag is created.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    See: https://lore.kernel.org/git/xmqq353x8de3.fsf@gitster.g/T/#m594378bc6fe2545e638ce2d5f9c11861d4e33082
    
    > What you want to use is test_path_is_missing, without "!".

 t/t7004-tag.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651b..1cb738b00d2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2127,4 +2127,13 @@ test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
 	test_cmp expected actual
 '
 
+test_expect_success 'If tag is created then tag message file is unlinked' '
+	test_when_finished "git tag -d foo" &&
+	write_script fakeeditor <<-\EOF &&
+	echo Message >.git/TAG_EDITMSG
+	EOF
+	GIT_EDITOR=./fakeeditor git tag -a foo &&
+	test_path_is_missing .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

