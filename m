Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFAC77B7F
	for <git@archiver.kernel.org>; Sun, 14 May 2023 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjENNUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENNUP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 09:20:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80430CF
        for <git@vger.kernel.org>; Sun, 14 May 2023 06:20:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 682C65C004F;
        Sun, 14 May 2023 09:20:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 May 2023 09:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684070413; x=
        1684156813; bh=YHjumG4EiDCYjprOGjGIvdEhPPNL9JilF0ifu7WYFAQ=; b=J
        ofL0ed8QKgSYSt9TG8w0l0FOAfEbbmQUbkog5MYiHz89azOMGxY42TAun8n294we
        sZAMMLmhQs1H7mXfvZMQvEP2AO2rXkhHPkjPQ1ehmwz8X0CL22DKbCpqgU0D2cpy
        XmtZOS/jbGoiWf9eykM7MvOxDs3UwJFIZKIabLIuIhBxkXNGxq1tnEFr4JBBBhN5
        JSydB+QhGF66fPlBZK9uT7YvyObYbUN3pjX+NRUfhH6JPEObId7+nMJ7kP5IriB8
        0Sj1+5+4u3t+3M2inJHjZCslqY2eKdYVbzuJrQM2ZgP40PiCHZ2JhZQZRUK628+9
        uoiqBtvepjeAkXvL0apqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684070413; x=
        1684156813; bh=YHjumG4EiDCYjprOGjGIvdEhPPNL9JilF0ifu7WYFAQ=; b=I
        afWpwlmg90i1rgHn0cmUCMJqiyh5mDlC4r2D5vNh3pbDEGZdocK1ujJ+YLrCZXvR
        YpmI/89fo/VC5jFSeRPk95dHorW75c1xijfYoiHhoLxPraB46XrWqWvUXXqEdsh8
        Pzr2XjyrIMei51A/eMjr7SObVH8OC9c6QpN7ox4LW+pIshqvhehhiBGCI+4SfP0r
        JkwZvD3E5rTOABfMPdkh7PyJgG23bYx89ocJaNhxUlsfEeh4JlodC2vjwxq73nB8
        sQ3DOmd6Lu/s3inhLIrZeFhh3z/ePtbBwUUMxzZ+/fOajbDg2w+3B/7y3EH3V+h7
        ylU8AUn4fUutOAYKW2/kw==
X-ME-Sender: <xms:DeBgZAZPDzCpPG4qh0S-7vvy5y7FrabrqyNccUTPYwXPZeASggq3fMQ>
    <xme:DeBgZLYlAo0GxWL3YowZn7Db_WUyz_c-x-SIOZrxa8etRpC89m36Zx8BD9snBtDGJ
    RS5c0MUMBb7f6wDSQ>
X-ME-Received: <xmr:DeBgZK_q84ZHkODEhY-kZPUoX6rP6Hy5ekhRi6wguQc6BeFFKKIPr1Nvzc1KgeT75NrJFP4TcIOfvTHFfBmHlY5_hGq0p-nlZkC1SGwyg_nUES5WGdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:DeBgZKqS6_pOcc0mpkvmigFXpNuatg64_Zo2yV-nSmYxJUmy5Ayj0Q>
    <xmx:DeBgZLryDVkfI4SqNzQr_k6ekKL-YBdkW25XXsvdgcvKYBy_1Zzezw>
    <xmx:DeBgZIQRYgNtoFN9f-TQb12tQjus_Npb_WYcw0Qfc16diDMt-ek5Xw>
    <xmx:DeBgZECJXozH7dYB3agspnmzEfz0-o1NSFcudpINvX-eZxE7Ivp_bQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 09:20:12 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/3] t/t7004-tag: add failing tag message file test
Date:   Sun, 14 May 2023 15:17:59 +0200
Message-Id: <1f24aa43f70b16381ef0cfb4f1d482706161554d.1684067644.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684067644.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7004-tag.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 550b5b1cce..1e512dbe06 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2136,4 +2136,14 @@ test_expect_success 'If tag is created then tag message file is unlinked' '
 	! test -e .git/TAG_EDITMSG
 '
 
+test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
+	test_when_finished "git tag -d foo/bar" &&
+	write_script fakeeditor <<-\EOF &&
+	echo Message >.git/TAG_EDITMSG
+	EOF
+	git tag foo/bar &&
+	! GIT_EDITOR=./fakeeditor git tag -a foo &&
+	test -e .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

