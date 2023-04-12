Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD26C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDLT6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDLT6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:58:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36A65A7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:58:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 506E55C00CE;
        Wed, 12 Apr 2023 15:58:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 15:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681329517; x=1681415917; bh=7EmVg5LaMS55PHupRNLqYaRMJ
        t51wP017vloNVEO+Vc=; b=TiWoe1e3nfidGHVd8Nm6eWp1Q2ylyG6CBv2XoJHlP
        grEDhS48B0JEuUj9srO4oMtjndQUOlc7M1OZwtSNslX+U6JvivGN4gLakPmCFIjT
        RCP+lSg5bPHYwkbP1jpF9HEbVRoe8x9uMOwRzvYZOmU/nnp5uR68YQiP/JWlsaU5
        zcGaInC6H4p3NqTEZLYibPpdis2JUH+jjKSy1tYjfvXL6LiAvsvdVEreVrL70kdp
        f15gmJsvQAw5+opn34fLhJ1NEmOgMvmy2fb/5zH71OyC9IGQGwi9igc6BcBt58GG
        BdCxLj/FQaKvUQ5l0/PewU7DTkj9pv1Cs7JeTIu8s9LhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681329517; x=1681415917; bh=7EmVg5LaMS55PHupRNLqYaRMJt51wP017vl
        oNVEO+Vc=; b=ZDQep+eEiDQYjok4qQOQBcI6q+msAmCiTzacSc4tgovNDBDyNkV
        I5L9Qp+hJxuUfOOrojXt2GKaqbqVi/r4cByGkNhaXFI8dE5zzV5veGfOpNR4Yqr/
        f2vu/UfB19Zg/f3re6mPJ6MibiUTUCwSRbQGhGc2kxjMvq/TkXvf+/O7XC0qOZGB
        IDwnLZ77NqQD9jS30ZvIKiw31RGx6mCPjDHojAIlqfn5XgrYCxOcByN5rnlfYogM
        CihY4xxv+jHRzhaoI0dvl0SfxW/93pZ4whZZAaLj2qyNOHGV7zwyN1QPgFnTzFiq
        GftClEf/Xgsrz9nPN0DPAsijg/aqiBT96QA==
X-ME-Sender: <xms:bQ03ZJNIj2AUzQpVnuHKgBLFLvksSAIlOkaOnFykNwTA6IHvtIlgNr8>
    <xme:bQ03ZL8UsIGgiATE52p8E1IVOKCOGKBvaYHZclzziCophujKzArwVkJDnEaPKau-t
    7Pi_OznZLWQkd1qsw>
X-ME-Received: <xmr:bQ03ZITHECR4dP4DPAKZgfDA7zhMbgPKoKXGaZc1dsnOtE5gz_1yXv1ovOTffj8EVxP3iW-7e4e31HwefYntwzfDX9VeVNJoyEusiG1j8rTP4lUMftU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:bQ03ZFv3-Bh8IAZFkYQb7kvzpQLlbu1Zd-dcOV69Vg-Lxm2iHL_7TA>
    <xmx:bQ03ZBfYZH74pSA6pDadm0sEPktBJ0vCFeyJ0v6hpUrv6VqhxbyHyA>
    <xmx:bQ03ZB1ILxPhXAF__ff3Wud6IQh1Qejc02A1DsH_h6PH3dUzTpfR5Q>
    <xmx:bQ03ZCoxVC4QkzFTTMzhnG9H58JZjJgRYqaliTcuOTCcL-idEfYqAQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:58:36 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        adlternative@gmail.com, christian.couder@gmail.com
Subject: [PATCH v3 4/4] doc: interpret-trailers: fix example
Date:   Wed, 12 Apr 2023 21:52:15 +0200
Message-Id: <f6e56051078f01310b1196d64f97c2cf6173b411.1681326818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681326818.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1681326818.git.code@khaugsbakk.name>
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
index d2a23e9161..4b97f812be 100644
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
-$ git interpret-trailers <empty-msg.txt
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
2.40.0

