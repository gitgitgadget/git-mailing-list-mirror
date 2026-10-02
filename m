Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04633422531
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925482; cv=none; b=IcIVLxzHdIdscBMY3+4kYznfr2juUx4MkX7eOPv95uC/E/NNsXhSaJX06x/IWbgC6jRTnXTIuEbrGifGU5jeLvxssKDdL64ouapguQB2kcdvOvFo6mcf/Mbxh9J4h9OV1T709+yIe9PQBhbAWawrDkCnbDyS2vFUPl5NZ/nq26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925482; c=relaxed/simple;
	bh=sRUvPYFqUrQtuQSzjL5GADrs6oL3TuAiSRBYyqe6OU8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K/uEgHvPyGlPzlqLshjE/v/0pbIzFwD/NSrrPqXHxCjLV60hdoJNDWdHwU/IL0tvpl9hlAkB3CN+t6r5IN/Fo+gUApI4H564nMzvRlOjzUtTvPgwRf7Fta0Q2tmJU3vrkH0q6s1UOPiT8Sb0CStgUK1OoL1DQVRCbU9QSXcIW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3FXsw1w; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3FXsw1w"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-33c0d931083so2780737eec.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925477; x=1791530277; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T9OGEwQUZzOoUzpkQNH66revrkFvSZXLnY08M8a4n3I=;
        b=U3FXsw1wAYvUt81abdQ1ueQ64ynkDMy5AqxLrPt2gEguF8bpiR9b15+SXaShYHbWVQ
         QRGcx9Koc8L3jTUCdcJ35J2waqJZviXT+Gakdms33++EtQwTzuqwiZBIdV3oXdkbOsgE
         fyAy5oeGJ9W6OdgRKri4q3CydkksAesv6KVDha88GRxQJ2q9Weiq6GFpeiuXkgHe+8lC
         h4CSK53KoTp+AIBC0SyoKNOIonrdQRH3Gr11lfKbh9LKGOg0JYBgLpAq6aMgxux4h+u5
         cNmumXy4WJ5TaFcPtC2hOQFTHR0wt7vkM8ezFuET4vF7+fWTFzvLP9424atFi9rFQuqD
         Wesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925477; x=1791530277;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9OGEwQUZzOoUzpkQNH66revrkFvSZXLnY08M8a4n3I=;
        b=2ewbATiz6HgejLMREtzJRpAYNKoqmYQQdxxjosAqgvSWClYVQjT4YiXu5Hl1r+OPHH
         UIEtNW/WNYzZmFprbtpHvsRsM6hqnJqV8YlZaMqSQD10XrwoO8xMvJD9d25yQ+292kp9
         uwI54yF1xcwyDoBDeaMaHqs7GwjCAQ6mV776ByiLHkSIyGkP8JjmjmkhQ266U58if7dC
         KbrtG+fTStP/X43GJPIn8GXkuhYpjtriTu/nyeb3YAxWDxRnAGBFb8GfU+S1TaF4u6wo
         w17Pw4K3SmWyknGmOU0zfdpp3tXBAioWqaZ3oeGxrnegMeEqTHafvdV/9KaeyREbV9Ar
         rJMg==
X-Gm-Message-State: AFuF++lflJTmwCtVXz4Nm61rn/J7ePgkaQYOPlIm7p5Of2F4nF2weDwG
	PuBZBcIj5bpV8Jiz3taaB5YSshE+P6/akFhz19+UoXmOaJFOUIgaaYr8P6tQOw==
X-Gm-Gg: AYBFou3Co+jmEhtDX0YS84UoZZXMf86Xqb+jUh1zN2r9X906AMemSEuVB0e1rgI0nbM
	xEGp6fZY2cq2dMmads2uHvLRbA89KXiv6j7g8YTNGQf7LxfY1kcIYoycOLJ8PWgk1ryULZ7RnUQ
	IVDqxJxu7eay3SHHMwz8JiPoMY5SDoGofkYHsJi/uEwxTOhjWWdIhButF2fygmDyR1rnTCf1NT5
	GMrbvUmXYJSZFEZ15lOTZBYpZnagIhcvs0ksF8OVVHzRkyomcuCtYnelvC7IZg2C09GV0vkX4Do
	MKyA54uWHKrLx8ouLj5l4DkIE5inopV6OX6Gx7a0qVRrm81qXOujSNGf8AHuQrjehsaTuZver5s
	osCjQ6wWeEQnCrKXIaIzTR+vScF43VuySrePxxJVC6fSt3TOAFmz9AI6NPwVSXBf0dPm2Aw0lAg
	QX5dlwW3KBiWeWV6we6yJQOmyqFLH3jIkbVLNjb8wVtn3asJusZQgnupUmkRoeWaN7OcB0LlDtw
	hXuWjDacFcW
X-Received: by 2002:a05:7022:f509:b0:144:e259:b1f with SMTP id a92af1059eb24-14f5b414938mr1644470c88.13.1790925477108;
        Fri, 02 Oct 2026 00:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f474774c4sm4010523c88.14.2026.10.02.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:17:56 -0700 (PDT)
Message-Id: <955709d4ef3aa43a6fb15cf5007daf094b76d427.1790925472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2423.git.git.1790925472.gitgitgadget@gmail.com>
References: <pull.2423.git.git.1790925472.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:17:52 +0000
Subject: [PATCH 2/2] remote: allow a list of remotes in remote.pushDefault
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Someone who pushes to a personal fork in some repositories and to
origin in others cannot set remote.pushDefault globally. Repositories
without the named remote fail to push, because git takes the missing
name for a URL.

Let remote.pushDefault hold a space separated list of remote names and
push to the first one that is configured in the repository. When none
of them is configured, fall back to branch.<name>.remote as if the
variable was not set. A single name keeps working as before, and a
value set in the repository still overrides one set globally.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  7 +++++++
 remote.c                         | 29 ++++++++++++++++++++++---
 t/t5516-fetch-push.sh            | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..6a67c97fe8 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -2,6 +2,13 @@ remote.pushDefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushRemote` for specific branches.
++
+The value may be a space separated list of remote names, in which case
+the first one that is configured in the repository is used. If none of
+them is configured, `branch.<name>.remote` is used as if
+`remote.pushDefault` was not set. This allows setting a list such as
+`fork origin` globally and have repositories without a `fork` remote
+push to `origin`.
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
diff --git a/remote.c b/remote.c
index 6567ec91cc..3cad0673b9 100644
--- a/remote.c
+++ b/remote.c
@@ -700,6 +700,25 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 					 explicit);
 }
 
+static const char *pushdefault_candidate(struct remote_state *remote_state)
+{
+	const char *p = remote_state->pushremote_name;
+
+	if (!strchr(p, ' '))
+		return p;
+
+	while (*p) {
+		size_t len = strcspn(p, " ");
+		struct remote *remote = find_remote(remote_state, p, len);
+
+		if (remote && valid_remote(remote))
+			return remote->name;
+		p += len;
+		p += strspn(p, " ");
+	}
+	return NULL;
+}
+
 static const char *
 remotes_pushremote_for_branch(struct remote_state *remote_state,
 			      struct branch *branch, int *explicit)
@@ -710,9 +729,13 @@ remotes_pushremote_for_branch(struct remote_state *remote_state,
 		return branch->pushremote_name;
 	}
 	if (remote_state->pushremote_name) {
-		if (explicit)
-			*explicit = 1;
-		return remote_state->pushremote_name;
+		const char *name = pushdefault_candidate(remote_state);
+
+		if (name) {
+			if (explicit)
+				*explicit = 1;
+			return name;
+		}
 	}
 	return remotes_remote_for_branch(remote_state, branch, explicit);
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b982b209bf..7a0cdafd65 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -591,6 +591,42 @@ test_expect_success 'push with remote.pushdefault' '
 	check_push_result down_repo $the_commit heads/main
 '
 
+test_expect_success 'push with remote.pushdefault list picks first existing remote' '
+	mk_test up_repo heads/main &&
+	mk_test down_repo heads/main &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.main.remote up &&
+	test_config remote.pushdefault "missing down up" &&
+	test_config push.default matching &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/main &&
+	check_push_result down_repo $the_commit heads/main
+'
+
+test_expect_success 'push with remote.pushdefault list of missing remotes' '
+	mk_test up_repo heads/main &&
+	test_config remote.up.url up_repo &&
+	test_config branch.main.remote up &&
+	test_config remote.pushdefault "missing also-missing" &&
+	test_config push.default matching &&
+	git push &&
+	check_push_result up_repo $the_commit heads/main
+'
+
+test_expect_success 'repository remote.pushdefault overrides global list' '
+	mk_test up_repo heads/main &&
+	mk_test down_repo heads/main &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config_global remote.pushdefault "down up" &&
+	test_config remote.pushdefault up &&
+	test_config push.default matching &&
+	git push &&
+	check_push_result up_repo $the_commit heads/main &&
+	check_push_result down_repo $the_first_commit heads/main
+'
+
 test_expect_success 'push with config remote.*.pushurl' '
 	mk_test testrepo heads/main &&
 	git checkout main &&
-- 
gitgitgadget
