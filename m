Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E7D1FEEE
	for <e@80x24.org>; Mon, 21 Nov 2016 23:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbcKUX1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:27:14 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35946 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbcKUX1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:27:13 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so391427pgc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81w/VB6WgQd97vew9lTI9lGEX21TCXyi1wcWx9xS/mc=;
        b=QOr58DhVbEcqV2GhUIAFUYZEoFS0oZbRZRwKHW6xLlYkMfqz5mfcxaGsTe2OvqoX2/
         hmAnPNju4SaNxzwoc91gSNTg6pofFmepsC3rbGI0G0NFz3dC2qThVFFZD8TrsNjDt/Yk
         OZr9U/ZVN+q3RubvffP6a3I/TvOGcOyWs3HvFcQM9g/iMPU/wXBx2/IOGwDiDvLecqBn
         xx4ov0hGlHD9u5PzEJ3zYp7gEZUn0aLYRQWc1v+3yjlwNyghUFoEBazWeLPoEsQ4qLws
         nXght/OrVBEMn3RDNuL3Ls71PD5Cu9PeFq7+6xH0gTm7zKIQWItzQK3J+AG/jx5BYrTF
         tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81w/VB6WgQd97vew9lTI9lGEX21TCXyi1wcWx9xS/mc=;
        b=NP25w3N3t9xw2JNRZwwSKboMk182woUqYhIEWfT+Q9jIpzaUTKRKl+yyjm5iQM0niU
         VrTngUnRExT98XyDsM8G2Qqfw9P0p+PXXb52tS9oZdselbeB3W3ize3v76ocCtXhdCRE
         OJEbE2rPPNAggyyjOykYYa3pD7ASY59tjL+WF7GKJ2EV2UW4IHtiEa6adjdezrW+Z8FX
         6Px0kNdi0ctvCvTq5OQVPPEpz+Nqo3Ik+a1rZWINZiQfyzK8g6hjEg1Mk1gKMtUymhVw
         A3QhFHbxLr4+NH7FxpM0ZZr+uSWtp8+UyCznpZaUE25tVbSkCcpconLEQ6+aF++DmYqV
         UQKQ==
X-Gm-Message-State: AKaTC02Z6jjEctvyz/IjYmBZqocMQRTYYfGb53T5aUzbnXqsy5KEgJZxuVUKWBruz8O/le2K
X-Received: by 10.98.100.66 with SMTP id y63mr21984503pfb.49.1479770832566;
        Mon, 21 Nov 2016 15:27:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id u23sm39885984pfg.86.2016.11.21.15.27.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 15:27:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/3] submodule config: inline config_from_{name, path}
Date:   Mon, 21 Nov 2016 15:27:07 -0800
Message-Id: <20161121232709.8906-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161121232709.8906-1-sbeller@google.com>
References: <20161121232709.8906-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no other user of config_from_{name, path}, such that there is no
reason for the existence of these one liner functions. Just inline these
to increase readability.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085be69..15ffab6af4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -471,18 +471,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static const struct submodule *config_from_path(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *path)
-{
-	return config_from(cache, commit_sha1, path, lookup_path);
-}
-
-static const struct submodule *config_from_name(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *name)
-{
-	return config_from(cache, commit_sha1, name, lookup_name);
-}
-
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
@@ -508,14 +496,14 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from_name(&the_submodule_cache, commit_sha1, name);
+	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from_path(&the_submodule_cache, commit_sha1, path);
+	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
 }
 
 void submodule_free(void)
-- 
2.11.0.rc2.18.g0126045.dirty

