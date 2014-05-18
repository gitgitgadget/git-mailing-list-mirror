From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 27/33] Minor testsuite fix.
Date: Mon, 19 May 2014 00:00:03 +0200
Message-ID: <1400450409-30998-28-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:12:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Jl-0000H1-LD
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbaERWM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:12:26 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59706 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbaERWMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:12:25 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so3463680lbv.3
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MKIm+UwqYET/6tJk5Y/Mid84RIh44VKh5L5h/Cl9ro=;
        b=Mn4gh+ibZj8yG/o6SbgMJlfNWycOmA/5btTLLpZzHKAs71sq94Vs8CVadTCaSUoqrI
         YsQOBQcDFYl2Js44EpMvoX/4DeZQcsT/GWXm0SDiicJSczrr3CwvHszSISHseZ1iAaqw
         uxbWeP1kMCre4TorA207dw5uW3Ww8xraaz8/9vh55bGvS5RtsEbIU0gOi8aeuWeOGfvj
         KsdPAAiXCkcx/kH3FNh7o34zu7aVKTCwKFlLpq4zaN3zlUxkNpAHoYu5Dex2SUUoKOwd
         NGp5+SnM0dKF9/LsqV84PIxtTZ1NpCJAaKK8GcVkkhfpiR7+56rBdM9noQA0xSiV5HF/
         IC7Q==
X-Gm-Message-State: ALoCoQnt8FNSHzz6ufgg4X6nlTtaK6UQdpMc9NJp79BmLI36Y/kdQyK3YOCZJaHjnTEVvtLuo4b+
X-Received: by 10.112.14.5 with SMTP id l5mr22194222lbc.12.1400451144311;
        Sun, 18 May 2014 15:12:24 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.12.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:12:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249542>

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
