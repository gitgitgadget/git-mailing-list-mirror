Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68352C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 05:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjECF3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECF3a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 01:29:30 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD071FCA
        for <git@vger.kernel.org>; Tue,  2 May 2023 22:29:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a5ef766282so3806733a34.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 22:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683091768; x=1685683768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzvUtNV7ke0nN5u4ScOddAOmA3YKZKKJMHrk648uC3Y=;
        b=ALmmwIp5x/EyKtLrrJ+Y2e3fO7kuoz5jmq5YXBI0WvtQVFY7d2DfEcnMEP0ayrPvJ5
         jnuahmOJdSHtXDn0mxgzCMQ8/9xmmLqDQubv8BGqiD94QVKokZe9ivEUpQQ+Izm3rW8s
         r3N4eNEd6XTIOUdoJX/aVJBDmWN8aMosbHQUoIFYhhSjduSU8Znyxxz+esW74XOPbNlw
         kgFpoXYQjjVgxzJJoV1ASd6tBFH/Y+zhtNO71e9lkjLgX4czGjaslKIzem9iIEEzEyuq
         N4vIOiBdoThiWZmtlohHv5VgnCJqZRuaNU5HfkbpEQdjXcCzZ1ZRMn/J1OUpccOewhaz
         cIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683091768; x=1685683768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzvUtNV7ke0nN5u4ScOddAOmA3YKZKKJMHrk648uC3Y=;
        b=kbThmDetEUgI666hrxEsf69Zypmjh1C9thRxIBJY6hzJsAF0t904ZkqeqnU4cAWkIi
         tuPQzf5jE36td0rldAljNDnT8jIe6t83IlXG100a6EfhwIbHeIu90qgrBrzFIMgIDqcV
         FE6p/1LpXV3tYj+Inh0cw4DIbRFEGn8MNJfi9kTb7my+w+RDEPvkz4nTc0I6NXRV+R3V
         446cQdISSTYwWD6LmUKqqd8PTGp/7gVoqNMPi8wRGUdXkyMe21sjzrG/fK13ZmpXTKVw
         JD/5BQh1+Yj5apQ6x/XMxT6E5RoRLz1DU23bGo1/PZrUjEtjx5A0r0oCSfEiX313wODa
         Bx0A==
X-Gm-Message-State: AC+VfDxvaq91CBbHoUYPRl4dghuoYZUwq8sPrmcju8avOYICyBTZfEIp
        VC2s2eSZam52rRk1besSlqjWfmpbFss=
X-Google-Smtp-Source: ACHHUZ6MXHuD2LQv76qZq6H2BpAXnA6aP9ganh9Fdpk7sohkzqhlqrjzRV4Y/VkQ1a5D4pplHi4ndw==
X-Received: by 2002:a05:6830:1453:b0:6a5:f1d7:7398 with SMTP id w19-20020a056830145300b006a5f1d77398mr10642652otp.9.1683091768031;
        Tue, 02 May 2023 22:29:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d21-20020a056830139500b0069d602841e7sm256983otq.72.2023.05.02.22.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 22:29:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: manpage: remove maximum title length
Date:   Tue,  2 May 2023 23:29:26 -0600
Message-Id: <20230503052926.217219-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DocBook Stylesheets limit the size of the manpage titles for some
reason.

Even some of the longest git commands have no trouble fitting in 80
character terminals, so it's not clear why we would want to limit titles
to 20 characters, especially when modern terminals are much bigger.

For example:

--- a/git-credential-cache--daemon.1
+++ b/git-credential-cache--daemon.1
@@ -1,4 +1,4 @@
-GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
+GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)

 NAME
        git-credential-cache--daemon - Temporarily store user credentials in
@@ -24,4 +24,4 @@ DESCRIPTION
 GIT
        Part of the git(1) suite

-Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
+Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/manpage-normal.xsl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index a9c7ec69f4..e7aa5df2fc 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -8,6 +8,9 @@
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
+<!-- unset maximum length of title -->
+<xsl:param name="man.th.title.max.length"/>
+
 <!-- convert asciidoc callouts to man page format -->
 <xsl:template match="co">
 	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-- 
2.40.0+fc1

