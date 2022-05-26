Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB5CC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbiEZOvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347850AbiEZOut (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3B5DA04
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j21so1483670pga.13
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjgoNcSswCzdBzD+c9PEtXQswDpUmfFrTouBDVbw9PE=;
        b=p5xA67DlH6s9f0BfkdifwMD+IV0Guh0AnYRi9hSpEEoOEGuiahzo7cSSTHUnUoOdKW
         ppeAE+4Buk3Ze2x/tHrm/uU/wm4+HeI/ClWCSC839AnoNz3UkIiEpihRmpjkYezDj4Aj
         plCrgP9LRGPTTK19ryfmiFu4AQ6nA0GrFZIhYGALvl66JahamQty/9Nx84UCmrBTlbQP
         0McYwXCpefonm9VB/SIPSCC2WOyVLsp4vvn9l9BJV3irtZaJZd3Qj2s/IerMVEvi8Zos
         6p02SJULclcFFzvu/ibZ+5fE39xsTYO93nx0Qkkpngvos6MBSsJ5o7O1iPkz1edi+0ig
         BJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjgoNcSswCzdBzD+c9PEtXQswDpUmfFrTouBDVbw9PE=;
        b=wO4BVKa4RJS8lEYtw8EZ+49BAktQCnz7lopXIZLitp6R5mikQChIi8Y6EeY7AnWKtl
         rBtmGQjijIbt7AR1UPdey2e/35dind+l+B9SJc1mK747GsVTmw1Z0+rWCy0xNTo6D1y/
         rBvzNUxwr0Idf25UZh5/x12wzm7TsfOzW5gPZ37Hm3wmGvvLmK23iU6aM6zRYaVk9VW2
         1xQOPd+S5fXewPHW68grt4cBZxk2zuMy5Cf/JZ9qoD6ShR13N+w0XuzUlWT+YrdSwsqf
         R1xp/9NXTq+JSZmL5/oSDgM5wIBzvlCe3VW9nMBP5CCnyCBNvnyGk9NCw+wZw19/PHyp
         Mkpw==
X-Gm-Message-State: AOAM530qGd81H4nzK+ZLV8CnP68MRDpR2tM4a0YXCnKyF67V3UiePt9L
        kaoRQVK5LjPE0pqoRG4AA/hrVxOnczxMcA==
X-Google-Smtp-Source: ABdhPJwF8qcCR4dA2RGlVUiZ0+/WW++zQ8Hetbbw4vsKcIAN895FHCa7joRDjsi9tYssBPQ2sQs3nw==
X-Received: by 2002:a63:91c8:0:b0:3fa:e410:735d with SMTP id l191-20020a6391c8000000b003fae410735dmr6700482pge.504.1653576647610;
        Thu, 26 May 2022 07:50:47 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:47 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 07/10] po/git.pot: don't check in result of "make pot"
Date:   Thu, 26 May 2022 22:50:32 +0800
Message-Id: <20220526145035.18958-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Remove the "po/git.pot" file from being tracked, which started with
dce37b66fb0 (l10n: initial git.pot for 1.7.10 upcoming release,
2012-02-13).

The reason the po/git.pot started being checked in was because the
po/*.po files were changed a schema where we'd generate them from a
known-good snapshot of po/git.pot, instead of each translator running
"make pot" themselves.

This makes sense, but we don't need to carry this file in-tree just to
achieve that aim, and doing so has resulted in a significant amount of
"diff churn" since this method of doing it was introduced:

    $ git log -p --oneline -- po/git.pot|wc -l
    553743

We can instead let l10n contributors to generate "po/git.pot" in runtime
to update their own "po/XX.po", and the l10n coordinator can check
pull requests using CI pipeline.

This reverts to the schema introduced initially in cd5513a7168 (i18n:
Makefile: "pot" target to extract messages marked for translation,
2011-02-22).

The actual "git rm" of po/git.pot was in preceding commit to make this
change easier to review, and to preempt the mailing list from blocking
it due to it being too large.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile      | 5 +++--
 po/.gitignore | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0cc397d214..cc3eb856b2 100644
--- a/Makefile
+++ b/Makefile
@@ -2786,8 +2786,8 @@ endef
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(gen_pot_header)
 
-po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
-	$(QUIET_GEN)$(MSGCAT) $(filter-out FORCE,$^) >$@
+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
+	$(QUIET_GEN)$(MSGCAT) $^ >$@
 
 .PHONY: pot
 pot: po/git.pot
@@ -3330,6 +3330,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
+	$(RM) po/git.pot
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
diff --git a/po/.gitignore b/po/.gitignore
index 796b96d1c4..37d1301b32 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1 +1,2 @@
 /build
+/git.pot
-- 
2.36.0.1.g15c4090757

