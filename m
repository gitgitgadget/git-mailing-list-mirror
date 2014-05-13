From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 27/29] Minor testsuite fix.
Date: Tue, 13 May 2014 22:31:03 +0200
Message-ID: <1400013065-27919-28-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSo-0000O3-0e
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbaEMUiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:38:02 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:52852 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbaEMUiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:38:00 -0400
Received: by mail-la0-f48.google.com with SMTP id mc6so714598lab.7
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MKIm+UwqYET/6tJk5Y/Mid84RIh44VKh5L5h/Cl9ro=;
        b=Q6bCgHuFTUtUE6X+qCO9m2dAh+8C+7z8JIpAiUVVH05CWMn0TXB9zaDJFSaX9u9e3O
         fsUe6C555L1eeg0WOxdTXLCIFlL5ag0jEknXF9L9pzGo/yQeBI4TjK/5jXqzG+a17FY4
         lF0sEPCwKOpne3rOvtEy5C+5cs/RTWLclvBM/3H0JH0oz/XKnPnKjh7JF4o0saqg7zQy
         8tExIMnCIl4st1MjQ4MXGAw4E3gI0hWFgkf84ZgzBHkfd1sTnf88lzpKeoHyCPsvZvF/
         TCFBq2+0Zq+s6qbRNIr/El6+kmlcwExq7xb24mYPMOCahGMb4QHvbC7LVU6pJEXufhoC
         KvcQ==
X-Gm-Message-State: ALoCoQkIvqlnCKk9Vv9tQJnhaxupHVjDCkzoXPWkq6LyViHDScFSOhAYSKpqG1db3vfLnqIDHDAr
X-Received: by 10.152.6.131 with SMTP id b3mr19661189laa.9.1400013479209;
        Tue, 13 May 2014 13:37:59 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248844>

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
