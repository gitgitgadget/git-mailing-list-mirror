Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379481C943C
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238166; cv=none; b=GNqzty9sN1dlXXeDwuhE4s2cwOmDwMD9iUbGWSHTU/kcdov9/sm4GO0WOKJwZn5Y8ni1j3EsxD6PpUL0AT2aCXp6A7ajU0MyWpCjuntwb0G4Wafgz3a1UHdlfRfzHI+zKysU9WNal1Mg3UTlMRLfOvEHHcQeQcLUPTDGz8bX0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238166; c=relaxed/simple;
	bh=eTV3mFVpkM6DyzopiZpy/q4hgja6LJ5PR3D2Ah1FxYI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u9ZGwfWUll3cJ7FvKT+SJ2UnBWyOP/WBU5BIngFzpw1HVcyVLnBFt4ZtMK0QsgVIO3B/U1ssETH/M8+qztumBAM/1dsG60t7jRQaswvpYBZYNP05b1sBHF17U0Snzbo+O9fuV4rq9y9c/UgM8e2S9O6/hLLCF8b3Ofjmn7tbeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhrV+cps; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhrV+cps"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso3683492a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238162; x=1724842962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfB9xVofbfd1pN3u2l2Y851KysG9YRVpuJQRoSL0Fds=;
        b=OhrV+cpsnYa8D0jM4G/o9durgNHGDm3oC/l6YuRNZ7r/WOgf3laVik4aiFJiGkpmkX
         7kRrOv3RIv+wZBvgEzo6B3+WwfOqg3RM82n5w0v2HaBNl+VsIpFAozc8XgWAeIakqFuy
         7gBkGMGEG9q3zk9qrcqMxHA75/T9t2+gEfOa93TlGoEgXOwuhEaLPcP6K+C6HTS0F7E2
         lD7vYxi5K/3H2PJ2J5Ub7O2SP7HP7Ie5X2sNN/L17FE+jzIuUc21DWubkKc+DMJ+7+G1
         /sIZzqzQoP3z6zW+jBKbLIKoa77z3weMYDNAOz+GWPMVEWv8Wz62YQL6J3tzF4Om1co6
         4f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238162; x=1724842962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfB9xVofbfd1pN3u2l2Y851KysG9YRVpuJQRoSL0Fds=;
        b=kvpQuH6sdwGSDn9uiPpebDo+FTJ/HXGdJuW7FF4GP8tUYEidXzOjyOMtaSYxXKsNeN
         9S8cE1GtFmYs1HdzUcA2iEz3sJVsU7pNALunpC4v9PBc7rHc27JH231NcDsQ+U6lyqHl
         qPE59PCsMeFgiATVHc39Xp2pPwouRp5K4DvJWVeAJmqdHYr2pjcHNjMU1ymbIkiR6gnM
         5i0bTHZUdItD+1dK6LH5Rjw0JJnKMW8hdGCn1vvDsOE/sY6o+cCFqUvKv/Q+Xrj1ph05
         /jBRqxhbGO4ukg26CsDJoKAla8mbP8rsHT5Njv+dpB0zGMBMinV7QgVY32Hg27hdYTAK
         aV+g==
X-Gm-Message-State: AOJu0YznlXYI5BanBs5Z+gdKAmOtF7cPaSl1zxEFuQn9Bsrb2CSrtHjD
	ZvyHpvgOwxVZ6MPpJPIGEsS2hl4fTcQuhMwOjvLddof0NmXzlpehuaFUnQ==
X-Google-Smtp-Source: AGHT+IHOiAy+wZ3ZQQczD9WrP5Zh14jxcEDD4IlLOZxzhI9oBpyBfJpIHh5zgQar3oSKF6AMdod/ZQ==
X-Received: by 2002:a05:6402:254d:b0:5be:fa53:f81 with SMTP id 4fb4d7f45d1cf-5bf1f28a6damr1534190a12.37.1724238161592;
        Wed, 21 Aug 2024 04:02:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfb7aasm7957528a12.51.2024.08.21.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:41 -0700 (PDT)
Message-Id: <25d769903b2ab4a4c454929bf6378751bd366a37.1724238153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:32 +0000
Subject: [PATCH 7/7] advice: refuse to output if stderr not TTY
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The advice system is intended to help end users around corner cases or other
difficult spots when using the Git tool. As such, they are added without
considering the possibility that they could break scripts or external tools
that execute Git processes and then parse the output.

I will not debate the merit of tools parsing stderr, but instead attempt to
be helpful to tool authors by avoiding these behavior changes across Git
versions.

In b79deeb5544 (advice: add --no-advice global option, 2024-05-03), the
--no-advice option was presented as a way to help tool authors specify that
they do not want any advice messages. As part of this implementation, the
GIT_ADVICE environment variable is given as a way to communicate the desire
for advice (=1) or no advice (=0) and pass that along to all child
processes.

However, both the --no-advice option and the GIT_ADVICE environment variable
require the tool author to change how they interact with Git to gain this
protection.

If Git instead disables the advice system when stderr is not a terminal,
then tool authors benefit immediately.

It is important, though, to let interested users force advice to be enabled,
even when redirecting stderr to a non-terminal file. Be sure to test this by
ensuring GIT_ADVICE=1 forces advice to be written to non-terminals.

The changes leading up to this already set GIT_ADVICE=1 in all other test
scripts that care about the advice being output (or not).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/advice.txt |  9 ++++++---
 advice.c                        |  4 +++-
 t/t0018-advice.sh               | 18 +++++++++++++-----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 0ba89898207..4946a8aff8d 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -1,8 +1,11 @@
 advice.*::
 	These variables control various optional help messages designed to
-	aid new users.  When left unconfigured, Git will give the message
-	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to `false`:
+	aid new users. These are only output to `stderr` when it is a
+	terminal.
++
+When left unconfigured, Git will give the message alongside instructions
+on how to squelch it.  You can tell Git that you do not need the help
+message by setting these to `false`:
 +
 --
 	addEmbeddedRepo::
diff --git a/advice.c b/advice.c
index 6b879d805c0..05cf467b680 100644
--- a/advice.c
+++ b/advice.c
@@ -133,7 +133,9 @@ int advice_enabled(enum advice_type type)
 	static int globally_enabled = -1;
 
 	if (globally_enabled < 0)
-		globally_enabled = git_env_bool(GIT_ADVICE_ENVIRONMENT, 1);
+		globally_enabled = git_env_bool(GIT_ADVICE_ENVIRONMENT, -1);
+	if (globally_enabled < 0)
+		globally_enabled = isatty(2);
 	if (!globally_enabled)
 		return 0;
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index fac52322a7f..c63ef070a76 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -8,7 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'advice should be printed when config variable is unset' '
+test_expect_success TTY 'advice should be printed when config variable is unset' '
 	cat >expect <<-\EOF &&
 	hint: This is a piece of advice
 	hint: Disable this message with "git config advice.nestedTag false"
@@ -17,7 +17,7 @@ test_expect_success 'advice should be printed when config variable is unset' '
 	test_cmp expect actual
 '
 
-test_expect_success 'advice should be printed when config variable is set to true' '
+test_expect_success TTY 'advice should be printed when config variable is set to true' '
 	cat >expect <<-\EOF &&
 	hint: This is a piece of advice
 	EOF
@@ -26,13 +26,13 @@ test_expect_success 'advice should be printed when config variable is set to tru
 	test_cmp expect actual
 '
 
-test_expect_success 'advice should not be printed when config variable is set to false' '
+test_expect_success TTY 'advice should not be printed when config variable is set to false' '
 	test_config advice.nestedTag false &&
 	test-tool advise "This is a piece of advice" 2>actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'advice should not be printed when --no-advice is used' '
+test_expect_success TTY 'advice should not be printed when --no-advice is used' '
 	q_to_tab >expect <<-\EOF &&
 	On branch trunk
 
@@ -54,7 +54,7 @@ test_expect_success 'advice should not be printed when --no-advice is used' '
 	test_cmp expect actual
 '
 
-test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
+test_expect_success TTY 'advice should not be printed when GIT_ADVICE is set to false' '
 	q_to_tab >expect <<-\EOF &&
 	On branch trunk
 
@@ -76,6 +76,8 @@ test_expect_success 'advice should not be printed when GIT_ADVICE is set to fals
 	test_cmp expect actual
 '
 
+# This test also verifies that GIT_ADVICE=1 ignores the requirement
+# that stderr is a terminal.
 test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
 	q_to_tab >expect <<-\EOF &&
 	On branch trunk
@@ -99,4 +101,10 @@ test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
 	test_cmp expect actual
 '
 
+test_expect_success 'advice should not be printed when stderr is not a terminal' '
+	test_config advice.nestedTag true &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget
