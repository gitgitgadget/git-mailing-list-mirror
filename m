From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 03/28] Added test case for "guilt delete -f".
Date: Fri, 21 Mar 2014 08:31:41 +0100
Message-ID: <1395387126-13681-4-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxL-0002BU-9b
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287AbaCUHdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:22 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:47577 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaCUHdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:04 -0400
Received: by mail-la0-f46.google.com with SMTP id hr17so1364955lab.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QN6hPd3Rc30veOLYyCGGn45TY8WBzgcClELFOmMFVn8=;
        b=Nh37yjYIR5Bs+JkjMhq21aDsceWoXkEKMq8JeQJWotmQk9toVKOsFpPoJGegfFkPEQ
         t4HRTYCZFn1tUa6+WTeVOyiU+PzNYki8jNG/PWoTEpTz9xySbIXOersHs6Lo9YYOPj5t
         veUo4uI83Vg1VSTZtiv1U9H0vPFix7bnEfnUALgsz5OaDTlown5YLys1Nz4YrQBnSBZp
         D/liiXdK2rNTMLBrvYYor8OViVFqq1ruzDgk7aCO/FMUU/2ZWOG4wW4OMEcQvCuCG+uF
         A+AjUrz9qjIbweqwQXi8P1HQiOoo15e1l2jTBZHDXifd3QsEAlBb32DDZaC9j8KkAczG
         b40Q==
X-Gm-Message-State: ALoCoQlwrDGW3cuetbeCEZy7kCQgvVdJZ+SSBsCOnDxvamPFihgWIcKSYdwZufvtcUC8PiQLvWnZ
X-Received: by 10.112.47.3 with SMTP id z3mr9099905lbm.34.1395387183155;
        Fri, 21 Mar 2014 00:33:03 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244648>

Ensure that the file really is deleted.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-026.out | 15 +++++++++++++++
 regression/t-026.sh  |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/regression/t-026.out b/regression/t-026.out
index 3b9fb14..be50b48 100644
--- a/regression/t-026.out
+++ b/regression/t-026.out
@@ -29,3 +29,18 @@ f 7848194fd2e9ee0eb6589482900687d799d60a12  .git/patches/master/series
 f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt new delete-me
+% guilt pop
+All patches popped.
+% guilt delete -f delete-me
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7848194fd2e9ee0eb6589482900687d799d60a12  .git/patches/master/series
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
diff --git a/regression/t-026.sh b/regression/t-026.sh
index 0ccdf85..e25d0df 100755
--- a/regression/t-026.sh
+++ b/regression/t-026.sh
@@ -20,4 +20,7 @@ cmd guilt delete add
 
 cmd list_files
 
-# FIXME: test delete -f
+cmd guilt new delete-me
+cmd guilt pop
+cmd guilt delete -f delete-me
+cmd list_files
-- 
1.8.3.1
