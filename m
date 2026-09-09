Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A93932E3
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983422; cv=none; b=hDKqpYDrQj1KmAzO0pLcWdyyKZRnzg9Pa027OIXSbjEQyPWefEmgNy/yvKSzivPuCbKjJhEtrioinBNy0ahJQN+WdxhASfQvVpTqP+WPAosAxRJ0d7oW2Ba9n73Q3F1UZ9ZP6eB+Hu/IGjwGs86V86b1OusU17HTzw9D1kCOllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983422; c=relaxed/simple;
	bh=4nUWysvpS+IdfEiOBid4CWRuPTEX6qkHz6O4PPWr7kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/lgC37KX+DKrjrMN1xxXXJ6PGx3MkNM19uGFD77BU6QA7muH3sCQ+eYZFromjlFOGs+KkIC5YQXNs9n729EqjkeqUOZf2i49HubEQSFNJRpRp2ZfJZF1w8CCwszeO5mIh4UHMxDWdBMy+aEAA6nwI+VzvJshgni3YNL/ei5u4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIiC5ImS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIiC5ImS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c253425b253so955746866b.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983419; x=1789588219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hJ14M0X4HcjxQ3BD7Dj0WoTCsszx5hu9JFOCBRv1mHE=;
        b=AIiC5ImSC3VXGgAWmBe78D4p+CRRtx7KyNdc5JPTasdIawI7V/ls2tHZKPQRje9PoK
         lZtJx3dbkCVsO2jgqkbNTiyR+ia8dGDCam22KgTVRUdBO0Vju+axhV6W/FuE6CsjPlTX
         sTmAf8l5KZO14GVxr6B2WFzGxZyhZ5oFPeAwGyC35gmCUZBvOu0K9B+DK5JPWNyi5t1S
         gTLFS1J5TuU9bxlZv12VrvEQHZHFHMricMVswvrnRDG8/RMbNuxQp7GhvC7xdrOy3gy4
         zCoebHuKFxTfRmViWDzaCuGo6TAd3PHviI4GqTzICgXvyABm/1nbMKTvsJAuy2ovDIwS
         1rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983419; x=1789588219;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJ14M0X4HcjxQ3BD7Dj0WoTCsszx5hu9JFOCBRv1mHE=;
        b=cLLRqsNXK5qX/2XyxtjbRt6eykCqszZYuJa5IBaDwcXSd8gXCIMHys+DCJilgMCEr3
         Kucmffihg1YwpimVUm5xGlWXeyXv3IflbAz0suKO7WzxX5i+OeeTMM+XTGLevYVtFq7X
         srA/XlkYXa2JXSNaZujQH1KJVT1OwcEIQ1qGGrwppMIKKTSzFBh1D+givGE6Y4mR2WwN
         WopZs8KzAhVeDF21fmkwUhTucvMlvNijMxDjmItQZdLOrVPx8OvQwIy9pisaQewIm1ra
         TCkrcWgSK+KcuG/qeISizi5og0BAmjtcdASGvdp54Y4/npe8h9CK/O7OGo3FoPSoLNa4
         3L/A==
X-Gm-Message-State: AFuF++ksBKMKHqkSOErsMRJ43VJ6HaOY7TtcOL7RpZbcMlrsNlC0onGQ
	FUzo5iHQm003WfDCnpo3MzO9KcsIV3u0VXG/9KuCDpVU1a0LbNlmGBOjftvsXA==
X-Gm-Gg: AYBFou2EkkuWh+47TdwIYyqo5HGVep075fVpZEmfgn0PPf2QMTL0Bz2LA7bzQRDWEpW
	BCa0GN1jZh2qAtGG9Xxhjdx8TkX8Iz0MRSxGkELHheoKlgGPJFoH26V34dRrLbUTdWpK14HWeoK
	GJ1JYXfGKARNb3O9iCDFd/ElrlZnDd3QGCeyn4MRhVmqaP3poDMEczCWj5T5P8HnX64Q97AoePX
	bEgbISy5XiuqCBrPE5XYXgZjI5x3LyRViZFe7hXCC3UICz5twErAgaiu7Y3tRuM4jQzf489gQsd
	udk4eAfVv7anznjmqrw8m1x4/oG6hv+fMS2nY+bM4F48hRlQYoH8jpbZ01sgOCvCwXrN+CqrWYe
	kE3Ro6pUsXfMi/3Alt97NlsWVSasq3gHb3Q6tgeZN0rSpYwCtckcTXjaX1mSHnMvK0QAdxodFul
	KFD41Ua/MUZ+9aee0TK3ADaBl32NxJ2M9V7/G5yux9z1ERxcFCTfa+dcY1NyEc+E5z5U+rP3NmM
	E0HIfu/HVqijZ+R23GB7AwFJ3Vp6D5YqBfBygc=
X-Received: by 2002:a05:6402:388c:b0:6a9:93c0:113e with SMTP id 4fb4d7f45d1cf-6a993c02723mr2420377a12.9.1788983418978;
        Wed, 09 Sep 2026 12:50:18 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3f00sm7264786a12.12.2026.09.09.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:50:17 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] cmake: remove any "$(*_OBJS)" variables when parsing Makefile for sources
Date: Wed,  9 Sep 2026 21:50:04 +0200
Message-ID: <20260909195006.2179119-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1193.g1b994e35de
In-Reply-To: <20260909195006.2179119-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To get various lists of files, CMake parses our Makefile looking for
lines matching e.g. "list_var += ...".  In case of LIB_OBJS this
picks up the line "LIB_OBJS += $(COMPAT_OBJS)" as well, so the parsing
macro has a specific instruction to remove "$(COMPAT_OBJS)" from the
resulting list.

Currently this is the only such Makefile variable to be removed from
the list, but the next patches will (re)introduce more variables
containing lists of object files, so let's generalize that removing
instruction to remove any "$(*_OBJS)" Makefile variable as well.

Note that we can't make the pattern matching the Makefile variable too
general, e.g. to match any "$(VARIABLE)", because some lines of our
Makefile do contain variables as directory prefixes, e.g.
"UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o", and we must
definitely keep those.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I rarely do CMake, so it's quite possible that this is not the most
straightforward or idiomatic approach.

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8f56203f34..241da0d43a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -102,7 +102,7 @@ project(git
 macro(parse_makefile_for_sources list_var makefile regex)
 	file(STRINGS ${makefile} ${list_var} REGEX "^${regex} \\+=(.*)")
 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
-	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
+	string(REGEX REPLACE "\\$\\([^)]*_OBJS\\)" "" ${list_var} ${${list_var}}) # remove any "$(*_OBJS)" variables
 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
 	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
 	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
-- 
2.55.0.1193.g1b994e35de

