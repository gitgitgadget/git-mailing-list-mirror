Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A800EC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDCTYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjDCTYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:24:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AF2120
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:24:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 128D332009ED;
        Mon,  3 Apr 2023 15:24:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 15:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680549854; x=1680636254; bh=DbnH6bGRPP/YtDhi2vh45Wj97
        1So9fIb1sBG7ZnysOc=; b=eAADgxDZW4jUOkuOG4fU4+y/Syhz5w5R7Hxy2CSTR
        5fp3B9kTwhIplpyVjzEeeduPrfeVlTvKDYclzCKlGiMVkHaVhPIu0nBBbdmMbZoP
        s14Mf5C+XXdld6504vP+qu2g9Y6LsEFOuJgiDLkgglgeoJX/ZMgr15jRkpaEOcMN
        5OVwTZ/YV0DrmV6o07zkKea9F2ysX7tLu8yk/dV45KAXNYH/vdqNOt1blArZa09x
        hKn/MPQBRRJWlSimeM9dooRqsAyoBSDJxA5H17Ncd2IobIT1CSO7SVZtSL3SlYma
        UrlrUPZa++oSvm0iIXhSfG4USixxTgcNdGlQGedA1OuiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680549854; x=1680636254; bh=DbnH6bGRPP/YtDhi2vh45Wj971So9fIb1sB
        G7ZnysOc=; b=dn0J6cs1bocUzQc1ZWl1JIgd3ejAyp9Kdd7hnUfJJQIt/qSSwXa
        8aR42VZTm3pgFkJlFlsLwfbQUDA9m/qARWBI8v8RsdziGVKAHg5f+1TNgt7XaXnc
        yU/ZVC0kOY5w419vgBXJueMLj9lrZoCNqmv+fAuPTu4Y8f4WxRWgVMW7Iv2rwCvL
        mkHi/2th+aX+ck4yvhWIQcmq0wY1tHBR9aeQat+xr6RL7HmQvMXU+vO2PrM4Xw62
        uUM/jLh5CNrFBafKNam0yPFaGVMkiuPq7cdPu2uYPxPZtZL9TDteLoDh0SNq4ReN
        0lgyIcMjh9GQZ1IlQMkqmLeG8TvdFaXaMhw==
X-ME-Sender: <xms:3icrZEaSaZvO5YvUKbLPo9NdA1esnvmiPensi9yO2woS4Hn3VpYaEIA>
    <xme:3icrZPZH3NmWZGAN6dKqIIo57PL8e4Hl2MWzU6CHuA_yYUfdCcyU9yBkL2J0gbBwW
    ylMa0uaG3R9A8hT5w>
X-ME-Received: <xmr:3icrZO__mU2QqULBMzvtalMgPZjD0yUFmwlmH5dyywBOIOUmfQ-t1NDi4pHy0cNKuaYf1Xa59NDkWZGBOaDUI6FedNVSG50Gaow_Iic6jpQMnWp7mEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:3icrZOoeut3wI2jF_gPjAHumKjqq4ugJeXJDzgFybhBsFhPZkqpK2A>
    <xmx:3icrZPopAUg5VoOQAqKaxKZXKaVo7ZTektHkaoU5Z2L1uJu39m5poQ>
    <xmx:3icrZMQXlLPfk6BAD_v8WezMhiTT_UW8kSIMSPqftH-moyEBv6loaA>
    <xmx:3icrZG28JRXOXi0YiX1MRz5Cz4I2LsIlc5biw3IZiOgSrqqz63ZJ1A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 15:24:13 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, rybak.a.v@gmail.com,
        ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v2 2/3] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20deprecated=20config?=
Date:   Mon,  3 Apr 2023 21:22:00 +0200
Message-Id: <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680548650.git.code@khaugsbakk.name>
References: <20230331181229.15255-1-code@khaugsbakk.name> <cover.1680548650.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`command` has been deprecated since commit c364b7ef51 (trailer: add new
.cmd config option, 2021-05-03).

Use the commit message of c364b7ef51 as a guide to replace the use of
`$ARG` and to use a script instead of an inline command.[1] Also,
explicitly trigger the command by passing in `--trailer=see`, since
this config is not automatically used.[2]

[1]: “Instead of "$ARG", users can refer to the value as positional
   argument, $1, in their scripts.”
[2]: “At the same time, in order to allow `git interpret-trailers` to
   better simulate the behavior of `git command -s`,
   'trailer.<token>.cmd' will not automatically execute.”

Cc: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index dbbb6815c3..c76efae76a 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -325,7 +325,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
 $ cat empty-msg.txt | git interpret-trailers
 
 Signed-off-by: Bob <bob@example.com>
@@ -403,11 +403,14 @@ $ cat msg.txt
 subject
 
 message
+$ cat ~/bin/glog-ref
+#!/bin/sh
+git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14
 $ git config trailer.see.key "See-also: "
 $ git config trailer.see.ifExists "replace"
 $ git config trailer.see.ifMissing "doNothing"
-$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
-$ cat msg.txt | git interpret-trailers
+$ git config trailer.see.cmd "glog-ref"
+$ cat msg.txt | git interpret-trailers --trailer=see
 subject
 
 message
-- 
2.40.0

