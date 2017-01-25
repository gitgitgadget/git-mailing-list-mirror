Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62561F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdAYWDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:31 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33895 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdAYWD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:29 -0500
Received: by mail-pf0-f179.google.com with SMTP id e4so60771997pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qGtR/5vMF/V4YRpdSug25WCP3m/oOSzphzWzhQogb8k=;
        b=Chc8KVz86LP5FfnQA1FnlLOxcA0YIVxeUogE0iHrPDQ7CB7tWfRO/GJeGpA+H6NaMb
         F91OJqaUUs9nl1J3bYKHt9/TN6hhrFhjBDsYWbdp4zjMat3Cb4qAFK4qlClcHq1Hrnws
         0OVydeQs76bQRmdnWWr68zBNZt9Kx/wNeZ1B5BkxPnFn6eg9G8l5/l0QPZNXmp2Pe6rg
         qeRkV3FnwVSkBDLCqBj1/PzOcFcl6RXTGHHCzyoSx+mOmBs/xPSIPP8HaAewZ4b7Ye7S
         uEtei7JX9NBD3Il5GzPkxL/2hFvb3YM4SyWnzcLonk2JGmRQnCbsGb2e72krpLfpyJ9x
         1/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qGtR/5vMF/V4YRpdSug25WCP3m/oOSzphzWzhQogb8k=;
        b=tTG5SaN3jAB51N8iDvmWhvVDmSL2hFDkp92lODjp8wD4NI19OZ9N/DKJOlAO8QHG2w
         hlYU1ZA8tpFD938f+/P7oQwOU/MtcM3NA1Koi0WeOLdll+T8/Wbf6dbfOmL4mXh8DYIm
         k/apIZMiZy4a7TYbepG1B/ERZTsvxQCM8cVfvfQkaA8qoWICKcleM5VTaJREN4SjCcOl
         mfRLutdj3vTSLThdvLL4wCA1empekhCePVbYNHHs1tW8qScYG1WHVEmya+KkV6Pu8pFK
         QwLGIi6/wcQZ7wAOuzzNHiJs2dSgLJAMJbEZplTJE3IQzHtPpkg78FlmZa1BKWNnsU8E
         FMVA==
X-Gm-Message-State: AIkVDXJsunMAbZJBM34nu6kPMOh98sMNu1xPEy4Xm56CD+Ekbu8Mf4+bxum141NmuZ/wb8R6
X-Received: by 10.84.141.164 with SMTP id 33mr6825889plv.86.1485381808922;
        Wed, 25 Jan 2017 14:03:28 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:28 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 12/14] fetch-pack: do not printf after closing stdout
Date:   Wed, 25 Jan 2017 14:03:05 -0800
Message-Id: <db1db5d0e5563464c09d1678234c9c5e8ae5b2f4.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fetch-pack, during a stateless RPC, printf is invoked after stdout is
closed. Update the code to not do this, preserving the existing
behavior.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index ae073ab24..24af3b7c5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -191,10 +191,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		printf("connectivity-ok\n");
 		fflush(stdout);
 	}
-	close(fd[0]);
-	close(fd[1]);
-	if (finish_connect(conn))
-		return 1;
+	if (finish_connect(conn)) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	ret = !ref;
 
@@ -218,11 +218,17 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		ret = 1;
 	}
 
+	if (args.stateless_rpc)
+		goto cleanup;
+
 	while (ref) {
 		printf("%s %s\n",
 		       oid_to_hex(&ref->old_oid), ref->name);
 		ref = ref->next;
 	}
 
+cleanup:
+	close(fd[0]);
+	close(fd[1]);
 	return ret;
 }
-- 
2.11.0.483.g087da7b7c-goog

