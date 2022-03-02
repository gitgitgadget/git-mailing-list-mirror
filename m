Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiCBRLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbiCBRLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1040936
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so1662194wmp.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc3ut0ZvXd8IXWygrBAOEm8lNr2zlrd79hP19IRsVJw=;
        b=Ac9tKtw18iTcUZerALE1vGr9aLEM8QYPEpgBhFuIlH0i7h0IaBthNH1oJ7lhH4YIeP
         iHDWde/s+Kvjf+gWcaC0cbWmpq2SsNKeDaQmFdjOwEYJeKjPnOMl10jRshx4/ozhKFwQ
         MGDNEUfIHWCIz/OihVktUns3bhPW6rzwxqBggUvpepwlCEc1aKaylbkrl37GMXo8wf5T
         d1SlLUApAXCDJ0hf2c6L0Zb2IipAW7IDdFmy1VDuMIsNmAGxbLeK8KDxXjwUuKgzRz+c
         oO5orecP2R+tFeiZSfFqFev59jbV+HhBXzgTU0CeQFCWVLkTNLg6JvPGtHBQcY/8Vueg
         cuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc3ut0ZvXd8IXWygrBAOEm8lNr2zlrd79hP19IRsVJw=;
        b=RUo/Sbg8GE/mCA/yLa+tZnXARN//WO/o/UNqiAxcbURV2kIJBMNJ1N3KlbHVNnorgq
         wkDs/ZTVFrwfNFAqBf/pv9tlGbMD+dqv1QArEa/fzae+hUYwycNrlMpS86Lv0TuFzc53
         9XFjsJqy3i81hffEqgrsQU80KPwa5hXq0U8IZVtb5jn1kj9/+UGjrmhiz0L5MZ4xPhqL
         VUUdMhZZ1BJp3ebjxk566ra0pUKmkA/6t8UnGCg7jO+2MeaXlvbYa59MV+qvxSrG2Lpq
         vxr+EVHS//qBpc50eDYYZz5KUShzfSNLrkozSosKOkpYiOv+Aiqcl/oICr/+Q4IfZrKU
         K4Jw==
X-Gm-Message-State: AOAM530Oo9o/V+Vtk2CmJA1qOmHGZnRaGmKE+aDFbX8gRxXj7+OLNY5P
        xPzdWD1WjVnWpv/2/JL2Ba7zSjnWLsRNDQ==
X-Google-Smtp-Source: ABdhPJyfu6V1/AgcR/f+N+rlUwLjRBCPunxXaHu8D5nYMeLT4PXO/MBBTcWluTP2SfGeDm+mgcQa8A==
X-Received: by 2002:a7b:c216:0:b0:381:21f4:4965 with SMTP id x22-20020a7bc216000000b0038121f44965mr605102wmi.167.1646241027812;
        Wed, 02 Mar 2022 09:10:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/14] urlmatch.c: add and use a *_release() function
Date:   Wed,  2 Mar 2022 18:10:10 +0100
Message-Id: <patch-04.14-7f7077e8476-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak in credential_apply_config() by adding and using a
new urlmatch_config_release() function. This just does a
string_list_clear() on the "vars" member.

This finished up work on normalizing the init/free pattern in this
API, started in 73ee449bbf2 (urlmatch.[ch]: add and use
URLMATCH_CONFIG_INIT, 2021-10-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/config.c | 2 +-
 credential.c     | 1 +
 urlmatch.c       | 5 +++++
 urlmatch.h       | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 542d8d02b2b..ebec61868be 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -612,7 +612,7 @@ static int get_urlmatch(const char *var, const char *url)
 
 		strbuf_release(&matched->value);
 	}
-	string_list_clear(&config.vars, 1);
+	urlmatch_config_release(&config);
 	string_list_clear(&values, 1);
 	free(config.url.url);
 
diff --git a/credential.c b/credential.c
index e7240f3f636..f6389a50684 100644
--- a/credential.c
+++ b/credential.c
@@ -130,6 +130,7 @@ static void credential_apply_config(struct credential *c)
 	git_config(urlmatch_config_entry, &config);
 	string_list_clear(&config.vars, 1);
 	free(normalized_url);
+	urlmatch_config_release(&config);
 	strbuf_release(&url);
 
 	c->configured = 1;
diff --git a/urlmatch.c b/urlmatch.c
index 03ad3f30a9c..b615adc923a 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -611,3 +611,8 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	strbuf_release(&synthkey);
 	return retval;
 }
+
+void urlmatch_config_release(struct urlmatch_config *config)
+{
+	string_list_clear(&config->vars, 1);
+}
diff --git a/urlmatch.h b/urlmatch.h
index 34a3ba6d197..9f40b00bfb8 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -71,5 +71,6 @@ struct urlmatch_config {
 }
 
 int urlmatch_config_entry(const char *var, const char *value, void *cb);
+void urlmatch_config_release(struct urlmatch_config *config);
 
 #endif /* URL_MATCH_H */
-- 
2.35.1.1228.g56895c6ee86

