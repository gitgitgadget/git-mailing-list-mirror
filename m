Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A610613D52E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054899; cv=none; b=Cb5EzFXAl1zPQj2sszLCzg/udNQ8PV/odRqvOVychXwOvFxjOhVeW00WroA0aG1qayVR1HovgI8gZFyOow1xQAkx9MUK9IaOvlZuQO448hdvCcXDq+iQ/T2n0eGjfCAH3GH/AS11FFq1aDYGEQVTCoSgU1Ezf+XJin23ddw1mkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054899; c=relaxed/simple;
	bh=L2NGPccQsJrinTXCD2PyyjIfOhtnoBY6BN16lfCK1io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pyhgJBgsUh5LOR1jWB7DcQTjU3f4Vq7FgnXMLYGkMHidMvnlLZIn3+6WAnBvjiIdjVZLPBsEtADGrJNVw82YTHHkNmCrUqAWaIRYFt7fZv30MqSVzeMbg1jepTp7OKAEhT/gveVlvIO4FKD31j9FkMjmKx6TJ1F3dP9JwU1gmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lah8rSb4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lah8rSb4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be2fa8f68so155837276.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054896; x=1723659696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9T0kI73iAVt04U6LFo3WC7rUOTJgxGB+Vr/cOIlEGs=;
        b=Lah8rSb45QENTx1E3M+Y/DBNSKHS2O0sSAMi0fMvdDjsNUoJdGa0UiuhtdELWdMKP7
         kI1R2kk0dz5qjjPHXgGMbXUN0WXa7bzLQlK9P+E05/8uePWostfkVh2g01yIaRIRWpAX
         rRlbU/FhUVsV/0msY73hxp3afimfoOdMUa+sTjs+bI1KUdrA1FAVTdsnsagoVolQh9qf
         nffi3BoujvroriCw9h4BlNmF8MBBIth8jd7rfzgzcJASlM77MlNanlY52eKZaem631ql
         GtGOtgpfHzUS8t0eOpAaGBusZkWjmPz3hvNP4WBYppr4Lk2PheFXxZSkJqL8I6CUoXs/
         6jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054896; x=1723659696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9T0kI73iAVt04U6LFo3WC7rUOTJgxGB+Vr/cOIlEGs=;
        b=MUHCx+J0Rk1lyAMREx7+1XNlbkCRNqGkpfAMxGfrSs4kHSswX6trCghH7+THL1m7kZ
         dLasqtILMhNZfEooFsNKl1NdSxMeQkyiQCMICZUNA4iIOMA51TI7go/quH/NhXrAAuu8
         Z9X8mKYjkP+sRfbsucm8XMnXasM6rqS83JCzuP2An1l2PJqqY1VBlliwbstIP88wWYPc
         1mCQJACig4ejV8YdOdP2QJ9T0ihaRptU2a/7HY9zmQEgkSe4Fkt8WFrPrLNSmKgAV1/P
         oH9xGZxeeRcihG4FjMo0a9W7d7Smu7bRM/9QiQ0rmqUvhYebTZxHFWXilH+mio8wq3CC
         bSjw==
X-Gm-Message-State: AOJu0YxSY/PnOeanbgGR4EuUiyjZCE4WK/FQXGHPLPMy4r3o4PAHi5cg
	fj13OUrGYIqdVLZCDWO/yKlye7YrcZFDGRVZcKbG8iqnNqidQP2CTbTzVauqS/zxao5cl0nH5Nl
	vnJS3wixsneVSJ8adQUmM8kpLjNQKRcAZR5BetR2h8JCQxZK6Oicnp8j17p7hAXey8VSKD0d07b
	G6Neq2owYZrfKqkvoKvMC6nynJJbQObw4vAre3IQQ=
X-Google-Smtp-Source: AGHT+IFyLJiAafgi8YZErSEZ0D/cN/dI8z28Nvngd7frvAdfC37XQpwFLr0OzEe8RHpJ+QoJmoRNgZJPM6RWQA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2b90:b0:e05:eccb:95dc with SMTP
 id 3f1490d57ef6-e0bde283222mr161918276.6.1723054896473; Wed, 07 Aug 2024
 11:21:36 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:26 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <78c2aa2ef9351d977f31dbbb16b148baf254ad59.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 1/6] common-main: split common_exit() into a new file
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

Currently, object files in libgit.a reference common_exit(), which is
contained in common-main.o. However, common-main.o also includes main(),
which references cmd_main() in git.o, which in turn depends on all the
builtin/*.o objects.

We would like to allow external users to link libgit.a without needing
to include so many extra objects. Enable this by splitting common_exit()
and check_bug_if_BUG() into a new file common-exit.c, and add
common-exit.o to LIB_OBJS so that these are included in libgit.a.

This split has previously been proposed ([1], [2]) to support fuzz tests
and unit tests by avoiding conflicting definitions for main(). However,
both of those issues were resolved by other methods of avoiding symbol
conflicts. Now we are trying to make libgit.a more self-contained, so
hopefully we can revisit this approach.

[1] https://lore.kernel.org/git/Yp+wjCPhqieTku3X@google.com/
[2] https://lore.kernel.org/git/20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile      |  1 +
 common-exit.c | 26 ++++++++++++++++++++++++++
 common-main.c | 24 ------------------------
 3 files changed, 27 insertions(+), 24 deletions(-)
 create mode 100644 common-exit.c

diff --git a/Makefile b/Makefile
index 3eab701b10..1cac51a4f7 100644
--- a/Makefile
+++ b/Makefile
@@ -979,6 +979,7 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
+LIB_OBJS += common-exit.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
diff --git a/common-exit.c b/common-exit.c
new file mode 100644
index 0000000000..1aaa538be3
--- /dev/null
+++ b/common-exit.c
@@ -0,0 +1,26 @@
+#include "git-compat-util.h"
+#include "trace2.h"
+
+static void check_bug_if_BUG(void)
+{
+	if (!bug_called_must_BUG)
+		return;
+	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
+}
+
+/* We wrap exit() to call common_exit() in git-compat-util.h */
+int common_exit(const char *file, int line, int code)
+{
+	/*
+	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
+	 * to e.g. turn -1 into 255. On a POSIX system this is
+	 * redundant, see exit(3) and wait(2), but as it doesn't harm
+	 * anything there we don't need to guard this with an "ifdef".
+	 */
+	code &= 0xff;
+
+	check_bug_if_BUG();
+	trace2_cmd_exit_fl(file, line, code);
+
+	return code;
+}
diff --git a/common-main.c b/common-main.c
index 8e68ac9e42..af4dea049e 100644
--- a/common-main.c
+++ b/common-main.c
@@ -66,27 +66,3 @@ int main(int argc, const char **argv)
 	/* Not exit(3), but a wrapper calling our common_exit() */
 	exit(result);
 }
-
-static void check_bug_if_BUG(void)
-{
-	if (!bug_called_must_BUG)
-		return;
-	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
-}
-
-/* We wrap exit() to call common_exit() in git-compat-util.h */
-int common_exit(const char *file, int line, int code)
-{
-	/*
-	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
-	 * to e.g. turn -1 into 255. On a POSIX system this is
-	 * redundant, see exit(3) and wait(2), but as it doesn't harm
-	 * anything there we don't need to guard this with an "ifdef".
-	 */
-	code &= 0xff;
-
-	check_bug_if_BUG();
-	trace2_cmd_exit_fl(file, line, code);
-
-	return code;
-}
-- 
2.46.0.rc2.264.g509ed76dc8-goog

