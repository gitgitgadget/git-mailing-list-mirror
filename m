Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27000257A
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921442; cv=none; b=iGDIIlDTjNrsduifWHp894wTrcbjM03aQnATd76j9qLsLe9WzACf/+5HKeHdqj/3RssSqjkjw+xwsZt18GI4vkq/1DvUOHOpv6eS1dt5MhjTyDwU4Ok4yANMoVq4FlS/WN7hzvZyucLkJPMJGOQjbpUvjugEr3nVicXlzH+Lkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921442; c=relaxed/simple;
	bh=AtMiQtE8aAJVCZGBMVK3ZcGu3LOeGL5Z4Oq0ih+F0G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z5mN1vScp9/IdfiA+wYPGbornroKan8L5JJNszVM4fUCyNVf0VggTUcG7JIjRAn10+SFENxRQu9e+pho8g548Z93v8C5qN1blcaswyBE7gMQlL+gt094+rw3fb736fwoPhxf1/FqTQOrR0CJPS/PNFcqSAnCsrPkRaW3Z3EMWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gp28FXrU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gp28FXrU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso3898040276.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921440; x=1707526240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVROZgRCYYjvX4iQzXA0HgvWzMdib79l9N9wUFJRqjw=;
        b=Gp28FXrUahZX7oRPqgIJQIobr4f/GL2q53rEhTggk0LiflKuwt/WQid82PLnmCRLkJ
         SbaPPWwPo3ukHE7p4yZMOC18IViIXPM8kE54x16Cn+MnqacLIOyEY59oA/QSL5EuOLwh
         oyBUzHx0TXPaV941XhP/W38J2cYDmszxQZk3Y3dKfeECoAfkoJAVhOoijQzL/ltZKV0a
         bbPyoStcixKCbLUQ2UE8Omu1tyeSIb4SY6veJPe7hhEayRFzt3czx9n7TJGaxU3NY9KI
         zh+AbnS7mYDqBt+qyPT3f2/qurkgBCGy2gKRnUVb/TSZdedPXndShdtsoGGCuiTX3pe5
         bwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921440; x=1707526240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVROZgRCYYjvX4iQzXA0HgvWzMdib79l9N9wUFJRqjw=;
        b=sQjDH7edVzf+yyi6sreDwBLP5bn96h5ohmGViom2BF2uGNSRw0DtWQkY5N0UBvXAMt
         GoyQ9kaP1uT3r9LGnN6EJ93cKcGd+h80XYYvSAvYIQEVJGuRzuhrNkWmPhnLwTN1ddXX
         xzCSuyIOPJcto9aRlssp/iao7fZzZQPDrNT5mSYPg3Q2f192X17xbAtu0I1M0GmOzA2O
         4E36jSLaDOgmGXEyoIgqSh9YP8Ka6bJpb6UOGzP7yI9+iGBsy4iyyraZ2hSgmApx9w1P
         0k04TsHB0Mjc8NrbmA5P+eobnZoUQ9HwHkWzlniOeurSqFstLOfFtJyhp/9kYhpah6we
         +5mg==
X-Gm-Message-State: AOJu0Yw/LGicNoaTjal8MsRPcBB6X7YzzzH2tqwE1LZWPdp5+ZWvdHm4
	4Gz1JAo2wLRJqBd5yw+or9Fn+uL+FvfsoWRjJCK8196GKq85PQFik0HGkl//4/p0Oy+5iWThrgu
	uScUNknX1+r7IERZn7JB0KBU2Go5ckMICGBZ4GLeH7ubrx76r8krLI44eGqW9AOzUYGQaiI27lr
	5P12Hj3fh+wzJwk9w0ZAncWsnUd4Z6FMOJ28buPxI=
X-Google-Smtp-Source: AGHT+IGByA6gRo//9wLnu3lRV7t91EiOzK7cC8w0wWZhazosw/zAQ99LUOu0UrNfs/RMV7decKKFyFGFi8iGwQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2012:b0:dc6:ece2:634c with SMTP
 id dh18-20020a056902201200b00dc6ece2634cmr138335ybb.11.1706921440124; Fri, 02
 Feb 2024 16:50:40 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:28 -0800
In-Reply-To: <cover.1706921262.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1706921262.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <e1b89ae93e930cd902d1527955d588c3d0c15490.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 3/6] test-tool run-command testsuite: remove hardcoded filter
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

`test-tool run-command testsuite` currently assumes that it will only be
running the shell test suite, and therefore filters out anything that
does not match a hardcoded pattern of "t[0-9][0-9][0-9][0-9]-*.sh".

Later in this series, we'll adapt `test-tool run-command testsuite` to
also support unit tests, which do not follow the same naming conventions
as the shell tests, so this hardcoded pattern is inconvenient.

Since `testsuite` also allows specifying patterns on the command-line,
let's just remove this pattern. As noted in [1], there are no longer any
uses of `testsuite` in our codebase, it should be OK to break backwards
compatibility in this case. We also add a new filter to avoid trying to
execute "." and "..", so that users who wish to execute every test in a
directory can do so without specifying a pattern.

[1] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/helper/test-run-command.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index a41a54d9cb..e6bd792274 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -175,9 +175,7 @@ static int testsuite(int argc, const char **argv)
 	while ((d = readdir(dir))) {
 		const char *p = d->d_name;
 
-		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
-		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
-		    !ends_with(p, ".sh"))
+		if (!strcmp(p, ".") || !strcmp(p, ".."))
 			continue;
 
 		/* No pattern: match all */
-- 
2.43.0.594.gd9cf4e227d-goog

