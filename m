Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6D19CD01
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755961; cv=none; b=vE6OAl5QnaJ3rbnftbe1UISHJm33DedxxHOjkEtL4PQU1+ygBi22ipvFz0n3oWvB1orJBKkb0rjlnQJVrTvdihHAUac5moueGZrHFgxApZLBQF4k1R5Xx6SbjxMQgSz8L3EPhZXH5rRnMFBUzgrpkdULf7K0w1lOakk5iXTssf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755961; c=relaxed/simple;
	bh=JIIm+vmESym/WV4Ly/qPeFBeTa9rX/7VDydL8qkN9c4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hbeKnM2vf+nl+HXJAzuLXtd0ZmmwGNbCj5SnHbhv4n9iokz7+IWiXQrsIy47vWp+4CmQhSMiMqLBFTdzmTZ4dHmpZXIKJHtVAQDhdsCGdORv/dSsga/lxE4PuZzeS6YydcbNK4dwJ9wyRwT6LRCwiFqt3KTkvfFckFq7fG9FJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMKYJMrQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMKYJMrQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a54690d369so4293504f8f.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750755957; x=1751360757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEgGSVQqDW+q6BGyX38x3y3BfLmKJmyatDC0ax3NqCY=;
        b=OMKYJMrQJA8YmNHI3KiufJpmjYcIIFVDxxyh+9LJ4Z7PiWiPPOjBC6LCfAu2+2DxWD
         RFf31M4Itd4CsNwcn4FcTEgK+K+VfjGzYxtJiI1wP3ichmFBYoxU4qgjTZFZHPgQdfbs
         MjnKCH2cXG6YzUHHuW1qBXJ578iR1n6RwNZWRO2Au02h/ImV1wbHIUBdjbMLIBjmHFC/
         WczkJb5y/qjvIh4m/7qRbZR3aL6j7n40un9DIIZTe6Cs5jT9kYbdOj91eBP7pMmZgsbh
         yKhx0bC0SKORFHY8W7XFAcddVbcsl875nW8tOJWbyxSKflMu78D6UCexnvvp4GGowqFU
         gLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750755957; x=1751360757;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEgGSVQqDW+q6BGyX38x3y3BfLmKJmyatDC0ax3NqCY=;
        b=dFtv4GnnRZrNUEuUdHEDP11Az/ri9F2NKk7PtTLQna0pBoRcjPHlbeN9god7pbeaPv
         Xeh5opvX9pLQZREZAck6g7l2wtr71NerIcn/oX0z1G6VopWKrlzkFvZ3Zz6nANo6Ahwu
         IRe5/4cpstXM3HfBeVcAxonBHUrjQQD41lv/QNZnz9NG7ZwDpoAMRZ0xMtlETILrnbto
         FaKsw+dWS5E27G58xqVrnGoInp0Bkarn6g3F5ZO6r7oDDX7mh3Giy0Xaae9kNVxWqJdw
         ubEo7dqM4SL657/wAbMXUDjGrWCtJCuv7bY9tejt/WJQMLftUY7hEI5CtnbSL72oQitN
         R7wg==
X-Gm-Message-State: AOJu0YwOI3WDA9mBnbg1UeUudrtY+4UwAVqFgC/C13aFbwTuGtDcpOkw
	YP7g/7mJw+vwe7iS/li3RgfI0zZ8EwzLjbNFtlQjxGd55qFLUAAuAtuRc6gQHg==
X-Gm-Gg: ASbGncsMX+f+hgJtuPDL4C97gfYenQ+PS8q+sylGcKEux7uoIQS/XJBVGJrcoAAiTrD
	thzBhtifTcpYrVdPaaS9zE7nV7wQml97roharLbVauRIzGvKNXomkEwV9di1cHfhY2W5JszNn5T
	iG6O/w1ZaBKFbXcD8S7OiwjERrcq1CF/EKU6cNm8Xtb8/htmMpSogH9Dh9Ib0ZkPypOXMVeiPTV
	vriuXm9mwz/d/dYHKUlEbPHfhh2ovXUAIm3bkD2xmLnLha7UNYO0WyqwQqziPJcqHWbEqapDb/7
	rmG/Ya1VhQm82H7JIVpGl23AXAUg0UJu1df2cGh++PzeX2ExrbNkZEz7OFapRJI=
X-Google-Smtp-Source: AGHT+IH2IKBsfPTfwyxmHTHvvCSArYRCTxert/GlBB2Y6dresio/cI6Yc1+WuDpxUw++MmElQq5EWA==
X-Received: by 2002:a05:6000:230b:b0:3a5:8a68:b823 with SMTP id ffacd0b85a97d-3a6d12af83bmr11330811f8f.23.1750755956694;
        Tue, 24 Jun 2025 02:05:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453755e7d1dsm52966785e9.10.2025.06.24.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:05:55 -0700 (PDT)
Message-Id: <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v5.git.1749544174590.gitgitgadget@gmail.com>
References: <pull.1774.v5.git.1749544174590.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 09:05:53 +0000
Subject: [PATCH v6] gitk: add external diff file rename detection
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    tobias.boesch@miele.com,
    ToBoMi <tobias.boesch@miele.com>,
    Tobias Boesch <tobias.boesch@miele.com>

From: Tobias Boesch <tobias.boesch@miele.com>

If a file is renamed between commits and an external diff is started
through gitk on the original or the renamed file name,
gitk is unable to open the renamed file in the external diff editor.
It fails to fetch the renamed file from git, because it fetches it
using its original path in contrast to using the renamed path of the
file.
Detect the rename and open the external diff with the original and
the renamed file instead of no file (fetch the renamed file path and
name from git) no matter if the original or the renamed file is
selected in gitk.
Since moved or renamed file are handled the same way do this also
for moved files.

Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
---
    gitk: add external diff file rename detection
    
    Changes since v1:
    
     * Commit message ident
     * Commit message line length
    
    Changes since v2:
    
     * Removed option for rename detection (Adding GUI options seems to be
       not desired - which is understandable)
     * Rebased on current master of git-for-windows
     * Renamed variables for a better understanding
     * Made rename detection also work when the renamed file is selected in
       gitk
    
    Changes since v3:
    
     * Changed message to use present tense, removed bullet points and
       described changes in imperative mood
    
    Changes sine v4:
    
     * Use a git command to gather the changed file paths rather than
       parsing the text from the diff window panel for efficiency and to
       avoid regex containing the filename as a variable.
     * Change != to ne in string comparison
     * removed extra set of parentheses around &&
     * shorter variable names
    
    Changes sine v5:
    
     * Include filename in rename check. Find only the file and its renamed
       version that is selected in the GUI.
     * Escape special characters in the filename to prevent that they are
       intepreted as part of a regular expression

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v5:

 1:  0d28f189dc3 ! 1:  f1c71e56324 gitk: add external diff file rename detection
     @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
      +                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
      +    }
      +    set filename [file tail $filepath]
     -+    set regex_ren {\d+\s\d+\s\S+\s\S+\s\S+\s+(\S+)\s+(\S+)}
     -+    set regex_ren [subst -nobackslashes -nocommands $regex_ren]
     -+    if {[regexp -line -- $regex_ren $cmd_result whole_match ren_from ren_to]} {
     ++    set esc_chars {\\ | ? ^ * . $ \[ \] + \( \) \{ \}}
     ++    foreach char $esc_chars {
     ++        set filename [string map [list $char \\$char] $filename]
     ++    }
     ++    set regex_base {\d+\s\d+\s\S+\s\S+\s\S+\s+}
     ++    set regex_ren_from $regex_base[subst -nobackslashes -nocommands {(\S+$filename)\s+(\S+)}]
     ++    set regex_ren_to $regex_base[subst -nobackslashes -nocommands {(\S+)\s+(\S+$filename)}]
     ++    if {[regexp -line -- $regex_ren_from $cmd_result whole_match ren_from ren_to]} {
     ++        if {$ren_from ne {} && $ren_to ne {}} {
     ++            lappend renames $ren_from
     ++            lappend renames $ren_to
     ++        }
     ++    } elseif {[regexp -line -- $regex_ren_to $cmd_result whole_match ren_from ren_to]} {
      +        if {$ren_from ne {} && $ren_to ne {}} {
      +            lappend renames $ren_from
      +            lappend renames $ren_to


 gitk-git/gitk | 54 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 19689765cde..5d4b0fd3a68 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3775,6 +3775,48 @@ proc external_diff_get_one_file {diffid filename diffdir} {
                "revision $diffid"]
 }
 
+proc check_for_renames_in_diff {diffidfrom diffidto filepath} {
+    global nullid nullid2
+
+    if {$diffidfrom eq $nullid} {
+        set rev [list $diffidto -R]
+    } elseif {$diffidfrom eq $nullid2} {
+        set rev [list $diffidto --cached -R]
+    } elseif {$diffidto eq $nullid} {
+        set rev [list $diffidfrom]
+    } elseif {$diffidto eq $nullid2} {
+        set rev [list $diffidfrom --cached]
+    } else {
+        set rev [list $diffidfrom..$diffidto]
+    }
+
+    set renames [list {}]
+    if {[catch {eval exec git diff $rev --find-renames --stat --raw --diff-filter=R} cmd_result]} {
+        error_popup "[mc "Error getting file rename info for file \"%s\" from commit %s to %s." \
+                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
+    }
+    set filename [file tail $filepath]
+    set esc_chars {\\ | ? ^ * . $ \[ \] + \( \) \{ \}}
+    foreach char $esc_chars {
+        set filename [string map [list $char \\$char] $filename]
+    }
+    set regex_base {\d+\s\d+\s\S+\s\S+\s\S+\s+}
+    set regex_ren_from $regex_base[subst -nobackslashes -nocommands {(\S+$filename)\s+(\S+)}]
+    set regex_ren_to $regex_base[subst -nobackslashes -nocommands {(\S+)\s+(\S+$filename)}]
+    if {[regexp -line -- $regex_ren_from $cmd_result whole_match ren_from ren_to]} {
+        if {$ren_from ne {} && $ren_to ne {}} {
+            lappend renames $ren_from
+            lappend renames $ren_to
+        }
+    } elseif {[regexp -line -- $regex_ren_to $cmd_result whole_match ren_from ren_to]} {
+        if {$ren_from ne {} && $ren_to ne {}} {
+            lappend renames $ren_from
+            lappend renames $ren_to
+        }
+    }
+    return $renames
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
@@ -3805,8 +3847,16 @@ proc external_diff {} {
     if {$diffdir eq {}} return
 
     # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    set renamed_filenames [check_for_renames_in_diff $diffidfrom $diffidto $flist_menu_file]
+    set rename_from_filename [lindex $renamed_filenames 1]
+    set rename_to_filename [lindex $renamed_filenames 2]
+    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
+        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
+    } else {
+        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    }
 
     if {$difffromfile ne {} && $difftofile ne {}} {
         set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]

base-commit: 14de3eb34435db79c6e7edc8082c302a26a8330a
-- 
gitgitgadget
