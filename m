Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E2AC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiHBMaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiHBM3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7751422
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso924860wms.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8JreIyzcEq7/uAXxPzoccFoQb6CoOWKqrR+In2Ko/0=;
        b=ZjwkQrPTwsTqCVY6AoX+y7xyXwLToHPKn1+gXlg22sWO2wAJYJpUURUcUj8GdarqlV
         wgyLzOnpwB1xTekz1Hdsbp7E2dSC3LmouWW8oQaqNUXsyiUYZhJWFo6uivMWaU3tfTiA
         fQSfOyHmr+sUqhSSjttwocANoCLQ8LEPc5gV5KM9Ob7/7Gbc6axyJ6u3VGQOaJlarIKz
         SdF8aGEoXAQj1/dbFdtYFo9vLI2AF9/MdMt0dR8tKioEi0V9C9+TFS1ATdKPzlUIrL+h
         VDiMKFZc9d3yaTkj24VV7NgWCZO5bvffpWYIX10c5KvQWoLvVNtK32k174IknHw3wstm
         A+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G8JreIyzcEq7/uAXxPzoccFoQb6CoOWKqrR+In2Ko/0=;
        b=aSO3vTzIcFt5wrTIGk1SnbSgD1bpeQdCFBOfSJxMOGDYzZtjECNGmLEzZ2ObS7YbHN
         ej2nIFSi9kVtqJtxIPivNTS2WnPSuTD8cGItxzyNDkeGmML7V83PQuRvcGJdQ+mC3HSF
         rsAruxfZvrBxQVbdh7JM3OxKPsbUoY+rc0UGKnA5HAkQuepQ21rucO+h3xTcHDnVQpF9
         vvFrCCKo/sxdy+wco4YMmJwvC79xpArkoHXK8XOrtp94HpFeeXF4OcaTWtdA1QvxqPMb
         /F8zMnjc7ZgDnaCSAQjXTD7EIbp/87i1/PhyZuvXjGv045mYU6U8/HUhHVxR9kH6D5xy
         X96w==
X-Gm-Message-State: AJIora+CbKHnVHpe5TWms7ewpRHlYN2BoTM10PQt8dRcFFzsmpUN4aGZ
        vPGelARKwZ1NOQY1UDdeeCcTXVLDI2w=
X-Google-Smtp-Source: AGRyM1taZAaW62Zu0UCSk3C2/UbUerDekUEkXJ6LDIqzWYV9L5dgWXD3BKt8ZDG+nRVz6+YG4AUPJA==
X-Received: by 2002:a05:600c:4113:b0:3a3:4b67:d086 with SMTP id j19-20020a05600c411300b003a34b67d086mr13975832wmi.20.1659443391576;
        Tue, 02 Aug 2022 05:29:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d50d2000000b0021e9fafa601sm14990033wrt.22.2022.08.02.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:51 -0700 (PDT)
Message-Id: <acee1fae0274306790fe1a6b0ae8eb2ed04ec32a.1659443384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:44 +0000
Subject: [PATCH v2 5/5] clone: --bundle-uri cannot be combined with --depth
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change added the '--bundle-uri' option, but did not check
if the --depth parameter was included. Since bundles are not compatible
with shallow clones, provide an error message to the user who is
attempting this combination.

I am leaving this as its own change, separate from the one that
implements '--bundle-uri', because this is more of an advisory for the
user. There is nothing wrong with bootstrapping with bundles and then
fetching a shallow clone. However, that is likely going to involve too
much work for the client _and_ the server. The client will download all
of this bundle information containing the full history of the
repository only to ignore most of it. The server will get a shallow
fetch request, but with a list of haves that might cause a more painful
computation of that shallow pack-file.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-clone.txt | 3 ++-
 builtin/clone.c             | 3 +++
 t/t5606-clone-options.sh    | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 60fedf7eb5e..d032d971dd7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -327,7 +327,8 @@ or `--mirror` is given)
 	Before fetching from the remote, fetch a bundle from the given
 	`<uri>` and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
-	namespace.
+	namespace. This option is incompatible with `--depth`,
+	`--shallow-since`, and `--shallow-exclude`.
 
 :git-clone: 1
 include::urls.txt[]
diff --git a/builtin/clone.c b/builtin/clone.c
index 4224d562758..4463789680b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -937,6 +937,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (bundle_uri && deepen)
+		die(_("--bundle-uri is incompatible with --depth, --shallow-since, and --shallow-exclude"));
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 8f676d6b0c0..f6bb02ab947 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -58,6 +58,14 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'disallows --bundle-uri with shallow options' '
+	for option in --depth=1 --shallow-since=01-01-2000 --shallow-exclude=HEAD
+	do
+		test_must_fail git clone --bundle-uri=bundle $option from to 2>err &&
+		grep "bundle-uri is incompatible" err || return 1
+	done
+'
+
 test_expect_success 'reject cloning shallow repository' '
 	test_when_finished "rm -rf repo" &&
 	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
-- 
gitgitgadget
