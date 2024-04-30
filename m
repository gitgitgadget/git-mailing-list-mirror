Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01556194C8D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506975; cv=none; b=cc/eEBuaARkAWZhAuAqnEEKR3KfTmZzQL33UebN7tSZiPdHQ0Qkt1sn8IUMJscXl+uyduHvGadPojmzTxvdFFdR9iZFm5YFeEc9wDxw78Y4aNwxfhsp6n079iS7HO8cNqQHNeIVh40OqQ4J019vdQWiEHKxzyI+ELOMn3MgjCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506975; c=relaxed/simple;
	bh=4Wy+IXy/+spIZ5IiE0Dk97UBTU48bZKYO1RHsU1r11A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFYrhm93+f+FDpwgb9zWatuSHpDMYRS267GOkSDbP6OmOemVobI5Atg53Sk3/BsawaoTWcSWiiDE6sajAv6wpMvp+GobUVCkPANInu+cFzp4k/2dPORC6y8+3PPpxwFpsN/UbOMvq75yUBw9T1ehO5l6PtkxFaUT2b/kjaETWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hj6INLVN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hj6INLVN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61dfa4090c1so6645797b3.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506973; x=1715111773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dy9kW74Osm5SsZZodkyT0+b5Ssxdgg0C36+JUhh7mJY=;
        b=hj6INLVNjMGumMDyJsMzU9wlLS3GRpQcHZxcYXBNKSxDxBUGGD8OPzKQ8261xdnqQ+
         nnBz5IY7G27Hywyl41Co9iW0MQyj/yOUHaHEPT0jB5agx3TEdrp4QJsfJImSScxB1Z1n
         12atwk28YDEBRTT3F5lQ/Qj91VFBzVOq8xlIvBrRuyXOsJV64KpJb1W20In8MKeg5FY8
         Aj03+WMwyxA1bwicUML7c9tRX1XmVtRm40OvvcuBuuxqZx0oRMXyVJnVD5WSYyEL2LIp
         zrZrChQQ1cVVhQEYZIXlB0dP/nK/WMxFPsYRvxBIjHtGK6us+HTJUVlwcoAg4n9fy3wR
         KvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506973; x=1715111773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy9kW74Osm5SsZZodkyT0+b5Ssxdgg0C36+JUhh7mJY=;
        b=BnuJW0hsVwpq8ael+yqaJaYlTm6nDKtXFexBoZ8g1/Rk0eY0JvD/CBJQrr+FLoILhK
         n8GlVbl8MnnRjxw+DVUjL6bOcjiZ53Zz6JQlnDeuhJp9v1L7xrJaJxLS6qDy6wJYJNXn
         kvILFKf4wuZegbAtVSRv+ScW8IRkwfkowp6E7sp9+PFvYuZ0eTmqN0IbhQtUDuJO/AWv
         a+A1BE0p69U/Zz2pAAn+l4zMsF4yHDb3s2lpckmD0hSnrglDuYyOhrYBcXgHczOYZ/t5
         8nqAUX5KrfPH+x2i1lbfiVrzo+p1PgOS9upgRwgP8mkjGC6G8sYZJbw3r1hHFpzPw0iv
         DtyA==
X-Gm-Message-State: AOJu0YzBHdypkXyggAI2TEADTm+CK8DhMc5j1y9wYoulgE3ByTEsZj8Q
	vHoblsDLvLSBOmjiveb1oXtH56pJWIUZ6+unGQtcyMAHGk565E6Gpt9mm7EOLk0rEr0xMUWUlhX
	ZhO5XraxZHVgEKP/WsZqAynWicV4JioOQ/ifo3cAmv0oHs6rbrCwoN473tWTozPxbn6C7jANkNN
	jiUvaK1oDVHDQBfXK6old9PpSiUFu1vuNDG8O5AIM=
X-Google-Smtp-Source: AGHT+IEfFCSbNfEcZ3KXWHXeBbzo2fePZeWBATV/rAGBS46MfKp0skUsdorNCTl/QILLLuGQF8iECvykX4AnZA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a0d:ccd7:0:b0:61b:ec24:a014 with SMTP id
 o206-20020a0dccd7000000b0061bec24a014mr125674ywd.0.1714506973060; Tue, 30 Apr
 2024 12:56:13 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:57 -0700
In-Reply-To: <cover.1714506612.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1714506612.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <4a92131ab94b06958db2d2172344d427f0494b83.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 7/7] ci: use test-tool as unit test runner on Windows
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Although the previous commit changed t/Makefile to run unit tests
alongside shell tests, the Windows CI still needs a separate unit-tests
step due to how the test sharding works.

We want to avoid using `prove` as a test running on Windows due to
performance issues [1], so use the new test-tool runner instead.

[1] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ci/run-test-slice.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index ae8094382f..e167e646f7 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -17,7 +17,7 @@ handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice
 if [ "$1" == "0" ] ; then
-	group "Run unit tests" make --quiet -C t unit-tests-prove
+	group "Run unit tests" make --quiet -C t unit-tests-test-tool
 fi
 
 check_unignored_build_artifacts
-- 
2.45.0.rc0.197.gbae5840b3b-goog

