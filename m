Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD6C352B6
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119DA206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDLSI5Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502009AbgDNMdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501997AbgDNMdL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF95C061A0F
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b8so5983096pfp.8
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFVbeO4bXagJhDbblegxUu51pn+AAl+6nu9bWOWjzwo=;
        b=JDLSI5Syvm6xR3dzDguPfwwZe2/IPiTModSDmh+QEOnmKXbldIWeeIKBIuRc4/Rc5c
         TbkVhIxQcJpzRROG7fApfOM1qktZ4ZLbtE438A1NdR93vQaS6iqqgJ/q+623O97/Dk+i
         wJ+xy0uTZR0DXnMyll5eUEO+hc8u0YPsN7ICugmLTkEfueLCWVZLJNVno7hNzmh5RQF7
         6SafGnCmxZXXDv9gBiBnFW7uRteQCeCqPjsHKI4Gwmss5Qi0VeT4B0WDr4BIojXNuZxi
         ZZjlNUrJz3HCyFR7SJMzFqNywaHfySyRozdl2W3+Map8V+ieHKyxD/Kub3lA1RpL4ELa
         lm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFVbeO4bXagJhDbblegxUu51pn+AAl+6nu9bWOWjzwo=;
        b=MTqI6l4Ss9mO5GHDuyy1HgQ+6AA0jWYVU7mHYPDi2kWpEsldypVjH0qQZ1EqoL5PoN
         ziKSXpSeAiGTdrbFXUuEv9yqzhd4r1lD3Cc4VnV0wM/G3/3Vpilnn8zXZNUVnQAKnWk0
         mW+uml5F9qffKHyGNJdDTG31GXLML4vfKZzpZq4KX6dgLxjg3B9GryXXbVhaSjRswpgO
         fs2Mh1TrAIxpJT/7JqwHDJ55zGQNNZ/YFJMeK2x1ABmn3jcQ/PVNJFPHIf6PaIe6MZF5
         MwucAKvGq2WD6B5UXs7gTBDcW9xUb0Gxpfsi+UJge9hEFxdkPxAnGrdZ37Vw/4jBIBFb
         ml9A==
X-Gm-Message-State: AGi0PuaDtRyDiuuhJYgpnpHVyJzsw1tB3WdKzaNtc07LcKmO6OSxGTpQ
        2H9j6Ad4KcQxMEv5iZicPlw=
X-Google-Smtp-Source: APiQypJKgdPKH89J0A6yn4dfU6e6smwe/Ln2JvouQQ+MqIJuRgGwlHN7+V2PRnBQPsGqulVgOe/22w==
X-Received: by 2002:aa7:91d0:: with SMTP id z16mr23985116pfa.231.1586867590274;
        Tue, 14 Apr 2020 05:33:10 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:09 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 7/7] doc: add documentation for the proc-receive hook
Date:   Tue, 14 Apr 2020 08:32:57 -0400
Message-Id: <20200414123257.27449-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add documentation for the new "proc-receive" hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/githooks.txt | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..a0ea829435 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -333,6 +333,64 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+proc-receive
+~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but uses a pkt-line format protocol to communicate with
+'receive-pack' to read commands, push-options and send results.  In the
+following example for the protocol, the letter 'S' stands for
+'receive-pack' and the letter 'H' stands for this hook.
+
+    # Version and features negotiation.
+    S: PKT-LINE(version=1\0push-options atomic...)
+    S: flush-pkt
+    H: PKT-LINE(version=1\0push-options...)
+    H: flush-pkt
+
+    # Send commands from server to the hook.
+    S: PKT-LINE(<old-oid> <new-oid> <ref>)
+    S: ... ...
+    S: flush-pkt
+    # Send push-options only if the 'push-options' feature is enabled.
+    S: PKT-LINE(push-option)
+    S: ... ...
+    S: flush-pkt
+
+    # Receive result from the hook.
+    # OK, run this command successfully.
+    H: PKT-LINE(ok <ref>)
+    # NO, I reject it.
+    H: PKT-LINE(ng <ref> <reason>)
+    # Fall through, let 'receive-pack' to execute it.
+    H: PKT-LINE(ft <ref>)
+    # OK, but has an alternate reference.  The alternate reference name
+    # is given in the third parameter, and other status can be given in
+    # key-value pairs.
+    H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
+                forced-update)
+    H: ... ...
+    H: flush-pkt
+
+Each command for the 'proc-receive' hook may point to a pseudo-reference
+and always has a zero-old as its old-oid, while the 'proc-receive' hook
+may update an alternate reference and the alternate reference may exist
+already with a non-zero old-oid.  For this case, this hook may return
+different OID and different reference name as extended status of the
+report line.
+
+The report of the commands of this hook should have the same order as
+the input.  The exit status of the 'proc-receive' hook only determines
+the success or failure of the group of commands sent to it, unless
+atomic push is in use.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
-- 
2.24.1.15.g448c31058d.agit.4.5

