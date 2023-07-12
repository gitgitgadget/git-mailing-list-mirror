Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA38EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjGLQB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjGLQBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 12:01:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E81980
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:01:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D2DB45C00A2;
        Wed, 12 Jul 2023 12:01:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 12:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1689177681; x=1689264081; bh=MXi+TNMsIz
        k28wXi2I5PFwHtPPlN6jLZgUCk/rVgwPc=; b=dwA598u54b4TjugAq0MOcBb2vP
        bHjayPh3rktLv2cP8IMvy8JIXGmDUiRfw4MatGnSGE2zEntJb8ho9AORXdtl3a4r
        yWFw04JEdYVTkAJYihKgOp8J/+itQz1db/6wKWJCDX7YMVGQlSCz3OcFb97lPuT5
        xk3H50v9glDCxogqNj9/kuqRXmxLKHjveHCcG/nYL/q1Rc0QIvQQUicpHpib5F2D
        OPM+fAo+H9tQ0rjnAUSBrUMqAydOTiH8rwQXK+wGP/+aKv1UJB9WGF9ZIAjPqWyx
        a2vkspS7nE+TjRuivdQWNn5ObXFchBNkunsBZNUpBSZhFX0Y+M54AIUn3A8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689177681; x=1689264081; bh=MXi+TNMsIzk28
        wXi2I5PFwHtPPlN6jLZgUCk/rVgwPc=; b=Pd5UUIpt3ATG/kidaWbxdZVufyjzn
        6NFaeZg/WOpQxZ7//4gKRAheLgfx+JcvcVxyHRz1Jalkvdd0ie0OprOt/AZYqJAO
        BgGaIWxVLN0xFin49eudHPBbe+1hWeDbCmyv+5UGL7kHl1n67SAPKjsWp3NGnDRE
        OL0ntctPpnG5O3kr8A3Z6876Z75iOQ5emXxRXNvR+YHVR/94T4ajBMboaspCpnCK
        GxKre4SXy+78nQj2v+fFNrMt87Oeq1Qd/8+Soea2uwcxBDOyPFP6egGrrdZvugR2
        eBntUYHOpHnBkIKD3E6LmBqbIlonRUQzyqpWBLNrzb9ju6XEwJ3DS8Ong==
X-ME-Sender: <xms:Uc6uZORWfqdOKnBizkUGHvUK8Aw7rYB_s3IlkxTDZZunYGdoBDig4A>
    <xme:Uc6uZDzzAe0kUUpvOkM9WNNZVcHI__N7HJ9eWFMeWjY-n2RKfjDEPKQK5CMHv0ZrZ
    7KE0XArcFnTu4OH-Q>
X-ME-Received: <xmr:Uc6uZL3QDOXcBKteT_dvVBkmTrOgQPcRR_V-De6iwWQBL85gNTBzT3hqJqM2ydFlDDr5Bc2rcwd-cc0bg-Oty2Mo5eUuW3dMtFSuioUgnHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepphhvuhhtohhvsehimhgrphdrtggtnecuggftrfgrthhtvghrnhepiedvte
    dtffegvefhudevgfetteegieffudfgudelheegteeileelleeghedugefhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhvuhhtohhvsehimh
    grphdrtggt
X-ME-Proxy: <xmx:Uc6uZKAaHqMIdATkLIfPOjNC0IwYe4tn9ydvlCOA84NfNOLugnOF6g>
    <xmx:Uc6uZHjagAewVU2ocTjC07GKGmWRpjTaTO3oEwbl2TlHootdGOqduA>
    <xmx:Uc6uZGpxq-3ORZD8y-EpgiPGi7lpSd34gBFf9MtcySBpKAUFYeksnQ>
    <xmx:Uc6uZHJo6jKMsK6n0g7Ng5O-i4M5J8VigUQDZBA1TfNauWr4ZmZ4DA>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 12:01:20 -0400 (EDT)
From:   pvutov@imap.cc
To:     git@vger.kernel.org
Cc:     Petar Vutov <pvutov@imap.cc>
Subject: [PATCH] doc: remove mentions of .gitmodules !command syntax
Date:   Wed, 12 Jul 2023 18:02:03 +0200
Message-ID: <20230712160216.855054-1-pvutov@imap.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Petar Vutov <pvutov@imap.cc>

To mitigate CVE-2019-19604, the capability to configure
`git submodule update` to execute custom commands was
removed in v2.20.2.

The git-submodule documentation still mentions the now-unsupported
syntax, which is misleading.

Remove the leftover documentation.

Signed-off-by: Petar Vutov <pvutov@imap.cc>
---
 Documentation/git-submodule.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f9..b40ac72f75 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -163,12 +163,6 @@ checked out in the submodule.
 The following 'update' procedures are only available via the
 `submodule.<name>.update` configuration variable:
 
-	custom command;; arbitrary shell command that takes a single
-	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. When `submodule.<name>.update`
-	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
-
 	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
-- 
2.41.0

