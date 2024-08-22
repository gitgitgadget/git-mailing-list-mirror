Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714F4CE05
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318881; cv=none; b=ZQL6Hhpqkn1kpZoVvukU4voqVrqSxa7FT4CpfWXlpLh6D1L/p9ANrX0OTz5Jk5CYOHYtR7Zn6QdWVYNcP/xaSK2MJHhvknTVBX5PpGtooiyBlTpkiuYkCsyjinxdI3K5/34ugMIA4Kaf7lxBhPM2xmtsINjsm5zExyOS33tRhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318881; c=relaxed/simple;
	bh=9Kv1+F0zGW+36iRHnLPY+yZ2kMNjSzjV/WKQmNr+UGI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VaHCNjHm6MyD5hRxIa1e1yTYVxdk5HGDGCbN1tXzeH4mqpDXA02jpdl2tPEMYWXqFRkqTyY3EDfkIITp0uHDoCbFexId3aYHQeuUrAgFdq6rYRgnSIhEIZSojoIWYIaFAwCiRUSvmJpCi4037TpMwgLiKpdM6HTIDeNdur1//vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQV2ffO1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQV2ffO1"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533488ffb03so773210e87.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318877; x=1724923677; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nW4wY2WnqanA0R5ubNAY3L9qc59QDHvIA8suQEvS+Rk=;
        b=dQV2ffO1MrNnTwqRTSDFngZ8RnR8wYzoa030pxJYZfAiAb8TjZc/3znza1lhjc64OG
         PGD7uu6jX3sgs1d6dk8oMGADriBCelKtj+K3ot7ZcVGpjlHmUyW+Pf4Rh9FDf5qYanfL
         FH1EZuJuob0XlsJCEaEm18Dau6RGPrn8KiIUOGAr/1SvJI54k3C+X5Jm4ZP/fYPNduhS
         YsJng+dK5bPmQGkFDi9t1cK94S9DVSPCjyUWjUjS+SCXzbnTS5Yq79V9/QOdyEbsbXL/
         e8FfPJjgKJDLcQZdy+0z8IWIkniPV3X1RLwLSc0gEUiHC+fvtN/z2LaymzUbz+/sLFYW
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318877; x=1724923677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW4wY2WnqanA0R5ubNAY3L9qc59QDHvIA8suQEvS+Rk=;
        b=fTLlLx6f9CGtRDtWI0SnXQ3HKJ9DGxaEMfb5vvKAXckdLUtZY0oW0AESrhoOSA2vy7
         p5CSXx5Twe+aOWp8Ux16p1nXeXHkfCWvwKqzDKewxnRz2K3ICa96BszhB6PyaHk58p5n
         WorWxit8JOYfda4iHMGbW0SMHYdQoCWQC6muyzbZoRcC+5MZOQsvP3u35KiDD45PaT4n
         CSerHP9c/eLwUuUYOy/LDMmYycL8mIU2MsjFXNYfOa2cOHPI+D2kX4Ytab0unO/eWlMy
         MhOootrP1wfSiNWLxcW0fofs9cGiL4lsdyOknK36Mf9D9WgalKRbyyB/O9yaH7D2jum6
         AquA==
X-Gm-Message-State: AOJu0YxBtvmGG2lNAPBvU/TUc2jUIdLKX0aLCYukwURQUqbAFkj6OxUN
	BeCs47V46794+E0kSq4Vgxl0iOdKLEt+n+MW75DLzlfly3luTaGgwP3eKA==
X-Google-Smtp-Source: AGHT+IFJxPvPwayuNUNi6Z9xHvhQVSIQpRxgTzhruSyknUgsfPkHQLNSZjJ4nuQRUEJrTAJKEaSCjg==
X-Received: by 2002:a05:6512:3b23:b0:52e:934f:bda5 with SMTP id 2adb3069b0e04-5334faeb6aamr793188e87.21.1724318876298;
        Thu, 22 Aug 2024 02:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2adc4asm91666666b.86.2024.08.22.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:27:55 -0700 (PDT)
Message-Id: <pull.1774.git.1724318874608.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Aug 2024 09:27:54 +0000
Subject: [PATCH] gitk: added external diff file rename detection
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ToBoMi <tobias.boesch@miele.com>,
    deboeto <tobias.boesch@miele.com>

From: deboeto <tobias.boesch@miele.com>

* If a file was renamed between commits and
    an external diff is started through gitk
    on the THE ORIGINAL FILE NAME (not the
    renamed one), gitk was unable to open
    the renamed file in the external diff
    editor.
    It failed to fetch the renamed file from
    git, because it fetched it with the original
    path in contrast to using the renamed path
*   gitk now detects the rename and opens the
    external diff with the original and the RENAMED
    file instead of no file (it is able to fetch
    the renamed file now from git with the renamed
    path/filename)
* Since git doesn't destinguish between move or
    rename this also works for moved files
* External diff detection and usage is optional
    and has to be enabled in gitk settings
* External rename detection ist marked
    EXPERIMENTAL in the settings and disabled
    by default
* Showing the renamed file doesn't work when THE
    RENAMED FILE is selected in gitk and an
    external diff ist started on that file,
    because the selected file is not renamed in
    that commit. It already IS the renamed file.

Signed-off-by: deboeto <tobias.boesch@miele.com>
---
    gitk: added external diff file rename detection

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

 gitk-git/gitk | 54 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d7..f7427f6d3f2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3662,11 +3662,33 @@ proc external_diff_get_one_file {diffid filename diffdir} {
                "revision $diffid"]
 }
 
+proc check_for_renames_in_diff {filepath} {
+    global ctext
+
+    set renamed_filenames [list {}]
+    set filename [file tail $filepath]
+    set rename_from_text_length 12
+    set rename_to_text_length 10
+    set reg_expr_rename_from {^rename from (.*$filename)}
+    set reg_expr_rename_from [subst -nobackslashes -nocommands $reg_expr_rename_from]
+    set reg_expr_rename_to {^rename to (.*)}
+    set rename_from_text_index [$ctext search -elide -regexp -- $reg_expr_rename_from 0.0]
+    if { ($rename_from_text_index != {})} {
+        set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to $rename_from_text_index]
+        if { ($rename_from_text_index != {}) && ($rename_to_text_index != {}) } {
+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_length chars" "$rename_from_text_index lineend"]
+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_length chars" "$rename_to_text_index lineend"]
+        }
+    }
+    return $renamed_filenames
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
     global diffids
     global extdifftool
+    global file_rename_detection
 
     if {[llength $diffids] == 1} {
         # no reference commit given
@@ -3692,8 +3714,21 @@ proc external_diff {} {
     if {$diffdir eq {}} return
 
     # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    if {$file_rename_detection} {
+        set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
+        set rename_from_filename [lindex $renamed_filenames 1]
+        set rename_to_filename [lindex $renamed_filenames 2]
+        if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
+            set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
+            set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
+        } else {
+            set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+            set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+        }
+    } else {
+        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    }
 
     if {$difffromfile ne {} && $difftofile ne {}} {
         set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
@@ -11577,7 +11612,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hideremotes want_ttk have_ttk maxrefs web_browser file_rename_detection
 
     set page [create_prefs_page $notebook.general]
 
@@ -11639,12 +11674,16 @@ proc prefspage_general {notebook} {
     grid $page.lgen - -sticky w -pady 10
     ${NS}::checkbutton $page.want_ttk -variable want_ttk \
         -text [mc "Use themed widgets"]
+    ${NS}::checkbutton $page.file_rename_detection -variable file_rename_detection \
+        -text [mc "Use ext diff file rename detection"]
+    ${NS}::label $page.file_rename_detection_note -text [mc "(EXPERIMENTAL\nTries to find the file path of a\nrenamed file in external diff)"]
     if {$have_ttk} {
         ${NS}::label $page.ttk_note -text [mc "(change requires restart)"]
     } else {
         ${NS}::label $page.ttk_note -text [mc "(currently unavailable)"]
     }
     grid x $page.want_ttk $page.ttk_note -sticky w
+    grid x $page.file_rename_detection $page.file_rename_detection_note -sticky w
     return $page
 }
 
@@ -11725,7 +11764,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk file_rename_detection
 
     set top .gitkprefs
     set prefstop $top
@@ -11734,7 +11773,7 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk file_rename_detection} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11860,7 +11899,7 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk file_rename_detection} {
         global $v
         set $v $oldprefs($v)
     }
@@ -12404,6 +12443,7 @@ set autoselect 1
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
+set file_rename_detection 0
 
 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
@@ -12498,7 +12538,7 @@ config_check_tmp_exists 50
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
     cmitmode wrapcomment autoselect autosellen showneartags maxrefs visiblerefs
-    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
+    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk file_rename_detection
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
     extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor

base-commit: b9849e4f7631d80f146d159bf7b60263b3205632
-- 
gitgitgadget
