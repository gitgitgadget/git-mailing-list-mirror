Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D353B5
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="P0DvzK/+"
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE1D6
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:27 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e562706d29so1942531fac.2
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697341406; x=1697946206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QpXSNr/Uo9V+OS81+Envn5yr9RoYGnankRhO8BtBj0=;
        b=P0DvzK/+9vpSM97qGwZypjwDQZSqYnbTaoGULF9/clyhKRtZVpd9YImj1m84qwUjL8
         GJEa7OKZEAv/EcVqgQTsAeDlQYRT9/7+npOec0LX9mWaKmaOlVIFDBgCtUscLaKfYixv
         DcNtn4Okg3hpvIuWCj6nH7GYHOjE49h5S93JKZe1Ax4TKjh4Qq7DSgaamJ8/2JiCzj4h
         yqMPo6JX2HRI0QV9CuZlNtAO+cFaLZUqgwTJzHAKp61MKbTgB0vV6XX4fQPzFuIbM32P
         8bYOcIXFFJaRVaVQQ6085Le/jsjbxOQHtgG8C81a1b4bAZQaQIsEKP4qeVLNNAFbhjYg
         WbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697341406; x=1697946206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QpXSNr/Uo9V+OS81+Envn5yr9RoYGnankRhO8BtBj0=;
        b=JKJ5ghnDqKWIFH22blEiRKuHUTHfs3OxCBLW1oLLGYtwfQIYhdX+eZF0eu1ltHdM19
         tpQemVdbJGuV+CzHdnP6WFH9YEmEPdCRGqVPq0CRObezSu3pE0sWOfRd9oizM5KJHYU5
         lnDNkumYR4C1NivvdhEr8bwj6kJxnHxIifqsBwEQ2z+Y26Wd3blefs2wrl8pE9w9FSSP
         QFh8Qc73Ksi+7fjd9Ma++LjQXDMAARmBYfJWzdafYuppAZblvLZ7Cb4R0KZzhMgblG2+
         YIWQYNyNMVREyA5DESJPhSfvbzfWKOV43RIpOuKfNRSyLqnNEo6vCQm9oR7mgCjK6oER
         ydNQ==
X-Gm-Message-State: AOJu0Yz1mHPxYL0UP+wzajtkNlvodVTpIl2zCNUjBz6L7Y+rOt14n7Oz
	NAX0z6bpcyjWACSf5eczTyRm1NR28QOzFKMeG4E=
X-Google-Smtp-Source: AGHT+IHc7oW74pOjpd7MeblGe8NOjlMY3isyRaWAwLIe9/C7faG1tgv0oLnhXYZHnA7doNtiSnPlrw==
X-Received: by 2002:a05:6871:528d:b0:1e9:96c6:e04c with SMTP id hu13-20020a056871528d00b001e996c6e04cmr12750220oac.32.1697341406403;
        Sat, 14 Oct 2023 20:43:26 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id bq10-20020a056a02044a00b0059ce3d1def5sm510777pgb.45.2023.10.14.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:43:26 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH v2 3/3] bugreport: don't create --diagnose zip w/o report
Date: Sat, 14 Oct 2023 20:42:37 -0700
Message-ID: <20231015034238.100675-4-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.298.gd89efca819.dirty
In-Reply-To: <20231015034238.100675-1-jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <20231015034238.100675-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prevent the diagnostics zip file from being created when the bugreport
itself is not created due to an error.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/bugreport.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 573d270677..91567806c9 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -161,21 +161,6 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		    report_path.buf);
 	}
 
-	/* Prepare diagnostics, if requested */
-	if (diagnose != DIAGNOSE_NONE) {
-		struct strbuf zip_path = STRBUF_INIT;
-		strbuf_add(&zip_path, report_path.buf, output_path_len);
-		strbuf_addstr(&zip_path, "git-diagnostics-");
-		strbuf_addftime(&zip_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
-		if (i > 1) strbuf_addf(&zip_path, "+%d", i-1);
-		strbuf_addstr(&zip_path, ".zip");
-
-		if (create_diagnostics_archive(&zip_path, diagnose))
-			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
-
-		strbuf_release(&zip_path);
-	}
-
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
@@ -202,6 +187,22 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	fprintf(stderr, _("Created new report at '%s'.\n"),
 		user_relative_path);
 
+	/* Prepare diagnostics, if requested */
+	if (diagnose != DIAGNOSE_NONE) {
+		struct strbuf zip_path = STRBUF_INIT;
+		strbuf_add(&zip_path, report_path.buf, output_path_len);
+		strbuf_addstr(&zip_path, "git-diagnostics-");
+		strbuf_addftime(&zip_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
+		if (i > 1) strbuf_addf(&zip_path, "+%d", i-1);
+		strbuf_addstr(&zip_path, ".zip");
+
+		if (create_diagnostics_archive(&zip_path, diagnose))
+			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
+
 	free(prefixed_filename);
 	strbuf_release(&buffer);
 	strbuf_release(&default_option_suffix);
-- 
2.42.0.298.gd89efca819.dirty

