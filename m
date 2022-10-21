Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E4FA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJURIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJURIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A93027D4C6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so5898365wrb.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkxtgP/J3nLS9pfMEEWqqmQ9TtoIhKkytBuFPBUtbV4=;
        b=oSQUUmZuOm/zxi9UZBaUkKxP+T7NXFka+uNlPWz8o/EKaGVbZIO0k63Kumcyplgir3
         GZLU83AXk2uJnbEdNT+koFD/FC7Toq9by7ChjCLiwRc7uX1Ub2fVaDu8ldaC5vWCIwEf
         kfw7Xv2fYp3ikXwf//vqwBEEAT9vstbOsqGLVpGicR5WP6zOf9lIONmOj/xRYg/IaTqx
         YwlwWFjKtlts590G/YcwGjqoSjIWpnd/R5jjFziRioQfk8tEZhrselNA4Zzw2Rw/Zpgs
         9FrcBKI20TTnRf7llnbcTS6Wjvh4FnLm7yBlD4MNFe+XpWB03CXYyfLeZzX1aOu+BVkE
         fQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkxtgP/J3nLS9pfMEEWqqmQ9TtoIhKkytBuFPBUtbV4=;
        b=vjOf4pBvIPHv+uXbjguHEYMLk5cNxlnIDhEXiy3mVyKsPcS9ApklYeeYhaBRWQqfPf
         HryvGgCK6E5wEZhvUpvubUOwlCbHjydRKIqQr3CwULs7WCTnJrILinBWc2TfnX/V9VBM
         oH3eEEu+HUd0YXWeG9N/s4TZ2U0jub1IGuIft2FA+XBWTApPzS3N1Gvn0tZHjc3TW5w/
         GyWs4by17s3DqDgdjihV08fMAdxO0Aas3k72RWUZFZNgy41WCmjmdkg0Xipo5c9Il3r3
         cQQhnWU0V0H+nfGZ3LGBCMOvBhD+qoGSzNqQCweNrjE056cgnXcTuKchLNMmlhsYiCa8
         4vxA==
X-Gm-Message-State: ACrzQf0IXBCRT81MT5I18ttXKCBZmDk4/7ALoEKiBsHsazSz/uKoiSit
        CgjH0VvncnBjSkazgD4uj0M6Oh9TAtw=
X-Google-Smtp-Source: AMsMyM7ebDDJDTbx25ZOI3TGB2NSIBSpapnBzRqI4C16S4xGpCfQubeL4qK0RZuUUfnioYzUOwpP7w==
X-Received: by 2002:adf:e7c9:0:b0:22e:3524:9b4b with SMTP id e9-20020adfe7c9000000b0022e35249b4bmr12586678wrn.520.1666372090490;
        Fri, 21 Oct 2022 10:08:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003b4ff30e566sm10134392wms.3.2022.10.21.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:09 -0700 (PDT)
Message-Id: <0838d992744a4b06523be6df0edb046ebba033ee.1666372083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
        <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:07:59 +0000
Subject: [PATCH v2 2/6] credential: add WWW-Authenticate header to cred
 requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add the value of the WWW-Authenticate response header to credential
requests. Credential helpers that understand and support HTTP
authentication and authorization can use this standard header (RFC 2616
Section 14.47 [1]) to generate valid credentials.

WWW-Authenticate headers can contain information pertaining to the
authority, authentication mechanism, or extra parameters/scopes that are
required.

The current I/O format for credential helpers only allows for unique
names for properties/attributes, so in order to transmit multiple header
values (with a specific order) we introduce a new convention whereby a
C-style array syntax is used in the property name to denote multiple
ordered values for the same property.

In this case we send multiple `wwwauth[n]` properties where `n` is a
zero-indexed number, reflecting the order the WWW-Authenticate headers
appeared in the HTTP response.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  9 +++++++++
 credential.c                     | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f5..0ff3cbc25b9 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -160,6 +160,15 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[]`::
+
+	When an HTTP response is received that includes one or more
+	'WWW-Authenticate' authentication headers, these can be passed to Git
+	(and subsequent credential helpers) with these attributes.
+	Each 'WWW-Authenticate' header value should be passed as a separate
+	attribute 'wwwauth[]' where the order of the attributes is the same
+	as they appear in the HTTP response.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential.c b/credential.c
index 897b4679333..8a3ad6c0ae2 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	int i = 0;
+	const char *full_key = xstrfmt("%s[]", key);
+	for (; i < vec->nr; i++) {
+		credential_write_item(fp, full_key, vec->v[i], 0);
+	}
+	free((void*)full_key);
+}
+
 void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol, 1);
@@ -270,6 +281,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
 static int run_credential_helper(struct credential *c,
-- 
gitgitgadget

