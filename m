Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2A43F8DF
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452620; cv=none; b=f5g2rI0bESaZGaEba6lcSIsp3nqwgOy+E5FoaKxPCXuSZJF5z9LQSXwjP0NsDT65VfSB9Gkn1z1IPY7XB/bp78yzb9GKSapMqrnC1fgVz+65jOcKyNO5Uj4BhieSMeQDDWIjAaBDUx7EhQ30adbPvVGwGQaEryEeIh7iRMC34lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452620; c=relaxed/simple;
	bh=FgDsqByZjiB5jZr/tmtJCuVdF8LD3/q2jm18tHlbwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtrlX6Gqq/NqZG3wi5YNRoVUPX774Kfm/707bIHtS6cdIRRbq0PpzJycNm2CVwaqlAn9liqPn7hyxNQZdMFbEGzAN+vYFv/RpKvD7XvHKv38donh22aDrEaR93AeKizbtwwF9xL+AC1mrmsuhK5dOf1mIfSHLiGo+lpH/lzupnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ox9/cFNr; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox9/cFNr"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso489509566b.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 23:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452617; x=1790057417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4267tsd2HAGjTObLhQb0euxvj7vWe7qO8wYbKlTzwI=;
        b=ox9/cFNrVsBRcQ1YRGc6vaDdRBlYLygiAIuK4X+yTIwsLBHoFVSkNKoadC8SRGtyom
         zhEzu9V9VLf0EpRrrXifvUWi2fzEYvs/CAYsFKGcgerquswRb6o2TVgF0RA76ldyzPGZ
         j/+Y6Bceegj+PD9nzF0CcDmF3G7WXlJMvthvpNkYAcl6Sl1VJDrUzgULdVRBhfINS60V
         x+7euehaQoFPCqtNJU/18ESKmGHWJS0XCDJka/nAt/6ZJlme+Palve7OO+ycf1bEOI6z
         vqczTCYvDEZqvUX/QHVMRkrxPginsBXykmPqTYVpqill9nTI1BBJIWaHE/ASYSNurjF/
         SHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452617; x=1790057417;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4267tsd2HAGjTObLhQb0euxvj7vWe7qO8wYbKlTzwI=;
        b=S/zrAz7HOUaFYS/5wQJXMfMfgwiTMjQV/FZQwWx7oO0tEccCaeEzatbvQ5qd8s9UJU
         xo+QJvntv3x/bKKLXSsJVO9f9XJR8CMXpdHbSv4QnNpxrxKYmnGnrSlQz3u+7CYAZUf3
         CyEEOmSULo+KGvDU4mbUiTZ8j/1W+aVkQrAydiJgAJr0BADJq52zpIQhQXiBcsjB2ymp
         uUgZ7lHBpVewVM34yhfTSTEWAFphQTndmIwcYOMDx1j+x6ehCaU0Z/9uCppDbMwhFO8V
         vXZhNVziHJRRyNjkYDDff/ytoBd/3IHdk83AYJSky2tIIaor5gL3ElPEqvRTyInKLog7
         S84w==
X-Gm-Message-State: AFuF++mvLLkZvh0w4InQM/yEgVHo4jMxGOWC8k4J1a1ctF16wTzX+sWy
	qKgBTUpcMa9DfFqa7Gjppf27spX8Ba52zulbTBRLHmmXaO24f8+L/Albp3Or7w==
X-Gm-Gg: AYBFou0jJBMlcZVejCyenYGTMMU9zVarGo9tOWzi2YOs/6RR2wujqTeLLZUiBOAI9AB
	9vxYhy9zXgooobkN3ebApkj+gc6eSjkghqivO1Ts9YPLVZMNqXDI6nknSM7HJ7gmyeOlAYv6EsF
	wNBhqCQ5mWyz8d6WjvJHiBrh/wk+Q+lcluDDDlN3CpKD1uUO0YFC8gWS7Jc09pR7mAsH0GREZEz
	4fWyQWYgl45QxDAUz4laK2xRYm1H2hI0btBaJCToofPAb7pLv1CEK1ZoZBwZzJSlr1jC8hMAULl
	5BmDyzIMNvoFcgYqfzT0H4XuZ66Ld7ASF1Ka+u0VyLMuBuCBShVem0q12pdv+LCOEYz7Y+bM8hy
	HxkWOWBUllGtogqDAFCTvRFpr7QIFS6FKfNxdNDiq+uVdA6/CAmqkmcdeRdqRw4JEUj/9Bewi7w
	Ss0IZWy1NZvXpTdw1t2pXgk2CVd28MXSb99r7lVAaWQg+hKOqtLEXBGckkrPHhKiJzVZqmCVYPr
	OpZ7DVtCO1auYvGOWTRu4ziXfU=
X-Received: by 2002:a17:906:478f:b0:c26:1648:a061 with SMTP id a640c23a62f3a-c29b8723fe4mr352480366b.28.1789452616729;
        Mon, 14 Sep 2026 23:10:16 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4f77asm523777766b.8.2026.09.14.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:10:16 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/4] cmake: remove any "$(*_OBJS)" variables when parsing Makefile for sources
Date: Tue, 15 Sep 2026 08:09:50 +0200
Message-ID: <20260915060952.569535-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.467.ge054dd0dd6
In-Reply-To: <20260915060952.569535-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
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
2.56.0.rc0.467.ge054dd0dd6

