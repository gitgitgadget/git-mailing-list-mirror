Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D137BC27C76
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjATWJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjATWJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA168A5CDA
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b7so6019124wrt.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTWpx0WyAIrrtseRIMjsPnNsN9rcivimHrEZq2BXS9w=;
        b=a8Db2/tCoOQQmy3GOI2Q7m6PWFjHUxweBarHo57ld+r1va6w5aQRZlp4hcejaHILLH
         7jeCTzH7IybQt7Xa1+0W04Av3ubtGA54do8YL2G/oRAUn5nLlLqhgWrRhJ6q/l34Zn1I
         GEyYCERVmZ1ZBAqlTM7jq3v3A9K1/jSalvo0mqrrZuQ6Kn0OqtLmn4JBiCp9dvkU1TK7
         s3Og7RulZu4i3ozzwi8Ns5Qb2BtC43R8n6VueibkMIzBfVawRu/bnT/kjyPzfcpsRE3V
         BSdXqOyutnMGv/YGf1DI3TFdQG9ICTssSi50S5A4XSnVGgVcxb6vOviMoVjvpmtsOZ75
         aE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTWpx0WyAIrrtseRIMjsPnNsN9rcivimHrEZq2BXS9w=;
        b=ewppDQqoNTT+V0gQMdQ4K/tELNrpp9xBYKaFuGE97LFvCgn6Eyga1iGZGVvqDkE8No
         WPRArcH3RdAZW3RzR/IXF0Tr2FtV933HA/HAoiyXeWBiCaEw0uRuF6Xk4OdkeNC3UPn0
         Giv6slbFGY5lJ5md4EDfOodzqA+CHrqXFRo0w15AwBSCYYGbGabiw7O0jqXXvt+nfhOG
         bxYZI+1JUrHNF3563b6Lhb7OdL78DH8Znk27ZxMbnUIZai6+1k1wh+fqd+tuAYehmWj8
         bU8a/X35FxvZ2G01vGJeMWJ8FToy49W4vSGek2T8KoGkpxWZ5Hpd3xK1Wiv9XBB4al04
         euZA==
X-Gm-Message-State: AFqh2kp1xlU8d0VIa7+4HywtN6NoLypfniIImSommldlqFoXG4jQzEj5
        3mjLa+7yC7sM1PJaLWIPUJciyrSibUU=
X-Google-Smtp-Source: AMrXdXtTx2w/hu6jS4FUj7ZM+hRqIfirpFAR/eGvz3uB6qNH2m6VmW3ZTHfexLwbASd4z+RSYRgNig==
X-Received: by 2002:a5d:4f90:0:b0:2bd:d542:e01e with SMTP id d16-20020a5d4f90000000b002bdd542e01emr14604620wru.10.1674252540184;
        Fri, 20 Jan 2023 14:09:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm36752818wrj.2.2023.01.20.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:59 -0800 (PST)
Message-Id: <2f97c94f67981dcfbbed00a9800cec4cd26c594d.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:47 +0000
Subject: [PATCH v7 09/12] test-http-server: add sending of arbitrary headers
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
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
index 72c6cca7e5c..70bf15c3fa1 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -417,6 +417,7 @@ static int allow_anonymous;
 static struct auth_module **auth_modules = NULL;
 static size_t auth_modules_nr = 0;
 static size_t auth_modules_alloc = 0;
+static struct strvec extra_headers = STRVEC_INIT;
 
 static struct auth_module *get_auth_module(const char *scheme, int create)
 {
@@ -520,6 +521,9 @@ done:
 			string_list_append(&hdrs, challenge);
 		}
 
+		for (i = 0; i < extra_headers.nr; i++)
+			string_list_append(&hdrs, extra_headers.v[i]);
+
 		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
 				      &hdrs, *wr);
 	}
@@ -585,6 +589,8 @@ static int read_auth_config(const char *name, const char *val, void *data)
 			string_list_clear(mod->tokens, 1);
 	} else if (!strcmp(name, "auth.allowanonymous")) {
 		allow_anonymous = git_config_bool(name, val);
+	} else if (!strcmp(name, "auth.extraheader")) {
+		strvec_push(&extra_headers, val);
 	} else {
 		warning("unknown auth config '%s'", name);
 	}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index 20fd9b09aef..2c16c8f72a5 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -178,6 +178,10 @@ test_expect_success CURL 'http auth server auth config' '
 		token = reset-tokens:the-only-valid-one
 
 		allowAnonymous = false
+
+		extraHeader = X-Extra-Header: abc
+		extraHeader = X-Extra-Header: 123
+		extraHeader = X-Another: header\twith\twhitespace!
 	EOF
 
 	cat >OUT.expected <<-EOF &&
@@ -185,6 +189,9 @@ test_expect_success CURL 'http auth server auth config' '
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

