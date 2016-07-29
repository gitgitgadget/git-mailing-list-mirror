Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920491F955
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbcG2AoX (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35068 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbcG2AoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:22 -0400
Received: by mail-pa0-f53.google.com with SMTP id iw10so25547965pac.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qQ4lawUgyiMRu+6w36uaLXVBFHMKRIKKq7Xdhkr+Ms=;
        b=KejQxuZJ8iQFnbngpwK+OGnmW2Fl91ekFUwAwDSA3KBn9W08dAunPkQ6kIawvjupIL
         Izf8/PbER4pWhN6M/wuKZfxFIbVL5kgIkTmiS2uIcADt0cNmVeWy9KwclienwyVutX2x
         TYpwACUxsy4rBq0j61EuCDi0zEUtOmIQYfiYd8sRnQeJWVzzQ8uNShL4fYTthUbJ+F8O
         BbVKv4rYBSUzEel1gWjmGpaz+e688jhamG8lsyY/qk5+QdOD3emq61feCui/PzzgFF07
         l/gbNt8ttC3+66ac6wPvKHTr7Gyvk/TTwZoUAPwe0XGTBDbkh9U7/wnIxKfkFmdSQE3o
         DylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5qQ4lawUgyiMRu+6w36uaLXVBFHMKRIKKq7Xdhkr+Ms=;
        b=VOC76eU+wwbM6m8HYv7b1p0SS7CN3jY2SASJK2gOyVprrs4V3g5EoHzaodQv1dZYIm
         DWcJ7kGvDkF2I46JH0N6UEGayzVTehrqCiubsmR5CCrNfEVeUS6rFFSRqZT2PeGKNWW5
         W3qVVIubyM0RnZFThVXgTd3h0rycIMgO/EfHl9ySnwf6uil8UE+e/4rJoTqkxzvZemVf
         ZVTtzkx+yHkr4zdGALxNnosNDiRNzzuegAhcBYJi6eEcGI5Y4oZ9lmkJFXEnR4MhYIBG
         KZlYSj5DDHgcR9i4DMKdE6fwYd9rF94fogc/Anae3VVgLIwpWTIGVZjSOvVtsheDnEYj
         Rhmg==
X-Gm-Message-State: AEkoouuSBizBPI/ChSVd2zA3TunDFVE6uTei9RFnPq9Weec4trL5mrIIyHSjbk5lwnFrOUb1
X-Received: by 10.66.146.69 with SMTP id ta5mr64951342pab.157.1469753061874;
        Thu, 28 Jul 2016 17:44:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id wp4sm19881580pab.15.2016.07.28.17.44.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:21 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/7] submodule--helper: fix usage string for relative-path
Date:	Thu, 28 Jul 2016 17:44:06 -0700
Message-Id: <20160729004409.2072-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Internally we call the underscore version of relative_path, but externally
we present an API with no underscores.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b22352b..fb90c64 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -892,7 +892,7 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
 {
 	struct strbuf sb = STRBUF_INIT;
 	if (argc != 3)
-		die("submodule--helper relative_path takes exactly 2 arguments, got %d", argc);
+		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
 
 	printf("%s", relative_path(argv[1], argv[2], &sb));
 	strbuf_release(&sb);
-- 
2.9.2.472.g1ffb07c.dirty

