Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7487C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbhLPSTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbhLPSTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:08 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AA4C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so36131wmd.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ycVqUq8XNWvwy8JAAUPh1G8Aa8iPRtzEPrLa/pDpOUs=;
        b=frg6/Qa9+VI+6dXaNEirhq69em3rXlFMso/s98C4CE+4KQhFfjvDwC5XE+j1uIjnur
         iTQLn9bcN2tnTS0mKx8w1k9A+cEVAPxm1AjktUJrltpPkAzLCjdWKGBALh849+1olelS
         QIlFSd1cghzW2tJIxN8aPQVGj8cG5cMsUHqBJA2PjJ/qJuEI/v1jx56qWGqTr+Njyld/
         XJiFUdQkduldEONHFO2h5r+By5VHZmxBNnPV8lY6AZVIiMCnuWnKZxMS4tC1WoHzCkLw
         gQayKW/cA4JWA0wyeU0nwwpjH5DNz263m/oO32P3c1MAHL0o3MHjgjdAL4l2xm+tsNtm
         O4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ycVqUq8XNWvwy8JAAUPh1G8Aa8iPRtzEPrLa/pDpOUs=;
        b=i/hF6J6g++4Ga8sY/s89kacLDvp1KofDN/+WFG+QIrAXAJQW3mUAyfYYv7DYNJjXsA
         KA+8z/ntDLyEUIvR7fA5JjyWXvi2ITa2psGaEDeE0dwgJfd69ttcojle2QD7L/1fZyto
         VYl94dhvM4SP6baA5TQ5qqlsWFLcdGZBO7kPj/S4Lw8LHY25vzxffGz9HPTjkBYGAOUD
         wdc3udP76iE9Zk+VTFIRNaBrGFQbz9CCuZ0ZGUtEwiDa9otHZQ8rFpY0swxODQicuzhG
         fZ19bEecagRTI11szSI8qnyClxSiHHQsW138M+Qb+S5+jbHZkyObVCSej6+46WJc45Kt
         VjFg==
X-Gm-Message-State: AOAM531srfR+CTDPejVtuukUzZ+JQNbAHycxUS6dvKWoVxTSIWLXpDXt
        YFQwtLCxJaUGp0bLQxaTLlzNDoDeLT8=
X-Google-Smtp-Source: ABdhPJzrxMG/ZxefDINCyMUZeYNCiH/q+0LqfKfa1w0HflGF5RC8hMuNPB+786NNP/8xHR8JW8NEtw==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr6214068wma.42.1639678746318;
        Thu, 16 Dec 2021 10:19:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm413807wri.115.2021.12.16.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:19:06 -0800 (PST)
Message-Id: <0c81a14247f9f832b5dc23de94116d8c67d81325.1639678737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
From:   "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 18:18:52 +0000
Subject: [PATCH v3 2/4] clean: normalize format string of yes/no prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kashav madan <kshvmdn@gmail.com>,
        Kashav Madan <kshvmdn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kashav Madan <kshvmdn@gmail.com>

Move the question mark in the prompt before the choices to be more
consistent with other similar prompts.

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
 builtin/clean.c | 2 +-
 po/bg.po        | 2 +-
 po/ca.po        | 4 ++--
 po/de.po        | 4 ++--
 po/el.po        | 2 +-
 po/es.po        | 4 ++--
 po/fr.po        | 4 ++--
 po/git.pot      | 2 +-
 po/id.po        | 4 ++--
 po/it.po        | 4 ++--
 po/ko.po        | 4 ++--
 po/pl.po        | 4 ++--
 po/pt_PT.po     | 4 ++--
 po/ru.po        | 4 ++--
 po/sv.po        | 4 ++--
 po/tr.po        | 4 ++--
 po/vi.po        | 4 ++--
 po/zh_CN.po     | 4 ++--
 po/zh_TW.po     | 4 ++--
 19 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..2b52e522a82 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -752,7 +752,7 @@ static int ask_each_cmd(void)
 		if (!eof) {
 			qname = quote_path(item->string, NULL, &buf, 0);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
-			printf(_("Remove %s [y/N]? "), qname);
+			printf(_("Remove %s? [y/N] "), qname);
 			if (git_read_line_interactively(&confirm) == EOF) {
 				putchar('\n');
 				eof = 1;
diff --git a/po/bg.po b/po/bg.po
index e0786caa274..10ba01d2817 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -13487,7 +13487,7 @@ msgstr "Избиране на обекти за изтриване"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
+msgid "Remove %s? [y/N] "
 msgstr "Да се изтрие ли „%s“? „y“ —  да, „N“ — НЕ"
 
 #: builtin/clean.c:786
diff --git a/po/ca.po b/po/ca.po
index 71673d48d01..d9798fd530e 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -13211,8 +13211,8 @@ msgstr "Selecciona els ítems a suprimir"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Voleu eliminar %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Voleu eliminar %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/de.po b/po/de.po
index 3e8ef2ed122..442627f3448 100644
--- a/po/de.po
+++ b/po/de.po
@@ -13274,8 +13274,8 @@ msgstr "Wählen Sie Einträge zum Löschen"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "'%s' löschen [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "'%s' löschen? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/el.po b/po/el.po
index 27c8c488ea1..b826b73d460 100644
--- a/po/el.po
+++ b/po/el.po
@@ -9560,7 +9560,7 @@ msgstr ""
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:760
 #, c-format
-msgid "Remove %s [y/N]? "
+msgid "Remove %s? [y/N] "
 msgstr ""
 
 #: builtin/clean.c:785 git-add--interactive.perl:1717
diff --git a/po/es.po b/po/es.po
index ef8ae6d471e..8e9143131d0 100644
--- a/po/es.po
+++ b/po/es.po
@@ -13081,8 +13081,8 @@ msgstr "Seleccionar objetos para borrar"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "¿Borrar %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "¿Borrar %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/fr.po b/po/fr.po
index 9812213b2fe..ebb5b73ce3b 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -13282,8 +13282,8 @@ msgstr "Sélectionner les éléments à supprimer"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Supprimer %s [y/N] ? "
+msgid "Remove %s? [y/N] "
+msgstr "Supprimer %s ? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/git.pot b/po/git.pot
index c3102deb5d2..4ef2f39b950 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -12087,7 +12087,7 @@ msgstr ""
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
+msgid "Remove %s? [y/N] "
 msgstr ""
 
 #: builtin/clean.c:786
diff --git a/po/id.po b/po/id.po
index 3b8b0c39e51..b41e290c94a 100644
--- a/po/id.po
+++ b/po/id.po
@@ -12525,8 +12525,8 @@ msgstr "Pilih item untuk dihapus"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Hapus %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Hapus %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/it.po b/po/it.po
index 01c6d1f095e..b4322699060 100644
--- a/po/it.po
+++ b/po/it.po
@@ -12508,8 +12508,8 @@ msgstr "Seleziona gli elementi da eliminare"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:758
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Eliminare %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Eliminare %s? [y/N] "
 
 #: builtin/clean.c:789
 msgid ""
diff --git a/po/ko.po b/po/ko.po
index 96d3a2a3be4..29c7a6896fd 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -7179,8 +7179,8 @@ msgstr "삭제할 항목을 선택하십시오"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:763
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "%s 제거합니까 [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "%s 제거합니까? [y/N] "
 
 #: builtin/clean.c:788 git-add--interactive.perl:1717
 #, c-format
diff --git a/po/pl.po b/po/pl.po
index 637a328a869..4d79160a15b 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -13061,8 +13061,8 @@ msgstr "Wybierz elementy do skasowania"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Usunąć %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Usunąć %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/pt_PT.po b/po/pt_PT.po
index a9a67f15484..06da638e981 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -12623,8 +12623,8 @@ msgstr "Selecione itens para eliminar"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Remover %s [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Remover %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/ru.po b/po/ru.po
index d091ea22e5a..cc886655cfd 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -11466,8 +11466,8 @@ msgstr "Укажите элементы для удаления"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:758
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Удалить %s [y - да/N - нет]? "
+msgid "Remove %s? [y/N] "
+msgstr "Удалить %s? [y - да/N - нет] "
 
 #: builtin/clean.c:789
 msgid ""
diff --git a/po/sv.po b/po/sv.po
index 6ccb7e7421c..ea9fe33cf9e 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -12981,8 +12981,8 @@ msgstr "Välj poster att ta bort"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Ta bort %s [Y=ja / N=nej]? "
+msgid "Remove %s? [y/N] "
+msgstr "Ta bort %s? [Y=ja / N=nej] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/tr.po b/po/tr.po
index 686b21459a3..46a1ae5a8d2 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -13040,8 +13040,8 @@ msgstr "Silinecek ögeleri seçin"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "%s kaldırılsın mı [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "%s kaldırılsın mı? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/vi.po b/po/vi.po
index bfb84bd0049..d9c0130af2b 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -13037,8 +13037,8 @@ msgstr "Chọn mục muốn xóa"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "Xóa bỏ “%s” [y/N]? "
+msgid "Remove %s? [y/N] "
+msgstr "Xóa bỏ “%s”? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 9131b440e6f..a51c81bfc4a 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -12881,8 +12881,8 @@ msgstr "选择要删除的条目"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "删除 %s [y/N]？"
+msgid "Remove %s? [y/N] "
+msgstr "删除 %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 80e156c94fc..c5b5f756f33 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -12735,8 +12735,8 @@ msgstr "選擇要刪除的條目"
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:755
 #, c-format
-msgid "Remove %s [y/N]? "
-msgstr "移除 %s [y/N]？ "
+msgid "Remove %s? [y/N] "
+msgstr "移除 %s? [y/N] "
 
 #: builtin/clean.c:786
 msgid ""
-- 
gitgitgadget

