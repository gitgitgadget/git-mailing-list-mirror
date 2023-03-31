Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83024C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCaSOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCaSOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:14:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C0DBE3
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:14:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 45F1D5C0144;
        Fri, 31 Mar 2023 14:14:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 14:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680286486; x=1680372886; bh=/8ZkRFyNvmDqcOGxr1mquHr9m
        vq5jukichXQLo1uBNE=; b=RU/lXu1wkiz+c+yh1HdChwaXACtHtT+Rrdsa0ksZ3
        eFiiYgBN32zsgQHZmYqo/FlYqr+RrRb6ceMZa5aBvlSlt25fu4ltP4atAb+HztrF
        BRAaTx0R4ekXvZUhDh4IaTUIlGoVRJlMZn0MIoqTLSCAytnLHW1471xJdN0SOLgB
        d66UMjNDrJFERGz6oPPtv99ydkBOnd/U6/YJL/ebCQSESruSYvbc7T4rx6Qdo2CB
        bRJ1VrlGGGmRWqiq1FuAN6F46Uq4+i/WpfPOdOUkgvDgI1R8CfD48el2LFvR2uCH
        XrOYl4gqqFLh8/r5pga8wHT8R2SFHOpEy73Swn1RQQWNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680286486; x=1680372886; bh=/8ZkRFyNvmDqcOGxr1mquHr9mvq5jukichX
        QLo1uBNE=; b=WH2glAMnnoSa9d8UU16wKxCKMhHxvEMdyTHWajdnbmPNOXxLXOB
        rNNI4dcFfMqmNgGS7vkrr+fhp2fHyfbO07t3troIPY/vb6dzo+kLq+Aq1O9MmR5r
        pcbjJRCTEymITFYg5woM3SZwRpqnW+yu8ZZ4VnMsKNkLq2uLIY1mxiyFNwA2Mm8v
        LUyWWdra6W8qUuvrW6e2EGigrLeES0ktK4gRx1eOwFc8pX1x9ueCrF37BAfUqsOw
        E4YgrhCnZKLRKHf3dy53ZQB+0RrFHq41D05Yfbi2w5kDEmRXQ32cf9tR2SoOh6Ha
        gBrFCEemD5XJqHjjJemiVUO8FJ8zb5JkWNQ==
X-ME-Sender: <xms:FSMnZG-VJa1114FG6glmMhTEGGumRBd8Mo0TAzadrVxX1BCeYAS9tPI>
    <xme:FSMnZGt2jMm3e82Pndb6sIRU78dlA4e3kMXn8V5lpQa37rcOZzHuIaIiTrLrNW3vV
    E_coy5My7hvSYl08w>
X-ME-Received: <xmr:FSMnZMDlNu_HrIdZzn3tMY4LSKmFdzg5CWXLv4RUkNYdVinFKMnXyP4A8OxxydqhkXZ1Rhbcx6TmtHAKgpq4snlO7J844nl5oyqg2CHx9WKaHRXnO2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FiMnZOe-rb4_86ot6IiMHMd_rRC7kwHhKS1hIbZA-Xym1C8LjJgNCQ>
    <xmx:FiMnZLOWtdSS73lLPV5_eh_mZ2wxH0jOeXPKin_q8E5aUT7MaE3_WA>
    <xmx:FiMnZImYoF6qDKQJtp0Qo353oUz3rtAASrZYChgwMb0lXD1yzP5GeQ>
    <xmx:FiMnZB0gsaki7064umI_PGHOe104HeFT8KVpzuHgr4XlQVDBNhDUog>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 14:14:45 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH 2/3] =?UTF-8?q?doc:=20interpret-trailers:=20don=E2=80=99t?= =?UTF-8?q?=20use=20deprecated=20config?=
Date:   Fri, 31 Mar 2023 20:14:22 +0200
Message-Id: <20230331181422.15409-1-code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331180817.14466-1-code@khaugsbakk.name>
References: <20230331180817.14466-1-code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`trailer.sign.command` has been deprecated since commit
c364b7ef51 (trailer: add new .cmd config option, 2021-05-03).

Use the commit message of c364b7ef51 as a guide to replace the use of
`$ARG` and to use a script instead of an inline command.[1] Also,
explicitly trigger the command by passing in `--trailer=sign`, since
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
index 787332771e..792d61ae7b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -325,7 +325,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
 $ git interpret-trailers <<EOF
 > EOF
 
@@ -402,11 +402,14 @@ Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
   commit that is related, and show how it works:
 +
 ------------
+$ cat ~/bin/glog-ref
+#!/bin/sh
+git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14
 $ git config trailer.see.key "See-also: "
 $ git config trailer.see.ifExists "replace"
 $ git config trailer.see.ifMissing "doNothing"
-$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
-$ git interpret-trailers <<EOF
+$ git config trailer.see.cmd "glog-ref"
+$ git interpret-trailers --trailer=see <<EOF
 > subject
 >
 > message
-- 
2.40.0

