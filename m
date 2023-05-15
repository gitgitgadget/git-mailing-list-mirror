Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D57C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbjEOUbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbjEOUbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:31:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1825A11D98
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:31:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6632D5C00E9;
        Mon, 15 May 2023 16:31:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 May 2023 16:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684182660; x=
        1684269060; bh=08Ssv3Cds/55Ghh/iIH5WpWpZV5q8r2I/9M3ABsvj18=; b=C
        aVd0j7wlyebkLp3WLz56ZaP6gVsbs+NpeuBX+VHULT8hglSt+656mZ1qjC/fZTlE
        NAa2tOxZt1tD/MK1d1lcuFPtFVDZ0rySHA3NeUdn3bXCEtgv0sU+wG8KF8nDCRc5
        y2djN9l4EIVAHs+IAJBTic7v0yde+QXECChpiCb5yAVuYkSB+nUFugsSD9hN01QK
        PG0hlFgjbrMtMj4+QNCqeMrlJmTZpWITgcL/HWLcltUP92pJEFJwb1qiJKlMuZ8k
        Px0L8eUyCF2kdvNgfN5jjXeN3p45oIyCCcF2w7af1k3ZtlLflqEXN2y79+r15MHW
        R7hTbjFQ01qEDghT9IbzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684182660; x=
        1684269060; bh=08Ssv3Cds/55Ghh/iIH5WpWpZV5q8r2I/9M3ABsvj18=; b=j
        kdI6XpPvHYun3HoRYgGEBwXXDwh/lLvDczkOZz7N6XvaCKYQUKeJyGdcLcp5UQl/
        c+xXJTNdTI1eg1ng5pwcjiF3g+2gBYwjFJ5TLir4sANsSTOeQN/4E55zoIE9sKnQ
        XwdzGg53UIBRa40zEolMRzsfUw0V5cJ+wFWtihaXSEfLV7xoJ8jrCrygO8zlghOu
        3iOwj90z8BW6BWscBB80JlTT6lFoTFaC9eOSfL6CepIa1QsMVqIcauR79iO70dSQ
        TKQ2ckh8mjWlsx/NDTsCdaVjPBGidkEje4iFRwpwDZAri083G83hsqR6G5SA7I/Y
        x6xJsnQ3gui9xMVgQlJKg==
X-ME-Sender: <xms:hJZiZGM9W3C_QXraOX40v0xcxGdjBKKO7MYkH0FSIABFezamjXxjmBs>
    <xme:hJZiZE8xOom6Ez8gws1HL7eDiln7WqOn1BMYcOc9duyditZwpmbpWrvgg7TUPTRhQ
    hTg-SRMiW4Vnd_jnQ>
X-ME-Received: <xmr:hJZiZNRQSKSN4ehFW6un0fYVvCecuIR6sJ0KPr9yttHeiK-IgYvSg3-OLMjJHEz4NROv69_raSCSMgTllBCgCa6G7-RZYMCeoA8b728BRTfqSpcF4Y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetud
    eiheeguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:hJZiZGtOvIvN-_uEO21SR-3P2Z89rLdP6iSiUUh3W83qwAVKmBCrqw>
    <xmx:hJZiZOdJif5g_BU4FQgNsTrOC3AMxE6olkVQeYzuotHPS5NpubY8wg>
    <xmx:hJZiZK2dtKxdFjPd81cmw8TtttQFmTX-vJddxqhkJ3WggGmhFpHjvg>
    <xmx:hJZiZCGcyN1Tm826v3APordmB-3N6IxU-MZE7Yb-XIbVDC6DS6ctlQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 16:30:59 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/3] t/t7004-tag: add regression test for successful tag creation
Date:   Mon, 15 May 2023 22:29:34 +0200
Message-Id: <aabeb4568ee19eefb8b788708a16cc72036e8e8f.1684181855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684181855.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684181855.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard tag message file is unlinked if the tag is created.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    `test_when_finished` because this test interferes with the next one
    without it.

 t/t7004-tag.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651..cd454acfed 100755
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
+	! test_path_exists .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

