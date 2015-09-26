From: larsxschneider@gmail.com
Subject: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Sat, 26 Sep 2015 09:54:57 +0200
Message-ID: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:55:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKg-0007Hp-BF
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbbIZHzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:19 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33986 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbIZHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:17 -0400
Received: by wicfx3 with SMTP id fx3so47048729wic.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=NJwo/LuD5hgJMygliYVubSJwMQYj8ra9a+3mk9+wbnQ=;
        b=kBbnoLmEcM8YCubRO4IQPLZ87l4kh32C+u51MTloO/Q85ol5w90ewKlgMoyjEQjVyp
         4P/qwyJhOkIr5koyQOHvkH5fxrkCeUs6O21/I2Mj6KvK8CPTBnXoWYnFbhb6NF9Tm7mW
         gUFUx/ZQtI9dRHYl/8Yib7v2t7WarD0P8cTG/kL8y4xDen8HC5wgk+09v8rhK7a7sbPj
         T8bssobnpVD3ziA5qpNDDi2vDse1cpYnX5qXHEsO/6gjdrCFcY+fWTqsFtSsDu4dnodU
         U5JpM9ejnFNqSEuJV7MUkt1fPyhtyoScPCJ4+O0She+uQL1P0k2dzitozcRI2bb559Td
         uPRA==
X-Received: by 10.194.250.40 with SMTP id yz8mr12475588wjc.37.1443254116530;
        Sat, 26 Sep 2015 00:55:16 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.11
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278686>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v7:
* fix commit message line length (thanks Junio)
* fix sync command for large file system support (thanks Luke!)
* add test case for sync command
* rename git-p4.pushLargeFiles to git-p4.largeFilePush for consistency with
  other git-p4.largeFile* configs
* fix relative path handling for clone operation which caused a crash in the
  disk space check and t9819 (thanks Luke!)
* use test_path_is_missing instead of !test_path_is_file (thanks Luke!)

The patch is again based on maint (ee6ad5f) as patches v1-v6 before.

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
 git-p4.py                  | 270 +++++++++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 192 ++++++++++++++++++++++++++++++
 t/t9824-git-p4-git-lfs.sh  | 288 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 766 insertions(+), 16 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh
 create mode 100755 t/t9824-git-p4-git-lfs.sh

--
2.5.1
