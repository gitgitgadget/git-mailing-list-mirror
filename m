Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357E15B10A
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025466; cv=none; b=mcAjCLvOcJZoWpXm7/lGHVECsvbyXVZTkuPTGqrkh4IcfSWz6t5TJoXGMNk4+vBs3GRjtlaoWuqoTI7VmgnRXUJ3sjv9I1NJWGkZTwQ9pmJF/lQCRfiB+Rd1+7W7x/VBzrxI+tCFX/hd23G++jJaWT31BxRtdwgVWWiVNKAUgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025466; c=relaxed/simple;
	bh=X/iVPdS8BI9Q3kNKSfBuXD+4g6EyVJeXX91CTqEoRpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gXOyrZPaPhoWSsthgMJkyEW15lf/kQgotRKThVL5LKzIyCTlyGhMM6Vd9BMSZllsaOFM6c8GX2M1KDvunF7spdy4oWy5R8YY21CvpU+usQsOwdt9rFLVTo1OjoGL/os+yJanJtaTD5tdT2m7gS4INH55eRFmeAAX3FjZ5tSoV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6MZOa0Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6MZOa0Y"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f7ed6eso29679707b3.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025464; x=1715630264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0MsO1dJdkmzETo3Vb/aHe95tnWVsUlLJnBhvpvKhaE=;
        b=J6MZOa0YuaUz/wa860SviwDUatwcfGiqVCix/IUg8NZN6eWguwSN4S6NYifgioMbOb
         /g+ipbSzKInkJhh5bLFD9Agkw2d/ZcGuleFVtdPde6FLDJEuL1ndlMI6JoN1L3dbqKmx
         1SvVIarKcvwfC9bySgdxV3ic/Ie1e47EN2xu3Xuafp7Hj451LWAREMMdUd09c+6ZUjyE
         540gPZag/VRXcUG5lDCbY59sNvDLmXRwpISvqyMCNyt4YCJku4LOOu8Ax6eBLDleDyIi
         /fZN0W+AwFIJERgV3plEZ4/xTx+2Uqwcs4gs9Y99UrHQKk+aefb9HRkrBbmG9/QXM+CY
         kGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025464; x=1715630264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0MsO1dJdkmzETo3Vb/aHe95tnWVsUlLJnBhvpvKhaE=;
        b=dHH70mL6XEP8vIr1DIWgicQESNDTBcRIoxsu/z2AfE1y6A21m6UHWANpROeNDmu2V/
         XQ6Lvnn2L6fRvshKrCk+vj2Qf/DCOMyjrIStkzfcuPMFeBI/pfHMiGq84jcal8441hRT
         ddSORA+1Jj4Z/rs4aNizJHwyx6bSvT3RDXfAGbj+5xaRYypCsyyDxh2m2jegBHDyjJfW
         oSW+8LXT27xMjUSPg9e6N0QSDok82nVWyX9lBWUbEY8OnG6biSuhRdDLal45RyjrD0Gk
         6f+C6gzeC+qjAZLv30M6kQdSMsLW3aGlGhzv0ZdMsudScKTrbsCrc08XguP4K9UGO+8T
         X2Jw==
X-Gm-Message-State: AOJu0YwAgeUmb6iNxbfFfAOjWM6/CvLzG58TWoMO2GcQJdsO91HpHp9v
	92y9C0Awb1CvXa0ZYN+QzW0HaFnznRuLu9o5wz3MkmeJePZJ6GG3iNQCUW4KEnrl+y6F7svzq+p
	GWIKevWAawzOzaZeIyMduFQtwCkI/adWZ6ods1r3EWNbPp9aKItOr8m4VMUu13m04MHzCqUibWc
	uQ2cqHPjktYulj0YKheks7xpQDaPKR5s/VNl6a3vQ=
X-Google-Smtp-Source: AGHT+IFwhA1dDNcXZ2+xdWRWIkM4DlElaeEg3ySaHagKtQrfBdcDvT1Tb7sDpoR2qP2RuF2dgJ1/whFWBJkXhg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:ca4a:0:b0:620:32ea:e1d4 with SMTP id
 m71-20020a0dca4a000000b0062032eae1d4mr165541ywd.0.1715025464393; Mon, 06 May
 2024 12:57:44 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:33 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <4a16a3ec241d83b3de424ce835db24eee6e46f0f.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 3/7] test-tool run-command testsuite: remove hardcoded filter
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
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
2.45.0.rc1.225.g2a3ae87e7f-goog

