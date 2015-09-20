From: larsxschneider@gmail.com
Subject: [PATCH v6 0/7] git-p4: add support for large file systems
Date: Sun, 20 Sep 2015 22:26:20 +0200
Message-ID: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCP-0003Z3-3v
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbbITU0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 16:26:31 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35008 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbbITU0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:30 -0400
Received: by wicge5 with SMTP id ge5so91307391wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bARZd8VIftGJnV7mVYwIZcg9X2DpYphELRn0aYbZdsk=;
        b=pFC2Ya5lsG3nVkrYrhReI/7qPxgd1k0phu0p77gBl3DU9ZgoHtP0eDbP4XKMybTdn7
         UILBQepn/Wk45V0uK8lOktVAi/GhZ1SrmjZBeF5+XIdIewQQyXref7K89rWqKJjyAU8d
         TprDjN73VIuv4fyIazJB1p0yEqlugJhIZiRXHl4i39L33039BMAEw8fYGKyCpzcaYk60
         0ZkMAtthTgO//e6im4FnUxFKHtjDGYL3usbO2IowaNlYTvIfJYOY1dXw9vANEyl+/9GW
         D5lRUW1nzYTpOI/TjxEGqt6znvDnH14MA5n3YdqzswksVGeMif6yTfbvvxLQz74HfsB4
         YgpQ==
X-Received: by 10.180.12.145 with SMTP id y17mr9896603wib.83.1442780789845;
        Sun, 20 Sep 2015 13:26:29 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278262>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v5:
* remove superfluous flush call (thanks Luke!)
* keep &&-chain intact in test cases (thanks Luke, Junio and Eric!)
* add mock LFS test case for deleting files (thanks Luke!)
* add mock LFS test case for git-p4.largeFileExtensions option
* add Luke's ACK to commit "git-p4: add optional type specifier to gitConfig reader" (thanks Luke!)
* replace substring extraction in test case ... "${VAR:X:Y}" only works in bash, "$(echo "$VAR" | cut -cX-Y)" works in sh

Cheers,
Lars

Lars Schneider (7):
  git-p4: add optional type specifier to gitConfig reader
  git-p4: add gitConfigInt reader
  git-p4: return an empty list if a list config has no values
  git-p4: add file streaming progress in verbose mode
  git-p4: check free space during streaming
  git-p4: add support for large file systems
  git-p4: add Git LFS backend for large file system

 Documentation/git-p4.txt   |  32 +++++
 git-p4.py                  | 278 ++++++++++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 170 ++++++++++++++++++++++++++
 t/t9824-git-p4-git-lfs.sh  | 288 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 751 insertions(+), 17 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh
 create mode 100755 t/t9824-git-p4-git-lfs.sh

--
2.5.1
