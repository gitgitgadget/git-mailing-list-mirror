Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E87C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508BE20702
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4sAyvcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgKFSt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFSt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 13:49:28 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F7C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 10:49:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 74so3329558lfo.5
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzZ0tjVSQbVlz20IdtwguQiuQfbWYkeIyyPscLaFoDA=;
        b=j4sAyvcKqmIgvQgTZZhweNicbVQ6PhpnrZWJJ8WV9JVNDTa6M1tqHjMXYNr67XpZlh
         TPcmBimLsauukFzG2TmC2LA2axuCwLCi0UDG8E0Avaim2lzCWmGJ2XcDzPC2iZQO+j9m
         OkWf35D6sxZBoyplNgYFeHwUjcsoFEEUq3SFahxmv1W2GqJH7J5XJY6SCWemrKTCDJw9
         PRERabb8QISis0uGpCK98jPPzma2Z3mA8/Rx2gv7sBYPRCUU9UilFXfm7TVtxuMxf+Ut
         DVJoiwwuKQdxPE6eIbUN4gsPun/xxYgfoELGRi+2UCtO4Qa5/UgX7dAVp4FEfrzTX/8w
         zEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzZ0tjVSQbVlz20IdtwguQiuQfbWYkeIyyPscLaFoDA=;
        b=o6ErqxaQyjm02nDXxppsviTXh3E+uyEk1lwhojmWXzPNoT9R1J4prQC1bVtyCzcvi9
         XldDOIVi7nu8JIBxQyhOmdzj2RI55WM0NlMCpYVN/GfkzBHiRAwLClFgXCiLB6JdJIo9
         RC7zio1bkSbwGyLAvDugm3X9UMLGbWMVqHLwNmL7QSFT9fGFy3pCBJT4jEy7TuZj/mH+
         QBNiowy9n8aaqn/Xt6Kx7ZJQdI/FVA0oSMRrrp4CcP2N9KLwPq4+xATC9/DlRRfZ21io
         fJ0WZwoKTZGeum2BO27iKZ99MridwTA6xN6S2gSlLAcvazu3Jr1BdoUvBXvXIukxX1TB
         Psxg==
X-Gm-Message-State: AOAM532N/PHA003y+AKqHRedPQ4izA2bgruIuvl3vRnVouwyYMI902HT
        MGI+ejDmb6E5bkbCOSsZwuoKOg05MtRNyg==
X-Google-Smtp-Source: ABdhPJwJ8GjiOQNAoCoIqT277PsMRXj+tkviyqKoPK6o0Pb0SVNjLfuEt1YLVh9MqZo3KycDfAQCVA==
X-Received: by 2002:a19:550b:: with SMTP id n11mr1270047lfe.495.1604688562135;
        Fri, 06 Nov 2020 10:49:22 -0800 (PST)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id q15sm252063lfb.163.2020.11.06.10.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 10:49:20 -0800 (PST)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     git@vger.kernel.org
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] git-gui: update Russian translation
Date:   Fri,  6 Nov 2020 20:49:04 +0200
Message-Id: <20201106184904.7196-1-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.16.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translation is done on Transifex: https://www.transifex.com/djm00n/git-po-ru/git-gui/
If you have any corrections please report them there.

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 po/ru.po | 3287 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 1778 insertions(+), 1509 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 9f5305c..161ee1a 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -2,14 +2,14 @@
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui package.
 # Translators:
-# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015-2016
+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015-2016,2020
 # Irina Riesen <irina.riesen@gmail.com>, 2007
 msgid ""
 msgstr ""
 "Project-Id-Version: Git Russian Localization Project\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
-"PO-Revision-Date: 2016-06-30 12:39+0000\n"
+"POT-Creation-Date: 2020-02-08 22:54+0100\n"
+"PO-Revision-Date: 2020-11-05 11:20+0000\n"
 "Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
 "Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/language/ru/)\n"
 "MIME-Version: 1.0\n"
@@ -18,33 +18,33 @@ msgstr ""
 "Language: ru\n"
 "Plural-Forms: nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 && n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);\n"
 
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: критическая ошибка"
-
-#: git-gui.sh:743
+#: git-gui.sh:847
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "В %s установлен неверный шрифт:"
 
-#: git-gui.sh:779
+#: git-gui.sh:901
 msgid "Main Font"
 msgstr "Шрифт интерфейса"
 
-#: git-gui.sh:780
+#: git-gui.sh:902
 msgid "Diff/Console Font"
 msgstr "Шрифт консоли и изменений (diff)"
 
-#: git-gui.sh:794
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034
+#: git-gui.sh:1053 git-gui.sh:3212
+msgid "git-gui: fatal error"
+msgstr "git-gui: критическая ошибка"
+
+#: git-gui.sh:918
 msgid "Cannot find git in PATH."
 msgstr "git не найден в PATH."
 
-#: git-gui.sh:821
+#: git-gui.sh:945
 msgid "Cannot parse Git version string:"
 msgstr "Невозможно распознать строку версии Git: "
 
-#: git-gui.sh:839
+#: git-gui.sh:970
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -56,473 +56,519 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr "Невозможно определить версию Git\n\n%s указывает на версию «%s».\n\nдля %s требуется версия Git, начиная с 1.5.0\n\nПредположить, что «%s» и есть версия 1.5.0?\n"
 
-#: git-gui.sh:1128
+#: git-gui.sh:1267
 msgid "Git directory not found:"
 msgstr "Каталог Git не найден:"
 
-#: git-gui.sh:1146
+#: git-gui.sh:1301
 msgid "Cannot move to top of working directory:"
 msgstr "Невозможно перейти к корню рабочего каталога репозитория: "
 
-#: git-gui.sh:1154
+#: git-gui.sh:1309
 msgid "Cannot use bare repository:"
 msgstr "Невозможно использование репозитория без рабочего каталога:"
 
-#: git-gui.sh:1162
+#: git-gui.sh:1317
 msgid "No working directory"
 msgstr "Отсутствует рабочий каталог"
 
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Обновление информации о состоянии файлов…"
 
-#: git-gui.sh:1390
+#: git-gui.sh:1551
 msgid "Scanning for modified files ..."
 msgstr "Поиск измененных файлов…"
 
-#: git-gui.sh:1454
+#: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
 msgstr "Вызов перехватчика prepare-commit-msg…"
 
-#: git-gui.sh:1471
+#: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "Коммит прерван перехватчиком prepare-commit-msg."
 
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
 msgstr "Готово."
 
-#: git-gui.sh:1787
+#: git-gui.sh:1968
 #, tcl-format
-msgid "Displaying only %s of %s files."
-msgstr "Показано %s из %s файлов."
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s "
+"files."
+msgstr "Лимит отображаемых файлов достигнут (gui.maxfilesdisplayed = %s), не все %s файлы показаны."
 
-#: git-gui.sh:1913
+#: git-gui.sh:2091
 msgid "Unmodified"
 msgstr "Не изменено"
 
-#: git-gui.sh:1915
+#: git-gui.sh:2093
 msgid "Modified, not staged"
 msgstr "Изменено, не в индексе"
 
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
 msgstr "В индексе для коммита"
 
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
 msgstr "Части, в индексе для коммита"
 
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
 msgstr "В индексе для коммита, отсутствует"
 
-#: git-gui.sh:1920
+#: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr "Тип файла изменён, не в индексе"
 
-#: git-gui.sh:1921
+#: git-gui.sh:2099 git-gui.sh:2100
+msgid "File type changed, old type staged for commit"
+msgstr "Тип файла изменён, старый тип файла в индексе"
+
+#: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr "Тип файла изменён, в индексе"
 
-#: git-gui.sh:1923
+#: git-gui.sh:2102
+msgid "File type change staged, modification not staged"
+msgstr "Изменение типа файла в индексе, изменение не в индексе"
+
+#: git-gui.sh:2103
+msgid "File type change staged, file missing"
+msgstr "Изменение типа файла в индексе, файл не найден"
+
+#: git-gui.sh:2105
 msgid "Untracked, not staged"
 msgstr "Не отслеживается, не в индексе"
 
-#: git-gui.sh:1928
+#: git-gui.sh:2110
 msgid "Missing"
 msgstr "Отсутствует"
 
-#: git-gui.sh:1929
+#: git-gui.sh:2111
 msgid "Staged for removal"
 msgstr "В индексе для удаления"
 
-#: git-gui.sh:1930
+#: git-gui.sh:2112
 msgid "Staged for removal, still present"
 msgstr "В индексе для удаления, еще не удалено"
 
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
 msgid "Requires merge resolution"
 msgstr "Требуется разрешение конфликта при слиянии"
 
-#: git-gui.sh:1972
-msgid "Starting gitk... please wait..."
-msgstr "Запускается gitk… Подождите, пожалуйста…"
-
-#: git-gui.sh:1984
+#: git-gui.sh:2164
 msgid "Couldn't find gitk in PATH"
 msgstr "gitk не найден в PATH."
 
-#: git-gui.sh:2043
+#: git-gui.sh:2210 git-gui.sh:2245
+#, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "Запускается %s… Подождите, пожалуйста…"
+
+#: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
 msgstr "git gui не найден в PATH."
 
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
 msgstr "Репозиторий"
 
-#: git-gui.sh:2456
+#: git-gui.sh:2727
 msgid "Edit"
-msgstr "Редактировать"
+msgstr "Правка"
 
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "Ветка"
 
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "Коммит"
 
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr "Слияние"
 
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "Внешние репозитории"
 
-#: git-gui.sh:2468
+#: git-gui.sh:2739
 msgid "Tools"
 msgstr "Вспомогательные операции"
 
-#: git-gui.sh:2477
+#: git-gui.sh:2748
 msgid "Explore Working Copy"
 msgstr "Просмотр рабочего каталога"
 
-#: git-gui.sh:2483
+#: git-gui.sh:2763
+msgid "Git Bash"
+msgstr "Git Bash"
+
+#: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
 msgstr "Просмотреть файлы текущей ветки"
 
-#: git-gui.sh:2487
+#: git-gui.sh:2776
 msgid "Browse Branch Files..."
 msgstr "Показать файлы ветки…"
 
-#: git-gui.sh:2492
+#: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
 msgstr "Показать историю текущей ветки"
 
-#: git-gui.sh:2496
+#: git-gui.sh:2785
 msgid "Visualize All Branch History"
 msgstr "Показать историю всех веток"
 
-#: git-gui.sh:2503
+#: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Показать файлы ветки %s"
 
-#: git-gui.sh:2505
+#: git-gui.sh:2794
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Показать историю ветки %s"
 
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Статистика базы данных"
 
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2802 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "Сжать базу данных"
 
-#: git-gui.sh:2516
+#: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "Проверить базу данных"
 
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
-#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
 msgid "Create Desktop Icon"
 msgstr "Создать ярлык на рабочем столе"
 
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
 msgid "Quit"
 msgstr "Выход"
 
-#: git-gui.sh:2547
+#: git-gui.sh:2836
 msgid "Undo"
 msgstr "Отменить"
 
-#: git-gui.sh:2550
+#: git-gui.sh:2839
 msgid "Redo"
 msgstr "Повторить"
 
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2843 git-gui.sh:3461
 msgid "Cut"
 msgstr "Вырезать"
 
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Копировать"
 
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2849 git-gui.sh:3467
 msgid "Paste"
 msgstr "Вставить"
 
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr "Удалить"
 
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
 msgid "Select All"
-msgstr "Выделить все"
+msgstr "Выделить всё"
 
-#: git-gui.sh:2576
+#: git-gui.sh:2865
 msgid "Create..."
 msgstr "Создать…"
 
-#: git-gui.sh:2582
+#: git-gui.sh:2871
 msgid "Checkout..."
 msgstr "Перейти…"
 
-#: git-gui.sh:2588
+#: git-gui.sh:2877
 msgid "Rename..."
 msgstr "Переименовать…"
 
-#: git-gui.sh:2593
+#: git-gui.sh:2882
 msgid "Delete..."
 msgstr "Удалить…"
 
-#: git-gui.sh:2598
+#: git-gui.sh:2887
 msgid "Reset..."
 msgstr "Сбросить…"
 
-#: git-gui.sh:2608
+#: git-gui.sh:2897
 msgid "Done"
 msgstr "Завершено"
 
-#: git-gui.sh:2610
+#: git-gui.sh:2899
 msgid "Commit@@verb"
 msgstr "Закоммитить"
 
-#: git-gui.sh:2619 git-gui.sh:3050
-msgid "New Commit"
-msgstr "Новый коммит"
-
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
 msgstr "Исправить последний коммит"
 
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "Перечитать"
 
-#: git-gui.sh:2643
+#: git-gui.sh:2924
 msgid "Stage To Commit"
 msgstr "Добавить в индекс"
 
-#: git-gui.sh:2649
+#: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
 msgstr "Добавить изменённые файлы в индекс"
 
-#: git-gui.sh:2655
+#: git-gui.sh:2936
 msgid "Unstage From Commit"
 msgstr "Убрать из издекса"
 
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
 msgstr "Обратить изменения"
 
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
 msgid "Show Less Context"
 msgstr "Меньше контекста"
 
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
 msgid "Show More Context"
 msgstr "Больше контекста"
 
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
 msgid "Sign Off"
 msgstr "Вставить Signed-off-by"
 
-#: git-gui.sh:2696
+#: git-gui.sh:2977
 msgid "Local Merge..."
 msgstr "Локальное слияние…"
 
-#: git-gui.sh:2701
+#: git-gui.sh:2982
 msgid "Abort Merge..."
 msgstr "Прервать слияние…"
 
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
 msgstr "Добавить…"
 
-#: git-gui.sh:2717
+#: git-gui.sh:2998
 msgid "Push..."
 msgstr "Отправить…"
 
-#: git-gui.sh:2721
+#: git-gui.sh:3002
 msgid "Delete Branch..."
 msgstr "Удалить ветку…"
 
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
 msgstr "Настройки…"
 
-#: git-gui.sh:2742
+#: git-gui.sh:3023
 msgid "Remove..."
 msgstr "Удалить…"
 
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
 msgid "Help"
-msgstr "Помощь"
+msgstr "Справка"
 
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
 #, tcl-format
 msgid "About %s"
 msgstr "О %s"
 
-#: git-gui.sh:2783
+#: git-gui.sh:3064
 msgid "Online Documentation"
 msgstr "Документация в интернете"
 
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
 msgid "Show SSH Key"
 msgstr "Показать ключ SSH"
 
-#: git-gui.sh:2893
+#: git-gui.sh:3097 git-gui.sh:3229
+msgid "usage:"
+msgstr "использование:"
+
+#: git-gui.sh:3101 git-gui.sh:3233
+msgid "Usage"
+msgstr "Использование"
+
+#: git-gui.sh:3182 lib/blame.tcl:575
+msgid "Error"
+msgstr "Ошибка"
+
+#: git-gui.sh:3213
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr "критическая ошибка: %s: нет такого файла или каталога"
 
-#: git-gui.sh:2926
+#: git-gui.sh:3246
 msgid "Current Branch:"
 msgstr "Текущая ветка:"
 
-#: git-gui.sh:2947
-msgid "Staged Changes (Will Commit)"
-msgstr "Изменения в индексе (будут закоммичены)"
-
-#: git-gui.sh:2967
+#: git-gui.sh:3271
 msgid "Unstaged Changes"
 msgstr "Изменено (не будет сохранено)"
 
-#: git-gui.sh:3017
+#: git-gui.sh:3293
+msgid "Staged Changes (Will Commit)"
+msgstr "Изменения в индексе (будут закоммичены)"
+
+#: git-gui.sh:3367
 msgid "Stage Changed"
 msgstr "Индексировать всё"
 
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3386 lib/transport.tcl:137
 msgid "Push"
 msgstr "Отправить"
 
-#: git-gui.sh:3071
+#: git-gui.sh:3413
 msgid "Initial Commit Message:"
 msgstr "Сообщение первого коммита:"
 
-#: git-gui.sh:3072
+#: git-gui.sh:3414
 msgid "Amended Commit Message:"
 msgstr "Сообщение исправленного коммита:"
 
-#: git-gui.sh:3073
+#: git-gui.sh:3415
 msgid "Amended Initial Commit Message:"
 msgstr "Сообщение исправленного первого коммита:"
 
-#: git-gui.sh:3074
+#: git-gui.sh:3416
 msgid "Amended Merge Commit Message:"
 msgstr "Сообщение исправленного слияния:"
 
-#: git-gui.sh:3075
+#: git-gui.sh:3417
 msgid "Merge Commit Message:"
 msgstr "Сообщение слияния:"
 
-#: git-gui.sh:3076
+#: git-gui.sh:3418
 msgid "Commit Message:"
 msgstr "Сообщение коммита:"
 
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Копировать все"
 
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3501 lib/blame.tcl:106
 msgid "File:"
 msgstr "Файл:"
 
-#: git-gui.sh:3255
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr "Открыть"
+
+#: git-gui.sh:3629
 msgid "Refresh"
 msgstr "Обновить"
 
-#: git-gui.sh:3276
+#: git-gui.sh:3650
 msgid "Decrease Font Size"
 msgstr "Уменьшить размер шрифта"
 
-#: git-gui.sh:3280
+#: git-gui.sh:3654
 msgid "Increase Font Size"
 msgstr "Увеличить размер шрифта"
 
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3662 lib/blame.tcl:296
 msgid "Encoding"
 msgstr "Кодировка"
 
-#: git-gui.sh:3299
+#: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
 msgstr "Применить/Убрать изменение"
 
-#: git-gui.sh:3304
+#: git-gui.sh:3678
 msgid "Apply/Reverse Line"
 msgstr "Применить/Убрать строку"
 
-#: git-gui.sh:3323
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+msgid "Revert Hunk"
+msgstr "Обратить изменения блока"
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+msgid "Revert Line"
+msgstr "Обратить изменения строки"
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr "Отменить последнее обращение изменений"
+
+#: git-gui.sh:3713
 msgid "Run Merge Tool"
 msgstr "Запустить программу слияния"
 
-#: git-gui.sh:3328
+#: git-gui.sh:3718
 msgid "Use Remote Version"
 msgstr "Взять внешнюю версию"
 
-#: git-gui.sh:3332
+#: git-gui.sh:3722
 msgid "Use Local Version"
 msgstr "Взять локальную версию"
 
-#: git-gui.sh:3336
+#: git-gui.sh:3726
 msgid "Revert To Base"
 msgstr "Обратить изменения"
 
-#: git-gui.sh:3354
+#: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
 msgstr "Показать эти изменения подмодуля"
 
-#: git-gui.sh:3358
+#: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "Показать историю текущей ветки подмодуля"
 
-#: git-gui.sh:3362
+#: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
 msgstr "Показать историю всех веток подмодуля"
 
-#: git-gui.sh:3367
+#: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
 msgstr "Запустить git gui в подмодуле"
 
-#: git-gui.sh:3389
+#: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
 msgstr "Убрать блок из индекса"
 
-#: git-gui.sh:3391
+#: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr "Убрать строки из индекса"
 
-#: git-gui.sh:3393
+#: git-gui.sh:3798 git-gui.sh:3809
+msgid "Revert Lines"
+msgstr "Обратить изменения строк"
+
+#: git-gui.sh:3800
 msgid "Unstage Line From Commit"
 msgstr "Убрать строку из индекса"
 
-#: git-gui.sh:3396
+#: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
 msgstr "Добавить блок в индекс"
 
-#: git-gui.sh:3398
+#: git-gui.sh:3808
 msgid "Stage Lines For Commit"
 msgstr "Добавить строки в индекс"
 
-#: git-gui.sh:3400
+#: git-gui.sh:3811
 msgid "Stage Line For Commit"
 msgstr "Добавить строку в индекс"
 
-#: git-gui.sh:3424
+#: git-gui.sh:3861
 msgid "Initializing..."
 msgstr "Инициализация…"
 
-#: git-gui.sh:3541
+#: git-gui.sh:4017
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -533,14 +579,14 @@ msgid ""
 "\n"
 msgstr "Возможны ошибки в переменных окружения.\n\nПеременные окружения, которые возможно\nбудут проигнорированы командами Git,\nзапущенными из %s\n\n"
 
-#: git-gui.sh:3570
+#: git-gui.sh:4046
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr "\nЭто известная проблема с Tcl,\nраспространяемым Cygwin."
 
-#: git-gui.sh:3575
+#: git-gui.sh:4051
 #, tcl-format
 msgid ""
 "\n"
@@ -551,357 +597,201 @@ msgid ""
 "~/.gitconfig file.\n"
 msgstr "\n\nВместо использования %s можно\nсохранить значения user.name и\nuser.email в Вашем персональном\nфайле ~/.gitconfig.\n"
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
-msgstr "git-gui - графический пользовательский интерфейс к Git."
-
-#: lib/blame.tcl:72
-msgid "File Viewer"
-msgstr "Просмотр файла"
-
-#: lib/blame.tcl:78
-msgid "Commit:"
-msgstr "Коммит:"
-
-#: lib/blame.tcl:271
-msgid "Copy Commit"
-msgstr "Копировать SHA-1"
-
-#: lib/blame.tcl:275
-msgid "Find Text..."
-msgstr "Найти текст…"
-
-#: lib/blame.tcl:284
-msgid "Do Full Copy Detection"
-msgstr "Провести полный поиск копий"
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Неподдерживаемая программа проверки правописания"
 
-#: lib/blame.tcl:288
-msgid "Show History Context"
-msgstr "Показать исторический контекст"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Проверка правописания не доступна"
 
-#: lib/blame.tcl:291
-msgid "Blame Parent Commit"
-msgstr "Авторы родительского коммита"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Неправильная конфигурация программы проверки правописания"
 
-#: lib/blame.tcl:450
+#: lib/spellcheck.tcl:70
 #, tcl-format
-msgid "Reading %s..."
-msgstr "Чтение %s…"
-
-#: lib/blame.tcl:557
-msgid "Loading copy/move tracking annotations..."
-msgstr "Загрузка аннотации копирований/переименований…"
-
-#: lib/blame.tcl:577
-msgid "lines annotated"
-msgstr "строк прокомментировано"
+msgid "Reverting dictionary to %s."
+msgstr "Словарь вернут к %s."
 
-#: lib/blame.tcl:769
-msgid "Loading original location annotations..."
-msgstr "Загрузка аннотаций первоначального положения объекта…"
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Программа проверки правописания не смогла запуститься"
 
-#: lib/blame.tcl:772
-msgid "Annotation complete."
-msgstr "Аннотация завершена."
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Нераспознанная программа проверки правописания"
 
-#: lib/blame.tcl:802
-msgid "Busy"
-msgstr "Занят"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Исправлений не найдено"
 
-#: lib/blame.tcl:803
-msgid "Annotation process is already running."
-msgstr "Аннотация уже запущена"
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Программа проверки правописания прервала передачу данных"
 
-#: lib/blame.tcl:842
-msgid "Running thorough copy detection..."
-msgstr "Выполнение полного поиска копий…"
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Ошибка проверки правописания"
 
-#: lib/blame.tcl:910
-msgid "Loading annotation..."
-msgstr "Загрузка аннотации…"
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
+msgstr "извлечение %s"
 
-#: lib/blame.tcl:963
-msgid "Author:"
-msgstr "Автор:"
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Извлечение изменений из %s "
 
-#: lib/blame.tcl:967
-msgid "Committer:"
-msgstr "Коммитер:"
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "чистка внешнего %s"
 
-#: lib/blame.tcl:972
-msgid "Original File:"
-msgstr "Исходный файл:"
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Чистка отслеживаемых веток, удалённых из %s"
 
-#: lib/blame.tcl:1020
-msgid "Cannot find HEAD commit:"
-msgstr "Не удалось найти текущее состояние:"
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "извлечь со всех внешних репозиториев"
 
-#: lib/blame.tcl:1075
-msgid "Cannot find parent commit:"
-msgstr "Не удалось найти родительское состояние:"
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "Получение изменений со всех внешних репозиториев"
 
-#: lib/blame.tcl:1090
-msgid "Unable to display parent"
-msgstr "Не могу показать предка"
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "чистка всех внешних репозиториев"
 
-#: lib/blame.tcl:1091 lib/diff.tcl:320
-msgid "Error loading diff:"
-msgstr "Ошибка загрузки изменений:"
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "Чистка отслеживаемых веток, удалённых со всех внешних репозиториев"
 
-#: lib/blame.tcl:1231
-msgid "Originally By:"
-msgstr "Источник:"
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "отправить %s"
 
-#: lib/blame.tcl:1237
-msgid "In File:"
-msgstr "Файл:"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Отправка изменений в %s "
 
-#: lib/blame.tcl:1242
-msgid "Copied Or Moved Here By:"
-msgstr "Скопировано/перемещено в:"
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Точное копирование в %s"
 
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
-msgid "Checkout Branch"
-msgstr "Перейти на ветку"
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Отправка %s %s в %s"
 
-#: lib/branch_checkout.tcl:23
-msgid "Checkout"
-msgstr "Перейти"
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Отправить ветки"
 
-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
+#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 lib/merge.tcl:178
 msgid "Cancel"
 msgstr "Отмена"
 
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
-msgid "Revision"
-msgstr "Версия"
-
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
-msgid "Options"
-msgstr "Настройки"
-
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
-msgstr "Извлечь изменения из внешней ветки"
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Исходные ветки"
 
-#: lib/branch_checkout.tcl:44
-msgid "Detach From Local Branch"
-msgstr "Отсоединить от локальной ветки"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Репозиторий назначения"
 
-#: lib/branch_create.tcl:22
-msgid "Create Branch"
-msgstr "Создать ветку"
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "внешний:"
 
-#: lib/branch_create.tcl:27
-msgid "Create New Branch"
-msgstr "Создать новую ветку"
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Указанное положение:"
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
-msgid "Create"
-msgstr "Создать"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Настройки отправки"
 
-#: lib/branch_create.tcl:40
-msgid "Branch Name"
-msgstr "Имя ветки"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "Принудительно перезаписать существующую ветку (возможна потеря изменений)"
 
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
-msgid "Name:"
-msgstr "Название:"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "Использовать thin pack (для медленных сетевых подключений)"
 
-#: lib/branch_create.tcl:58
-msgid "Match Tracking Branch Name"
-msgstr "Соответствовать имени отслеживаемой ветки"
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Передать метки"
 
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
-msgstr "Начальная версия"
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr "%s (%s): Отправка"
 
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
-msgstr "Обновить имеющуюся ветку:"
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Извлечение %s из %s "
 
-#: lib/branch_create.tcl:75
-msgid "No"
-msgstr "Нет"
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "критическая ошибка: невозможно разрешить %s"
 
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
-msgstr "Только Fast Forward"
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Закрыть"
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
-msgstr "Сброс"
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Ветка «%s» не существует."
 
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
-msgstr "После создания сделать текущей"
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Ошибка создания упрощённой конфигурации git pull для «%s»."
 
-#: lib/branch_create.tcl:131
-msgid "Please select a tracking branch."
-msgstr "Укажите отлеживаемую ветку."
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Ветка «%s» уже существует."
 
-#: lib/branch_create.tcl:140
+#: lib/checkout_op.tcl:229
 #, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Отслеживаемая ветка %s не является веткой на внешнем репозитории."
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr "Ветка «%s» уже существует.\n\nОна не может быть перемотана вперед к %s.\nТребуется слияние."
 
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
-msgid "Please supply a branch name."
-msgstr "Укажите имя ветки."
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Неизвестная стратегия слияния «%s»."
 
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/checkout_op.tcl:262
 #, tcl-format
-msgid "'%s' is not an acceptable branch name."
-msgstr "Недопустимое имя ветки «%s»."
+msgid "Failed to update '%s'."
+msgstr "Не удалось обновить «%s»."
 
-#: lib/branch_delete.tcl:15
-msgid "Delete Branch"
-msgstr "Удаление ветки"
-
-#: lib/branch_delete.tcl:20
-msgid "Delete Local Branch"
-msgstr "Удалить локальную ветку"
-
-#: lib/branch_delete.tcl:37
-msgid "Local Branches"
-msgstr "Локальные ветки"
-
-#: lib/branch_delete.tcl:52
-msgid "Delete Only If Merged Into"
-msgstr "Удалить только в случае, если было слияние с"
-
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "Всегда (не выполнять проверку на слияние)"
-
-#: lib/branch_delete.tcl:103
-#, tcl-format
-msgid "The following branches are not completely merged into %s:"
-msgstr "Ветки, которые не полностью сливаются с %s:"
-
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr "Восстановить удаленные ветки сложно.\n\nПродолжить?"
-
-#: lib/branch_delete.tcl:141
-#, tcl-format
-msgid ""
-"Failed to delete branches:\n"
-"%s"
-msgstr "Не удалось удалить ветки:\n%s"
-
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
-msgid "Rename Branch"
-msgstr "Переименование ветки"
-
-#: lib/branch_rename.tcl:26
-msgid "Rename"
-msgstr "Переименовать"
-
-#: lib/branch_rename.tcl:36
-msgid "Branch:"
-msgstr "Ветка:"
-
-#: lib/branch_rename.tcl:39
-msgid "New Name:"
-msgstr "Новое название:"
-
-#: lib/branch_rename.tcl:75
-msgid "Please select a branch to rename."
-msgstr "Укажите ветку для переименования."
-
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
-#, tcl-format
-msgid "Branch '%s' already exists."
-msgstr "Ветка «%s» уже существует."
-
-#: lib/branch_rename.tcl:117
-#, tcl-format
-msgid "Failed to rename '%s'."
-msgstr "Не удалось переименовать «%s». "
-
-#: lib/browser.tcl:17
-msgid "Starting..."
-msgstr "Запуск…"
-
-#: lib/browser.tcl:26
-msgid "File Browser"
-msgstr "Просмотр списка файлов"
-
-#: lib/browser.tcl:126 lib/browser.tcl:143
-#, tcl-format
-msgid "Loading %s..."
-msgstr "Загрузка %s…"
-
-#: lib/browser.tcl:187
-msgid "[Up To Parent]"
-msgstr "[На уровень выше]"
-
-#: lib/browser.tcl:267 lib/browser.tcl:273
-msgid "Browse Branch Files"
-msgstr "Показать файлы ветки"
-
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
-msgid "Browse"
-msgstr "Показать"
-
-#: lib/checkout_op.tcl:85
-#, tcl-format
-msgid "Fetching %s from %s"
-msgstr "Извлечение %s из %s "
-
-#: lib/checkout_op.tcl:133
-#, tcl-format
-msgid "fatal: Cannot resolve %s"
-msgstr "критическая ошибка: невозможно разрешить %s"
-
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
-msgid "Close"
-msgstr "Закрыть"
-
-#: lib/checkout_op.tcl:175
-#, tcl-format
-msgid "Branch '%s' does not exist."
-msgstr "Ветка «%s» не существует."
-
-#: lib/checkout_op.tcl:194
-#, tcl-format
-msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "Ошибка создания упрощённой конфигурации git pull для «%s»."
-
-#: lib/checkout_op.tcl:229
-#, tcl-format
-msgid ""
-"Branch '%s' already exists.\n"
-"\n"
-"It cannot fast-forward to %s.\n"
-"A merge is required."
-msgstr "Ветка «%s» уже существует.\n\nОна не может быть перемотана вперед к %s.\nТребуется слияние."
-
-#: lib/checkout_op.tcl:243
-#, tcl-format
-msgid "Merge strategy '%s' not supported."
-msgstr "Неизвестная стратегия слияния «%s»."
-
-#: lib/checkout_op.tcl:262
-#, tcl-format
-msgid "Failed to update '%s'."
-msgstr "Не удалось обновить «%s»."
-
-#: lib/checkout_op.tcl:274
-msgid "Staging area (index) is already locked."
-msgstr "Рабочая область заблокирована другим процессом."
+#: lib/checkout_op.tcl:274
+msgid "Staging area (index) is already locked."
+msgstr "Рабочая область заблокирована другим процессом."
 
 #: lib/checkout_op.tcl:289
 msgid ""
@@ -921,51 +811,55 @@ msgstr "Обновление рабочего каталога из «%s»…"
 msgid "files checked out"
 msgstr "файлы извлечены"
 
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "Прерван переход на «%s» (требуется слияние содержимого файлов)"
 
-#: lib/checkout_op.tcl:377
+#: lib/checkout_op.tcl:378
 msgid "File level merge required."
 msgstr "Требуется слияние содержания файлов."
 
-#: lib/checkout_op.tcl:381
+#: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Ветка «%s» остаётся текущей."
 
-#: lib/checkout_op.tcl:452
+#: lib/checkout_op.tcl:453
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
 "If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."
 msgstr "Вы более не находитесь на локальной ветке.\n\nЕсли вы хотите снова вернуться к какой-нибудь ветке, создайте её сейчас, начиная с «Текущего отсоединенного состояния»."
 
-#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "Выполнен переход на «%s»."
 
-#: lib/checkout_op.tcl:535
+#: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "Сброс «%s»  на «%s» приведет к потере следующих коммитов:"
 
-#: lib/checkout_op.tcl:557
+#: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
 msgstr "Восстановить потерянные коммиты будет сложно."
 
-#: lib/checkout_op.tcl:562
+#: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "Сбросить «%s»?"
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
 msgstr "Наглядно"
 
-#: lib/checkout_op.tcl:635
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Сброс"
+
+#: lib/checkout_op.tcl:636
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -975,576 +869,498 @@ msgid ""
 "This should not have occurred.  %s will now close and give up."
 msgstr "Не удалось установить текущую ветку.\n\nВаш рабочий каталог обновлён только частично. Были обновлены все файлы кроме служебных файлов Git. \n\nЭтого не должно было произойти. %s завершается."
 
-#: lib/choose_font.tcl:39
-msgid "Select"
-msgstr "Выбрать"
+#: lib/remote_add.tcl:20
+#, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "%s (%s): Добавление внешнего репозитория"
 
-#: lib/choose_font.tcl:53
-msgid "Font Family"
-msgstr "Шрифт"
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Добавить внешний репозиторий"
 
-#: lib/choose_font.tcl:74
-msgid "Font Size"
-msgstr "Размер шрифта"
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Добавить"
 
-#: lib/choose_font.tcl:91
-msgid "Font Example"
-msgstr "Пример текста"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Информация о внешнем репозитории"
 
-#: lib/choose_font.tcl:103
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
-msgstr "Это пример текста.\nЕсли Вам нравится этот текст, это может быть Ваш шрифт."
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Название:"
 
-#: lib/choose_repository.tcl:28
-msgid "Git Gui"
-msgstr "Git Gui"
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Положение:"
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
-msgid "Create New Repository"
-msgstr "Создать новый репозиторий"
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "Следующая операция"
 
-#: lib/choose_repository.tcl:93
-msgid "New..."
-msgstr "Новый…"
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Сразу извлечь изменения"
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
-msgid "Clone Existing Repository"
-msgstr "Склонировать существующий репозиторий"
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Инициализировать внешний репозиторий и отправить"
 
-#: lib/choose_repository.tcl:106
-msgid "Clone..."
-msgstr "Клонировать…"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "Больше ничего не делать"
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
-msgid "Open Existing Repository"
-msgstr "Выбрать существующий репозиторий"
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Укажите название внешнего репозитория."
 
-#: lib/choose_repository.tcl:119
-msgid "Open..."
-msgstr "Открыть…"
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "«%s» не является допустимым именем внешнего репозитория."
 
-#: lib/choose_repository.tcl:132
-msgid "Recent Repositories"
-msgstr "Недавние репозитории"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Не удалось добавить «%s» из «%s». "
 
-#: lib/choose_repository.tcl:138
-msgid "Open Recent Repository:"
-msgstr "Открыть последний репозиторий"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "Извлечение %s"
 
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/remote_add.tcl:156
 #, tcl-format
-msgid "Failed to create repository %s:"
-msgstr "Не удалось создать репозиторий %s:"
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Невозможно инициализировать репозиторий в «%s»."
 
-#: lib/choose_repository.tcl:391
-msgid "Directory:"
-msgstr "Каталог:"
+#: lib/remote_add.tcl:163
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Настройка %s (в %s)"
 
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
-msgid "Git Repository"
-msgstr "Репозиторий"
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Запуск…"
 
-#: lib/choose_repository.tcl:448
+#: lib/browser.tcl:27
 #, tcl-format
-msgid "Directory %s already exists."
-msgstr "Каталог '%s' уже существует."
+msgid "%s (%s): File Browser"
+msgstr "%s (%s): Просмотр списка файлов"
 
-#: lib/choose_repository.tcl:452
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
-msgid "File %s already exists."
-msgstr "Файл '%s' уже существует."
+msgid "Loading %s..."
+msgstr "Загрузка %s…"
 
-#: lib/choose_repository.tcl:466
-msgid "Clone"
-msgstr "Склонировать"
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[На уровень выше]"
 
-#: lib/choose_repository.tcl:479
-msgid "Source Location:"
-msgstr "Исходное положение:"
+#: lib/browser.tcl:275
+#, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "%s (%s): Просмотр файлов ветки"
 
-#: lib/choose_repository.tcl:490
-msgid "Target Directory:"
-msgstr "Каталог назначения:"
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Показать файлы ветки"
 
-#: lib/choose_repository.tcl:502
-msgid "Clone Type:"
-msgstr "Тип клона:"
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
+msgstr "Показать"
 
-#: lib/choose_repository.tcl:508
-msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "Стандартный (Быстрый, полуизбыточный, «жесткие» ссылки)"
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
+msgstr "Версия"
 
-#: lib/choose_repository.tcl:514
-msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Полная копия (Медленный, создает резервную копию)"
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Не удалось разблокировать индекс"
 
-#: lib/choose_repository.tcl:520
-msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr "Общий (Самый быстрый, не рекомендуется, без резервной копии)"
+#: lib/index.tcl:30
+msgid "Index Error"
+msgstr "Ошибка в индексе"
 
-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
-#, tcl-format
-msgid "Not a Git repository: %s"
-msgstr "Каталог не является репозиторием: %s"
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr "Не удалось обновить индекс Git. Состояние репозитория будет перечитано автоматически."
 
-#: lib/choose_repository.tcl:592
-msgid "Standard only available for local repository."
-msgstr "Стандартный клон возможен только для локального репозитория."
+#: lib/index.tcl:43
+msgid "Continue"
+msgstr "Продолжить"
 
-#: lib/choose_repository.tcl:596
-msgid "Shared only available for local repository."
-msgstr "Общий клон возможен только для локального репозитория."
+#: lib/index.tcl:46
+msgid "Unlock Index"
+msgstr "Разблокировать индекс"
+
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
+msgstr "файлов"
+
+#: lib/index.tcl:326
+msgid "Unstaging selected files from commit"
+msgstr "Уборка выбранных файлов из индекса"
 
-#: lib/choose_repository.tcl:617
+#: lib/index.tcl:330
 #, tcl-format
-msgid "Location %s already exists."
-msgstr "Путь '%s' уже существует."
+msgid "Unstaging %s from commit"
+msgstr "Удаление %s из индекса"
 
-#: lib/choose_repository.tcl:628
-msgid "Failed to configure origin"
-msgstr "Не могу сконфигурировать исходный репозиторий."
+#: lib/index.tcl:369
+msgid "Ready to commit."
+msgstr "Готов для коммита."
 
-#: lib/choose_repository.tcl:640
-msgid "Counting objects"
-msgstr "Считаю объекты"
+#: lib/index.tcl:378
+msgid "Adding selected files"
+msgstr "Добавление выбранных файлов"
 
-#: lib/choose_repository.tcl:641
-msgid "buckets"
-msgstr "блоки"
-
-#: lib/choose_repository.tcl:665
+#: lib/index.tcl:382
 #, tcl-format
-msgid "Unable to copy objects/info/alternates: %s"
-msgstr "Не могу скопировать objects/info/alternates: %s"
+msgid "Adding %s"
+msgstr "Добавление %s…"
 
-#: lib/choose_repository.tcl:701
+#: lib/index.tcl:412
 #, tcl-format
-msgid "Nothing to clone from %s."
-msgstr "Нечего клонировать с %s."
+msgid "Stage %d untracked files?"
+msgstr "Проиндексировать %d неотслеживаемые файла?"
 
-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
-msgid "The 'master' branch has not been initialized."
-msgstr "Не инициализирована ветвь «master»."
+#: lib/index.tcl:420
+msgid "Adding all changed files"
+msgstr "Добавление всех измененных файлов"
 
-#: lib/choose_repository.tcl:716
-msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "«Жесткие ссылки» недоступны. Будет использовано копирование."
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Обратить изменения в файле %s?"
 
-#: lib/choose_repository.tcl:728
+#: lib/index.tcl:508
 #, tcl-format
-msgid "Cloning from %s"
-msgstr "Клонирование %s"
+msgid "Revert changes in these %i files?"
+msgstr "Обратить изменения в %i файле(-ах)?"
 
-#: lib/choose_repository.tcl:759
-msgid "Copying objects"
-msgstr "Копирование objects"
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "Любые непроиндексированные изменения, будут потеряны при обращении изменений."
 
-#: lib/choose_repository.tcl:760
-msgid "KiB"
-msgstr "КБ"
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
+msgstr "Ничего не делать"
 
-#: lib/choose_repository.tcl:784
+#: lib/index.tcl:545
 #, tcl-format
-msgid "Unable to copy object: %s"
-msgstr "Не могу скопировать объект: %s"
+msgid "Delete untracked file %s?"
+msgstr "Удалить неотслеживаемый файл %s?"
 
-#: lib/choose_repository.tcl:794
-msgid "Linking objects"
-msgstr "Создание ссылок на objects"
+#: lib/index.tcl:550
+#, tcl-format
+msgid "Delete these %i untracked files?"
+msgstr "Удалить %i неотслеживаемые файла?"
 
-#: lib/choose_repository.tcl:795
-msgid "objects"
-msgstr "объекты"
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
+msgstr "Файлы будут удалены навсегда."
 
-#: lib/choose_repository.tcl:803
-#, tcl-format
-msgid "Unable to hardlink object: %s"
-msgstr "Не могу создать «жесткую ссылку» на объект: %s"
+#: lib/index.tcl:564
+msgid "Delete Files"
+msgstr "Удалить файлы"
 
-#: lib/choose_repository.tcl:858
-msgid "Cannot fetch branches and objects.  See console output for details."
-msgstr "Не удалось извлечь ветки и объекты. Дополнительная информация на консоли."
+#: lib/index.tcl:586
+msgid "Deleting"
+msgstr "Удаление"
 
-#: lib/choose_repository.tcl:869
-msgid "Cannot fetch tags.  See console output for details."
-msgstr "Не удалось извлечь метки. Дополнительная информация на консоли."
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
+msgstr "Возникшие ошибки при удалении файлов:\n"
 
-#: lib/choose_repository.tcl:893
-msgid "Cannot determine HEAD.  See console output for details."
-msgstr "Не могу определить HEAD. Дополнительная информация на консоли."
+#: lib/index.tcl:674
+#, tcl-format
+msgid "None of the %d selected files could be deleted."
+msgstr "Не удалось удалить ни один из выбранных %d файлов."
 
-#: lib/choose_repository.tcl:902
+#: lib/index.tcl:679
 #, tcl-format
-msgid "Unable to cleanup %s"
-msgstr "Не могу очистить %s"
+msgid "%d of the %d selected files could not be deleted."
+msgstr "Не удалось удалить %d из выбранных  %d файлов."
 
-#: lib/choose_repository.tcl:908
-msgid "Clone failed."
-msgstr "Клонирование не удалось."
+#: lib/index.tcl:726
+msgid "Reverting selected files"
+msgstr "Обращение изменений в выбранных файлах"
 
-#: lib/choose_repository.tcl:915
-msgid "No default branch obtained."
-msgstr "Ветка по умолчанию не была получена."
+#: lib/index.tcl:730
+#, tcl-format
+msgid "Reverting %s"
+msgstr "Обращение изменений в %s"
 
-#: lib/choose_repository.tcl:926
+#: lib/branch_checkout.tcl:16
 #, tcl-format
-msgid "Cannot resolve %s as a commit."
-msgstr "Не могу распознать %s как коммит."
+msgid "%s (%s): Checkout Branch"
+msgstr "%s (%s): Переход на ветку"
 
-#: lib/choose_repository.tcl:938
-msgid "Creating working directory"
-msgstr "Создаю рабочий каталог"
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Перейти на ветку"
 
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
-msgid "files"
-msgstr "файлов"
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Перейти"
 
-#: lib/choose_repository.tcl:968
-msgid "Initial file checkout failed."
-msgstr "Не удалось получить начальное состояние файлов репозитория."
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
+msgstr "Настройки"
 
-#: lib/choose_repository.tcl:1011
-msgid "Open"
-msgstr "Открыть"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Извлечь изменения из внешней ветки"
 
-#: lib/choose_repository.tcl:1021
-msgid "Repository:"
-msgstr "Репозиторий:"
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Отсоединить от локальной ветки"
 
-#: lib/choose_repository.tcl:1072
+#: lib/status_bar.tcl:263
 #, tcl-format
-msgid "Failed to open repository %s:"
-msgstr "Не удалось открыть репозиторий %s:"
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s … %*i из %*i %s (%3i%%)"
 
-#: lib/choose_rev.tcl:53
-msgid "This Detached Checkout"
-msgstr "Текущее отсоединенное состояние"
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Отправить"
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
-msgstr "Выражение для определения версии:"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Удалить ссылку на внешний репозиторий"
 
-#: lib/choose_rev.tcl:74
-msgid "Local Branch"
-msgstr "Локальная ветка:"
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Чистка"
 
-#: lib/choose_rev.tcl:79
-msgid "Tracking Branch"
-msgstr "Отслеживаемая ветка"
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Извлечение из"
 
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
-msgid "Tag"
-msgstr "Метка"
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
+msgstr "Все"
 
-#: lib/choose_rev.tcl:317
+#: lib/branch_rename.tcl:15
 #, tcl-format
-msgid "Invalid revision: %s"
-msgstr "Неверная версия: %s"
+msgid "%s (%s): Rename Branch"
+msgstr "%s (%s): Переименовать ветку"
 
-#: lib/choose_rev.tcl:338
-msgid "No revision selected."
-msgstr "Версия не указана."
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Переименование ветки"
 
-#: lib/choose_rev.tcl:346
-msgid "Revision expression is empty."
-msgstr "Пустое выражение для определения версии."
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Переименовать"
 
-#: lib/choose_rev.tcl:531
-msgid "Updated"
-msgstr "Обновлено"
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Ветка:"
 
-#: lib/choose_rev.tcl:559
-msgid "URL"
-msgstr "Ссылка"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Новое название:"
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this to amend.\n"
-msgstr "Отсутствует коммиты для исправления.\n\nВы создаете начальный коммит, здесь еще нечего исправлять.\n"
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Укажите ветку для переименования."
 
-#: lib/commit.tcl:18
-msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.\n"
-msgstr "Невозможно исправить коммит во время слияния.\n\nТекущее слияние не завершено. Невозможно исправить предыдуий коммит, не прерывая эту операцию.\n"
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Укажите имя ветки."
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
-msgstr "Ошибка при загрузке данных для исправления коммита:"
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "Недопустимое имя ветки «%s»."
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
-msgstr "Невозможно получить информацию об авторстве:"
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Не удалось переименовать «%s». "
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "Недопустимый GIT_COMMITTER_IDENT:"
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Выбрать"
 
-#: lib/commit.tcl:129
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "предупреждение: Tcl не поддерживает кодировку «%s»."
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Шрифт"
 
-#: lib/commit.tcl:149
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
-msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь. \n\nЭто будет сделано сейчас автоматически.\n"
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Размер шрифта"
 
-#: lib/commit.tcl:172
-#, tcl-format
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Пример текста"
+
+#: lib/choose_font.tcl:105
 msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file before committing.\n"
-msgstr "Нельзя выполнить коммит с незавершённой операцией слияния.\n\nДля файла %s возник конфликт слияния. Разрешите конфликт и добавьте их в индекс перед выполнением коммита.\n"
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr "Это пример текста.\nЕсли Вам нравится этот текст, это может быть Ваш шрифт."
 
-#: lib/commit.tcl:180
+#: lib/option.tcl:11
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
-msgstr "Обнаружено неизвестное состояние файла %s.\n\nФайл %s не может быть закоммичен этой программой.\n"
+msgid "Invalid global encoding '%s'"
+msgstr "Неверная глобальная кодировка «%s»"
 
-#: lib/commit.tcl:188
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
-msgstr "Отсутствуют изменения для сохранения.\n\nДобавьте в индекс хотя бы один файл перед выполнением коммита.\n"
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Неверная кодировка репозитория «%s»"
 
-#: lib/commit.tcl:203
-msgid ""
-"Please supply a commit message.\n"
-"\n"
-"A good commit message has the following format:\n"
-"\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
-msgstr "Укажите сообщение коммита.\n\nРекомендуется следующий формат сообщения:\n\n- в первой строке краткое описание сделанных изменений\n- вторая строка пустая\n- в оставшихся строках опишите, что дают ваши изменения\n"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Восстановить настройки по умолчанию"
 
-#: lib/commit.tcl:234
-msgid "Calling pre-commit hook..."
-msgstr "Вызов перехватчика pre-commit…"
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Сохранить"
 
-#: lib/commit.tcl:249
-msgid "Commit declined by pre-commit hook."
-msgstr "Коммит прерван переватчиком pre-commit."
+#: lib/option.tcl:133
+#, tcl-format
+msgid "%s Repository"
+msgstr "Для репозитория %s"
 
-#: lib/commit.tcl:272
-msgid "Calling commit-msg hook..."
-msgstr "Вызов перехватчика commit-msg…"
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Общие (для всех репозиториев)"
 
-#: lib/commit.tcl:287
-msgid "Commit declined by commit-msg hook."
-msgstr "Коммит прерван переватчиком commit-msg"
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Имя пользователя"
 
-#: lib/commit.tcl:300
-msgid "Committing changes..."
-msgstr "Коммит изменений…"
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "Адрес электронной почты"
 
-#: lib/commit.tcl:316
-msgid "write-tree failed:"
-msgstr "Программа write-tree завершилась с ошибкой:"
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Суммарное сообщение при слиянии"
 
-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
-msgid "Commit failed."
-msgstr "Не удалось закоммитить изменения."
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Уровень детальности сообщений при слиянии"
 
-#: lib/commit.tcl:334
-#, tcl-format
-msgid "Commit %s appears to be corrupt"
-msgstr "Коммит %s похоже поврежден"
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Показать отчет об изменениях после слияния"
 
-#: lib/commit.tcl:339
-msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
-"\n"
-"A rescan will be automatically started now.\n"
-msgstr "Нет изменения для коммита.\n\nНи один файл не был изменен и не было слияния.\n\nСейчас автоматически запустится перечитывание репозитория.\n"
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Использовать для слияния программу"
 
-#: lib/commit.tcl:346
-msgid "No changes to commit."
-msgstr "Нет изменения для коммита."
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Доверять времени модификации файла"
 
-#: lib/commit.tcl:360
-msgid "commit-tree failed:"
-msgstr "Программа commit-tree завершилась с ошибкой:"
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Чистка отслеживаемых веток при извлечении изменений"
 
-#: lib/commit.tcl:381
-msgid "update-ref failed:"
-msgstr "Программа update-ref завершилась с ошибкой:"
-
-#: lib/commit.tcl:469
-#, tcl-format
-msgid "Created commit %s: %s"
-msgstr "Создан коммит %s: %s "
-
-#: lib/console.tcl:59
-msgid "Working... please wait..."
-msgstr "В процессе… пожалуйста, ждите…"
-
-#: lib/console.tcl:186
-msgid "Success"
-msgstr "Процесс успешно завершен"
-
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
-msgstr "Ошибка: не удалось выполнить команду"
-
-#: lib/database.tcl:43
-msgid "Number of loose objects"
-msgstr "Количество несвязанных объектов"
-
-#: lib/database.tcl:44
-msgid "Disk space used by loose objects"
-msgstr "Объем дискового пространства, занятый несвязанными объектами"
-
-#: lib/database.tcl:45
-msgid "Number of packed objects"
-msgstr "Количество упакованных объектов"
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "Такое же имя, как и у отслеживаемой ветки"
 
-#: lib/database.tcl:46
-msgid "Number of packs"
-msgstr "Количество pack-файлов"
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Использовать Textconv для просмотра различий и авторства"
 
-#: lib/database.tcl:47
-msgid "Disk space used by packed objects"
-msgstr "Объем дискового пространства, занятый упакованными объектами"
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Поиск копий только в изменённых файлах"
 
-#: lib/database.tcl:48
-msgid "Packed objects waiting for pruning"
-msgstr "Несвязанные объекты, которые можно удалить"
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Максимальная длинна списка недавних репозиториев"
 
-#: lib/database.tcl:49
-msgid "Garbage files"
-msgstr "Мусор"
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Минимальное количество символов для поиска копий"
 
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Сжатие базы объектов"
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Радиус исторического контекста (в днях)"
 
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
-msgstr "Проверка базы объектов при помощи fsck"
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "Число строк в контексте diff"
 
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress the database.\n"
-"\n"
-"Compress the database now?"
-msgstr "Этот репозиторий сейчас содержит примерно %i свободных объектов\n\nДля лучшей производительности рекомендуется сжать базу данных.\n\nСжать базу данных сейчас?"
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
+msgstr "Дополнительные параметры для diff"
 
-#: lib/date.tcl:25
-#, tcl-format
-msgid "Invalid date from Git: %s"
-msgstr "Неправильная дата в репозитории: %s"
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "Ширина текста сообщения коммита"
 
-#: lib/diff.tcl:64
-#, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have the same state."
-msgstr "Изменений не обнаружено.\n\nв %s отсутствуют изменения.\n\nДата изменения файла была обновлена другой программой, но содержимое файла осталось прежним.\n\nСейчас будет запущено перечитывание репозитория, чтобы найти подобные файлы."
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Шаблон для имени новой ветки"
 
-#: lib/diff.tcl:104
-#, tcl-format
-msgid "Loading diff of %s..."
-msgstr "Загрузка изменений %s…"
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Кодировка содержания файла по умолчанию"
 
-#: lib/diff.tcl:125
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
-msgstr "ЛОКАЛЬНО: удалён\nВНЕШНИЙ:\n"
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
+msgstr "Предупреждать перед коммитом в отделённый HEAD"
 
-#: lib/diff.tcl:130
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
-msgstr "ВНЕШНИЙ: удалён\nЛОКАЛЬНО:\n"
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
+msgstr "Индексирование неотслеживаемых файлов"
 
-#: lib/diff.tcl:137
-msgid "LOCAL:\n"
-msgstr "ЛОКАЛЬНО:\n"
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr "Показать неотслеживаемые файлы"
 
-#: lib/diff.tcl:140
-msgid "REMOTE:\n"
-msgstr "ВНЕШНИЙ:\n"
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr "Ширина табуляции"
 
-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
 #, tcl-format
-msgid "Unable to display %s"
-msgstr "Не могу показать %s"
+msgid "%s:"
+msgstr "%s:"
 
-#: lib/diff.tcl:203
-msgid "Error loading file:"
-msgstr "Ошибка загрузки файла:"
-
-#: lib/diff.tcl:210
-msgid "Git Repository (subproject)"
-msgstr "Репозиторий Git (подпроект)"
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Изменить"
 
-#: lib/diff.tcl:222
-msgid "* Binary file (not showing content)."
-msgstr "* Двоичный файл (содержимое не показано)"
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Словарь для проверки правописания:"
 
-#: lib/diff.tcl:227
-#, tcl-format
-msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
-msgstr "* Размер неотслеживаемого файла %d байт.\n* Показано первых %d байт.\n"
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Изменить"
 
-#: lib/diff.tcl:233
+#: lib/option.tcl:288
 #, tcl-format
-msgid ""
-"\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
-msgstr "\n* Неотслеживаемый файл обрезан: %s.\n* Чтобы увидеть весь файл, используйте внешний редактор.\n"
-
-#: lib/diff.tcl:482
-msgid "Failed to unstage selected hunk."
-msgstr "Не удалось исключить выбранную часть."
+msgid "Choose %s"
+msgstr "Выберите %s"
 
-#: lib/diff.tcl:489
-msgid "Failed to stage selected hunk."
-msgstr "Не удалось проиндексировать выбранный блок изменений."
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "п."
 
-#: lib/diff.tcl:568
-msgid "Failed to unstage selected line."
-msgstr "Не удалось исключить выбранную строку."
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Настройки"
 
-#: lib/diff.tcl:576
-msgid "Failed to stage selected line."
-msgstr "Не удалось проиндексировать выбранную строку."
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Не удалось полностью сохранить настройки:"
 
 #: lib/encoding.tcl:443
 msgid "Default"
@@ -1559,824 +1375,1277 @@ msgstr "Системная (%s)"
 msgid "Other"
 msgstr "Другая"
 
-#: lib/error.tcl:20 lib/error.tcl:114
-msgid "error"
-msgstr "ошибка"
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Запуск %s требует выбранного файла."
 
-#: lib/error.tcl:36
-msgid "warning"
-msgstr "предупреждение"
+#: lib/tools.tcl:92
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Вы действительно хотите выполнить %1$s на «%2$s»?"
 
-#: lib/error.tcl:94
-msgid "You must correct the above errors before committing."
-msgstr "Перед коммитом, исправьте вышеуказанные ошибки."
+#: lib/tools.tcl:96
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Действительно запустить %s?"
 
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
-msgstr "Не удалось разблокировать индекс"
+#: lib/tools.tcl:118
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Вспомогательная операция: %s"
 
-#: lib/index.tcl:15
-msgid "Index Error"
-msgstr "Ошибка в индексе"
+#: lib/tools.tcl:119
+#, tcl-format
+msgid "Running: %s"
+msgstr "Выполнение: %s"
 
-#: lib/index.tcl:17
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
-msgstr "Не удалось обновить индекс Git. Состояние репозитория будет перечитано автоматически."
+#: lib/tools.tcl:158
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "Программа %s завершилась успешно."
 
-#: lib/index.tcl:28
-msgid "Continue"
-msgstr "Продолжить"
+#: lib/tools.tcl:160
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Ошибка выполнения программы: %s"
 
-#: lib/index.tcl:31
-msgid "Unlock Index"
-msgstr "Разблокировать индекс"
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Использовать базовую версию для разрешения конфликта?"
 
-#: lib/index.tcl:289
-#, tcl-format
-msgid "Unstaging %s from commit"
-msgstr "Удаление %s из индекса"
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Использовать версию из этой ветки для разрешения конфликта?"
 
-#: lib/index.tcl:328
-msgid "Ready to commit."
-msgstr "Готов для коммита."
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Использовать версию из другой ветки для разрешения конфликта?"
 
-#: lib/index.tcl:341
+#: lib/mergetool.tcl:14
 #, tcl-format
-msgid "Adding %s"
-msgstr "Добавление %s…"
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr "Внимание! Список изменений показывает только конфликтующие отличия.\n\n%s будет переписан.\n\nЭто действие можно отменить только перезапуском операции слияния."
 
-#: lib/index.tcl:398
+#: lib/mergetool.tcl:45
 #, tcl-format
-msgid "Revert changes in file %s?"
-msgstr "Обратить изменения в файле %s?"
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Похоже, что файл %s содержит неразрешенные конфликты. Продолжить индексацию?"
 
-#: lib/index.tcl:400
+#: lib/mergetool.tcl:60
 #, tcl-format
-msgid "Revert changes in these %i files?"
-msgstr "Обратить изменения в %i файле(-ах)?"
+msgid "Adding resolution for %s"
+msgstr "Добавляю результат разрешения для %s"
 
-#: lib/index.tcl:408
-msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr "Любые непроиндексированные изменения, будут потеряны при обращении изменений."
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Программа слияния не обрабатывает конфликты с удалением или участием ссылок"
 
-#: lib/index.tcl:411
-msgid "Do Nothing"
-msgstr "Ничего не делать"
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Конфликтующий файл не существует"
 
-#: lib/index.tcl:429
-msgid "Reverting selected files"
-msgstr "Обращение изменений в выбранных файлах"
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "«%s» не является программой слияния"
 
-#: lib/index.tcl:433
+#: lib/mergetool.tcl:275
 #, tcl-format
-msgid "Reverting %s"
-msgstr "Обращение изменений в %s"
+msgid "Unsupported merge tool '%s'"
+msgstr "Неподдерживаемая программа слияния «%s»"
 
-#: lib/merge.tcl:13
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr "Программа слияния уже работает. Прервать?"
+
+#: lib/mergetool.tcl:330
+#, tcl-format
 msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
-msgstr "Невозможно выполнить слияние во время исправления.\n\nЗавершите исправление данного коммита перед выполнением операции слияния.\n"
+"Error retrieving versions:\n"
+"%s"
+msgstr "Ошибка получения версий:\n%s"
 
-#: lib/merge.tcl:27
+#: lib/mergetool.tcl:350
+#, tcl-format
 msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.\n"
+"Could not start the merge tool:\n"
 "\n"
-"The rescan will be automatically started now.\n"
-msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем слияние может быть сделано.\n\nЭто будет сделано сейчас автоматически.\n"
-
-#: lib/merge.tcl:45
-#, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current merge.  Only then can you begin another merge.\n"
-msgstr "Предыдущее слияние не завершено из-за конфликта.\n\nДля файла %s возник конфликт слияния.\n\nРазрешите конфликт, добавьте файл в индекс и закоммитьте. Только после этого можно начать следующее слияние.\n"
+"%s"
+msgstr "Ошибка запуска программы слияния:\n\n%s"
 
-#: lib/merge.tcl:55
-#, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.\n"
-msgstr "Вы находитесь в процессе изменений.\n\nФайл %s изменён.\n\nВы должны завершить текущий коммит перед началом слияния. В случае необходимости, это позволит прервать операцию слияния.\n"
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
+msgstr "Запуск программы слияния…"
 
-#: lib/merge.tcl:107
-#, tcl-format
-msgid "%s of %s"
-msgstr "%s из %s"
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
+msgstr "Ошибка выполнения программы слияния."
 
-#: lib/merge.tcl:120
+#: lib/tools_dlg.tcl:22
 #, tcl-format
-msgid "Merging %s and %s..."
-msgstr "Слияние %s и %s…"
+msgid "%s (%s): Add Tool"
+msgstr "%s (%s): Добавить инструмент"
 
-#: lib/merge.tcl:131
-msgid "Merge completed successfully."
-msgstr "Слияние успешно завершено."
-
-#: lib/merge.tcl:133
-msgid "Merge failed.  Conflict resolution is required."
-msgstr "Не удалось завершить слияние. Требуется разрешение конфликта."
-
-#: lib/merge.tcl:158
-#, tcl-format
-msgid "Merge Into %s"
-msgstr "Слияние с %s"
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Новая вспомогательная операция"
 
-#: lib/merge.tcl:177
-msgid "Revision To Merge"
-msgstr "Версия, с которой провести слияние"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Добавить для всех репозиториев"
 
-#: lib/merge.tcl:212
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
-msgstr "Невозможно прервать исправление.\n\nЗавершите текущее исправление коммита.\n"
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Описание вспомогательной операции"
 
-#: lib/merge.tcl:222
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
-msgstr "Прервать операцию слияния?\n\nПрерывание текущего слияния приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Используйте «/» для создания подменю"
 
-#: lib/merge.tcl:228
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
-msgstr "Сбросить изменения?\n\nСброс изменений приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Команда:"
 
-#: lib/merge.tcl:239
-msgid "Aborting"
-msgstr "Прерываю"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Показать диалог перед запуском"
 
-#: lib/merge.tcl:239
-msgid "files reset"
-msgstr "изменения в файлах отменены"
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Запрос на выбор версии (устанавливает $REVISION)"
 
-#: lib/merge.tcl:267
-msgid "Abort failed."
-msgstr "Прервать не удалось."
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Запрос дополнительных аргументов (устанавливает $ARGS)"
 
-#: lib/merge.tcl:269
-msgid "Abort completed.  Ready."
-msgstr "Прервано."
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "Не показывать окно вывода команды"
 
-#: lib/mergetool.tcl:8
-msgid "Force resolution to the base version?"
-msgstr "Использовать базовую версию для разрешения конфликта?"
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Запуск только если показан список изменений ($FILENAME не пусто)"
 
-#: lib/mergetool.tcl:9
-msgid "Force resolution to this branch?"
-msgstr "Использовать версию из этой ветки для разрешения конфликта?"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Укажите название вспомогательной операции."
 
-#: lib/mergetool.tcl:10
-msgid "Force resolution to the other branch?"
-msgstr "Использовать версию из другой ветки для разрешения конфликта?"
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Вспомогательная операция «%s» уже существует."
 
-#: lib/mergetool.tcl:14
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
-"Note that the diff shows only conflicting changes.\n"
-"\n"
-"%s will be overwritten.\n"
-"\n"
-"This operation can be undone only by restarting the merge."
-msgstr "Внимание! Список изменений показывает только конфликтующие отличия.\n\n%s будет переписан.\n\nЭто действие можно отменить только перезапуском операции слияния."
+"Could not add tool:\n"
+"%s"
+msgstr "Ошибка добавления программы:\n%s"
 
-#: lib/mergetool.tcl:45
+#: lib/tools_dlg.tcl:187
 #, tcl-format
-msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr "Похоже, что файл %s содержит неразрешенные конфликты. Продолжить индексацию?"
+msgid "%s (%s): Remove Tool"
+msgstr "%s (%s): Удалить инструмент"
 
-#: lib/mergetool.tcl:60
-#, tcl-format
-msgid "Adding resolution for %s"
-msgstr "Добавляю результат разрешения для %s"
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Удалить команды программы"
 
-#: lib/mergetool.tcl:141
-msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr "Программа слияния не обрабатывает конфликты с удалением или участием ссылок"
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Удалить"
 
-#: lib/mergetool.tcl:146
-msgid "Conflict file does not exist"
-msgstr "Конфликтующий файл не существует"
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Синим выделены программы локальные репозиторию)"
 
-#: lib/mergetool.tcl:264
+#: lib/tools_dlg.tcl:283
 #, tcl-format
-msgid "Not a GUI merge tool: '%s'"
-msgstr "«%s» не является программой слияния"
+msgid "%s (%s):"
+msgstr "%s (%s):"
 
-#: lib/mergetool.tcl:268
+#: lib/tools_dlg.tcl:292
 #, tcl-format
-msgid "Unsupported merge tool '%s'"
-msgstr "Неподдерживаемая программа слияния «%s»"
+msgid "Run Command: %s"
+msgstr "Запуск команды: %s"
 
-#: lib/mergetool.tcl:303
-msgid "Merge tool is already running, terminate it?"
-msgstr "Программа слияния уже работает. Прервать?"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Аргументы"
 
-#: lib/mergetool.tcl:323
-#, tcl-format
-msgid ""
-"Error retrieving versions:\n"
-"%s"
-msgstr "Ошибка получения версий:\n%s"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "OK"
 
-#: lib/mergetool.tcl:343
-#, tcl-format
-msgid ""
-"Could not start the merge tool:\n"
-"\n"
-"%s"
-msgstr "Ошибка запуска программы слияния:\n\n%s"
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Поиск:"
 
-#: lib/mergetool.tcl:347
-msgid "Running merge tool..."
-msgstr "Запуск программы слияния…"
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Дальше"
 
-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
-msgid "Merge tool failed."
-msgstr "Ошибка выполнения программы слияния."
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Обратно"
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
-msgstr "Неверная глобальная кодировка «%s»"
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "Регулярные выражения"
 
-#: lib/option.tcl:19
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "Учёт регистра"
+
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
 #, tcl-format
-msgid "Invalid repo encoding '%s'"
-msgstr "Неверная кодировка репозитория «%s»"
+msgid "%s (%s): Create Desktop Icon"
+msgstr "%s (%s): Создать ярлык на рабочем столе"
 
-#: lib/option.tcl:117
-msgid "Restore Defaults"
-msgstr "Восстановить настройки по умолчанию"
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr "Невозможно записать ссылку:"
 
-#: lib/option.tcl:121
-msgid "Save"
-msgstr "Сохранить"
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr "Невозможно записать значок:"
 
-#: lib/option.tcl:131
+#: lib/remote_branch_delete.tcl:29
 #, tcl-format
-msgid "%s Repository"
-msgstr "Для репозитория %s"
-
-#: lib/option.tcl:132
-msgid "Global (All Repositories)"
-msgstr "Общие (для всех репозиториев)"
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "%s (%s): Удаление внешней ветки"
 
-#: lib/option.tcl:138
-msgid "User Name"
-msgstr "Имя пользователя"
+#: lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Удаление ветки во внешнем репозитории"
 
-#: lib/option.tcl:139
-msgid "Email Address"
-msgstr "Адрес электронной почты"
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
+msgstr "Из репозитория"
 
-#: lib/option.tcl:141
-msgid "Summarize Merge Commits"
-msgstr "Суммарное сообщение при слиянии"
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr "Ветки"
 
-#: lib/option.tcl:142
-msgid "Merge Verbosity"
-msgstr "Уровень детальности сообщений при слиянии"
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr "Удалить только в случае, если"
 
-#: lib/option.tcl:143
-msgid "Show Diffstat After Merge"
-msgstr "Показать отчет об изменениях после слияния"
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr "Слияние с:"
 
-#: lib/option.tcl:144
-msgid "Use Merge Tool"
-msgstr "Использовать для слияния программу"
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Всегда (не выполнять проверку на слияние)"
 
-#: lib/option.tcl:146
-msgid "Trust File Modification Timestamps"
-msgstr "Доверять времени модификации файла"
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr "Для операции «Слияние с» требуется указать ветку."
 
-#: lib/option.tcl:147
-msgid "Prune Tracking Branches During Fetch"
-msgstr "Чистка отслеживаемых веток при извлечении изменений"
+#: lib/remote_branch_delete.tcl:185
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr "Следующие ветки могут быть объединены с %s при помощи операции слияния:\n\n - %s"
 
-#: lib/option.tcl:148
-msgid "Match Tracking Branches"
-msgstr "Такое же имя, как и у отслеживаемой ветки"
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr "Некоторые тесты на слияние не прошли, потому что вы не извлекли необходимые коммиты. Попытайтесь извлечь их из %s."
 
-#: lib/option.tcl:149
-msgid "Blame Copy Only On Changed Files"
-msgstr "Поиск копий только в изменённых файлах"
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
+msgstr "Укажите одну или несколько веток для удаления."
 
-#: lib/option.tcl:150
-msgid "Minimum Letters To Blame Copy On"
-msgstr "Минимальное количество символов для поиска копий"
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr "Восстановить удаленные ветки сложно.\n\nПродолжить?"
 
-#: lib/option.tcl:151
-msgid "Blame History Context Radius (days)"
-msgstr "Радиус исторического контекста (в днях)"
+#: lib/remote_branch_delete.tcl:227
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Удаление веток из %s"
 
-#: lib/option.tcl:152
-msgid "Number of Diff Context Lines"
-msgstr "Число строк в контексте diff"
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
+msgstr "Не указан репозиторий."
 
-#: lib/option.tcl:153
-msgid "Commit Message Text Width"
-msgstr "Ширина текста сообщения коммита"
+#: lib/remote_branch_delete.tcl:305
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Перечитывание %s…"
 
-#: lib/option.tcl:154
-msgid "New Branch Name Template"
-msgstr "Шаблон для имени новой ветки"
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
+msgstr "Git Gui"
 
-#: lib/option.tcl:155
-msgid "Default File Contents Encoding"
-msgstr "Кодировка содержания файла по умолчанию"
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
+msgstr "Создать новый репозиторий"
 
-#: lib/option.tcl:203
-msgid "Change"
-msgstr "Изменить"
+#: lib/choose_repository.tcl:110
+msgid "New..."
+msgstr "Новый…"
 
-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
-msgstr "Словарь для проверки правописания:"
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
+msgstr "Склонировать существующий репозиторий"
 
-#: lib/option.tcl:254
-msgid "Change Font"
-msgstr "Изменить"
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
+msgstr "Клонировать…"
 
-#: lib/option.tcl:258
-#, tcl-format
-msgid "Choose %s"
-msgstr "Выберите %s"
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
+msgstr "Выбрать существующий репозиторий"
 
-#: lib/option.tcl:264
-msgid "pt."
-msgstr "pt."
+#: lib/choose_repository.tcl:141
+msgid "Open..."
+msgstr "Открыть…"
 
-#: lib/option.tcl:278
-msgid "Preferences"
-msgstr "Настройки"
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
+msgstr "Недавние репозитории"
 
-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
-msgstr "Не удалось полностью сохранить настройки:"
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
+msgstr "Открыть последний репозиторий"
 
-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "Удалить ссылку на внешний репозиторий"
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Не удалось создать репозиторий %s:"
 
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "Чистка"
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Создать"
 
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "Извлечение из"
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr "Каталог:"
 
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "Отправить"
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
+msgstr "Репозиторий"
 
-#: lib/remote_add.tcl:19
-msgid "Add Remote"
-msgstr "Зарегистрировать внешний репозиторий"
+#: lib/choose_repository.tcl:487
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "Каталог '%s' уже существует."
 
-#: lib/remote_add.tcl:24
-msgid "Add New Remote"
-msgstr "Добавить внешний репозиторий"
+#: lib/choose_repository.tcl:491
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Файл '%s' уже существует."
 
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
-msgid "Add"
-msgstr "Добавить"
+#: lib/choose_repository.tcl:506
+msgid "Clone"
+msgstr "Склонировать"
 
-#: lib/remote_add.tcl:37
-msgid "Remote Details"
-msgstr "Информация о внешнем репозитории"
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
+msgstr "Исходное положение:"
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
-msgstr "Положение:"
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr "Каталог назначения:"
 
-#: lib/remote_add.tcl:62
-msgid "Further Action"
-msgstr "Следующая операция"
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr "Тип клона:"
 
-#: lib/remote_add.tcl:65
-msgid "Fetch Immediately"
-msgstr "Сразу извлечь изменения"
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Стандартный (Быстрый, полуизбыточный, «жесткие» ссылки)"
 
-#: lib/remote_add.tcl:71
-msgid "Initialize Remote Repository and Push"
-msgstr "Инициализировать внешний репозиторий и отправить"
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Полная копия (Медленный, создает резервную копию)"
 
-#: lib/remote_add.tcl:77
-msgid "Do Nothing Else Now"
-msgstr "Больше ничего не делать"
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Общий (Самый быстрый, не рекомендуется, без резервной копии)"
 
-#: lib/remote_add.tcl:101
-msgid "Please supply a remote name."
-msgstr "Укажите название внешнего репозитория."
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
+msgstr "Также рекурсивно клонировать подмодули"
 
-#: lib/remote_add.tcl:114
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
 #, tcl-format
-msgid "'%s' is not an acceptable remote name."
-msgstr "«%s» не является допустимым именем внешнего репозитория."
+msgid "Not a Git repository: %s"
+msgstr "Каталог не является репозиторием Git: %s"
 
-#: lib/remote_add.tcl:125
-#, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Не удалось добавить «%s» из «%s». "
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
+msgstr "Стандартный клон возможен только для локального репозитория."
 
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
-msgstr "извлечение %s"
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
+msgstr "Общий клон возможен только для локального репозитория."
 
-#: lib/remote_add.tcl:134
+#: lib/choose_repository.tcl:655
 #, tcl-format
-msgid "Fetching the %s"
-msgstr "Извлечение %s"
+msgid "Location %s already exists."
+msgstr "Путь %s уже существует."
 
-#: lib/remote_add.tcl:157
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Невозможно инициализировать репозиторий в «%s»."
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr "Не удалось сконфигурировать исходный репозиторий"
+
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr "Подсчёт объектов"
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr "блоки"
+
+#: lib/choose_repository.tcl:703
 #, tcl-format
-msgid "push %s"
-msgstr "отправить %s"
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Не удалось скопировать objects/info/alternates: %s"
 
-#: lib/remote_add.tcl:164
+#: lib/choose_repository.tcl:740
 #, tcl-format
-msgid "Setting up the %s (at %s)"
-msgstr "Настройка %s (в %s)"
+msgid "Nothing to clone from %s."
+msgstr "Нечего клонировать с %s."
 
-#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Branch Remotely"
-msgstr "Удаление ветки во внешнем репозитории"
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
+msgstr "Не инициализирована ветка «master»."
 
-#: lib/remote_branch_delete.tcl:47
-msgid "From Repository"
-msgstr "Из репозитория"
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Жесткие ссылки недоступны. Будет использовано копирование."
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
-msgid "Remote:"
-msgstr "внешний:"
+#: lib/choose_repository.tcl:769
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Клонирование из %s"
 
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
-msgid "Arbitrary Location:"
-msgstr "Указанное положение:"
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
+msgstr "Копирование объектов"
 
-#: lib/remote_branch_delete.tcl:84
-msgid "Branches"
-msgstr "Ветки"
+#: lib/choose_repository.tcl:801
+msgid "KiB"
+msgstr "КБ"
 
-#: lib/remote_branch_delete.tcl:109
-msgid "Delete Only If"
-msgstr "Удалить только в случае, если"
+#: lib/choose_repository.tcl:825
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Не могу скопировать объект: %s"
 
-#: lib/remote_branch_delete.tcl:111
-msgid "Merged Into:"
-msgstr "Слияние с:"
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
+msgstr "Создание ссылок на objects"
 
-#: lib/remote_branch_delete.tcl:152
-msgid "A branch is required for 'Merged Into'."
-msgstr "Для операции «Слияние с» требуется указать ветку."
+#: lib/choose_repository.tcl:838
+msgid "objects"
+msgstr "объекты"
 
-#: lib/remote_branch_delete.tcl:184
+#: lib/choose_repository.tcl:846
 #, tcl-format
-msgid ""
-"The following branches are not completely merged into %s:\n"
-"\n"
-" - %s"
-msgstr "Следующие ветки могут быть объединены с %s при помощи операции слияния:\n\n - %s"
+msgid "Unable to hardlink object: %s"
+msgstr "Не могу создать «жесткую ссылку» на объект: %s"
 
-#: lib/remote_branch_delete.tcl:189
-#, tcl-format
-msgid ""
-"One or more of the merge tests failed because you have not fetched the "
-"necessary commits.  Try fetching from %s first."
-msgstr "Некоторые тесты на слияние не прошли, потому что вы не извлекли необходимые коммиты. Попытайтесь извлечь их из %s."
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
+msgstr "Не удалось извлечь ветки и объекты. Дополнительная информация на консоли."
 
-#: lib/remote_branch_delete.tcl:207
-msgid "Please select one or more branches to delete."
-msgstr "Укажите одну или несколько веток для удаления."
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "Не удалось извлечь метки. Дополнительная информация на консоли."
+
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "Не могу определить HEAD. Дополнительная информация на консоли."
 
-#: lib/remote_branch_delete.tcl:226
+#: lib/choose_repository.tcl:947
 #, tcl-format
-msgid "Deleting branches from %s"
-msgstr "Удаление веток из %s"
+msgid "Unable to cleanup %s"
+msgstr "Не могу очистить %s"
 
-#: lib/remote_branch_delete.tcl:292
-msgid "No repository selected."
-msgstr "Не указан репозиторий."
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
+msgstr "Клонирование не удалось."
+
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
+msgstr "Ветка по умолчанию не была получена."
 
-#: lib/remote_branch_delete.tcl:297
+#: lib/choose_repository.tcl:971
 #, tcl-format
-msgid "Scanning %s..."
-msgstr "Перечитывание %s…"
+msgid "Cannot resolve %s as a commit."
+msgstr "Не могу распознать %s как коммит."
 
-#: lib/search.tcl:21
-msgid "Find:"
-msgstr "Поиск:"
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr "Создаю рабочий каталог"
 
-#: lib/search.tcl:23
-msgid "Next"
-msgstr "Дальше"
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr "Не удалось получить начальное состояние файлов репозитория."
 
-#: lib/search.tcl:24
-msgid "Prev"
-msgstr "Обратно"
+#: lib/choose_repository.tcl:1072
+msgid "Cloning submodules"
+msgstr "Клонирование подмодулей"
 
-#: lib/search.tcl:25
-msgid "Case-Sensitive"
-msgstr "Игн. большие/маленькие"
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr "Не удалось клонировать подмодули."
 
-#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
-msgid "Cannot write shortcut:"
-msgstr "Невозможно записать ссылку:"
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr "Репозиторий:"
 
-#: lib/shortcut.tcl:137
-msgid "Cannot write icon:"
-msgstr "Невозможно записать значок:"
+#: lib/choose_repository.tcl:1159
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Не удалось открыть репозиторий %s:"
 
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
-msgstr "Неподдерживаемая программа проверки правописания"
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - графический пользовательский интерфейс к Git."
 
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
-msgstr "Проверка правописания не доступна"
+#: lib/blame.tcl:74
+#, tcl-format
+msgid "%s (%s): File Viewer"
+msgstr "%s (%s): Просмотр файла"
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
-msgstr "Неправильная конфигурация программы проверки правописания"
+#: lib/blame.tcl:80
+msgid "Commit:"
+msgstr "Коммит:"
 
-#: lib/spellcheck.tcl:70
-#, tcl-format
-msgid "Reverting dictionary to %s."
-msgstr "Словарь вернут к %s."
+#: lib/blame.tcl:282
+msgid "Copy Commit"
+msgstr "Копировать SHA-1"
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
-msgstr "Программа проверки правописания не смогла запуститься"
+#: lib/blame.tcl:286
+msgid "Find Text..."
+msgstr "Найти текст…"
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
-msgstr "Нераспознанная программа проверки правописания"
+#: lib/blame.tcl:290
+msgid "Goto Line..."
+msgstr "Перейти на строку…"
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
-msgstr "Исправлений не найдено"
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
+msgstr "Провести полный поиск копий"
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
-msgstr "Программа проверки правописания прервала передачу данных"
+#: lib/blame.tcl:303
+msgid "Show History Context"
+msgstr "Показать исторический контекст"
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
-msgstr "Ошибка проверки правописания"
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
+msgstr "Авторы родительского коммита"
 
-#: lib/sshkey.tcl:31
+#: lib/blame.tcl:468
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Чтение %s…"
+
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
+msgstr "Загрузка аннотации копирований/переименований…"
+
+#: lib/blame.tcl:613
+msgid "lines annotated"
+msgstr "строк прокомментировано"
+
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
+msgstr "Загрузка аннотаций первоначального положения объекта…"
+
+#: lib/blame.tcl:818
+msgid "Annotation complete."
+msgstr "Аннотация завершена."
+
+#: lib/blame.tcl:849
+msgid "Busy"
+msgstr "Занят"
+
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
+msgstr "Аннотация уже запущена"
+
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
+msgstr "Выполнение полного поиска копий…"
+
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
+msgstr "Загрузка аннотации…"
+
+#: lib/blame.tcl:1010
+msgid "Author:"
+msgstr "Автор:"
+
+#: lib/blame.tcl:1014
+msgid "Committer:"
+msgstr "Коммитер:"
+
+#: lib/blame.tcl:1019
+msgid "Original File:"
+msgstr "Исходный файл:"
+
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
+msgstr "Не удалось найти текущее состояние:"
+
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
+msgstr "Не удалось найти родительское состояние:"
+
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
+msgstr "Не могу показать предка"
+
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
+msgstr "Ошибка загрузки изменений:"
+
+#: lib/blame.tcl:1279
+msgid "Originally By:"
+msgstr "Источник:"
+
+#: lib/blame.tcl:1285
+msgid "In File:"
+msgstr "Файл:"
+
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
+msgstr "Скопировано/перемещено в:"
+
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have the same state."
+msgstr "Изменений не обнаружено.\n\nв %s отсутствуют изменения.\n\nДата изменения файла была обновлена другой программой, но содержимое файла осталось прежним.\n\nСейчас будет запущено перечитывание репозитория, чтобы найти подобные файлы."
+
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Загрузка изменений %s…"
+
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr "ЛОКАЛЬНО: удалён\nВНЕШНИЙ:\n"
+
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr "ВНЕШНИЙ: удалён\nЛОКАЛЬНО:\n"
+
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
+msgstr "ЛОКАЛЬНО:\n"
+
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
+msgstr "ВНЕШНИЙ:\n"
+
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Не могу показать %s"
+
+#: lib/diff.tcl:221
+msgid "Error loading file:"
+msgstr "Ошибка загрузки файла:"
+
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
+msgstr "Репозиторий Git (подпроект)"
+
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
+msgstr "* Двоичный файл (содержимое не показано)"
+
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr "* Размер неотслеживаемого файла %d байт.\n* Показано первых %d байт.\n"
+
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr "\n* Неотслеживаемый файл обрезан: %s.\n* Чтобы увидеть весь файл, используйте внешний редактор.\n"
+
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
+msgstr "Не удалось исключить выбранную часть."
+
+#: lib/diff.tcl:591
+msgid "Failed to revert selected hunk."
+msgstr "Не удалось обратить изменения выбранного блока."
+
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
+msgstr "Не удалось проиндексировать выбранный блок изменений."
+
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
+msgstr "Не удалось исключить выбранную строку."
+
+#: lib/diff.tcl:696
+msgid "Failed to revert selected line."
+msgstr "Не удалось обратить изменения выбраной строки."
+
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
+msgstr "Не удалось проиндексировать выбранную строку."
+
+#: lib/diff.tcl:889
+msgid "Failed to undo last revert."
+msgstr "Не удалось отменить посленднее обращение изменений."
+
+#: lib/sshkey.tcl:34
 msgid "No keys found."
 msgstr "Ключ не найден"
 
-#: lib/sshkey.tcl:34
+#: lib/sshkey.tcl:37
 #, tcl-format
 msgid "Found a public key in: %s"
 msgstr "Публичный ключ из %s"
 
-#: lib/sshkey.tcl:40
+#: lib/sshkey.tcl:43
 msgid "Generate Key"
 msgstr "Создать ключ"
 
-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:61
 msgid "Copy To Clipboard"
 msgstr "Скопировать в буфер обмена"
 
-#: lib/sshkey.tcl:70
-msgid "Your OpenSSH Public Key"
-msgstr "Ваш публичный ключ OpenSSH"
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
+msgstr "Ваш публичный ключ OpenSSH"
+
+#: lib/sshkey.tcl:83
+msgid "Generating..."
+msgstr "Создание…"
+
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr "Ошибка запуска ssh-keygen:\n\n%s"
+
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
+msgstr "Ключ не создан."
+
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
+msgstr "Создание ключа завершилось, но результат не был найден"
+
+#: lib/sshkey.tcl:126
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Ваш ключ находится в: %s"
+
+#: lib/branch_create.tcl:23
+#, tcl-format
+msgid "%s (%s): Create Branch"
+msgstr "%s (%s): Создание ветки"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Создать новую ветку"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Имя ветки"
+
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "Соответствовать имени отслеживаемой ветки"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Начальная версия"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Обновить имеющуюся ветку:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Нет"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Только Fast Forward"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "После создания сделать текущей"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Укажите отлеживаемую ветку."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Отслеживаемая ветка %s не является веткой на внешнем репозитории."
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "В процессе… пожалуйста, ждите…"
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Процесс успешно завершен"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Ошибка: не удалось выполнить команду"
+
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "Перейти на строку:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "Перейти"
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Текущее отсоединенное состояние"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Выражение для определения версии:"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Локальная ветка:"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "Отслеживаемая ветка"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Метка"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Неверная версия: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Версия не указана."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "Пустое выражение для определения версии."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Обновлено"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "Ссылка"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this to amend.\n"
+msgstr "Отсутствует коммиты для исправления.\n\nВы создаете начальный коммит, здесь еще нечего исправлять.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.\n"
+msgstr "Невозможно исправить коммит во время слияния.\n\nТекущее слияние не завершено. Невозможно исправить предыдуий коммит, не прерывая эту операцию.\n"
+
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
+msgstr "Ошибка при загрузке данных для исправления коммита:"
+
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
+msgstr "Невозможно получить информацию об авторстве:"
+
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Недопустимый GIT_COMMITTER_IDENT:"
+
+#: lib/commit.tcl:138
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "предупреждение: Tcl не поддерживает кодировку «%s»."
+
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь. \n\nЭто будет сделано сейчас автоматически.\n"
+
+#: lib/commit.tcl:182
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file before committing.\n"
+msgstr "Нельзя выполнить коммит с незавершённой операцией слияния.\n\nДля файла %s возник конфликт слияния. Разрешите конфликт и добавьте их в индекс перед выполнением коммита.\n"
+
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr "Обнаружено неизвестное состояние файла %s.\n\nФайл %s не может быть закоммичен этой программой.\n"
+
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr "Отсутствуют изменения для сохранения.\n\nДобавьте в индекс хотя бы один файл перед выполнением коммита.\n"
+
+#: lib/commit.tcl:213
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr "Укажите сообщение коммита.\n\nРекомендуется следующий формат сообщения:\n\n- в первой строке краткое описание сделанных изменений\n- вторая строка пустая\n- в оставшихся строках опишите, что дают ваши изменения\n"
+
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
+msgstr "Вызов перехватчика pre-commit…"
+
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
+msgstr "Коммит прерван переватчиком pre-commit."
+
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous thing to do because if you switch to another branch you will lose your changes and it can be difficult to retrieve them later from the reflog. You should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr "Вы собираетесь сделать коммит в отделённый HEAD. Это действие потенциально опасно, так как если вы переключитесь на другую ветку после этого, то вы потеряете свои изменения и их сложно будет потом найти с помощью журнала ссылок (reflog). Вам скорее всего следует отменить этот коммит и создать новую ветку до продолжения.\n \n Вы действительно хотите продолжить и создать коммит?"
+
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
+msgstr "Вызов перехватчика commit-msg…"
+
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
+msgstr "Коммит прерван переватчиком commit-msg"
+
+#: lib/commit.tcl:327
+msgid "Committing changes..."
+msgstr "Коммит изменений…"
+
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
+msgstr "Программа write-tree завершилась с ошибкой:"
 
-#: lib/sshkey.tcl:78
-msgid "Generating..."
-msgstr "Создание…"
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
+msgstr "Не удалось закоммитить изменения."
 
-#: lib/sshkey.tcl:84
+#: lib/commit.tcl:362
 #, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Коммит %s похоже поврежден"
+
+#: lib/commit.tcl:367
 msgid ""
-"Could not start ssh-keygen:\n"
+"No changes to commit.\n"
 "\n"
-"%s"
-msgstr "Ошибка запуска ssh-keygen:\n\n%s"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr "Нет изменения для коммита.\n\nНи один файл не был изменен и не было слияния.\n\nСейчас автоматически запустится перечитывание репозитория.\n"
 
-#: lib/sshkey.tcl:111
-msgid "Generation failed."
-msgstr "Ключ не создан."
+#: lib/commit.tcl:374
+msgid "No changes to commit."
+msgstr "Нет изменения для коммита."
 
-#: lib/sshkey.tcl:118
-msgid "Generation succeeded, but no keys found."
-msgstr "Создание ключа завершилось, но результат не был найден"
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
+msgstr "Программа commit-tree завершилась с ошибкой:"
 
-#: lib/sshkey.tcl:121
-#, tcl-format
-msgid "Your key is in: %s"
-msgstr "Ваш ключ находится в: %s"
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
+msgstr "Программа update-ref завершилась с ошибкой:"
 
-#: lib/status_bar.tcl:83
+#: lib/commit.tcl:514
 #, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s … %*i из %*i %s (%3i%%)"
+msgid "Created commit %s: %s"
+msgstr "Создан коммит %s: %s "
 
-#: lib/tools.tcl:75
+#: lib/branch_delete.tcl:16
 #, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "Запуск %s требует выбранного файла."
+msgid "%s (%s): Delete Branch"
+msgstr "%s (%s): Удаление ветки"
 
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "Действительно запустить %s?"
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Удалить локальную ветку"
 
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "Вспомогательная операция: %s"
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Локальные ветки"
 
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "Выполнение: %s"
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Удалить только в случае, если было слияние с"
 
-#: lib/tools.tcl:149
+#: lib/branch_delete.tcl:103
 #, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "Программа %s завершилась успешно."
+msgid "The following branches are not completely merged into %s:"
+msgstr "Ветки, которые не полностью сливаются с %s:"
 
-#: lib/tools.tcl:151
+#: lib/branch_delete.tcl:131
 #, tcl-format
-msgid "Tool failed: %s"
-msgstr "Ошибка выполнения программы: %s"
+msgid " - %s:"
+msgstr " — %s:"
 
-#: lib/tools_dlg.tcl:22
-msgid "Add Tool"
-msgstr "Добавить вспомогательную операцию"
-
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
-msgstr "Новая вспомогательная операция"
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr "Не удалось удалить ветки:\n%s"
 
-#: lib/tools_dlg.tcl:33
-msgid "Add globally"
-msgstr "Добавить для всех репозиториев"
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Неправильная дата в репозитории: %s"
 
-#: lib/tools_dlg.tcl:45
-msgid "Tool Details"
-msgstr "Описание вспомогательной операции"
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "Количество несвязанных объектов"
 
-#: lib/tools_dlg.tcl:48
-msgid "Use '/' separators to create a submenu tree:"
-msgstr "Используйте «/» для создания подменю"
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Объем дискового пространства, занятый несвязанными объектами"
 
-#: lib/tools_dlg.tcl:61
-msgid "Command:"
-msgstr "Команда:"
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "Количество упакованных объектов"
 
-#: lib/tools_dlg.tcl:74
-msgid "Show a dialog before running"
-msgstr "Показать диалог перед запуском"
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "Количество pack-файлов"
 
-#: lib/tools_dlg.tcl:80
-msgid "Ask the user to select a revision (sets $REVISION)"
-msgstr "Запрос на выбор версии (устанавливает $REVISION)"
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Объем дискового пространства, занятый упакованными объектами"
 
-#: lib/tools_dlg.tcl:85
-msgid "Ask the user for additional arguments (sets $ARGS)"
-msgstr "Запрос дополнительных аргументов (устанавливает $ARGS)"
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Несвязанные объекты, которые можно удалить"
 
-#: lib/tools_dlg.tcl:92
-msgid "Don't show the command output window"
-msgstr "Не показывать окно вывода команды"
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "Мусор"
 
-#: lib/tools_dlg.tcl:97
-msgid "Run only if a diff is selected ($FILENAME not empty)"
-msgstr "Запуск только если показан список изменений ($FILENAME не пусто)"
+#: lib/database.tcl:66
+#, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr "%s (%s): Статистика базы данных"
 
-#: lib/tools_dlg.tcl:121
-msgid "Please supply a name for the tool."
-msgstr "Укажите название вспомогательной операции."
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Сжатие базы объектов"
 
-#: lib/tools_dlg.tcl:129
-#, tcl-format
-msgid "Tool '%s' already exists."
-msgstr "Вспомогательная операция «%s» уже существует."
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Проверка базы объектов при помощи fsck"
 
-#: lib/tools_dlg.tcl:151
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
-"Could not add tool:\n"
-"%s"
-msgstr "Ошибка добавления программы:\n%s"
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress the database.\n"
+"\n"
+"Compress the database now?"
+msgstr "Этот репозиторий сейчас содержит примерно %i свободных объектов\n\nДля лучшей производительности рекомендуется сжать базу данных.\n\nСжать базу данных сейчас?"
 
-#: lib/tools_dlg.tcl:190
-msgid "Remove Tool"
-msgstr "Удалить программу"
+#: lib/error.tcl:20
+#, tcl-format
+msgid "%s: error"
+msgstr "%s: ошибка"
 
-#: lib/tools_dlg.tcl:196
-msgid "Remove Tool Commands"
-msgstr "Удалить команды программы"
+#: lib/error.tcl:36
+#, tcl-format
+msgid "%s: warning"
+msgstr "%s: предупреждение"
 
-#: lib/tools_dlg.tcl:200
-msgid "Remove"
-msgstr "Удалить"
+#: lib/error.tcl:80
+#, tcl-format
+msgid "%s hook failed:"
+msgstr "ошибка перехватчика %s:"
 
-#: lib/tools_dlg.tcl:236
-msgid "(Blue denotes repository-local tools)"
-msgstr "(Синим выделены программы локальные репозиторию)"
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr "Перед коммитом, исправьте вышеуказанные ошибки."
 
-#: lib/tools_dlg.tcl:297
+#: lib/error.tcl:116
 #, tcl-format
-msgid "Run Command: %s"
-msgstr "Запуск команды: %s"
+msgid "%s (%s): error"
+msgstr "%s (%s): ошибка"
 
-#: lib/tools_dlg.tcl:311
-msgid "Arguments"
-msgstr "Аргументы"
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr "Невозможно выполнить слияние во время исправления.\n\nЗавершите исправление данного коммита перед выполнением операции слияния.\n"
 
-#: lib/tools_dlg.tcl:348
-msgid "OK"
-msgstr "OK"
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем слияние может быть сделано.\n\nЭто будет сделано сейчас автоматически.\n"
 
-#: lib/transport.tcl:7
+#: lib/merge.tcl:45
 #, tcl-format
-msgid "Fetching new changes from %s"
-msgstr "Извлечение изменений из %s "
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current merge.  Only then can you begin another merge.\n"
+msgstr "Предыдущее слияние не завершено из-за конфликта.\n\nДля файла %s возник конфликт слияния.\n\nРазрешите конфликт, добавьте файл в индекс и закоммитьте. Только после этого можно начать следующее слияние.\n"
 
-#: lib/transport.tcl:18
+#: lib/merge.tcl:55
 #, tcl-format
-msgid "remote prune %s"
-msgstr "чистка внешнего %s"
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.\n"
+msgstr "Вы находитесь в процессе изменений.\n\nФайл %s изменён.\n\nВы должны завершить текущий коммит перед началом слияния. В случае необходимости, это позволит прервать операцию слияния.\n"
 
-#: lib/transport.tcl:19
+#: lib/merge.tcl:108
 #, tcl-format
-msgid "Pruning tracking branches deleted from %s"
-msgstr "Чистка отслеживаемых веток, удалённых из %s"
+msgid "%s of %s"
+msgstr "%s из %s"
 
-#: lib/transport.tcl:26
+#: lib/merge.tcl:126
 #, tcl-format
-msgid "Pushing changes to %s"
-msgstr "Отправка изменений в %s "
+msgid "Merging %s and %s..."
+msgstr "Слияние %s и %s…"
+
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
+msgstr "Слияние успешно завершено."
+
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Не удалось завершить слияние. Требуется разрешение конфликта."
 
-#: lib/transport.tcl:64
+#: lib/merge.tcl:156
 #, tcl-format
-msgid "Mirroring to %s"
-msgstr "Точное копирование в %s"
+msgid "%s (%s): Merge"
+msgstr "%s (%s): Слияние"
 
-#: lib/transport.tcl:82
+#: lib/merge.tcl:164
 #, tcl-format
-msgid "Pushing %s %s to %s"
-msgstr "Отправка %s %s в %s"
+msgid "Merge Into %s"
+msgstr "Слияние с %s"
 
-#: lib/transport.tcl:100
-msgid "Push Branches"
-msgstr "Отправить ветки"
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
+msgstr "Версия, с которой провести слияние"
 
-#: lib/transport.tcl:114
-msgid "Source Branches"
-msgstr "Исходные ветки"
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr "Невозможно прервать исправление.\n\nЗавершите текущее исправление коммита.\n"
 
-#: lib/transport.tcl:131
-msgid "Destination Repository"
-msgstr "Репозиторий назначения"
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr "Прервать операцию слияния?\n\nПрерывание текущего слияния приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
 
-#: lib/transport.tcl:169
-msgid "Transfer Options"
-msgstr "Настройки отправки"
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr "Сбросить изменения?\n\nСброс изменений приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
 
-#: lib/transport.tcl:171
-msgid "Force overwrite existing branch (may discard changes)"
-msgstr "Принудительно перезаписать существующую ветку (возможна потеря изменений)"
+#: lib/merge.tcl:246
+msgid "Aborting"
+msgstr "Прерываю"
 
-#: lib/transport.tcl:175
-msgid "Use thin pack (for slow network connections)"
-msgstr "Использовать thin pack (для медленных сетевых подключений)"
+#: lib/merge.tcl:247
+msgid "files reset"
+msgstr "изменения в файлах отменены"
 
-#: lib/transport.tcl:179
-msgid "Include tags"
-msgstr "Передать метки"
+#: lib/merge.tcl:277
+msgid "Abort failed."
+msgstr "Прервать не удалось."
+
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
+msgstr "Прервано."
-- 
2.24.0.windows.2

