Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDA51F428
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeHZNp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:26 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:35541 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeHZNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:25 -0400
Received: by mail-lj1-f173.google.com with SMTP id p10-v6so10011483ljg.2
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7v5ntUysnPCRK+a3Yjh3Vit34/EWbEQvAK9tTQ6rJo=;
        b=DduqIoqzslbsTIaOY8A9+rFM39cWHK7uUCjwWHkSVKrk8Uofp6ll/w9noDohy+CiGx
         rQ4Me+GXiiJiESKrGWOJg/WPNBUd/aCX+yy3ROleT4JXywsdHYiMgP7F1D1v9QOTD3O1
         qoBvAJrZ/JjWfmUUWf4MDhd2iQlTxoI3qK/5Ke9tRLDER63ps6SvxXtI30Gwvj5IyfHd
         UPNgQ1jGg/Y7akjJF+PSkOxTsbFFJB4oEUDRsLSCWtU/5c6BQhgZTmWnt1/NrcJkk9Rr
         gdVI4HolYTotDId+p49CieR/K0fyvgp775g4st8lIGUfQ9vo3H8Ac8H5vpVx9Ut79UsK
         x2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7v5ntUysnPCRK+a3Yjh3Vit34/EWbEQvAK9tTQ6rJo=;
        b=S1AftFihPu5hkkTi+41wt6dCz23Axvlp02BF0ykNFXyp5CFcQIKsBiyvxxHF3OxWm/
         vo/jz+YfqhzzqXwbStQ2Unf0ncbU5ljJZS+Uhc0fp1uJsUB4HSMNKe/tXDNmYLKqFbwt
         zzH+S6/kjTb6Jy2ZCHC+88bSexH2epIfQqKD6ryM6R177vtk/OWAXuZPMr6giuwTzh8h
         JiaQdXATc1a/0hxfnXw08/IblcYgmKmz/9ZroFdUaQ0qtzaoQp6tgVGFkAQ5UJv3BWZb
         ar32YL7KEU0ddZqlkh21O4WZbCik6HcONtEAE2yIidm6CU/HBcswzCGJQ/A+l6d2OLSO
         EguQ==
X-Gm-Message-State: APzg51CMZHl86gQIcBmAWMRkx7IZYIhPRjESF8NAxrVP3WPN1XL2oCZi
        PLruA353is7q6YSjmqGq5Unv+rSH
X-Google-Smtp-Source: ANB0VdYZlvv2+UAqkYaZq1YtsD10j1qhGTkXC5xnVYENACwXBUVYziUDhmGZQEmGrhLkI3GhuA295A==
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr5479317ljj.13.1535277798651;
        Sun, 26 Aug 2018 03:03:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/21] archive.c: remove implicit dependency the_repository
Date:   Sun, 26 Aug 2018 12:02:54 +0200
Message-Id: <20180826100314.5137-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 0a07b140fe..994495af05 100644
--- a/archive.c
+++ b/archive.c
@@ -391,7 +391,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
-- 
2.19.0.rc0.337.ge906d732e7

