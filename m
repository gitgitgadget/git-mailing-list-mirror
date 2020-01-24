Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E1C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B39F2072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E05fhPjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgAXWdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:33:46 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37653 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgAXWdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:33:46 -0500
Received: by mail-wm1-f53.google.com with SMTP id f129so983374wmf.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=McAms4/NW2qZmb4DTZlcYxobAxiDp3pnnoFyCatmZO4=;
        b=E05fhPjvcXJ6wOHoiLGPVFe1qIm+Ea5OF/5nV5U5q8QaqiPqT3EQBwwTHraEnCiBBR
         19cM7V8InOMPc+sAzgbElIWJ2FMtQHgYev7lQ68/7Y/zg/lwM5/riGcknD0uuzngB1t2
         n5E3H+LkhGKcjdMwO8LYPFU3xBQu5EU2EniS/pOFvHnoOUnClBkBnmyo9TzRKOBOFO0J
         anBAMIbgfjpe5RiWl1+yUge/Sku1jvn9KkqNGeqzSAivHaMyI14SrMEJYPI9WXEI3+oK
         EAG/33KNE2s4V0DG3fYMcPS4poGzM6bpIjJVM4R3SQenB0cY1alib7/vPBOjnkkxGSDj
         JweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=McAms4/NW2qZmb4DTZlcYxobAxiDp3pnnoFyCatmZO4=;
        b=nXFdLFDpcYbLsewkiOuOwtL54iency6RLL7GkIO3mO99O/w1LE2drNeIQSfng6Ivy+
         hhj8qc9z3QFCsxlXoF4tD37rvSqL712SmbHV5OcLSvntcY9epcKDftj2TQFtSf07qB50
         aqo2mwuTByq1CrsnRkYx0+HXU01JyEYZJm11MJwER0cjZjHLg19OjqqdDHVXXhD9HR6w
         QLbOazALkpcZihWXduA4byg0e4jbrHoW4WbwFwBce1A+rERc1uDdakz2K/BLdEIxsl3r
         H2LIKgdMKdrKSqiQ1iTZPbWRJYZJyHHiyHek0UKUSEm8XAZtI+bqxcUEUNFZpTiadOrP
         QKHQ==
X-Gm-Message-State: APjAAAWsQ7sNQmjzJuOAMHnRMJ9R+K7W8nnEodJ2b+SrHNpkpN2J15qE
        x9hNlhKxTjcTl4c/887oAjK4kNMo
X-Google-Smtp-Source: APXvYqw2PedgauEzbckuIMvbVtrcBQehrbEmapXRCDkfAgXWw/Z6SI6JhqfbXv3tOODzouEra0R31w==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr1310559wmb.114.1579905222035;
        Fri, 24 Jan 2020 14:33:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm10185206wrx.81.2020.01.24.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:33:41 -0800 (PST)
Message-Id: <c91a84b0eddc22b021afe32ca4cb54c70d609c09.1579905218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.git.1579905218.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 22:33:38 +0000
Subject: [PATCH 3/3] git-gui: completed german translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Stimming <christian@cstimming.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Christian Stimming <christian@cstimming.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Stimming <christian@cstimming.de>

More glossary changed, mostly adapted to git-core German glossary at
https://github.com/ruester/git-po-de/wiki/Translation-Guidelines
and translation changed accordingly. One notable change in translation
is branch -> Branch. Overall increased consistency.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po          | 256 ++++++++++++++++++++++------------------------
 po/glossary/de.po |  83 +++++++--------
 2 files changed, 160 insertions(+), 179 deletions(-)

diff --git a/po/de.po b/po/de.po
index ae7b0d8fd9..b902d67f81 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2020-01-13 21:51+0100\n"
-"PO-Revision-Date: 2020-01-13 22:37+0100\n"
+"PO-Revision-Date: 2020-01-24 23:09+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "Language: de_DE\n"
@@ -89,11 +89,11 @@ msgstr "Nach geänderten Dateien suchen..."
 
 #: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
-msgstr "Aufrufen des »prepare-commit hook«..."
+msgstr "Aufrufen des »prepare-commit-msg hook«..."
 
 #: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr "Commit abgelehnt durch »prepare-commit hook«."
+msgstr "Commit abgelehnt durch »prepare-commit-msg hook«."
 
 #: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
@@ -103,7 +103,7 @@ msgstr "Bereit."
 #, tcl-format
 msgid ""
 "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
-msgstr ""
+msgstr "Anzeigelimit erreicht (gui.maxfilesdisplayed = %s) für Anzahl Einträge. Es werden nicht alle %s Dateien gezeigt."
 
 #: git-gui.sh:2091
 msgid "Unmodified"
@@ -147,7 +147,7 @@ msgstr "Dateityp-Änderung bereitgestellt, Datei gelöscht"
 
 #: git-gui.sh:2105
 msgid "Untracked, not staged"
-msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
+msgstr "Unversioniert, nicht bereitgestellt"
 
 #: git-gui.sh:2110
 msgid "Missing"
@@ -189,7 +189,7 @@ msgstr "Bearbeiten"
 
 #: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
-msgstr "Zweig"
+msgstr "Branch"
 
 #: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
@@ -209,7 +209,7 @@ msgstr "Werkzeuge"
 
 #: git-gui.sh:2748
 msgid "Explore Working Copy"
-msgstr "Arbeitskopie im Dateimanager"
+msgstr "Arbeitskopie im Dateimanager öffnen"
 
 #: git-gui.sh:2763
 msgid "Git Bash"
@@ -217,24 +217,24 @@ msgstr "Git Bash"
 
 #: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
-msgstr "Aktuellen Zweig durchblättern"
+msgstr "Aktuellen Branch durchblättern"
 
 #: git-gui.sh:2776
 msgid "Browse Branch Files..."
-msgstr "Einen Zweig durchblättern..."
+msgstr "Branch durchblättern..."
 
 #: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
-msgstr "Aktuellen Zweig darstellen"
+msgstr "Aktuellen Branch darstellen"
 
 #: git-gui.sh:2785
 msgid "Visualize All Branch History"
-msgstr "Alle Zweige darstellen"
+msgstr "Historie aller Branches darstellen"
 
 #: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "Zweig »%s« durchblättern"
+msgstr "Branch »%s« durchblättern"
 
 #: git-gui.sh:2794
 #, tcl-format
@@ -309,7 +309,7 @@ msgstr "Löschen..."
 
 #: git-gui.sh:2887
 msgid "Reset..."
-msgstr "Zurücksetzen..."
+msgstr "Umsetzen..."
 
 #: git-gui.sh:2897
 msgid "Done"
@@ -329,7 +329,7 @@ msgstr "Neu laden"
 
 #: git-gui.sh:2924
 msgid "Stage To Commit"
-msgstr "Zum Committen bereitstellen"
+msgstr "Für Commit bereitstellen"
 
 #: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
@@ -365,7 +365,7 @@ msgstr "Zusammenführen abbrechen..."
 
 #: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
-msgstr "Hinzufügen..."
+msgstr "Neues hinzufügen..."
 
 #: git-gui.sh:2998
 msgid "Push..."
@@ -373,7 +373,7 @@ msgstr "Versenden..."
 
 #: git-gui.sh:3002
 msgid "Delete Branch..."
-msgstr "Zweig löschen..."
+msgstr "Branch löschen..."
 
 #: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
@@ -422,7 +422,7 @@ msgstr ""
 
 #: git-gui.sh:3246
 msgid "Current Branch:"
-msgstr "Aktueller Zweig:"
+msgstr "Aktueller Branch:"
 
 #: git-gui.sh:3271
 msgid "Unstaged Changes"
@@ -534,11 +534,11 @@ msgstr "Diese Änderungen im Untermodul darstellen"
 
 #: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
-msgstr "Aktuellen Zweig im Untermodul darstellen"
+msgstr "Aktuellen Branch im Untermodul darstellen"
 
 #: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
-msgstr "Alle Zweige im Untermodul darstellen"
+msgstr "Alle Branches im Untermodul darstellen"
 
 #: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
@@ -668,12 +668,12 @@ msgstr "Neue Änderungen von »%s« holen"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "Extern aufräumen von »%s«"
+msgstr "Gelöschte externe Branches aus »%s« entfernen"
 
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+msgstr "Gelöschte externe Übernahmebranches aus »%s« werden entfernt"
 
 #: lib/transport.tcl:25
 msgid "fetch all remotes"
@@ -685,11 +685,11 @@ msgstr "Neue Änderungen von allen externen anfordern"
 
 #: lib/transport.tcl:40
 msgid "remote prune all remotes"
-msgstr "Extern aufräumen aller externen Repositories"
+msgstr "Extern veraltete Branches entfernen aller Repositories"
 
 #: lib/transport.tcl:41
 msgid "Pruning tracking branches deleted from all remotes"
-msgstr "Übernahmezweige aufräumen und entfernen, die in allen externen Repositories gelöscht wurden"
+msgstr "Gelöschte externe Übernahmebranches aus allen Repositories werden entfernt"
 
 #: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
 #: lib/remote_add.tcl:162
@@ -714,7 +714,7 @@ msgstr "%s %s nach %s versenden"
 
 #: lib/transport.tcl:132
 msgid "Push Branches"
-msgstr "Zweige versenden"
+msgstr "Branches versenden"
 
 #: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
 #: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
@@ -726,7 +726,7 @@ msgstr "Abbrechen"
 
 #: lib/transport.tcl:147
 msgid "Source Branches"
-msgstr "Lokale Zweige"
+msgstr "Lokale Branches"
 
 #: lib/transport.tcl:162
 msgid "Destination Repository"
@@ -746,8 +746,7 @@ msgstr "Netzwerk-Einstellungen"
 
 #: lib/transport.tcl:207
 msgid "Force overwrite existing branch (may discard changes)"
-msgstr ""
-"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
+msgstr "Überschreiben von existierenden Branches erzwingen (könnte Änderungen löschen)"
 
 #: lib/transport.tcl:211
 msgid "Use thin pack (for slow network connections)"
@@ -755,12 +754,12 @@ msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
 
 #: lib/transport.tcl:215
 msgid "Include tags"
-msgstr "Mit Markierungen übertragen"
+msgstr "Mit Markierungen versenden"
 
 #: lib/transport.tcl:229
 #, tcl-format
 msgid "%s (%s): Push"
-msgstr "%s (%s): Übertragen"
+msgstr "%s (%s): Versenden"
 
 #: lib/checkout_op.tcl:85
 #, tcl-format
@@ -770,7 +769,7 @@ msgstr "Änderungen »%s« von »%s« anfordern"
 #: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
+msgstr "Fehler: »%s« kann nicht als Branch oder Version erkannt werden"
 
 #: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
 #: lib/database.tcl:30
@@ -780,7 +779,7 @@ msgstr "Schließen"
 #: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
-msgstr "Zweig »%s« existiert nicht."
+msgstr "Branch »%s« existiert nicht."
 
 #: lib/checkout_op.tcl:194
 #, tcl-format
@@ -790,7 +789,7 @@ msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
 #: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "Zweig »%s« existiert bereits."
+msgstr "Branch »%s« existiert bereits."
 
 #: lib/checkout_op.tcl:229
 #, tcl-format
@@ -800,10 +799,9 @@ msgid ""
 "It cannot fast-forward to %s.\n"
 "A merge is required."
 msgstr ""
-"Zweig »%s« existiert bereits.\n"
+"Branch »%s« existiert bereits.\n"
 "\n"
-"Zweig kann nicht mit »%s« schnellzusammengeführt werden. Reguläres "
-"Zusammenführen ist notwendig."
+"Branch kann nicht auf »%s« vorgespult werden. Reguläres Zusammenführen ist notwendig."
 
 #: lib/checkout_op.tcl:243
 #, tcl-format
@@ -830,7 +828,7 @@ msgid ""
 msgstr ""
 "Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Repository seit dem letzten Laden geändert.  Vor dem Wechseln des lokalen Zweigs muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden geändert.  Vor dem Wechseln des lokalen Branches muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
@@ -846,9 +844,7 @@ msgstr "Dateien aktualisiert"
 #: lib/checkout_op.tcl:377
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr ""
-"Auf Zweig »%s« umstellen abgebrochen (Zusammenführen der Dateien ist "
-"notwendig)."
+msgstr "Auf Branch »%s« umstellen abgebrochen (Zusammenführen der Dateien ist notwendig)."
 
 #: lib/checkout_op.tcl:378
 msgid "File level merge required."
@@ -857,7 +853,7 @@ msgstr "Zusammenführen der Dateien ist notwendig."
 #: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
-msgstr "Es wird auf Zweig »%s« verblieben."
+msgstr "Es wird auf Branch »%s« verblieben."
 
 #: lib/checkout_op.tcl:453
 msgid ""
@@ -866,10 +862,9 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This Detached "
 "Checkout'."
 msgstr ""
-"Die Arbeitskopie ist nicht auf einem lokalen Zweig.\n"
+"Die Arbeitskopie ist nicht auf einem lokalen Branch.\n"
 "\n"
-"Wenn Sie auf einem Zweig arbeiten möchten, erstellen Sie bitte jetzt einen "
-"Zweig mit der Auswahl »Abgetrennte Arbeitskopie-Version«."
+"Wenn Sie auf einem Branch arbeiten möchten, erstellen Sie bitte jetzt einen Branch mit der Auswahl »Losgelöste Arbeitskopie-Version«."
 
 #: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
@@ -879,16 +874,16 @@ msgstr "Umgestellt auf »%s«."
 #: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Zurücksetzen von »%s« nach »%s« wird folgenden Commit verwerfen:"
+msgstr "Umsetzen von »%s« nach »%s« wird folgende Commits verlieren:"
 
 #: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
-msgstr "Verworfene Commits können nur mit größerem Aufwand wiederhergestellt werden."
+msgstr "Verlorene Commits können nur mit größerem Aufwand wiederhergestellt werden."
 
 #: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
-msgstr "»%s« zurücksetzen?"
+msgstr "»%s« umsetzen?"
 
 #: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
@@ -896,7 +891,7 @@ msgstr "Darstellen"
 
 #: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
 msgid "Reset"
-msgstr "Zurücksetzen"
+msgstr "Umsetzen"
 
 #: lib/checkout_op.tcl:636
 #, tcl-format
@@ -908,11 +903,9 @@ msgid ""
 "\n"
 "This should not have occurred.  %s will now close and give up."
 msgstr ""
-"Lokaler Zweig kann nicht gesetzt werden.\n"
+"Lokaler Branch kann nicht gesetzt werden.\n"
 "\n"
-"Diese Arbeitskopie ist nur teilweise umgestellt. Die Dateien sind korrekt "
-"aktualisiert, aber einige interne Git-Dateien konnten nicht geändert "
-"werden.\n"
+"Diese Arbeitskopie ist nur teilweise umgestellt. Die Dateien sind korrekt aktualisiert, aber einige interne Git-Dateien konnten nicht geändert werden.\n"
 "\n"
 "Dies ist ein interner Programmfehler von %s. Programm wird jetzt abgebrochen."
 
@@ -1007,11 +1000,11 @@ msgstr "[Nach oben]"
 #: lib/browser.tcl:275
 #, tcl-format
 msgid "%s (%s): Browse Branch Files"
-msgstr "%s (%s): Dateien des Zweigs durchblättern"
+msgstr "%s (%s): Dateien des Branches durchblättern"
 
 #: lib/browser.tcl:282
 msgid "Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
+msgstr "Dateien des Branches durchblättern"
 
 #: lib/browser.tcl:288 lib/choose_repository.tcl:437
 #: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
@@ -1055,7 +1048,7 @@ msgstr "Dateien"
 
 #: lib/index.tcl:326
 msgid "Unstaging selected files from commit"
-msgstr ""
+msgstr "Gewählte Dateien aus der Bereitstellung herausnehmen"
 
 #: lib/index.tcl:330
 #, tcl-format
@@ -1078,11 +1071,11 @@ msgstr "»%s« hinzufügen"
 #: lib/index.tcl:412
 #, tcl-format
 msgid "Stage %d untracked files?"
-msgstr ""
+msgstr "%d unversionierte Dateien bereitstellen?"
 
 #: lib/index.tcl:420
 msgid "Adding all changed files"
-msgstr ""
+msgstr "Alle geänderten Dateien hinzufügen"
 
 #: lib/index.tcl:503
 #, tcl-format
@@ -1104,14 +1097,14 @@ msgid "Do Nothing"
 msgstr "Nichts tun"
 
 #: lib/index.tcl:545
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Delete untracked file %s?"
-msgstr "Zweige auf »%s« werden gelöscht"
+msgstr "Unversionierte Datei »%s« löschen?"
 
 #: lib/index.tcl:550
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Delete these %i untracked files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+msgstr "Diese %i unversionierten Dateien löschen?"
 
 #: lib/index.tcl:560
 msgid "Files will be permanently deleted."
@@ -1151,11 +1144,11 @@ msgstr "Änderungen in %s verwerfen"
 #: lib/branch_checkout.tcl:16
 #, tcl-format
 msgid "%s (%s): Checkout Branch"
-msgstr "%s (%s): Auf Zweig umstellen"
+msgstr "%s (%s): Auf Branch umstellen"
 
 #: lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
-msgstr "Auf Zweig umstellen"
+msgstr "Auf Branch umstellen"
 
 #: lib/branch_checkout.tcl:26
 msgid "Checkout"
@@ -1167,11 +1160,11 @@ msgstr "Optionen"
 
 #: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Übernahmezweig anfordern"
+msgstr "Übernahmebranch anfordern"
 
 #: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
-msgstr "Verbindung zu lokalem Zweig lösen"
+msgstr "Verbindung zu lokalem Branch lösen"
 
 #: lib/status_bar.tcl:263
 #, tcl-format
@@ -1188,11 +1181,11 @@ msgstr "Externes Repository entfernen"
 
 #: lib/remote.tcl:223
 msgid "Prune from"
-msgstr "Aufräumen von"
+msgstr "Veraltete Branches entfernen"
 
 #: lib/remote.tcl:228
 msgid "Fetch from"
-msgstr "Anfordern von"
+msgstr "Anfordern"
 
 #: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
 msgid "All"
@@ -1201,11 +1194,11 @@ msgstr "Alle"
 #: lib/branch_rename.tcl:15
 #, tcl-format
 msgid "%s (%s): Rename Branch"
-msgstr "%s (%s): Zweig umbenennen"
+msgstr "%s (%s): Branch umbenennen"
 
 #: lib/branch_rename.tcl:23
 msgid "Rename Branch"
-msgstr "Zweig umbenennen"
+msgstr "Branch umbenennen"
 
 #: lib/branch_rename.tcl:28
 msgid "Rename"
@@ -1213,7 +1206,7 @@ msgstr "Umbenennen"
 
 #: lib/branch_rename.tcl:38
 msgid "Branch:"
-msgstr "Zweig:"
+msgstr "Branch:"
 
 #: lib/branch_rename.tcl:46
 msgid "New Name:"
@@ -1221,16 +1214,16 @@ msgstr "Neuer Name:"
 
 #: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
-msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
+msgstr "Bitte wählen Sie einen Branch zum umbenennen."
 
 #: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
 msgid "Please supply a branch name."
-msgstr "Bitte geben Sie einen Zweignamen an."
+msgstr "Bitte geben Sie einen Branchnamen an."
 
 #: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
-msgstr "»%s« ist kein zulässiger Zweigname."
+msgstr "»%s« ist kein zulässiger Branchname."
 
 #: lib/branch_rename.tcl:123
 #, tcl-format
@@ -1318,15 +1311,15 @@ msgstr "Auf Dateiänderungsdatum verlassen"
 
 #: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Übernahmezweige aufräumen während Anforderung"
+msgstr "Veraltete Übernahmebranches entfernen während Anforderung"
 
 #: lib/option.tcl:150
 msgid "Match Tracking Branches"
-msgstr "Passend zu Übernahmezweig"
+msgstr "Passend zu Übernahmebranch"
 
 #: lib/option.tcl:151
 msgid "Use Textconv For Diffs and Blames"
-msgstr ""
+msgstr "Benutze »textconv« für Vergleich und Annotieren"
 
 #: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
@@ -1342,7 +1335,7 @@ msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
 
 #: lib/option.tcl:155
 msgid "Blame History Context Radius (days)"
-msgstr "Anzahl Tage für Historien-Kontext"
+msgstr "Anzahl Tage für Annotieren-Historien-Kontext"
 
 #: lib/option.tcl:156
 msgid "Number of Diff Context Lines"
@@ -1350,7 +1343,7 @@ msgstr "Anzahl der Kontextzeilen beim Vergleich"
 
 #: lib/option.tcl:157
 msgid "Additional Diff Parameters"
-msgstr ""
+msgstr "Zusätzliche Vergleich-/diff-Parameter"
 
 #: lib/option.tcl:158
 msgid "Commit Message Text Width"
@@ -1358,7 +1351,7 @@ msgstr "Textbreite der Commit-Beschreibung"
 
 #: lib/option.tcl:159
 msgid "New Branch Name Template"
-msgstr "Namensvorschlag für neue Zweige"
+msgstr "Namensvorlage für neue Branches"
 
 #: lib/option.tcl:160
 msgid "Default File Contents Encoding"
@@ -1366,19 +1359,19 @@ msgstr "Voreingestellte Zeichenkodierung"
 
 #: lib/option.tcl:161
 msgid "Warn before committing to a detached head"
-msgstr ""
+msgstr "Warnen vor committen auf losgelöste Branchspitze"
 
 #: lib/option.tcl:162
 msgid "Staging of untracked files"
-msgstr ""
+msgstr "Unversionierte Dateien bereitstellen"
 
 #: lib/option.tcl:163
 msgid "Show untracked files"
-msgstr ""
+msgstr "Unversionierte Dateien anzeigen"
 
 #: lib/option.tcl:164
 msgid "Tab spacing"
-msgstr ""
+msgstr "Tabulator-Breite"
 
 #: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
 #: lib/database.tcl:57
@@ -1434,9 +1427,9 @@ msgid "Running %s requires a selected file."
 msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
 
 #: lib/tools.tcl:92
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "Wollen Sie %s wirklich starten?"
+msgstr "Wollen Sie %1$s wirklich auf Datei »%2$s« starten?"
 
 #: lib/tools.tcl:96
 #, tcl-format
@@ -1469,11 +1462,11 @@ msgstr "Konflikt durch Basisversion ersetzen?"
 
 #: lib/mergetool.tcl:9
 msgid "Force resolution to this branch?"
-msgstr "Konflikt durch diesen Zweig ersetzen?"
+msgstr "Konflikt durch diesen Branch ersetzen?"
 
 #: lib/mergetool.tcl:10
 msgid "Force resolution to the other branch?"
-msgstr "Konflikt durch anderen Zweig ersetzen?"
+msgstr "Konflikt durch anderen Branch ersetzen?"
 
 #: lib/mergetool.tcl:14
 #, tcl-format
@@ -1688,11 +1681,11 @@ msgstr "Fehler beim Erstellen des Icons:"
 #: lib/remote_branch_delete.tcl:29
 #, tcl-format
 msgid "%s (%s): Delete Branch Remotely"
-msgstr "%s (%s): Zweig in externem Repository löschen"
+msgstr "%s (%s): Branch in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Zweig in externem Repository löschen"
+msgstr "Branch in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
@@ -1700,7 +1693,7 @@ msgstr "In Repository"
 
 #: lib/remote_branch_delete.tcl:88
 msgid "Branches"
-msgstr "Zweige"
+msgstr "Branches"
 
 #: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
@@ -1716,7 +1709,7 @@ msgstr "Immer (Keine Zusammenführungsprüfung)"
 
 #: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
-msgstr "Für »Zusammenführen mit« muss ein Zweig angegeben werden."
+msgstr "Für »Zusammenführen mit« muss ein Branch angegeben werden."
 
 #: lib/remote_branch_delete.tcl:185
 #, tcl-format
@@ -1725,7 +1718,7 @@ msgid ""
 "\n"
 " - %s"
 msgstr ""
-"Folgende Zweige sind noch nicht mit »%s« zusammengeführt:\n"
+"Folgende Branches sind noch nicht mit »%s« zusammengeführt:\n"
 "\n"
 " - %s"
 
@@ -1738,7 +1731,7 @@ msgstr "Ein oder mehrere Zusammenführungen sind fehlgeschlagen, da Sie nicht di
 
 #: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
-msgstr "Bitte wählen Sie mindestens einen Zweig, der gelöscht werden soll."
+msgstr "Bitte wählen Sie mindestens einen Branch, der gelöscht werden soll."
 
 #: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
 msgid ""
@@ -1746,15 +1739,14 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
-"möglich.\n"
+"Das Wiederherstellen von gelöschten Branches ist nur mit größerem Aufwand möglich.\n"
 "\n"
-"Sollen die ausgewählten Zweige gelöscht werden?"
+"Sollen die ausgewählten Branches gelöscht werden?"
 
 #: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
-msgstr "Zweige auf »%s« werden gelöscht"
+msgstr "Branches auf »%s« werden gelöscht"
 
 #: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
@@ -1860,7 +1852,7 @@ msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
 
 #: lib/choose_repository.tcl:560
 msgid "Recursively clone submodules too"
-msgstr ""
+msgstr "Rekursiv weitere Untermodule klonen"
 
 #: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
 #: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
@@ -1907,7 +1899,7 @@ msgstr "Von »%s« konnte nichts geklont werden."
 #: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
 #: lib/choose_repository.tcl:974
 msgid "The 'master' branch has not been initialized."
-msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
+msgstr "Der »master«-Branch wurde noch nicht initialisiert."
 
 #: lib/choose_repository.tcl:755
 msgid "Hardlinks are unavailable.  Falling back to copying."
@@ -1946,9 +1938,7 @@ msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
 
 #: lib/choose_repository.tcl:903
 msgid "Cannot fetch branches and objects.  See console output for details."
-msgstr ""
-"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+msgstr "Branches und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die Ausgaben auf der Konsole für weitere Angaben."
 
 #: lib/choose_repository.tcl:914
 msgid "Cannot fetch tags.  See console output for details."
@@ -1958,9 +1948,7 @@ msgstr ""
 
 #: lib/choose_repository.tcl:938
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr ""
-"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+msgstr "Die Branchspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die Ausgaben auf der Konsole für weitere Angaben."
 
 #: lib/choose_repository.tcl:947
 #, tcl-format
@@ -1973,7 +1961,7 @@ msgstr "Klonen fehlgeschlagen."
 
 #: lib/choose_repository.tcl:960
 msgid "No default branch obtained."
-msgstr "Kein voreingestellter Zweig gefunden."
+msgstr "Kein voreingestellter Branch gefunden."
 
 #: lib/choose_repository.tcl:971
 #, tcl-format
@@ -1989,13 +1977,12 @@ msgid "Initial file checkout failed."
 msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
 
 #: lib/choose_repository.tcl:1072
-#, fuzzy
 msgid "Cloning submodules"
-msgstr "Kopieren von »%s«"
+msgstr "Klone Untermodul"
 
 #: lib/choose_repository.tcl:1087
 msgid "Cannot clone submodules."
-msgstr ""
+msgstr "Untermodul konnte nicht geklont werden."
 
 #: lib/choose_repository.tcl:1110
 msgid "Repository:"
@@ -2094,7 +2081,7 @@ msgstr "Ursprüngliche Datei:"
 
 #: lib/blame.tcl:1067
 msgid "Cannot find HEAD commit:"
-msgstr "Zweigspitze (»HEAD commit«) kann nicht gefunden werden:"
+msgstr "Branchspitze (»HEAD commit«) kann nicht gefunden werden:"
 
 #: lib/blame.tcl:1122
 msgid "Cannot find parent commit:"
@@ -2194,7 +2181,7 @@ msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
 msgstr ""
-"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
+"* Unversionierte Datei hat %d Bytes.\n"
 "* Nur erste %d Bytes werden angezeigt.\n"
 
 #: lib/diff.tcl:250
@@ -2205,7 +2192,7 @@ msgid ""
 "* To see the entire file, use an external editor.\n"
 msgstr ""
 "\n"
-"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
+"* Unversionierte Datei, hier abgeschnitten durch %s.\n"
 "* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
 
 #: lib/diff.tcl:583
@@ -2289,19 +2276,19 @@ msgstr "Ihr Schlüssel ist abgelegt in: %s"
 #: lib/branch_create.tcl:23
 #, tcl-format
 msgid "%s (%s): Create Branch"
-msgstr "%s (%s): Zweig erstellen"
+msgstr "%s (%s): Branch erstellen"
 
 #: lib/branch_create.tcl:28
 msgid "Create New Branch"
-msgstr "Neuen Zweig erstellen"
+msgstr "Neuen Branch erstellen"
 
 #: lib/branch_create.tcl:42
 msgid "Branch Name"
-msgstr "Zweigname"
+msgstr "Branchname"
 
 #: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
-msgstr "Passend zu Übernahmezweig-Name"
+msgstr "Passend zu Übernahmebranch-Name"
 
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -2309,7 +2296,7 @@ msgstr "Anfangsversion"
 
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "Existierenden Zweig aktualisieren:"
+msgstr "Existierenden Branch aktualisieren:"
 
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -2317,7 +2304,7 @@ msgstr "Nein"
 
 #: lib/branch_create.tcl:80
 msgid "Fast Forward Only"
-msgstr "Nur Schnellzusammenführung"
+msgstr "Nur Vorspulen"
 
 #: lib/branch_create.tcl:97
 msgid "Checkout After Creation"
@@ -2325,12 +2312,12 @@ msgstr "Arbeitskopie umstellen nach Erstellen"
 
 #: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
-msgstr "Bitte wählen Sie einen Übernahmezweig."
+msgstr "Bitte wählen Sie einen Übernahmebranch."
 
 #: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Übernahmezweig »%s« ist kein Zweig im externen Repository"
+msgstr "Übernahmebranch »%s« ist kein Branch im externen Repository."
 
 #: lib/console.tcl:59
 msgid "Working... please wait..."
@@ -2354,7 +2341,7 @@ msgstr "Gehe"
 
 #: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
-msgstr "Abgetrennte Arbeitskopie-Version"
+msgstr "Losgelöste Arbeitskopie-Version"
 
 #: lib/choose_rev.tcl:60
 msgid "Revision Expression:"
@@ -2362,11 +2349,11 @@ msgstr "Version Regexp-Ausdruck:"
 
 #: lib/choose_rev.tcl:72
 msgid "Local Branch"
-msgstr "Lokaler Zweig"
+msgstr "Lokaler Branch"
 
 #: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
-msgstr "Übernahmezweig"
+msgstr "Übernahmebranch"
 
 #: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
 msgid "Tag"
@@ -2518,14 +2505,17 @@ msgid ""
 " \n"
 " Do you really want to proceed with your Commit?"
 msgstr ""
+"Sie sind dabei, einen Commit auf losgelöste Branchspitze (»commit to detached head«) zu erstellen. Das ist riskant, denn wenn Sie zu einem anderen Branch wechseln, würden Sie diese Änderungen verlieren und es ist nachträglich schwierig, diese aus dem Commit-Log (»reflog«) wiederzufinden. Es wird empfohlen, diesen Commit abzubrechen und zunächst einen neuen Branch zu erstellen.\n"
+"\n"
+" Wollen Sie den Commit trotzdem in dieser Form erstellen?"
 
 #: lib/commit.tcl:299
 msgid "Calling commit-msg hook..."
-msgstr "Aufrufen des »commit-message hook«..."
+msgstr "Aufrufen des »commit-msg hook«..."
 
 #: lib/commit.tcl:314
 msgid "Commit declined by commit-msg hook."
-msgstr "Committen abgelehnt durch »commit-message hook«."
+msgstr "Committen abgelehnt durch »commit-msg hook«."
 
 #: lib/commit.tcl:327
 msgid "Committing changes..."
@@ -2573,20 +2563,20 @@ msgstr "update-ref fehlgeschlagen:"
 #: lib/commit.tcl:514
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Version %s übertragen: %s"
+msgstr "Commit %s erstellt: %s"
 
 #: lib/branch_delete.tcl:16
 #, tcl-format
 msgid "%s (%s): Delete Branch"
-msgstr "%s (%s): Zweig löschen"
+msgstr "%s (%s): Branch löschen"
 
 #: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
-msgstr "Lokalen Zweig löschen"
+msgstr "Lokalen Branch löschen"
 
 #: lib/branch_delete.tcl:39
 msgid "Local Branches"
-msgstr "Lokale Zweige"
+msgstr "Lokale Branches"
 
 #: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
@@ -2595,7 +2585,7 @@ msgstr "Nur löschen, wenn zusammengeführt nach"
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
-msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
+msgstr "Folgende Branches sind noch nicht mit »%s« zusammengeführt:"
 
 #: lib/branch_delete.tcl:131
 #, tcl-format
@@ -2608,7 +2598,7 @@ msgid ""
 "Failed to delete branches:\n"
 "%s"
 msgstr ""
-"Fehler beim Löschen der Zweige:\n"
+"Fehler beim Löschen der Branches:\n"
 "%s"
 
 #: lib/date.tcl:25
@@ -2818,11 +2808,11 @@ msgid ""
 "\n"
 "Continue with resetting the current changes?"
 msgstr ""
-"Änderungen zurücksetzen?\n"
+"Änderungen verwerfen?\n"
 "\n"
-"Wenn Sie zurücksetzen, gehen alle noch nicht committeten Änderungen verloren.\n"
+"Alle noch nicht committeten Änderungen würden verloren gehen.\n"
 "\n"
-"Änderungen jetzt zurücksetzen?"
+"Änderungen jetzt verwerfen?"
 
 #: lib/merge.tcl:246
 msgid "Aborting"
diff --git a/po/glossary/de.po b/po/glossary/de.po
index ed392748c2..c568c2743e 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
 "POT-Creation-Date: 2020-01-13 21:40+0100\n"
-"PO-Revision-Date: 2020-01-13 22:30+0100\n"
+"PO-Revision-Date: 2020-01-24 23:06+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "Language: de_DE\n"
@@ -20,18 +20,15 @@ msgid ""
 "English Term (Dear translator: This file will never be visible to the user!)"
 msgstr ""
 "Deutsche Übersetzung.\n"
+"Git-core glossary:\n"
+"  https://github.com/ruester/git-po-de/wiki/Translation-Guidelines\n"
+"\n"
 "Andere deutsche SCM:\n"
-"  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und http://"
-"tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_de.po "
-"(username=guest, password empty, gut),\n"
-"  http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Visual "
-"Source Safe, kommerziell),\n"
-"  http://cvsbook.red-bean.com/translations/german/Kap_06.html "
-"(mittelmäßig),\n"
-"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/de_DE.po?"
-"view=markup (mittelmäßig),\n"
-"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsvn.po "
-"(username=guest, password empty, schlecht)"
+"  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_de.po (username=guest, password empty, gut),\n"
+"  http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Visual Source Safe, kommerziell),\n"
+"  http://cvsbook.red-bean.com/translations/german/Kap_06.html (mittelmäßig),\n"
+"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/de_DE.po?view=markup (mittelmäßig),\n"
+"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsvn.po (username=guest, password empty, schlecht)"
 
 #. ""
 msgid "amend"
@@ -43,11 +40,11 @@ msgstr "annotieren"
 
 #. "A 'branch' is an active line of development."
 msgid "branch [noun]"
-msgstr "Zweig"
+msgstr "Branch"
 
 #. ""
 msgid "branch [verb]"
-msgstr "verzweigen"
+msgstr "branchen"
 
 #. ""
 msgid "checkout [noun]"
@@ -57,9 +54,7 @@ msgstr ""
 
 #. "The action of updating the working tree to a revision which was stored in the object database."
 msgid "checkout [verb]"
-msgstr ""
-"Arbeitskopie erstellen; Zweig umstellen [checkout a branch] (auschecken? "
-"ausspielen? abrufen? Source Safe: auschecken)"
+msgstr "Arbeitskopie erstellen; Branch umstellen [checkout a branch] (auschecken? ausspielen? abrufen? Source Safe: auschecken)"
 
 #. ""
 msgid "clone [verb]"
@@ -83,7 +78,7 @@ msgstr "vergleichen"
 
 #. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
 msgid "fast forward merge"
-msgstr "Schnellzusammenführung"
+msgstr "Vorspulen (-zusammenführung)"
 
 #. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
 msgid "fetch"
@@ -111,7 +106,7 @@ msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
 
 #. "Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
-msgstr "aufräumen (entfernen?)"
+msgstr "veraltete Branches entfernen (aufräumen?, entfernen?)"
 
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
@@ -135,7 +130,7 @@ msgstr "Repository"
 
 #. ""
 msgid "reset"
-msgstr "zurücksetzen (zurückkehren?)"
+msgstr "umsetzen (reset to commit), Änderungen verwerfen (reset to HEAD)"
 
 #. ""
 msgid "revert"
@@ -167,7 +162,7 @@ msgstr "markieren"
 
 #. "A regular git branch that is used to follow changes from another repository."
 msgid "tracking branch"
-msgstr "Übernahmezweig"
+msgstr "Übernahmebranch"
 
 #. ""
 msgid "undo"
@@ -187,11 +182,11 @@ msgstr "Arbeitskopie"
 
 #. "a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
 msgid "ancestor"
-msgstr ""
+msgstr "Vorgänger-Commit"
 
 #. "prematurely stop and abandon an operation"
 msgid "abort"
-msgstr ""
+msgstr "abbrechen"
 
 #. "a repository with only .git directory, without working directory"
 msgid "bare repository"
@@ -203,19 +198,19 @@ msgstr ""
 
 #. "get the authors responsible for each line in a file"
 msgid "blame"
-msgstr ""
+msgstr "annotieren"
 
 #. "to select and apply a single commit without merging"
 msgid "cherry-pick"
-msgstr ""
+msgstr "? pflücken? cherry-pick?"
 
 #. "a commit that directly succeeds the current one in git's graph of commits"
 msgid "child"
-msgstr ""
+msgstr "Kind-Commit"
 
 #. "clean the state of the git repository, often after manually stopped operation"
 msgid "cleanup"
-msgstr ""
+msgstr "aufräumen"
 
 #. "a message that gets attached with any commit"
 msgid "commit message"
@@ -223,11 +218,11 @@ msgstr "Commit-Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
 
 #. "a commit that precedes the current one in git's graph of commits (not necessarily directly)"
 msgid "descendant"
-msgstr ""
+msgstr "Nachfolger-Commit"
 
 #. "checkout of a revision rather than a some head"
 msgid "detached checkout"
-msgstr ""
+msgstr "losgelöster Commit (von Branch losgelöster Commit?)"
 
 #. "any merge strategy that works on a file by file basis"
 msgid "file level merging"
@@ -235,7 +230,7 @@ msgstr ""
 
 #. "the last revision in a branch"
 msgid "head"
-msgstr ""
+msgstr "HEAD / Branchspitze"
 
 #. "script that gets executed automatically on some event"
 msgid "hook"
@@ -243,29 +238,27 @@ msgstr ""
 
 #. "the first checkout during a clone operation"
 msgid "initial checkout"
-msgstr ""
+msgstr "Erstellen der Arbeitskopie, auschecken"
 
 #. "a branch that resides in the local git repository"
 msgid "local branch"
-msgstr ""
+msgstr "Lokaler Branch"
 
 #. "a Git object that is not part of any pack"
 msgid "loose object"
 msgstr ""
 
 #. "a branch called by convention 'master' that exists in a newly created git repository"
-#, fuzzy
 msgid "master branch"
-msgstr "Übernahmezweig"
+msgstr "Master-Branch"
 
 #. "a remote called by convention 'origin' that the current git repository has been cloned from"
 msgid "origin"
 msgstr "origin"
 
 #. "a file containing many git objects packed together"
-#, fuzzy
 msgid "pack [noun]"
-msgstr "Markierung"
+msgstr "Pack-Datei"
 
 #. "a Git object part of some pack"
 msgid "packed object"
@@ -273,34 +266,32 @@ msgstr ""
 
 #. "a commit that directly precedes the current one in git's graph of commits"
 msgid "parent"
-msgstr ""
+msgstr "Eltern-Commit"
 
 #. "the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
 msgid "reflog"
-msgstr ""
+msgstr "Commit-Log, »reflog«"
 
 #. "decide which changes from alternative versions of a file should persist in Git"
 msgid "resolve (a conflict)"
-msgstr ""
+msgstr "auflösen (einen Konflikt)"
 
 #. "abandon changes and go to pristine version"
-#, fuzzy
 msgid "revert changes"
-msgstr ""
-"verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
+msgstr "verwerfen (bei git-reset bzw. checkout), umkehren (bei git-revert, also mit neuem commit)"
 
 #. "expression that signifies a revision in git"
 msgid "revision expression"
-msgstr ""
+msgstr "Version Regexp-Ausdruck"
 
 #. "add some content of files and directories to the staging area in preparation for a commit"
 msgid "stage/unstage"
-msgstr ""
+msgstr "bereitstellen, in Bereitstellung vormerken / aus Bereitstellung herausnehmen"
 
 #. "temporarily save changes in a stack without committing"
 msgid "stash"
-msgstr ""
+msgstr "der Stash [noun], \"stash\" benutzen [verb]"
 
 #. "file whose content is tracked/not tracked by git"
 msgid "tracked/untracked"
-msgstr ""
+msgstr "versioniert/unversioniert"
-- 
gitgitgadget
