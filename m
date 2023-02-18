Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33CDC636D7
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBRGdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBRGdD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 01:33:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1811161
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 22:33:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k3-20020a05600c1c8300b003e1f5f2a29cso160672wms.4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6df/ptqk2SSpVQ1Fp9DaIydu9YcP80QwesNHOi/L3As=;
        b=fVzV9aaaxwHE4HmwqEs4pz4PUuGNFtNuKDGJumBKlUBN0J+21zS03uE3wVqsow+O32
         LgcKXb9ewTEgn8knS20fqQRMHeXhF+1q6EINn2b/mYsnNldMKRCOIPpBTWjzfMOCtEJ4
         DJ2K9HUmWO0Y7D6rQsFwMG+bysmlm8kTKojO6yL7XiNeJUx/Q2N/KnKsyvNL3vCakdTq
         Uh6GEKjH8G/4FY6ZofpEXUn5JMf9ovBpSjdF/AUf8ZMcaduYwl05DhhCItuRrCvffvpP
         XxLcbfd1eWhpczrebzeLkCtbxmlrpx/4xKzX/EGKjq4ADwl6jIdMaAYZhuDzc1enT35x
         ppKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6df/ptqk2SSpVQ1Fp9DaIydu9YcP80QwesNHOi/L3As=;
        b=AYTri3oafGYmyz+dHsv1cQEENmpsBdb2JIJmqhdNdfoyVrLHpEY3AyF4n+8zzyrLmd
         8g9JGoF8YG/ZVQ1y8hi/8+4asJXu77wgVhq9NS202zKlKLMXClizw81hZINNLkweLDrH
         eHBd03rZ3NgQBfU82j5wmrO8Pj4xz+Jh3wZbySGlC2CCQ1tJXxoytwE1CI3ScJdP1r34
         Q2LfvH8Pl6tyUNLCs2SwJtVYhta80Pyl1+5s85m86Wi2FSMWQ1N+ixe5E+42plLVBDz1
         mCh8tUcpNo8axEWtt3Eij0x2ed0IWDcaKzoCi4B3fE7Nt1+ZEQZniof/adMmE4TC0dPf
         JdKA==
X-Gm-Message-State: AO0yUKX0IRqEcp/4KSefNDu4WQ4g69SpbcS9tvcxO4YxS+gzY4Fe8H8y
        3tUAgwBXNapjZPeuSz7DkVH2co1Dnr0=
X-Google-Smtp-Source: AK7set9b80Lut1KI674Cdag9qsJWBolWnMoHE8j+bBPnsKY8dLaBcdf4IY2T0EfTdiryZFRdjuphZQ==
X-Received: by 2002:a05:600c:706:b0:3e2:1f01:c5f4 with SMTP id i6-20020a05600c070600b003e21f01c5f4mr3623399wmn.5.1676701979107;
        Fri, 17 Feb 2023 22:32:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003e11ad0750csm7198297wmj.47.2023.02.17.22.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:32:58 -0800 (PST)
Message-Id: <pull.1443.v4.git.git.1676701977347.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
References: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Feb 2023 06:32:57 +0000
Subject: [PATCH v4] credential: new attribute password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Some passwords have an expiry date known at generation. This may be
years away for a personal access token or hours for an OAuth access
token.

When multiple credential helpers are configured, `credential fill` tries
each helper in turn until it has a username and password, returning
early. If Git authentication succeeds, `credential approve`
stores the successful credential in all helpers. If authentication
fails, `credential reject` erases matching credentials in all helpers.
Helpers implement corresponding operations: get, store, erase.

The credential protocol has no expiry attribute, so helpers cannot
store expiry information. Even if a helper returned an improvised
expiry attribute, git credential discards unrecognised attributes
between operations and between helpers.

This is a particular issue when a storage helper and a
credential-generating helper are configured together:

	[credential]
		helper = storage  # eg. cache or osxkeychain
		helper = generate  # eg. oauth

`credential approve` stores the generated credential in both helpers
without expiry information. Later `credential fill` may return an
expired credential from storage. There is no workaround, no matter how
clever the second helper. The user sees authentication fail (a retry
will succeed).

Introduce a password expiry attribute. In `credential fill`, ignore
expired passwords and continue to query subsequent helpers.

In the example above, `credential fill` ignores the expired password
and a fresh credential is generated. If authentication succeeds,
`credential approve` replaces the expired password in storage.
If authentication fails, the expired credential is erased by
`credential reject`. It is unnecessary but harmless for storage
helpers to self prune expired credentials.

Add support for the new attribute to credential-cache.
Eventually, I hope to see support in other popular storage helpers.

Example usage in a credential-generating helper
https://github.com/hickford/git-credential-oauth/pull/16

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute password_expiry_utc
    
    details in commit message
    
    Changes in patch v4:
    
     * Set errno = 0 to fix tests on Windows and FreeBSD (thanks Lessley
       Dennington)
     * Clarify rationale as discussed at review club

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1443%2Fhickford%2Fpassword-expiry-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1443/hickford/password-expiry-v4
Pull-Request: https://github.com/git/git/pull/1443

Range-diff vs v3:

 1:  1846815a5c1 ! 1:  ae8bddbb30a credential: new attribute password_expiry_utc
     @@ Commit message
          Helpers implement corresponding operations: get, store, erase.
      
          The credential protocol has no expiry attribute, so helpers cannot
     -    store expiry information. (Even if a helper returned an improvised
     +    store expiry information. Even if a helper returned an improvised
          expiry attribute, git credential discards unrecognised attributes
     -    between operations and between helpers.)
     +    between operations and between helpers.
      
     -    As a workaround, whenever monolithic helper Git Credential Manager (GCM)
     -    retrieves an OAuth credential from its storage, it makes a HTTP request
     -    to check whether the OAuth token has expired [1]. This complicates and
     -    slows the authentication happy path.
     -
     -    Worse is the case that a storage helper and a credential-generating
     -    helper are configured together:
     +    This is a particular issue when a storage helper and a
     +    credential-generating helper are configured together:
      
                  [credential]
                          helper = storage  # eg. cache or osxkeychain
     -                    helper = generate  # eg. oauth or manager
     +                    helper = generate  # eg. oauth
      
          `credential approve` stores the generated credential in both helpers
          without expiry information. Later `credential fill` may return an
          expired credential from storage. There is no workaround, no matter how
     -    clever the second helper.
     +    clever the second helper. The user sees authentication fail (a retry
     +    will succeed).
      
          Introduce a password expiry attribute. In `credential fill`, ignore
          expired passwords and continue to query subsequent helpers.
      
     -    In the example above, `credential fill` ignores the expired credential
     +    In the example above, `credential fill` ignores the expired password
          and a fresh credential is generated. If authentication succeeds,
     -    `credential approve` replaces the expired credential in storage.
     +    `credential approve` replaces the expired password in storage.
          If authentication fails, the expired credential is erased by
          `credential reject`. It is unnecessary but harmless for storage
          helpers to self prune expired credentials.
      
          Add support for the new attribute to credential-cache.
     -    Eventually, I hope to see support in other storage helpers.
     +    Eventually, I hope to see support in other popular storage helpers.
      
          Example usage in a credential-generating helper
          https://github.com/hickford/git-credential-oauth/pull/16
      
     -    [1] https://github.com/GitCredentialManager/git-credential-manager/blob/66b94e489ad8cc1982836355493e369770b30211/src/shared/GitLab/GitLabHostProvider.cs#L217
     -
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## Documentation/git-credential.txt ##
     @@ Documentation/gitcredentials.txt: helper::
       variable, each helper will be tried in turn, and may provide a username,
       password, or nothing. Once Git has acquired both a username and a
      -password, no more helpers will be tried.
     -+unexpired password, no more helpers will be tried.
     ++non-expired password, no more helpers will be tried.
       +
       If `credential.helper` is configured to the empty string, this resets
       the helper list to empty (so you may override a helper set by a
     @@ credential.c: int credential_read(struct credential *c, FILE *fp)
       			free(c->path);
       			c->path = xstrdup(value);
      +		} else if (!strcmp(key, "password_expiry_utc")) {
     ++			errno = 0;
      +			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
     -+			if (c->password_expiry_utc == 0 || errno)
     ++			if (c->password_expiry_utc == 0 || errno == ERANGE)
      +				c->password_expiry_utc = TIME_MAX;
       		} else if (!strcmp(key, "url")) {
       			credential_from_url(c, value);
     @@ credential.c: void credential_fill(struct credential *c)
       	for (i = 0; i < c->helpers.nr; i++) {
       		credential_do(c, c->helpers.items[i].string, "get");
      +		if (c->password_expiry_utc < time(NULL)) {
     ++			/* Discard expired password */
      +			FREE_AND_NULL(c->password);
     ++			/* Reset expiry to maintain consistency */
      +			c->password_expiry_utc = TIME_MAX;
      +		}
       		if (c->username && c->password)
     @@ t/t0300-credentials.sh: test_expect_success 'credential_fill continues through p
      +	EOF
      +'
      +
     -+test_expect_success 'credential_fill continues through expired password' '
     ++test_expect_success 'credential_fill ignores expired password' '
      +	check fill "verbatim-with-expiry one two 5" "verbatim three four" <<-\EOF
      +	protocol=http
      +	host=example.com
     @@ t/t0300-credentials.sh: test_expect_success 'do not bother storing password-less
       	EOF
       '
       
     -+test_expect_success 'credential_approve does not store expired credential' '
     ++test_expect_success 'credential_approve does not store expired password' '
      +	check approve useless <<-\EOF
      +	protocol=http
      +	host=example.com
     @@ t/t0300-credentials.sh: test_expect_success 'credential_reject calls all helpers
       	EOF
       '
       
     -+test_expect_success 'credential_reject erases expired credential' '
     ++test_expect_success 'credential_reject erases credential regardless of expiry' '
      +	check reject useless <<-\EOF
      +	protocol=http
      +	host=example.com


 Documentation/git-credential.txt   |  6 ++
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c |  3 +
 credential.c                       | 20 ++++++-
 credential.h                       |  2 +
 t/t0300-credentials.sh             | 94 ++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..29d184ab824 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -144,6 +144,12 @@ Git understands the following attributes:
 
 	The credential's password, if we are asking it to be stored.
 
+`password_expiry_utc`::
+
+	Generated passwords such as an OAuth access token may have an expiry date.
+	When reading credentials from helpers, `git credential fill` ignores expired
+	passwords. Represented as Unix time UTC, seconds since 1970.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 4522471c337..100f045bb1a 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -167,7 +167,7 @@ helper::
 If there are multiple instances of the `credential.helper` configuration
 variable, each helper will be tried in turn, and may provide a username,
 password, or nothing. Once Git has acquired both a username and a
-password, no more helpers will be tried.
+non-expired password, no more helpers will be tried.
 +
 If `credential.helper` is configured to the empty string, this resets
 the helper list to empty (so you may override a helper set by a
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index f3c89831d4a..338058be7f9 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
+			if (e->item.password_expiry_utc != TIME_MAX)
+				fprintf(out, "password_expiry_utc=%"PRItime"\n",
+					e->item.password_expiry_utc);
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
diff --git a/credential.c b/credential.c
index f6389a50684..f32011343f9 100644
--- a/credential.c
+++ b/credential.c
@@ -7,6 +7,7 @@
 #include "prompt.h"
 #include "sigchain.h"
 #include "urlmatch.h"
+#include "git-compat-util.h"
 
 void credential_init(struct credential *c)
 {
@@ -234,6 +235,11 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			errno = 0;
+			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
+			if (c->password_expiry_utc == 0 || errno == ERANGE)
+				c->password_expiry_utc = TIME_MAX;
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -269,6 +275,11 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	if (c->password_expiry_utc != TIME_MAX) {
+		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
+		credential_write_item(fp, "password_expiry_utc", s, 0);
+		free(s);
+	}
 }
 
 static int run_credential_helper(struct credential *c,
@@ -342,6 +353,12 @@ void credential_fill(struct credential *c)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
+		if (c->password_expiry_utc < time(NULL)) {
+			/* Discard expired password */
+			FREE_AND_NULL(c->password);
+			/* Reset expiry to maintain consistency */
+			c->password_expiry_utc = TIME_MAX;
+		}
 		if (c->username && c->password)
 			return;
 		if (c->quit)
@@ -360,7 +377,7 @@ void credential_approve(struct credential *c)
 
 	if (c->approved)
 		return;
-	if (!c->username || !c->password)
+	if (!c->username || !c->password || c->password_expiry_utc < time(NULL))
 		return;
 
 	credential_apply_config(c);
@@ -381,6 +398,7 @@ void credential_reject(struct credential *c)
 
 	FREE_AND_NULL(c->username);
 	FREE_AND_NULL(c->password);
+	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
 }
 
diff --git a/credential.h b/credential.h
index f430e77fea4..935b28a70f1 100644
--- a/credential.h
+++ b/credential.h
@@ -126,10 +126,12 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	timestamp_t password_expiry_utc;
 };
 
 #define CREDENTIAL_INIT { \
 	.helpers = STRING_LIST_INIT_DUP, \
+	.password_expiry_utc = TIME_MAX, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 3485c0534e6..c66d91e82d8 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -35,6 +35,16 @@ test_expect_success 'setup helper scripts' '
 	test -z "$pass" || echo password=$pass
 	EOF
 
+	write_script git-credential-verbatim-with-expiry <<-\EOF &&
+	user=$1; shift
+	pass=$1; shift
+	pexpiry=$1; shift
+	. ./dump
+	test -z "$user" || echo username=$user
+	test -z "$pass" || echo password=$pass
+	test -z "$pexpiry" || echo password_expiry_utc=$pexpiry
+	EOF
+
 	PATH="$PWD:$PATH"
 '
 
@@ -109,6 +119,43 @@ test_expect_success 'credential_fill continues through partial response' '
 	EOF
 '
 
+test_expect_success 'credential_fill populates password_expiry_utc' '
+	check fill "verbatim-with-expiry one two 9999999999" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	username=one
+	password=two
+	password_expiry_utc=9999999999
+	--
+	verbatim-with-expiry: get
+	verbatim-with-expiry: protocol=http
+	verbatim-with-expiry: host=example.com
+	EOF
+'
+
+test_expect_success 'credential_fill ignores expired password' '
+	check fill "verbatim-with-expiry one two 5" "verbatim three four" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	username=three
+	password=four
+	--
+	verbatim-with-expiry: get
+	verbatim-with-expiry: protocol=http
+	verbatim-with-expiry: host=example.com
+	verbatim: get
+	verbatim: protocol=http
+	verbatim: host=example.com
+	verbatim: username=one
+	EOF
+'
+
 test_expect_success 'credential_fill passes along metadata' '
 	check fill "verbatim one two" <<-\EOF
 	protocol=ftp
@@ -149,6 +196,24 @@ test_expect_success 'credential_approve calls all helpers' '
 	EOF
 '
 
+test_expect_success 'credential_approve stores password expiry' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=9999999999
+	--
+	--
+	useless: store
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: password_expiry_utc=9999999999
+	EOF
+'
+
 test_expect_success 'do not bother storing password-less credential' '
 	check approve useless <<-\EOF
 	protocol=http
@@ -159,6 +224,17 @@ test_expect_success 'do not bother storing password-less credential' '
 	EOF
 '
 
+test_expect_success 'credential_approve does not store expired password' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=5
+	--
+	--
+	EOF
+'
 
 test_expect_success 'credential_reject calls all helpers' '
 	check reject useless "verbatim one two" <<-\EOF
@@ -181,6 +257,24 @@ test_expect_success 'credential_reject calls all helpers' '
 	EOF
 '
 
+test_expect_success 'credential_reject erases credential regardless of expiry' '
+	check reject useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=5
+	--
+	--
+	useless: erase
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: password_expiry_utc=5
+	EOF
+'
+
 test_expect_success 'usernames can be preserved' '
 	check fill "verbatim \"\" three" <<-\EOF
 	protocol=http

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
