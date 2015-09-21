From: larsxschneider@gmail.com
Subject: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Tue, 22 Sep 2015 00:41:06 +0200
Message-ID: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9m4-0000PZ-1S
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbbIUWlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:19 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36135 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbIUWlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:18 -0400
Received: by wicgb1 with SMTP id gb1so135408369wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lMJOY4YBx+8yxa7EGN1nzPUKsSjkLQTBvurNpZjcLHo=;
        b=YSCY0hmqwitgbm+ic55MrzUI6t1qA9vLeDn3bOOZi2/l7qT79+2qPNmGRVuSAZDR9I
         Ou98te6trumPg8fdWjhAI/f1MTyez9gpQQ+stUxOrsy1MQldVkGFKKtnRvVA3MSPLjQ6
         0xKN3dAewqqwKhsDHoN2ZViPKwhEAQvso49hCKPNjWFnHE7PNmD5VgTegudYey+S00rg
         0ltqco/j8dMP++fyo5QSYqkE372rqcnKzU8yr8edGbJXrj0FrsuMG9M32MttYQzmm07j
         09DbSNShr4YEwHFOa4eJECq1QkvATAwt1J2Wla0SjIGe8HluhoRxJi8ZFkrShwd0xKre
         SLDQ==
X-Received: by 10.194.205.37 with SMTP id ld5mr29260934wjc.14.1442875277204;
        Mon, 21 Sep 2015 15:41:17 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278352>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v6:
* fix spaces in .gitattributes for Git-LFS files (old "[:space:]", new "[[:space:]]")
* generated patch on top of next (95c4325) to resolve merge conflicts

I am sorry about the "[:space:]" bug this late. I had the fix in my development
branch but missed to apply it in this patch series.

@Junio:
Your conflict resolution in pu looks good. Nevertheless, I made this patch on
top of next to ease the integration. I hope this is ok.

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
