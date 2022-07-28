Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7601C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiG1QSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiG1QSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502173904
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z16so2766217wrh.12
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4yCObcxaA9xEd0VkOtnutTEENUe/JQa5kV98MRiOKiA=;
        b=dR5MZrmFoSiWPTfdl+5mGqo2o1ZLRdnviLYbq87XhgCeHao6SZBbF5ORLrtHlgv71q
         tpXtXBOtUEqOFDQvTJ2gIS+Z9T5MtTJ2BXiXdEEDGqjhEccGZB5ckB9e01+kz0aow0RX
         hFmRL2CnXaXwkVd+I9I4lGW7J24Z06m25Zkm8Sz97xPPlnTZA+Sl43U97iW7i/ph/Vmi
         sHruSqgXPEJUXFP71H/yQJKd5kO0jAI3qqsaUXsBacuugG4uf6lBGjpcI6yHi6EWADCG
         6bizR658a+fNwz6kXGnX+5LS6iA222/gHWF35M0Cu46KpZKMqotFXSAE668h+03lBZLv
         ElJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4yCObcxaA9xEd0VkOtnutTEENUe/JQa5kV98MRiOKiA=;
        b=PLL+KomGJ9iu1BlFkJ/BAWw+4SutJ3WJCuMsqPGo94qE3GtQ6nRQcDVshemzSv/bZg
         k0n0NIhL/f12/KJ5ym8DshQ6qi2nFdC8EOlAT30qdoPBA58uMxeYDf4wVpOwQlCcr8e+
         bWAC8YpB/7Dzk1yPVy8dnZLOvdz3Mjtk4/TbNj9OGaWVt+NZTpAZF48tscDxihh7DEt3
         bqPRpRwDuipL0DBaC7G5xRlsFyhLgRGTi6pnFMgdvjv1Qx1Ep6yB8q4CRfhtBGAICRAR
         w1fXO/cKaeiI0vTXVPLr0DT6AiWsuvF7oNBZKAsPJN63qHYIIrpeBJVhOAJiBQgTbqZ9
         Uh4g==
X-Gm-Message-State: AJIora9fw0LuA3VV6C4XavaaN534gevU4mxIg9IcRVXzg6xz7UXUQkJz
        bBKQ5eHDkssUeQIJWjWRtWZglSrNr2sxYw==
X-Google-Smtp-Source: AGRyM1tcPbAfAPiWrDU99lVhm/6jveI00hnVv+lTgrEtfTBYJRsU0cz1AjhSC9TPF7ZRWbcsZSE3YQ==
X-Received: by 2002:a05:6000:2a9:b0:21e:8f9b:74b9 with SMTP id l9-20020a05600002a900b0021e8f9b74b9mr11731300wry.232.1659025071370;
        Thu, 28 Jul 2022 09:17:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/20] submodule--helper: convert a strbuf_detach() to xstrfmt()
Date:   Thu, 28 Jul 2022 18:16:57 +0200
Message-Id: <patch-12.20-08cc9ce2e24-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert a case where we had no reason to use a "struct strbuf" to use
an xstrfmt(). This code was added along with other uses of "struct
strbuf" in this function in ee8838d1577 (submodule: rewrite
`module_clone` shell function in C, 2015-09-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 60165a848a2..f74957444e1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1568,12 +1568,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
-	if (!is_absolute_path(clone_data->path)) {
-		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
-	} else {
+	if (!is_absolute_path(clone_data->path))
+		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
+					   clone_data->path);
+	else
 		clone_data->path = xstrdup(clone_data->path);
-	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
-- 
2.37.1.1167.g38fda70d8c4

