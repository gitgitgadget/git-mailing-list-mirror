Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3525020248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfCTLrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34402 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so1644798pgq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sh6kI7svlAYMZ/6jUd3R1fDDCJIXeZ0ov/IzRrpHk6U=;
        b=MXyu65FZcdDxxGxnsuQZINvp68GHXJAVqXegbU2lwMrK3A7o/QqejQBQA+gxn12T2v
         DpXvgE2H9tokryHYEf79wE1BdmMa/VL4ZkrYPgRUDBmmDBH7SCjbb7RvXw++xO6YlaJD
         1jb7T2yAXCSIQeTMdAod4o5vyhJpxk0T31REnZZI80tRna+5z5V8fpqvNDLVTsJjZ1DC
         B6GBcjAnikaU9+wktlBTyCn8Yx671X71KQzzPgDJwATpE3FHArfv0iB6/qqd+k7bqnsP
         RAALoo+OEZPvGQnsLkc0jbIRuhBu0r7ktqKLoeT8Dmf8OqRhvu5p09ORYTw9PhbdDMV6
         c3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sh6kI7svlAYMZ/6jUd3R1fDDCJIXeZ0ov/IzRrpHk6U=;
        b=sKpeknR3TJkA8W4I/O5Tl4qdIGiGP18W8hFqsUU7gB+akMrlsB8EO3dT9W33jPLHDV
         qQ3dti38kyjwl1O7Rn6PTrIdC9W3v6Uyx2AhcDq+UIcR4DdvxsROPZDvUyeWkxBhqLEL
         7gzmrVbLHjyD9S3b2ZdvIFN1OmFdvpLgGwI0UKusIYHrmkH4EgkkWZlbVVrpJE3Lf1yR
         kDPaI1UWlja+9BrtiI/QhI3GsOwNlKTIEH/ajEoabKtnwT8XC7iTruDXvtKTfA5wuXKq
         t8CzuSQbgXf40p0DgJFDM0tfw1zItIZR/yONhA1ex3PJd5TPISL+Rdp8oeJglbBclbML
         EShQ==
X-Gm-Message-State: APjAAAVeOQjHpJ45NEqj3MUG20mCSoOuajc6zHXXRJ2pIO/o1Zyehe2j
        E+9qBkqMJWVcf8WN7XoebQQxn4cd
X-Google-Smtp-Source: APXvYqwQD2+rbBUezJpp8J3Na2XpYcgWN1GB6rGHF92aSBHIODBfQ8GCUZ1X94vnHBaxwO1Cq8fGVQ==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr23947002ple.107.1553082443211;
        Wed, 20 Mar 2019 04:47:23 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p86sm3636227pfa.104.2019.03.20.04.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/20] diff-parseopt: convert --ita-[in]visible-in-index
Date:   Wed, 20 Mar 2019 18:46:45 +0700
Message-Id: <20190320114703.18659-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 8fdcdcc8ff..3eace63172 100644
--- a/diff.c
+++ b/diff.c
@@ -5352,6 +5352,12 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("specify how differences in submodules are shown"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_submodule),
+		OPT_SET_INT_F(0, "ita-invisible-in-index", &options->ita_invisible_in_index,
+			      N_("hide 'git add -N' entries from the index"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
+			      N_("treat 'git add -N' entries as real in the index"),
+			      0, PARSE_OPT_NONEG),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5401,10 +5407,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--ita-invisible-in-index"))
-		options->ita_invisible_in_index = 1;
-	else if (!strcmp(arg, "--ita-visible-in-index"))
-		options->ita_invisible_in_index = 0;
+	}
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
-- 
2.21.0.548.gd3c7d92dc2

