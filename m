Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09B1CCB50
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634944; cv=none; b=Q4AH2oTVg4bYuMr7fwNsVrS2NCsuvZgMIKue93K83OKmyTUX5MAAHgoWkw0toq0ca0XIOmcqNlCU642xZi5/Iz6vAkK7pzCGJOrAo6o4igXz2hOzg2zGYxt/Bh2fn7Cm8hnHhNw11ICxWYD3m1fBvTsOzA2VZYMs2uymPu0a5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634944; c=relaxed/simple;
	bh=deKq+A9LnK+oqwjEPHhGiFvL8WASgJwQOit1fL5TJwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dPnmAoH2XrnYPTqhr/ZaEk4V6g6B82jWR49O6VdiFIMkLRfDxvV0WikyRSyZcJ1vYDuKDNoUd8qcQGwfW6AfzzW2u2xQ+OniJ0XayoPbdSB02rs+6FdJpn+Qtp0QTsdNi5ET2OmduAbIXpqS0nabqnFdFPIOsO+j//nsgjxZdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkXCNZf6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkXCNZf6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f629a7aaso47406266b.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634940; x=1730239740; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3kU7eI+PYLSlOBjI4sp2ao+VRlCLuTcWtBPICI1TrI=;
        b=gkXCNZf6GYD7mxPM14vEAnle2u3wF9eJUnktLDVPK7gkdkLNcykC+Jrcl/o79JBthX
         OWqziCGJHr2hFqvuONaG0jQ1pBRSnawOrD8LY4N0ulDPkj9/ib/yhfJt9DQPnNYYs5/p
         Jp3rJ0QlZC2JL6gcElNt4BjDibQnxyK8xxivPRJbRLgVdHEKJyGJEnAXmxI7jhd0vIDH
         hRif/Bemxjkc1Is4BgZ6mvAppO92fel72pHWILc4bniBpoJiH6JzfXzGzUqsGHYCzuHj
         e1lfQZttESpMTdz6AWe24fV2zb52RuDq1xEU2uhvDPoKF3Df4t3QI+ryqG7efWONLc0z
         bJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634940; x=1730239740;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3kU7eI+PYLSlOBjI4sp2ao+VRlCLuTcWtBPICI1TrI=;
        b=M/XeZBZ/cmirV+e4Pfw0O5r/ymQJMAA2Ll9BaILI8HZcfOI+zdTwYIwUJAUZB0p6Tc
         0/Gl4V8KRdmDhhCVaIK5jXyQPlGF+ymXV4WmRmQwFIidGFWtIUpS/sHQWnxIXBSQwXkt
         Rl8n7HXb+Mleyh1/k/OlQsPY/FBUHF0+Frov1AKdU0Jf8w4cv0FSXsTXdAeyplbf6WDB
         MAxJdoU4kF7SkyZahJqpG1ekMsTmFWAkfFBi/hubGy0CWVNk87EoyjSQlXK58CK1/8KE
         cgYOYXQ55cJdL3r1Mr32X/DofhKYI0Q49PyRGu4fDGDuk9oug8ZvZi5zj/rgz5BQ3y54
         1pYA==
X-Gm-Message-State: AOJu0YzTBBYM9fOgIG9iZC6zrRsgF7OsAIUOMbqzXUWU/Iswu2WupkYE
	8TZIP6SUQsnXGZGm2W6FJDOHgkW30eKFnXmYwt3F3QlDUu709DNd4jivUA==
X-Google-Smtp-Source: AGHT+IHoBtiIdgpe+XFheADSxgd63nN7tbXuquEcJIlL9dYB4VgQYOtMDvS7R472n7+0TawRLfrpTQ==
X-Received: by 2002:a17:907:1c20:b0:a9a:762a:d71 with SMTP id a640c23a62f3a-a9aaa4f4eb5mr434257966b.4.1729634940031;
        Tue, 22 Oct 2024 15:09:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915993basm389724766b.203.2024.10.22.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:08:59 -0700 (PDT)
Message-Id: <d9c997d7a9c8975ce845aa0cb4deaba22cbf3b94.1729634938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
	<pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 22:08:55 +0000
Subject: [PATCH v4 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.
Update tests to ensure these arguments are properly validated.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 daemon.c              | 12 ++++++++----
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..a40e435c637 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
+#include "gettext.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "protocol.h"
@@ -1308,17 +1309,20 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout))
+				die(_("invalid timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout))
+				die(_("invalid init-timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
+			if (strtol_i(v, 10, &max_connections))
+				die(_("invalid max-connections '%s', expecting an integer"), v);
 			if (max_connections < 0)
-				max_connections = 0;	        /* unlimited */
+				max_connections = 0;  /* unlimited */
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index c5f08b67996..722ddb8b7fa 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -8,6 +8,32 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+test_expect_success 'daemon rejects invalid --init-timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --max-connections values' '
+	arg='3a' &&
+	test_must_fail git daemon --max-connections=3a 2>actual_error &&
+	test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" >expected &&
+	test_cmp actual_error expected
+'
+
 start_git_daemon
 
 check_verbose_connect () {
-- 
gitgitgadget

