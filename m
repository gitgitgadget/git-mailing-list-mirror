Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5363932D8
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114728; cv=none; b=b5IG9iH2qY5s+4yhISZi0/rr36e1xpFm4QTN9fMlgbk9r8iH6omsxeEA8+YIi66IvsXzHAVf7yUSa01h2+AQ0MkY2iWrCS5U3S0U0f8ufBTnVsHhVbNsqZLztosngn4XtSwuIRQC7Ob7JQNOwkww5FoI6OHkMx93Wed5tMB+SV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114728; c=relaxed/simple;
	bh=3Hlgd8uMV0Agal/5OW0q2ue7DwCCXv2/KHZe35CJSx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s+CKxtthz/xa0HHbVn/Bta0QYSos9RIExbst8WBe3C0YIxHk32+Ai91mzYLz81OcbEJUmtnHbUAsEpiZb7tOF1lCHvtZby5poDPnkZKxQ7aOsOZvGRq/6aIU+ETqR99EeY85tTl93cdJkLNAvI3XK7N0P3BhqTctObGt9JK81vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvrzcB0g; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvrzcB0g"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a093c784b0so101038216d6.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114726; x=1777719526; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=kvrzcB0gRJDXkR+8YAF1JR57RJ9TwaCsZ+Y6+T5cT7yrs7baUNh74tY8uKQCeZ3V5q
         D59bj3zrmsWcwQYL2a4FfEHVmKMISBx2+lHcRCR36phJggw8VpKuIp1WryMbWxvAfwOD
         gwX/SfwHrIkWDg9OUIgPnI0N+5ts2u9ntK+8uu5HSr/8VfoTltq5JdLv64euUwj+82CK
         dFgnCUK8b+m4q6A/QhYLItUWjsWGaJ8dQT3TYETPxKUQyBY5WbZYa6DLABpyLI8anEnK
         78L2nzoc7POsPDfKsBOymGLs4yZnBE9iOeMacVtgUcAkk3z2SifjWD8/9aPJQy+TY6XS
         xsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114726; x=1777719526;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=n3H7FG7Gc9JGV5EDBLO15uVAa+L8h4SYwxUGz380MvBUmM70oSXZeY047J6v+2XkIv
         CRCVZtz+ss+j+9OAlLD707f/1Sj5tkJwI7xtItQEAF+dE2SVpDN9bR8TkbYyQNx1uFL7
         snByI/7c9VtJl3eEpVy9EsebkPiWkJ7vDyUJMwyvOujhe7LSYLSnwX3X2YR7vJJUvhWc
         GbGrjpFI3Dd2p/44oRauR3lR0T9kkjPVK/TPv9wYVym3tEZS8vwZT4Q3QwcjtqTd/Ugm
         51inBMW+es5GAaf6gqWLVgd2fJFyaAdfmZTQctZdV7bimSIuOKpVRtYqgR340LIkBciH
         eG6A==
X-Gm-Message-State: AOJu0YwIY3C0Xxw4YtGfneOuR5ZBEQZo8eeZwZ/lenOJfEK+8IOfhxyi
	rxfWQ4ZVFtAtYwndzi4nk8xWggwQ7fkQ82IT5uVjycKKyOU2phiuCOdlhEmRQQ==
X-Gm-Gg: AeBDieszBeG3UTNdrfP7ddUQXDy3NqU7zq8vbsfSXTL/yCEDw94fzW4oxQERBJ0jo5S
	e+7uR9SzTK4kXBeV27dDBX9Tu1j3PHRnYsH8xyNSxiIB124DRSxxtMH+j4QV28T0tn8gmTrenKi
	iUSsvzqX4Z6xIGfVO2+1FDIeTWDL5epuoOSuuumPHdhHCoM9A2CWtEsi8zWe47MMPaPoOMnw3Hk
	KpX6DDzh9WzWahWeI94ai68RAQTK3tCpm1KHgjkjy/XP4cgjex93hSiQS0tf/S8TM5TcVKEHB+k
	1NwyN2HoP3cMQg/bRhJ6YesB5MTa4el1OMlK7Lw9FGQof6AKvHjvAF9BUEs7iiL2/jcV9KCC9yk
	2+ISbBTqpv41Sg4gDMX+4ZYWl7dUseohWDOvY+8kmji0qZUqSmh6KyVuJ0XsAM9RxCPLQstvPzX
	Db9ld7j62Uq7uT/AwWugXEXBCnikAPOf5QCyfDiQ==
X-Received: by 2002:a05:6214:40b:b0:8ac:ba63:a1b1 with SMTP id 6a1803df08f44-8b028176865mr588383986d6.49.1777114726283;
        Sat, 25 Apr 2026 03:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm207513016d6.4.2026.04.25.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:45 -0700 (PDT)
Message-Id: <bfbe0db67f5a0454378bd5fd71e2cbc1493bcb59.1777114720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
	<pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:38 +0000
Subject: [PATCH v2 3/5] ci: bump actions/github-script from v8 to v9
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The only use we have of `actions/github-script` is the "skip if the
commit or tree was already tested" step in `main.yml`, which checks
whether an identical tree-SHA was already built successfully. It
currently pins v8; v9 is the latest release.

What v9 changes:

- The `ACTIONS_ORCHESTRATION_ID` environment variable is now
  appended to the HTTP user-agent string. This is transparent to
  our script.
- A new injected `getOctokit` factory lets scripts create
  additional authenticated clients in the same step without
  importing `@actions/github`. We do not use it.
- Two breaking changes affect scripts that either call
  `require('@actions/github')` (fails at runtime, because
  `@actions/github` v9 is now ESM-only) or that shadow the
  implicit `getOctokit` parameter via `const`/`let` (syntax
  error). Our script does neither -- it only uses the pre-supplied
  `github` REST client and `core` helpers -- so the upgrade is
  safe.

Risk analysis: the step is advisory. It sets `enabled=' but skip'`
as an optimization to avoid re-running CI on a tree that was already
tested successfully. Even if the v9 upgrade broke the script, the
surrounding `try { ... } catch (e) { core.warning(e); }` block would
degrade it to a warning and CI would still run normally. In practice
the script continues to work identically on v9.

See also:

- Release notes: https://github.com/actions/github-script/releases
- Compare: https://github.com/actions/github-script/compare/v8...v9

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index da31b10c79..6d7f26e71e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,7 +63,7 @@ jobs:
           echo "skip_concurrent=$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v8
+        uses: actions/github-script@v9
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
-- 
gitgitgadget

