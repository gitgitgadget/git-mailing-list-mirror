Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3413C3D3
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726790431; cv=none; b=RjdrQPkWbkKeLdzXGgANTPINCCJ5hNbZIxiXTj1YjYdUXBHtw6kuGsoQacDVKHCVvU2dD8WiZZW/U5WYMDcphdKS5m73vmL75qLX7/5gQ7cLDhtndUIaukPKUhXM2EsMac9o/vcaxPQQTXlpUzDlkJeOiyYJLHIiCAjgB48Zgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726790431; c=relaxed/simple;
	bh=nJ5GcEt9feTFmwqaJP28slBE2482mb3Ne5AZvx5atvc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=slEv6ptRWBdRQyOiabTtla5zgbk/dulv9RTz+jcOdDsJFu66w8odYksaz6WLHqxJcXKDqPSBJOPJ84i5MiMCs+BLwGXBF1EBiHM5YHAEa8iDz2ynUNOYL+JtPZqJ5royZYQK4w+cnJyuFRWxdy6JZ5Q4U12jOMFLsnVVl0d7j4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpNZexxq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpNZexxq"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso191003366b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726790427; x=1727395227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaNY5ZrJNkAbTfnuqRBQuw+hE4fk+SzWL4Ia8fQykHU=;
        b=cpNZexxqcKSPPM53ksJyE6SYwxRa4gt+wK9UEyTCXGdko3xiHyfyLL8CxFYJGNDTNr
         V7NfSKeZAsgxhDPlnWS/h9YMHCRSd0zLb9YxOi3NH1qW3yDjvOMQyaE3eqer2RHT1aHy
         ple/T90RT+gy7oUmN+LRsj+UF5eJGSSHJV9As7Fzen4ivsgZbD0+4BU+NIcZi7SEx+8G
         NYdRVij22bdenRANeT4afeKGV3x1WoQ3MSriABIBBFt1sXz65+uoi5y40W9HTp3anyzi
         YMLcn9/on4h1ts/Mlh8DDaw1Oxe3rkY1c4RKboTe0Ltf4l6Hm+z/tUxH+APLotN5vQA/
         tLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726790427; x=1727395227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaNY5ZrJNkAbTfnuqRBQuw+hE4fk+SzWL4Ia8fQykHU=;
        b=cOuR5xqgwgb7wKEv6jGZGky3MWovdXOL1+S2luep4jLRxDGl/+CAl3edE5dBJmH4MP
         duV/kbaq2iCk0Tz9S4VQ4A26fZSDppoSymk6B59tVju0bf2Zvf6l0PY0edrhZtok70iq
         U1ZgwRFxWaoCO7utfsgNcP7R1csVsY41lrqnisteY4jiGnAcSr0j0cwogwavmFZGKEWq
         6HubXWPPAF01FEL+7MRXWJp3ntqCHC9KLs3q5DwOKZwi5QvFb4V+ztkbTlbhknvj2XEu
         YPJVjI0JlkAsMH4Y8DDP9tvQzlMXrrjAz+/o0KrYiaNguv6YoWiMVS0rBG9+Qc/jNLwQ
         lxYw==
X-Gm-Message-State: AOJu0Yx6huBxFzWJqVuXGlkU7kmS8D0BFELSOu6aMOJ/bYrxjR1mKtHW
	h3WEAEqp5rLnY/afJgW5tkRdUWLDPFIGsDgUHwSXUhWiEnxUUMjy4S18Dg==
X-Google-Smtp-Source: AGHT+IGNX87WpACRwvMD5MhgTt20Ij3wegqkJjAAd0u5ajkVciJQKD+R642rLwbsSivoRGBgMm4iLw==
X-Received: by 2002:a17:906:d259:b0:a7a:9ca6:528 with SMTP id a640c23a62f3a-a90d4fc8f40mr58730466b.11.1726790427039;
        Thu, 19 Sep 2024 17:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613338f4sm773076966b.216.2024.09.19.17.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:00:26 -0700 (PDT)
Message-Id: <1e9bf2d09c17bc0cdcd0a8f8dbacab007e5c53e7.1726790424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 00:00:21 +0000
Subject: [PATCH 1/3] credential: add new interactive config option
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
    liuzhongbo.gg@gmail.com,
    Johannes.Schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

When scripts or background maintenance wish to perform HTTP(S) requests,
there is a risk that our stored credentials might be invalid. At the
moment, this causes the credential helper to ping the user and block the
process. Even if the credential helper does not ping the user, Git falls
back to the 'askpass' method, which includes a direct ping to the user
via the terminal.

Even setting the 'core.askPass' config as something like 'echo' will
causes Git to fallback to a terminal prompt. It uses
git_terminal_prompt(), which finds the terminal from the environment and
ignores whether stdin has been redirected. This can also block the
process awaiting input.

Create a new config option to prevent user interaction, favoring a
failure to a blocked process.

The chosen name, 'credential.interactive', is taken from the config
option used by Git Credential Manager to already avoid user
interactivity, so there is already one credential helper that integrates
with this option. However, older versions of Git Credential Manager also
accepted other string values, including 'auto', 'never', and 'always'.
The modern use is to use a boolean value, but we should still be
careful that some users could have these non-booleans. Further, we
should respect 'never' the same as 'false'. This is respected by the
implementation and test, but not mentioned in the documentation.

The implementation for the Git interactions takes place within
credential_getpass(). The method prototype is modified to return an
'int' instead of 'void'. This allows us to detect that no attempt was
made to fill the given credential, changing the single caller slightly.

Also, a new trace2 region is added around the interactive portion of the
credential request. This provides a way to measure the amount of time
spent in that region for commands that _are_ interactive. It also makes
a conventient way to test that the config option works with
'test_region'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/credential.txt |  8 ++++++++
 credential.c                        | 30 ++++++++++++++++++++++++++---
 t/t5551-http-fetch-smart.sh         | 22 +++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 0221c3e620d..470482ff4c2 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -9,6 +9,14 @@ credential.helper::
 Note that multiple helpers may be defined. See linkgit:gitcredentials[7]
 for details and examples.
 
+credential.interactive::
+	By default, Git and any configured credential helpers will ask for
+	user input when new credentials are required. Many of these helpers
+	will succeed based on stored credentials if those credentials are
+	still valid. To avoid the possibility of user interactivity from
+	Git, set `credential.interactive=false`. Some credential helpers
+	respect this option as well.
+
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
 	or https URL to be important. Defaults to false. See
diff --git a/credential.c b/credential.c
index ee46351ce01..6dea3859ece 100644
--- a/credential.c
+++ b/credential.c
@@ -13,6 +13,8 @@
 #include "strbuf.h"
 #include "urlmatch.h"
 #include "git-compat-util.h"
+#include "trace2.h"
+#include "repository.h"
 
 void credential_init(struct credential *c)
 {
@@ -251,14 +253,36 @@ static char *credential_ask_one(const char *what, struct credential *c,
 	return xstrdup(r);
 }
 
-static void credential_getpass(struct credential *c)
+static int credential_getpass(struct credential *c)
 {
+	int interactive;
+	char *value;
+	if (!git_config_get_maybe_bool("credential.interactive", &interactive) &&
+	    !interactive) {
+		trace2_data_intmax("credential", the_repository,
+				   "interactive/skipped", 1);
+		return -1;
+	}
+	if (!git_config_get_string("credential.interactive", &value)) {
+		int same = !strcmp(value, "never");
+		free(value);
+		if (same) {
+			trace2_data_intmax("credential", the_repository,
+					   "interactive/skipped", 1);
+			return -1;
+		}
+	}
+
+	trace2_region_enter("credential", "interactive", the_repository);
 	if (!c->username)
 		c->username = credential_ask_one("Username", c,
 						 PROMPT_ASKPASS|PROMPT_ECHO);
 	if (!c->password)
 		c->password = credential_ask_one("Password", c,
 						 PROMPT_ASKPASS);
+	trace2_region_leave("credential", "interactive", the_repository);
+
+	return 0;
 }
 
 int credential_has_capability(const struct credential_capability *capa,
@@ -501,8 +525,8 @@ void credential_fill(struct credential *c, int all_capabilities)
 			    c->helpers.items[i].string);
 	}
 
-	credential_getpass(c);
-	if (!c->username && !c->password && !c->credential)
+	if (credential_getpass(c) ||
+	    (!c->username && !c->password && !c->credential))
 		die("unable to get password from user");
 }
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 7b5ab0eae16..ceb3336a5c4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -186,6 +186,28 @@ test_expect_success 'clone from password-protected repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'credential.interactive=false skips askpass' '
+	set_askpass bogus nonsense &&
+	(
+		GIT_TRACE2_EVENT="$(pwd)/interactive-true" &&
+		export GIT_TRACE2_EVENT &&
+		test_must_fail git clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-true-dir &&
+		test_region credential interactive interactive-true &&
+
+		GIT_TRACE2_EVENT="$(pwd)/interactive-false" &&
+		export GIT_TRACE2_EVENT &&
+		test_must_fail git -c credential.interactive=false \
+			clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-false-dir &&
+		test_region ! credential interactive interactive-false &&
+
+		GIT_TRACE2_EVENT="$(pwd)/interactive-never" &&
+		export GIT_TRACE2_EVENT &&
+		test_must_fail git -c credential.interactive=never \
+			clone --bare "$HTTPD_URL/auth/smart/repo.git" interactive-never-dir &&
+		test_region ! credential interactive interactive-never
+	)
+'
+
 test_expect_success 'clone from auth-only-for-push repository' '
 	echo two >expect &&
 	set_askpass wrong &&
-- 
gitgitgadget

