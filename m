Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2917CC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDLT57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLT55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:57:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CF52683
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:57:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C8FAF5C00C0;
        Wed, 12 Apr 2023 15:57:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Apr 2023 15:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1681329475; x=
        1681415875; bh=KXveMsDAkaiOnJpaM7E0oI/dVYCNQgIkiXQqtqweezE=; b=S
        S1p45Qu7rZk3gA/GNC+w8xmyokANCkKWPIYetzkV8YQc4GIScsGTXaVC+hfoNdKl
        lzpKEh3QUGR6U36mfqM074Ucba0FqFpRE3n/idnia1VQBDvucVnYan2mMdpPoiv1
        414XHNBC5s73I7bHP5jwcv2OVLC57k2WqcvGDyOiFgcygBH6fPQEBM8jhEbFAxAT
        y1Pclw6q7tX3/lyt0ly/7M52HooxjdoPVqcAdMjzUhQ1VnOglapxk1j1fUBEoiE8
        BtQ4JFetPOYRGqCQAUv/VrVMvnoX5qKvLa8dwD8dJwCxXe6G4w8w/UXV/zcBTJJN
        CtzCUd6S9alpqArHG51hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681329475; x=
        1681415875; bh=KXveMsDAkaiOnJpaM7E0oI/dVYCNQgIkiXQqtqweezE=; b=H
        2UmmTWfA9FFgjB9tAhTlXUiCaJVrzl8fqnBA8zzA5F/F4rNQUjavmvceFnp+62Ui
        LBq0xim3S8RZCm4lwPWeoak69t9uVjkFX9RlC0Q4TTxuecF45VpRAv7q31p/RGUX
        ftBVFe9F5V+F9k1raCETg4x2bFBEkbLaKJMbLcUCa2ds8ej/Fkkv1H0UPh8iff/8
        K7UmEUA02aLY3CH67voWsZXjACWqEpxCRhc4SdJeyII+0s8qKORb4aOv9AqGYZ57
        47CuP+cjZYAeWrANkTnR0b6A7xhY/V1kB5ZiJXytp7wODS3k6/MniY58QbGc9UXr
        DRhcqNu7Xc2XZd7bd7Xpg==
X-ME-Sender: <xms:Qw03ZDWNbQLecZBCWD4ca_jZEyk5Ap8XZsq8mEgd-_kCIS9vKe_9rG4>
    <xme:Qw03ZLnZVOBDCx5r16bFaqY5XXgKCsnFNWh2sqwMUA5N5nClLgHRqRgoMxksDn-5x
    PL2dlhI3RRULSJ1Tw>
X-ME-Received: <xmr:Qw03ZPZBqduLwmn7gHaLEayW_cTCdn1Ng0NS4sYLyOL5TIjavqC0eGbhLT0YuZVVVPn5phZi9_U1PsUDGa9hnB5JPOPrqO7YgN8aCvlEQ9FaOqInJaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefhud
    evveejtddttedvhfelffeuuefhffeugeeluedtgfdtuefhtefhudelleekteenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Qw03ZOWF__9yJgwBB8qdVApovyie2TSqrNqgwhqudXVqP393JZH_2Q>
    <xmx:Qw03ZNmEd9OsqFQdJyRHjWsIYnaepLwz56wxct9Owds4t0uLXJ1HMA>
    <xmx:Qw03ZLciMZIGCLYSE5uVg_mUybaT7ntNsL8oSz7vx-0MPGKTF6rlCQ>
    <xmx:Qw03ZDiIAPC-6od2Xy_GWqAsry2lcao7Ra1mlTWCYV6JooLJiDLWfA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:57:54 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        adlternative@gmail.com, christian.couder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] doc: interpret-trailers: use input redirection
Date:   Wed, 12 Apr 2023 21:52:13 +0200
Message-Id: <12f7b10462184cbac884859e91d7b45e021041ee.1681326818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681326818.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1681326818.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Link: https://lore.kernel.org/git/xmqqbkk44qbo.fsf@gitster.g/

 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 15d34b983f..6b712564a4 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -280,7 +280,7 @@ $ cat msg.txt
 subject
 
 message
-$ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
+$ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>' <msg.txt
 subject
 
 message
-- 
2.40.0

