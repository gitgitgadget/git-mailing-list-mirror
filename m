Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB2C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDLT6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDLT6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:58:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E248D3
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:58:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AB1205C00CC;
        Wed, 12 Apr 2023 15:58:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 15:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681329510; x=1681415910; bh=Z/9eJg4mSH/W4d14sZnnZe9Uc
        M00AmOa2B7xhBAxaXQ=; b=wlTiahvH6ahT7n7g12XvzBQ+QUmV1R+p5I/1Md7dV
        FgBhMnCxgJojt7Trf87pJwzmkZtCY321ddNpWiOx4u6Ahg7701QfODNIG+qaskZU
        G8FNz28Cjkf8kA7Hx0khJigUJyK9QJpyAF5g7H+cli/7rsbUcqp91AdtQcgtZqEB
        kSlzn2v8cuHVXLItoqmHatb30a4SVHwtk7O0TYvn0L/VxCLqX2LSHjk7C0SDOtmI
        tS9x10i8QaYSFdiwLMn5p9n9k6P+rGLWV1as5k2iX02zB4rfhbjj3koDK0Ei4Asg
        ciM9X+rgg/15/n9Fv7VFXnsMK7l1snHKSQy/JuEKnOviw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681329510; x=1681415910; bh=Z/9eJg4mSH/W4d14sZnnZe9UcM00AmOa2B7
        xhBAxaXQ=; b=K1+1vSjSRNRGFhGyRAr3EEKMmP4YEIz4ZdBBZ684t/zaOA+ZyOU
        BRGRFW7rCBQsBCvRVUQqXocVYTQ/+AeGThBeb0+/sClKOTBc4TuP8+JHX4828L/1
        PjdSOe3V/XCueBGEJccKT3h1rRSR2cl898oJozNPSjtMcd+6j9eFAkeeFb/ZjnZS
        a5+xxmZVoYU6pK8Dg3exDSD9oaU2zS35uTVZzd+cPo5mfbc5N+VNPbBbVu83WCXH
        pKJkngMtS4jIxgyrI50eH4ZWuot/KDTgDsZNWEjLgIzRnoXVbilcLjhh5d/NhzJB
        4Tun2x4Ga6m7k2HuRkIRX7vsp+ZSCAwE93Q==
X-ME-Sender: <xms:Zg03ZCFsF_vZEno_gpMYNZQR4QSm1teFRxdcHA4c5J80HAMqtekX0hw>
    <xme:Zg03ZDXMgIiadkR-KOxPmxuude7smpGcMtMtB3Sos0Gb0WX3q45POFdiJYmx9coDc
    UYIp1S2AhMfq0MNVQ>
X-ME-Received: <xmr:Zg03ZMLoigQ_EoKZcYj4pi5Y6LGnPynHMUeSGhK0RWOXM3BpbL-Qbk0trEttZSgNB0XEI1pAXcjgpEx2QsLdbkNu1YY0Msx9CRfGtnICinXfD5-52Vs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Zg03ZMHS_s85O9mNGTe6vXNc3hVouJmiQwtwKcdDQz-_Jeo1NX4I3Q>
    <xmx:Zg03ZIXmCGXWy4_BuqAhRBaWV1Q_sSXK8IV9sRTmvqXEuzhWYwH4Yg>
    <xmx:Zg03ZPNAaF14WGHedrQPO1d_V4M54resOFQr0MXuQmZCk4fn04sCKQ>
    <xmx:Zg03ZFhfVjbEG76v5N1E-ro31X0_nokME6-6Kpt0Mqx5kVljfz9Z7w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:58:29 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        adlternative@gmail.com, christian.couder@gmail.com
Subject: [PATCH v3 3/4] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20deprecated=20config?=
Date:   Wed, 12 Apr 2023 21:52:14 +0200
Message-Id: <dc1982f0d0a26b13b4b2f37ac844bc85b891157a.1681326818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681326818.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1681326818.git.code@khaugsbakk.name>
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
index 6b712564a4..d2a23e9161 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -325,7 +325,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
 $ git interpret-trailers <empty-msg.txt
 
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
2.40.0

