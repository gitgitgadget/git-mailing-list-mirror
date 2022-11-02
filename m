Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40196C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKBWJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBWJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABF2BC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so231089wrq.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekv8BwlEx82o86H7pDNJe1k3otaqpfti4VGo52hs/FQ=;
        b=SslQl4/kOlUD4tA4M3oDLRNcc3EGDRVA1h+zKW35tit+nnl4sup/EfIYuG4+CFVJd0
         V9Yg2jWJnqQ9voD3d4VbLT+CiKG1tpzc4huIrc5+dEvAFxxHzjnwBCd6IgbzOk4owPzi
         IhSdPB0ZxGj5+ANt0EzXgf/61yqYa0bx45Gd4QYRJZ4fDD/+A1ZaezG/sHy3s7R9vU4J
         pR9SyXeBCiOzPprrwYXD4mzCjCkxY+RW6M46Shf1T7w9i1KY5T13SxgzSkfC3mqwSYod
         3ouTlsvsH+i8cQuMDS/gQeRpJRo9ktrM3KGQMC3lRH+AjqSTTiXj4iosIqFUNQFHUua7
         +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekv8BwlEx82o86H7pDNJe1k3otaqpfti4VGo52hs/FQ=;
        b=tQ+rWMyTzx7GbbTgrM3hPt4Is+6kB9SFciW3JlwUFqBFCYrNyPTePM8Y5T5OGOPxAq
         so3V33MEmJa83dPPH7jccyjMx4uVSwddOBQSasJpraFzyOmFbzMwiRU4HSGaNG9vyTaG
         MgkgPGrTu5vzBv0Y7i7emhDlXRXGP0elPz2pQHDV2fkHnZctsRt0G89r5pTHKZo8CXjn
         AtczjIZyUGyCQTzrY/ze5rFgH7/13uGLBG0IF5d4bhLe3qStfjX9YP7//+j1Uc2I7S7d
         DrZFrbF3NGJW3goAFqDysQzx1ofW/5UjMO8Ienyske1ZVHgcNKb4WUxrlxjr8xZxesgr
         gmlQ==
X-Gm-Message-State: ACrzQf0LnqcLVgJBtM2Ur+vcQWm6lkMlsiYQ0Y4c58OuiY0FE2Mpvh3z
        u7geOl8oJykSKeWKGvpwaYGOwX8T7AY=
X-Google-Smtp-Source: AMsMyM66FYSAsAussov0Jq3KkqNTRf3tVuRIDl89eNcrFeWhqq+hZaIcavXO/rLKbBK97xxm+hvumQ==
X-Received: by 2002:adf:de8e:0:b0:236:ea40:47ef with SMTP id w14-20020adfde8e000000b00236ea4047efmr5726805wrl.519.1667426974234;
        Wed, 02 Nov 2022 15:09:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003c6f3e5ba42sm3141611wmb.46.2022.11.02.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:33 -0700 (PDT)
Message-Id: <e45e23406a5e1609a36375acf9cb36ac6efc2dd6.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:20 +0000
Subject: [PATCH v3 02/11] credential: add WWW-Authenticate header to cred
 requests
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

In this case we send multiple `wwwauth[]` properties where the order
that the repeated attributes appear in the conversation reflects the
order that the WWW-Authenticate headers appeared in the HTTP response.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt | 17 ++++++++++++++++-
 credential.c                     | 12 ++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f5..791a57dddfb 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -113,7 +113,13 @@ separated by an `=` (equals) sign, followed by a newline.
 The key may contain any bytes except `=`, newline, or NUL. The value may
 contain any bytes except newline or NUL.
 
-In both cases, all bytes are treated as-is (i.e., there is no quoting,
+Attributes with keys that end with C-style array brackets `[]` can have
+multiple values. Each instance of a multi-valued attribute forms an
+ordered list of values - the order of the repeated attributes defines
+the order of the values. An empty multi-valued attribute (`key[]=\n`)
+acts to clear any previous entries and reset the list.
+
+In all cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
 attributes is terminated by a blank line or end-of-file.
 
@@ -160,6 +166,15 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[]`::
+
+	When an HTTP response is received by Git that includes one or more
+	'WWW-Authenticate' authentication headers, these will be passed by Git
+	to credential helpers.
+	Each 'WWW-Authenticate' header value is passed as a multi-valued
+	attribute 'wwwauth[]', where the order of the attributes is the same as
+	they appear in the HTTP response.
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

