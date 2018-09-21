Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874251F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbeIUVrV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:21 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46841 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbeIUVrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:20 -0400
Received: by mail-lj1-f179.google.com with SMTP id 203-v6so12081030ljj.13
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGDj1wfbwAhTG+ZJ/1pixX+RIDQWmuJMuwGPKoydYJY=;
        b=UQyCOBmdSSTDQ7QoL0vsHGS3DMEGfMnv7PuuIIqMfN4xBBtfOKv4lFAxDoIJ+tnID9
         OHwvLNuw4mKoq58a8Si/jkqqCQlmUgqtZ2y8lPzONj+9XveGVB5eU3+5xdxylg4Qprrx
         DpklvLN82YXNDPg5nbFeoSC2v+hwr9bz8wdWIiGLK3DVa94xyxjnnCE/lIJyjFASvn8u
         RncJfpwupSuyBeCEY3r5zPZmPknPNcp0u/Y67zqxuw6a3T/h11gB//kA7TeBuoLqBDR6
         w3BzNyVV1DXQ56xbzVy266MwgoYz73MoBn71zPvffOeq5ZtN/n2lUcfytGKMu6YC5diM
         izdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGDj1wfbwAhTG+ZJ/1pixX+RIDQWmuJMuwGPKoydYJY=;
        b=m+2l9Ln3kXtjONDy/4UqciqGO3Pn96ktCt8++QSqYaD/IQclrKaGVocWB8A0T1RQQH
         xyTbonkxYuNUv7MObh4iGwYMr0RhWJa02e1LkPnl2rebAeyaGbKY0MK5S/EIYYBCtQEN
         tmBbYuOj6xHmaqlCdUEU3AgmBEbH1RKnuRiJhFO5IPBP0V/WdoGAjcHoJppuZkHZuuMO
         6J3nKDh2i0h4+Dwyk9I7rhCt3zfWNkFA9dgSbdmBfMNixm5GCPEByZWTsxkqYlYjgaLJ
         abZyFSPybIOGBNFhCfpi72O8wPxjq/5RqGc5q31hokOpVETloXELknKlZPN4RTc7UVVB
         fa3Q==
X-Gm-Message-State: ABuFfogYszpCmigPFd5D1DMYdRBSkA18juELThb6AvNrDCWq65Yu97Ws
        +0lIf2dc+auCa0s4oxeW64M=
X-Google-Smtp-Source: ACcGV60I3H81jZc6qFlWyDWD3TGFHqhD84e0eLmKX6C2aZp+2CQ+j4ilbgpTrQFprcj/vR+W+idXFQ==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr2318569ljf.67.1537545469406;
        Fri, 21 Sep 2018 08:57:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 01/23] archive.c: remove implicit dependency the_repository
Date:   Fri, 21 Sep 2018 17:57:17 +0200
Message-Id: <20180921155739.14407-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "repo" field in archive_args has been added since b612ee202a
(archive.c: avoid access to the_index - 2018-08-13). Use it instead of
hard coding the_repository.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.19.0.640.gcd3aa10a8a

