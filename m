Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A9221264
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525140; cv=none; b=Dm0kGBAv9KsxBtzvoBIfMVtMkdIh+wLMcziiuoc0bETBvccCF8XUYOFTQfb3C68UALavJix7VXUr6zK4qm71bzBTWXVj9kQx1SSKmzj+plHj17RxD0oBU1XT+ITFFiUKJd74kdB2ps4Nr9jurUTZIz3A28Hk8RNN10BTl8AfA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525140; c=relaxed/simple;
	bh=jyKdzgnGa4wiwrw5HcHZzMyu0spPuI8LZYIhAVKedfk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PBKIsKzhh3km3Rrsq0blKuNWAlGWPUSRSzilhAMLLZJKdFMR7m9qbEYO5rQCf4oELYSaHxq9VhS0xuVsbH/xn+KQiYCTGCOnXjN4aVO6WbgFvWDbUXOLVt1uPNosJsM7BcJL2KFnmeGe2W5XQ760jtgYb/D+cYp1Gi0RDp5TapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcPKo0xu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcPKo0xu"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso108778839f.0
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759525136; x=1760129936; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFdv0cHgOZtkdYU1HsK3ruUFD4odEC7vFeqQKe3SyeU=;
        b=TcPKo0xuFeqzNPDV1xuZJB25ScfpOUuZjIhM9cBOxMeSnu7jL9skHeQO0JjyAw4PBv
         lNzFIOuikDSGO0tYmTOv5MSI20miVwprLUA1BEPWsnIGphdVEvPWFj/wuhvAmyJ6sP8x
         yLYjW8i3Skx0uStpFO+RVdXwJjRp6xfDmr9P1CZMBlaoR8WkvKdCFOq4GNg5CMdN7IMq
         p7xu45H2lS3bRVRw8t3XIDplhlT/te16WSDPGpI6pKx9YMQypdb7jit50EOcNNvrBV2x
         hANiyBTzCxQ7xaiX0EuCPjMK8pRGMzFtMI/WnJCGqP2GudAGIRnE+g0EfuXJ0XRokR0w
         qu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759525136; x=1760129936;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFdv0cHgOZtkdYU1HsK3ruUFD4odEC7vFeqQKe3SyeU=;
        b=FhDYRtymjAabQbjOT8JkmAx9H7fDcTNvTfQVQtwuS7LuXqaYVcyRLGfnUDmx35iFGE
         REaHSioU0wvJDMjuvG0jKmnLh9h/0PmiRTndNSA2fp/okBvwz0jzp4xSjR/EBKyvL3ah
         esLJp+WnqxhiIQQdBV3YwLrEMToh/0wqmi/PneKKpM5Ftdu3hI5BxwXbFRSAHkXsmxPE
         Jp0H/p6rEspmWZTmnaP8JIoL31tW8QOA3hC7ixAQZDsH4aPDgrI1NQY+IC6zfUrMzAfT
         KHzB5y4WZhn8XjeuLVgRgbaNFvJkjHJn6HCiLqhywa+NOeaV4vNT8sNe8SofVkP3sC++
         IymQ==
X-Gm-Message-State: AOJu0Yy9AAhBQsjsrfduzadJbaKG1TtMn+SNdztYzIPhovere6IT+DzE
	I7R6DX/0sfQTLL3nbTQuGXfYd/66NYA7QCUucqDOpuSXv3daLAE+rrY6D0+MDg==
X-Gm-Gg: ASbGnctFb9f9sFs5sTwo5cQAc/yVpMc+5V0qtF733+XWAJQryDyhx3bIMQQcHhICqhE
	h1YwqsIBKFK5w8aVCkflVWScuzrVXuS7pAdjAIKTqja+m/QzbgRDAbs7pJk5qf2WGCX+0eWmug9
	oJtfex0ZoTBcccXY7t2A1pnujLpwzhO2xBi8fXXvRg7uZjSGziFXKq0vXWuxGNFtV7NV4+PTflo
	zcC86UI5C3GPV6lMJjzBMzbHXw+PsdLAVgoFZ6vsGIRuYQjHcGpfT/lraMKfBCWpAze82+NMA+1
	OGOHlQdeHusVNLM5Gjm+8IWreUWGimRk+kUzoakelb9qwdKXzOLlunADJQ/6vwMO64dLu/sWlT7
	Jnrg4yUT5jZ6n2/icQ0d4eh4kfz1QvKTQRxKmzE/pu6oFyND6vak=
X-Google-Smtp-Source: AGHT+IEgHaZQ34YNgrL5LRS3JyDfmW2GOBL4K/h5sgz1/HtUQ0r5uTINAaFeJ+iQMWHqNJq/uKNkqg==
X-Received: by 2002:a05:6e02:1fe9:b0:425:7466:624d with SMTP id e9e14a558f8ab-42e7ada91abmr57026325ab.26.1759525136294;
        Fri, 03 Oct 2025 13:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f05c4578esm9911895ab.22.2025.10.03.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:58:55 -0700 (PDT)
Message-Id: <pull.1979.v2.git.1759525133638.gitgitgadget@gmail.com>
In-Reply-To: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
References: <pull.1979.git.1759352209657.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Oct 2025 20:58:53 +0000
Subject: [PATCH v2] docs/gitcredentials: describe URL prefix matching
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
Cc: sandals@crustytoothpaste.net,
    Johannes.Schindelin@gmx.de,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Documentation was inaccurate since 9a121b0d226 (credential: handle
`credential.<partial-URL>.<key>` again, 2020-04-24)

Add tests for documented behaviour.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    docs/gitcredentials: describe URL prefix matching

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1979%2Fhickford%2Furl-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1979/hickford/url-prefix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1979

Range-diff vs v1:

 1:  15f44a2ac5 ! 1:  4b64cf47e9 docs/gitcredentials: describe URL prefix matching
     @@ Documentation/gitcredentials.adoc: match: Git compares the protocols exactly.  H
      -entry for `https://example.com`) but will not match a config entry for
      -`https://example.com/bar`.
      +If the "pattern" URL does include a path component, then this must match
     -+as a prefix path: the context `https://example.com/bar` will match a config
     ++as a path prefix: the context `https://example.com/bar` will match a config
      +entry for `https://example.com/bar/baz.git` but will not match a config entry for
      +`https://example.com/other/repo.git` or `https://example.com/barry/repo.git`
     -+(even though it is a string prefix).
     ++(even though it is a string prefix). To match as a prefix, the pattern
     ++must include protocol and host.
       
       
       CONFIGURATION OPTIONS


 Documentation/gitcredentials.adoc | 16 ++++++++--------
 t/t0300-credentials.sh            | 19 +++++++++++++++----
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..bf595f7918 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -150,9 +150,8 @@ pattern in the config file. For example, if you have this in your config file:
 	username = foo
 --------------------------------------
 
-then we will match: both protocols are the same, both hosts are the same, and
-the "pattern" URL does not care about the path component at all. However, this
-context would not match:
+then we will match: both protocols are the same and both hosts are the same.
+However, this context would not match:
 
 --------------------------------------
 [credential "https://kernel.org"]
@@ -166,11 +165,12 @@ match: Git compares the protocols exactly.  However, you may use wildcards in
 the domain name and other pattern matching techniques as with the `http.<URL>.*`
 options.
 
-If the "pattern" URL does include a path component, then this too must match
-exactly: the context `https://example.com/bar/baz.git` will match a config
-entry for `https://example.com/bar/baz.git` (in addition to matching the config
-entry for `https://example.com`) but will not match a config entry for
-`https://example.com/bar`.
+If the "pattern" URL does include a path component, then this must match
+as a path prefix: the context `https://example.com/bar` will match a config
+entry for `https://example.com/bar/baz.git` but will not match a config entry for
+`https://example.com/other/repo.git` or `https://example.com/barry/repo.git`
+(even though it is a string prefix). To match as a prefix, the pattern
+must include protocol and host.
 
 
 CONFIGURATION OPTIONS
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index cb3a85c7ff..07aa834d33 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -991,18 +991,24 @@ test_expect_success 'url parser not confused by encoded markers' '
 
 test_expect_success 'credential config with partial URLs' '
 	echo "echo password=yep" | write_script git-credential-yep &&
-	test_write_lines url=https://user@example.com/repo.git >stdin &&
+	test_write_lines url=https://user@example.com/org/repo.git >stdin &&
 	for partial in \
 		example.com \
+		example.com/org/repo.git \
 		user@example.com \
+		user@example.com/org/repo.git \
 		https:// \
 		https://example.com \
 		https://example.com/ \
+		https://example.com/org \
+		https://example.com/org/ \
+		https://example.com/org/repo.git \
 		https://user@example.com \
 		https://user@example.com/ \
-		https://example.com/repo.git \
-		https://user@example.com/repo.git \
-		/repo.git
+		https://user@example.com/org \
+		https://user@example.com/org/ \
+		https://user@example.com/org/repo.git \
+		/org/repo.git
 	do
 		git -c credential.$partial.helper=yep \
 			credential fill <stdin >stdout &&
@@ -1012,7 +1018,12 @@ test_expect_success 'credential config with partial URLs' '
 
 	for partial in \
 		dont.use.this \
+		example.com/o \
+		user@example.com/o \
 		http:// \
+		https://example.com/o \
+		https://user@example.com/o \
+		/o \
 		/repo
 	do
 		git -c credential.$partial.helper=yep \

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
gitgitgadget
