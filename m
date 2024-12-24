Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C181AFB36
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036726; cv=none; b=PxmMEF0VVsluZzS+Bo+NdCnCrvqCcKLpR8sqLk14NjmUM/Q63/6mP3vpzPs10JXQK2oDefauj5IsgKgFa1TCjjQz6013n1NW+/FnlL3u7IY77J73SKbRTYVAyFPLBS2oD2c8DC8XamLBbyprttkfWL0UGsA3+3gVCi06TIZpn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036726; c=relaxed/simple;
	bh=fRuNmQ1pHtmANnOjAY1qoV5Rw0pI7Av1zdiQ8Pj6KKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcUhadPs+J6185+4bCKO9nDV+iUx9nhHvRcQx+ITU9R399NeKqsdKXJ+D5vkiCsbWY2H75+OzLSE/sdd7Rp9+/QUSS8OyTuw4s9ltuIOeWXwtK2ab8PDCdJrMwRYYnTJCb6xG4EOy2LsMgJyMuWYJJh0bTCks0qGv1YFuumzUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=gwZ0/cBX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="gwZ0/cBX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa67ac42819so716007466b.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735036720; x=1735641520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r02Jr1mmzBbgw+fXoXlhwt0va5rKlTYnwNn+VF0YKjw=;
        b=gwZ0/cBXBaCIbAjOWqt5lQs8PR1ORp2YG5rxyiwX7VgiNvFjB+y2v12jTfA+h6p2YX
         9IeuLBuhVXWy253NDRe7G91+ru6k9fN3BSAfiuI69Bm91IM6TencIVuuczgplGi46RRw
         TQ6snHGIhd6fFc2ZkceK8yrZPfKwY/CmrxvYBbNlCx7Hn90CKulnIJgL37OxfdVFHSiQ
         2pAu5nZEJ/VAT80sEVTftBjZfOPOhkEg4F7GOs0N010oPF0SxM3UmQnzg8K3W+v5+Eac
         StNehN8j9gRMWHBMU+IMuEkjIWNl6wySCbW/Toh88GT1ugl62x9RC1YpMoCHt80x2qo5
         3KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036720; x=1735641520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r02Jr1mmzBbgw+fXoXlhwt0va5rKlTYnwNn+VF0YKjw=;
        b=YD2zAGdT/SP8Yw/Ie1xdJyrZLx1BaIxnPmeJhVOwjLUOXoYZx4gopDZkWjAz7mRlEA
         xVtdxfNvNhoe5qDSWfOjy0riVA6Fvwz8HgMc5gHk5EIXSHqocJY5t/OCOM3Up3Wvt28r
         KHJEmKwNaIjjRiaMlQZDIzVTOHBXTkpjEbDQl2FSR55xuODTzeo8nS4oXo7Jh/zbpsEi
         wzwkpXMNkE05bfkU2MmVXfKh6QfJTw6k+WTISO4csR5ePjSOx9QQ0Jt/Zns7ZdPT6i+Z
         fgdyFQ8J17oqS7SQ2CI6eZK67rFJcaFoqtHZQ03o6xLVyfZvDAqFaEdZX8BbKk7SLe2U
         BMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXNkhE1ZbD+JhcOVjB475/8MKSGbNsL11Kbdo8hHgmMo6bRy+4XqTPMVZLvW/OkOMi4Iik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhdua+QF1nkD7yqMsjdgoKyqtreclsTIMT8pm5olhttdYBq2P
	anrYSn0T+bqVSzD90x3m55UiRr/Hg2Tc96B/HBHzIbj2dImgpGn0vKNlQ+gF88I=
X-Gm-Gg: ASbGncs+FIsY0nWGktJHVNoJBLiYXmJPsa053X4O6x2yVOuMh9O7BCGOZAZeT4VDirF
	l6YYCJQiNz1XaZadHtZCv0MTR/xecLO9ehTUkumTOyq5rDlPxoE2ZD57vUHfKLMWqOcCO+/DAJN
	JADoeEC9h0+5edwlr63Re6tf9ETPhXTz5eSn+mzMibsh7cppXdGV2lQ4Bjr8oAItku96YcLSImX
	YEXN/F4IAGOTY1S9dthOnq3mXhpz3Fg2Ht1pItLoC/Fc01SqzaiiS5M8Xk3U4w2qaIGK4TkvoNQ
	v+17DY5Ae0LeV99R1b9X+rvJfQ==
X-Google-Smtp-Source: AGHT+IEcICvZYqHcXsLqaoQsb+Slt06j0BkSaTplNwaGiF0JAceI5lIXzFqhlxHEOG0bBcWkBANl/w==
X-Received: by 2002:a17:907:7288:b0:aa6:a9fe:46dd with SMTP id a640c23a62f3a-aac346507b2mr1270272566b.38.1735036719395;
        Tue, 24 Dec 2024 02:38:39 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06f847sm625565766b.202.2024.12.24.02.38.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Dec 2024 02:38:38 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: j6t@kdbg.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	paulus@ozlabs.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] l10n: bg.po: Updated Bulgarian translation (5515t)
Date: Tue, 24 Dec 2024 11:38:33 +0100
Message-ID: <20241224103834.17085-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqqplliz2zj.fsf@gitster.g>
References: <xmqqplliz2zj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 500 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 314 insertions(+), 186 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index daec1326c0..61214c4b1c 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -199,7 +199,8 @@
 # gitattributes file файл с атрибути на git
 # advertised обявен за наличен
 # superproject свръхпроект
-#
+# rev-index обратен индекс (reverse index)
+# dererging branches раздалечили се клони
 # ------------------------
 # „$var“ - може да не сработва за shell има gettext и eval_gettext - проверка - намират се лесно по „$
 # ------------------------
@@ -216,10 +217,10 @@
 # for i in `sort -u FILES`; do cnt=`grep $i FILES | wc -l`; echo $cnt $i ;done | sort -n
 msgid ""
 msgstr ""
-"Project-Id-Version: git 2.40\n"
+"Project-Id-Version: git 2.41\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2023-03-01 01:20+0000\n"
-"PO-Revision-Date: 2023-03-02 08:54+0200\n"
+"POT-Creation-Date: 2023-05-19 19:48+0200\n"
+"PO-Revision-Date: 2023-05-19 20:57+0300\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -890,6 +891,23 @@ msgstr "Промѐните трябва да се подадат преди с
 msgid "Exiting because of unfinished merge."
 msgstr "Изход от програмата заради незавършено сливане."
 
+msgid ""
+"Diverging branches can't be fast-forwarded, you need to either:\n"
+"\n"
+"\tgit merge --no-ff\n"
+"\n"
+"or:\n"
+"\n"
+"\tgit rebase\n"
+msgstr ""
+"Раздалечили се клони не може да се превъртят.  Ползвайте:\n"
+"\n"
+"  git merge --no-ff\n"
+"\n"
+"или:\n"
+"\n"
+"  git rebase\n"
+
 msgid "Not possible to fast-forward, aborting."
 msgstr "Не може да се извърши превъртане, преустановяване на действието."
 
@@ -1353,6 +1371,10 @@ msgstr "съкращаване на името на файла с отхвърл
 msgid "cannot open %s"
 msgstr "„%s“ не може да бъде отворен"
 
+#, c-format
+msgid "cannot unlink '%s'"
+msgstr "„%s“ не може да се изтрие"
+
 #, c-format
 msgid "Hunk #%d applied cleanly."
 msgstr "%d-то парче бе успешно приложено."
@@ -1546,6 +1568,10 @@ msgstr "git archive --remote ХРАНИЛИЩЕ [--exec КОМАНДА] --list"
 msgid "cannot read '%s'"
 msgstr "файлът „%s“ не може да бъде прочетен"
 
+#, c-format
+msgid "pathspec '%s' matches files outside the current directory"
+msgstr "пътят „%s“ съвпада с файлове извън текущата директория"
+
 #, c-format
 msgid "pathspec '%s' did not match any files"
 msgstr "пътят „%s“ не съвпада с никой файл"
@@ -1562,9 +1588,6 @@ msgstr "неправилно име на обект: „%s“"
 msgid "not a tree object: %s"
 msgstr "не е обект-дърво: %s"
 
-msgid "current working directory is untracked"
-msgstr "текущата работна директория не е следена"
-
 #, c-format
 msgid "File not found: %s"
 msgstr "Файлът „%s“ липсва"
@@ -1691,6 +1714,11 @@ msgstr "прескачане на прекалено големия файл з
 msgid "ignoring overly large gitattributes blob '%s'"
 msgstr "прескачане на прекалено големия обект-BLOB за атрибути на git: „%s“"
 
+msgid "bad --attr-source or GIT_ATTR_SOURCE"
+msgstr ""
+"неправилна стойност за опцията „--attr-source“ или променливата "
+"„GIT_ATTR_SOURCE“"
+
 #, c-format
 msgid "Badly quoted content in file '%s': %s"
 msgstr "Неправилно цитирано съдържание във файла „%s“: %s"
@@ -1796,9 +1824,6 @@ msgstr[1] "Двоично търсене: остават %d версии сле
 msgid "--contents and --reverse do not blend well."
 msgstr "опциите „--contents“ и „--reverse“ са несъвместими"
 
-msgid "cannot use --contents with final commit object name"
-msgstr "опцията „--contents“ е несъвместима с име на обект от крайно подаване"
-
 msgid "--reverse and --first-parent together require specified latest commit"
 msgstr ""
 "Едновременното задаване на опциите „--reverse“ и „--first-parent“ изисква "
@@ -1985,10 +2010,6 @@ msgstr "подмодул „%s“: клонът „%s“ не може да се
 msgid "'%s' is already checked out at '%s'"
 msgstr "„%s“ вече е изтеглен в „%s“"
 
-#, c-format
-msgid "HEAD of working tree %s is not updated"
-msgstr "Указателят „HEAD“ на работното дърво „%s“ не е обновен"
-
 msgid "git add [<options>] [--] <pathspec>..."
 msgstr "git add [ОПЦИЯ…] [--] ПЪТ…"
 
@@ -3080,6 +3101,14 @@ msgstr "Не може да изтриете клона „%s“, който е 
 msgid "remote-tracking branch '%s' not found."
 msgstr "следящият клон „%s“ не може да бъде открит."
 
+#, c-format
+msgid ""
+"branch '%s' not found.\n"
+"Did you forget --remote?"
+msgstr ""
+"клонът „%s“ не може да бъде открит.\n"
+"Пробвахте ли опцията „--remote“?"
+
 #, c-format
 msgid "branch '%s' not found."
 msgstr "клонът „%s“ не може да бъде открит."
@@ -3110,6 +3139,10 @@ msgstr "Клонът „%s“ се пребазира върху „%s“"
 msgid "Branch %s is being bisected at %s"
 msgstr "Търси се двоично в клона „%s“ при „%s“"
 
+#, c-format
+msgid "HEAD of working tree %s is not updated"
+msgstr "Указателят „HEAD“ на работното дърво „%s“ не е обновен"
+
 #, c-format
 msgid "Invalid branch name: '%s'"
 msgstr "Неправилно име на клон: „%s“"
@@ -3213,6 +3246,9 @@ msgstr ""
 msgid "move/rename a branch, even if target exists"
 msgstr "преместване/преименуване на клон, дори ако има вече клон с такова име"
 
+msgid "do not output a newline after empty formatted refs"
+msgstr "без извеждане на нов ред след празен форматиран указател"
+
 msgid "copy a branch and its reflog"
 msgstr "копиране на клон и принадлежащия му журнал на указателите"
 
@@ -3436,12 +3472,10 @@ msgid "Created new report at '%s'.\n"
 msgstr "Новият доклад е създаден в „%s“.\n"
 
 msgid ""
-"git bundle create [-q | --quiet | --progress | --all-progress] [--all-"
-"progress-implied]\n"
+"git bundle create [-q | --quiet | --progress]\n"
 "                  [--version=<version>] <file> <git-rev-list-args>"
 msgstr ""
-"git bundle create [-q | --quiet | --progress | --all-progress] [--all-"
-"progress-implied]\n"
+"git bundle create [-q | --quiet | --progress ]\n"
 "                  [--version=ВЕРСИЯ] ФАЙЛ ОПЦИЯ_ЗА_git-rev-list…"
 
 msgid "git bundle verify [-q | --quiet] <file>"
@@ -3462,12 +3496,11 @@ msgstr "без извеждане на напредъка"
 msgid "show progress meter"
 msgstr "извеждане на напредъка"
 
-msgid "show progress meter during object writing phase"
-msgstr "извеждане на напредъка във фазата на запазване на обектите"
+msgid "historical; same as --progress"
+msgstr "изоставена опция, същото като „--progress“"
 
-msgid "similar to --all-progress when progress meter is shown"
-msgstr ""
-"същото действие като опцията „--all-progress“ при извеждането на напредъка"
+msgid "historical; does nothing"
+msgstr "изоставена опция, нищо не прави"
 
 msgid "specify bundle format version"
 msgstr "версия на пратката"
@@ -4498,6 +4531,10 @@ msgstr "не може да бъде получена информация чре
 msgid "%s exists and is not a directory"
 msgstr "„%s“ съществува и не е директория"
 
+#, c-format
+msgid "'%s' is a symlink, refusing to clone with --local"
+msgstr "„%s“ е символна връзка, не може да се клонира с опцията „--local“"
+
 #, c-format
 msgid "failed to start iterator over '%s'"
 msgstr "неуспешно итериране по „%s“"
@@ -6071,118 +6108,13 @@ msgstr "git fetch --all [ОПЦИЯ…]"
 msgid "fetch.parallel cannot be negative"
 msgstr "опцията „fetch.parallel“ трябва да е неотрицателна"
 
-msgid "fetch from all remotes"
-msgstr "доставяне от всички отдалечени хранилища"
-
-msgid "set upstream for git pull/fetch"
-msgstr "задаване на клон за следене за издърпване/доставяне"
-
-msgid "append to .git/FETCH_HEAD instead of overwriting"
-msgstr "добавяне към „.git/FETCH_HEAD“ вместо замяна"
-
-msgid "use atomic transaction to update references"
-msgstr "изискване на атомарни операции за обновяване на указателите"
-
-msgid "path to upload pack on remote end"
-msgstr "отдалечен път, където да се качи пакетът"
-
-msgid "force overwrite of local reference"
-msgstr "принудително презаписване на локален указател"
-
-msgid "fetch from multiple remotes"
-msgstr "доставяне от множество отдалечени хранилища"
-
-msgid "fetch all tags and associated objects"
-msgstr "доставяне на всички етикети и принадлежащи обекти"
-
-msgid "do not fetch all tags (--no-tags)"
-msgstr "без доставянето на всички етикети „--no-tags“"
-
-msgid "number of submodules fetched in parallel"
-msgstr "брой подмодули доставени паралелно"
-
-msgid "modify the refspec to place all refs within refs/prefetch/"
-msgstr ""
-"промяна на указателя, така че и той, както останалите, да бъде в „refs/"
-"prefetch/“"
-
-msgid "prune remote-tracking branches no longer on remote"
-msgstr "окастряне на клоните следящи вече несъществуващи отдалечени клони"
-
-msgid "prune local tags no longer on remote and clobber changed tags"
-msgstr ""
-"окастряне на локалните етикети, които вече не съществуват в отдалеченото "
-"хранилище и презаписване на променените"
-
-msgid "on-demand"
-msgstr "ПРИ НУЖДА"
-
-msgid "control recursive fetching of submodules"
-msgstr "управление на рекурсивното доставяне на подмодулите"
-
-msgid "write fetched references to the FETCH_HEAD file"
-msgstr "запазване на доставените указатели във файла „FETCH_HEAD“"
-
-msgid "keep downloaded pack"
-msgstr "запазване на изтеглените пакети с обекти"
-
-msgid "allow updating of HEAD ref"
-msgstr "позволяване на обновяването на указателя „HEAD“"
-
-msgid "deepen history of shallow clone"
-msgstr "задълбочаване на историята на плитко хранилище"
-
-msgid "deepen history of shallow repository based on time"
-msgstr "задълбочаване на историята на плитко хранилище до определено време"
-
-msgid "convert to a complete repository"
-msgstr "превръщане в пълно хранилище"
-
-msgid "re-fetch without negotiating common commits"
-msgstr "повторно доставяне без договаряне на общите подавания"
-
-msgid "prepend this to submodule path output"
-msgstr "добавяне на това пред пътя на подмодула"
-
-msgid ""
-"default for recursive fetching of submodules (lower priority than config "
-"files)"
-msgstr ""
-"стандартно рекурсивно изтегляне на подмодулите (файловете с настройки са с "
-"приоритет)"
-
-msgid "accept refs that update .git/shallow"
-msgstr "приемане на указатели, които обновяват „.git/shallow“"
-
-msgid "refmap"
-msgstr "КАРТА_С_УКАЗАТЕЛИ"
-
-msgid "specify fetch refmap"
-msgstr "указване на КАРТАта_С_УКАЗАТЕЛИ за доставяне"
-
-msgid "report that we have only objects reachable from this object"
-msgstr "докладване, че всички обекти може са достижими при започване от този"
-
-msgid "do not fetch a packfile; instead, print ancestors of negotiation tips"
-msgstr ""
-"без доставяне на пакетни файлове, вместо това да се извеждат предшественици "
-"на договорните върхове"
-
-msgid "run 'maintenance --auto' after fetching"
-msgstr "изпълняване на „maintenance --auto“ след доставяне"
-
-msgid "check for forced-updates on all updated branches"
-msgstr "проверка за принудителни обновявания на всички клони"
-
-msgid "write the commit-graph after fetching"
-msgstr "запазване на гра̀фа с подаванията след доставяне"
-
-msgid "accept refspecs from stdin"
-msgstr "четене на указателите от стандартния вход"
-
 msgid "couldn't find remote ref HEAD"
 msgstr "указателят „HEAD“ в отдалеченото хранилище не може да бъде открит"
 
+#, c-format
+msgid "From %.*s\n"
+msgstr "От %.*s\n"
+
 #, c-format
 msgid "object %s not found"
 msgstr "обектът „%s“ липсва"
@@ -6258,10 +6190,6 @@ msgid "rejected %s because shallow roots are not allowed to be updated"
 msgstr ""
 "отхвърляне на „%s“, защото плитките върхове не може да бъдат обновявани"
 
-#, c-format
-msgid "From %.*s\n"
-msgstr "От %.*s\n"
-
 #, c-format
 msgid ""
 "some local refs could not be updated; try running\n"
@@ -6355,6 +6283,115 @@ msgstr ""
 msgid "you need to specify a tag name"
 msgstr "трябва да укажете име на етикет"
 
+msgid "fetch from all remotes"
+msgstr "доставяне от всички отдалечени хранилища"
+
+msgid "set upstream for git pull/fetch"
+msgstr "задаване на клон за следене за издърпване/доставяне"
+
+msgid "append to .git/FETCH_HEAD instead of overwriting"
+msgstr "добавяне към „.git/FETCH_HEAD“ вместо замяна"
+
+msgid "use atomic transaction to update references"
+msgstr "изискване на атомарни операции за обновяване на указателите"
+
+msgid "path to upload pack on remote end"
+msgstr "отдалечен път, където да се качи пакетът"
+
+msgid "force overwrite of local reference"
+msgstr "принудително презаписване на локален указател"
+
+msgid "fetch from multiple remotes"
+msgstr "доставяне от множество отдалечени хранилища"
+
+msgid "fetch all tags and associated objects"
+msgstr "доставяне на всички етикети и принадлежащи обекти"
+
+msgid "do not fetch all tags (--no-tags)"
+msgstr "без доставянето на всички етикети „--no-tags“"
+
+msgid "number of submodules fetched in parallel"
+msgstr "брой подмодули доставени паралелно"
+
+msgid "modify the refspec to place all refs within refs/prefetch/"
+msgstr ""
+"промяна на указателя, така че и той, както останалите, да бъде в „refs/"
+"prefetch/“"
+
+msgid "prune remote-tracking branches no longer on remote"
+msgstr "окастряне на клоните следящи вече несъществуващи отдалечени клони"
+
+msgid "prune local tags no longer on remote and clobber changed tags"
+msgstr ""
+"окастряне на локалните етикети, които вече не съществуват в отдалеченото "
+"хранилище и презаписване на променените"
+
+msgid "on-demand"
+msgstr "ПРИ НУЖДА"
+
+msgid "control recursive fetching of submodules"
+msgstr "управление на рекурсивното доставяне на подмодулите"
+
+msgid "write fetched references to the FETCH_HEAD file"
+msgstr "запазване на доставените указатели във файла „FETCH_HEAD“"
+
+msgid "keep downloaded pack"
+msgstr "запазване на изтеглените пакети с обекти"
+
+msgid "allow updating of HEAD ref"
+msgstr "позволяване на обновяването на указателя „HEAD“"
+
+msgid "deepen history of shallow clone"
+msgstr "задълбочаване на историята на плитко хранилище"
+
+msgid "deepen history of shallow repository based on time"
+msgstr "задълбочаване на историята на плитко хранилище до определено време"
+
+msgid "convert to a complete repository"
+msgstr "превръщане в пълно хранилище"
+
+msgid "re-fetch without negotiating common commits"
+msgstr "повторно доставяне без договаряне на общите подавания"
+
+msgid "prepend this to submodule path output"
+msgstr "добавяне на това пред пътя на подмодула"
+
+msgid ""
+"default for recursive fetching of submodules (lower priority than config "
+"files)"
+msgstr ""
+"стандартно рекурсивно изтегляне на подмодулите (файловете с настройки са с "
+"приоритет)"
+
+msgid "accept refs that update .git/shallow"
+msgstr "приемане на указатели, които обновяват „.git/shallow“"
+
+msgid "refmap"
+msgstr "КАРТА_С_УКАЗАТЕЛИ"
+
+msgid "specify fetch refmap"
+msgstr "указване на КАРТАта_С_УКАЗАТЕЛИ за доставяне"
+
+msgid "report that we have only objects reachable from this object"
+msgstr "докладване, че всички обекти може са достижими при започване от този"
+
+msgid "do not fetch a packfile; instead, print ancestors of negotiation tips"
+msgstr ""
+"без доставяне на пакетни файлове, вместо това да се извеждат предшественици "
+"на договорните върхове"
+
+msgid "run 'maintenance --auto' after fetching"
+msgstr "изпълняване на „maintenance --auto“ след доставяне"
+
+msgid "check for forced-updates on all updated branches"
+msgstr "проверка за принудителни обновявания на всички клони"
+
+msgid "write the commit-graph after fetching"
+msgstr "запазване на гра̀фа с подаванията след доставяне"
+
+msgid "accept refspecs from stdin"
+msgstr "четене на указателите от стандартния вход"
+
 msgid "--negotiate-only needs one or more --negotiation-tip=*"
 msgstr ""
 "Опцията „--negotiate-only“ изисква една или повече опции „--negotiation-"
@@ -6473,6 +6510,12 @@ msgstr "извеждане само на указателите, които съ
 msgid "print only refs which don't contain the commit"
 msgstr "извеждане само на указателите, които не съдържат това ПОДАВАНЕ"
 
+msgid "read reference patterns from stdin"
+msgstr "изчитане на шаблоните за указатели от стандартния вход"
+
+msgid "unknown arguments supplied with --stdin"
+msgstr "непознат аргумент към опцията „--stdin“"
+
 msgid "git for-each-repo --config=<config> [--] <arguments>"
 msgstr "git for-each-repo --config=НАСТРОЙКА [--] АРГУМЕНТ…"
 
@@ -6485,6 +6528,10 @@ msgstr "настройка, която съдържа списък с пътищ
 msgid "missing --config=<config>"
 msgstr "липсва --config=НАСТРОЙКА"
 
+#, c-format
+msgid "got bad config --config=%s"
+msgstr "получена е неправилена настройка „--config=%s“"
+
 msgid "unknown"
 msgstr "непознат"
 
@@ -6631,19 +6678,28 @@ msgstr "%s: несвързаният връх „HEAD“ не сочи към н
 msgid "notice: %s points to an unborn branch (%s)"
 msgstr "предупреждение: „%s“ сочи към все още несъществуващ клон (%s)"
 
-msgid "Checking cache tree"
-msgstr "Проверка на кеша на обектите-дървета"
+#, c-format
+msgid "Checking cache tree of %s"
+msgstr "Проверка на кеша на обектите-дървета на „%s“"
 
 #, c-format
-msgid "%s: invalid sha1 pointer in cache-tree"
-msgstr "„%s“: неправилен указател за SHA1 в кеша на обектите-дървета"
+msgid "%s: invalid sha1 pointer in cache-tree of %s"
+msgstr "„%s“: неправилен указател за SHA1 в кеша на обектите-дървета на „%s“"
 
 msgid "non-tree in cache-tree"
 msgstr "в кеша на обектите-дървета има нещо, което не е дърво"
 
 #, c-format
-msgid "%s: invalid sha1 pointer in resolve-undo"
-msgstr "„%s“: неправилен указател за отмяна на разрешените подавания"
+msgid "%s: invalid sha1 pointer in resolve-undo of %s"
+msgstr "„%s“: неправилен указател за отмяна на разрешените подавания на „%s“"
+
+#, c-format
+msgid "unable to load rev-index for pack '%s'"
+msgstr "обратният индекс на пакета „%s“ не може да бъде зареден"
+
+#, c-format
+msgid "invalid rev-index for pack '%s'"
+msgstr "неправилен обратен индекс за пакета „%s“"
 
 msgid ""
 "git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
@@ -9584,6 +9640,13 @@ msgstr "неподдържана версия на индекса „%s“"
 msgid "bad index version '%s'"
 msgstr "неправилна версия на индекса „%s“"
 
+msgid "show progress meter during object writing phase"
+msgstr "извеждане на напредъка във фазата на запазване на обектите"
+
+msgid "similar to --all-progress when progress meter is shown"
+msgstr ""
+"същото действие като опцията „--all-progress“ при извеждането на напредъка"
+
 msgid "<version>[,<offset>]"
 msgstr "ВЕРСИЯ[,ОТМЕСТВАНЕ]"
 
@@ -9788,6 +9851,9 @@ msgstr ""
 "ни известите с е-писмо до пощенския списък:\n"
 "<git@vger.kernel.org>.\n"
 
+msgid "refusing to run without --i-still-use-this"
+msgstr "трябва да добавите и опцията „--i-still-use-this“"
+
 msgid "git pack-refs [--all] [--no-prune]"
 msgstr "git pack-refs [--all] [--no-prune]"
 
@@ -9962,8 +10028,8 @@ msgstr "Обновяване на все още несъздаден клон с
 msgid "pull with rebase"
 msgstr "издърпване с пребазиране"
 
-msgid "please commit or stash them."
-msgstr "трябва да подадете или скатаете промѐните."
+msgid "Please commit or stash them."
+msgstr "Промѐните трябва или да се подадат, или да се скатаят."
 
 #, c-format
 msgid ""
@@ -10001,7 +10067,7 @@ msgstr "Не може да превъртите към повече от еди
 
 msgid "Need to specify how to reconcile divergent branches."
 msgstr ""
-"Трябва да укажете как да се решават разликите при разминаване на клоните."
+"Трябва да укажете как да се решават разликите при раздалечаване на клоните."
 
 msgid "cannot rebase with locally recorded submodule modifications"
 msgstr ""
@@ -10210,8 +10276,8 @@ msgstr "Неправилна стойност за „%s“"
 msgid "repository"
 msgstr "хранилище"
 
-msgid "push all refs"
-msgstr "изтласкване на всички указатели"
+msgid "push all branches"
+msgstr "изтласкване на всички клони"
 
 msgid "mirror all refs"
 msgstr "огледално копие на всички указатели"
@@ -10219,8 +10285,10 @@ msgstr "огледално копие на всички указатели"
 msgid "delete refs"
 msgstr "изтриване на указателите"
 
-msgid "push tags (can't be used with --all or --mirror)"
-msgstr "изтласкване на етикетите (несъвместимо с опциите „--all“ и „--mirror“)"
+msgid "push tags (can't be used with --all or --branches or --mirror)"
+msgstr ""
+"изтласкване на етикетите (несъвместимо с опциите „--all“, „--branches“ и „--"
+"mirror“)"
 
 msgid "force updates"
 msgstr "принудително обновяване"
@@ -10484,6 +10552,10 @@ msgstr ""
 "\n"
 "В резултат те не може да се пребазират."
 
+#, c-format
+msgid "Unknown rebase-merges mode: %s"
+msgstr "Неправилен режим за „--rebase-merges“: %s"
+
 #, c-format
 msgid "could not switch to %s"
 msgstr "не може да се премине към „%s“"
@@ -10499,6 +10571,15 @@ msgstr ""
 "неправилна стойност „%s“: вариантите са „drop“ (прескачане), "
 "„keep“ (запазване) и „ask“ (питане)"
 
+msgid ""
+"--rebase-merges with an empty string argument is deprecated and will stop "
+"working in a future version of Git. Use --rebase-merges without an argument "
+"instead, which does the same thing."
+msgstr ""
+"ползването на „--rebase-merges“ с празен низ за аргумент е остаряло и в "
+"бъдеще ще спре да работи. Ползвайте опцията „--rebase-merges“ без аргумент, "
+"за да постигнете същия резултат."
+
 #, c-format
 msgid ""
 "%s\n"
@@ -10728,21 +10809,24 @@ msgstr ""
 msgid "switch `C' expects a numerical value"
 msgstr "опцията „C“ очаква число за аргумент"
 
-#, c-format
-msgid "Unknown mode: %s"
-msgstr "Неизвестна стратегия: „%s“"
-
 msgid "--strategy requires --merge or --interactive"
 msgstr ""
 "опцията „--strategy“ изисква някоя от опциите „--merge“ или „--interactive“"
 
 msgid ""
-"apply options are incompatible with rebase.autosquash.  Consider adding --no-"
+"apply options are incompatible with rebase.autoSquash.  Consider adding --no-"
 "autosquash"
 msgstr ""
-"опциите за прилагане са несъвместими с „rebase.autosquash“.  Пробвайте да "
+"опциите за прилагане са несъвместими с „rebase.autoSquash“.  Пробвайте да "
 "добавите опцията „--no-autosquash“"
 
+msgid ""
+"apply options are incompatible with rebase.rebaseMerges.  Consider adding --"
+"no-rebase-merges"
+msgstr ""
+"опциите за прилагане са несъвместими с „rebase.rebaseMerges“.  Пробвайте да "
+"добавите опцията „--no-rebase-merges“"
+
 msgid ""
 "apply options are incompatible with rebase.updateRefs.  Consider adding --no-"
 "update-refs"
@@ -10789,9 +10873,6 @@ msgstr "„%s“: изисква се точно една база за преб
 msgid "Does not point to a valid commit '%s'"
 msgstr "Указателят „%s“ не сочи към подаване"
 
-msgid "Please commit or stash them."
-msgstr "Промѐните трябва или да се подадат, или да се скатаят."
-
 msgid "HEAD is up to date."
 msgstr "Указателят „HEAD“ е напълно актуален."
 
@@ -11476,9 +11557,9 @@ msgstr ""
 msgid "approxidate"
 msgstr "евристична дата"
 
-msgid "with -C, expire objects older than this"
+msgid "with --cruft, expire objects older than this"
 msgstr ""
-"с опцията „-C“: обявяване на обектите по-стари от това ВРЕМЕ за остарели"
+"с опцията „--cruft“: обявяване на обектите по-стари от това ВРЕМЕ за остарели"
 
 msgid "remove redundant packs, and run git-prune-packed"
 msgstr ""
@@ -12158,6 +12239,9 @@ msgstr ""
 msgid "remote name"
 msgstr "име на отдалечено хранилище"
 
+msgid "push all refs"
+msgstr "изтласкване на всички указатели"
+
 msgid "use stateless RPC protocol"
 msgstr "използване на протокол без запазване на състоянието за RPC"
 
@@ -12364,9 +12448,11 @@ msgstr ""
 "локалното хранилище"
 
 msgid ""
-"git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"
+"git sparse-checkout (init | list | set | add | reapply | disable | check-"
+"rules) [<options>]"
 msgstr ""
-"git sparse-checkout (init | list | set | add | reapply | disable) ОПЦИЯ…"
+"git sparse-checkout (init | list | set | add | reapply | disable | check-"
+"rules) ОПЦИЯ…"
 
 msgid "this worktree is not sparse"
 msgstr "това работно дърво не е частично"
@@ -12492,6 +12578,24 @@ msgstr ""
 msgid "error while refreshing working directory"
 msgstr "грешка при обновяване на работната директория"
 
+msgid ""
+"git sparse-checkout check-rules [-z] [--skip-checks][--[no-]cone] [--rules-"
+"file <file>]"
+msgstr ""
+"git sparse-checkout check-rules [-z] [--skip-checks] [--[no-]cone] [--rules-"
+"file ФАЙЛ]"
+
+msgid "terminate input and output files by a NUL character"
+msgstr "разделяне на входните и изходните файлове с нулевия знак „NUL“"
+
+msgid "when used with --rules-file interpret patterns as cone mode patterns"
+msgstr ""
+"когато е придружено с „--rules-file“ шаблоните се третират като шаблони в "
+"пътеводен режим"
+
+msgid "use patterns in <file> instead of the current ones."
+msgstr "ползване на шаблоните във ФАЙЛа вместо текущите."
+
 msgid "git stash list [<log-options>]"
 msgstr "git stash list [ОПЦИЯ_ЗА_ЖУРНАЛ…]"
 
@@ -15421,8 +15525,8 @@ msgstr "дължината на съкращаване е извън диапа
 msgid "bad zlib compression level %d"
 msgstr "неправилно ниво на компресиране: %d"
 
-msgid "core.commentChar should only be one character"
-msgstr "настройката „core.commentChar“ трябва да е само един знак"
+msgid "core.commentChar should only be one ASCII character"
+msgstr "настройката „core.commentChar“ трябва да е само един знак от ASCII"
 
 #, c-format
 msgid "ignoring unknown core.fsyncMethod value '%s'"
@@ -15539,6 +15643,10 @@ msgstr "„%s“ не може да се зададе да е „%s“"
 msgid "invalid section name: %s"
 msgstr "неправилно име на раздел: %s"
 
+#, c-format
+msgid "refusing to work with overly long line in '%s' on line %<PRIuMAX>"
+msgstr "ред %2$<PRIuMAX> в „%1$s“ е прекалено дълъг"
+
 #, c-format
 msgid "missing value for '%s'"
 msgstr "липсва стойност за „%s“"
@@ -16235,6 +16343,9 @@ msgstr "добавяне на допълнителен префикс за вс
 msgid "do not show any source or destination prefix"
 msgstr "без префикс за източника и целта"
 
+msgid "use default prefixes a/ and b/"
+msgstr "ползване на стандартните префикси „a/“ и „b/“"
+
 msgid "show context between diff hunks up to the specified number of lines"
 msgstr ""
 "извеждане на контекст между последователните парчета с разлики от указания "
@@ -16541,6 +16652,14 @@ msgstr "директорията на git не може да се мигрира
 msgid "hint: Waiting for your editor to close the file...%c"
 msgstr "Подсказка: чака се редакторът ви да затвори файла …%c"
 
+#, c-format
+msgid "could not write to '%s'"
+msgstr "в „%s“ не може да се пише"
+
+#, c-format
+msgid "could not edit '%s'"
+msgstr "„%s“ не може да се редактира"
+
 msgid "Filtering content"
 msgstr "Филтриране на съдържанието"
 
@@ -16845,6 +16964,10 @@ msgstr "опцията „-c“ изисква низ за настройка\n"
 msgid "no config key given for --config-env\n"
 msgstr "опцията „--config-env“ изисква ключ\n"
 
+#, c-format
+msgid "no attribute source given for --attr-source\n"
+msgstr "опцията „--attr-source“ изисква източник на атрибути\n"
+
 #, c-format
 msgid "unknown option: %s\n"
 msgstr "непозната опция: „%s“\n"
@@ -18587,6 +18710,10 @@ msgstr "„%s“ липсва в пакет „%s“ при отместване
 msgid "unable to get disk usage of '%s'"
 msgstr "използваното място за съхранение на „%s“ не може да бъде получено"
 
+#, c-format
+msgid "bitmap file '%s' has invalid checksum"
+msgstr "неправилна сума за проверка за файла с битови маски „%s“"
+
 #, c-format
 msgid "mtimes file %s is too small"
 msgstr "файлът с времето на промяна (mtime) „%s“ е твърде малък"
@@ -18633,6 +18760,14 @@ msgstr ""
 "идентификатор на контролна сума %2$<PRIu32> на файла с обратен индекс „%1$s“ "
 "не се поддържа"
 
+msgid "invalid checksum"
+msgstr "неправилна сума за проверка"
+
+#, c-format
+msgid "invalid rev-index position at %<PRIu64>: %<PRIu32> != %<PRIu32>"
+msgstr ""
+"неправилна позиция в обратния индекс при %<PRIu64>: %<PRIu32> != %<PRIu32>"
+
 msgid "cannot both write and verify reverse index"
 msgstr "обратният индекс не може едновременно да се записва и да се проверява"
 
@@ -19378,6 +19513,10 @@ msgstr "непознат аргумент за „%%(%s)“: %s"
 msgid "positive width expected with the %%(align) atom"
 msgstr "очаква се положителна широчина с лексемата „%%(align)“"
 
+#, c-format
+msgid "expected format: %%(ahead-behind:<committish>)"
+msgstr "очакван формат: %%(ahead-behind:ПОДАВАНЕ)"
+
 #, c-format
 msgid "malformed field name: %.*s"
 msgstr "неправилно име на обект: „%.*s“"
@@ -19929,10 +20068,10 @@ msgid_plural ""
 "Your branch and '%s' have diverged,\n"
 "and have %d and %d different commits each, respectively.\n"
 msgstr[0] ""
-"Текущият клон се е отделил от „%s“,\n"
+"Текущият клон се е раздалечил от „%s“,\n"
 "двата имат съответно по %d и %d несъвпадащи подавания.\n"
 msgstr[1] ""
-"Текущият клон се е отделил от „%s“,\n"
+"Текущият клон се е раздалечил от „%s“,\n"
 "двата имат съответно по %d и %d несъвпадащи подавания.\n"
 
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
@@ -20011,10 +20150,6 @@ msgstr "конфликтът в „%s“ не може да се обнови"
 msgid "no remembered resolution for '%s'"
 msgstr "липсва запазена корекция на конфликт при „%s“"
 
-#, c-format
-msgid "cannot unlink '%s'"
-msgstr "„%s“ не може да се изтрие"
-
 #, c-format
 msgid "Updated preimage for '%s'"
 msgstr "Предварителният вариант на „%s“ е обновен"
@@ -20383,10 +20518,6 @@ msgstr ""
 msgid "could not lock '%s'"
 msgstr "„%s“ не може да се заключи"
 
-#, c-format
-msgid "could not write to '%s'"
-msgstr "в „%s“ не може да се пише"
-
 #, c-format
 msgid "could not write eol to '%s'"
 msgstr "краят на ред не може да се запише в „%s“"
@@ -20757,9 +20888,6 @@ msgstr ""
 "директорията за определянето на последователността „%s“ не може да бъде "
 "създадена"
 
-msgid "could not lock HEAD"
-msgstr "указателят „HEAD“ не може да се заключи"
-
 msgid "no cherry-pick or revert in progress"
 msgstr ""
 "в момента не се извършва отбиране на подавания или пребазиране на клона"
@@ -20862,13 +20990,13 @@ msgstr ""
 "    git rebase --continue\n"
 "\n"
 
-msgid "and made changes to the index and/or the working tree\n"
-msgstr "и променѝ индекса и/или работното дърво\n"
+msgid "and made changes to the index and/or the working tree.\n"
+msgstr "и променѝ индекса и/или работното дърво.\n"
 
 #, c-format
 msgid ""
 "execution succeeded: %s\n"
-"but left changes to the index and/or the working tree\n"
+"but left changes to the index and/or the working tree.\n"
 "Commit or stash your changes, and then run\n"
 "\n"
 "  git rebase --continue\n"
@@ -21324,10 +21452,6 @@ msgid_plural "%u bytes/s"
 msgstr[0] "%u байт/сек."
 msgstr[1] "%u байта/сек."
 
-#, c-format
-msgid "could not edit '%s'"
-msgstr "„%s“ не може да се редактира"
-
 #, c-format
 msgid "ignoring suspicious submodule name: %s"
 msgstr "игнориране на подозрително име на подмодул: „%s“"
@@ -23085,13 +23209,17 @@ msgid "(%s) Could not execute '%s'"
 msgstr "(%s) Не може да бъде се изпълни „%s“"
 
 #, perl-format
-msgid "(%s) Adding %s: %s from: '%s'\n"
-msgstr "(%s) Добавяне на „%s: %s“ от: „%s“\n"
+msgid "(%s) Malformed output from '%s'"
+msgstr "(%s) Неправилен изход от: „%s“."
 
 #, perl-format
 msgid "(%s) failed to close pipe to '%s'"
 msgstr "(%s) програмният канал не може да се затвори за изпълнението на „%s“"
 
+#, perl-format
+msgid "(%s) Adding %s: %s from: '%s'\n"
+msgstr "(%s) Добавяне на „%s: %s“ от: „%s“\n"
+
 msgid "cannot send message as 7bit"
 msgstr "съобщението не може да се изпрати чрез 7 битови знаци"
 
-- 
2.47.1

