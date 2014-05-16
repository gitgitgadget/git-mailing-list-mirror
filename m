From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 27/31] Minor testsuite fix.
Date: Fri, 16 May 2014 16:46:14 +0200
Message-ID: <1400251578-17221-28-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:56:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJYp-0003HR-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbaEPO41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:56:27 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:49917 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaEPO4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:56:24 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so2002332lbv.7
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MKIm+UwqYET/6tJk5Y/Mid84RIh44VKh5L5h/Cl9ro=;
        b=CBgdQVXyPVTD/HippX3R+zmwvJe9klSVXYPlK2lDwRcAZqIxA2oHsS9d2glGfyaatL
         H2SVccBhQZMnH6GQGQDT6WPWEXeJt6KF/MUmVzu47iNBseeiB4NMIDU5QdYCDArsuFAw
         7il/zZ5vgz+v1oNEZ94bSLRkvruEVZm0nlrIT7xBJU5N/EoeMqKyt4xggjR8KJ9rb+rW
         83V+h2kNGull9Tldvo1YSapFsqU36WninRukp7y/Uun0bwYmblTXuaVL9mZ0c4B08V/m
         316TCOkBg07Dq4S+h68MOgC3HDBe2pc3lZjbf48RJREQcnJzM84m6o8LmO4Ki4nLYg+5
         jLrQ==
X-Gm-Message-State: ALoCoQkIc66vIYqQ/t44Di/M7QHjOSHLBH0oTLpW0xS3YugDbPN1MTwh0kZOFat9mKbVwWmH08Wm
X-Received: by 10.112.189.138 with SMTP id gi10mr11786771lbc.15.1400252182433;
        Fri, 16 May 2014 07:56:22 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.56.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:56:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249336>

Fix remove_topic() in t-061.sh so that it doesn't print a git hash.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
index 6192f1b..db26e12 100755
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
