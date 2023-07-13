Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65256C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGMTc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjGMTct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:32:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15C268B
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:32:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 11DB95C0178;
        Thu, 13 Jul 2023 15:32:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jul 2023 15:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1689276768; x=
        1689363168; bh=BT94B+1HT9cB5m090ZYkRBqzhZqGQyqnt3KEenOOepk=; b=N
        C7T3XsfVjPKFIC6ADY6CgcvC9vR0ke0D1ed5YtcReC/6xx7/BEX8Dj6l1dEEeAjq
        WYmrIHydPRv9IJ2wWPdp0/ydI1yZ8Q+deZT/Kk22IJvDAiKJ9/pjMt8gU9yutLYE
        NrJMesu01rWUSzkQUtC+gxw52LwTYHPCEzwbYq3hn2IKacnFNVKPykdMdVT4HNPN
        /VHNOJMbHP7y53HIOA0Bfp6vew+7G9Rqo86upGgdNu5Q9rltKRZhNokxqWNF/TU2
        5QVUy5wg8STlTTY9KXe7rNV2irKYiSliqgtGsdSouEPJJMKCEexUUcQYJyLnkY6X
        kwLra+grQXU7HsAJS0P1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689276768; x=
        1689363168; bh=BT94B+1HT9cB5m090ZYkRBqzhZqGQyqnt3KEenOOepk=; b=T
        LvVjsnlcpAbYt2+zNNsXKHTAwV6+Pe1DOeK119MBUR92YevZMOXEvFmBHE/wrg7D
        N1qOH/dgfBF3E1GuSxTJX37UiKy9fvzlpfX6LuWjbFSQ3B32gbDVlYz7r0gn4UQ4
        mE32qn4qeMopBK1I4SO92pzXdnn3qipBf8w7VI+8KunXsK7cGi9/Zd9+lLDhll3f
        lyYDj+uJLYLB17tq4Au8oKkdtYH4BCQZu0Ck6WreSIOoCjEv4e7SKCMBJfGMco8o
        YZe381lq6q0JfaJcxPJ0P9CJi2dCkUw1kpgwvXcJC6o2F6FLAR40IAlldV9tFkYV
        UPuaZ1oGJCo2ABMSMUuhw==
X-ME-Sender: <xms:X1GwZHtmLWiXC6j1n6MbWAHAU66kxMMPCKyI-KPeNsQEd79A2Vhcng>
    <xme:X1GwZIdAwZBav7Fjjo0leP9VoDyIjvZWNrvfCmjS7Ma_ky6z9SLsuzMa_9vPmx66G
    vxCDnIzAOu1X4-9ZA>
X-ME-Received: <xmr:X1GwZKwbFsgGDdUpuHLl6XuAC0UKMCQHGrCJFXRl0d4i5cwVMZZV9A1ko2hiogFblBJ8mrWgxCfBf4iPcwON3A2cl3PLtzoA8NpAULuWRlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenogetfedtuddqtd
    duucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhr
    ohhmpehpvhhuthhovhesihhmrghprdgttgenucggtffrrghtthgvrhhnpedtuefhvdfhtd
    eugfffieejieduheeiuedthfevtdekgfevveejjefhffettdelieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvhhuthhovhesihhmrghprd
    gttg
X-ME-Proxy: <xmx:X1GwZGO8uf2rBS_KhdfpHi-gI7nhesc-c3v-jtjb66DW7xjlJaLVcw>
    <xmx:X1GwZH_s3aigGvDeQ3-o1xoBq5FMJLrpZS5yLDedMG-kBKTxc6VCtw>
    <xmx:X1GwZGVo8vBVuI47z8AJptVg8YsXOBJNmqUr_oKz2zSEFSrJYkJouQ>
    <xmx:YFGwZBnRmOO9rSNqJcbbEasLAakUEwCshfxsF0xmdBXL355pY5aFKQ>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 15:32:47 -0400 (EDT)
From:   pvutov@imap.cc
To:     pvutov@imap.cc
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v3 1/1] docs: highlight that .gitmodules does not support !command
Date:   Thu, 13 Jul 2023 21:33:42 +0200
Message-ID: <20230713193342.1053968-1-pvutov@imap.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Petar Vutov <pvutov@imap.cc>

Bugfix for fc01a5d2 (submodule update documentation: don't repeat
ourselves, 2016-12-27).

The `custom command` and `none` entries are described as sharing the
same limitations, but one is allowed in .gitmodules and the other is
not. Instead, describe their limitations separately and in slightly
more detail.

Signed-off-by: Petar Vutov <pvutov@imap.cc>
---

Changes from v1:
Don't delete the documentation for `!command`. Instead, highlight
the differences in the limitations of `none` and `!command`.

Changes from v2:
Improve phrasing.
Add the bugfix blurb in the commit message.

 Documentation/git-submodule.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f9..69ee2cd6b0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -160,16 +160,19 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
-
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
 	    superproject) is executed. When `submodule.<name>.update`
 	    is set to '!command', the remainder after the exclamation mark
 	    is the custom command.
++
+Custom commands are only allowed in the `submodule.<name>.update`
+git-config variable. They cannot be used in the .gitmodules file.
 
 	none;; the submodule is not updated.
++
+The `none` update procedure is allowed in the .gitmodules file
+or the `submodule.<name>.update` git-config variable.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
-- 
2.41.0

