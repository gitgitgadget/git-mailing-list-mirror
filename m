From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 1/2] gitk: alter the ordering for the "Tags and heads" view
Date: Fri, 18 Mar 2016 14:51:36 -0400
Message-ID: <1458327097-92126-2-git-send-email-rappazzo@gmail.com>
References: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Mar 18 19:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzUy-0001lE-3s
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbcCRSvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:51:45 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34184 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbcCRSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:51:43 -0400
Received: by mail-yw0-f194.google.com with SMTP id f6so10958654ywa.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yy4kZ24sJ4ZI8LnWNMhuemhY6xjylt4cTTc061HOL4Y=;
        b=b6P1Q/sll+M3A77zlFwMIq/dF8wrpBxwFiiOd9X3/ZAThZvWgo3GZPrSD7M4N4bc6Y
         Lh0VYFsThd7/4dSmvOhWzRptBDIrkH0DNxb930jwpZct/oqxsNbq6ZCi2wdBid1/O2Xv
         A8EVCvxX4TqkNfgt4JvJ1stgHT1cN/2bWLcV+Q3nufotwkPIvYD4EZyHK9n8TywYJ4lU
         o0Q71oyzLq9Lh4/ikfRGjDA00eLlzYtmw183YGl3/gzeKcuah+FaO0ohAoayMogPk1cX
         JfJe/JxFwVHVjsks2/2ZGqsnAg+vm6J0jWvvLV2yCKx7YZcmp2xQivPx6CH4PKAPp5Gq
         1tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yy4kZ24sJ4ZI8LnWNMhuemhY6xjylt4cTTc061HOL4Y=;
        b=c2JijZg82lp9/g01MZxSN7cji3mRG3+bMtVHJ+viPpSKundylbUS66pFJ0Tq2bTVwC
         SaN7IqJC+ZTYKajGbNyoNW/i7/fKLFsYoU+vmFH9fguQfB0x3cp7F6IDKVtkgBY89k6A
         /TU9UYgNcJRuq8h4pFcn24F5nzMLp/XuiH1Le3zvjUH5t1E9kgTGTInybBf6Aw6tantB
         4COy+xGFfJe7NYog/qwZ5nVT4mnuwddfXk6lwjiue1Fw0+HUP1vCyV26jYuhrEuF+3SR
         uxLTsGn//jGENhe3xjz0a7gno6cYoYyz+OiCpUz29dzJw3/xrWqsfktgjFsqEPHpk6Fh
         bfJQ==
X-Gm-Message-State: AD7BkJL7H4RqIaX1SkbQAk92w4+m3JeBjtq5FsOUBEc3rY3PKTmbgSE73jRXIcS58NlxBg==
X-Received: by 10.129.21.213 with SMTP id 204mr7593381ywv.70.1458327102194;
        Fri, 18 Mar 2016 11:51:42 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id t123sm9204599ywe.4.2016.03.18.11.51.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 11:51:41 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289243>

In the "Tags and heads" view, the list of refs is globally sorted.
Because of this, the list of local refs (heads) can be interrupted by the
list of remote refs.  This change re-orders the view to be: local refs,
remote refs tracked by local refs, remote refs, tags, and then other refs.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 5f1255c..d6d3136 100755
--- a/gitk
+++ b/gitk
@@ -9933,35 +9933,71 @@ proc refill_reflist {} {
     global curview
 
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
-    set refs {}
+    set localrefs {}
+    set remoterefs {}
+    set locally_tracked_remote_refs {}
+    set tagrefs {}
+    set otherrefs {}
     foreach n [array names headids] {
-	if {[string match $reflistfilter $n]} {
+	if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
 	    if {[commitinview $headids($n) $curview]} {
-		lappend refs [list $n H]
+		lappend localrefs [list $n H]
+		catch {set remote_name [exec git config --get branch.$n.remote]}
+		if {$remote_name ne ""} {
+		    catch {set remote_ref [exec git config --get branch.$n.merge]}
+		    set remote_ref [string map {"refs/heads/" ""} $remote_ref]
+		    set locally_tracked_remote_ref "remotes/$remote_name/$remote_ref"
+		    set upstream_exists ""
+		    catch {set upstream_exists [exec git rev-parse --verify $locally_tracked_remote_ref]}
+		    if {$upstream_exists ne ""} {
+			if {[lsearch $locally_tracked_remote_refs [list $locally_tracked_remote_ref H]] < 0} {
+			    lappend locally_tracked_remote_refs [list $locally_tracked_remote_ref H]
+			}
+		    }
+		}
 	    } else {
 		interestedin $headids($n) {run refill_reflist}
 	    }
 	}
     }
+    set locally_tracked_remote_refs [lsort -index 0 $locally_tracked_remote_refs]
+    set localrefs [lsort -index 0 $localrefs]
+
+    foreach n [array names headids] {
+	if {[string match "remotes/*" $n] && [string match $reflistfilter $n]} {
+	    if {[commitinview $headids($n) $curview]} {
+		if {[lsearch $locally_tracked_remote_refs [list $n H]] < 0} {
+		    lappend remoterefs [list $n H]
+		}
+	    } else {
+		interestedin $headids($n) {run refill_reflist}
+	    }
+	}
+    }
+    set remoterefs [lsort -index 0 $remoterefs]
+
     foreach n [array names tagids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $tagids($n) $curview]} {
-		lappend refs [list $n T]
+		lappend tagrefs [list $n T]
 	    } else {
 		interestedin $tagids($n) {run refill_reflist}
 	    }
 	}
     }
+    set tagrefs [lsort -index 0 $tagrefs]
+
     foreach n [array names otherrefids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $otherrefids($n) $curview]} {
-		lappend refs [list $n o]
+		lappend otherrefs [list "$n" o]
 	    } else {
 		interestedin $otherrefids($n) {run refill_reflist}
 	    }
 	}
     }
-    set refs [lsort -index 0 $refs]
+    set otherrefs [lsort -index 0 $otherrefs]
+    lappend refs {*}$localrefs {*}$locally_tracked_remote_refs {*}$remoterefs {*}$tagrefs {*}$otherrefs
     if {$refs eq $reflist} return
 
     # Update the contents of $showrefstop.list according to the
-- 
2.7.4
