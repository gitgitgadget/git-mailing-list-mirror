Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6AF1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJSW7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39555 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeJSW7V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so31091851ljg.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3/toxNXMg0bRBOAhYyLkrTQY3QNQREzLVmFI9h1ROU=;
        b=vITSUZKnJT4j3sjkUR824z6PAczlr5QEcTYqWe1xjmdoLHCnHEYuVwsmgS8h0+jT0d
         +qNWtLpt3oybMgG8taEQI/8GIRJgLpyjsznuhsXn+SK03Hqk+iBs4rOUoAapAJbPvT9K
         bSUGBUcgAy4P+wpWFQP38a8H0QlLgsUAUtO6aFnJWFAgS+55pBeQ0eGrCmiX0Z4x2F4k
         YHBOy9MVeHJ2GfopYMCp/Vn74sYKgX0RufGTQgre4SgAhtsNNKIECmZH2xwBkd38GP4h
         03kreh5FZU9XMQOEo3Ky6ljlvi14olwIcikzrn2jw3QUBhu0Op9Hggq5j37qzIWjSwTm
         2wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3/toxNXMg0bRBOAhYyLkrTQY3QNQREzLVmFI9h1ROU=;
        b=i+B5RX1923AZK/vlZu5S/NBucimK/HqdipqW3hUgssfojQITa07XRxmLWOhDF4kM8P
         naRxxY3Bfs/07LgLAEnAXeTiIzZhbK16lrsdGyv+iXBV9i/FjAPq/E4DT5UA4mz0Gao2
         0FgD9hEMNQGzDpuNw7Q3DcF8Ds3SHXQ/kCvGe1FMyE0mv9IMbfoV03ZywE/4J3Jgy9FW
         JkuY6EOdYbqG27lBOZ136UHDUIo2XnWF20gqUEPJW9LJJRzf8V0KhjI/W4vfauMW/5SR
         oaLkTVNVqNoursT4ez2G4xwGB66d5AAXHyaco9simizO0E4sHrfYqHr6DDs4Ru5Ke2Fe
         x+sw==
X-Gm-Message-State: ABuFfojW97Qwh3MAQcqaXSH9jkgRXSnbCwdow9uLGL8XgFvwermsokjt
        Luop5qF1RZfztglpAzozu76KBXc8
X-Google-Smtp-Source: ACcGV62PLQlTEJAo9kMNLkWt0KkYRpc5Wh56iUfEBr6jZIjQZSQMvvXwkpGTkNSuX8mZLArm2RyOYw==
X-Received: by 2002:a2e:9ec5:: with SMTP id h5-v6mr7460875ljk.40.1539960772057;
        Fri, 19 Oct 2018 07:52:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/19] notes-merge.c: remove implicit dependency the_repository
Date:   Fri, 19 Oct 2018 16:52:26 +0200
Message-Id: <20181019145237.16079-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 notes-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index c3bee1a87d..b6a998bfd4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -558,7 +558,7 @@ int notes_merge(struct notes_merge_options *o,
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
 		local = NULL; /* local_oid == null_oid indicates unborn ref */
-	else if (!(local = lookup_commit_reference(the_repository, &local_oid)))
+	else if (!(local = lookup_commit_reference(o->repo, &local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
@@ -576,7 +576,7 @@ int notes_merge(struct notes_merge_options *o,
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(the_repository, &remote_oid))) {
+	} else if (!(remote = lookup_commit_reference(o->repo, &remote_oid))) {
 		die("Could not parse remote commit %s (%s)",
 		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
-- 
2.19.1.647.g708186aaf9

