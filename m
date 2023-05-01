Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E7C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjEAUFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjEAUFu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:05:50 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A22685
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:05:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E6F2E320099F;
        Mon,  1 May 2023 16:05:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 May 2023 16:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682971548; x=1683057948; bh=PBJwvj4/7rMiKOK6yU58ocax7
        4D1zxG609oYSSATl+w=; b=a9/VoLtfonfkj5HivhaPOnpa7nFT7jFe3BsIfkt5Q
        JoSieoeuN4+s13HSBHVYqFyB/840MTObNOWdQNGZOl5vB9ymwKSaJfbir20Abvh2
        gZlZ70t730gDi4i+0Lymok9dDiSM/Raq15BMOtpSdmKXxy+PHTDEmTLYRQe4wM+F
        5rcDGKSYFUn8H2pc3TF+pn7xctYtn13MJ7Uy2klXHXHtB84OrdJ+N4pgoZ6bc0Pc
        UvrRZDa12bKoHABvIZOsOPbk62P3jzSB0siET8rhryt3npF/pMT8LELMkxzpO0go
        8IKl/mDtd9OZP6O/59zb8o4vtmbKGlLSS7b2B/tqNb7tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682971548; x=1683057948; bh=PBJwvj4/7rMiKOK6yU58ocax74D1zxG609o
        YSSATl+w=; b=FzUhPkZ3WULN3t59nf0XmLhPyx6pQx4rRn5UbU/izrqEduuQR2a
        jvS2F4Rd1yXTZO6cE/JQDebheGzmThgtsEFGAcz7AHo0kWK3pk7uSFUuwy+eMard
        wly9sJCTc4qDLNxb3JevWXUiR80Si3TILftI7n3xkzXkdlyHGxPlrmqbIL1oV36c
        o+dJJIEQSfRoZeN3kK3FxPTySzjiI3893S9IuUuS1P1RenpCpI9yV7jeIG9zwJcb
        sqlN1VUcRE9WFPlQLGiGekes7XRgJ2wgeHOwFpj2mW26HiQZRS6t3ZlweRQuJSEt
        84z+HuvGniLNvorvQB09OXkuHYnhgOazQwg==
X-ME-Sender: <xms:nBtQZNXl36Cs3Jzmb1rJtLx83O0fjCriIdyHv_yv6JueXIeVhsMIDw8>
    <xme:nBtQZNlVJIag-4s8y8M_S0HyUAK7QIiewQS7iO33HMPDDtcJwpExvFQfD-srodIHk
    zDAy-8fYNndILPEqg>
X-ME-Received: <xmr:nBtQZJbbBQyHlGKlngrQ1CZMFoptay76wUMrQwZQLSBWlQKHgLD_PuXSGbkc_WuBmx_zLMcMMlL43y0JTauc6kHFfF3L_1-iNhavLt2P5lOFeDnM5fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:nBtQZAWv8ij0a5hodVJsvrMScGH7zFBHzwbThY9FVvNVu_HN32KfRQ>
    <xmx:nBtQZHnHcmN2jlqW0IK4V775p_Be2J908Zovib_QYGU9qnZGogZ2Dw>
    <xmx:nBtQZNdAiMkS6Br31s0LSPRu6AB6jCOA-QEk8BZRlW66RYWHFNW6lw>
    <xmx:nBtQZPu1DITsM6oIS0RAbvjd3LWQRe9el2MFqBGju4N8r5aZftiJAg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 16:05:47 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v4 3/4] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20deprecated=20config?=
Date:   Mon,  1 May 2023 22:02:40 +0200
Message-Id: <9ea4c4f91673af53985aac04e93e5f46d9508fde.1682970213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682970213.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1682970213.git.code@khaugsbakk.name>
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

Acked-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4ff8be7f2e..acecc037ec 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -325,7 +325,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
 $ git interpret-trailers </dev/null
 
 Signed-off-by: Bob <bob@example.com>
@@ -405,11 +405,14 @@ subject
 message
 
 see: HEAD~2
+$ cat ~/bin/glog-ref
+#!/bin/sh
+git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14
 $ git config trailer.see.key "See-also: "
 $ git config trailer.see.ifExists "replace"
 $ git config trailer.see.ifMissing "doNothing"
-$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
-$ git interpret-trailers <msg.txt
+$ git config trailer.see.cmd "glog-ref"
+$ git interpret-trailers --trailer=see <msg.txt
 subject
 
 message
-- 
2.40.1

