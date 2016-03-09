From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 1/2] gitk: alter the ordering for the "Tags and heads" view
Date: Wed,  9 Mar 2016 13:18:09 -0500
Message-ID: <1457547490-12249-2-git-send-email-rappazzo@gmail.com>
References: <1457547490-12249-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Mar 09 19:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adigk-0002Xq-RM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933643AbcCISSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:18:20 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34719 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933595AbcCISSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:18:16 -0500
Received: by mail-yw0-f196.google.com with SMTP id f6so3085408ywa.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EhNKMCBpDg5uiSIEMZ6DT2GI5KHe1bL29DLusr/aao8=;
        b=bR27OuL7aY9zpRb4P8jtwwFa8l5ifwbgEyNaDvvANNXKoBrQj97Zx05H+HN5ZE9Brc
         E5H6Yd/HKlogGz/U6buclDrGw22ZNWWHXg1BFLQhRWoVdsLJ0KIhBTbpu3dfv1QdYbNA
         FxkK/N0TYYb/FFqa6m31NXvM5jvSG/9wfCFrfbDkCr2Rir718HGNmtTUM+Cqf2zgX6i/
         To7htpL65m98Zzb3IjuVKSYXB09uqnBVjWkWamRVIcX2rYIq9lFVlZMxZM2+cB8jZD66
         9T0B8rsOtAAOEZ27eAVt9kMN/qzeIHQnM2RVwxq4hh1QeaofHng0j0nOvbVfpMS0Fdli
         LB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EhNKMCBpDg5uiSIEMZ6DT2GI5KHe1bL29DLusr/aao8=;
        b=KXH7Fd7kKvJAUepiyu6WOnj43fHmMDzq1ZW3HId0nN25uU6l5P1MK/JdOe9gVxaasY
         CibVdUyi2LHdCaBagJEVpxTKu1IleQrQLt34AJvlt07aFFuWKPJpBn7hInT+Lbl8SBOs
         dyoVSYM+yIuAhR+QUQ8MRgenx9TEProCSOuMrwimO2GmztBv8CJtXj6rrGGPDMf6lWD/
         IWFV1ouetyM42EY9lY8oyjCDlWQlr01n2DWtV0WaXY80AG3G/M34n/ZJdcbU/DZUXZEF
         BiGLxVLVDh1+LtG0aY9RT372dLmkXs0xLhoF3p95mSlovcHd4kSXWABdMPJcna2q283B
         DySQ==
X-Gm-Message-State: AD7BkJJglcg4gNZlaXS3X30SQcJGqTrJ1ypE7czRhgTRVkdAB5JGehobM7O2f1UPqOb7ig==
X-Received: by 10.129.0.65 with SMTP id 62mr9870499ywa.199.1457547495822;
        Wed, 09 Mar 2016 10:18:15 -0800 (PST)
Received: from MRappazzo-8.infor.com (pool-100-35-119-77.nwrknj.fios.verizon.net. [100.35.119.77])
        by smtp.gmail.com with ESMTPSA id o185sm2561964ywb.9.2016.03.09.10.18.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 10:18:15 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457547490-12249-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288546>

In the "Tags and heads" view, the list of refs is globally sorted.
Because of this, the list of local refs (heads) can be interrupted by the
list of remote refs.  This change re-orders the view to be: local refs,
remote refs tracked by local refs, remote refs, tags, and then other refs.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 5f1255c..32fbc50 100755
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
+		    catch {set exists [exec git rev-parse --verify $locally_tracked_remote_ref]}
+		    if {$exists ne ""} {
+			if {[lsearch $locally_tracked_remote_refs [list $locally_tracked_remote_ref H]] < 0} {
+			    lappend locally_tracked_remote_refs [list $locally_tracked_remote_ref H]
+			}
+		    }
+		    set exists ""
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
2.7.2
