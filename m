Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C714DFF5
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731246; cv=none; b=ZkX0ZthSd9VUmQAYGCWICnWTDWsjWjMRLnVWzSi130w2PopwgLnCdwR021H2HcX+P8Hk4yByhKL7NlsHAvxypHSD9Ebri5qYugzKBEbJ8UU2P0L138OQk0AiyOKsi7e9QlmjvitxQkpGC1WKIVe2+sSkpaRLEVU+5b8BEzCCiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731246; c=relaxed/simple;
	bh=Bdv7ic5XRrwtS4nmoj4Gq5WpG+vEQxsUv37S/uXy1gQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFBEpe03PcEM05gb2yZoi0d+eUg84ko74QQqWZklZCmWN7bfOLotA4ze7V5XaV3wJx9eMHqH1/4IiJyzk5hwNn3ZgR02NXX06ODoHka1JCZNKNx4k7FG016I393HlaQufrDB6U0CJMIS+jhUOGWFMTHrgPo0j5DHfET6K8TdeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHN0ovEn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHN0ovEn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so2186778276.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731244; x=1709336044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iF5pWFdcom/O/sPsVNJm3DzfcOMbthIOUDSkLmNhSaQ=;
        b=sHN0ovEnqYodVM42QPUnsWfxPUL8uEJcicQMzqMORzZiIAuKjUcE1l+3j3QINH//zq
         5PjohQ73V3EQwFiv7FGzyZL3TLTN+FqdiybAN4ajVn2q6UqmrbVmGXLMl5+fSvYMjs97
         UZoHqBx2olWKkebNdm3lqzgedUise/dR/LoXIit7talOUci46/dYng2sq8FTAAlxeOi2
         JUug3OyHYXwsMjquamcHl5WXZ9H+wQq2hnJ16OXKyEYwvKBOCnVXyuK73u6kMM7tortf
         GdiUGCJK7T10ocCE/OFL8HIjI1qzIreUYiZ/EmIIWBQkBIQuJ5pRSWlRs0MT9xGC8KGp
         5pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731244; x=1709336044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iF5pWFdcom/O/sPsVNJm3DzfcOMbthIOUDSkLmNhSaQ=;
        b=PPuwFYky9GGXo9mIxdvJJhYFKuvqW+h8ORlcOM2mqG7K8T7yp1KjA8E6HRqxWwiKSz
         W4U7x/GL54COkzAYAhz0dyeSFRq0IMqPPoo2SD25ijULTeoCthI9LnD3FFPP1uFZs9Ep
         20BHLetz39OQpvwt1danIpnHjjZYz+dHmNBv2bI2lINngtpPI/ug8dJtCBqy5CI9bIOA
         e7ZidvlKa8sm0AfU4qultJ2Vv4N+Z+INJAeaH/OX4FSlic895EH+5ETOgVsknYTHGaro
         Gx53q9TPQGTsfGOQ8S4e90mvzOZ0DZZDgNPczmwyyH/Y9FDSEisOqrZhOj7BXFVLp9qd
         soAQ==
X-Gm-Message-State: AOJu0YyQ1Bg7BCKy51FwZ2wgPGU2za363CSzVtMRqLh0LvoLJV6pOwYF
	FvCu1SVW8ND1Mc54GIFjKmqGyXkhDwBRbOX6cOiiJmSu62u28oZp49rZocyMYs2EfyqAXIG5h4J
	wloSu25d4FFCV1GPbgSN1kNIQz+8KOL67TjHekKMsrTrhniedzFarBpGr4mXdMkFw/U0y+B0A9h
	LB7SSapLbGrViV0JIfm6souIws40dQom8r8+QI+oo=
X-Google-Smtp-Source: AGHT+IF2+aTphCPNUyfVhEGnrmgh9SAjK0nVsRakX8Wr1TgAJXjs4w7UkEVAHSN4qx6abpzpJywXsC9MeJ+wjg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a25:8a11:0:b0:dc6:b813:5813 with SMTP id
 g17-20020a258a11000000b00dc6b8135813mr39443ybl.9.1708731243802; Fri, 23 Feb
 2024 15:34:03 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:52 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <4a16a3ec241d83b3de424ce835db24eee6e46f0f.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 3/7] test-tool run-command testsuite: remove hardcoded filter
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
2.44.0.rc0.258.g7320e95886-goog

