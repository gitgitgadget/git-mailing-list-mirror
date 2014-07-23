From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Wed, 23 Jul 2014 11:42:51 -0700
Message-ID: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1W5-0006Op-0C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067AbaGWSnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:43:49 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47190 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:43:48 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2035594pdb.41
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BTAHD9QnhaMgQpiMi97cxnNoHnLl87GzGuWIqKCkp14=;
        b=u6h5p9vWiGpAj/qHAEk0nhkDci36ec9s7y8u07obWw7IxZrhXGRLr0sMwLR7MPxe18
         R8EZI7wDUwKlFd3S76XinuVg99+5OL0NaN11WOYirl9ycrnInuShApmp2ot+PsazlTe6
         AXWGP43LhB6akTZEtHb38sgsASzMXGPgRWbutHdUxkQQV1qduApmxT/msjJAGyK63LJ5
         T2qcxNQL0Q8q6z3glw+hLumrB2e8ff8DhpPdWcMNIs0zrJEK56YSY82pzvjeASer/eSL
         qXoE9HCwsKwLxSFJ/F1anrCCZ6IFH5mA2+SPOT7YnoQ1z73lhsXlKfcgPMi19QDNq+I2
         kqgQ==
X-Received: by 10.66.249.71 with SMTP id ys7mr4437960pac.112.1406141027941;
        Wed, 23 Jul 2014 11:43:47 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.43.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:43:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254101>

This series builds on the top of 5def4132 (ta/config-set) in pu or topic[1]
in the mailing list with name "git config cache & special querying API utilizing
the cache".

This series aims to do these three things,

* Use the config-set API to rewrite git_config().

* Solve any legacy bugs in the previous system while at it.

* To be feature complete compared to the previous git_config() implementation,
  which I think it is now. (added the line number and file name info just for
  completeness)

Also, I haven't yet checked the exact improvements but still as a teaser,
git status now only rereads the configuration files twice instead of four
times.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/253862

Tanay Abhra (7):

 Documentation/technical/api-config.txt |  5 ++
 cache.h                                |  1 +
 config.c                               | 93 +++++++++++++++++++++++++++++++---
 t/t1308-config-set.sh                  | 17 +++++++
 test-config.c                          | 10 ++++
 userdiff.c                             | 14 ++++-
 6 files changed, 131 insertions(+), 9 deletions(-)

-- 
1.9.0.GIT
