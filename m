Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C74C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbiCXFAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbiCXFAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C828E35
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1935569wmz.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=fvNZ6wDZOqUoDYoSz8bTia4MCTgo9ySe9mCp3ZLZIzqmPCb+lM2L+7KNQtyzZXG1Ev
         cuL0biuTH6mb8nPt5jlMzbWdQmwgZ1guLbDXCsm1v0oCdc15TQYRk0g9sBLbzAjbETlF
         I1aRS0bNf+PSCzy2JbLai289wWq7LuFZjF+GAv+lWpLdnPOxYIyhCWdNnoyIEVXwdLaM
         5m4owifR/TFyeub95jVqSn3zsLKjYzfIZZ7OntMHxMSZ2cuyy+5c28OlsqAsQZm5U132
         JpxlQc5BObX7GkwEg+Tw8M8lFPpAqOTzcOng4UfOXDBoTSk+7vlJTCoB7kJaePMuL8Ez
         n3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=v4WsKi+edcp79dbnc4OtTbtX05fRT7JKHfdpA0PsVSLDNDa8RmC98kjnDgbC4HfhIu
         E486ddGVgFJh3MDs1maW+yY1i9GAgVGXKQB0kJd0lD8dhqj7BLaIMUUHcCZuiNirZPez
         2Ziy03TUL77zuPakmmJvzyOtDouQnJkLeD2RD7gXeEcANmokIVct8yLg2ntIH/nwIn0J
         4JGp+91lD95s1UMJhR4XszZxPtq9UGLpDw+FJtOrKJD5D0YX0ldWRapOFcnrILhkJtAb
         4W8dsy7JBMFqhES7FBTjxmXRlaqVqsjUSGcyLf7t0QzV1TB+SJSgtR25+4CE14/WT503
         E32Q==
X-Gm-Message-State: AOAM533aYQ+xt+SsiqKEY0CTFqTCIzOz8DUXR8pDWYPk9OofkFBzJRBM
        /s9Rj6yjAsMo4a5HgCMElvIKAIDWtRc=
X-Google-Smtp-Source: ABdhPJzo5SkGO3MZM4JD/SKqSWuQtDWnuRNG+SxOAX99TnYp3cgKzXOxHe4jBJNpoTqOAqySN0gMGA==
X-Received: by 2002:a05:600c:4296:b0:38c:1b43:1562 with SMTP id v22-20020a05600c429600b0038c1b431562mr2993397wmc.122.1648097913331;
        Wed, 23 Mar 2022 21:58:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm4176349wmq.41.2022.03.23.21.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:32 -0700 (PDT)
Message-Id: <26ce5b8fddaa507e09d3201c4c6492e4d1184d53.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:18 +0000
Subject: [PATCH v3 03/11] object-file: pass filename to fsync_or_die
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

If we die while trying to fsync a loose object file, pass the actual
filename we're trying to sync. This is likely to be more helpful for a
user trying to diagnose the cause of the failure than the former
'loose object file' string. It also sidesteps any concerns about
translating the die message differently for loose objects versus
something else that has a real path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index b254bc50d70..5ffbf3d4fd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static void close_loose_object(int fd, const char *filename)
 {
 	if (the_repository->objects->odb->will_destroy)
 		goto out;
 
 	if (fsync_object_files > 0)
-		fsync_or_die(fd, "loose object file");
+		fsync_or_die(fd, filename);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
-				       "loose object file");
+				       filename);
 
 out:
 	if (close(fd) != 0)
@@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
+	close_loose_object(fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;
-- 
gitgitgadget

