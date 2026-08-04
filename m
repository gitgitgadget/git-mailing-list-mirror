Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E948381D
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879843; cv=none; b=rfihTEC0k1gvixxtbRZSlVXLr95efT+m+wC15G7Pm6IXlI/Q0MmK1IwdG74sBKhqadogtGakzd96ZrIBHtdYWAfHEKrkrL1JeyYSz3zWriD496F56kKzTFo4gf3qsejXpPc37/5WsDBs6Khwcq63fcZYWkDJafdZo6d1XBWa1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879843; c=relaxed/simple;
	bh=QryyLyyqnYGJDmGEk7AUOo5gmFo9WXPPcW7o0AByQfk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B6nin3N/smnLQ/D2EZeNs4gg5XkPjQIGPpl1uL5yUtvu6Yy+8VbNv/Ph3GfFeTLAP8jpKQtDFmg/GzN49jqTtUDmTbq7OF2QorpU2WwCqQC+36wtI7ME7uuosTgdgxZHlyAz024gu0AnlymssNzOF+Od2d3g9YsY9xXuhhWQZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ol1nkeMS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol1nkeMS"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9aea40d799so141921a12.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879841; x=1786484641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mINZ4PGivT8/fQbj2tmmt6yPraW8hSBcqPWYbhhftC0=;
        b=ol1nkeMSe4Y/aW50XUIyH/wGYZ1CI5HGbsRQUJH/a5Gr/8WKL52lpXGXK4VpoAHWLD
         j9Ezhzo2wTIMxwDh1pIXeWWH3tlqO43Nl0Hb6inFnXAfYAlVbXahoyu1HxKdiO3c9QD8
         VJPBLhqXvmAy5tKIh84KXkq8BO5RvTFbGNkgpabM8/oYNQmMiNECCO6eXJqcckt5p1A1
         c1snG4HFBz9351sn+36gsDg0msKUyhN44e85K/LaFCDGLYxpuBnsQcHicBAQtZFD1cKR
         UR1TAM6OoruFQiapLuVF3cq6yYp9LXy7xLSNB5eliXQoFe7s0+AbfZbkiwiINMBgBciz
         brng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879841; x=1786484641;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mINZ4PGivT8/fQbj2tmmt6yPraW8hSBcqPWYbhhftC0=;
        b=QHvGk+qbOGiFrKMhwlXODovwGJdbA9ge3o5D5hQOnPD4a4BKUDtYM6DLB/+qeMQwZg
         YA/ILYdBEUY5Hkb9sE2z2519jEdNnsSW2UauJHg7/mxZ5isJhaRr1qxv4+58OZ6tNdAP
         v0Ijk9bcUatEo+jTzNyMN6lobulWLxxUtkvqFPvA9YdP2gZWMpDpCqFynNVV6Fa7T6Fr
         BC+3tYX8SZxDcGAXN1tM5HqSjCq2Tqxc4k6Ro6qlgsegMK5m6ld8ZjQoJai+SqhhTBr5
         KnTk7LR6apRcFv6WXy/mno52BsoJ6coZmzxdJJyckt//ajfCQh4cFRq/FuiQIsaE27kA
         Wk5w==
X-Gm-Message-State: AOJu0YzQWRT420K80DoZDRywHDbjBwUQ7Jw48g3B+p6darqYk1OMZBxU
	cImxVeJ0EJx1fn2fZ19K0JqhuOuFZ5W1CEZYTZroP8XPot80BgKtal+3IkiWCw==
X-Gm-Gg: AR+sD111xPt82wIpOrzGChGFILODb5ACQoMHKk2KK7sbc2POFZ5phCwQJiy1BDEjMwC
	g7xJgAmUo6x2/dTISCAZ80Luhmjp3hDURcSP/daBvm8zoN3icVc5Rfx/JC/yO6IYFLSH32gD3HW
	MyvYFDFW7FbVTMAA2+rh8ilrxdHtxsTPlM8ZBKctapPi2tT0fQWWPTuz0c3djqbQTDLhxe6kn3w
	Rthm/U9i4QfHGrRMBDb1mQxYQoEf1hgaQ0gSZdNkterFrssoUs2pcrnmtNkLODIJIA8AoJBbMAC
	ApaNeNMFBBLos9kraflPwdEAcAxLEJk+ZL8fSsfTbvWgGiB5uYDX3F7WbFe2u0DT2a0v3aGrj9V
	585BUfgPh93GASEc+qvmpfWo7+fsj92abIEvoS50UCTkZGRPRe2EkZRudwhsj9f2UMUjv9+iGM+
	3HASFNdUfMTumHbXZL/xwqLT+H3Tg4pTWBc+t9siFgAnAcdRJJz8I4SRfiJ7CrCVd7
X-Received: by 2002:a05:6a20:4309:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3cb85dee5ecmr1628325637.9.1785879841267;
        Tue, 04 Aug 2026 14:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.133.106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca660e66sm6559550c88.8.2026.08.04.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:44:00 -0700 (PDT)
Message-Id: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
From: "Tim Wiederhake via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 21:43:59 +0000
Subject: [PATCH] gitk: add user-defined custom commands
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
Cc: Tim Wiederhake <twied@gmx.net>,
    Tim Wiederhake <twied@gmx.net>

From: Tim Wiederhake <twied@gmx.net>

Allow users to define up to three custom commands each for the commit
list and the diff display area.  Commands are configured in a new
"Commands" tab in the preferences dialog, with a name and a command
template per slot.  Non-empty slots appear in the right-click context
menu of the respective area.

Command templates support placeholder substitution (commit id, commit
title, author name, author date, etc.) and are executed via "sh -c"
to allow for background execution by appending "&", and pipeing.  If
a command terminates with exit code 42, its output is displayed;
otherwise only non-zero exit codes are reported.

Signed-off-by: Tim Wiederhake <twied@gmx.net>
Assisted-by: Claude Opus 4.6
---
    gitk: add user-defined custom commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2371%2Ftwied%2Fcustom_commands-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2371/twied/custom_commands-v1
Pull-Request: https://github.com/git/git/pull/2371

 gitk-git/gitk | 220 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 0f3571050b..af9cfd9eec 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3696,9 +3696,11 @@ proc find_ctext_fileinfo {line} {
 }
 
 proc pop_diff_menu {w X Y x y} {
-    global ctext diff_menu flist_menu_file
-    global diff_menu_txtpos diff_menu_line
-    global diff_menu_filebase
+    global ctext diff_menu flist_menu_file currentid
+    global diff_menu_txtpos diff_menu_line diff_menu_filebase
+    global usercmd_dd_name1 usercmd_dd_body1
+    global usercmd_dd_name2 usercmd_dd_body2
+    global usercmd_dd_name3 usercmd_dd_body3
 
     set diff_menu_txtpos [split [$w index "@$x,$y"] "."]
     set diff_menu_line [lindex $diff_menu_txtpos 0]
@@ -3711,6 +3713,10 @@ proc pop_diff_menu {w X Y x y} {
     if {$f eq {}} return
     set flist_menu_file [lindex $f 0]
     set diff_menu_filebase [lindex $f 1]
+    update_menu_custom_cmds $diff_menu $currentid \
+        [list $usercmd_dd_name1 $usercmd_dd_body1 \
+              $usercmd_dd_name2 $usercmd_dd_body2 \
+              $usercmd_dd_name3 $usercmd_dd_body3]
     tk_popup $diff_menu $X $Y
 }
 
@@ -9148,9 +9154,134 @@ proc mstime {} {
     return [format "%.3f" [expr {([clock click -milliseconds] - $startmstime) / 1000.0}]]
 }
 
+proc update_menu_custom_cmds {menu id cmds} {
+    if {![info exists ::usercmd_menu_count($menu)]} {
+        set ::usercmd_menu_count($menu) 0
+    }
+
+    for {set j 0} {$j < $::usercmd_menu_count($menu)} {incr j} {
+        $menu delete end
+    }
+
+    set ::usercmd_menu_count($menu) 0
+    foreach {name cmd_template} $cmds {
+        if {$name ne "" && $cmd_template ne ""} {
+            if {$::usercmd_menu_count($menu) == 0} {
+                $menu add separator
+                incr ::usercmd_menu_count($menu)
+            }
+            $menu add command -label $name \
+                -command [list exec_custom_cmd $cmd_template $id]
+            incr ::usercmd_menu_count($menu)
+        }
+    }
+}
+
+proc get_blame_origin {} {
+    global diff_menu_filebase diff_menu_line flist_menu_file
+    global currentid cmitmode parents curview cdup
+
+    set blame_id ""
+    set blame_line ""
+    catch {
+        if {$cmitmode eq "tree"} {
+            set line [expr {$diff_menu_line - $diff_menu_filebase}]
+            set blamefile [file join $cdup $flist_menu_file]
+            set blame_out [exec git blame -p -L$line,+1 $currentid -- $blamefile]
+            set first [lindex [split $blame_out "\n"] 0]
+            set blame_id [lindex $first 0]
+            set blame_line [lindex $first 1]
+        } else {
+            set h [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
+            if {$h ne {}} {
+                set pi [lindex $h 0]
+                if {$pi > 0} {
+                    incr pi -1
+                    set blame_parent [lindex $parents($curview,$currentid) $pi]
+                    set line [lindex $h 1]
+                    set blamefile [file join $cdup $flist_menu_file]
+                    set blame_out [exec git blame -p -L$line,+1 $blame_parent -- $blamefile]
+                    set first [lindex [split $blame_out "\n"] 0]
+                    set blame_id [lindex $first 0]
+                    set blame_line [lindex $first 1]
+                }
+            }
+        }
+    }
+    return [list $blame_id $blame_line]
+}
+
+proc get_diff_file {} {
+    global flist_menu_file
+    if {[info exists flist_menu_file]} {
+        return $flist_menu_file
+    }
+    return ""
+}
+
+proc exec_custom_cmd {cmd_template id} {
+    global commitinfo markedid
+
+    getcommit $id
+
+    set blame_computed 0
+    set blame_id ""
+    set blame_line ""
+
+    set cmd ""
+    set len [string length $cmd_template]
+    for {set i 0} {$i < $len} {incr i} {
+        if {[string index $cmd_template $i] eq "%" && $i + 1 < $len} {
+            set next [string index $cmd_template [expr {$i + 1}]]
+            if {!$blame_computed && ($next eq "b" || $next eq "l")} {
+                set blame [get_blame_origin]
+                set blame_id [lindex $blame 0]
+                set blame_line [lindex $blame 1]
+                set blame_computed 1
+            }
+            switch -- $next {
+                "%" { append cmd "%" }
+                "i" { append cmd $id }
+                "t" { append cmd [lindex $commitinfo($id) 0] }
+                "a" { append cmd [lindex $commitinfo($id) 1] }
+                "d" { append cmd [lindex $commitinfo($id) 2] }
+                "c" { append cmd [lindex $commitinfo($id) 3] }
+                "D" { append cmd [lindex $commitinfo($id) 4] }
+                "m" { append cmd [lindex $commitinfo($id) 5] }
+                "M" { if {[info exists markedid]} { append cmd $markedid } }
+                "b" { append cmd $blame_id }
+                "f" { append cmd [get_diff_file] }
+                "l" { append cmd $blame_line }
+                default { append cmd "%" $next }
+            }
+            incr i
+        } else {
+            append cmd [string index $cmd_template $i]
+        }
+    }
+
+    if {[catch {exec sh -c $cmd 2>@1} output]} {
+        set exitcode 1
+        if {[lindex $::errorCode 0] eq "CHILDSTATUS"} {
+            set exitcode [lindex $::errorCode 2]
+        }
+        if {$exitcode == 42} {
+            tk_messageBox -type ok -icon info \
+                -title [mc "Command output"] -message $output
+        } else {
+            tk_messageBox -type ok -icon error \
+                -title [mc "Command failed"] \
+                -message [mc "Exit code %d:\n%s" $exitcode $output]
+        }
+    }
+}
+
 proc rowmenu {x y id} {
     global rowctxmenu selectedline rowmenuid curview
     global nullid nullid2 fakerowmenu mainhead markedid
+    global usercmd_cl_name1 usercmd_cl_body1
+    global usercmd_cl_name2 usercmd_cl_body2
+    global usercmd_cl_name3 usercmd_cl_body3
 
     stopfinding
     set rowmenuid $id
@@ -9182,6 +9313,10 @@ proc rowmenu {x y id} {
     $menu entryconfigure [mca "Make patch"] -state $state
     $menu entryconfigure [mca "Diff this -> marked commit"] -state $mstate
     $menu entryconfigure [mca "Diff marked commit -> this"] -state $mstate
+    update_menu_custom_cmds $menu $id \
+        [list $usercmd_cl_name1 $usercmd_cl_body1 \
+              $usercmd_cl_name2 $usercmd_cl_body2 \
+              $usercmd_cl_name3 $usercmd_cl_body3]
     tk_popup $menu $x $y
 }
 
@@ -11916,6 +12051,60 @@ proc prefspage_fonts {notebook} {
     return $page
 }
 
+proc prefspage_commands {notebook} {
+    global {*}$::config_variables
+
+    set page [create_prefs_page $notebook.commands]
+
+    ttk::label $page.cl_header -text [mc "Commit list"] -font mainfontbold
+    grid $page.cl_header - - -sticky w -pady 10
+
+    ttk::label $page.cl_namelbl -text [mc "Name"]
+    ttk::label $page.cl_cmdlbl -text [mc "Command"]
+    grid x $page.cl_namelbl $page.cl_cmdlbl -sticky w
+
+    foreach i {1 2 3} {
+        ttk::label $page.cl_row${i}lbl -text "${i}."
+        ttk::entry $page.cl_name${i} -textvariable usercmd_cl_name${i} -width 20
+        ttk::entry $page.cl_body${i} -textvariable usercmd_cl_body${i} -width 40
+        grid $page.cl_row${i}lbl $page.cl_name${i} $page.cl_body${i} -sticky ew -padx 2
+    }
+
+    ttk::label $page.dd_header -text [mc "Diff display"] -font mainfontbold
+    grid $page.dd_header - - -sticky w -pady 10
+
+    ttk::label $page.dd_namelbl -text [mc "Name"]
+    ttk::label $page.dd_cmdlbl -text [mc "Command"]
+    grid x $page.dd_namelbl $page.dd_cmdlbl -sticky w
+
+    foreach i {1 2 3} {
+        ttk::label $page.dd_row${i}lbl -text "${i}."
+        ttk::entry $page.dd_name${i} -textvariable usercmd_dd_name${i} -width 20
+        ttk::entry $page.dd_body${i} -textvariable usercmd_dd_body${i} -width 40
+        grid $page.dd_row${i}lbl $page.dd_name${i} $page.dd_body${i} -sticky ew -padx 2
+    }
+
+    set explain "Commands with both name and command filled in will "
+    append explain "appear in the context menu (right-click) of the "
+    append explain "respective area. "
+    append explain "Substitution: %% = literal %, %i = commit id, "
+    append explain "%t = title, %m = message, %a = author, "
+    append explain "%d = author date, %c = committer, "
+    append explain "%D = committer date, %M = marked commit id, "
+    append explain "%f = file path (diff only), "
+    append explain "%b = blame origin id (diff only), "
+    append explain "%l = blame origin line number (diff only). "
+    append explain "Exit code 0 = silent; 42 = show output; "
+    append explain "other = show error. "
+    append explain "Append \"&\" to run asynchronously."
+    ttk::label $page.explain -text $explain -wraplength 500 -justify left
+    grid $page.explain - - -sticky w -pady 10 -padx 5
+
+    grid columnconfigure $page 2 -weight 1
+
+    return $page
+}
+
 proc doprefs {} {
     global oldprefs prefstop
     global {*}$::config_variables
@@ -11938,6 +12127,7 @@ proc doprefs {} {
     lappend pages [prefspage_general $notebook] [mc "General"]
     lappend pages [prefspage_colors $notebook] [mc "Colors"]
     lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
+    lappend pages [prefspage_commands $notebook] [mc "Commands"]
     set col 0
     foreach {page title} $pages {
         $notebook add $page -text $title
@@ -12659,6 +12849,18 @@ set autocopy 0
 set autoselect 1
 set autosellen $hashlength
 set perfile_attrs 0
+set usercmd_cl_name1 ""
+set usercmd_cl_body1 ""
+set usercmd_cl_name2 ""
+set usercmd_cl_body2 ""
+set usercmd_cl_name3 ""
+set usercmd_cl_body3 ""
+set usercmd_dd_name1 ""
+set usercmd_dd_body1 ""
+set usercmd_dd_name2 ""
+set usercmd_dd_body2 ""
+set usercmd_dd_name3 ""
+set usercmd_dd_body3 ""
 
 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
@@ -12807,6 +13009,18 @@ set config_variables {
     uifgcolor
     uifgdisabledcolor
     uifont
+    usercmd_cl_body1
+    usercmd_cl_body2
+    usercmd_cl_body3
+    usercmd_cl_name1
+    usercmd_cl_name2
+    usercmd_cl_name3
+    usercmd_dd_body1
+    usercmd_dd_body2
+    usercmd_dd_body3
+    usercmd_dd_name1
+    usercmd_dd_name2
+    usercmd_dd_name3
     visiblerefs
     web_browser
     workingfilescirclecolor

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
gitgitgadget
