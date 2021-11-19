Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23FC433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3079C615E6
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhKSFIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSFII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:08:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B000DC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t30so15870578wra.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6/rRi/3u0iQxU1VyH3Wsm4V+rudXO/TGY+UTpe0ZZCY=;
        b=AtV723RAkZUrYm3JgRG7lOBTE+wvJ5Zp9g+XvbFpdVSCTDDxq5mBhtceeiGInrM7W5
         zRkSPrverjFZND9kjrdXyV5URqPWl3ex+wNp1ZSFMBG5qQi6pD7j7I6UxRFF3zLRK9KT
         4IxLiNt9e7IHBbgZzxD63JSTctIDjF8OkpoVMzlSCVilrDVAPUAp0XJTDw3jqBltVpfg
         7FsTswx5b0rih2rQYaA6AfM4/qp8X1CBCidH5rnm6gKjyjNwJd1+4e4hZiK/MLkS+BSX
         udV6eVDs5eHAKkAHhbLSljO/1MdJc9sZjzPqwO/4SJwStVSJG91j3eh1ALa+kw4C+ZH8
         Hi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6/rRi/3u0iQxU1VyH3Wsm4V+rudXO/TGY+UTpe0ZZCY=;
        b=U893Z4UZcqIMNXdkxhwJZrvWuAWObJT+/ijSygwFeozc1IBFmbBeUgqD7V9DfSI1ah
         ba5AsuJBhamPzck08jxr/8XyugKsxZzqiBd3u2jTkTeGlT4V7R/zD4399493YFXLLaio
         1oQELnnCca2m9u3UWYyw8z+mLAkT11C4DbZGb2Nf+Tz+zUB82NB5fJBgPEzO5oeAIWCH
         2+PpiDZjy+5KMlwMnQ3fvrtmJq1KDAR8vS6iLbS/fIW1m7Hum4Zt1uFZ5IQckHR54HU4
         DTeG4dBRK3qGEAjz/3iKQVrMkX+EZ4PmHhflm0kYXofB68FG6V5ze7uppOyx+GVlKiRq
         YGlw==
X-Gm-Message-State: AOAM533DNpexGjZZgTo/7pkrvZTeWkK6JpviRWZ87/UFDBSaqbIlIcKL
        fQE7eqjwWLrnP5gVUYCzywtf7rQKWZI=
X-Google-Smtp-Source: ABdhPJyEokhlSnZgWTF9OuqIXuGKQdGoFGac/JXFsTF8pGwiFoKkl1cg8sNqLtl1qbjwwAk2c4JWEQ==
X-Received: by 2002:a05:6000:156a:: with SMTP id 10mr3892953wrz.87.1637298304957;
        Thu, 18 Nov 2021 21:05:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q24sm1195903wmj.21.2021.11.18.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 21:05:04 -0800 (PST)
Message-Id: <9e60e77c041bca28a50d706c865eb776e5fe2ec2.1637298299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 05:04:58 +0000
Subject: [PATCH v7 2/2] am: support --empty=<option> to handle empty patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Since that the command 'git-format-patch' can include patches of
commits that emit no changes, the 'git-am' command should also
support an option, named as '--empty', to specify how to handle
those empty patches. In this commit, we have implemented three
valid options ('die', 'drop' and 'keep').

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  8 ++++++
 builtin/am.c             | 55 ++++++++++++++++++++++++++++++++++++----
 po/bg.po                 |  2 +-
 po/ca.po                 |  2 +-
 po/de.po                 |  2 +-
 po/el.po                 |  2 +-
 po/es.po                 |  2 +-
 po/fr.po                 |  2 +-
 po/git.pot               |  2 +-
 po/id.po                 |  2 +-
 po/it.po                 |  2 +-
 po/ko.po                 |  2 +-
 po/pl.po                 |  2 +-
 po/pt_PT.po              |  8 +++---
 po/ru.po                 |  4 +--
 po/sv.po                 |  2 +-
 po/tr.po                 |  2 +-
 po/vi.po                 |  2 +-
 po/zh_CN.po              |  9 +++++--
 po/zh_TW.po              |  7 ++++-
 t/t4150-am.sh            | 49 +++++++++++++++++++++++++++++++++++
 21 files changed, 140 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..1e6a64bf2ed 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--empty=(die|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -63,6 +64,13 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--empty-commit=(die|drop|keep)::
+	By default, or when the option is set to 'die', the command
+	errors out on an input e-mail message that lacks a patch. When
+	this option is set to 'drop', skip such an e-mail message instead.
+	When this option is set to 'keep', create an empty commit,
+	recording the contents of the e-mail message as its log.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..cc6512275aa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_action {
+	DIE_EMPTY_COMMIT = 0,  /* output errors */
+	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
+	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -118,6 +124,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	int quoted_cr; /* enum quoted_cr_action */
+	int empty_type; /* enum empty_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -178,6 +185,25 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "die"))
+		*opt_value = DIE_EMPTY_COMMIT;
+	else if (!strcmp(arg, "drop"))
+		*opt_value = DROP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "keep"))
+		*opt_value = KEEP_EMPTY_COMMIT;
+	else
+		return error(_("Invalid value for --empty: %s"), arg);
+
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -1248,11 +1274,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_or_missing_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty."));
-		die_user_resolve(state);
-	}
-
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
@@ -1763,6 +1784,7 @@ static void am_run(struct am_state *state, int resume)
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 		int apply_status;
+		int to_keep;
 
 		reset_ident_date();
 
@@ -1792,8 +1814,27 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		to_keep = 0;
+		if (is_empty_or_missing_file(am_path(state, "patch"))) {
+			switch (state->empty_type) {
+			case DROP_EMPTY_COMMIT:
+				say(state, stdout, _("Skipping: %.*s"), linelen(state->msg), state->msg);
+				goto next;
+				break;
+			case KEEP_EMPTY_COMMIT:
+				to_keep = 1;
+				break;
+			case DIE_EMPTY_COMMIT:
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+				break;
+			}
+		}
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
+		if (to_keep)
+			goto commit;
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -1827,6 +1868,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2399,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
+		  N_("how to handle empty patches"),
+		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/po/bg.po b/po/bg.po
index 51d7c7242f2..17d05bc9d4e 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -11194,7 +11194,7 @@ msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr ""
 "Индексът не е чист: кръпките не може да бъдат приложени (замърсени са: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Прилагане: %.*s"
diff --git a/po/ca.po b/po/ca.po
index 556b028cd8b..4035055c28e 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -10931,7 +10931,7 @@ msgstr "no s'ha pogut escriure el fitxer d'índex"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Índex brut: no es poden aplicar pedaços (bruts: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "S'està aplicant: %.*s"
diff --git a/po/de.po b/po/de.po
index f00c21d896f..fbae81fc59f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10999,7 +10999,7 @@ msgstr "Konnte Index-Datei nicht schreiben."
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Geänderter Index: kann Patches nicht anwenden (geändert: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Wende an: %.*s"
diff --git a/po/el.po b/po/el.po
index 703f46d0c7c..5a3d4d8a61e 100644
--- a/po/el.po
+++ b/po/el.po
@@ -7801,7 +7801,7 @@ msgstr "Να γίνει εφαρμογή; [y]es/[n]o/[e]dit/[v]iew patch/[a]ccep
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr ""
 
-#: builtin/am.c:1749 builtin/am.c:1817
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr ""
diff --git a/po/es.po b/po/es.po
index ced2eb6d3d5..774a333cc64 100644
--- a/po/es.po
+++ b/po/es.po
@@ -10840,7 +10840,7 @@ msgstr "no es posible escribir el archivo índice"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Índice sucio: no se puede aplicar parches (sucio: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Aplicando: %.*s"
diff --git a/po/fr.po b/po/fr.po
index e950f87add0..30a8a1b3fd1 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -11013,7 +11013,7 @@ msgstr "impossible d'écrire le fichier d'index"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Index sale : impossible d'appliquer des patchs (sales : %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Application de  %.*s"
diff --git a/po/git.pot b/po/git.pot
index 78fea37065b..1367e12f3d0 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -9985,7 +9985,7 @@ msgstr ""
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr ""
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr ""
diff --git a/po/id.po b/po/id.po
index c1afc2a32f3..0821da2efee 100644
--- a/po/id.po
+++ b/po/id.po
@@ -10306,7 +10306,7 @@ msgstr "tidak dapat menulis berkas indeks"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Indeks kotor: tidak dapat menerapkan tambalan (kotor: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Menerapkan: %.*s"
diff --git a/po/it.po b/po/it.po
index c31560834d8..475a60dc1d1 100644
--- a/po/it.po
+++ b/po/it.po
@@ -10229,7 +10229,7 @@ msgstr "impossibile scrivere il file indice"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Indice sporco: impossibile applicare le patch (elemento sporco: %s)"
 
-#: builtin/am.c:1761 builtin/am.c:1829
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Applicazione in corso: %.*s"
diff --git a/po/ko.po b/po/ko.po
index 5d190e52380..5a9d7eb0305 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -5681,7 +5681,7 @@ msgstr "적용? 예[y]/아니오[n]/편집[e]/패치 보기[v]/모두 적용[a]:
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "변경된 인덱스: 패치를 적용할 수 없습니다 (dirty: %s)"
 
-#: builtin/am.c:1808 builtin/am.c:1879
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "적용하는 중: %.*s"
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14cc..f9768843fb0 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -10811,7 +10811,7 @@ msgstr "nie można zapisać pliku indeksu"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Brudny indeks: nie można zastosować łatek (brudny: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Stosowanie: %.*s"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 70e5c6d9c16..e89894ca5dc 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -24,7 +24,7 @@
 #   bisect                           |  bisetar
 #   blame                            |  blame
 #   blob object                      |  objeto-blob
-#   branch                           |  ramo 
+#   branch                           |  ramo
 #   bug                              |  bug
 #   bundle                           |  conjunto
 #   bypass                           |  desviar
@@ -74,7 +74,7 @@
 #   loose refs                       |  refs soltas
 #   mark                             |  marca
 #   master                           |  master
-#   merge                            |  junção 
+#   merge                            |  junção
 #   mergetag                         |  etiqueta-junção
 #   object                           |  objeto
 #   object database                  |  base dados de objeto
@@ -211,7 +211,7 @@
 #   token                            |  token
 #   unset                            |  desdefinir
 #   untrack                          |  desmonitorizar
-#   
+#
 #
 msgid ""
 msgstr ""
@@ -10485,7 +10485,7 @@ msgstr "incapaz escrever ficheiro de index"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Index sujo: incapaz aplicar patches (sujo: %s)"
 
-#: builtin/am.c:1797 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "A aplicar: %.*s"
diff --git a/po/ru.po b/po/ru.po
index 993d106f1f9..69acd080d12 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1,7 +1,7 @@
 # SOME DESCRIPTIVE TITLE.
 # Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
 # This file is distributed under the same license as the PACKAGE package.
-# 
+#
 # Translators:
 # Alexander Golubev <fatzer2@gmail.com>, 2020
 # Dimitriy Ryazantcev <DJm00n@mail.ru>, 2014-2021
@@ -9398,7 +9398,7 @@ msgstr "не удалось записать индекс"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Индекс изменён: нельзя применять патчи (изменено: %s)"
 
-#: builtin/am.c:1748 builtin/am.c:1816
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Применение: %.*s"
diff --git a/po/sv.po b/po/sv.po
index e3b17b6a0ef..41f6be1c540 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -10746,7 +10746,7 @@ msgstr "kan inte skriva indexfil"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Smutsigt index: kan inte tillämpa patchar (smutsiga: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Tillämpar: %.*s"
diff --git a/po/tr.po b/po/tr.po
index 06870900c4e..6c4d7ee8337 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -10810,7 +10810,7 @@ msgstr "indeks dosyası yazılamıyor"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Kirli indeks: Yamalar uygulanamıyor (kirli: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Uygulanıyor: %.*s"
diff --git a/po/vi.po b/po/vi.po
index be197ab594f..5ed8c0239fe 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -10807,7 +10807,7 @@ msgstr "không thể ghi tập tin lưu mục lục"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "Bảng mục lục bẩn: không thể áp dụng các miếng vá (bẩn: %s)"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "Áp dụng: %.*s"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 60ffa45f7a0..13c4ae14a29 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -6463,7 +6463,7 @@ msgstr "坏的索引文件 sha1 签名"
 msgid "index uses %.4s extension, which we do not understand"
 msgstr "索引使用不被支持的 %.4s 扩展"
 
-# 	
+#
 #: read-cache.c:1834
 #, c-format
 msgid "ignoring %.4s extension"
@@ -10673,11 +10673,16 @@ msgstr "无法写入索引文件"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "脏索引：不能应用补丁（脏文件：%s）"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "应用：%.*s"
 
+#: builtin/am.c:1818
+#, c-format
+msgid "Skipping: %.*s"
+msgstr "跳过：%.*s"
+
 #: builtin/am.c:1815
 msgid "No changes -- Patch already applied."
 msgstr "没有变更 —— 补丁已经应用过。"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index f1df8b60a91..d6259cc1cb6 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -10538,11 +10538,16 @@ msgstr "無法寫入索引檔案"
 msgid "Dirty index: cannot apply patches (dirty: %s)"
 msgstr "髒索引：不能套用修補檔（髒檔案：%s）"
 
-#: builtin/am.c:1798 builtin/am.c:1865
+#: builtin/am.c:1834 builtin/am.c:1902
 #, c-format
 msgid "Applying: %.*s"
 msgstr "套用：%.*s"
 
+#: builtin/am.c:1818
+#, c-format
+msgid "Skipping: %.*s"
+msgstr "忽略：%.*s"
+
 #: builtin/am.c:1815
 msgid "No changes -- Patch already applied."
 msgstr "沒有變更——修補檔已經套用過。"
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..16e966b2b73 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,12 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	: >empty.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1158,47 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'An empty input file is error regardless of --empty option' '
+	test_must_fail git am --empty=drop empty.patch 2>actual &&
+	echo Patch format detection failed. >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'invalid when passing the --empty option alone' '
+	git checkout empty-commit^ &&
+	test_must_fail git am --empty empty-commit.patch 2>err &&
+	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
+	test_cmp expected err
+'
+
+test_expect_success 'a message without a patch is an error (default)' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty" err &&
+	rm -fr .git/rebase-apply
+'
+
+test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am --empty=die empty-commit.patch >err &&
+	grep "Patch is empty." err &&
+	rm -fr .git/rebase-apply
+'
+
+test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
+	git am --empty=drop empty-commit.patch >output &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+	grep "Skipping: empty commit" output
+'
+
+test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
+	git am --empty=keep empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%s" >expected &&
+	git show HEAD --format="%s" >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
gitgitgadget
