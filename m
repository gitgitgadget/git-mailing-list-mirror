Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067CC6379F
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjARDa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjARDae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4F53B35
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso557517wmq.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tELCOU0LU2YgYDUa6yeAM5xwoAzYpT9GhRqvk/i/2MU=;
        b=Rk2nBMJymouKrs2Bw+X1OQgPwOWB4/se8pWTtAblKcWEzGMkchDFJddTpvA3d6iOsJ
         gGpQ+c9CMxc47bkxlIz5TfJ5ak/AiPWgKHfSDBT8Wkz6b5jimWVR1WjUa78ilX8iAe3u
         xAZWLPhoCMugjxd0VVjCVOk/uLOB79Htenf2rmPHkFyCT7LB6q0Rg9U8qj45YpwcRgdb
         id+UPKkAT+eZ51YqXDVcZAafe0yIZfV2+QdPyAxzuUNwStQWv1IK6vCNkgrRqqghPJww
         yiVO1mJb5vIqJ3uIfGKfx6nDZxo7T98aqzlDZDlLOkqhCBkhw2AXEsTvpR+buYFfUmRQ
         QHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tELCOU0LU2YgYDUa6yeAM5xwoAzYpT9GhRqvk/i/2MU=;
        b=OxRB5vz+QiMV2iBx6HseDsbhG/vX0XlxMlyLB0EqoIvFaBdBWbtVaYm6d1KfPffF2Q
         EIjkjO1jFT+GUCmzUOduqVgn9QYzi6eMax8dYHUsrRS/U3yuSdslQh+m/K4qm8ZIqzh7
         2FANCdtNBu4BNIAKvHVOFVwAbjlH+2D9zY0avbJW9YGWpBQnbrjux1rB9e3oEDk6eevR
         YlYE9v21nNMmpYOnlInJwkx34oLFl2JvxXljfO1XuAiyWFVbq2c68WlhoZPIINKAYIPa
         mUkvIPGCiAJKdjjj/EU8+xf466ey5nACdxM95tpPTlU7XldhglwXW4zCm7mprScIMzGH
         EtGw==
X-Gm-Message-State: AFqh2ko31SkmTsPfx8Z4FxhFZ8w/Z5w1iWI+/64HSaifL2rOenmXQAca
        sjbvfSU3a4dyfizyHVFDCMsiE6zdfwY=
X-Google-Smtp-Source: AMrXdXs/ej6BRR4QqVKGD19nT5lKfaR2a5WtzcQZq4sZ07FMYwVjkzeuB10wa8c60AEybLqAzr4TCw==
X-Received: by 2002:a05:600c:1c1b:b0:3d9:ebf9:7004 with SMTP id j27-20020a05600c1c1b00b003d9ebf97004mr4942621wms.29.1674012627699;
        Tue, 17 Jan 2023 19:30:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a7bc4d6000000b003daffc2ecdesm616811wmk.13.2023.01.17.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:27 -0800 (PST)
Message-Id: <76125cdf239df7bebc63a27099e68e71a8216798.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:14 +0000
Subject: [PATCH v6 09/12] test-http-server: add sending of arbitrary headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add the ability to send arbitrary headers in HTTP responses from the
test-http-server. This is useful when we want to test 'malformed'
response message handling.

Add the following option to the server auth config file:

[auth]
	extraHeader = [<value>]*

Each `auth.extraHeader` value will be appended to the response headers
verbatim.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-http-server.c | 6 ++++++
 t/t5556-http-auth.sh        | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 691fbfb51d6..cbaee4fc0f4 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -388,6 +388,7 @@ static int allow_anonymous;
 static struct auth_module **auth_modules = NULL;
 static size_t auth_modules_nr = 0;
 static size_t auth_modules_alloc = 0;
+static struct strvec extra_headers = STRVEC_INIT;
 
 static struct auth_module *get_auth_module(const char *scheme, int create)
 {
@@ -489,6 +490,9 @@ done:
 			string_list_append(&hdrs, challenge);
 		}
 
+		for (i = 0; i < extra_headers.nr; i++)
+			string_list_append(&hdrs, extra_headers.v[i]);
+
 		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
 				      &hdrs, *wr);
 	}
@@ -557,6 +561,8 @@ static int read_auth_config(const char *name, const char *val, void *data)
 			string_list_clear(mod->tokens, 1);
 	} else if (!strcmp(name, "auth.allowanonymous")) {
 		allow_anonymous = git_config_bool(name, val);
+	} else if (!strcmp(name, "auth.extraheader")) {
+		strvec_push(&extra_headers, val);
 	} else {
 		warning("unknown auth config '%s'", name);
 	}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index cb5562a41bf..e36107ea95d 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -112,6 +112,10 @@ test_expect_success CURL 'http auth server auth config' '
 		token = reset-tokens:the-only-valid-one
 
 		allowAnonymous = false
+
+		extraHeader = X-Extra-Header: abc
+		extraHeader = X-Extra-Header: 123
+		extraHeader = X-Another: header\twith\twhitespace!
 	EOF
 
 	cat >OUT.expected <<-EOF &&
@@ -119,6 +123,9 @@ test_expect_success CURL 'http auth server auth config' '
 	WWW-Authenticate: with-params foo="replaced" q=1
 	WWW-Authenticate: no-explicit-challenge
 	WWW-Authenticate: reset-tokens
+	X-Extra-Header: abc
+	X-Extra-Header: 123
+	X-Another: header	with	whitespace!
 
 	Error: 401 Unauthorized
 	EOF
-- 
gitgitgadget

