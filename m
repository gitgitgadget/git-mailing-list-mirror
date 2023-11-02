Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345018E3F
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP3CMpUB"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9B12E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408425c7c10so7254785e9.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933135; x=1699537935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJbl0XTCoSZU2vy1uJ1Q/iJYU5/TAJnp9Zb6o7SiQgA=;
        b=EP3CMpUBNRckAuxqfJnqv5F7S9MetUALAKj1ylawb6yT+QIwSskWpeveaY9uVeQPQF
         5hg4p4aZl+b3OuPlyYGFoS9fW27G+hgw3cRRGQmQQJs7J6ZQ/al+/U0wCvXW0Km4GzyR
         irQfiX9bH9/ftV7btPvGUFcWOUUukB8jd67LCKScBrA67ExOzaplke/pX6mLqcbGEtRQ
         ABVW12s0DhxwXzWfnrj9cq5LSwoWI8n6COWyGg7rZPJB5oA2N3x5wVqUMRoGfyLEJZmD
         FErUK5pgw8Zp+o8H3RLZB5hLj22OfUM34JfuN14KUBzZXjd+yy2qZyj9xiHYnjpVDnus
         04FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933135; x=1699537935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJbl0XTCoSZU2vy1uJ1Q/iJYU5/TAJnp9Zb6o7SiQgA=;
        b=AbdRYgh34laj3YCq5JZVqAxvJG88ooE76vP8XxI2ixTMdfasaXZhiOORm7f+J9HcdI
         Q+6ukF68N6n16Rf/E3KqRUug/uNNjXgNsA4/JkbeDiP584whbpsMHVocKTAfpsJtYaSJ
         vqzRbnsgQyedrZhDdWFBlKxJMJENk7UI0GMPanHxHO/sq0i1uPKeYXF1AkgYwHiYCooG
         adRxKmG84Yc4ArNd38KOEQ4uj+PkXLXKFPyIvvdkLrcHPCvGgMme/2bGVIC/D68c8z1l
         p/vTn4qfYP1h4m4iDWMcO4sVH33HqwrPCe1naVuVKxRxL+hx+JR9qFZmZ1+3dCqwxbbW
         DIPw==
X-Gm-Message-State: AOJu0Yw68+FYBB1630HB67BYE7vVEBgHenMhS3at8z02jWzegK480MAK
	p3mbvXBZbMjClwvOI5sSiR+ebm7UMIs=
X-Google-Smtp-Source: AGHT+IGE/0O5ymwQC8C6VREfYEqEt8fawQ+8K9nA4yw0OAGWVcf/ylJGfkE2D4VgF7y2Ow0mFGsBvA==
X-Received: by 2002:adf:ed0f:0:b0:32d:9572:646e with SMTP id a15-20020adfed0f000000b0032d9572646emr12828694wro.54.1698933135157;
        Thu, 02 Nov 2023 06:52:15 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:14 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 04/14] replay: die() instead of failing assert()
Date: Thu,  2 Nov 2023 14:51:41 +0100
Message-ID: <20231102135151.843758-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

It's not a good idea for regular Git commands to use an assert() to
check for things that could happen but are not supported.

Let's die() with an explanation of the issue instead.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index afabb844d3..32dbaaf028 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -179,7 +179,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
-		assert(commit->parents && !commit->parents->next);
+
+		if (!commit->parents)
+			die(_("replaying down to root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
 		base = commit->parents->item;
 
 		next_tree = repo_get_commit_tree(the_repository, commit);
-- 
2.42.0.496.g529a7fda40

