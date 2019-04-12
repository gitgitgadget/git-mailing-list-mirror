Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37AB20248
	for <e@80x24.org>; Fri, 12 Apr 2019 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDLXEo (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 19:04:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45898 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfDLXEm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 19:04:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id o26so9719708edv.12
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U1ehrQbrrO4btWyEjYC6AvboSluzq0Fx8j3ErJpjCAE=;
        b=ddl60htpHXNLWzz0F+14HFRsBw4FQBf0RBJlF/bLiGWBAn0sypGHMUu+jhLl2FVfKH
         TIPaLXVOMpajYJ+nks9AGicHcx7jsWqzWCSPHrwWq3X98X2kpbHY2XoHRBoiXGheoizm
         vzs8jJwlYzb8+wZkxIT7GziuFO9pkdbJN7F+juEVoNvfrroJBf2H9haYDtTqc4TKTjjq
         Ve1IS8KLXcKwbYn178Y9HmnAviafRgtWWYWbZWPAuN4SHFf0WsX13hG9WPNPopkTB5db
         4wtg71kTs786iKjticdyKgFiSoItbGiH5N7bn7wQBbdEMEAJBqHFvl+KwB5r3iUaIT/U
         Y0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U1ehrQbrrO4btWyEjYC6AvboSluzq0Fx8j3ErJpjCAE=;
        b=beccLoCS5I/42VZEUPRvIXMUGbbBHjC2XCOSDWPdT7uwPYYGICvqGhxWm/9/2fHOsD
         YdMFW/ZAyXXhXNeF08uEnTNEmbO67uZaNjZ6vC1isUvJR2rb2Nm1GFxV+bC1qsfZTtlB
         8bJtifM4JLQnqxlSV3ThKHWP+UQgCjBYQrGQbXpL7aW/eEepDBOcdZjtj8hGI9hO6frC
         iSB6MA+/KJSfbNoJQXsNJgBvJ/fdWVzKD4rJIDKUKjhS80Fx2G/Xe5YRHMLnxxxC0XnJ
         2sg25p856T4iFdDTPpfUYN3TzwntJnQzhNmEmM7VVtZvBITvuRRHwFGT2mFkeipB3tfB
         2x6A==
X-Gm-Message-State: APjAAAUh0lWorMForHPCPpvl6FeiA9BoghtUj4qtZr7kibvkE8XZvg7/
        aS6MJwg4Di+jizDhNBpaflReTfkA
X-Google-Smtp-Source: APXvYqxHF3ERFjdc95b0V7bS8xDu62GM3LUk0oiCP3mLGOBvSHIsA1RRIHmNBoG6WSZleyI/X6cb+g==
X-Received: by 2002:a17:906:43c2:: with SMTP id j2mr14831413ejn.136.1555110280996;
        Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23sm6831869ejr.74.2019.04.12.16.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 23:04:38 GMT
Message-Id: <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.145.git.gitgitgadget@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] archive: avoid spawning `gzip`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

As we already link to the zlib library, we can perform the compression
without even requiring gzip on the host machine.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-tar.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index ba37dad27c..5979ed14b7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -466,18 +466,34 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	filter.use_shell = 1;
 	filter.in = -1;
 
-	if (start_command(&filter) < 0)
-		die_errno(_("unable to start '%s' filter"), argv[0]);
-	close(1);
-	if (dup2(filter.in, 1) < 0)
-		die_errno(_("unable to redirect descriptor"));
-	close(filter.in);
+	if (!strcmp("gzip -cn", ar->data)) {
+		char outmode[4] = "wb\0";
+
+		if (args->compression_level >= 0 && args->compression_level <= 9)
+			outmode[2] = '0' + args->compression_level;
+
+		gzip = gzdopen(fileno(stdout), outmode);
+		if (!gzip)
+			die(_("Could not gzdopen stdout"));
+	} else {
+		if (start_command(&filter) < 0)
+			die_errno(_("unable to start '%s' filter"), argv[0]);
+		close(1);
+		if (dup2(filter.in, 1) < 0)
+			die_errno(_("unable to redirect descriptor"));
+		close(filter.in);
+	}
 
 	r = write_tar_archive(ar, args);
 
-	close(1);
-	if (finish_command(&filter) != 0)
-		die(_("'%s' filter reported error"), argv[0]);
+	if (gzip) {
+		if (gzclose(gzip) != Z_OK)
+			die(_("gzclose failed"));
+	} else {
+		close(1);
+		if (finish_command(&filter) != 0)
+			die(_("'%s' filter reported error"), argv[0]);
+	}
 
 	strbuf_release(&cmd);
 	return r;
-- 
gitgitgadget
