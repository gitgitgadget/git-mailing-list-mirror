From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH 1/2] gitk: Add a 'rename' option to the branch context menu
Date: Sat, 19 Mar 2016 19:32:16 +0100
Message-ID: <1733024.6FbHNINAh3@wiske>
References: <51900395.pKIx87RN0F@wiske> <10662590.KWXHt2RUKZ@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:15:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahYVu-0000nk-MK
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 09:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbcCTIO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 04:14:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32825 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbcCTIOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 04:14:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id x188so14947693wmg.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+j5EfTw7EaQPTffgPbD5Nes+jMaQiws1rJsgQp9YLE=;
        b=g2Xos9EllQHsVEbzPfMpuR2e81gNf/vCIf8W3geSo7flENDl7PsUASYSXmQHfpoxLd
         70kqzps3kvxVBetSuAJh8dGjhQUieORMiwF77Sh6eedC1gdE4LaiLvEDHtljfBWr8Sww
         b7oqDQ2zD+RPO26nkmECLOc9PTmGFqmIlTepE5B0zzzULBxpWPM6He11fO9RgeP70tOS
         R4BrxDVECvJV1sC/fuEvfjOfOKhNTxdCCTJ75eGdaRCruF4htef6VXBBWg/XwMXDxFrn
         WDppnXp7DXgj0Pcww/xJ9WHR8UTFU+5EC5NsxA96Um9aZLP7MGoXw4+WB7KE5A6nuezy
         CLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v+j5EfTw7EaQPTffgPbD5Nes+jMaQiws1rJsgQp9YLE=;
        b=AP0wLX3HrGlOLPmV4+zcpE96EvVxywKAelShXw6XO7xCDJWJC8wzYXPkkYbWXuB2Sz
         rEjCsi8p3Y2MGMHXFeU05SEDwmm1UYETo9hGApdsXrsGz/rFwh9P9H+XZYALciDgQwz0
         //Ba+VcLDWb2a4aOA9eFKL/S3GvhG8RkpglqTTM/lFk+ArLoVplO8TfUN5RwCRDc2+Hg
         SKEbZj4MfiXFc4/LHVf8YruFJB7m7nFJqmLhuU9fR15JEla2VHcaa2jm/ZWX4XKq9UpS
         OjL5RChuLb3cEznct4eppW2qoUFU+d7Cdg5RR6WtiLr2VxCpvOSIh//3VYy4DQqWTX3s
         M7MA==
X-Gm-Message-State: AD7BkJImenrIx2vqoBrK3N+w0l4hSEUUpRM/yeRwZZkoHtFy7wYt7yOuVvrUXHUFtxHMeQ==
X-Received: by 10.28.53.4 with SMTP id c4mr7958503wma.34.1458461686698;
        Sun, 20 Mar 2016 01:14:46 -0700 (PDT)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id e127sm6822813wma.20.2016.03.20.01.14.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 01:14:46 -0700 (PDT)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <10662590.KWXHt2RUKZ@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289341>


Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>
---
 gitk | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/gitk b/gitk
index 805a1c7..84b49bc 100755
--- a/gitk
+++ b/gitk
@@ -2664,6 +2664,7 @@ proc makewindow {} {
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
 	{mc "Check out this branch" command cobranch}
+	{mc "Rename this branch" command mvbranch}
 	{mc "Remove this branch" command rmbranch}
 	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
@@ -9452,26 +9453,58 @@ proc wrcomcan {} {
 }
 
 proc mkbranch {} {
-    global rowmenuid mkbrtop NS
+    global NS rowmenuid
+
+    set top .branchdialog
+
+    set val(name) ""
+    set val(id) $rowmenuid
+    set val(command) [list mkbrgo $top]
+
+    set ui(title) [mc "Create branch"]
+    set ui(accept) [mc "Create"]
+
+    branchdia $top val ui
+}
+
+proc mvbranch {} {
+    global NS
+    global headmenuid headmenuhead
+
+    set top .branchdialog
+
+    set val(name) $headmenuhead
+    set val(id) $headmenuid
+    set val(command) [list mvbrgo $top $headmenuhead]
+
+    set ui(title) [mc "Rename branch %s" $headmenuhead]
+    set ui(accept) [mc "Rename"]
+
+    branchdia $top val ui
+}
+
+proc branchdia {top valvar uivar} {
+    global NS
+    upvar $valvar val $uivar ui
 
-    set top .makebranch
     catch {destroy $top}
     ttk_toplevel $top
     make_transient $top .
-    ${NS}::label $top.title -text [mc "Create new branch"]
+    ${NS}::label $top.title -text $ui(title)
     grid $top.title - -pady 10
     ${NS}::label $top.id -text [mc "ID:"]
     ${NS}::entry $top.sha1 -width 40
-    $top.sha1 insert 0 $rowmenuid
+    $top.sha1 insert 0 $val(id)
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
     ${NS}::label $top.nlab -text [mc "Name:"]
     ${NS}::entry $top.name -width 40
+    $top.name insert 0 $val(name)
     grid $top.nlab $top.name -sticky w
     ${NS}::frame $top.buts
-    ${NS}::button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top]
+    ${NS}::button $top.buts.go -text $ui(accept) -command $val(command)
     ${NS}::button $top.buts.can -text [mc "Cancel"] -command "catch {destroy $top}"
-    bind $top <Key-Return> [list mkbrgo $top]
+    bind $top <Key-Return> $val(command)
     bind $top <Key-Escape> "catch {destroy $top}"
     grid $top.buts.go $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -9526,6 +9559,46 @@ proc mkbrgo {top} {
     }
 }
 
+proc mvbrgo {top prevname} {
+    global headids idheads mainhead mainheadid
+
+    set name [$top.name get]
+    set id [$top.sha1 get]
+    set cmdargs {}
+    if {$name eq $prevname} {
+	catch {destroy $top}
+	return
+    }
+    if {$name eq {}} {
+	error_popup [mc "Please specify a new name for the branch"] $top
+	return
+    }
+    catch {destroy $top}
+    lappend cmdargs -m $prevname $name
+    nowbusy renamebranch
+    update
+    if {[catch {
+	eval exec git branch $cmdargs
+    } err]} {
+	notbusy renamebranch
+	error_popup $err
+    } else {
+	notbusy renamebranch
+	removehead $id $prevname
+	removedhead $id $prevname
+	set headids($name) $id
+	lappend idheads($id) $name
+	addedhead $id $name
+	if {$prevname eq $mainhead} {
+	    set mainhead $name
+	    set mainheadid $id
+	}
+	redrawtags $id
+	dispneartags 0
+	run refill_reflist
+    }
+}
+
 proc exec_citool {tool_args {baseid {}}} {
     global commitinfo env
 
@@ -9756,15 +9829,16 @@ proc headmenu {x y id head} {
     stopfinding
     set headmenuid $id
     set headmenuhead $head
-    set state normal
+    array set state {0 normal 1 normal 2 normal}
     if {[string match "remotes/*" $head]} {
-	set state disabled
+	array set state {0 disabled 1 disabled 2 disabled}
     }
     if {$head eq $mainhead} {
-	set state disabled
+	array set state {0 disabled 2 disabled}
+    }
+    foreach i {0 1 2} {
+	$headctxmenu entryconfigure $i -state $state($i)
     }
-    $headctxmenu entryconfigure 0 -state $state
-    $headctxmenu entryconfigure 1 -state $state
     tk_popup $headctxmenu $x $y
 }
 
-- 
2.1.4
