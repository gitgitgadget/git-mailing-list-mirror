Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A962C1A2
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067924; cv=none; b=e8Bw/dMArqXrwly4VTBFlovUCg4zwug48sYRWvK4AQNIjsgfGFhzbwj1vzwED0Ouos3ENmYd5qGTETF/KT/SFKv8CW92kw2tAPqhYIkwEO75rgNTFSIqi/xavNfHlZqg6/4TK4j1STR1faEr+S99oh6fP5w9nCL+pXLitbnY4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067924; c=relaxed/simple;
	bh=rJPzmhMSjx9iBCqP5UsFyGxZtdGbk6iCJqLzSLEXmNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Rlqoa5OEtx9Xs2DH5k9ZzO7GDOx/3DwOU8pNFxaa8BZoABS1hgcYmD8i4LAMdkctQAz56so0Rs3Cv5x2B1oy/Hog4GoxL7flzN9Ul4tWoXP9TLeMAVHNataG/oU0VL54gf12v2iJ1cOvdz+mY9WO6LuGUIXDwyQpWFs4nKbBJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOhjW+GC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOhjW+GC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso697477466b.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067921; x=1726672721; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUJA/uWC5wEAEvWXWnCz0uXg6YtmJNnjezikMuZ0SGo=;
        b=SOhjW+GC5tBjTd2+vMJIxbfonX5e8xIhPGGtA8x5Rlmfnuxj8tJIHdGyyyq5XrnzrG
         iMnWNfFvsJ6w0kiDEAXk2WWAQvGSb4mtTC/x2LYY2HcskYBgE2aihdE8ME8UjeV24BmF
         HKU4FMcdGEFVM3qI/UfAQufjFdbbuLyZQ311390nrqb2H7cY4rsPObvh2SZ5AZ0JuY+u
         TleIsg49O+Vey3vHkJBpjXyMULCUR4jX1WcqbZJpXn+Vv8J+/8QOPCz8wc/8cjbAwE+a
         AsEGrsifsRqsYdRFgU48h8kWqe+U1sjRruFZx5ZxiyU3EZHy5mggMnFS4phsllB3OTfU
         V7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067921; x=1726672721;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUJA/uWC5wEAEvWXWnCz0uXg6YtmJNnjezikMuZ0SGo=;
        b=T5SB9ck/m8A1haoX5EcxHp88nKcBp3qvq3r3F5L+GOyqImKJ0Da69wP1fSUDY46Jcp
         PqQOB2Rq9/YhLjeOiud3Dh6hJTt/xw3cPtsV5W1vasg1CvvqaU2tt4gRCFfHYLSY1Afc
         3vQYWQB89iNz8NYKoKoibWN5EcgCnKE273f4JVPOYGwqNiH1Z3wAxdqMCXeue1bUGrom
         XX9rWQyzu26BR2tuAQwmswH0jXLZJM/n2XLnqzi5U6t4lVW14MWYdo5LPs9qTu50zTdT
         YJEMGO6tCU4CyoKIgK3DZKezvu8cEXWTlGExXQ4+1JL03XGpYeiRpM25Vb8CfdLa4Wh2
         YXLg==
X-Gm-Message-State: AOJu0YyF8KDClecmlWx4Tm4loxLIMqYDClfYwnYK1apd4llPI5ydXljx
	CVw1pnQhY/K/85+gjK/0KNNEWrSg5F9K93tW/a3jHsesWHEDTIJFJSQEug==
X-Google-Smtp-Source: AGHT+IHuWbi2oQ6vnS7Q2ZOSl/7nR2wcY/jSBdZivQJ2uP0UIZLUfkWN4n4xoO3Zu/W8tLLZ3Embkg==
X-Received: by 2002:a17:907:3d8e:b0:a8d:4e13:55f9 with SMTP id a640c23a62f3a-a8ffaae3670mr491474266b.19.1726067920832;
        Wed, 11 Sep 2024 08:18:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d3b47d270sm563479666b.47.2024.09.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:18:39 -0700 (PDT)
Message-Id: <f30c77bc36072df57662cac0cb7bf1bbea378062.1726067917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 15:18:36 +0000
Subject: [PATCH 3/4] remote add: use strvec to store tracking branches
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Store the list of branches to track in a ’struct strvec' instead of a
'struct string_list'. This in preparation for the next commit where it
will be convenient to have them stored in a NULL terminated array. This
means that we now duplicate the strings when storing them but the
overhead is not significant.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/remote.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4dbf7a4c506..318701496ed 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -158,7 +158,7 @@ static int add(int argc, const char **argv, const char *prefix)
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
-	struct string_list track = STRING_LIST_INIT_NODUP;
+	struct strvec track = STRVEC_INIT;
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -171,8 +171,8 @@ static int add(int argc, const char **argv, const char *prefix)
 			    N_("import all tags and associated objects when fetching\n"
 			       "or do not fetch any tag at all (--no-tags)"),
 			    TAGS_SET),
-		OPT_STRING_LIST('t', "track", &track, N_("branch"),
-				N_("branch(es) to track")),
+		OPT_STRVEC('t', "track", &track, N_("branch"),
+			   N_("branch(es) to track")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
 		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
@@ -210,10 +210,9 @@ static int add(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", name);
 		if (track.nr == 0)
-			string_list_append(&track, "*");
+			strvec_push(&track, "*");
 		for (i = 0; i < track.nr; i++) {
-			add_branch(buf.buf, track.items[i].string,
-				   name, mirror, &buf2);
+			add_branch(buf.buf, track.v[i], name, mirror, &buf2);
 		}
 	}
 
@@ -246,7 +245,7 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
-	string_list_clear(&track, 0);
+	strvec_clear(&track);
 
 	return 0;
 }
-- 
gitgitgadget

