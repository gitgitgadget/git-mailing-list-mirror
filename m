From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 03/29] Added test case for "guilt delete -f".
Date: Tue, 13 May 2014 22:30:39 +0200
Message-ID: <1400013065-27919-4-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:32:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJNZ-0008Qf-NO
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbaEMUcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:32:47 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:59499 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbaEMUch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:37 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so700651lab.25
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feFFMhScDRe/a+FC4wabr67+e68FNjSy+P3KVS7PS1c=;
        b=EL155su2ARcPlr3GUz/RtixjYttvl5OlCEOwWzzndgk8SIGaMDAy8tSyp1vZJy8PEX
         PYrb3X8uU1h/mBpqz0gkMPPicuHB9w9SdVb06eI0uHqUEcg+rooykSlOvHbSQaE3vfob
         2LZH1bctZ1GZP62MfAyFXXcfs6V48uLaToN144TTcHR00e71xmzPxL8ecizofDKutD/H
         sEF25Qo2M4/0j+KG3ap7lvce07R8e2VlB9cSLcDeqJCddo95oAL3yCiOK/L7+vN5fYpT
         Fn6F25ZrKbayf2EEIpezpbj5mPHd6BQSR6zkCSlBXxJz3OMTtMtKOfDfqZYl52hv+Mi0
         nOEw==
X-Gm-Message-State: ALoCoQn448I0obTQd2ZfFC1yvyPN3U9pz0Ne9j6c2KyMInxJ11RG5TY8W4T6VxRr9JZdD/BjbTWf
X-Received: by 10.112.199.234 with SMTP id jn10mr29997918lbc.8.1400013155215;
        Tue, 13 May 2014 13:32:35 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248818>

Ensure that the file really is deleted.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
