Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1C199E80
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506968; cv=none; b=Vft+QRO20QHn/QFcUfx75khHfjyaHOGOda6/m8DkkLdMgJky99t2vnLM5b1Fhh7tX+l453dGJqawsq/zxzVzsT8rrXpMK9Y+21CiMGCVc6fyQAYOVYfCZyjKdd3F6Z/dlsodS+XKfyRkp9DKICnA+t4iMBSakHX3OUG16lhwMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506968; c=relaxed/simple;
	bh=Dkayb9ZP5cIqLevP7ASo1806VxgNJgzYjFEwFinrpM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hwSs0YbOlPdq5tFVl9OOOHf9JNm1AhzDYvPIWOxWd9pE8f2X1sjZXrKq7w4JDDhZkMuCweaMsjORdHyqmXWii+K6XQu+gz65Kq1U0NkLQxnw53bbCmcDE5ABJi7Fq5Wvbn34UAQzZ60bL9PHyZDrZz7LyazIoOIHnXVOZIprQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H01RTWva; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H01RTWva"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e368833so14423337b3.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506966; x=1715111766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uh5H7S1W0wXkp3VWpeqZdyqR8uJl36OVVEcPSNaUr8=;
        b=H01RTWvahWyMQMY8SDhNK6JOg4xYnmE+L7IChZjooCCjjsTc/x5hwEHWMZk7eoTMGO
         a9RezYf8bMJxuLFTUF+r8ReT7Thd3KEC0MhEXBYHXbWdNa9QgQt4Fg2gIT9W2nlWDwUb
         E3sPDXu2+wV/Stv5HIxu3dDxjHDsQdpEUPUUP+O+/TDXCod+Ip8thk7fi89CSOP+amFG
         jODOmi4ppmDswa4C9j5A9YpSfqHwZsMi0uNtlP4Ll2djWeXbMUYnSZKSrg56YrGwmlvd
         RLNtCtHKgQC00RJg7SeQqITJpmpnJrF5Gj8ONgRuu8U1phBKJt8ZzQqlTciU8xrg+oo8
         +hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506966; x=1715111766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uh5H7S1W0wXkp3VWpeqZdyqR8uJl36OVVEcPSNaUr8=;
        b=HIGhWTPK5pPBg0eTDlkPFFVk9venSP7FxOQzUDRywB77gh2xppHEZUju9ed4dtf70Y
         JC9pSm6HX+FsTzlCo5ZC3lpiCRg/LQ3YYgGecDccuhZWs7i2+VrsBAePJ3EmBPJR6Fmu
         FpGHuNth84eofPRYvvo7Zs0s9eSojPgPhSOzeHJ4lnYQ5DSHhEYPwYvr2osmNuzXi4Sy
         u+zS9bzupiNCBrn0DzMGeO9GkwvMixQ/jqpPZswFoO01ANZz/QjG6zXD21Vf9EGPvaFB
         JdW6f2d3Y4Sq1V3QhNL+B1Ohm2Vl4zb9XmQRgC2e3vNAy04erW9L2k5yRIOU1E624BX1
         wXdw==
X-Gm-Message-State: AOJu0YxKttgqUmtqxIC6UtKVRgn6t8d3pgwCl0sRBk+dv52uc0fjqWg+
	/xZZUY2tmKKpABZM2vktow9cLJtNpHE/cT7o0b67Jaj0Z5PF/OlPQITvLy1iUMbwAC1HRo3eeXg
	R66GZEmTK3Qp25XYUzRatru8H0dCtmAcEooe0ZzGjbAx6h/NCsS69ydkU2+Wx6B4iuqjDuZP/8P
	jZxT5DZOB6QY6z3fmI9+atkcqcHE1pBpkI051l7KY=
X-Google-Smtp-Source: AGHT+IGjihMafKgh7LdqnE2QEgNv0iGemcYHoXR7sHO/QT7MDzKxZB6Rho+g+r7gHlc6/D/Jo3izXOCzXhUb7w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a0d:d614:0:b0:61c:89a4:dd5f with SMTP id
 y20-20020a0dd614000000b0061c89a4dd5fmr147573ywd.0.1714506965647; Tue, 30 Apr
 2024 12:56:05 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:53 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <4a16a3ec241d83b3de424ce835db24eee6e46f0f.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 3/7] test-tool run-command testsuite: remove hardcoded filter
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
2.45.0.rc0.197.gbae5840b3b-goog

