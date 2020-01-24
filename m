Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B30C32771
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CB62075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3ff/6/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgAXWdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:33:50 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34825 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgAXWdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:33:50 -0500
Received: by mail-wm1-f42.google.com with SMTP id p17so998279wmb.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 14:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8bMZvM0yxNFsDb8JBMneaaNlzSuikEzlM9s7MfaenMU=;
        b=f3ff/6/t9hvANSkvKdqcxPO2iyZEe65zJcslUUBfMkW2RxRX2o16DSePLZn+vDUtrN
         jrmdEnGdp5sGfe5jHr6JL4XVugjh00HcZ0lLHc9PVjPyNWL5XWSPyi8fP2EZEehIxrV1
         geEHn7h9+9r+qsZ6HXTaMlliVTc1iyky8PMl/rxUndQHxrWuGrXOHkdlQ6nJdRg3/mGp
         cCKKnpMeEhTtTa8kp7EIZKIW798WtkpgjnmuePzT8eo4hdRjRIr6JIDQRopyaIB+kfsk
         ASz/2ndPcuZDeXRCapwJAN4vK2g5Pes+/WkbIQ0B+suhTIkMnRTPnss5mVLQ1S3lRgO2
         KLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8bMZvM0yxNFsDb8JBMneaaNlzSuikEzlM9s7MfaenMU=;
        b=uXtV82PSp63yF/VS7ODyna5AjUrYYFK7kP0AgO9NFY8oy8H9ZyKuiBCzgLiZeS4JH6
         x1OIU4vW8JNi8gI6qW2owBBCutjfROVi2FdIOodmzDuyZkSLF8Mm3UI/2uFRP7E7wI1O
         k1Rp753Whp7z+eIt4tNX6Asc5VXrURaUUbcJ1Myac1JNJf95vRe5xA5M17zzZcMm93Di
         SmqL2IibQJUITVntC0e48vBX7bAHKyL+cIcoxYiCynfMxFSfwKfBf8d25kM6cpJ4dWLb
         2Dg8byd0YqXZw0/zAlnyeQSvrqmaMD25UqvelsaLBv72+mPDrKnKfpe9co1OG3Ekylv4
         5ANw==
X-Gm-Message-State: APjAAAW/ilnyLgsU/X94pO4QqVg8R5VCPuRz5Ftk2zen8hTFagvFCnw3
        21CWOaTuO5d/DOXlnvyCl1IZijzB
X-Google-Smtp-Source: APXvYqzJEIR7lNO4+ccmxhmsttKSeDtfkMSHztkKNFM1YDKKjl6gpJ8lcK24w7ItSwr1jjmrncuV0w==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr1227108wma.24.1579905220624;
        Fri, 24 Jan 2020 14:33:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm9456578wru.38.2020.01.24.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:33:40 -0800 (PST)
Message-Id: <1f6265c85806c9a164d4efd2f98d8f6ff592d1f0.1579905218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.git.1579905218.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 22:33:36 +0000
Subject: [PATCH 1/3] git-gui: update german translation to most recently
 created pot templates
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

No content changes so far, only the preparation for subsequent edits.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po          | 3520 ++++++++++++++++++++++++---------------------
 po/glossary/de.po |  131 +-
 2 files changed, 2040 insertions(+), 1611 deletions(-)

diff --git a/po/de.po b/po/de.po
index baebff2fff..162dc8aebe 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,41 +7,42 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 22:22+0100\n"
+"POT-Creation-Date: 2020-01-13 21:51+0100\n"
 "PO-Revision-Date: 2010-01-26 22:25+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
+"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: Programmfehler"
-
-#: git-gui.sh:743
+#: git-gui.sh:847
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ungültige Zeichensatz-Angabe in %s:"
 
-#: git-gui.sh:779
+#: git-gui.sh:901
 msgid "Main Font"
 msgstr "Programmschriftart"
 
-#: git-gui.sh:780
+#: git-gui.sh:902
 msgid "Diff/Console Font"
 msgstr "Vergleich-Schriftart"
 
-#: git-gui.sh:794
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 git-gui.sh:1053
+#: git-gui.sh:3212
+msgid "git-gui: fatal error"
+msgstr "git-gui: Programmfehler"
+
+#: git-gui.sh:918
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:821
+#: git-gui.sh:945
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
 
-#: git-gui.sh:839
+#: git-gui.sh:970
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,479 +61,532 @@ msgstr ""
 "\n"
 "Soll angenommen werden, »%s« sei Version 1.5.0?\n"
 
-#: git-gui.sh:1128
+#: git-gui.sh:1267
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
 
-#: git-gui.sh:1146
+#: git-gui.sh:1301
 msgid "Cannot move to top of working directory:"
 msgstr ""
 "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie gewechselt "
 "werden:"
 
-#: git-gui.sh:1154
+#: git-gui.sh:1309
 msgid "Cannot use bare repository:"
 msgstr "Bloßes Projektarchiv kann nicht benutzt werden:"
 
-#: git-gui.sh:1162
+#: git-gui.sh:1317
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
 
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
 
-#: git-gui.sh:1390
+#: git-gui.sh:1551
 msgid "Scanning for modified files ..."
 msgstr "Nach geänderten Dateien suchen..."
 
-#: git-gui.sh:1454
+#: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
-msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle (»prepare-commit hook«)..."
+msgstr ""
+"Aufrufen der Eintragen-Vorbereiten-Kontrolle (»prepare-commit hook«)..."
 
-#: git-gui.sh:1471
+#: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 "Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (»prepare-commit "
 "hook«)."
 
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
 msgstr "Bereit."
 
-#: git-gui.sh:1787
+#: git-gui.sh:1968
 #, tcl-format
-msgid "Displaying only %s of %s files."
-msgstr "Nur %s von %s Dateien werden angezeigt."
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
+msgstr ""
 
-#: git-gui.sh:1913
+#: git-gui.sh:2091
 msgid "Unmodified"
 msgstr "Unverändert"
 
-#: git-gui.sh:1915
+#: git-gui.sh:2093
 msgid "Modified, not staged"
 msgstr "Verändert, nicht bereitgestellt"
 
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
 
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
 
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
 
-#: git-gui.sh:1920
+#: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr "Dateityp geändert, nicht bereitgestellt"
 
-#: git-gui.sh:1921
+#: git-gui.sh:2099 git-gui.sh:2100
+#, fuzzy
+msgid "File type changed, old type staged for commit"
+msgstr "Dateityp geändert, nicht bereitgestellt"
+
+#: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr "Dateityp geändert, bereitgestellt"
 
-#: git-gui.sh:1923
+#: git-gui.sh:2102
+#, fuzzy
+msgid "File type change staged, modification not staged"
+msgstr "Dateityp geändert, nicht bereitgestellt"
+
+#: git-gui.sh:2103
+#, fuzzy
+msgid "File type change staged, file missing"
+msgstr "Dateityp geändert, bereitgestellt"
+
+#: git-gui.sh:2105
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
 
-#: git-gui.sh:1928
+#: git-gui.sh:2110
 msgid "Missing"
 msgstr "Fehlend"
 
-#: git-gui.sh:1929
+#: git-gui.sh:2111
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum Löschen"
 
-#: git-gui.sh:1930
+#: git-gui.sh:2112
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum Löschen, trotzdem vorhanden"
 
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
 msgid "Requires merge resolution"
 msgstr "Konfliktauflösung nötig"
 
-#: git-gui.sh:1972
-msgid "Starting gitk... please wait..."
-msgstr "Gitk wird gestartet... bitte warten."
-
-#: git-gui.sh:1984
+#: git-gui.sh:2164
 msgid "Couldn't find gitk in PATH"
 msgstr "Gitk kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:2043
+#: git-gui.sh:2210 git-gui.sh:2245
+#, fuzzy, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "Gitk wird gestartet... bitte warten."
+
+#: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
 msgstr "»Git gui« kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
 msgstr "Projektarchiv"
 
-#: git-gui.sh:2456
+#: git-gui.sh:2727
 msgid "Edit"
 msgstr "Bearbeiten"
 
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "Zweig"
 
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "Version"
 
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr "Zusammenführen"
 
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "Externe Archive"
 
-#: git-gui.sh:2468
+#: git-gui.sh:2739
 msgid "Tools"
 msgstr "Werkzeuge"
 
-#: git-gui.sh:2477
+#: git-gui.sh:2748
 msgid "Explore Working Copy"
 msgstr "Arbeitskopie im Dateimanager"
 
-#: git-gui.sh:2483
+#: git-gui.sh:2763
+msgid "Git Bash"
+msgstr ""
+
+#: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchblättern"
 
-#: git-gui.sh:2487
+#: git-gui.sh:2776
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchblättern..."
 
-#: git-gui.sh:2492
+#: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
 
-#: git-gui.sh:2496
+#: git-gui.sh:2785
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
 
-#: git-gui.sh:2503
+#: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig »%s« durchblättern"
 
-#: git-gui.sh:2505
+#: git-gui.sh:2794
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von »%s« darstellen"
 
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
 
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2802 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
 
-#: git-gui.sh:2516
+#: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "Datenbank überprüfen"
 
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
-#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
 
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
 msgid "Quit"
 msgstr "Beenden"
 
-#: git-gui.sh:2547
+#: git-gui.sh:2836
 msgid "Undo"
 msgstr "Rückgängig"
 
-#: git-gui.sh:2550
+#: git-gui.sh:2839
 msgid "Redo"
 msgstr "Wiederholen"
 
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2843 git-gui.sh:3461
 msgid "Cut"
 msgstr "Ausschneiden"
 
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopieren"
 
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2849 git-gui.sh:3467
 msgid "Paste"
 msgstr "Einfügen"
 
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr "Löschen"
 
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
 msgid "Select All"
 msgstr "Alle auswählen"
 
-#: git-gui.sh:2576
+#: git-gui.sh:2865
 msgid "Create..."
 msgstr "Erstellen..."
 
-#: git-gui.sh:2582
+#: git-gui.sh:2871
 msgid "Checkout..."
 msgstr "Umstellen..."
 
-#: git-gui.sh:2588
+#: git-gui.sh:2877
 msgid "Rename..."
 msgstr "Umbenennen..."
 
-#: git-gui.sh:2593
+#: git-gui.sh:2882
 msgid "Delete..."
 msgstr "Löschen..."
 
-#: git-gui.sh:2598
+#: git-gui.sh:2887
 msgid "Reset..."
 msgstr "Zurücksetzen..."
 
-#: git-gui.sh:2608
+#: git-gui.sh:2897
 msgid "Done"
 msgstr "Fertig"
 
-#: git-gui.sh:2610
+#: git-gui.sh:2899
 msgid "Commit@@verb"
 msgstr "Eintragen"
 
-#: git-gui.sh:2619 git-gui.sh:3050
-msgid "New Commit"
-msgstr "Neue Version"
-
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
 msgstr "Letzte nachbessern"
 
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "Neu laden"
 
-#: git-gui.sh:2643
+#: git-gui.sh:2924
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
 
-#: git-gui.sh:2649
+#: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
 msgstr "Geänderte Dateien bereitstellen"
 
-#: git-gui.sh:2655
+#: git-gui.sh:2936
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
 msgstr "Änderungen verwerfen"
 
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
 msgid "Show Less Context"
 msgstr "Weniger Zeilen anzeigen"
 
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
 msgid "Show More Context"
 msgstr "Mehr Zeilen anzeigen"
 
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
 msgid "Sign Off"
 msgstr "Abzeichnen"
 
-#: git-gui.sh:2696
+#: git-gui.sh:2977
 msgid "Local Merge..."
 msgstr "Lokales Zusammenführen..."
 
-#: git-gui.sh:2701
+#: git-gui.sh:2982
 msgid "Abort Merge..."
 msgstr "Zusammenführen abbrechen..."
 
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
 msgstr "Hinzufügen..."
 
-#: git-gui.sh:2717
+#: git-gui.sh:2998
 msgid "Push..."
 msgstr "Versenden..."
 
-#: git-gui.sh:2721
+#: git-gui.sh:3002
 msgid "Delete Branch..."
 msgstr "Zweig löschen..."
 
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
 msgstr "Optionen..."
 
-#: git-gui.sh:2742
+#: git-gui.sh:3023
 msgid "Remove..."
 msgstr "Entfernen..."
 
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
 msgid "Help"
 msgstr "Hilfe"
 
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
 #, tcl-format
 msgid "About %s"
 msgstr "Über %s"
 
-#: git-gui.sh:2783
+#: git-gui.sh:3064
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
 
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
 msgid "Show SSH Key"
 msgstr "SSH-Schlüssel anzeigen"
 
-#: git-gui.sh:2893
+#: git-gui.sh:3097 git-gui.sh:3229
+msgid "usage:"
+msgstr ""
+
+#: git-gui.sh:3101 git-gui.sh:3233
+msgid "Usage"
+msgstr ""
+
+#: git-gui.sh:3182 lib/blame.tcl:575
+#, fuzzy
+msgid "Error"
+msgstr "Fehler"
+
+#: git-gui.sh:3213
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "Fehler: Verzeichnis »%s« kann nicht gelesen werden: Datei oder Verzeichnis "
 "nicht gefunden"
 
-#: git-gui.sh:2926
+#: git-gui.sh:3246
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
 
-#: git-gui.sh:2947
-msgid "Staged Changes (Will Commit)"
-msgstr "Bereitstellung (zum Eintragen)"
-
-#: git-gui.sh:2967
+#: git-gui.sh:3271
 msgid "Unstaged Changes"
 msgstr "Nicht bereitgestellte Änderungen"
 
-#: git-gui.sh:3017
+#: git-gui.sh:3293
+msgid "Staged Changes (Will Commit)"
+msgstr "Bereitstellung (zum Eintragen)"
+
+#: git-gui.sh:3367
 msgid "Stage Changed"
 msgstr "Alles bereitstellen"
 
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3386 lib/transport.tcl:137
 msgid "Push"
 msgstr "Versenden"
 
-#: git-gui.sh:3071
+#: git-gui.sh:3413
 msgid "Initial Commit Message:"
 msgstr "Erste Versionsbeschreibung:"
 
-#: git-gui.sh:3072
+#: git-gui.sh:3414
 msgid "Amended Commit Message:"
 msgstr "Nachgebesserte Beschreibung:"
 
-#: git-gui.sh:3073
+#: git-gui.sh:3415
 msgid "Amended Initial Commit Message:"
 msgstr "Nachgebesserte erste Beschreibung:"
 
-#: git-gui.sh:3074
+#: git-gui.sh:3416
 msgid "Amended Merge Commit Message:"
 msgstr "Nachgebesserte Zusammenführungs-Beschreibung:"
 
-#: git-gui.sh:3075
+#: git-gui.sh:3417
 msgid "Merge Commit Message:"
 msgstr "Zusammenführungs-Beschreibung:"
 
-#: git-gui.sh:3076
+#: git-gui.sh:3418
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
 
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Alle kopieren"
 
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3501 lib/blame.tcl:106
 msgid "File:"
 msgstr "Datei:"
 
-#: git-gui.sh:3255
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr "Öffnen"
+
+#: git-gui.sh:3629
 msgid "Refresh"
 msgstr "Aktualisieren"
 
-#: git-gui.sh:3276
+#: git-gui.sh:3650
 msgid "Decrease Font Size"
 msgstr "Schriftgröße verkleinern"
 
-#: git-gui.sh:3280
+#: git-gui.sh:3654
 msgid "Increase Font Size"
 msgstr "Schriftgröße vergrößern"
 
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3662 lib/blame.tcl:296
 msgid "Encoding"
 msgstr "Zeichenkodierung"
 
-#: git-gui.sh:3299
+#: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
 
-#: git-gui.sh:3304
+#: git-gui.sh:3678
 msgid "Apply/Reverse Line"
 msgstr "Zeile anwenden/umkehren"
 
-#: git-gui.sh:3323
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+#, fuzzy
+msgid "Revert Hunk"
+msgstr "Kontext anwenden/umkehren"
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+#, fuzzy
+msgid "Revert Line"
+msgstr "Änderungen verwerfen"
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr ""
+
+#: git-gui.sh:3713
 msgid "Run Merge Tool"
 msgstr "Zusammenführungswerkzeug"
 
-#: git-gui.sh:3328
+#: git-gui.sh:3718
 msgid "Use Remote Version"
 msgstr "Externe Version benutzen"
 
-#: git-gui.sh:3332
+#: git-gui.sh:3722
 msgid "Use Local Version"
 msgstr "Lokale Version benutzen"
 
-#: git-gui.sh:3336
+#: git-gui.sh:3726
 msgid "Revert To Base"
 msgstr "Ursprüngliche Version benutzen"
 
-#: git-gui.sh:3354
+#: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
 msgstr "Diese Änderungen im Untermodul darstellen"
 
-#: git-gui.sh:3358
+#: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "Aktuellen Zweig im Untermodul darstellen"
 
-#: git-gui.sh:3362
+#: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
 msgstr "Alle Zweige im Untermodul darstellen"
 
-#: git-gui.sh:3367
+#: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
 msgstr "Git gui im Untermodul starten"
 
-#: git-gui.sh:3389
+#: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
 
-#: git-gui.sh:3391
+#: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr "Zeilen aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:3393
+#: git-gui.sh:3798 git-gui.sh:3809
+#, fuzzy
+msgid "Revert Lines"
+msgstr "Änderungen verwerfen"
+
+#: git-gui.sh:3800
 msgid "Unstage Line From Commit"
 msgstr "Zeile aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:3396
+#: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
 msgstr "Kontext zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3398
+#: git-gui.sh:3808
 msgid "Stage Lines For Commit"
 msgstr "Zeilen zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3400
+#: git-gui.sh:3811
 msgid "Stage Line For Commit"
 msgstr "Zeile zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3424
+#: git-gui.sh:3861
 msgid "Initializing..."
 msgstr "Initialisieren..."
 
-#: git-gui.sh:3541
+#: git-gui.sh:4017
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -548,7 +602,7 @@ msgstr ""
 "von %s an Git weitergegeben werden:\n"
 "\n"
 
-#: git-gui.sh:3570
+#: git-gui.sh:4046
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -558,7 +612,7 @@ msgstr ""
 "Dies ist ein bekanntes Problem der Tcl-Version, die\n"
 "in Cygwin mitgeliefert wird."
 
-#: git-gui.sh:3575
+#: git-gui.sh:4051
 #, tcl-format
 msgid ""
 "\n"
@@ -574,341 +628,183 @@ msgstr ""
 "gewünschten Werte für die Einstellung user.name und \n"
 "user.email in Ihre Datei ~/.gitconfig einfügen.\n"
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
-msgstr "git-gui - eine grafische Oberfläche für Git."
-
-#: lib/blame.tcl:72
-msgid "File Viewer"
-msgstr "Datei-Browser"
-
-#: lib/blame.tcl:78
-msgid "Commit:"
-msgstr "Version:"
-
-#: lib/blame.tcl:271
-msgid "Copy Commit"
-msgstr "Version kopieren"
-
-#: lib/blame.tcl:275
-msgid "Find Text..."
-msgstr "Text suchen..."
-
-#: lib/blame.tcl:284
-msgid "Do Full Copy Detection"
-msgstr "Volle Kopie-Erkennung"
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Rechtschreibprüfungsprogramm nicht unterstützt"
 
-#: lib/blame.tcl:288
-msgid "Show History Context"
-msgstr "Historien-Kontext anzeigen"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Rechtschreibprüfung nicht verfügbar"
 
-#: lib/blame.tcl:291
-msgid "Blame Parent Commit"
-msgstr "Elternversion annotieren"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Unbenutzbare Konfiguration der Rechtschreibprüfung"
 
-#: lib/blame.tcl:450
+#: lib/spellcheck.tcl:70
 #, tcl-format
-msgid "Reading %s..."
-msgstr "%s lesen..."
-
-#: lib/blame.tcl:557
-msgid "Loading copy/move tracking annotations..."
-msgstr "Annotierungen für Kopieren/Verschieben werden geladen..."
-
-#: lib/blame.tcl:577
-msgid "lines annotated"
-msgstr "Zeilen annotiert"
+msgid "Reverting dictionary to %s."
+msgstr "Wörterbuch auf %s zurückgesetzt."
 
-#: lib/blame.tcl:769
-msgid "Loading original location annotations..."
-msgstr "Annotierungen für ursprünglichen Ort werden geladen..."
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Rechtschreibprüfungsprogramm mit Fehler abgebrochen"
 
-#: lib/blame.tcl:772
-msgid "Annotation complete."
-msgstr "Annotierung vollständig."
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Unbekanntes Rechtschreibprüfungsprogramm"
 
-#: lib/blame.tcl:802
-msgid "Busy"
-msgstr "Verarbeitung läuft"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Keine Vorschläge"
 
-#: lib/blame.tcl:803
-msgid "Annotation process is already running."
-msgstr "Annotierung läuft bereits."
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Unerwartetes EOF vom Rechtschreibprüfungsprogramm"
 
-#: lib/blame.tcl:842
-msgid "Running thorough copy detection..."
-msgstr "Intensive Kopie-Erkennung läuft..."
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Rechtschreibprüfung fehlgeschlagen"
 
-#: lib/blame.tcl:910
-msgid "Loading annotation..."
-msgstr "Annotierung laden..."
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
+msgstr "»%s« anfordern"
 
-#: lib/blame.tcl:963
-msgid "Author:"
-msgstr "Autor:"
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Neue Änderungen von »%s« holen"
 
-#: lib/blame.tcl:967
-msgid "Committer:"
-msgstr "Eintragender:"
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "Aufräumen von »%s«"
 
-#: lib/blame.tcl:972
-msgid "Original File:"
-msgstr "Ursprüngliche Datei:"
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
 
-#: lib/blame.tcl:1020
-msgid "Cannot find HEAD commit:"
-msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr ""
 
-#: lib/blame.tcl:1075
-msgid "Cannot find parent commit:"
-msgstr "Elternversion kann nicht gefunden werden:"
+#: lib/transport.tcl:26
+#, fuzzy
+msgid "Fetching new changes from all remotes"
+msgstr "Neue Änderungen von »%s« holen"
 
-#: lib/blame.tcl:1090
-msgid "Unable to display parent"
-msgstr "Elternversion kann nicht angezeigt werden"
+#: lib/transport.tcl:40
+#, fuzzy
+msgid "remote prune all remotes"
+msgstr "Aufräumen von »%s«"
 
-#: lib/blame.tcl:1091 lib/diff.tcl:320
-msgid "Error loading diff:"
-msgstr "Fehler beim Laden des Vergleichs:"
+#: lib/transport.tcl:41
+#, fuzzy
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
 
-#: lib/blame.tcl:1231
-msgid "Originally By:"
-msgstr "Ursprünglich von:"
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "»%s« versenden..."
 
-#: lib/blame.tcl:1237
-msgid "In File:"
-msgstr "In Datei:"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Änderungen nach »%s« versenden"
 
-#: lib/blame.tcl:1242
-msgid "Copied Or Moved Here By:"
-msgstr "Kopiert oder verschoben durch:"
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Spiegeln nach %s"
 
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
-msgid "Checkout Branch"
-msgstr "Auf Zweig umstellen"
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "%s %s nach %s versenden"
 
-#: lib/branch_checkout.tcl:23
-msgid "Checkout"
-msgstr "Umstellen"
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Zweige versenden"
 
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
 msgstr "Abbrechen"
 
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
-msgid "Revision"
-msgstr "Version"
-
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
-msgid "Options"
-msgstr "Optionen"
-
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
-msgstr "Übernahmezweig anfordern"
-
-#: lib/branch_checkout.tcl:44
-msgid "Detach From Local Branch"
-msgstr "Verbindung zu lokalem Zweig lösen"
-
-#: lib/branch_create.tcl:22
-msgid "Create Branch"
-msgstr "Zweig erstellen"
-
-#: lib/branch_create.tcl:27
-msgid "Create New Branch"
-msgstr "Neuen Zweig erstellen"
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Lokale Zweige"
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
-msgid "Create"
-msgstr "Erstellen"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Ziel-Projektarchiv"
 
-#: lib/branch_create.tcl:40
-msgid "Branch Name"
-msgstr "Zweigname"
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "Externes Archiv:"
 
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
-msgid "Name:"
-msgstr "Name:"
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Adresse:"
 
-#: lib/branch_create.tcl:58
-msgid "Match Tracking Branch Name"
-msgstr "Passend zu Übernahmezweig-Name"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Netzwerk-Einstellungen"
 
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
-msgstr "Anfangsversion"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr ""
+"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
 
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
-msgstr "Existierenden Zweig aktualisieren:"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
 
-#: lib/branch_create.tcl:75
-msgid "No"
-msgstr "Nein"
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Mit Markierungen übertragen"
 
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
-msgstr "Nur Schnellzusammenführung"
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr ""
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
-msgstr "Zurücksetzen"
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Änderungen »%s« von »%s« anfordern"
 
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
-msgstr "Arbeitskopie umstellen nach Erstellen"
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
 
-#: lib/branch_create.tcl:131
-msgid "Please select a tracking branch."
-msgstr "Bitte wählen Sie einen Übernahmezweig."
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Schließen"
 
-#: lib/branch_create.tcl:140
+#: lib/checkout_op.tcl:175
 #, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+msgid "Branch '%s' does not exist."
+msgstr "Zweig »%s« existiert nicht."
 
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
-msgid "Please supply a branch name."
-msgstr "Bitte geben Sie einen Zweignamen an."
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
 
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
-#, tcl-format
-msgid "'%s' is not an acceptable branch name."
-msgstr "»%s« ist kein zulässiger Zweigname."
-
-#: lib/branch_delete.tcl:15
-msgid "Delete Branch"
-msgstr "Zweig löschen"
-
-#: lib/branch_delete.tcl:20
-msgid "Delete Local Branch"
-msgstr "Lokalen Zweig löschen"
-
-#: lib/branch_delete.tcl:37
-msgid "Local Branches"
-msgstr "Lokale Zweige"
-
-#: lib/branch_delete.tcl:52
-msgid "Delete Only If Merged Into"
-msgstr "Nur löschen, wenn zusammengeführt nach"
-
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "Immer (Keine Zusammenführungsprüfung)"
-
-#: lib/branch_delete.tcl:103
-#, tcl-format
-msgid "The following branches are not completely merged into %s:"
-msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
-
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
-"möglich.\n"
-"\n"
-"Sollen die ausgewählten Zweige gelöscht werden?"
-
-#: lib/branch_delete.tcl:141
-#, tcl-format
-msgid ""
-"Failed to delete branches:\n"
-"%s"
-msgstr ""
-"Fehler beim Löschen der Zweige:\n"
-"%s"
-
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
-msgid "Rename Branch"
-msgstr "Zweig umbenennen"
-
-#: lib/branch_rename.tcl:26
-msgid "Rename"
-msgstr "Umbenennen"
-
-#: lib/branch_rename.tcl:36
-msgid "Branch:"
-msgstr "Zweig:"
-
-#: lib/branch_rename.tcl:39
-msgid "New Name:"
-msgstr "Neuer Name:"
-
-#: lib/branch_rename.tcl:75
-msgid "Please select a branch to rename."
-msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
-
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "Zweig »%s« existiert bereits."
 
-#: lib/branch_rename.tcl:117
-#, tcl-format
-msgid "Failed to rename '%s'."
-msgstr "Fehler beim Umbenennen von »%s«."
-
-#: lib/browser.tcl:17
-msgid "Starting..."
-msgstr "Starten..."
-
-#: lib/browser.tcl:26
-msgid "File Browser"
-msgstr "Datei-Browser"
-
-#: lib/browser.tcl:126 lib/browser.tcl:143
-#, tcl-format
-msgid "Loading %s..."
-msgstr "%s laden..."
-
-#: lib/browser.tcl:187
-msgid "[Up To Parent]"
-msgstr "[Nach oben]"
-
-#: lib/browser.tcl:267 lib/browser.tcl:273
-msgid "Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
-
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
-msgid "Browse"
-msgstr "Blättern"
-
-#: lib/checkout_op.tcl:85
-#, tcl-format
-msgid "Fetching %s from %s"
-msgstr "Änderungen »%s« von »%s« anfordern"
-
-#: lib/checkout_op.tcl:133
-#, tcl-format
-msgid "fatal: Cannot resolve %s"
-msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
-
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
-msgid "Close"
-msgstr "Schließen"
-
-#: lib/checkout_op.tcl:175
-#, tcl-format
-msgid "Branch '%s' does not exist."
-msgstr "Zweig »%s« existiert nicht."
-
-#: lib/checkout_op.tcl:194
-#, tcl-format
-msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
-
 #: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
@@ -961,23 +857,23 @@ msgstr "Arbeitskopie umstellen auf »%s«..."
 msgid "files checked out"
 msgstr "Dateien aktualisiert"
 
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
 "Auf Zweig »%s« umstellen abgebrochen (Zusammenführen der Dateien ist "
 "notwendig)."
 
-#: lib/checkout_op.tcl:377
+#: lib/checkout_op.tcl:378
 msgid "File level merge required."
 msgstr "Zusammenführen der Dateien ist notwendig."
 
-#: lib/checkout_op.tcl:381
+#: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Es wird auf Zweig »%s« verblieben."
 
-#: lib/checkout_op.tcl:452
+#: lib/checkout_op.tcl:453
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -989,32 +885,36 @@ msgstr ""
 "Wenn Sie auf einem Zweig arbeiten möchten, erstellen Sie bitte jetzt einen "
 "Zweig mit der Auswahl »Abgetrennte Arbeitskopie-Version«."
 
-#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "Umgestellt auf »%s«."
 
-#: lib/checkout_op.tcl:535
+#: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "Zurücksetzen von »%s« nach »%s« wird folgende Versionen verwerfen:"
 
-#: lib/checkout_op.tcl:557
+#: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
 msgstr ""
 "Verworfene Versionen können nur mit größerem Aufwand wiederhergestellt "
 "werden."
 
-#: lib/checkout_op.tcl:562
+#: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "»%s« zurücksetzen?"
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
 msgstr "Darstellen"
 
-#: lib/checkout_op.tcl:635
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Zurücksetzen"
+
+#: lib/checkout_op.tcl:636
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1032,658 +932,511 @@ msgstr ""
 "\n"
 "Dies ist ein interner Programmfehler von %s. Programm wird jetzt abgebrochen."
 
-#: lib/choose_font.tcl:39
-msgid "Select"
-msgstr "Auswählen"
-
-#: lib/choose_font.tcl:53
-msgid "Font Family"
-msgstr "Schriftfamilie"
-
-#: lib/choose_font.tcl:74
-msgid "Font Size"
-msgstr "Schriftgröße"
-
-#: lib/choose_font.tcl:91
-msgid "Font Example"
-msgstr "Schriftbeispiel"
+#: lib/remote_add.tcl:20
+#, fuzzy, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "Externes Archiv hinzufügen"
 
-#: lib/choose_font.tcl:103
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
-msgstr ""
-"Dies ist ein Beispieltext.\n"
-"Wenn Ihnen dieser Text gefällt, sollten Sie diese Schriftart wählen."
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Neues externes Archiv hinzufügen"
 
-#: lib/choose_repository.tcl:28
-msgid "Git Gui"
-msgstr "Git Gui"
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Hinzufügen"
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
-msgid "Create New Repository"
-msgstr "Neues Projektarchiv"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Einzelheiten des externen Archivs"
 
-#: lib/choose_repository.tcl:93
-msgid "New..."
-msgstr "Neu..."
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Name:"
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
-msgid "Clone Existing Repository"
-msgstr "Projektarchiv klonen"
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Adresse:"
 
-#: lib/choose_repository.tcl:106
-msgid "Clone..."
-msgstr "Klonen..."
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "Weitere Aktion jetzt"
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
-msgid "Open Existing Repository"
-msgstr "Projektarchiv öffnen"
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Gleich anfordern"
 
-#: lib/choose_repository.tcl:119
-msgid "Open..."
-msgstr "Öffnen..."
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Externes Archiv initialisieren und dahin versenden"
 
-#: lib/choose_repository.tcl:132
-msgid "Recent Repositories"
-msgstr "Zuletzt benutzte Projektarchive"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "Nichts tun"
 
-#: lib/choose_repository.tcl:138
-msgid "Open Recent Repository:"
-msgstr "Zuletzt benutztes Projektarchiv öffnen:"
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Bitte geben Sie einen Namen des externen Archivs an."
 
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/remote_add.tcl:113
 #, tcl-format
-msgid "Failed to create repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht erstellt werden:"
+msgid "'%s' is not an acceptable remote name."
+msgstr "»%s« ist kein zulässiger Name eines externen Archivs."
 
-#: lib/choose_repository.tcl:391
-msgid "Directory:"
-msgstr "Verzeichnis:"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr ""
+"Fehler beim Hinzufügen des externen Archivs »%s« aus Herkunftsort »%s«."
 
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
-msgid "Git Repository"
-msgstr "Git Projektarchiv"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "»%s« anfordern"
 
-#: lib/choose_repository.tcl:448
+#: lib/remote_add.tcl:156
 #, tcl-format
-msgid "Directory %s already exists."
-msgstr "Verzeichnis »%s« existiert bereits."
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr ""
+"Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
 
-#: lib/choose_repository.tcl:452
+#: lib/remote_add.tcl:163
 #, tcl-format
-msgid "File %s already exists."
-msgstr "Datei »%s« existiert bereits."
+msgid "Setting up the %s (at %s)"
+msgstr "Einrichten von »%s« an »%s«"
 
-#: lib/choose_repository.tcl:466
-msgid "Clone"
-msgstr "Klonen"
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Starten..."
 
-#: lib/choose_repository.tcl:479
-msgid "Source Location:"
-msgstr "Herkunft:"
+#: lib/browser.tcl:27
+#, fuzzy, tcl-format
+msgid "%s (%s): File Browser"
+msgstr "Datei-Browser"
 
-#: lib/choose_repository.tcl:490
-msgid "Target Directory:"
-msgstr "Zielverzeichnis:"
+#: lib/browser.tcl:132 lib/browser.tcl:149
+#, tcl-format
+msgid "Loading %s..."
+msgstr "%s laden..."
 
-#: lib/choose_repository.tcl:502
-msgid "Clone Type:"
-msgstr "Art des Klonens:"
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[Nach oben]"
 
-#: lib/choose_repository.tcl:508
-msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
+#: lib/browser.tcl:275
+#, fuzzy, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "Dateien des Zweigs durchblättern"
 
-#: lib/choose_repository.tcl:514
-msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Alles kopieren (langsamer, volle Redundanz)"
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Dateien des Zweigs durchblättern"
 
-#: lib/choose_repository.tcl:520
-msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
+msgstr "Blättern"
 
-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
-#, tcl-format
-msgid "Not a Git repository: %s"
-msgstr "Kein Git-Projektarchiv in »%s« gefunden."
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
+msgstr "Version"
 
-#: lib/choose_repository.tcl:592
-msgid "Standard only available for local repository."
-msgstr "Standard ist nur für lokale Projektarchive verfügbar."
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Bereitstellung kann nicht wieder freigegeben werden."
 
-#: lib/choose_repository.tcl:596
-msgid "Shared only available for local repository."
-msgstr "Verknüpft ist nur für lokale Projektarchive verfügbar."
+#: lib/index.tcl:30
+msgid "Index Error"
+msgstr "Fehler in Bereitstellung"
 
-#: lib/choose_repository.tcl:617
-#, tcl-format
-msgid "Location %s already exists."
-msgstr "Projektarchiv »%s« existiert bereits."
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+"Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Eine allgemeine "
+"Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
+"synchronisieren."
 
-#: lib/choose_repository.tcl:628
-msgid "Failed to configure origin"
-msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
+#: lib/index.tcl:43
+msgid "Continue"
+msgstr "Fortsetzen"
 
-#: lib/choose_repository.tcl:640
-msgid "Counting objects"
-msgstr "Objekte werden gezählt"
+#: lib/index.tcl:46
+msgid "Unlock Index"
+msgstr "Bereitstellung freigeben"
 
-#: lib/choose_repository.tcl:641
-msgid "buckets"
-msgstr "Buckets"
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
+msgstr "Dateien"
 
-#: lib/choose_repository.tcl:665
-#, tcl-format
-msgid "Unable to copy objects/info/alternates: %s"
-msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt werden: %s"
+#: lib/index.tcl:326
+#, fuzzy
+msgid "Unstaging selected files from commit"
+msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
-#: lib/choose_repository.tcl:701
+#: lib/index.tcl:330
 #, tcl-format
-msgid "Nothing to clone from %s."
-msgstr "Von »%s« konnte nichts geklont werden."
+msgid "Unstaging %s from commit"
+msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
-msgid "The 'master' branch has not been initialized."
-msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
+#: lib/index.tcl:369
+msgid "Ready to commit."
+msgstr "Bereit zum Eintragen."
 
-#: lib/choose_repository.tcl:716
-msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "Hardlinks nicht verfügbar. Stattdessen wird kopiert."
+#: lib/index.tcl:378
+#, fuzzy
+msgid "Adding selected files"
+msgstr "Änderungen in gewählten Dateien verwerfen"
 
-#: lib/choose_repository.tcl:728
+#: lib/index.tcl:382
 #, tcl-format
-msgid "Cloning from %s"
-msgstr "Kopieren von »%s«"
-
-#: lib/choose_repository.tcl:759
-msgid "Copying objects"
-msgstr "Objektdatenbank kopieren"
-
-#: lib/choose_repository.tcl:760
-msgid "KiB"
-msgstr "KB"
+msgid "Adding %s"
+msgstr "»%s« hinzufügen..."
 
-#: lib/choose_repository.tcl:784
+#: lib/index.tcl:412
 #, tcl-format
-msgid "Unable to copy object: %s"
-msgstr "Objekt kann nicht kopiert werden: %s"
+msgid "Stage %d untracked files?"
+msgstr ""
 
-#: lib/choose_repository.tcl:794
-msgid "Linking objects"
-msgstr "Objekte verlinken"
+#: lib/index.tcl:420
+msgid "Adding all changed files"
+msgstr ""
 
-#: lib/choose_repository.tcl:795
-msgid "objects"
-msgstr "Objekte"
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Änderungen in Datei »%s« verwerfen?"
 
-#: lib/choose_repository.tcl:803
+#: lib/index.tcl:508
 #, tcl-format
-msgid "Unable to hardlink object: %s"
-msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
+msgid "Revert changes in these %i files?"
+msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
 
-#: lib/choose_repository.tcl:858
-msgid "Cannot fetch branches and objects.  See console output for details."
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+"Alle nicht bereitgestellten Änderungen werden beim Verwerfen verloren gehen."
 
-#: lib/choose_repository.tcl:869
-msgid "Cannot fetch tags.  See console output for details."
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
+msgstr "Nichts tun"
+
+#: lib/index.tcl:545
+#, fuzzy, tcl-format
+msgid "Delete untracked file %s?"
+msgstr "Zweige auf »%s« werden gelöscht"
+
+#: lib/index.tcl:550
+#, fuzzy, tcl-format
+msgid "Delete these %i untracked files?"
+msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
 msgstr ""
-"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/choose_repository.tcl:893
-msgid "Cannot determine HEAD.  See console output for details."
+#: lib/index.tcl:564
+#, fuzzy
+msgid "Delete Files"
+msgstr "Löschen"
+
+#: lib/index.tcl:586
+#, fuzzy
+msgid "Deleting"
+msgstr "Löschen"
+
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
 msgstr ""
-"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/choose_repository.tcl:902
+#: lib/index.tcl:674
 #, tcl-format
-msgid "Unable to cleanup %s"
-msgstr "Verzeichnis »%s« kann nicht aufgeräumt werden."
+msgid "None of the %d selected files could be deleted."
+msgstr ""
 
-#: lib/choose_repository.tcl:908
-msgid "Clone failed."
-msgstr "Klonen fehlgeschlagen."
+#: lib/index.tcl:679
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
+msgstr ""
 
-#: lib/choose_repository.tcl:915
-msgid "No default branch obtained."
-msgstr "Kein voreingestellter Zweig gefunden."
+#: lib/index.tcl:726
+msgid "Reverting selected files"
+msgstr "Änderungen in gewählten Dateien verwerfen"
 
-#: lib/choose_repository.tcl:926
+#: lib/index.tcl:730
 #, tcl-format
-msgid "Cannot resolve %s as a commit."
-msgstr "»%s« wurde nicht als Version gefunden."
+msgid "Reverting %s"
+msgstr "Änderungen in %s verwerfen"
 
-#: lib/choose_repository.tcl:938
-msgid "Creating working directory"
-msgstr "Arbeitskopie erstellen"
+#: lib/branch_checkout.tcl:16
+#, fuzzy, tcl-format
+msgid "%s (%s): Checkout Branch"
+msgstr "Auf Zweig umstellen"
 
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
-msgid "files"
-msgstr "Dateien"
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Auf Zweig umstellen"
 
-#: lib/choose_repository.tcl:968
-msgid "Initial file checkout failed."
-msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Umstellen"
 
-#: lib/choose_repository.tcl:1011
-msgid "Open"
-msgstr "Öffnen"
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
+msgstr "Optionen"
 
-#: lib/choose_repository.tcl:1021
-msgid "Repository:"
-msgstr "Projektarchiv:"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Übernahmezweig anfordern"
 
-#: lib/choose_repository.tcl:1072
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Verbindung zu lokalem Zweig lösen"
+
+#: lib/status_bar.tcl:263
 #, tcl-format
-msgid "Failed to open repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht geöffnet werden."
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i von %*i %s (%3i%%)"
 
-#: lib/choose_rev.tcl:53
-msgid "This Detached Checkout"
-msgstr "Abgetrennte Arbeitskopie-Version"
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Versenden nach"
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
-msgstr "Version Regexp-Ausdruck:"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Externes Archiv entfernen"
 
-#: lib/choose_rev.tcl:74
-msgid "Local Branch"
-msgstr "Lokaler Zweig"
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Aufräumen von"
 
-#: lib/choose_rev.tcl:79
-msgid "Tracking Branch"
-msgstr "Übernahmezweig"
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Anfordern von"
 
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
-msgid "Tag"
-msgstr "Markierung"
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
+msgstr ""
 
-#: lib/choose_rev.tcl:317
-#, tcl-format
-msgid "Invalid revision: %s"
-msgstr "Ungültige Version: %s"
+#: lib/branch_rename.tcl:15
+#, fuzzy, tcl-format
+msgid "%s (%s): Rename Branch"
+msgstr "Zweig umbenennen"
 
-#: lib/choose_rev.tcl:338
-msgid "No revision selected."
-msgstr "Keine Version ausgewählt."
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Zweig umbenennen"
 
-#: lib/choose_rev.tcl:346
-msgid "Revision expression is empty."
-msgstr "Versions-Ausdruck ist leer."
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Umbenennen"
 
-#: lib/choose_rev.tcl:531
-msgid "Updated"
-msgstr "Aktualisiert"
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Zweig:"
 
-#: lib/choose_rev.tcl:559
-msgid "URL"
-msgstr "URL"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Neuer Name:"
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
-msgstr ""
-"Keine Version zur Nachbesserung vorhanden.\n"
-"\n"
-"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
-"Version, die Sie nachbessern könnten.\n"
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
 
-#: lib/commit.tcl:18
-msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
-msgstr ""
-"Nachbesserung währen Zusammenführung nicht möglich.\n"
-"\n"
-"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
-"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
-"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
-"beenden oder abbrechen.\n"
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Bitte geben Sie einen Zweignamen an."
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
-msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "»%s« ist kein zulässiger Zweigname."
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
-msgstr "Benutzername konnte nicht bestimmt werden:"
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Fehler beim Umbenennen von »%s«."
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "Ungültiger Wert von GIT_COMMITTER_INDENT:"
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Auswählen"
 
-#: lib/commit.tcl:129
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "Warning: Tcl/Tk unterstützt die Zeichencodierung »%s« nicht."
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Schriftfamilie"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Schriftgröße"
 
-#: lib/commit.tcl:149
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Schriftbeispiel"
+
+#: lib/choose_font.tcl:105
 msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+"This is example text.\n"
+"If you like this text, it can be your font."
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
-"\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
-"\n"
-"Es wird gleich neu geladen.\n"
+"Dies ist ein Beispieltext.\n"
+"Wenn Ihnen dieser Text gefällt, sollten Sie diese Schriftart wählen."
 
-#: lib/commit.tcl:172
+#: lib/option.tcl:11
 #, tcl-format
-msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
-msgstr ""
-"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
-"\n"
-"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
-"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+msgid "Invalid global encoding '%s'"
+msgstr "Ungültige globale Zeichenkodierung »%s«"
 
-#: lib/commit.tcl:180
+#: lib/option.tcl:19
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
-msgstr ""
-"Unbekannter Dateizustand »%s«.\n"
-"\n"
-"Datei »%s« kann nicht eingetragen werden.\n"
+msgid "Invalid repo encoding '%s'"
+msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
 
-#: lib/commit.tcl:188
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
-msgstr ""
-"Keine Änderungen vorhanden, die eingetragen werden könnten.\n"
-"\n"
-"Sie müssen mindestens eine Datei bereitstellen, bevor Sie eintragen können.\n"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Voreinstellungen wiederherstellen"
 
-#: lib/commit.tcl:203
-msgid ""
-"Please supply a commit message.\n"
-"\n"
-"A good commit message has the following format:\n"
-"\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
-msgstr ""
-"Bitte geben Sie eine Versionsbeschreibung ein.\n"
-"\n"
-"Eine gute Versionsbeschreibung enthält folgende Abschnitte:\n"
-"\n"
-"- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
-"\n"
-"- Zweite Zeile: Leerzeile\n"
-"\n"
-"- Rest: Eine ausführliche Beschreibung, warum diese Änderung hilfreich ist.\n"
-
-#: lib/commit.tcl:234
-msgid "Calling pre-commit hook..."
-msgstr "Aufrufen der Vor-Eintragen-Kontrolle (»pre-commit hook«)..."
-
-#: lib/commit.tcl:249
-msgid "Commit declined by pre-commit hook."
-msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (»pre-commit hook«)."
-
-#: lib/commit.tcl:272
-msgid "Calling commit-msg hook..."
-msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
-
-#: lib/commit.tcl:287
-msgid "Commit declined by commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
-"hook«)."
-
-#: lib/commit.tcl:300
-msgid "Committing changes..."
-msgstr "Änderungen eintragen..."
-
-#: lib/commit.tcl:316
-msgid "write-tree failed:"
-msgstr "write-tree fehlgeschlagen:"
-
-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
-msgid "Commit failed."
-msgstr "Eintragen fehlgeschlagen."
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Speichern"
 
-#: lib/commit.tcl:334
+#: lib/option.tcl:133
 #, tcl-format
-msgid "Commit %s appears to be corrupt"
-msgstr "Version »%s« scheint beschädigt zu sein"
-
-#: lib/commit.tcl:339
-msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
-"\n"
-"A rescan will be automatically started now.\n"
-msgstr ""
-"Keine Änderungen einzutragen.\n"
-"\n"
-"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
-"zusammengeführt.\n"
-"\n"
-"Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
+msgid "%s Repository"
+msgstr "Projektarchiv %s"
 
-#: lib/commit.tcl:346
-msgid "No changes to commit."
-msgstr "Keine Änderungen, die eingetragen werden können."
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Global (Alle Projektarchive)"
 
-#: lib/commit.tcl:360
-msgid "commit-tree failed:"
-msgstr "commit-tree fehlgeschlagen:"
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Benutzername"
 
-#: lib/commit.tcl:381
-msgid "update-ref failed:"
-msgstr "update-ref fehlgeschlagen:"
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "E-Mail-Adresse"
 
-#: lib/commit.tcl:469
-#, tcl-format
-msgid "Created commit %s: %s"
-msgstr "Version %s übertragen: %s"
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Zusammenführungs-Versionen zusammenfassen"
 
-#: lib/console.tcl:59
-msgid "Working... please wait..."
-msgstr "Verarbeitung. Bitte warten..."
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Ausführlichkeit der Zusammenführen-Meldungen"
 
-#: lib/console.tcl:186
-msgid "Success"
-msgstr "Erfolgreich"
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Vergleichsstatistik nach Zusammenführen anzeigen"
 
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
-msgstr "Fehler: Kommando fehlgeschlagen"
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Zusammenführungswerkzeug"
 
-#: lib/database.tcl:43
-msgid "Number of loose objects"
-msgstr "Anzahl unverknüpfter Objekte"
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Auf Dateiänderungsdatum verlassen"
 
-#: lib/database.tcl:44
-msgid "Disk space used by loose objects"
-msgstr "Festplattenplatz von unverknüpften Objekten"
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Übernahmezweige aufräumen während Anforderung"
 
-#: lib/database.tcl:45
-msgid "Number of packed objects"
-msgstr "Anzahl komprimierter Objekte"
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "Passend zu Übernahmezweig"
 
-#: lib/database.tcl:46
-msgid "Number of packs"
-msgstr "Anzahl Komprimierungseinheiten"
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr ""
 
-#: lib/database.tcl:47
-msgid "Disk space used by packed objects"
-msgstr "Festplattenplatz von komprimierten Objekten"
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Kopie-Annotieren nur bei geänderten Dateien"
 
-#: lib/database.tcl:48
-msgid "Packed objects waiting for pruning"
-msgstr "Komprimierte Objekte, die zum Aufräumen vorgesehen sind"
+#: lib/option.tcl:153
+#, fuzzy
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Zuletzt benutzte Projektarchive"
 
-#: lib/database.tcl:49
-msgid "Garbage files"
-msgstr "Dateien im Mülleimer"
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
 
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Objektdatenbank komprimieren"
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Anzahl Tage für Historien-Kontext"
 
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
-msgstr "Die Objektdatenbank durch »fsck-objects« überprüfen lassen"
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "Anzahl der Kontextzeilen beim Vergleich"
 
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
-"\n"
-"Compress the database now?"
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
 msgstr ""
-"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
-"\n"
-"Für eine optimale Performance wird empfohlen, die Datenbank des Projektarchivs zu komprimieren.\n"
-"\n"
-"Soll die Datenbank jetzt komprimiert werden?"
 
-#: lib/date.tcl:25
-#, tcl-format
-msgid "Invalid date from Git: %s"
-msgstr "Ungültiges Datum von Git: %s"
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "Textbreite der Versionsbeschreibung"
 
-#: lib/diff.tcl:64
-#, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
-msgstr ""
-"Keine Änderungen feststellbar.\n"
-"\n"
-"»%s« enthält keine Änderungen. Zwar wurde das Änderungsdatum dieser Datei von "
-"einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
-"unverändert.\n"
-"\n"
-"Das Arbeitsverzeichnis wird jetzt neu geladen, um diese Änderung bei allen "
-"Dateien zu prüfen."
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Namensvorschlag für neue Zweige"
 
-#: lib/diff.tcl:104
-#, tcl-format
-msgid "Loading diff of %s..."
-msgstr "Vergleich von »%s« laden..."
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Voreingestellte Zeichenkodierung"
 
-#: lib/diff.tcl:125
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
 msgstr ""
-"LOKAL: gelöscht\n"
-"ANDERES:\n"
 
-#: lib/diff.tcl:130
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
 msgstr ""
-"ANDERES: gelöscht\n"
-"LOKAL:\n"
 
-#: lib/diff.tcl:137
-msgid "LOCAL:\n"
-msgstr "LOKAL:\n"
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr ""
 
-#: lib/diff.tcl:140
-msgid "REMOTE:\n"
-msgstr "ANDERES:\n"
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr ""
 
-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
 #, tcl-format
-msgid "Unable to display %s"
-msgstr "Datei »%s« kann nicht angezeigt werden"
-
-#: lib/diff.tcl:203
-msgid "Error loading file:"
-msgstr "Fehler beim Laden der Datei:"
+msgid "%s:"
+msgstr ""
 
-#: lib/diff.tcl:210
-msgid "Git Repository (subproject)"
-msgstr "Git-Projektarchiv (Unterprojekt)"
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Ändern"
 
-#: lib/diff.tcl:222
-msgid "* Binary file (not showing content)."
-msgstr "* Binärdatei (Inhalt wird nicht angezeigt)"
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Wörterbuch Rechtschreibprüfung:"
 
-#: lib/diff.tcl:227
-#, tcl-format
-msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
-msgstr ""
-"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
-"* Nur erste %d Bytes werden angezeigt.\n"
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Schriftart ändern"
 
-#: lib/diff.tcl:233
+#: lib/option.tcl:288
 #, tcl-format
-msgid ""
-"\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
-msgstr ""
-"\n"
-"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
-"* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
-
-#: lib/diff.tcl:482
-msgid "Failed to unstage selected hunk."
-msgstr ""
-"Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
+msgid "Choose %s"
+msgstr "%s wählen"
 
-#: lib/diff.tcl:489
-msgid "Failed to stage selected hunk."
-msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "pt."
 
-#: lib/diff.tcl:568
-msgid "Failed to unstage selected line."
-msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Einstellungen"
 
-#: lib/diff.tcl:576
-msgid "Failed to stage selected line."
-msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Optionen konnten nicht gespeichert werden:"
 
 #: lib/encoding.tcl:443
 msgid "Default"
@@ -1698,229 +1451,40 @@ msgstr "Systemweit (%s)"
 msgid "Other"
 msgstr "Andere"
 
-#: lib/error.tcl:20 lib/error.tcl:114
-msgid "error"
-msgstr "Fehler"
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
 
-#: lib/error.tcl:36
-msgid "warning"
-msgstr "Warnung"
+#: lib/tools.tcl:92
+#, fuzzy, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Wollen Sie %s wirklich starten?"
 
-#: lib/error.tcl:94
-msgid "You must correct the above errors before committing."
-msgstr ""
-"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
-
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
-msgstr "Bereitstellung kann nicht wieder freigegeben werden."
-
-#: lib/index.tcl:15
-msgid "Index Error"
-msgstr "Fehler in Bereitstellung"
-
-#: lib/index.tcl:17
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
-msgstr ""
-"Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Eine allgemeine "
-"Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
-"synchronisieren."
-
-#: lib/index.tcl:28
-msgid "Continue"
-msgstr "Fortsetzen"
-
-#: lib/index.tcl:31
-msgid "Unlock Index"
-msgstr "Bereitstellung freigeben"
-
-#: lib/index.tcl:289
-#, tcl-format
-msgid "Unstaging %s from commit"
-msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
-
-#: lib/index.tcl:328
-msgid "Ready to commit."
-msgstr "Bereit zum Eintragen."
-
-#: lib/index.tcl:341
-#, tcl-format
-msgid "Adding %s"
-msgstr "»%s« hinzufügen..."
-
-#: lib/index.tcl:398
-#, tcl-format
-msgid "Revert changes in file %s?"
-msgstr "Änderungen in Datei »%s« verwerfen?"
-
-#: lib/index.tcl:400
-#, tcl-format
-msgid "Revert changes in these %i files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
-
-#: lib/index.tcl:408
-msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr ""
-"Alle nicht bereitgestellten Änderungen werden beim Verwerfen verloren gehen."
-
-#: lib/index.tcl:411
-msgid "Do Nothing"
-msgstr "Nichts tun"
-
-#: lib/index.tcl:429
-msgid "Reverting selected files"
-msgstr "Änderungen in gewählten Dateien verwerfen"
-
-#: lib/index.tcl:433
-#, tcl-format
-msgid "Reverting %s"
-msgstr "Änderungen in %s verwerfen"
-
-#: lib/merge.tcl:13
-msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
-msgstr ""
-"Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
-"\n"
-"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
-"zusammenführen können.\n"
-
-#: lib/merge.tcl:27
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
-msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
-"\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
-"\n"
-"Es wird gleich neu geladen.\n"
-
-#: lib/merge.tcl:45
+#: lib/tools.tcl:96
 #, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
-msgstr ""
-"Zusammenführung mit Konflikten.\n"
-"\n"
-"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
-"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
-"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
-"danach kann eine neue Zusammenführung begonnen werden.\n"
+msgid "Are you sure you want to run %s?"
+msgstr "Wollen Sie %s wirklich starten?"
 
-#: lib/merge.tcl:55
+#: lib/tools.tcl:118
 #, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
-msgstr ""
-"Es liegen Änderungen vor.\n"
-"\n"
-"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
-"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
-"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
-"einfacher beheben oder abbrechen.\n"
+msgid "Tool: %s"
+msgstr "Werkzeug: %s"
 
-#: lib/merge.tcl:107
+#: lib/tools.tcl:119
 #, tcl-format
-msgid "%s of %s"
-msgstr "%s von %s"
+msgid "Running: %s"
+msgstr "Starten: %s"
 
-#: lib/merge.tcl:120
+#: lib/tools.tcl:158
 #, tcl-format
-msgid "Merging %s and %s..."
-msgstr "Zusammenführen von %s und %s..."
-
-#: lib/merge.tcl:131
-msgid "Merge completed successfully."
-msgstr "Zusammenführen erfolgreich abgeschlossen."
-
-#: lib/merge.tcl:133
-msgid "Merge failed.  Conflict resolution is required."
-msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
+msgid "Tool completed successfully: %s"
+msgstr "Werkzeug erfolgreich abgeschlossen: %s"
 
-#: lib/merge.tcl:158
+#: lib/tools.tcl:160
 #, tcl-format
-msgid "Merge Into %s"
-msgstr "Zusammenführen in »%s«"
-
-#: lib/merge.tcl:177
-msgid "Revision To Merge"
-msgstr "Zusammenzuführende Version"
-
-#: lib/merge.tcl:212
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
-msgstr ""
-"Abbruch der Nachbesserung ist nicht möglich.\n"
-"\n"
-"Sie müssen die Nachbesserung der Version abschließen.\n"
-
-#: lib/merge.tcl:222
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
-msgstr ""
-"Zusammenführen abbrechen?\n"
-"\n"
-"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
-"\n"
-"Zusammenführen jetzt abbrechen?"
-
-#: lib/merge.tcl:228
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
-msgstr ""
-"Änderungen zurücksetzen?\n"
-"\n"
-"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
-"\n"
-"Änderungen jetzt zurücksetzen?"
-
-#: lib/merge.tcl:239
-msgid "Aborting"
-msgstr "Abbruch"
-
-#: lib/merge.tcl:239
-msgid "files reset"
-msgstr "Dateien zurückgesetzt"
-
-#: lib/merge.tcl:267
-msgid "Abort failed."
-msgstr "Abbruch fehlgeschlagen."
-
-#: lib/merge.tcl:269
-msgid "Abort completed.  Ready."
-msgstr "Abbruch durchgeführt. Bereit."
+msgid "Tool failed: %s"
+msgstr "Werkzeug fehlgeschlagen: %s"
 
 #: lib/mergetool.tcl:8
 msgid "Force resolution to the base version?"
@@ -1970,21 +1534,21 @@ msgstr ""
 msgid "Conflict file does not exist"
 msgstr "Konflikt-Datei existiert nicht"
 
-#: lib/mergetool.tcl:264
+#: lib/mergetool.tcl:246
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr "Kein GUI Zusammenführungswerkzeug: »%s«"
 
-#: lib/mergetool.tcl:268
+#: lib/mergetool.tcl:275
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr "Unbekanntes Zusammenführungswerkzeug: »%s«"
 
-#: lib/mergetool.tcl:303
+#: lib/mergetool.tcl:310
 msgid "Merge tool is already running, terminate it?"
 msgstr "Zusammenführungswerkzeug läuft bereits. Soll es abgebrochen werden?"
 
-#: lib/mergetool.tcl:323
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
@@ -1993,7 +1557,7 @@ msgstr ""
 "Fehler beim Abrufen der Dateiversionen:\n"
 "%s"
 
-#: lib/mergetool.tcl:343
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -2004,243 +1568,180 @@ msgstr ""
 "\n"
 "%s"
 
-#: lib/mergetool.tcl:347
+#: lib/mergetool.tcl:354
 msgid "Running merge tool..."
 msgstr "Zusammenführungswerkzeug starten..."
 
-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
 msgid "Merge tool failed."
 msgstr "Zusammenführungswerkzeug fehlgeschlagen."
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
-msgstr "Ungültige globale Zeichenkodierung »%s«"
-
-#: lib/option.tcl:19
-#, tcl-format
-msgid "Invalid repo encoding '%s'"
-msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
+#: lib/tools_dlg.tcl:22
+#, fuzzy, tcl-format
+msgid "%s (%s): Add Tool"
+msgstr "Werkzeug hinzufügen"
 
-#: lib/option.tcl:117
-msgid "Restore Defaults"
-msgstr "Voreinstellungen wiederherstellen"
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Neues Kommando für Werkzeug hinzufügen"
 
-#: lib/option.tcl:121
-msgid "Save"
-msgstr "Speichern"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Global hinzufügen"
 
-#: lib/option.tcl:131
-#, tcl-format
-msgid "%s Repository"
-msgstr "Projektarchiv %s"
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Einzelheiten des Werkzeugs"
 
-#: lib/option.tcl:132
-msgid "Global (All Repositories)"
-msgstr "Global (Alle Projektarchive)"
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Benutzen Sie einen Schrägstrich »/«, um Untermenüs zu erstellen:"
 
-#: lib/option.tcl:138
-msgid "User Name"
-msgstr "Benutzername"
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Kommando:"
 
-#: lib/option.tcl:139
-msgid "Email Address"
-msgstr "E-Mail-Adresse"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Bestätigungsfrage vor Starten anzeigen"
 
-#: lib/option.tcl:141
-msgid "Summarize Merge Commits"
-msgstr "Zusammenführungs-Versionen zusammenfassen"
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Benutzer nach Version fragen (setzt $REVISION)"
 
-#: lib/option.tcl:142
-msgid "Merge Verbosity"
-msgstr "Ausführlichkeit der Zusammenführen-Meldungen"
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Benutzer nach zusätzlichen Argumenten fragen (setzt $ARGS)"
 
-#: lib/option.tcl:143
-msgid "Show Diffstat After Merge"
-msgstr "Vergleichsstatistik nach Zusammenführen anzeigen"
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "Kein Ausgabefenster zeigen"
 
-#: lib/option.tcl:144
-msgid "Use Merge Tool"
-msgstr "Zusammenführungswerkzeug"
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Nur starten, wenn ein Vergleich gewählt ist ($FILENAME ist nicht leer)"
 
-#: lib/option.tcl:146
-msgid "Trust File Modification Timestamps"
-msgstr "Auf Dateiänderungsdatum verlassen"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Bitte geben Sie einen Werkzeugnamen an."
 
-#: lib/option.tcl:147
-msgid "Prune Tracking Branches During Fetch"
-msgstr "Übernahmezweige aufräumen während Anforderung"
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Werkzeug »%s« existiert bereits."
 
-#: lib/option.tcl:148
-msgid "Match Tracking Branches"
-msgstr "Passend zu Übernahmezweig"
-
-#: lib/option.tcl:149
-msgid "Blame Copy Only On Changed Files"
-msgstr "Kopie-Annotieren nur bei geänderten Dateien"
-
-#: lib/option.tcl:150
-msgid "Minimum Letters To Blame Copy On"
-msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
-
-#: lib/option.tcl:151
-msgid "Blame History Context Radius (days)"
-msgstr "Anzahl Tage für Historien-Kontext"
-
-#: lib/option.tcl:152
-msgid "Number of Diff Context Lines"
-msgstr "Anzahl der Kontextzeilen beim Vergleich"
-
-#: lib/option.tcl:153
-msgid "Commit Message Text Width"
-msgstr "Textbreite der Versionsbeschreibung"
-
-#: lib/option.tcl:154
-msgid "New Branch Name Template"
-msgstr "Namensvorschlag für neue Zweige"
-
-#: lib/option.tcl:155
-msgid "Default File Contents Encoding"
-msgstr "Voreingestellte Zeichenkodierung"
-
-#: lib/option.tcl:203
-msgid "Change"
-msgstr "Ändern"
-
-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
-msgstr "Wörterbuch Rechtschreibprüfung:"
-
-#: lib/option.tcl:254
-msgid "Change Font"
-msgstr "Schriftart ändern"
-
-#: lib/option.tcl:258
+#: lib/tools_dlg.tcl:148
 #, tcl-format
-msgid "Choose %s"
-msgstr "%s wählen"
-
-#: lib/option.tcl:264
-msgid "pt."
-msgstr "pt."
-
-#: lib/option.tcl:278
-msgid "Preferences"
-msgstr "Einstellungen"
-
-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
-msgstr "Optionen konnten nicht gespeichert werden:"
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Werkzeug konnte nicht hinzugefügt werden:\n"
+"\n"
+"%s"
 
-#: lib/remote_add.tcl:19
-msgid "Add Remote"
-msgstr "Externes Archiv hinzufügen"
+#: lib/tools_dlg.tcl:187
+#, fuzzy, tcl-format
+msgid "%s (%s): Remove Tool"
+msgstr "Werkzeug entfernen"
 
-#: lib/remote_add.tcl:24
-msgid "Add New Remote"
-msgstr "Neues externes Archiv hinzufügen"
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Werkzeugkommandos entfernen"
 
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
-msgid "Add"
-msgstr "Hinzufügen"
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Entfernen"
 
-#: lib/remote_add.tcl:37
-msgid "Remote Details"
-msgstr "Einzelheiten des externen Archivs"
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Werkzeuge für lokales Archiv werden in Blau angezeigt)"
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
-msgstr "Adresse:"
+#: lib/tools_dlg.tcl:283
+#, fuzzy, tcl-format
+msgid "%s (%s):"
+msgstr "Systemweit (%s)"
 
-#: lib/remote_add.tcl:62
-msgid "Further Action"
-msgstr "Weitere Aktion jetzt"
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Kommando aufrufen: %s"
 
-#: lib/remote_add.tcl:65
-msgid "Fetch Immediately"
-msgstr "Gleich anfordern"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Argumente"
 
-#: lib/remote_add.tcl:71
-msgid "Initialize Remote Repository and Push"
-msgstr "Externes Archiv initialisieren und dahin versenden"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "Ok"
 
-#: lib/remote_add.tcl:77
-msgid "Do Nothing Else Now"
-msgstr "Nichts tun"
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Suchen:"
 
-#: lib/remote_add.tcl:101
-msgid "Please supply a remote name."
-msgstr "Bitte geben Sie einen Namen des externen Archivs an."
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Nächster"
 
-#: lib/remote_add.tcl:114
-#, tcl-format
-msgid "'%s' is not an acceptable remote name."
-msgstr "»%s« ist kein zulässiger Name eines externen Archivs."
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Voriger"
 
-#: lib/remote_add.tcl:125
-#, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Fehler beim Hinzufügen des externen Archivs »%s« aus Herkunftsort »%s«."
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr ""
 
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
-msgstr "»%s« anfordern"
+#: lib/search.tcl:54
+msgid "Case"
+msgstr ""
 
-#: lib/remote_add.tcl:134
-#, tcl-format
-msgid "Fetching the %s"
-msgstr "»%s« anfordern"
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, fuzzy, tcl-format
+msgid "%s (%s): Create Desktop Icon"
+msgstr "Desktop-Icon erstellen"
 
-#: lib/remote_add.tcl:157
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr "Fehler beim Schreiben der Verknüpfung:"
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
-#, tcl-format
-msgid "push %s"
-msgstr "»%s« versenden..."
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr "Fehler beim Erstellen des Icons:"
 
-#: lib/remote_add.tcl:164
-#, tcl-format
-msgid "Setting up the %s (at %s)"
-msgstr "Einrichten von »%s« an »%s«"
+#: lib/remote_branch_delete.tcl:29
+#, fuzzy, tcl-format
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "Zweig in externem Archiv löschen"
 
-#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+#: lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
 msgstr "Zweig in externem Archiv löschen"
 
-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr "In Projektarchiv"
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
-msgid "Remote:"
-msgstr "Externes Archiv:"
-
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
-msgid "Arbitrary Location:"
-msgstr "Adresse:"
-
-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr "Zweige"
 
-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr "Nur löschen, wenn"
 
-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr "Zusammengeführt mit:"
 
-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Immer (Keine Zusammenführungsprüfung)"
+
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr "Für »Zusammenführen mit« muss ein Zweig angegeben werden."
 
-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2251,7 +1752,7 @@ msgstr ""
 "\n"
 " - %s"
 
-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
@@ -2261,332 +1762,1137 @@ msgstr ""
 "notwendigen Versionen vorher angefordert haben.  Sie sollten versuchen, "
 "zuerst von »%s« anzufordern."
 
-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr "Bitte wählen Sie mindestens einen Zweig, der gelöscht werden soll."
 
-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
+"möglich.\n"
+"\n"
+"Sollen die ausgewählten Zweige gelöscht werden?"
+
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "Zweige auf »%s« werden gelöscht"
 
-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
 msgstr "Kein Projektarchiv ausgewählt."
 
-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "»%s« laden..."
 
-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "Externes Archiv entfernen"
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
+msgstr "Git Gui"
 
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "Aufräumen von"
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
+msgstr "Neues Projektarchiv"
 
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "Anfordern von"
+#: lib/choose_repository.tcl:110
+msgid "New..."
+msgstr "Neu..."
 
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "Versenden nach"
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
+msgstr "Projektarchiv klonen"
 
-#: lib/search.tcl:21
-msgid "Find:"
-msgstr "Suchen:"
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
+msgstr "Klonen..."
 
-#: lib/search.tcl:23
-msgid "Next"
-msgstr "Nächster"
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
+msgstr "Projektarchiv öffnen"
 
-#: lib/search.tcl:24
-msgid "Prev"
-msgstr "Voriger"
+#: lib/choose_repository.tcl:141
+msgid "Open..."
+msgstr "Öffnen..."
 
-#: lib/search.tcl:25
-msgid "Case-Sensitive"
-msgstr "Groß-/Kleinschreibung unterscheiden"
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
+msgstr "Zuletzt benutzte Projektarchive"
 
-#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
-msgid "Cannot write shortcut:"
-msgstr "Fehler beim Schreiben der Verknüpfung:"
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
+msgstr "Zuletzt benutztes Projektarchiv öffnen:"
 
-#: lib/shortcut.tcl:137
-msgid "Cannot write icon:"
-msgstr "Fehler beim Erstellen des Icons:"
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Projektarchiv »%s« konnte nicht erstellt werden:"
 
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
-msgstr "Rechtschreibprüfungsprogramm nicht unterstützt"
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Erstellen"
 
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
-msgstr "Rechtschreibprüfung nicht verfügbar"
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr "Verzeichnis:"
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
-msgstr "Unbenutzbare Konfiguration der Rechtschreibprüfung"
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
+msgstr "Git Projektarchiv"
 
-#: lib/spellcheck.tcl:70
+#: lib/choose_repository.tcl:487
 #, tcl-format
-msgid "Reverting dictionary to %s."
-msgstr "Wörterbuch auf %s zurückgesetzt."
+msgid "Directory %s already exists."
+msgstr "Verzeichnis »%s« existiert bereits."
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
-msgstr "Rechtschreibprüfungsprogramm mit Fehler abgebrochen"
+#: lib/choose_repository.tcl:491
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Datei »%s« existiert bereits."
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
-msgstr "Unbekanntes Rechtschreibprüfungsprogramm"
+#: lib/choose_repository.tcl:506
+msgid "Clone"
+msgstr "Klonen"
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
-msgstr "Keine Vorschläge"
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
+msgstr "Herkunft:"
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
-msgstr "Unerwartetes EOF vom Rechtschreibprüfungsprogramm"
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr "Zielverzeichnis:"
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
-msgstr "Rechtschreibprüfung fehlgeschlagen"
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr "Art des Klonens:"
 
-#: lib/sshkey.tcl:31
-msgid "No keys found."
-msgstr "Keine Schlüssel gefunden."
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
 
-#: lib/sshkey.tcl:34
-#, tcl-format
-msgid "Found a public key in: %s"
-msgstr "Öffentlicher Schlüssel gefunden in: %s"
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Alles kopieren (langsamer, volle Redundanz)"
 
-#: lib/sshkey.tcl:40
-msgid "Generate Key"
-msgstr "Schlüssel erzeugen"
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
 
-#: lib/sshkey.tcl:56
-msgid "Copy To Clipboard"
-msgstr "In Zwischenablage kopieren"
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
+msgstr ""
 
-#: lib/sshkey.tcl:70
-msgid "Your OpenSSH Public Key"
-msgstr "Ihr OpenSSH öffenlicher Schlüssel"
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Kein Git-Projektarchiv in »%s« gefunden."
 
-#: lib/sshkey.tcl:78
-msgid "Generating..."
-msgstr "Erzeugen..."
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
+msgstr "Standard ist nur für lokale Projektarchive verfügbar."
 
-#: lib/sshkey.tcl:84
-#, tcl-format
-msgid ""
-"Could not start ssh-keygen:\n"
-"\n"
-"%s"
-msgstr ""
-"Konnte »ssh-keygen« nicht starten:\n"
-"\n"
-"%s"
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
+msgstr "Verknüpft ist nur für lokale Projektarchive verfügbar."
 
-#: lib/sshkey.tcl:111
-msgid "Generation failed."
-msgstr "Schlüsselerzeugung fehlgeschlagen."
+#: lib/choose_repository.tcl:655
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "Projektarchiv »%s« existiert bereits."
 
-#: lib/sshkey.tcl:118
-msgid "Generation succeeded, but no keys found."
-msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
+
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr "Objekte werden gezählt"
+
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr "Buckets"
 
-#: lib/sshkey.tcl:121
+#: lib/choose_repository.tcl:703
 #, tcl-format
-msgid "Your key is in: %s"
-msgstr "Ihr Schlüssel ist abgelegt in: %s"
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt werden: %s"
 
-#: lib/status_bar.tcl:83
+#: lib/choose_repository.tcl:740
 #, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s ... %*i von %*i %s (%3i%%)"
+msgid "Nothing to clone from %s."
+msgstr "Von »%s« konnte nichts geklont werden."
 
-#: lib/tools_dlg.tcl:22
-msgid "Add Tool"
-msgstr "Werkzeug hinzufügen"
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
+msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
 
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
-msgstr "Neues Kommando für Werkzeug hinzufügen"
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Hardlinks nicht verfügbar. Stattdessen wird kopiert."
 
-#: lib/tools_dlg.tcl:33
-msgid "Add globally"
-msgstr "Global hinzufügen"
+#: lib/choose_repository.tcl:769
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Kopieren von »%s«"
 
-#: lib/tools_dlg.tcl:45
-msgid "Tool Details"
-msgstr "Einzelheiten des Werkzeugs"
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
+msgstr "Objektdatenbank kopieren"
 
-#: lib/tools_dlg.tcl:48
-msgid "Use '/' separators to create a submenu tree:"
-msgstr "Benutzen Sie einen Schrägstrich »/«, um Untermenüs zu erstellen:"
+#: lib/choose_repository.tcl:801
+msgid "KiB"
+msgstr "KB"
 
-#: lib/tools_dlg.tcl:61
-msgid "Command:"
-msgstr "Kommando:"
+#: lib/choose_repository.tcl:825
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Objekt kann nicht kopiert werden: %s"
 
-#: lib/tools_dlg.tcl:74
-msgid "Show a dialog before running"
-msgstr "Bestätigungsfrage vor Starten anzeigen"
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
+msgstr "Objekte verlinken"
 
-#: lib/tools_dlg.tcl:80
-msgid "Ask the user to select a revision (sets $REVISION)"
-msgstr "Benutzer nach Version fragen (setzt $REVISION)"
+#: lib/choose_repository.tcl:838
+msgid "objects"
+msgstr "Objekte"
 
-#: lib/tools_dlg.tcl:85
-msgid "Ask the user for additional arguments (sets $ARGS)"
-msgstr "Benutzer nach zusätzlichen Argumenten fragen (setzt $ARGS)"
+#: lib/choose_repository.tcl:846
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
 
-#: lib/tools_dlg.tcl:92
-msgid "Don't show the command output window"
-msgstr "Kein Ausgabefenster zeigen"
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
+msgstr ""
+"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:97
-msgid "Run only if a diff is selected ($FILENAME not empty)"
-msgstr "Nur starten, wenn ein Vergleich gewählt ist ($FILENAME ist nicht leer)"
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
+msgstr ""
+"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:121
-msgid "Please supply a name for the tool."
-msgstr "Bitte geben Sie einen Werkzeugnamen an."
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr ""
+"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:129
+#: lib/choose_repository.tcl:947
 #, tcl-format
-msgid "Tool '%s' already exists."
-msgstr "Werkzeug »%s« existiert bereits."
+msgid "Unable to cleanup %s"
+msgstr "Verzeichnis »%s« kann nicht aufgeräumt werden."
 
-#: lib/tools_dlg.tcl:151
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
+msgstr "Klonen fehlgeschlagen."
+
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
+msgstr "Kein voreingestellter Zweig gefunden."
+
+#: lib/choose_repository.tcl:971
 #, tcl-format
-msgid ""
-"Could not add tool:\n"
-"%s"
-msgstr ""
-"Werkzeug konnte nicht hinzugefügt werden:\n"
-"\n"
-"%s"
+msgid "Cannot resolve %s as a commit."
+msgstr "»%s« wurde nicht als Version gefunden."
 
-#: lib/tools_dlg.tcl:190
-msgid "Remove Tool"
-msgstr "Werkzeug entfernen"
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr "Arbeitskopie erstellen"
 
-#: lib/tools_dlg.tcl:196
-msgid "Remove Tool Commands"
-msgstr "Werkzeugkommandos entfernen"
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
 
-#: lib/tools_dlg.tcl:200
-msgid "Remove"
-msgstr "Entfernen"
+#: lib/choose_repository.tcl:1072
+#, fuzzy
+msgid "Cloning submodules"
+msgstr "Kopieren von »%s«"
 
-#: lib/tools_dlg.tcl:236
-msgid "(Blue denotes repository-local tools)"
-msgstr "(Werkzeuge für lokales Archiv werden in Blau angezeigt)"
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr ""
+
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr "Projektarchiv:"
 
-#: lib/tools_dlg.tcl:297
+#: lib/choose_repository.tcl:1159
 #, tcl-format
-msgid "Run Command: %s"
-msgstr "Kommando aufrufen: %s"
+msgid "Failed to open repository %s:"
+msgstr "Projektarchiv »%s« konnte nicht geöffnet werden."
 
-#: lib/tools_dlg.tcl:311
-msgid "Arguments"
-msgstr "Argumente"
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - eine grafische Oberfläche für Git."
 
-#: lib/tools_dlg.tcl:348
-msgid "OK"
-msgstr "Ok"
+#: lib/blame.tcl:74
+#, fuzzy, tcl-format
+msgid "%s (%s): File Viewer"
+msgstr "Datei-Browser"
 
-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
+#: lib/blame.tcl:80
+msgid "Commit:"
+msgstr "Version:"
 
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "Wollen Sie %s wirklich starten?"
+#: lib/blame.tcl:282
+msgid "Copy Commit"
+msgstr "Version kopieren"
 
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "Werkzeug: %s"
+#: lib/blame.tcl:286
+msgid "Find Text..."
+msgstr "Text suchen..."
 
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "Starten: %s"
+#: lib/blame.tcl:290
+#, fuzzy
+msgid "Goto Line..."
+msgstr "Klonen..."
 
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "Werkzeug erfolgreich abgeschlossen: %s"
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
+msgstr "Volle Kopie-Erkennung"
 
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr "Werkzeug fehlgeschlagen: %s"
+#: lib/blame.tcl:303
+msgid "Show History Context"
+msgstr "Historien-Kontext anzeigen"
 
-#: lib/transport.tcl:7
-#, tcl-format
-msgid "Fetching new changes from %s"
-msgstr "Neue Änderungen von »%s« holen"
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
+msgstr "Elternversion annotieren"
 
-#: lib/transport.tcl:18
+#: lib/blame.tcl:468
 #, tcl-format
-msgid "remote prune %s"
-msgstr "Aufräumen von »%s«"
+msgid "Reading %s..."
+msgstr "%s lesen..."
 
-#: lib/transport.tcl:19
-#, tcl-format
-msgid "Pruning tracking branches deleted from %s"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
+msgstr "Annotierungen für Kopieren/Verschieben werden geladen..."
 
-#: lib/transport.tcl:26
-#, tcl-format
-msgid "Pushing changes to %s"
-msgstr "Änderungen nach »%s« versenden"
+#: lib/blame.tcl:613
+msgid "lines annotated"
+msgstr "Zeilen annotiert"
 
-#: lib/transport.tcl:64
-#, tcl-format
-msgid "Mirroring to %s"
-msgstr "Spiegeln nach %s"
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
+msgstr "Annotierungen für ursprünglichen Ort werden geladen..."
 
-#: lib/transport.tcl:82
-#, tcl-format
-msgid "Pushing %s %s to %s"
-msgstr "%s %s nach %s versenden"
+#: lib/blame.tcl:818
+msgid "Annotation complete."
+msgstr "Annotierung vollständig."
 
-#: lib/transport.tcl:100
-msgid "Push Branches"
-msgstr "Zweige versenden"
+#: lib/blame.tcl:849
+msgid "Busy"
+msgstr "Verarbeitung läuft"
 
-#: lib/transport.tcl:114
-msgid "Source Branches"
-msgstr "Lokale Zweige"
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
+msgstr "Annotierung läuft bereits."
 
-#: lib/transport.tcl:131
-msgid "Destination Repository"
-msgstr "Ziel-Projektarchiv"
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
+msgstr "Intensive Kopie-Erkennung läuft..."
 
-#: lib/transport.tcl:169
-msgid "Transfer Options"
-msgstr "Netzwerk-Einstellungen"
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
+msgstr "Annotierung laden..."
 
-#: lib/transport.tcl:171
-msgid "Force overwrite existing branch (may discard changes)"
-msgstr ""
-"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
+#: lib/blame.tcl:1010
+msgid "Author:"
+msgstr "Autor:"
 
-#: lib/transport.tcl:175
-msgid "Use thin pack (for slow network connections)"
-msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
+#: lib/blame.tcl:1014
+msgid "Committer:"
+msgstr "Eintragender:"
 
-#: lib/transport.tcl:179
-msgid "Include tags"
-msgstr "Mit Markierungen übertragen"
+#: lib/blame.tcl:1019
+msgid "Original File:"
+msgstr "Ursprüngliche Datei:"
+
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
+msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
+msgstr "Elternversion kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
+msgstr "Elternversion kann nicht angezeigt werden"
+
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
+msgstr "Fehler beim Laden des Vergleichs:"
+
+#: lib/blame.tcl:1279
+msgid "Originally By:"
+msgstr "Ursprünglich von:"
+
+#: lib/blame.tcl:1285
+msgid "In File:"
+msgstr "In Datei:"
+
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
+msgstr "Kopiert oder verschoben durch:"
+
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Keine Änderungen feststellbar.\n"
+"\n"
+"»%s« enthält keine Änderungen. Zwar wurde das Änderungsdatum dieser Datei "
+"von einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
+"unverändert.\n"
+"\n"
+"Das Arbeitsverzeichnis wird jetzt neu geladen, um diese Änderung bei allen "
+"Dateien zu prüfen."
+
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Vergleich von »%s« laden..."
+
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOKAL: gelöscht\n"
+"ANDERES:\n"
+
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"ANDERES: gelöscht\n"
+"LOKAL:\n"
+
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
+msgstr "LOKAL:\n"
+
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
+msgstr "ANDERES:\n"
+
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Datei »%s« kann nicht angezeigt werden"
+
+#: lib/diff.tcl:221
+msgid "Error loading file:"
+msgstr "Fehler beim Laden der Datei:"
+
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
+msgstr "Git-Projektarchiv (Unterprojekt)"
+
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
+msgstr "* Binärdatei (Inhalt wird nicht angezeigt)"
+
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
+"* Nur erste %d Bytes werden angezeigt.\n"
+
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
+"* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
+
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
+msgstr ""
+"Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
+
+#: lib/diff.tcl:591
+#, fuzzy
+msgid "Failed to revert selected hunk."
+msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
+msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
+msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
+
+#: lib/diff.tcl:696
+#, fuzzy
+msgid "Failed to revert selected line."
+msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
+msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+
+#: lib/diff.tcl:889
+#, fuzzy
+msgid "Failed to undo last revert."
+msgstr "Aktualisieren von »%s« fehlgeschlagen."
+
+#: lib/sshkey.tcl:34
+msgid "No keys found."
+msgstr "Keine Schlüssel gefunden."
+
+#: lib/sshkey.tcl:37
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Öffentlicher Schlüssel gefunden in: %s"
+
+#: lib/sshkey.tcl:43
+msgid "Generate Key"
+msgstr "Schlüssel erzeugen"
+
+#: lib/sshkey.tcl:61
+msgid "Copy To Clipboard"
+msgstr "In Zwischenablage kopieren"
+
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
+msgstr "Ihr OpenSSH öffenlicher Schlüssel"
+
+#: lib/sshkey.tcl:83
+msgid "Generating..."
+msgstr "Erzeugen..."
+
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Konnte »ssh-keygen« nicht starten:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
+msgstr "Schlüsselerzeugung fehlgeschlagen."
+
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
+msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."
+
+#: lib/sshkey.tcl:126
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Ihr Schlüssel ist abgelegt in: %s"
+
+#: lib/branch_create.tcl:23
+#, fuzzy, tcl-format
+msgid "%s (%s): Create Branch"
+msgstr "Zweig erstellen"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Neuen Zweig erstellen"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Zweigname"
+
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "Passend zu Übernahmezweig-Name"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Anfangsversion"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Existierenden Zweig aktualisieren:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Nein"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Nur Schnellzusammenführung"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Arbeitskopie umstellen nach Erstellen"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Bitte wählen Sie einen Übernahmezweig."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "Verarbeitung. Bitte warten..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Erfolgreich"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Fehler: Kommando fehlgeschlagen"
+
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr ""
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr ""
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Abgetrennte Arbeitskopie-Version"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Version Regexp-Ausdruck:"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Lokaler Zweig"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "Übernahmezweig"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Markierung"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Ungültige Version: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Keine Version ausgewählt."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "Versions-Ausdruck ist leer."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Aktualisiert"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Keine Version zur Nachbesserung vorhanden.\n"
+"\n"
+"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
+"Version, die Sie nachbessern könnten.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Nachbesserung währen Zusammenführung nicht möglich.\n"
+"\n"
+"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
+"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
+"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
+"beenden oder abbrechen.\n"
+
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
+msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
+msgstr "Benutzername konnte nicht bestimmt werden:"
+
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Ungültiger Wert von GIT_COMMITTER_INDENT:"
+
+#: lib/commit.tcl:138
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "Warning: Tcl/Tk unterstützt die Zeichencodierung »%s« nicht."
+
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/commit.tcl:182
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
+"\n"
+"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
+"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Unbekannter Dateizustand »%s«.\n"
+"\n"
+"Datei »%s« kann nicht eingetragen werden.\n"
+
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Keine Änderungen vorhanden, die eingetragen werden könnten.\n"
+"\n"
+"Sie müssen mindestens eine Datei bereitstellen, bevor Sie eintragen können.\n"
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
+msgstr ""
+"Bitte geben Sie eine Versionsbeschreibung ein.\n"
+"\n"
+"Eine gute Versionsbeschreibung enthält folgende Abschnitte:\n"
+"\n"
+"- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
+"\n"
+"- Zweite Zeile: Leerzeile\n"
+"\n"
+"- Rest: Eine ausführliche Beschreibung, warum diese Änderung hilfreich ist.\n"
+
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
+msgstr "Aufrufen der Vor-Eintragen-Kontrolle (»pre-commit hook«)..."
+
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
+msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (»pre-commit hook«)."
+
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
+msgstr ""
+"Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
+
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
+msgstr ""
+"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
+"hook«)."
+
+#: lib/commit.tcl:327
+msgid "Committing changes..."
+msgstr "Änderungen eintragen..."
+
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
+msgstr "write-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
+msgstr "Eintragen fehlgeschlagen."
+
+#: lib/commit.tcl:362
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Version »%s« scheint beschädigt zu sein"
+
+#: lib/commit.tcl:367
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Keine Änderungen einzutragen.\n"
+"\n"
+"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
+"zusammengeführt.\n"
+"\n"
+"Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
+
+#: lib/commit.tcl:374
+msgid "No changes to commit."
+msgstr "Keine Änderungen, die eingetragen werden können."
+
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
+msgstr "commit-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
+msgstr "update-ref fehlgeschlagen:"
+
+#: lib/commit.tcl:514
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Version %s übertragen: %s"
+
+#: lib/branch_delete.tcl:16
+#, fuzzy, tcl-format
+msgid "%s (%s): Delete Branch"
+msgstr "Zweig löschen"
+
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Lokalen Zweig löschen"
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Lokale Zweige"
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Nur löschen, wenn zusammengeführt nach"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
+
+#: lib/branch_delete.tcl:131
+#, tcl-format
+msgid " - %s:"
+msgstr ""
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Fehler beim Löschen der Zweige:\n"
+"%s"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Ungültiges Datum von Git: %s"
+
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "Anzahl unverknüpfter Objekte"
+
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Festplattenplatz von unverknüpften Objekten"
+
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "Anzahl komprimierter Objekte"
+
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "Anzahl Komprimierungseinheiten"
+
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Festplattenplatz von komprimierten Objekten"
+
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Komprimierte Objekte, die zum Aufräumen vorgesehen sind"
+
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "Dateien im Mülleimer"
+
+#: lib/database.tcl:66
+#, fuzzy, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr "Datenbankstatistik"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Objektdatenbank komprimieren"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Die Objektdatenbank durch »fsck-objects« überprüfen lassen"
+
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
+"\n"
+"Für eine optimale Performance wird empfohlen, die Datenbank des "
+"Projektarchivs zu komprimieren.\n"
+"\n"
+"Soll die Datenbank jetzt komprimiert werden?"
+
+#: lib/error.tcl:20
+#, fuzzy, tcl-format
+msgid "%s: error"
+msgstr "Fehler"
+
+#: lib/error.tcl:36
+#, fuzzy, tcl-format
+msgid "%s: warning"
+msgstr "Warnung"
+
+#: lib/error.tcl:80
+#, fuzzy, tcl-format
+msgid "%s hook failed:"
+msgstr "Werkzeug fehlgeschlagen: %s"
+
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr ""
+"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
+
+#: lib/error.tcl:116
+#, tcl-format
+msgid "%s (%s): error"
+msgstr ""
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
+"\n"
+"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
+"zusammenführen können.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Zusammenführung mit Konflikten.\n"
+"\n"
+"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
+"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
+"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
+"danach kann eine neue Zusammenführung begonnen werden.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Es liegen Änderungen vor.\n"
+"\n"
+"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
+"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
+"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
+"einfacher beheben oder abbrechen.\n"
+
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s von %s"
+
+#: lib/merge.tcl:126
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Zusammenführen von %s und %s..."
+
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
+msgstr "Zusammenführen erfolgreich abgeschlossen."
+
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
+
+#: lib/merge.tcl:156
+#, tcl-format
+msgid "%s (%s): Merge"
+msgstr ""
+
+#: lib/merge.tcl:164
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Zusammenführen in »%s«"
+
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
+msgstr "Zusammenzuführende Version"
+
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Abbruch der Nachbesserung ist nicht möglich.\n"
+"\n"
+"Sie müssen die Nachbesserung der Version abschließen.\n"
+
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Zusammenführen abbrechen?\n"
+"\n"
+"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
+"verloren.\n"
+"\n"
+"Zusammenführen jetzt abbrechen?"
+
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Änderungen zurücksetzen?\n"
+"\n"
+"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
+"verloren.\n"
+"\n"
+"Änderungen jetzt zurücksetzen?"
+
+#: lib/merge.tcl:246
+msgid "Aborting"
+msgstr "Abbruch"
+
+#: lib/merge.tcl:247
+msgid "files reset"
+msgstr "Dateien zurückgesetzt"
+
+#: lib/merge.tcl:277
+msgid "Abort failed."
+msgstr "Abbruch fehlgeschlagen."
+
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
+msgstr "Abbruch durchgeführt. Bereit."
+
+#~ msgid "Displaying only %s of %s files."
+#~ msgstr "Nur %s von %s Dateien werden angezeigt."
+
+#~ msgid "New Commit"
+#~ msgstr "Neue Version"
+
+#~ msgid "Case-Sensitive"
+#~ msgstr "Groß-/Kleinschreibung unterscheiden"
diff --git a/po/glossary/de.po b/po/glossary/de.po
index 35764d1d22..5af06bf4c1 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -6,10 +6,11 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
-"POT-Creation-Date: 2008-01-07 21:20+0100\n"
-"PO-Revision-Date: 2008-02-16 21:48+0100\n"
+"POT-Creation-Date: 2020-01-13 21:40+0100\n"
+"PO-Revision-Date: 2020-01-13 21:53+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
+"Language: de_DE\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -130,7 +131,7 @@ msgstr "wiederholen"
 
 #. "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
 msgid "remote"
-msgstr "Andere Archive (Gegenseite?, Entfernte?, Server?)"
+msgstr "Extern (Andere?, Gegenseite?, Entfernte?, Server?)"
 
 #. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
@@ -142,7 +143,8 @@ msgstr "zurücksetzen (zurückkehren?)"
 
 #. ""
 msgid "revert"
-msgstr "verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
+msgstr ""
+"verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
 
 #. "A particular state of files and directories which was stored in the object database."
 msgid "revision"
@@ -187,3 +189,124 @@ msgstr "überprüfen"
 #. "The tree of actual checked out files."
 msgid "working copy, working tree"
 msgstr "Arbeitskopie"
+
+#. "a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
+msgid "ancestor"
+msgstr ""
+
+#. "prematurely stop and abandon an operation"
+msgid "abort"
+msgstr ""
+
+#. "a repository with only .git directory, without working directory"
+msgid "bare repository"
+msgstr "bloßes Projektarchiv"
+
+#. "a parent version of the current file"
+msgid "base"
+msgstr ""
+
+#. "get the authors responsible for each line in a file"
+msgid "blame"
+msgstr ""
+
+#. "to select and apply a single commit without merging"
+msgid "cherry-pick"
+msgstr ""
+
+#. "a commit that directly succeeds the current one in git's graph of commits"
+msgid "child"
+msgstr ""
+
+#. "clean the state of the git repository, often after manually stopped operation"
+msgid "cleanup"
+msgstr ""
+
+#. "a message that gets attached with any commit"
+#, fuzzy
+msgid "commit message"
+msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
+
+#. "a commit that precedes the current one in git's graph of commits (not necessarily directly)"
+msgid "descendant"
+msgstr ""
+
+#. "checkout of a revision rather than a some head"
+msgid "detached checkout"
+msgstr ""
+
+#. "any merge strategy that works on a file by file basis"
+msgid "file level merging"
+msgstr ""
+
+#. "the last revision in a branch"
+msgid "head"
+msgstr ""
+
+#. "script that gets executed automatically on some event"
+msgid "hook"
+msgstr ""
+
+#. "the first checkout during a clone operation"
+msgid "initial checkout"
+msgstr ""
+
+#. "a branch that resides in the local git repository"
+msgid "local branch"
+msgstr ""
+
+#. "a Git object that is not part of any pack"
+msgid "loose object"
+msgstr ""
+
+#. "a branch called by convention 'master' that exists in a newly created git repository"
+#, fuzzy
+msgid "master branch"
+msgstr "Übernahmezweig"
+
+#. "a remote called by convention 'origin' that the current git repository has been cloned from"
+msgid "origin"
+msgstr "origin"
+
+#. "a file containing many git objects packed together"
+#, fuzzy
+msgid "pack [noun]"
+msgstr "Markierung"
+
+#. "a Git object part of some pack"
+msgid "packed object"
+msgstr ""
+
+#. "a commit that directly precedes the current one in git's graph of commits"
+msgid "parent"
+msgstr ""
+
+#. "the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
+msgid "reflog"
+msgstr ""
+
+#. "decide which changes from alternative versions of a file should persist in Git"
+msgid "resolve (a conflict)"
+msgstr ""
+
+#. "abandon changes and go to pristine version"
+#, fuzzy
+msgid "revert changes"
+msgstr ""
+"verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
+
+#. "expression that signifies a revision in git"
+msgid "revision expression"
+msgstr ""
+
+#. "add some content of files and directories to the staging area in preparation for a commit"
+msgid "stage/unstage"
+msgstr ""
+
+#. "temporarily save changes in a stack without committing"
+msgid "stash"
+msgstr ""
+
+#. "file whose content is tracked/not tracked by git"
+msgid "tracked/untracked"
+msgstr ""
-- 
gitgitgadget

