Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52FC77B7F
	for <git@archiver.kernel.org>; Sun, 14 May 2023 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjENNUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENNUI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 09:20:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FC1FD4
        for <git@vger.kernel.org>; Sun, 14 May 2023 06:20:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E0E175C012B;
        Sun, 14 May 2023 09:20:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 May 2023 09:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684070406; x=
        1684156806; bh=JI6vZgbZZPEcAo+aOqFg/6CzsHu3ixXozB03mY1TNXE=; b=j
        b9N3kEXqVvu1EXAsMtgaaZlOeV77OiCgXacGwSNkgsBawAGZaLwbMBwZx+zYL2j+
        UKtl/MJb3r9d5EqXyJ8Y7u44V43eiKbX09Nig+39z60e88Zz2nolm/uxQcvPQazN
        8zRei8DPhVVKeLI1Q0HtSFq133os9AOjVaBA3xrXzKLiFvFztxcD6IejziCzbgd2
        HLQ5CcMVBItcih3UBgLXfX/dOMuf8hKxCYPWVUNQjJynQDEGtKu1NnuUjpWTkZmN
        4u06pOALsM4KyzcJmbDoAP3xGC8eQ66PLrDCenRnkkr2so+1m0CpzcS1yXWAtA6U
        uJv5zlLh/WrFDM57Kdxww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684070406; x=
        1684156806; bh=JI6vZgbZZPEcAo+aOqFg/6CzsHu3ixXozB03mY1TNXE=; b=E
        zwBDVM6qvrPI4bU5w91bbhjJ1wOFHq75LJGqPafmU23c/ffIocGXPw/hMIhWZvmn
        N7qgQcChnfHCCQTvh6W0J7bphZzDbpZWOEXYr65xlUknUdCxv6ryQgRkxZKqJGZx
        SUUp/tSYnf7ncLwUQu3Tm/2XkIJhgMDGnGEsFFon8fQcWEEz+b9qYvbbk1FPYJ+b
        JW1LayiQDRQCjU0n3ss0GmggXJ+Up0luKdbao0d6NA1t9yCNsWtoJ/NNbgb38FwV
        kDbr6XUojggNpibenC3p1yYfHiP/4xZ4pPJI1pnYJflz9SMUwVafs3LYNxYnZqoo
        qA8dgmVY1upqZfSUreokg==
X-ME-Sender: <xms:BuBgZGiwIA3-joxVgn3gvuO3qusc9I5QqoAU4XIVUYp1Tg2XY6d6yEk>
    <xme:BuBgZHCoPg360XJUQ75Q7LsJFb-4SAjGvQDKUhBpK8Mo8u4dds6u5fVVOo0mTCLOg
    6yMImacA-6ymy5RVQ>
X-ME-Received: <xmr:BuBgZOGvok2pUdZf7q3qq6OvEa_-dpF8q3bjB_1o8UlLx5kTDw0iVpCoEIW1Kl_fVl2ntPioX_dXqYspxzRHQ7bTtRVlbGvtUedfO8V6VugA06YSwKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:BuBgZPR0mL7Kf0jn6T5K7wAQjvvShX6zgQn2yXvurjJENwKAf3Uxug>
    <xmx:BuBgZDzIMMV4M-qOngvq_5GRwCg4zi5d1olLGoq1G5FhsNFA-nUNzg>
    <xmx:BuBgZN7F4elVS_q3UCIepmB_iGT4cv4BY0TzBf6Ypwv0ATEGoKXhxQ>
    <xmx:BuBgZMqq5dBr7mezMWsIh3KxlkAqk3y_cPv6ub32OgzsNJTFvsKeEg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 09:20:05 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/3] t/t7004-tag: add regression test for existing behavior
Date:   Sun, 14 May 2023 15:17:58 +0200
Message-Id: <87b709d856d8f788a2a50a2804ac508d5775f324.1684067644.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name>
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
index 9aa1660651..550b5b1cce 100755
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
+	! test -e .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

