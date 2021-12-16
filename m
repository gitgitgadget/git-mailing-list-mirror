Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA8C4332F
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhLPSTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLPSTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC445C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o29so48292wms.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=01Bu6mIx6dPIc1HRX7VZqa6Gwy0lZhIlCxWEp8DiEIE=;
        b=oA2zC0101+g1ANn1gR6VDVIY12o28teE4vZNh+hs3+rSSahplWutEE1N+W/ItzrZGf
         j9RtvtxD9Il/mnRvvS3jobzt3kYuWuPp1stI3jvEkCZLFdWgi55ZCPhyWEEti9SHZOON
         +YUIRLARaQXEF/Mj3TDg9KTkEUoHD13fs0h0aeMd8kHxY5uCRig4xhm4Faddsa0a/pMi
         vHZlV5y3hEbShmfDyaBEgXaJN3GeYv0aZT2KCFwnEm1ku9rMAiPkghTX4Ywj7t7zcdD5
         h33qjfHFX7GARJKjAzg4bUEk6d6xHwORX/P5H23byAyzaku4gocbdfbGZmX5+veyT3TU
         rqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=01Bu6mIx6dPIc1HRX7VZqa6Gwy0lZhIlCxWEp8DiEIE=;
        b=nYEfx3HsTtduCQ1FSyozSP0Z5vMdP1KyVoQubw5KkyxNykJFb79G+jDkcmtSGLk7dY
         ILq1RXCOvtP7UiSR9UlrVhorLhT+hgLJOdCtfOwuDM3DULdH+IDuwgHwesiuWvp2cVNd
         puKCDRMI3u1s4nZFnNwR+yU2CTI5lOxkn7N2HuYMTQgfQ8dVb0ruMRNkJB4jlb4ernzj
         ivZxrcX7xctI0bMNoQHmnxQ8r9mslPmUC+amc6GNy6NwlkCfZBE8ocF2XQIj+7FsxyZU
         Xicb9ZuD4Ipj43csmn/t0NgyD5bvsWI3FOACwptBZQDmrfp0ZCKDMcdb9df8ubNSmkDK
         tr7A==
X-Gm-Message-State: AOAM533dur2icnFPg7qIVsCDas+O4TANVu/jJUhMyE8StD/nl5NEfn2w
        YhdHzUkFkJ0PRmKN3xR4z2CdxmirnWo=
X-Google-Smtp-Source: ABdhPJy6vrW8KvSzkSCcV6DOZLPPDN4Zt1dXEiqlihHaW3LLDbm8PRoLiVvSZyJEs78ZbAvqO22obg==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr6039554wmk.168.1639678745641;
        Thu, 16 Dec 2021 10:19:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm5575278wmq.6.2021.12.16.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:19:05 -0800 (PST)
Message-Id: <e7672e70cc937ef3aaab9a36199470e01f6676a8.1639678735.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
From:   "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 18:18:51 +0000
Subject: [PATCH v3 1/4] bisect--helper: normalize format string of yes/no
 prompts
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

Both callers of git_prompt in bisect--helper.c ask the user for yes/no
confirmation. They both place the question mark after the choices,
however this is inconsistent with how most UNIX-y tools do it. Update
the format string to exclude the choices from the question.

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
 builtin/bisect--helper.c | 6 +++---
 po/bg.po                 | 6 +++---
 po/ca.po                 | 8 ++++----
 po/de.po                 | 8 ++++----
 po/el.po                 | 8 ++++----
 po/es.po                 | 8 ++++----
 po/fr.po                 | 8 ++++----
 po/git.pot               | 4 ++--
 po/id.po                 | 8 ++++----
 po/it.po                 | 6 +++---
 po/ko.po                 | 8 ++++----
 po/pl.po                 | 8 ++++----
 po/pt_PT.po              | 8 ++++----
 po/ru.po                 | 8 ++++----
 po/sv.po                 | 8 ++++----
 po/tr.po                 | 8 ++++----
 po/vi.po                 | 8 ++++----
 po/zh_CN.po              | 8 ++++----
 po/zh_TW.po              | 8 ++++----
 19 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..2bfbb75f08b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -370,7 +370,7 @@ static int decide_next(const struct bisect_terms *terms,
 		 * translation. The program will only accept English input
 		 * at this point.
 		 */
-		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		yesno = git_prompt(_("Are you sure? [Y/n] "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
 			return -1;
 		return 0;
@@ -838,8 +838,8 @@ static int bisect_autostart(struct bisect_terms *terms)
 	 * translation. The program will only accept English input
 	 * at this point.
 	 */
-	yesno = git_prompt(_("Do you want me to do it for you "
-			     "[Y/n]? "), PROMPT_ECHO);
+	yesno = git_prompt(_("Do you want me to do it for you? "
+			     "[Y/n] "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
 		-1 : bisect_start(terms, empty_strvec, 0);
 
diff --git a/po/bg.po b/po/bg.po
index 51d7c7242f2..e0786caa274 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -11633,7 +11633,7 @@ msgstr "двоично търсене само по „%s“ подаване."
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
+msgid "Are you sure? [Y/n] "
 msgstr "Да се продължи ли? „Y“ —  ДА, „n“ — не"
 
 #: builtin/bisect--helper.c:434
@@ -11716,8 +11716,8 @@ msgstr "Започнете като изпълните командата „git
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Да се извърши ли автоматично? „Y“ —  ДА, „n“ — не"
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Да се извърши ли автоматично? „Y“ —  ДА, „n“ — не "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/ca.po b/po/ca.po
index 556b028cd8b..71673d48d01 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -11355,8 +11355,8 @@ msgstr "bisecant amb només una comissió %s"
 #. translation. The program will only accept English input
 #. at this point.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "N'esteu segur [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "N'esteu segur? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11435,8 +11435,8 @@ msgstr "Cal començar per «git bisect start»\n"
 #. translation. The program will only accept English input
 #. at this point.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Voleu que ho faci per vostè [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Voleu que ho faci per vostè? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/de.po b/po/de.po
index f00c21d896f..3e8ef2ed122 100644
--- a/po/de.po
+++ b/po/de.po
@@ -11429,8 +11429,8 @@ msgstr "binäre Suche nur mit einem %s Commit"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Sind Sie sicher [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Sind Sie sicher? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11511,8 +11511,8 @@ msgstr "Sie müssen mit \"git bisect start\" beginnen\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Wollen Sie, dass ich es für Sie mache [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Wollen Sie, dass ich es für Sie mache? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/el.po b/po/el.po
index 703f46d0c7c..27c8c488ea1 100644
--- a/po/el.po
+++ b/po/el.po
@@ -8202,7 +8202,7 @@ msgstr ""
 #. at this point.
 #.
 #: builtin/bisect--helper.c:329
-msgid "Are you sure [Y/n]? "
+msgid "Are you sure? [Y/n] "
 msgstr "Επιβεβαιώνετε [Y/n]; "
 
 #: builtin/bisect--helper.c:376
@@ -19779,7 +19779,7 @@ msgstr "Χρειάζεται να αρχίσετε με \"git bisect start\""
 #. translation. The program will only accept English input
 #. at this point.
 #: git-bisect.sh:60
-msgid "Do you want me to do it for you [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
 msgstr ""
 
 #: git-bisect.sh:101
@@ -21272,8 +21272,8 @@ msgstr ""
 #. TRANSLATORS: please keep [y/N] as is.
 #: git-send-email.perl:825
 #, perl-format
-msgid "Are you sure you want to use <%s> [y/N]? "
-msgstr "Επιβεβαιώνετε πως θέλετε να χρησιμοποιήσετε <%s> [y/N]? "
+msgid "Are you sure you want to use <%s>? [y/N] "
+msgstr "Επιβεβαιώνετε πως θέλετε να χρησιμοποιήσετε <%s>? [y/N] "
 
 #: git-send-email.perl:880
 msgid ""
diff --git a/po/es.po b/po/es.po
index ced2eb6d3d5..ef8ae6d471e 100644
--- a/po/es.po
+++ b/po/es.po
@@ -11267,8 +11267,8 @@ msgstr "haciendo bisect solo con un commit %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "¿Estás seguro [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "¿Estás seguro? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11347,8 +11347,8 @@ msgstr "Debes iniciar con \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "¿Quieres que lo haga por ti [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "¿Quieres que lo haga por ti? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/fr.po b/po/fr.po
index e950f87add0..9812213b2fe 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -11445,8 +11445,8 @@ msgstr "bissection avec seulement un commit %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Confirmez-vous [Y/n] ? "
+msgid "Are you sure? [Y/n] "
+msgstr "Confirmez-vous ? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11526,8 +11526,8 @@ msgstr "Vous devez démarrer avec \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Souhaitez-vous que je le fasse pour vous [Y/n] ? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Souhaitez-vous que je le fasse pour vous ? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/git.pot b/po/git.pot
index 78fea37065b..c3102deb5d2 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -10385,7 +10385,7 @@ msgstr ""
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
+msgid "Are you sure? [Y/n] "
 msgstr ""
 
 #: builtin/bisect--helper.c:434
@@ -10460,7 +10460,7 @@ msgstr ""
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
 msgstr ""
 
 #: builtin/bisect--helper.c:859
diff --git a/po/id.po b/po/id.po
index c1afc2a32f3..3b8b0c39e51 100644
--- a/po/id.po
+++ b/po/id.po
@@ -10734,8 +10734,8 @@ msgstr "membagi dua hanya dengan sebuah komit %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Anda yakin [Y/n]?"
+msgid "Are you sure? [Y/n] "
+msgstr "Anda yakin? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -10813,8 +10813,8 @@ msgstr "Anda perlu memulai dengan \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Anda ingin saya melakukannya untuk Anda [Y/n]"
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Anda ingin saya melakukannya untuk Anda [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/it.po b/po/it.po
index c31560834d8..01c6d1f095e 100644
--- a/po/it.po
+++ b/po/it.po
@@ -10682,7 +10682,7 @@ msgstr "eseguo la bisezione solo con un commit %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:370
-msgid "Are you sure [Y/n]? "
+msgid "Are you sure? [Y/n] "
 msgstr "Sei sicuro? [Y/n] "
 
 #: builtin/bisect--helper.c:431
@@ -10762,8 +10762,8 @@ msgstr "Devi iniziare con \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:838
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Vuoi che me ne occupi io [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Vuoi che me ne occupi io? [Y/n] "
 
 #: builtin/bisect--helper.c:866
 msgid "perform 'git bisect next'"
diff --git a/po/ko.po b/po/ko.po
index 5d190e52380..96d3a2a3be4 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -15994,8 +15994,8 @@ msgstr "\"git bisect start\" 명령으로 시작해야 합니다"
 #. translation. The program will only accept English input
 #. at this point.
 #: git-bisect.sh:60
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "지금 하시겠습니까 [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "지금 하시겠습니까? [Y/n] "
 
 #: git-bisect.sh:121
 #, sh-format
@@ -16061,8 +16061,8 @@ msgstr "경고: 하나의 $TERM_BAD 커밋에 대해서만 이등분."
 #. translation. The program will only accept English input
 #. at this point.
 #: git-bisect.sh:312
-msgid "Are you sure [Y/n]? "
-msgstr "확실합니까 [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "확실합니까? [Y/n] "
 
 #: git-bisect.sh:324
 #, sh-format
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14cc..637a328a869 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -11238,8 +11238,8 @@ msgstr "przeszukiwanie tylko z zapisem %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Czy na pewno [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Czy na pewno? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11319,8 +11319,8 @@ msgstr "Musisz rozpocząć przez „git bisect start”\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Chcesz, żeby to teraz zrobić [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Chcesz, żeby to teraz zrobić? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 70e5c6d9c16..a9a67f15484 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -10900,8 +10900,8 @@ msgstr "bissetando apenas com uma memória %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:358
-msgid "Are you sure [Y/n]? "
-msgstr "Tem a certeza [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Tem a certeza? [Y/n] "
 
 #: builtin/bisect--helper.c:419
 msgid "no terms defined"
@@ -10977,8 +10977,8 @@ msgstr "Deves começar com \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:826
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Quer que seja eu a fazer isso [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Quer que seja eu a fazer isso? [Y/n] "
 
 #: builtin/bisect--helper.c:844
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/ru.po b/po/ru.po
index 993d106f1f9..d091ea22e5a 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -9796,8 +9796,8 @@ msgstr ""
 #. translation. The program will only accept English input
 #. at this point.
 #: builtin/bisect--helper.c:357
-msgid "Are you sure [Y/n]? "
-msgstr "Вы уверены [Y - да/n - нет]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Вы уверены? [Y - да/n - нет] "
 
 #: builtin/bisect--helper.c:418
 msgid "no terms defined"
@@ -9870,8 +9870,8 @@ msgstr ""
 #. translation. The program will only accept English input
 #. at this point.
 #: builtin/bisect--helper.c:825
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Вы уверены, что хотите, чтобы я сделал это [Y] - да/[n] - нет? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Вы уверены, что хотите, чтобы я сделал это? [Y] - да/[n] - нет "
 
 #: builtin/bisect--helper.c:843
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/sv.po b/po/sv.po
index e3b17b6a0ef..6ccb7e7421c 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -11173,8 +11173,8 @@ msgstr "utför bisect med endast en %s incheckning"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Är du säker [Y=ja/N=nej]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Är du säker? [Y=ja/N=nej] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11254,8 +11254,8 @@ msgstr "Du måste starta med \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Vill du att jag ska göra det åt dig [Y=ja/N=nej]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Vill du att jag ska göra det åt dig? [Y=ja/N=nej] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/tr.po b/po/tr.po
index 06870900c4e..686b21459a3 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -11238,8 +11238,8 @@ msgstr "yalnızca bir %s işlemesi ile ikili arama yapılıyor"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Emin misiniz [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Emin misiniz? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11317,8 +11317,8 @@ msgstr "\"git bisect start\" ile başlamalısınız\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Bunu sizin yerinize benim yapmamı ister misiniz [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Bunu sizin yerinize benim yapmamı ister misiniz? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/vi.po b/po/vi.po
index be197ab594f..bfb84bd0049 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -11235,8 +11235,8 @@ msgstr "chỉ thực hiện việc bisect với một lần chuyển giao %s"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "Bạn có chắc chắn chưa [Y/n]? "
+msgid "Are you sure? [Y/n] "
+msgstr "Bạn có chắc chắn chưa? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11314,8 +11314,8 @@ msgstr "Bạn cần khởi đầu bằng \"git bisect start\"\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Bạn có muốn tôi thực hiện điều này cho bạn không [Y/n]? "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "Bạn có muốn tôi thực hiện điều này cho bạn không? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 60ffa45f7a0..9131b440e6f 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -11092,8 +11092,8 @@ msgstr "在只有一个 %s 提交的情况下二分查找"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "您确认么[Y/n]？ "
+msgid "Are you sure? [Y/n] "
+msgstr "您确认么? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11169,8 +11169,8 @@ msgstr "您需要执行 \"git bisect start\" 来开始\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "您想让我为您这样做么[Y/n]？ "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "您想让我为您这样做么? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index f1df8b60a91..80e156c94fc 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -10958,8 +10958,8 @@ msgstr "在只有一個 %s 提交的情況下二分搜尋"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:373
-msgid "Are you sure [Y/n]? "
-msgstr "您確認嗎[Y/n]？ "
+msgid "Are you sure? [Y/n] "
+msgstr "您確認嗎? [Y/n] "
 
 #: builtin/bisect--helper.c:434
 msgid "no terms defined"
@@ -11036,8 +11036,8 @@ msgstr "您需要執行 \"git bisect start\" 來開始\n"
 #. at this point.
 #.
 #: builtin/bisect--helper.c:841
-msgid "Do you want me to do it for you [Y/n]? "
-msgstr "您想讓我為您這樣做嗎[Y/n]？ "
+msgid "Do you want me to do it for you? [Y/n] "
+msgstr "您想讓我為您這樣做嗎? [Y/n] "
 
 #: builtin/bisect--helper.c:859
 msgid "Please call `--bisect-state` with at least one argument"
-- 
gitgitgadget

