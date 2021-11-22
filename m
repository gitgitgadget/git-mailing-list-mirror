Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E8C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 06:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhKVGuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 01:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhKVGuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 01:50:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3BC061714
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12672274wme.4
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NlM7hMcSYyZ4wuTr9eICUuvxg21IuQSXmqPCWX3uykc=;
        b=E3EnzchhSarzYN90OYXB+pD00Ji+QzIXsyuf0LH3R62DA4M/KbID6yYJTUKCFW/rNm
         ZbmpEZfcp6X/TMDY39dLuNfK2PZNa99KcLpKh5InQ1SG7BAy7/1vRMXXdi+yaxsj0mIp
         HDa0gnDTjBSIVRCWrIhIUhevnk5jpFtq8f0BH9F0kECNzlxmUjCFqJpdwKEnt6F8skgg
         zhxYqqUv9HSGpY0mlwGcDYinxIrRfi8I+R+7knY+A/IiKaNUlQt93kIRUKr5pcPWl9yA
         sAunFrY0zCrOSrvQq2OIzAbR+jk+Fw6/qlabmUAYkD9+zvjpxUz3jtHvTSMhmAPSZVIp
         xDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NlM7hMcSYyZ4wuTr9eICUuvxg21IuQSXmqPCWX3uykc=;
        b=6/VnVi0Ts8SWBKU8KgNxXpOKPt080Geb8KUzVpiKak/qA2qVHdVLK14DtyD9wFN5Tz
         kTntG12tE17hY7Rwv8MLd0x/laGD0+deSmdnGIWz9ZUWQUsNFjnS025qrpltdkEvfaRP
         htiWxdcbl048d8g+bjSaYfp01jQXGOeKNkj+xu2lAcMmPDJWnjsEwOsf/fujrQhNRCRI
         +kudiW947FqLUxiGjN/le2nEP+4f+7OqpjSUXRk/c+aLyTp9UfLjycM5g5Z5v09Cse4D
         O1QtBHM6R5tFGITrMk81fxt4zUuV4W2jSrBOwu78WGsXP79B7+9mWNCPeD8dMPlBM9y1
         QbWA==
X-Gm-Message-State: AOAM531OhB8Jt5Q3uGn7T4cZIW9ZHZBYfT3LriaBBpsGrao0BZwizl7V
        yzOD+os4DaZV+ghczJ65Yurvu1AzySI=
X-Google-Smtp-Source: ABdhPJwRM1wS1pEfICKJflBTO9FsS2qihMDZVibgQFAEMj7JELPs0DJqVYNm2VsLjdIr4ILDICiDmg==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr25825787wmh.60.1637563613139;
        Sun, 21 Nov 2021 22:46:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm22463847wmq.38.2021.11.21.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 22:46:52 -0800 (PST)
Message-Id: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 06:46:49 +0000
Subject: [PATCH v8 0/2] am: support --empty=(die|drop|keep) option to handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. update code according to the seen branch
 2. fix wrong document of git-am

----------------------------------------------------------------------------

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches

 Documentation/git-am.txt           |  8 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 55 +++++++++++++++++++++++++++---
 t/t4150-am.sh                      | 49 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 6 deletions(-)


base-commit: ca35af825273b98fc8dc11527488952f5db8eb80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v7:

 1:  d612bc49d57 ! 1:  5d98a088e14 doc: git-format-patch: describe the option --always
     @@ Commit message
          This commit has described how to use '--always' option in the command
          'git-format-patch' to include patches for commits that emit no changes.
      
     -    Signed-off-by: Aleen <aleen42@vip.qq.com>
     +    Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
      
       ## Documentation/git-format-patch.txt ##
      @@ Documentation/git-format-patch.txt: SYNOPSIS
 2:  9e60e77c041 ! 2:  3ff18e16a7a am: support --empty=<option> to handle empty patches
     @@ Commit message
          those empty patches. In this commit, we have implemented three
          valid options ('die', 'drop' and 'keep').
      
     -    Signed-off-by: Aleen <aleen42@vip.qq.com>
     +    Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
      
       ## Documentation/git-am.txt ##
      @@ Documentation/git-am.txt: SYNOPSIS
     @@ Documentation/git-am.txt: OPTIONS
       --quoted-cr=<action>::
       	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
     -+--empty-commit=(die|drop|keep)::
     ++--empty=(die|drop|keep)::
      +	By default, or when the option is set to 'die', the command
      +	errors out on an input e-mail message that lacks a patch. When
      +	this option is set to 'drop', skip such an e-mail message instead.
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       			N_("(internal use for git-rebase)")),
       		OPT_END()
      
     - ## po/bg.po ##
     -@@ po/bg.po: msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr ""
     - "Индексът не е чист: кръпките не може да бъдат приложени (замърсени са: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Прилагане: %.*s"
     -
     - ## po/ca.po ##
     -@@ po/ca.po: msgstr "no s'ha pogut escriure el fitxer d'índex"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Índex brut: no es poden aplicar pedaços (bruts: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "S'està aplicant: %.*s"
     -
     - ## po/de.po ##
     -@@ po/de.po: msgstr "Konnte Index-Datei nicht schreiben."
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Geänderter Index: kann Patches nicht anwenden (geändert: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Wende an: %.*s"
     -
     - ## po/el.po ##
     -@@ po/el.po: msgstr "Να γίνει εφαρμογή; [y]es/[n]o/[e]dit/[v]iew patch/[a]ccep
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr ""
     - 
     --#: builtin/am.c:1749 builtin/am.c:1817
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr ""
     -
     - ## po/es.po ##
     -@@ po/es.po: msgstr "no es posible escribir el archivo índice"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Índice sucio: no se puede aplicar parches (sucio: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Aplicando: %.*s"
     -
     - ## po/fr.po ##
     -@@ po/fr.po: msgstr "impossible d'écrire le fichier d'index"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Index sale : impossible d'appliquer des patchs (sales : %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Application de  %.*s"
     -
     - ## po/git.pot ##
     -@@ po/git.pot: msgstr ""
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr ""
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr ""
     -
     - ## po/id.po ##
     -@@ po/id.po: msgstr "tidak dapat menulis berkas indeks"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Indeks kotor: tidak dapat menerapkan tambalan (kotor: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Menerapkan: %.*s"
     -
     - ## po/it.po ##
     -@@ po/it.po: msgstr "impossibile scrivere il file indice"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Indice sporco: impossibile applicare le patch (elemento sporco: %s)"
     - 
     --#: builtin/am.c:1761 builtin/am.c:1829
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Applicazione in corso: %.*s"
     -
     - ## po/ko.po ##
     -@@ po/ko.po: msgstr "적용? 예[y]/아니오[n]/편집[e]/패치 보기[v]/모두 적용[a]:
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "변경된 인덱스: 패치를 적용할 수 없습니다 (dirty: %s)"
     - 
     --#: builtin/am.c:1808 builtin/am.c:1879
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "적용하는 중: %.*s"
     -
     - ## po/pl.po ##
     -@@ po/pl.po: msgstr "nie można zapisać pliku indeksu"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Brudny indeks: nie można zastosować łatek (brudny: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Stosowanie: %.*s"
     -
     - ## po/pt_PT.po ##
     -@@
     - #   bisect                           |  bisetar
     - #   blame                            |  blame
     - #   blob object                      |  objeto-blob
     --#   branch                           |  ramo 
     -+#   branch                           |  ramo
     - #   bug                              |  bug
     - #   bundle                           |  conjunto
     - #   bypass                           |  desviar
     -@@
     - #   loose refs                       |  refs soltas
     - #   mark                             |  marca
     - #   master                           |  master
     --#   merge                            |  junção 
     -+#   merge                            |  junção
     - #   mergetag                         |  etiqueta-junção
     - #   object                           |  objeto
     - #   object database                  |  base dados de objeto
     -@@
     - #   token                            |  token
     - #   unset                            |  desdefinir
     - #   untrack                          |  desmonitorizar
     --#   
     -+#
     - #
     - msgid ""
     - msgstr ""
     -@@ po/pt_PT.po: msgstr "incapaz escrever ficheiro de index"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Index sujo: incapaz aplicar patches (sujo: %s)"
     - 
     --#: builtin/am.c:1797 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "A aplicar: %.*s"
     -
     - ## po/ru.po ##
     -@@
     - # SOME DESCRIPTIVE TITLE.
     - # Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
     - # This file is distributed under the same license as the PACKAGE package.
     --# 
     -+#
     - # Translators:
     - # Alexander Golubev <fatzer2@gmail.com>, 2020
     - # Dimitriy Ryazantcev <DJm00n@mail.ru>, 2014-2021
     -@@ po/ru.po: msgstr "не удалось записать индекс"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Индекс изменён: нельзя применять патчи (изменено: %s)"
     - 
     --#: builtin/am.c:1748 builtin/am.c:1816
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Применение: %.*s"
     -
     - ## po/sv.po ##
     -@@ po/sv.po: msgstr "kan inte skriva indexfil"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Smutsigt index: kan inte tillämpa patchar (smutsiga: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Tillämpar: %.*s"
     -
     - ## po/tr.po ##
     -@@ po/tr.po: msgstr "indeks dosyası yazılamıyor"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Kirli indeks: Yamalar uygulanamıyor (kirli: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Uygulanıyor: %.*s"
     -
     - ## po/vi.po ##
     -@@ po/vi.po: msgstr "không thể ghi tập tin lưu mục lục"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "Bảng mục lục bẩn: không thể áp dụng các miếng vá (bẩn: %s)"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "Áp dụng: %.*s"
     -
     - ## po/zh_CN.po ##
     -@@ po/zh_CN.po: msgstr "坏的索引文件 sha1 签名"
     - msgid "index uses %.4s extension, which we do not understand"
     - msgstr "索引使用不被支持的 %.4s 扩展"
     - 
     --# 	
     -+#
     - #: read-cache.c:1834
     - #, c-format
     - msgid "ignoring %.4s extension"
     -@@ po/zh_CN.po: msgstr "无法写入索引文件"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "脏索引：不能应用补丁（脏文件：%s）"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "应用：%.*s"
     - 
     -+#: builtin/am.c:1818
     -+#, c-format
     -+msgid "Skipping: %.*s"
     -+msgstr "跳过：%.*s"
     -+
     - #: builtin/am.c:1815
     - msgid "No changes -- Patch already applied."
     - msgstr "没有变更 —— 补丁已经应用过。"
     -
     - ## po/zh_TW.po ##
     -@@ po/zh_TW.po: msgstr "無法寫入索引檔案"
     - msgid "Dirty index: cannot apply patches (dirty: %s)"
     - msgstr "髒索引：不能套用修補檔（髒檔案：%s）"
     - 
     --#: builtin/am.c:1798 builtin/am.c:1865
     -+#: builtin/am.c:1834 builtin/am.c:1902
     - #, c-format
     - msgid "Applying: %.*s"
     - msgstr "套用：%.*s"
     - 
     -+#: builtin/am.c:1818
     -+#, c-format
     -+msgid "Skipping: %.*s"
     -+msgstr "忽略：%.*s"
     -+
     - #: builtin/am.c:1815
     - msgid "No changes -- Patch already applied."
     - msgstr "沒有變更——修補檔已經套用過。"
     -
       ## t/t4150-am.sh ##
      @@ t/t4150-am.sh: test_expect_success setup '
       
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
       	git -C client am ../patch
       '
       
     -+test_expect_success 'An empty input file is error regardless of --empty option' '
     ++test_expect_success 'an empty input file is error regardless of --empty option' '
     ++	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am --empty=drop empty.patch 2>actual &&
     -+	echo Patch format detection failed. >expected &&
     ++	echo "Patch format detection failed." >expected &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'invalid when passing the --empty option alone' '
     ++	test_when_finished "git am --abort || :" &&
      +	git checkout empty-commit^ &&
      +	test_must_fail git am --empty empty-commit.patch 2>err &&
      +	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +test_expect_success 'a message without a patch is an error (default)' '
      +	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am empty-commit.patch >err &&
     -+	grep "Patch is empty" err &&
     -+	rm -fr .git/rebase-apply
     ++	grep "Patch is empty" err
      +'
      +
      +test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
      +	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am --empty=die empty-commit.patch >err &&
     -+	grep "Patch is empty." err &&
     -+	rm -fr .git/rebase-apply
     ++	grep "Patch is empty." err
      +'
      +
      +test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '

-- 
gitgitgadget
