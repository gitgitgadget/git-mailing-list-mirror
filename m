From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 27/28] Minor testsuite fix.
Date: Fri, 21 Mar 2014 08:32:05 +0100
Message-ID: <1395387126-13681-28-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxy-00035m-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbaCUHdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:44 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:55955 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964776AbaCUHdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:41 -0400
Received: by mail-la0-f47.google.com with SMTP id y1so1371620lam.20
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uJ9QIFiq92rEAHSJb3UkHo9RauiA6iTSE285zdNemUY=;
        b=CWJrxs4x4bQWlnbM73BzG7FmG4CtgvQLRPG2ZnfphjQ5bbeh4BMJPPe5IGQUG7tUfE
         zysSWlEHBfMnsC0bl0Wkn6o1jCv2XT65JIx3YNY2o0cwE6lU7W1/NTQng7BHTE+oedj5
         1/fS8kJ0T9gmU5TICcgmbUdGrTbcFLKXZ3Ypd6NkTHSN0klWTWU6j+/R5RlctTLdyDAL
         b9VxYV3mO2EO2qkKLBihi7g0wp/ZXpAq5ZNOAMrzuUrAi4Su31y9lWhnFi31TAEuYowH
         VW+JX6HYbCYiTF900/475ZkFK2sWmnQisvWZFE35rJpjaX9ty2542hn0F0sgzx2wzt5/
         v1fg==
X-Gm-Message-State: ALoCoQndjPSMB7Px6ySjyth+sTqSbRPHc/h7LjEx2p+6SmNCHejyLLHXvItGXnwFOG5h2gkAXYwh
X-Received: by 10.153.11.163 with SMTP id ej3mr32748028lad.17.1395387220641;
        Fri, 21 Mar 2014 00:33:40 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244655>

Fix remove_topic() in t-061.sh so that it doesn't print a git hash.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-061.out | 1 -
 regression/t-061.sh  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/regression/t-061.out b/regression/t-061.out
index ef0f335..60ad56d 100644
--- a/regression/t-061.out
+++ b/regression/t-061.out
@@ -381,7 +381,6 @@ ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
 ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
 % guilt pop -a
 No patches applied.
-ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
 % git checkout guilt/master
 Switched to branch "guilt/master"
 % guilt pop -a
diff --git a/regression/t-061.sh b/regression/t-061.sh
index a9a4fea..b573885 100755
--- a/regression/t-061.sh
+++ b/regression/t-061.sh
@@ -15,7 +15,7 @@ old_style_branch() {
 
 remove_topic() {
 	cmd guilt pop -a
-	if git rev-parse --verify --quiet guilt/master
+	if git rev-parse --verify --quiet guilt/master >/dev/null
 	then
 		cmd git checkout guilt/master
 	else
-- 
1.8.3.1
