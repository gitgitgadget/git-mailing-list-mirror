Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC10C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjEAUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjEAUFl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:05:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78821707
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:05:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2C4463200392;
        Mon,  1 May 2023 16:05:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 May 2023 16:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1682971539; x=
        1683057939; bh=tGIxcmWDFNtNc2K2H3m7LkQpAtz7EbGLGzBKRBxYgTk=; b=g
        75ExpgLwm1Xrm5IZA5ISOP0mzx+YSSMxtyoHSrmJeDuV6zZBAbxo3DT/5+/nIBht
        ADRO4tJVW6L0O1aJTpoXGGGcUNuI6dNQZdHTe8SDdJlkCa5SZmBCRiKHwtC4s/Nr
        F+Pod/xRP4S3sLI27qvFQuojZPxKe0Y9Z4L/5EZM47siIWmQqwWAX0wdhVG5HKvG
        jG4cvmv8npudPROKEpKrJDRlRxObRWGQFfrh117p3gEJzH3dKpjlw9cWOp/Udqpu
        13mcM0hk42DQonO4NsvIzihAfwew5HZ+rrnl5JFiZ+n00boJmiriCmmi5poUV7+/
        EP/gooX7qI5R085f/debA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1682971539; x=
        1683057939; bh=tGIxcmWDFNtNc2K2H3m7LkQpAtz7EbGLGzBKRBxYgTk=; b=P
        uqIFey2DN0MDrWxHbPbB/H49w3+IQlba9lP2yP3m1/JEI3dDTKr4YMHezqz4niAP
        Po0cVokuGEFyEY1F33wLuxJlUXx4iPTv1goP2aTOiis0QrNaIGZMmyV7QsYHtMqS
        8CVcWL98wkgenOIBx//LhVjHGeQLbI6bic67MHlO8FlC/Dyfv7+Yq3X3aRYrAq3J
        7UzAtA4fe12lzuKnfgn2OLR6X/TTccTfypDybI07yjjRqLgK6kta2hnoAjFU4DN8
        Y289bYIUQQ8J0ujAPcACcP9dxXGGhmeXJQCuP+7JqIFO99vhXH22sMEd3+lGZIVA
        Mdots5TcIZkZE+zaNImSw==
X-ME-Sender: <xms:kxtQZFaSEP868F58OJhulzO96NMG8nqE3MeovsZI1Az4gqd_wVYr3Hw>
    <xme:kxtQZMauxUA5-3mqBpby_cKau153P1esdsgmGWW1fsSpd1krvmv_nvYmmYYlVZBcl
    WN_Wybqu49Uo_G37w>
X-ME-Received: <xmr:kxtQZH-mGfkFy1ZxE_PWDTg_ESPKF6aZj0z9X8hpm_FnsgAOi7S2iLgO_6MxACDFJjAozScS_7yzy4IfTaCo6gB7qmCtaW-3vRyBdyMHqzCAdr_yPhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefhud
    evveejtddttedvhfelffeuuefhffeugeeluedtgfdtuefhtefhudelleekteenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:kxtQZDpqef-v-ucwB7dr4QKI6oNmczvO91Kax7ITTFAfKrSRx73RyQ>
    <xmx:kxtQZAob3lHpQ3hHjGTkSZAxMrxR36Nq50zQsdquN-gQDXvKagxY3g>
    <xmx:kxtQZJQb-4E0CfT2vPWAsSMeAi1kNI3M-xg5Di0MbNMkH-h3CJURYw>
    <xmx:kxtQZNDCWdMvdhNFAIJnwq_qtRWajQivr0h_3x2t7Q2seHerSsttYQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 16:05:38 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/4] doc: interpret-trailers: use input redirection
Date:   Mon,  1 May 2023 22:02:39 +0200
Message-Id: <32483aa635a61283c3c901c4705e531c9736209b.1682970213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682970213.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1682970213.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use input redirection instead of invoking cat(1) on a single file. This
is more straightforward, saves a process, and often makes the line
shorter.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Junio suggested expanding the commit message:
    https://lore.kernel.org/git/xmqqjzyg7qdw.fsf@gitster.g/

 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4f4eb7a7fc..4ff8be7f2e 100644
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
2.40.1

