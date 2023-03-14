Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659DC6FD1C
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 06:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCNGqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCNGqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 02:46:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145B95459
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 23:46:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m18-20020a05600c3b1200b003ed2a3d635eso1609750wms.4
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678776366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=faIJYqlLoPVrNT7LEXYfDoOcOK/QtnxBWUBJ4buF0zg=;
        b=itXzhMBJpY8jxyzcP2ZrsM4okJNXEKe5VxXhwqUphfXra+oxFxW09C0z/iNN6ams4s
         dVyV3kNoMeKj3QuTk0zJL89sKBGB90qQ2PZ/FiyP0n8yFBoXcdpSKB+YQ/ntGlNeYUXL
         dia/xrtj5AVIJesYuB8jRfv5VXFjXAfjUYzLireWToffyg+m19L0Fkvb9aS9VycoWYlV
         mPOuVzYqFZEtewUpB9+3WRI+oZI/sIzMbNC7tETgpQpHQym0V+MZc6n0xsY7SVoDdlyF
         ZRjnFbFYsQkh+H4WlJzM26cgqrg57huhp9cmRvM/d973WwPaVE2ATVE9ZFyXljB2MV20
         W9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faIJYqlLoPVrNT7LEXYfDoOcOK/QtnxBWUBJ4buF0zg=;
        b=dbXsHY0dxS800qZV/0aFNaOVOPzWfu/KeOHIWikC/3SaMth8LuaDGu2tMHut9k6uT6
         /AAP8Ru66kE/Th7Ogj2k+ue5FSqPnuhLz9Ca3tMXiZCyGmbIM54hEbeRqiN3W+HRHcm3
         CdyIb5sV3xYegBTWkQhVsaiH97LEklbeIXnuTENiyIgExHaXelgEEoSj5j+9ePXOeiHh
         BPmCeqeufcvUYV62e9wazpjOzh2OWtlCFFKS1QzitEzVRjvvUltJ6dT5EMltNlaSoRQx
         bGHcnbDtKFCyclfo2jo4HSjXQRstPmP8EiFzfjX2OpVCF4mBuvNUx0dMXOniKYn7CWac
         aqRA==
X-Gm-Message-State: AO0yUKX3AtnEWvmej+fapAkBnH/lj6wfsb3ZPo4CIZ5kw+1EKP/HiCsl
        3yHNyowzX5bZ8QcA38OUYAuvHYOnGHw=
X-Google-Smtp-Source: AK7set9vxcHOIu6AwPyZbuYYcPT4R+5HrUBCI3i7Kfz418gvXwIbbmf+Yj+6j14tcgsZvTVE7ozO/A==
X-Received: by 2002:a05:600c:3ac9:b0:3eb:966f:5811 with SMTP id d9-20020a05600c3ac900b003eb966f5811mr13317027wms.3.1678776366019;
        Mon, 13 Mar 2023 23:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d5051000000b002cfe7580b46sm1240242wrt.57.2023.03.13.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 23:46:05 -0700 (PDT)
Message-Id: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 06:46:04 +0000
Subject: [PATCH] credential: new attribute oauth_refresh_token
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

Git authentication with OAuth access token is supported by every popular
Git host including GitHub, GitLab and BitBucket [1][2][3]. Credential
helpers Git Credential Manager (GCM) and git-credential-oauth generate
OAuth credentials [4][5]. Following RFC 6749, the application prints a
link for the user to authorize access in browser. A loopback redirect
communicates the response including access token to the application.

For security, RFC 6749 recommends that OAuth response also includes
expiry date and refresh token [6]. After expiry, applications can use
the refresh token to generate a new access token without user
reauthorization in browser. GitLab and BitBucket set the expiry at two
hours [2][3]. (GitHub doesn't populate expiry or refresh token.)

However the Git credential protocol has no attribute to store the OAuth
refresh token (unrecognised attributes are silently discarded). This
means that the user has to regularly reauthorize the helper in browser.
On a browserless system, this is particularly intrusive, requiring a
second device.

Introduce a new attribute oauth_refresh_token. This is especially
useful when a storage helper and a read-only OAuth helper are configured
together. Recall that `credential fill` calls each helper until it has a
non-expired password.

```
[credential]
	helper = storage  # eg. cache or osxkeychain
	helper = oauth
```

The OAuth helper can use the stored refresh token forwarded by
`credential fill` to generate a fresh access token without opening the
browser. See
https://github.com/hickford/git-credential-oauth/pull/3/files
for an implementation tested with this patch.

Add support for the new attribute to credential-cache. Eventually, I
hope to see support in other popular storage helpers.

Alternatives considered: ask helpers to store all unrecognised
attributes. This seems excessively complex for no obvious gain.
Helpers would also need extra information to distinguish between
confidential and non-confidential attributes.

Workarounds: GCM abuses the helper get/store/erase contract to store the
refresh token during credential *get* as the password for a fictitious
host [7] (I wrote this hack). This workaround is only feasible for a
monolithic helper with its own storage.

[1] https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/
[2] https://docs.gitlab.com/ee/api/oauth2.html#access-git-over-https-with-access-token
[3] https://support.atlassian.com/bitbucket-cloud/docs/use-oauth-on-bitbucket-cloud/#Cloning-a-repository-with-an-access-token
[4] https://github.com/GitCredentialManager/git-credential-manager
[5] https://github.com/hickford/git-credential-oauth
[6] https://datatracker.ietf.org/doc/html/rfc6749#section-5.1
[7] https://github.com/GitCredentialManager/git-credential-manager/blob/66b94e489ad8cc1982836355493e369770b30211/src/shared/GitLab/GitLabHostProvider.cs#L207

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute oauth_refresh_token
    
    A minimal extension to the credential protocol to communicate OAuth
    refresh token. This is worthwhile because OAuth for Git authentication
    is ubiquitous. Current workaround is only feasible for a monolithic
    credential helper, discouraging interoperability between helpers.
    
    Details in commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1394%2Fhickford%2Fcredential-refresh-token-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1394/hickford/credential-refresh-token-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1394

 Documentation/git-credential.txt   |  6 ++++++
 builtin/credential-cache--daemon.c |  3 +++
 credential.c                       |  6 ++++++
 credential.h                       |  1 +
 t/t0300-credentials.sh             | 18 ++++++++++++++++++
 5 files changed, 34 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 29d184ab824..3677d68ce61 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -150,6 +150,12 @@ Git understands the following attributes:
 	When reading credentials from helpers, `git credential fill` ignores expired
 	passwords. Represented as Unix time UTC, seconds since 1970.
 
+`oauth_refresh_token`::
+
+	An OAuth refresh token may accompany a password that is an OAuth access
+	token. Helpers must treat this attribute as confidential like the password
+	attribute. Git itself has no special behaviour for this attribute.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 338058be7f9..f253a8278dc 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -130,6 +130,9 @@ static void serve_one_client(FILE *in, FILE *out)
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
 					e->item.password_expiry_utc);
+			if (e->item.oauth_refresh_token)
+				fprintf(out, "oauth_refresh_token=%s\n",
+					e->item.oauth_refresh_token);
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
diff --git a/credential.c b/credential.c
index f32011343f9..3b5d3d058cf 100644
--- a/credential.c
+++ b/credential.c
@@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	free(c->oauth_refresh_token);
 	string_list_clear(&c->helpers, 0);
 
 	credential_init(c);
@@ -240,6 +241,9 @@ int credential_read(struct credential *c, FILE *fp)
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
 			if (c->password_expiry_utc == 0 || errno == ERANGE)
 				c->password_expiry_utc = TIME_MAX;
+		} else if (!strcmp(key, "oauth_refresh_token")) {
+			free(c->oauth_refresh_token);
+			c->oauth_refresh_token = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -275,6 +279,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_item(fp, "oauth_refresh_token", c->oauth_refresh_token, 0);
 	if (c->password_expiry_utc != TIME_MAX) {
 		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
 		credential_write_item(fp, "password_expiry_utc", s, 0);
@@ -398,6 +403,7 @@ void credential_reject(struct credential *c)
 
 	FREE_AND_NULL(c->username);
 	FREE_AND_NULL(c->password);
+	FREE_AND_NULL(c->oauth_refresh_token);
 	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
 }
diff --git a/credential.h b/credential.h
index 935b28a70f1..b2eda372461 100644
--- a/credential.h
+++ b/credential.h
@@ -126,6 +126,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	char *oauth_refresh_token;
 	timestamp_t password_expiry_utc;
 };
 
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index c66d91e82d8..b49fc14a2bd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -214,6 +214,24 @@ test_expect_success 'credential_approve stores password expiry' '
 	EOF
 '
 
+test_expect_success 'credential_approve stores oauth refresh token' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	oauth_refresh_token=xyzzy
+	--
+	--
+	useless: store
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: oauth_refresh_token=xyzzy
+	EOF
+'
+
 test_expect_success 'do not bother storing password-less credential' '
 	check approve useless <<-\EOF
 	protocol=http

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
