Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58D221267
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755928832; cv=none; b=Z0H6p6u7gKkvhJMwJ2gjW3+7SfuqbZuuPUX/X8E9RawtEv6Zqkm++fVqBGDedcEQ16AJ2sVuowsB6DiYLfhHdEzVnwywoTV4aVBmQR11E6BqXYnrjv22CQ0i6e/whRpU3aINMiLmRfc6wSzAjqUlPpIvpe0QgK++uHiOZzxwm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755928832; c=relaxed/simple;
	bh=gA3YdjCoZE25sve9pWOqq+OoKiAdX49sQb3EatPlwCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqweEi69oJWN8p5ML0XW2hpK0kn6MzwXND6a0v4lxkvKO6kwFviHtvwEi+fva56jUav05itXyz+aPzBdx7kftSdRsgfV6oT2xO2gmJN77wGvHycBljgw3HohC49fiMDvZvaxtkf+H4zcwk2vTriV1N/eVFgIgYE7XT59lAdxX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lym6s8Ws; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lym6s8Ws"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2553553b3a.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755928829; x=1756533629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvJIqPfmN2n3datLErbuAj8dzCtr24eFn5GeT+k3MgI=;
        b=Lym6s8WsPOrT65LR+LFbJGY9LHgZaMqoaQp1jeyK0arEYwN45DnQ0BAZU0Sq6nFcor
         TvJQn7YYycUqgP7R1HlkeGtk1CqJEY/WLRd0CRVQFqZWiARI0yfJcn8pv0iP9n6mCa1l
         8wkKkoOuHykFTcPdYoSQjkRhubWXbBrnm8P6mDEYJGL8cgvb/uv+vkJqqVD6v7m3O3HK
         GACJ7uCtXcdmHnKPSmgZBSW24XNbzxCkFkkWQJvoNIwJcsnQG2a8tajZ/eKkJCM56rNL
         HgBeeV79NAl9nvxZym4JwObJhkw4ZZpmoUBhwh0Hz5aqVZVyHR3NKR3XO6RabK1TkjUH
         eDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755928829; x=1756533629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvJIqPfmN2n3datLErbuAj8dzCtr24eFn5GeT+k3MgI=;
        b=PNtNLq9//52arq3eXWBxOKRTTl2ubzDQ6IgbhX+ENvPKWaQqHi7zaebOaSo4VFeaYE
         y1xWn74XvtHF1j6TtbKfsX2C89Oish/YyHETQWknG5OEOm3wz1E61oh00f9a1LYEwRDD
         bi2NS1BfEMy1j+uLIsRzY8g00wUHO2DOCBj8vWyN/yf72eqHRTzrv02TUPdiSTuujKx4
         FozuSEgoM5U8ZDE0I2HnSx9XKBxWa82MftIFOkfcla5eRvAeEsVr1XwjLfxs1N54XF5R
         JzUJ82FLb7tSmvL/QjAiOgA1EHd1YBDPSfNF4s+tlTHWWf0U6eu5R6JkPp217znKKjCP
         4HRw==
X-Gm-Message-State: AOJu0Yz0oSuELHO1r2dVDDbLbT1J8BBRTkWWgb2+0fzW1ZztLqU4F6xC
	HD6XG/m++oMZ46XRcM47mpg4UuB5lrBxVR3bJYffXYnYtlmwlYFcSzjP/5Aaig==
X-Gm-Gg: ASbGncsYRwVC7SgbNmkob8VEPxRqhKXh8OYv/utJK8xBut3270Bq0iXDk7JYW+DI0Wn
	uk1FxuFcAukfwfQcPyiUQhZynhliYrmpNm05OPTzqr5sFhrNbhyLqvY0giAM9J0eJbyXGaYUT2d
	2w0Uvfikngf7k8LpyiR6haHq4xKfozJbnqCtduE2gVwKYjv1rynNAw0bR0rgkM5vj0lVd1KoUIC
	fSpv1CZ7LI7F/exIilwTyvITVEv1JybVaALfXdYb1Oao9Gw5Gno+cKgqvC28n7dfyndPx15zazV
	fqNZOpDxlulrxZt7ieb7NeUtD4aRggLWqCo3lO7gjfqADcqmkCEPgrV//R5h1MsikxPPutU0QlI
	Pr7BuhmDXZNBO3oD16Qs=
X-Google-Smtp-Source: AGHT+IHJF25CM5zz6S7AJzD2iwoLre7r67RiJM5EVJp/SQHBOmxnZyE0ekb6tfZv+GR/gYtAu2ZBHg==
X-Received: by 2002:a05:6a20:3c8f:b0:243:78a:829f with SMTP id adf61e73a8af0-24340e4855bmr9046705637.56.1755928829426;
        Fri, 22 Aug 2025 23:00:29 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b6fbsm1434145a12.30.2025.08.22.23.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 23:00:28 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 4/4] t: add test for git refs exists subcommand
Date: Sat, 23 Aug 2025 11:30:12 +0530
Message-Id: <20250823060012.540433-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823060012.540433-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250823060012.540433-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1462-refs-exists.sh`, for the `git refs exists`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_show_ref_exists` variable to "git refs exists" and then sourcing the
shared library (`t/show-ref-exists-tests.sh`).

This approach ensures that `git refs exists` is tested against the
entire comprehensive test suite of `git show-ref --exists`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build          |  1 +
 t/t1462-refs-exists.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100755 t/t1462-refs-exists.sh

diff --git a/t/meson.build b/t/meson.build
index 4d6bc3d38e..93e9773ec8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -211,6 +211,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1462-refs-exists.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1462-refs-exists.sh b/t/t1462-refs-exists.sh
new file mode 100755
index 0000000000..349453c4ca
--- /dev/null
+++ b/t/t1462-refs-exists.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='refs exists'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+git_show_ref_exists='git refs exists'
+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
-- 
2.34.1

