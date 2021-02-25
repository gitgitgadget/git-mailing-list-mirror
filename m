Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F36C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BB664F21
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBYSRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhBYSRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:17:46 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104AC061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:17:05 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 2so3250825qvd.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44pGx7Fe1pQt8fhf+nxXjaiyqjlCa/w62g8WI8VQHhQ=;
        b=ldAKI+Ej1hTPOLNoh5TPWDxrwelyiT6rGqnYsZt/3Q9sToy3H/ZYKXFfAQudkq2ydu
         eK4M36LrAK/cSBqKoc/9MmYJ3d8QomF3n/at1Xhaw+QuJS1w2qcfLdI6TzqA0yM4tN7P
         oo88SzaNQZ2gg+Tz1kOhbvnaZE8qs7apj3FfuPMWjRDCmLckyHxcnRP7oohyfkZWEZ6C
         g+KLrXAsWTaIJFf3JaPwIRQ3SqWqyP6vgm4t+28Awp3vZQIKGXsfrEtIoPs6tpA6t184
         Eh5yjIzdOmRca4tMqUOsNBZ7gKCoFB+78ad2lwqaqU3hq+ojEAn/ZaQNmDyw7uHFL7m+
         Dkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44pGx7Fe1pQt8fhf+nxXjaiyqjlCa/w62g8WI8VQHhQ=;
        b=BXIxZyJqUX6NHJMlbONU2fnZuRY+tMjVEyC1tbowjBj3GZHH7aAHPZth9SSMi+DLoU
         NOxkyWPjTLIUFt/KFrf6AHfWURmQ87Inu2E1Qx63anoFrW/NztB/Wo9io7/Igk9UtAak
         htS+vqMQO/gDKAyAyKzhytV3dPXyVpuObvtxaEQvydZWrWgXczLj07Awm4qPaiV5XwAT
         Nc2eENwnvqfRO9Q6PmO/s1CcJwTHzjDf+yQZInFlPFQbKy/+yHAj8RoCpoTJifHQ1bre
         ZmwOFszMXzX0jMNux1nCzDJ4zBLvu3TsWoR3bw7a97vRHGVbLwNRu9G5WsY7QHevoKvh
         VaVg==
X-Gm-Message-State: AOAM533iLE6d4smw/njGsL9cwkzGTZNA7GJf0EuvN58CGurUDejjX8qG
        o9ENOOKIx2l9bukZntJOapRGMWbGUcKphg==
X-Google-Smtp-Source: ABdhPJxpUBb0DDTL22vMZJ83dk3oPjSoYvaUQzIoNGJs7qVrqmUG5FjBFHcOs+Gu3LOGdKSdcQ6+dg==
X-Received: by 2002:a0c:b92c:: with SMTP id u44mr3940100qvf.34.1614277023883;
        Thu, 25 Feb 2021 10:17:03 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id r7sm4063291qtd.49.2021.02.25.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:17:03 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] convert: fail gracefully upon missing clean cmd on required filter
Date:   Thu, 25 Feb 2021 15:16:56 -0300
Message-Id: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitattributes documentation mentions that either the clean cmd or
the smudge cmd can be left unspecified in a filter definition. However,
when the filter is marked as 'required', the absence of any one of these
two should be treated as an error. Git already fails under these
circumstances, but not always in a pleasant way: omitting a clean cmd in
a required filter triggers an assertion error which leaves the user with
a quite verbose message:

git: convert.c:1462: convert_to_git_filter_fd: Assertion "ca.drv->clean || ca.drv->process" failed.

This assertion and the one above it are not really necessary, as the
apply_filter() call bellow them already performs the same checks. And
when these conditions are not met, the function returns 0, making the
caller die() with a much nicer message. (Also note that die()-ing here
is the right behavior as `would_convert_to_git_filter_fd() == true` is a
precondition to use convert_to_git_filter_fd(), and the former is only
true when the filter is required.) So remove both assertions and add two
regression tests to make sure that git fails nicely when either the
smudge or clean command is missing on a required filter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c             |  3 ---
 t/t0021-conversion.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07..48fbdac676 100644
--- a/convert.c
+++ b/convert.c
@@ -1455,9 +1455,6 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	struct conv_attrs ca;
 	convert_attrs(istate, &ca, path);
 
-	assert(ca.drv);
-	assert(ca.drv->clean || ca.drv->process);
-
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))
 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e828ee964c..4f8415d419 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -257,6 +257,30 @@ test_expect_success 'required filter clean failure' '
 	test_must_fail git add test.fc
 '
 
+test_expect_success 'required filter with absent clean field' '
+	test_config filter.absentclean.smudge cat &&
+	test_config filter.absentclean.required true &&
+
+	echo "*.ac filter=absentclean" >.gitattributes &&
+
+	echo test >test.ac &&
+	test_must_fail git add test.ac 2>stderr &&
+	test_i18ngrep "fatal: test.ac: clean filter .absentclean. failed" stderr
+'
+
+test_expect_success 'required filter with absent smudge field' '
+	test_config filter.absentsmudge.clean cat &&
+	test_config filter.absentsmudge.required true &&
+
+	echo "*.as filter=absentsmudge" >.gitattributes &&
+
+	echo test >test.as &&
+	git add test.as &&
+	rm -f test.as &&
+	test_must_fail git checkout -- test.as 2>stderr &&
+	test_i18ngrep "fatal: test.as: smudge filter absentsmudge failed" stderr
+'
+
 test_expect_success 'filtering large input to small output should use little memory' '
 	test_config filter.devnull.clean "cat >/dev/null" &&
 	test_config filter.devnull.required true &&
-- 
2.30.1

