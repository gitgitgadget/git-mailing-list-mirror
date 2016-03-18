From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 2/2] gitk: add an option to enable sorting the "Tags and heads" view by ref type
Date: Fri, 18 Mar 2016 14:51:37 -0400
Message-ID: <1458327097-92126-3-git-send-email-rappazzo@gmail.com>
References: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Mar 18 19:51:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzUy-0001lE-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbcCRSvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:51:47 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35689 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcCRSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:51:43 -0400
Received: by mail-yw0-f193.google.com with SMTP id d21so571234ywe.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zh1Kzaku6+RlIces34DmC6SFpOfQD3oAFv0UwtU08Ks=;
        b=k7gxuKdVht+Ez6Zqi41DLfOZH9mywXkK1N+uX9N+DRYxwUauzlXfvosumrSklJ15if
         3PRJWPMXrHw9i3KDWnn0xahLhitZ6P8dTH5oySlOj2YlEOclXDAByFvjhgAGYIAqjeRi
         Sk3yWWVpkbEyD7Z1UcG/o3CUNcSDXMiLC2XRbf/GLd2rbwwXNfnDxbquxxBl+wItbV6D
         p4i7YG4gfA5p9iFvN4aMBfcmExiAHDbllihAecU0m5M4H/NB6IDvXIabPEgJcRKTbZLm
         2lphqFTXnAa/XGxd7zordSM7TPOH+VOEVseH3jPyhjwZeqKfTYsi2Q+egHuIccKK1U7d
         9QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zh1Kzaku6+RlIces34DmC6SFpOfQD3oAFv0UwtU08Ks=;
        b=AiZV6+/xSiOYtPMXT0D/ugphuu1odmQsHvIfrXdkYGU1SIF7xZ8RtvPB9Ls116dz2s
         12F65Y4ABQIsqJFde2e37OctKFP3+eaQ3T7lzVRKNOC/Fh/VKk2oJ3kHu9lzLgjc1ko8
         2cEEfrx8WXwULkVVSR7787wTCRaa0Cy1LEXU1n99iZ6wyfe6TisOfCgfhNwTf73GnUgB
         0AZtg8oZQWvgAsPkXa2OWmnIGFTkrCe/6uC1j73+ZevQEyfYCLLVrxUfI+L1ZIv6ZnrE
         F+xvQmA/4sJ+7fM2bUljFAoNUp4oNCOg1VDuS1A4PfjcKckSCKK3111gMWwLEAYtrTEM
         MrVg==
X-Gm-Message-State: AD7BkJIDHg8V0iZ+dWUnI1M1HMKnMGrieChcuTnKR1qI5/U1RbZbrLHtnpPP/ZHu7F2oOA==
X-Received: by 10.37.21.5 with SMTP id 5mr7683549ybv.22.1458327102950;
        Fri, 18 Mar 2016 11:51:42 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id t123sm9204599ywe.4.2016.03.18.11.51.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 11:51:42 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289245>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index d6d3136..6d376e3 100755
--- a/gitk
+++ b/gitk
@@ -158,6 +158,7 @@ proc parseviewargs {n arglist} {
     global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
     global vinlinediff
     global worddiff git_version
+    global sort_refs_by_type
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -170,6 +171,7 @@ proc parseviewargs {n arglist} {
     set allknown 1
     set filtered 0
     set i -1
+    set sort_refs_by_type "0"
     foreach arg $arglist {
 	incr i
 	if {$nextisval} {
@@ -261,6 +263,9 @@ proc parseviewargs {n arglist} {
 	    "--no-replace-objects" {
 		set env(GIT_NO_REPLACE_OBJECTS) "1"
 	    }
+	    "--sort-refs-by-type" {
+		set sort_refs_by_type "1"
+	    }
 	    "-*" {
 		# Other flag arguments including -<n>
 		if {[string is digit -strict [string range $arg 1 end]]} {
@@ -9929,7 +9934,7 @@ proc reflistfilter_change {n1 n2 op} {
 }
 
 proc refill_reflist {} {
-    global reflist reflistfilter showrefstop headids tagids otherrefids
+    global reflist reflistfilter showrefstop headids tagids otherrefids sort_refs_by_type
     global curview
 
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
@@ -9998,6 +10003,10 @@ proc refill_reflist {} {
     }
     set otherrefs [lsort -index 0 $otherrefs]
     lappend refs {*}$localrefs {*}$locally_tracked_remote_refs {*}$remoterefs {*}$tagrefs {*}$otherrefs
+    if {$sort_refs_by_type ne "1"} {
+       set refs [lsort -index 0 $refs]
+    }
+
     if {$refs eq $reflist} return
 
     # Update the contents of $showrefstop.list according to the
-- 
2.7.4
