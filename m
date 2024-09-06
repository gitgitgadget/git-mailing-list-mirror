Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF853C463
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607705; cv=none; b=uqQ/qb3RWQU5C/54Fk9gb4a48XxgwT7y6larTBEHca1/wWTmzvNPx0TCWoBHtTDnfpxYOCuDgMsWm5XfkJLw4m1PsJnB3VgJ0QHHOyk2RO7sxMYZFxgifnYVfoFrFCW/MmQUifiJskx6KyakPWNJOHIQoVle/Y2ASR+7VZSzLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607705; c=relaxed/simple;
	bh=WpKNCF4Ritf9WFauir6dIqUx79pzZlnr3LpPH5EorNY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EuoNydDZC8EFpq5pwAmFURmaTstR3ZAZq4Re7QFahPHL/0ztqC1q/mnGoPx9EBHS0490unzq0pAUAOCpXg6eRaLYXXiwWK1pswylW8BnUeBO/8mlUmOnM8LcM5RVbbkY10ZhaqRa/QR48r2PhJkyM6dSwHzTHRXO0vG8A/vbOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrFJu2Kx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrFJu2Kx"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so1667332a12.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725607701; x=1726212501; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcPysyO/SP5syhP+P3fWsoTww6YtSbLOifR1b2HnLTM=;
        b=KrFJu2KxDLps1JtdgFG2SSIDPoF8FAda2ghiL5JVZk+fD7bygZ3YiFW7j2u17SiMBB
         k3L1goFZ9D6UqABIC02Hx30Z0j5WNMWJXQL9CWWsLoZNYc4Ndv2h4+qlvLchUiljYq/q
         Hx7wCvbtr20Y1igWboe8Wt9MYs4/bt+9xBWBOf6e+qqFC+b2SpClwkptFeppRLnLBQMI
         6K3QbGVhV8YrEilfqdXAkz+01Ep+rOgkd+V/f2z4RY5BoO+8h9sasT5Rtqj+GnqpayYt
         9xYlJ95t5ETG5UbHoFW+M1T/czsKiLWajazIF/AgQ3him4/UroiIurPyK7u3pGMUfdSS
         r3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607701; x=1726212501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcPysyO/SP5syhP+P3fWsoTww6YtSbLOifR1b2HnLTM=;
        b=h9cGPe0Ymulbg7HcOcdJqGoBdRAcScyPZ26gzT6riyCqURtt+TgHhDlVHuGqk8X5nt
         b2VYNUsN9uZIqBkYxJWHAEIP9S7dwZankL4WYCzhKyMaSritVkTIqkzkE8RyNrh60Jh1
         L/eJQsDgUN94cs4zQ8d3gmRRzMh92X+gZuAolj0sQsqasm+Vp/WBt8Q3TSsKTuDqoTCv
         uWp1Vsx6r03r3QYMrXE0dO9vSkTvl7aBkEB16Yta8qTadr9yDFYgADjfgxZg85CbvB//
         ngi0H//+lpDNWfZHUpbWcqzGrZTb2s6SigvSlLdQGEDJORa811g1cstwCD7iUx3yKk9x
         l5cQ==
X-Gm-Message-State: AOJu0Yz2Ix2ZagZDNIuohvpLu7DV9kUCTCup6jQCLCblUO8czSEoIAsw
	apz3eEXvw23cMdmsT4S8fZlAg1p8dKo/UwEIhFM2QUTX42z5UtNPDqcZTg==
X-Google-Smtp-Source: AGHT+IEqakS6/tgx6MWxkdASlQv5LDm5W+CEnw5FAV5EeommcKVCCfIFGc1o/3/Drsj3Xh66PiwPUg==
X-Received: by 2002:a50:c943:0:b0:5c0:b793:df4e with SMTP id 4fb4d7f45d1cf-5c21ed52c88mr17622434a12.22.1725607700088;
        Fri, 06 Sep 2024 00:28:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc551588sm2108173a12.39.2024.09.06.00.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:28:19 -0700 (PDT)
Message-Id: <pull.1774.v2.git.1725607698680.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.git.1724318874608.gitgitgadget@gmail.com>
References: <pull.1774.git.1724318874608.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Sep 2024 07:28:18 +0000
Subject: [PATCH v2] gitk: added external diff file rename detection
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
    Tobias Boesch <tobias.boesch@miele.com>

From: Tobias Boesch <tobias.boesch@miele.com>

* If a file was renamed between commits and an external diff is started
  through gitk on the THE ORIGINAL FILE NAME (not the renamed one),
  gitk was unable to open the renamed file in the external diff editor.
  It failed to fetch the renamed file from git, because it fetched it
  with the original path in contrast to using the renamed path
* gitk now detects the rename and opens the external diff with the
  original and the RENAMED file instead of no file (it is able to
  fetch the renamed file now from git with the renamed path/filename)
* Since git doesn't destinguish between move or rename this also works
  for moved files
* External diff detection and usage is optional and has to be enabled in
  gitk settings
* External rename detection ist marked EXPERIMENTAL in the settings
  and disabled by default
* Showing the renamed file doesn't work when THE RENAMED FILE is selected
  in gitk and an external diff ist started on that file, because the
  selected file is not renamed in that commit. It already IS the renamed
  file.

Signed-off-by: Tobias Boeesch <tobias.boesch@miele.com>
---
    gitk: added external diff file rename detection
    
    Changes since v1:
    
     * Commit message ident
     * Commit message line length

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v1:

 1:  4ff4aec82fe ! 1:  6209080cad6 gitk: added external diff file rename detection
     @@
       ## Metadata ##
     -Author: deboeto <tobias.boesch@miele.com>
     +Author: Tobias Boesch <tobias.boesch@miele.com>
      
       ## Commit message ##
          gitk: added external diff file rename detection
      
     -    * If a file was renamed between commits and
     -        an external diff is started through gitk
     -        on the THE ORIGINAL FILE NAME (not the
     -        renamed one), gitk was unable to open
     -        the renamed file in the external diff
     -        editor.
     -        It failed to fetch the renamed file from
     -        git, because it fetched it with the original
     -        path in contrast to using the renamed path
     -    *   gitk now detects the rename and opens the
     -        external diff with the original and the RENAMED
     -        file instead of no file (it is able to fetch
     -        the renamed file now from git with the renamed
     -        path/filename)
     -    * Since git doesn't destinguish between move or
     -        rename this also works for moved files
     -    * External diff detection and usage is optional
     -        and has to be enabled in gitk settings
     -    * External rename detection ist marked
     -        EXPERIMENTAL in the settings and disabled
     -        by default
     -    * Showing the renamed file doesn't work when THE
     -        RENAMED FILE is selected in gitk and an
     -        external diff ist started on that file,
     -        because the selected file is not renamed in
     -        that commit. It already IS the renamed file.
     +    * If a file was renamed between commits and an external diff is started
     +      through gitk on the THE ORIGINAL FILE NAME (not the renamed one),
     +      gitk was unable to open the renamed file in the external diff editor.
     +      It failed to fetch the renamed file from git, because it fetched it
     +      with the original path in contrast to using the renamed path
     +    * gitk now detects the rename and opens the external diff with the
     +      original and the RENAMED file instead of no file (it is able to
     +      fetch the renamed file now from git with the renamed path/filename)
     +    * Since git doesn't destinguish between move or rename this also works
     +      for moved files
     +    * External diff detection and usage is optional and has to be enabled in
     +      gitk settings
     +    * External rename detection ist marked EXPERIMENTAL in the settings
     +      and disabled by default
     +    * Showing the renamed file doesn't work when THE RENAMED FILE is selected
     +      in gitk and an external diff ist started on that file, because the
     +      selected file is not renamed in that commit. It already IS the renamed
     +      file.
      
     -    Signed-off-by: deboeto <tobias.boesch@miele.com>
     +    Signed-off-by: Tobias Boeesch <tobias.boesch@miele.com>
      
       ## gitk-git/gitk ##
      @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {


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

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
