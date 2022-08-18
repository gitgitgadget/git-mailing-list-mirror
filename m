Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B4C32772
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbiHROBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiHROAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:00:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CA3ECC2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs25so1857634wrb.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=JlZa0FOPBw4Xko/UZWGVepdvr2a7qdmgPSsQ3XWxujo=;
        b=ksioRrS56IIUJzFkwx9aRnDq+9EqsQX9bafIXegiaa60REFrRY0nADNw3aijqzh1Z9
         XblOaGEmA+SLV54/z1J0ugki4BaRcV1Qf8qqUW+o8H8lZq+wfp6EZvKrhwARFiMA+EVQ
         iFDUEl51Cg9iNG98sl1l6B0PDC8511z29+0NFqIfHf776Rz7l6VbKwKMr26aKXlW4f1a
         1haAWhRVTcP3QOu+Ob0SwpgwguwYlD+/rM0l9KDqCFZhfDSIYDCHSEZX0r2i0mfq72DJ
         9Tjoemrl7asLxJnxqy1pYws6yXjj1ex+Crl29WGxFRad1d/JywI8E9cd330VL6DT1S7Y
         ibPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=JlZa0FOPBw4Xko/UZWGVepdvr2a7qdmgPSsQ3XWxujo=;
        b=FB9dQ2oFlealchkvwzwN+RxQNtwBqbFtUzXGrteTHDyzdXFVGXGJ4h3tdTQpYubTh7
         97PnPT0/+R5WKD0ihbPRNmwcgAKvjYW8b6Q3lu07ToyEK2UbqyVJ6sHC6wea6gRPVQJt
         d+punXOoN0UyLrMiBXTplzQkYA1AbdhUIrrkkYcL2Zri931gxjuOcvCkb5uopl8tocVc
         20fuaBZRGkuB0jwYbHk9O4pNtD6F+4mq7aBkI4zTfi0DH1FXlkzElGtE69qAJMftrZwF
         dQTxQ1YR5Jkf4jbNft48ahUxieFUldzchaDGGhKFMBkFgI6xvNB8VaUwhYUSwbhETNJM
         wdxg==
X-Gm-Message-State: ACgBeo2PYF3agQ9n1yXFieoUAXiCyJgE6nHihC2Ywuu6Dj4JgWdakIig
        ugptR+BhMOGsGVdFb3wFEJw4iY3aJn8=
X-Google-Smtp-Source: AA6agR4lewKNl51SvQdYcWaB7SsBrpzHCL9ZlwPVq6J47q3TOwt3DSa/qgpQmTu+D94y8Lk9SN30lg==
X-Received: by 2002:a5d:5690:0:b0:225:49e:48c1 with SMTP id f16-20020a5d5690000000b00225049e48c1mr1700145wrv.552.1660831234484;
        Thu, 18 Aug 2022 07:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b0021e4bc9edbfsm1509643wrm.112.2022.08.18.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:00:34 -0700 (PDT)
Message-Id: <c48fbf984ea42e7c13d56db015dc63c2495f5f5f.1660831231.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
From:   "Sergio via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 14:00:30 +0000
Subject: [PATCH 1/2] Make rebase.autostash default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sergei Krivonos <sergeikrivonos@gmail.com>,
        Sergio <sergeikrivonos@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergio <sergeikrivonos@gmail.com>

Signed-off-by: Sergio <sergeikrivonos@gmail.com>
---
 Documentation/config/rebase.txt | 2 +-
 builtin/pull.c                  | 2 +-
 config.c                        | 8 ++++++++
 config.h                        | 8 ++++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f19bd0e0407..bc952327140 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -19,7 +19,7 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	This option can be overridden by the `--no-autostash` and
 	`--autostash` options of linkgit:git-rebase[1].
-	Defaults to false.
+	Defaults to true.
 
 rebase.updateRefs::
 	If set to true enable `--update-refs` option by default.
diff --git a/builtin/pull.c b/builtin/pull.c
index 403a24d7ca6..333d6a232a7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -362,7 +362,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 	int status;
 
 	if (!strcmp(var, "rebase.autostash")) {
-		config_autostash = git_config_bool(var, value);
+		config_autostash = git_config_bool_or_default(var, value, 1);
 		return 0;
 	} else if (!strcmp(var, "submodule.recurse")) {
 		recurse_submodules = git_config_bool(var, value) ?
diff --git a/config.c b/config.c
index e8ebef77d5c..c4f6da3547e 100644
--- a/config.c
+++ b/config.c
@@ -1437,6 +1437,14 @@ int git_config_bool(const char *name, const char *value)
 	return v;
 }
 
+int git_config_bool_or_default(const char *name, const char *value, int default_value)
+{
+	int v = git_parse_maybe_bool(value);
+	if (v < 0)
+		v = default_value;
+	return v;
+}
+
 int git_config_string(const char **dest, const char *var, const char *value)
 {
 	if (!value)
diff --git a/config.h b/config.h
index ca994d77147..d236bb0a326 100644
--- a/config.h
+++ b/config.h
@@ -242,6 +242,14 @@ int git_config_bool_or_int(const char *, const char *, int *);
  */
 int git_config_bool(const char *, const char *);
 
+/**
+ * Parse a string into a boolean value, respecting keywords like "true" and
+ * "false". Integer values are converted into true/false values (when they
+ * are non-zero or zero, respectively). Other values results in default. If
+ * parsing is successful, the return value is the result.
+ */
+int git_config_bool_or_default(const char *, const char *, int);
+
 /**
  * Allocates and copies the value string into the `dest` parameter; if no
  * string is given, prints an error message and returns -1.
-- 
gitgitgadget

