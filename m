From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 2/2] gitk: add an option to enable sorting the "Tags and heads" view by ref type
Date: Wed,  9 Mar 2016 13:18:10 -0500
Message-ID: <1457547490-12249-3-git-send-email-rappazzo@gmail.com>
References: <1457547490-12249-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Mar 09 19:18:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adigl-0002Xq-DN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933653AbcCISSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:18:22 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34721 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933612AbcCISSR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:18:17 -0500
Received: by mail-yw0-f196.google.com with SMTP id f6so3085420ywa.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfESeTMAHd1fcPhowo6craDRyBZ1Ul07Ubdlo8tnygI=;
        b=OjeCTNvdF+/HBzlku4qbgPZdi2c1UywYDKoNs1NNOhIWHZV7vdkZLDZf+8sfSwz+QI
         mcAImjinBVfPmO0htVZq+zGO/LaBzO0PBLLRZAJjZQ7BcvwfyDUhNspRA9lvBOEh9B1I
         Xvvr1+HgJMxXdxh81DWrHzKV1YuzOuFUBxSd8NdtDQEcxe0jqTuMHtvcQVi52wgo52+K
         +tHmilZYp8NUa76SzzEuRtq11tI/P25aLOUBzPdJJyEC+XnpPvs6b9OMxw6Nx1wW4r27
         Ldqktc2QqY0hACluqq1JmzuaacQmBMe8BDrPqUdKeCkno7hSZtFiFdAdXhtmoNQrbAVA
         KBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lfESeTMAHd1fcPhowo6craDRyBZ1Ul07Ubdlo8tnygI=;
        b=VapxtpNuGwFvHAcD+ocz+TGTUfjlgMsrGjW/hu0S/3Qjq2qfcReO5q1cPnNAKiFWhS
         9hN2MKfmUEAuPkU+tADXoSW5Dkkkyp1pm+B+MQmgve/oe5nqYVPRcHUa1cWGENDBymWa
         gUej7j+7AWA70PULHEX3tjsyNGFjLUr7qviztrSNOqM1SMvXGJUMCBFO3G1nAOB9fdlu
         IUEpFZpx4gytTvEP+xixSo3CtZQXFEJpFoBEkMtSVnpt6q6rHYQSYMeoRsCFWq4G6o7Y
         QYVa8s/HQZ4HwzaBoaxOIOyn4dq6ILlsrBv/J5zDP2b6FTxprQH0Uzyy9pY8LP+36R3s
         SJyw==
X-Gm-Message-State: AD7BkJIgnOOutEpClpRqf2WB2qophALxrnIKuDha3ZoRhtDUElx3sEI7easHDQV8ok8X3w==
X-Received: by 10.129.88.69 with SMTP id m66mr19236311ywb.332.1457547496639;
        Wed, 09 Mar 2016 10:18:16 -0800 (PST)
Received: from MRappazzo-8.infor.com (pool-100-35-119-77.nwrknj.fios.verizon.net. [100.35.119.77])
        by smtp.gmail.com with ESMTPSA id o185sm2561964ywb.9.2016.03.09.10.18.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 10:18:16 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457547490-12249-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288545>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 32fbc50..c933233 100755
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
2.7.2
