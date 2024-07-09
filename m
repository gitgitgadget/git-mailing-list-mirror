Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCA15F3E7
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536579; cv=none; b=sfu4Cl2p6xUIL5qQvC8bRn9szLW4aZTDMmmL6Xy696ciG71hSSqVj4/lLP6zqmEWStVISUFmIoun82pNpfKpVvnY9NgjdH5vqj5mdNAtpCk9SX6mfBZCYA+zr0OO9M3ZREoRdKg29fYqXOz4uYxA0viPxHYLyJXHXaVga7XjtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536579; c=relaxed/simple;
	bh=ZJhqkv85udoOEl/L5ZpiX90f1Wnj+ijmQKVwNRMaoMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=povLQIkuS3vbjqNBpBOyFlvr90idKMRWRlq2U6P/UwogwWZqpio+8mEc4jNI6tIbmoGHvKN6eWjOCuSSyFvTH4VplrDHgQ3/7WZmkjhArVCwU4n0gr4mzZmMArG/P7OrCQqgJvGSctsHhmtNkktUF91Gg0qIgK+UcEZmomgc1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwFOcC6l; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwFOcC6l"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so3549317f8f.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720536575; x=1721141375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIae+nmW8KLfv/umdwXxJKkDjsbfheVVbmhZJu5nbyI=;
        b=QwFOcC6lxrDEsnkDTFryhYR4HI49546tbJRnxF/An4hZt70APlMeR3IlM/DTjiwpom
         5iAu98uTQCR20aaMJdcEHNOC7cN9vNUSAN0esCWbcIvXBbalpfv/U9ickvU6KW4jNbaS
         qONGJfrSBLTP+OrJQi/WnJ5R53cxxXVTkL+SFpLvhi9giIGJrI7tFnfTRZOOZIWqw+qP
         TlP6TsWrAKWnPUslISYGrp4ddEbJ67HDPcc8ZsNS10u+unWhTEmlG2meFGbz46bdaVq2
         xXmyHkyLlH+Y7pbo2I5CkI8qhXtfwfCQevYAGUEhrlIaEbcgNjtxJjmS2ChnSScq5Bzl
         jESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536575; x=1721141375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIae+nmW8KLfv/umdwXxJKkDjsbfheVVbmhZJu5nbyI=;
        b=I2GR7UNJ7b55sY+9bmZtWx3lYKuhNKM1prUD48Jg0jhdkxjCkM2/jNoRtX8Rf3+iZ+
         XyFTb77UTZGZ9oN1XcTe2/rzprCzNqI3o66rtOV9m3ceCPrlHFTC/+pJXDTvwZXYzomO
         1BOP/5Yp2PJbX4otH4+rYIkCBIr8AWNR/cFrIzKoC8oDk66Iz4WKr+35fi8pPjysjPgW
         tBlpePUWX2sdeUdlaxZDQIv1fbc8rR9UOdVoTOKGBtGpNR1uQAiT4H+Z13z+eCPNKucQ
         cJ0yJBmreFBqYSeDncMHpJkZihXdeVrO6GhH8hQZyjl4rtp7rwKXd2WmJCjniTspZv7/
         Dgiw==
X-Gm-Message-State: AOJu0YyszAQg0kjVnXAKP1/Q92L/WBcsfPf+lvyyuwGIVHe5bKdXzUd1
	zQP7KTFkuPHTlczxCeWXGzCM/BzWKeQ8XVJMesuka92A1VMCOVy51tXHwxOK
X-Google-Smtp-Source: AGHT+IHMiAwqwP/ji99HnhkvsP+Ay0CI2pKMmzvvpRU3eqq6JJyJDRoidjqLwfUlXvLXuGUk5pTH7Q==
X-Received: by 2002:adf:9b93:0:b0:367:892e:c69f with SMTP id ffacd0b85a97d-367cea46153mr2134756f8f.13.1720536575244;
        Tue, 09 Jul 2024 07:49:35 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:eec5:fb32:356a:67b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e1dcsm2741324f8f.12.2024.07.09.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:49:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net
Subject: [PATCH v2] builtin/push: call set_refspecs after validating remote
Date: Tue,  9 Jul 2024 16:49:31 +0200
Message-ID: <20240709144931.1146528-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708140350.622986-1-karthik.188@gmail.com>
References: <20240708140350.622986-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
reset the remote URL if the provided URL is empty. When a user of
'remotes_remote_get' tries to fetch a remote with an empty repo name,
the function initializes the remote via 'make_remote'. But the remote is
still not a valid remote, since the URL is empty, so it tries to add the
URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
in 'remotes_remote_get', we again check if the remote is valid, which
fails, so we return 'NULL' for the 'struct remote *' value

The 'builtin/push.c' code, calls 'set_refspecs' before validating the
remote. This worked with empty repo names earlier since we would get a
remote, albeit with an empty URL. With the new changes, we get a 'NULL'
remote value, this causes the check for remote to fail and raises the
BUG in 'set_refspecs'.

Do a simple fix by doing remote validation first. Also add a test to
validate the bug fix. With this, we can also now directly pass remote to
'set_refspecs' instead of it trying to lazily obtain it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes from v1:
- Added more details to the commit message to clarify the issue at hand.
- Fixed the quoting in the test.
- Cleaned up 'set_refspecs' by now accepting a remote instead of trying
  to obtain one. 

Range-diff against v1:
1:  1bd4dc424d ! 1:  fd9a9387e9 builtin/push: call set_refspecs after validating remote
    @@ Metadata
      ## Commit message ##
         builtin/push: call set_refspecs after validating remote
     
    -    Since 9badf97c4 (remote: allow resetting url list), we reset the remote
    -    URL if the provided URL is empty. This means any caller of
    -    `remotes_remote_get()` would now get a NULL remote.
    +    Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
    +    reset the remote URL if the provided URL is empty. When a user of
    +    'remotes_remote_get' tries to fetch a remote with an empty repo name,
    +    the function initializes the remote via 'make_remote'. But the remote is
    +    still not a valid remote, since the URL is empty, so it tries to add the
    +    URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
    +    since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
    +    in 'remotes_remote_get', we again check if the remote is valid, which
    +    fails, so we return 'NULL' for the 'struct remote *' value
     
         The 'builtin/push.c' code, calls 'set_refspecs' before validating the
    -    remote. This worked earlier since we would get a remote, albeit with an
    -    empty URL. With the new changes, we get a NULL remote and this crashes.
    +    remote. This worked with empty repo names earlier since we would get a
    +    remote, albeit with an empty URL. With the new changes, we get a 'NULL'
    +    remote value, this causes the check for remote to fail and raises the
    +    BUG in 'set_refspecs'.
     
    -    Do a simple fix by doing remote validation first and also add a test to
    -    validate the bug fix.
    +    Do a simple fix by doing remote validation first. Also add a test to
    +    validate the bug fix. With this, we can also now directly pass remote to
    +    'set_refspecs' instead of it trying to lazily obtain it.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/push.c ##
    +@@ builtin/push.c: static void refspec_append_mapped(struct refspec *refspec, const char *ref,
    + 	refspec_append(refspec, ref);
    + }
    + 
    +-static void set_refspecs(const char **refs, int nr, const char *repo)
    ++static void set_refspecs(const char **refs, int nr, struct remote *remote)
    + {
    +-	struct remote *remote = NULL;
    + 	struct ref *local_refs = NULL;
    + 	int i;
    + 
    +@@ builtin/push.c: static void set_refspecs(const char **refs, int nr, const char *repo)
    + 				local_refs = get_local_heads();
    + 
    + 			/* Does "ref" uniquely name our ref? */
    +-			if (count_refspec_match(ref, local_refs, &matched) != 1) {
    ++			if (count_refspec_match(ref, local_refs, &matched) != 1)
    + 				refspec_append(&rs, ref);
    +-			} else {
    +-				/* lazily grab remote */
    +-				if (!remote)
    +-					remote = remote_get(repo);
    +-				if (!remote)
    +-					BUG("must get a remote for repo '%s'", repo);
    +-
    ++			else
    + 				refspec_append_mapped(&rs, ref, remote, matched);
    +-			}
    + 		} else
    + 			refspec_append(&rs, ref);
    + 	}
     @@ builtin/push.c: int cmd_push(int argc, const char **argv, const char *prefix)
      	if (tags)
      		refspec_append(&rs, "refs/tags/*");
    @@ builtin/push.c: int cmd_push(int argc, const char **argv, const char *prefix)
      	}
      
     +	if (argc > 0)
    -+		set_refspecs(argv + 1, argc - 1, repo);
    ++		set_refspecs(argv + 1, argc - 1, remote);
     +
      	if (remote->mirror)
      		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
    @@ t/t5529-push-errors.sh: test_expect_success 'detect missing sha1 expressions ear
      	test_cmp expect rp-ran
      '
      
    ++# We need to use an existing local_ref so that the remote is mapped to
    ++# it in 'builtin/push.c:set_refspecs()'.
     +test_expect_success 'detect empty remote' '
     +	test_must_fail git push "" main 2> stderr &&
    -+	grep "fatal: bad repository ''" stderr
    ++	grep "fatal: bad repository ${SQ}${SQ}" stderr
     +'
     +
      test_expect_success 'detect ambiguous refs early' '

 builtin/push.c         | 21 +++++++--------------
 t/t5529-push-errors.sh | 10 ++++++++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8260c6e46a..7a67398124 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -96,9 +96,8 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	refspec_append(refspec, ref);
 }
 
-static void set_refspecs(const char **refs, int nr, const char *repo)
+static void set_refspecs(const char **refs, int nr, struct remote *remote)
 {
-	struct remote *remote = NULL;
 	struct ref *local_refs = NULL;
 	int i;
 
@@ -124,17 +123,10 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 				local_refs = get_local_heads();
 
 			/* Does "ref" uniquely name our ref? */
-			if (count_refspec_match(ref, local_refs, &matched) != 1) {
+			if (count_refspec_match(ref, local_refs, &matched) != 1)
 				refspec_append(&rs, ref);
-			} else {
-				/* lazily grab remote */
-				if (!remote)
-					remote = remote_get(repo);
-				if (!remote)
-					BUG("must get a remote for repo '%s'", repo);
-
+			else
 				refspec_append_mapped(&rs, ref, remote, matched);
-			}
 		} else
 			refspec_append(&rs, ref);
 	}
@@ -630,10 +622,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		refspec_append(&rs, "refs/tags/*");
 
-	if (argc > 0) {
+	if (argc > 0)
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1, repo);
-	}
 
 	remote = pushremote_get(repo);
 	if (!remote) {
@@ -649,6 +639,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		    "    git push <name>\n"));
 	}
 
+	if (argc > 0)
+		set_refspecs(argv + 1, argc - 1, remote);
+
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 0247137cb3..54427252a8 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -2,6 +2,9 @@
 
 test_description='detect some push errors early (before contacting remote)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -38,6 +41,13 @@ test_expect_success 'detect missing sha1 expressions early' '
 	test_cmp expect rp-ran
 '
 
+# We need to use an existing local_ref so that the remote is mapped to
+# it in 'builtin/push.c:set_refspecs()'.
+test_expect_success 'detect empty remote' '
+	test_must_fail git push "" main 2> stderr &&
+	grep "fatal: bad repository ${SQ}${SQ}" stderr
+'
+
 test_expect_success 'detect ambiguous refs early' '
 	git branch foo &&
 	git tag foo &&
-- 
2.45.1

