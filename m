Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA023C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjEAUGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEAUFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:05:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036A2685
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:05:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 44B77320094F;
        Mon,  1 May 2023 16:05:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 May 2023 16:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682971551; x=1683057951; bh=Ha/vK0aQTChyGt/tMU53E4y/s
        LamF/w4nZzn7hoC2uk=; b=Ph50aPAc2K6ZWrJbQBqmlf4yhzMBZE44OL5icjwIT
        XjPPo9G+4Ic4B/AFW2Lm9QvwleLjdafVJLYLMO9KI/cjovbSO9a4JERX2Gu1/52R
        ucS4UEPxP2yC7ABPBNQyOZvpDlr6uCJK0K4isPyjuzUVdYDALp9390zjThh5zA/6
        I5ZGc1aVZC8oOW36ruEKnhY2dOEj4omVPhcVNMwuPFWAwPET9moR2V5xQjLOcCHX
        oTW4763DiUV9JsuIbREG2xMDtujX1YaI1rMpRbUJy5jO0teLqe2GYuSzhCoOJQLt
        LV0jamC9jCIhWueEL6AEDOsJbFlA6osL/iHztckzP4SJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682971551; x=1683057951; bh=Ha/vK0aQTChyGt/tMU53E4y/sLamF/w4nZz
        n7hoC2uk=; b=JIlXfdG3iHZReDD3MNbBtngZiezRXe/V55MPOacDqIZCqUe9Njd
        ps0lZooleiBbF7dM/2yDd9K7H9Dzw/YM1uiyPAkYO8nwxRVhNG0N8ah9jPNQk+f8
        TZIoTmosXG7D6QfsmW5KwzVakluzfFH5a2og1bbZB+KsNHf3Jk3mkknafcHd/3lo
        tcdEcMEP2T4bqPZIzOWNoMksDxZceXaLbo63TS8hAh0W93nVoL3JGZPry/1BWcMn
        K1Yalhj/QWPDDa8gIZCCqQyzl35v7UusxmLJlIA/FEgWotSNxBcSNmulADw+wRm2
        1fD/x0pR2SrEduJMay09RsTtwW+DpEclpvg==
X-ME-Sender: <xms:nxtQZBARK69LHr6uWzoAQoRlRRstN_PtrAUJmheOdO7ue3JgARWTkpI>
    <xme:nxtQZPi_YCku2jeHNMgvcilODzsaHjPokr-9lnyGuJpT0NmtI74NhwrGN04TkzU49
    mbN8Mh6KrmzbYzlKw>
X-ME-Received: <xmr:nxtQZMnkqoqBQtlTPJ6l0F_zniLfmQZxTxD6Nj2TchqKMHo9sGMLqfpqu_eXmZqp13NHn1mgcZMugwxxlXs0Eh2JDkrwScpV-6GXd7C6c4YfWLNFMQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:nxtQZLxrfxCVANOt3eZy8o5R_YnF1xWoxDrZ5ugwIAGXSDgQtEiitQ>
    <xmx:nxtQZGSLnxZKFlPAE_KNT9nwrHBu-3CDv0qNP7AzqeiOk8mDp6egkw>
    <xmx:nxtQZObNQLLkIipEXwK02W2Duotcwk6g8U4qU3e3FC4HbL96yLTYXA>
    <xmx:nxtQZP5xehTjCcBFJBedkyVhhOad-5qK3ehU8N4DImXvBsYpu1K8XA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 16:05:51 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 4/4] doc: interpret-trailers: fix example
Date:   Mon,  1 May 2023 22:02:41 +0200
Message-Id: <95760aafe86315c67115e4152e9ea98737de8c9e.1682970213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682970213.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1682970213.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to provide `--trailer sign` since the command won’t output
anything if you don’t give it an input and/or a
`--trailer`. Furthermore, the message which already contains an s-o-b is
wrong:

    $ git interpret-trailers --trailer sign <msg.txt
    Signed-off-by: Alice <alice@example.com>

    Signed-off-by: Alice <alice@example.com>

This can’t be what was originally intended.

So change the messages in this example to use the typical
“subject/message” file.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index acecc037ec..4b97f812be 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -322,16 +322,30 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
   'Signed-off-by: ' already, and show how it works:
 +
 ------------
+$ cat msg1.txt
+subject
+
+message
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
 $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
-$ git interpret-trailers </dev/null
+$ git interpret-trailers --trailer sign <msg1.txt
+subject
+
+message
 
 Signed-off-by: Bob <bob@example.com>
-$ cat msg.txt
+$ cat msg2.txt
+subject
+
+message
+
 Signed-off-by: Alice <alice@example.com>
-$ git interpret-trailers <msg.txt
+$ git interpret-trailers --trailer sign <msg2.txt
+subject
+
+message
 
 Signed-off-by: Alice <alice@example.com>
 ------------
-- 
2.40.1

