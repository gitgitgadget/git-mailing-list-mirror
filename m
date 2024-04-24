Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876157442D
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986063; cv=none; b=ZqzqUwntSOVRk0JR6n5Lnl2Z6pDYU7MduJBP1uSMXxMBCtZMp2dqDUjTIp5dHP8uxlCB1K1cK1HaWTQBopHGDUtYPTIkJ/66VlushUxM6tFZzEwt28tMJQWf3bz/f/lzun827KDjLqK6rOD6+NHRjJ/1/j6+KPwd+ptnBpmOJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986063; c=relaxed/simple;
	bh=HwlXhseibk7XuU6OSoV6FJp1xhufZ3etSRxMUF+5XyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=szekgYdv5cF/qeIUJibvwt7z3xyXrO+dQkNxMZreK/z2Os+dfLzAmgTE4hqrPVAPGk8oX36ZCUAxkCy61z4WjmClLWa4uIyHlwrQlJAVN3OKxdVoN1VcrntqADOo8uXi4pOObNtHYfMwkV3iLDKsWRFGaJjUBKko6uRp5YCO2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlUnY3fP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlUnY3fP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso405818276.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986061; x=1714590861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXus1Gkcc1750Jiv0uDUx9Fuhc2v2RRkLeZb18hkEbA=;
        b=dlUnY3fPeCN7FuY8stZs5lpu/zkfeoEzTQe5pCnYRU7Xe+uJMcQnyAATJgIuaM1UqU
         8CHb8YKmj8mHZQ+KS8ZOqnb1D3VepaBz5rl0NNcjuKuHHV5lL9hv7FeufnYahjnhTBSI
         0Bi7N2jPXcUjncXy5YbzuAYGHEbihiTdJCCPhS9jdUH9KoQ14k+yzWQONaUSJjmAPLm5
         WlLmsv1wXwyFamZdTJPNb8dflphQOLbos5Es3MCSr5FhjT79J9DSQgIO0vuIJ8ZUeKgW
         m8rSHyBYgQj1YWVzjToZrG5C0Q+nZqp6F+CfpcKHVBdS5tem53zCo5MowCb0mWvn84DL
         01ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986061; x=1714590861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXus1Gkcc1750Jiv0uDUx9Fuhc2v2RRkLeZb18hkEbA=;
        b=dXg+GKbYPm22M1wYEqQsW1r72GpUmfn/jBj2OC6ThTIwtUb1EH4JoIRVMOjOxpPFeu
         MqABz/oWjMK+y9fFnpoSCyLBB9OHynwGZPGDvMUVnswO/+Yhwa+J3YFGvYKFOm6ZxFBp
         3TTRACVQleUSbXI3z7XcGh6zoatmj1XIxv/ax/TKwaibmkkax0K3iNKhkOmH7ulVSekt
         vaelOxukMN0TBvl/9ga1bdr+h2FF1UfUXAkYrz6yf1s5IFLYtger15e9QmQNywqh5KlI
         bJyAkm1TtWqFzECQPF8uTiLr/LUufJLSrKuejYYiJ4J9BMn5uWJVcZUx3VQ3v4jjXDvy
         h9xw==
X-Gm-Message-State: AOJu0Yyb1tPm2oiLggpO9rgJ8GsUkHnN+lhhLweHWgPWO3gpThyQPf3j
	jRYGxwff27KkjWporISUgH1Xzkk3C20HH4P9o7oVepYTJTxWf1bMjqq3uX5R6/ZPy1ItmGB82oW
	kfCJ2MhR1rh11usZO52MLuMv8o9f0Ci5eJYlC0BS0uFvKT0NptymtDdGsldUWNNB2IMbSwNwfUr
	O6q3PjP7LLAhKb1VF8Qg1MemDdm1O06qEmfGozOi4=
X-Google-Smtp-Source: AGHT+IFVhOYRJjyMKOaHdsTMNyhu1wjIkzksTNvRqJtO5zf2EPdrRgxeYLnp7haq6JwNS6egdtXHz+YgbjYd2w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1024:b0:dcc:e1a6:aca9 with SMTP
 id x4-20020a056902102400b00dcce1a6aca9mr1108889ybt.9.1713986061354; Wed, 24
 Apr 2024 12:14:21 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:09 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <4a16a3ec241d83b3de424ce835db24eee6e46f0f.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 3/7] test-tool run-command testsuite: remove hardcoded filter
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
2.44.0.769.g3c40516874-goog

