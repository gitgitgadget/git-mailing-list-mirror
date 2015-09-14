From: larsxschneider@gmail.com
Subject: [PATCH v5 0/7] git-p4: add support for large file systems
Date: Mon, 14 Sep 2015 15:26:27 +0200
Message-ID: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTmO-0002Po-Ul
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbbINN0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:26:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36277 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbINN0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:26:39 -0400
Received: by wicgb1 with SMTP id gb1so141850592wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=aAqhG44xtSlvMB92IwzgX46Oly9ZgmrTUKi0QUpBuco=;
        b=ZsDNtcUi+AhAbbSdvMCRmCHMa/plUXE3xt1OTiEPOoJU8HT93Hn1tsZmYGF1y/6Htw
         TVUdGZcWKZQSmC8ZELfsVvVps1NtymqZdmcMIvqpvpCIqiqjzsedVTwUjwO/aP9n6e2o
         cDqNxtxva35N8TfR4TIUJ3b/6HP86u4AZxHTqK+KK2FQmpAAHpM1kkZZiJKnvoHihjmv
         f3VXZTFLwU6tUs/c+KQ8KgX+cRuh5XEnIHr0PdYBx2gVnriibW/ZK+zTU4UHU7rDgsbz
         4A0jN2rnF9vbfWLE12MbEmsJpjksKyeWqphmzGshHYxHMYDT/G0SGPK42gFNiriGvBQy
         yz0A==
X-Received: by 10.180.103.70 with SMTP id fu6mr27134223wib.9.1442237197227;
        Mon, 14 Sep 2015 06:26:37 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.26.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:26:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277820>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v4:
* Add streaming progress in verbose mode.
* Add check for free disk space.
* Remove the limitation that no .gitattribues must be present.
* Refactor large file system classes. The base implementation does not assume a ".gitattributes mechanism" anymore.
* Throw error if the large file system is used with 'git p4 submit'. Add warning in the docs, too.

Thanks to Junio and Luke feedback!

Lars Schneider (7):
  git-p4: add optional type specifier to gitConfig reader
  git-p4: add gitConfigInt reader
  git-p4: return an empty list if a list config has no values
  git-p4: add file streaming progress in verbose mode
  git-p4: check free space during streaming
  git-p4: add support for large file systems
  git-p4: add Git LFS backend for large file system

 Documentation/git-p4.txt   |  32 +++++
 git-p4.py                  | 279 ++++++++++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh |  96 +++++++++++++++
 t/t9824-git-p4-git-lfs.sh  | 288 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 678 insertions(+), 17 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh
 create mode 100755 t/t9824-git-p4-git-lfs.sh

--
2.5.1
