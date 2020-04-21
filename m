Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32828C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFFB2076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClLJhJnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDUNL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgDUNL1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:11:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77230C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so1332215pjw.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpbTyU3zepC+cB3HS5q+NtuYKOns6RRNNtTfLVybn3k=;
        b=ClLJhJnteEsZhKtcQYdGd3CvAMs1pdaAkdc0fDRu5UHX3HvGPyJFLoDYhuuNhIDH6j
         srOiR45ZWYMUVI7XUCyXE9ev+uhv3BVtMlJTP7y6UAJC0EoNOhG2dFLnDiFFADEVeAvR
         mVKdJKlhWO7U8TZBKZLQNACb8hLZ7Tclsx0fuWk0Nh3R/ekDHpKFk+NXGtmmLXr6thDN
         cX/IoyDWXT6v1TFBnpIwkvemZjkv1owiC1TELffFCl/xPLmj9wRLdpN0hBmQM55UUQrf
         9ZD/zxTKgkpwmUXMGdI2p1PGQNrbcNHadd6499dY5MSbozctWpu+XZlQbCFLzMxuJByJ
         dxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpbTyU3zepC+cB3HS5q+NtuYKOns6RRNNtTfLVybn3k=;
        b=VTRwmyjRlz6HHGtqadphO7rFzg+dQo75rBSFuXz4CQwHL4CbB7oRfMD6Z4SQXuRbOO
         z44wZo0AYZxsJOLOsMTIJSEur5fqetellRvL5K+tL25KP+QqJ2ef3eK/4HBdkMt4VnYG
         WClRs3HHy1UJ70cOkqJvlD/VHPbrYVYbpsXe0XULIRjjqSPCdBX5Lku2WTumJ9m8E1wA
         EvdXlYXtR8EmhGsGbEJmYZ5L2vHs2BtXwWomiCRzZKDmNeYfOuhnw0dS0wu6KdGYy10b
         fiYMOsm6VfYjvcrlfwMYpJbjou0xt3oF2dhtk0nZWVzX2cZlclpnPQedGP5Le3vXPp8y
         3gqA==
X-Gm-Message-State: AGi0PuYZYnfVFbypNwHfpYdOu5YukYmfXFRGKbtgjdQJBFwINV92RVuP
        0JgblZa+EGO1U80KTrIMi3p9VR/5ATY=
X-Google-Smtp-Source: APiQypJFP4POX51Zk00e5NKMkks2rJ0HjhrELzT62wxx0OBnVOekhGhT2qMGkxeNpw/RIf24is8GNA==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr5798444pje.83.1587474686521;
        Tue, 21 Apr 2020 06:11:26 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id i8sm2529422pfq.126.2020.04.21.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:11:25 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 1/4] gitfaq: files in .gitignore are tracked
Date:   Tue, 21 Apr 2020 18:41:09 +0530
Message-Id: <20200421131111.29201-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
References: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
Git tracking files/paths mentioned in '.gitignore'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..96767e7c75 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,27 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they are still tracked::
+	Git ignores files matching the patterns stated in the '.gitignore'.
+	Consequently, `git add` does not add the files/paths matching the
+	pattern in `.gitignore`, meaning they remain untracked; `git status`
+	does not list the aforementioned files/paths as untracked.
+
+	One thing to note is that the `.gitignore` mechanism applies only
+	to the files that are not already tracked. A file/path that is
+	already tracked will stay to be tracked even if you add a pattern
+	that happens to match it to `.gitignore` file.
+
+	This is probably the reason why Git shows some files/paths in the
+	staging area. These entities were being tracked before and later
+	were added in the `.gitignore`, due to which they show up in the
+	staging area.
+
+	To completely ignore and untrack files/paths falling in the above
+	category, it is advised to use `git rm --cached <file>` as well as
+	add these files/paths in the `.gitignore`.
+
 Hooks
 -----
 
-- 
2.20.1

