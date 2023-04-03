Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14668C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCTY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjDCTYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:24:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403ABE7C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:24:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7D7DB32001FC;
        Mon,  3 Apr 2023 15:24:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Apr 2023 15:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680549863; x=1680636263; bh=FZEL2LyYcImzvZZjNh9aXtmaJ
        Tc1ElbK2NRnWr8bw3U=; b=ZYdmRs7c/0YOhmYXOcr8mkkm9FjISCWO6rvVjEU1A
        IGr5PbkMPR/taeyX1R4IDZFjDM74A7uVqLVA+oCSVa0AP8MZa0IPkSGY7UkqFS+r
        YTtid5UelOMUnfrBinuuw2juYmvaAUiyxaimxG21CBikAYz/rFK/0UpGQ/oNnHeK
        i8PLMmaUoN7Ouo4qcguilTSig2iKiZfLFZNNw07T6QzMyt/Dl4XXd33SQwty8uHK
        wRa6fQ7DEHcNfGuK0N5ql6DZJZiYa0TeK8XCNaX5eb2iAV7ys6gpLM8s44L+KlTA
        eJilG+pWbuHgfNTdmop3EJ/trxb9AezLQ1hZmnxzpqa/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680549863; x=1680636263; bh=FZEL2LyYcImzvZZjNh9aXtmaJTc1ElbK2NR
        nWr8bw3U=; b=AIbc2Sj+6utn6xkYnZH9wNK1fiUSWhvPQ1cQqYLXkHVafGzXxAz
        h0xthIVC8Wj6gTk3ql9uPOJbIiSAyETTYQBP1a228qZQ8wfLJtuewgjI12nvQl0a
        zqYuEzwcrWX/8FSkvOtkL9uO5FxWl1NU3e2LUkaMtNoZ4MPDo03NVNYDAoORPRXB
        65COESgiFZir+I0m7HTbEVnZHIc4mevtVvPIvyFeSuggJML8OUDdL8dg3XNm/Nga
        HmWoTPwEDeuMZ+lTVapSL2WTdPKH1/e0g9MKMhy3DrQqwvoKfHnYOtjf46iaeN/K
        HUCbBhOMVkt8nFQpHXxRXJLvypeDuFI116w==
X-ME-Sender: <xms:5icrZD-3GjmttjBx6Mc_9PoubmIakHgWUXeDfrd8Bt01ciSXslQJe14>
    <xme:5icrZPu7DCnGB9_YuvtREXpktXK7SnvU2UMY86ah7F9ahgz6NJy26-94LVRd5AVZG
    undMM4Zo46AqEHg6Q>
X-ME-Received: <xmr:5icrZBDkE9guJg5BTfCwvTFdhqfJwAyUScNX_xnXKTxQUt4jNlBuJ2uwwZItIBQORrN4UpOW2JxFWYWYyh-xoVcHhG332nRwWel324y5A0EctAvi2XI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:5icrZPfmAUOGXnhfY8rYQ1BE6iKpwdZV5u5KEvD6vRnTtx7UkLm83w>
    <xmx:5icrZIMFSZf8ri7kmEkbyIyUq-mibk06trhksLNni63h2E8vsBn2Qg>
    <xmx:5icrZBmntTRYsSF9B7DtY69yQgXW2rm1ejjHTaR3vSOwh60cNMxqRA>
    <xmx:5ycrZBYgkMAbHAM68TjJVelApuUpVoOEkLLWcDZGmd0cc8cLrm3E3w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 15:24:21 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, rybak.a.v@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] doc: interpret-trailers: fix examples
Date:   Mon,  3 Apr 2023 21:22:01 +0200
Message-Id: <14555cf87fa5fdc0ce14c7077ba212d16ad3bc76.1680548650.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680548650.git.code@khaugsbakk.name>
References: <20230331181229.15255-1-code@khaugsbakk.name> <cover.1680548650.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to provide `--trailer sign` since the command won’t output
anything if you don’t give it an input and/or a
`--trailer`. Furthermore, the example where `msg.txt` already contains
an s-o-b is wrong:

    $ cat msg.txt | git interpret-trailers --trailer sign
    Signed-off-by: Alice <alice@example.com>

    Signed-off-by: Alice <alice@example.com>

A file which only consists of one trailer line is not interpreted as the
original example must have expected. So change the examples to use the
typical “subject/message” file.

Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    This isn’t just a quirk of this series but also happens on `master`:
    
        $ git config trailer.sign.ifmissing add
        $ git config trailer.sign.ifexists doNothing
        $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
        $ git interpret-trailers <<EOF
        > EOF
        $ git interpret-trailers <<EOF
        Signed-off-by: Alice <alice@example.com>
        > EOF
        Signed-off-by: Alice <alice@example.com>
    
        Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

 Documentation/git-interpret-trailers.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index c76efae76a..c6f5b92ecc 100644
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
-$ cat empty-msg.txt | git interpret-trailers
+$ cat msg1.txt | git interpret-trailers --trailer sign
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
-$ cat msg.txt | git interpret-trailers
+$ cat msg2.txt | git interpret-trailers --trailer sign
+subject
+
+message
 
 Signed-off-by: Alice <alice@example.com>
 ------------
-- 
2.40.0

