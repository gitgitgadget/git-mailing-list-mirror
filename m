Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE69FC4741F
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1F2087E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWnAhbix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgJ2Vcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgJ2Vcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62640C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so4085156ybm.22
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=Y6MHdBdPxqowdqb96wr1JWEY0Xk0KmoTvIXiei+qIyg=;
        b=IWnAhbixeb9JjVMYUhLeOOjM7EciW3LjC3dBG8ozpLGTBTRJHglfRf441jjbigkT17
         FdGuTC/9DtqSvmGl4aKWcIosO/WMZLR4J7oC8YU0owi3S9dQ5ybnFsSybU8iCOrJplIY
         2GSWlBSKXkCBgBeyqi4VIUFpiR1Xmb+SnBa7+jA3ScoKCAUT09p3BntuFB3PTxZlTymH
         UcuWdJiqGWllD7HZdaLXKIVpxE7XRuwC4KNzYTnTAqab05bFKgJgCX8JZ9fD5pSEtu/y
         tMX3/MOOYjIaY/Xu7dQtyGtXr84VgE4EzzBL+CYRWpzvbbnC+o1T+YgFUE6pFOhswDQq
         21Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=Y6MHdBdPxqowdqb96wr1JWEY0Xk0KmoTvIXiei+qIyg=;
        b=nt5H2JbjsJS84u0jKBuz0KeUZpBowPnop5NvLmYmFbiJWIkhpgKqomAVTSfak0oe5s
         X/2yGYrXdIDbkHpyvSH0VlF70TH8KIymQ04fTkDAbQGHNazeW3NA0cCdFgFcs+XUeLgD
         uYRbwhuphEELs8CId0bPwUgFkxyePZsGuFtov1bfxhdbAxfJ2NA5jV8W1jHNkRdrbb8u
         kFhAT3ERtR0hgCHyPhN0+QZ1p29oI3EUBiXK/+njSNZIl42cy0ZXnnPkO99YBVbETbUw
         gAt3gDWWdqYeY74OV1Ihx2xk+vY0V2CfRQTRJe1nsmPQVUSyOITXOR5ndOvo4kAwsVrL
         uwPA==
X-Gm-Message-State: AOAM5330VZXeL9Qa9bA8YC3xwHI2BxivWZqGYGRvtF8DDx/QaC79tjLi
        gOZqyLNLMsrWwoFylYCs4jtEkLLKKi28IalkwaecVQyamkKLo5wM/zMMMthIiyssG5lsK9BnJDC
        OaWp/lY8Ms5G1HUIVjV/MI0t3ePeObv62LJHXoRdGgaI8hUAWXwu2jtVwq5hcJcE=
X-Google-Smtp-Source: ABdhPJyb/+1i/Qvl4wukXofh/oTI5RNrOAMuMDW5INKzWMydbt7Wum2SYX+Q9qcCWOeveOUEJRnGKjhPmtuCmQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:bbc4:: with SMTP id
 c4mr8991472ybk.178.1604007165584; Thu, 29 Oct 2020 14:32:45 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:32 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <5d5097b67109554e0763724633810ea616b5e2b2.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 02/10] docs: new trace2.advertiseSID option
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document a new config option that allows users to determine whether or
not to advertise their trace2 session IDs to remote Git clients and
servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/trace2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 01d3afd8a8..3f2e3b4425 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -69,3 +69,7 @@ trace2.maxFiles::
 	write additional traces if we would exceed this many files. Instead,
 	write a sentinel file that will block further tracing to this
 	directory. Defaults to 0, which disables this check.
+
+trace2.advertiseSID::
+	Boolean. When true, client and server processes will advertise their
+	trace2 session IDs to their remote counterpart. Defaults to false.
-- 
2.29.1.341.ge80a0c044ae-goog

