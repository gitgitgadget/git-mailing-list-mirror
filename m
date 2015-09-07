From: larsxschneider@gmail.com
Subject: [PATCH v3 0/5] git-p4: add support for large file systems
Date: Mon,  7 Sep 2015 14:21:13 +0200
Message-ID: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQP-00007U-21
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbIGMVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:21:24 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33063 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbbIGMVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:23 -0400
Received: by wiclk2 with SMTP id lk2so86962116wic.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Url21SrioRaJuKDPObC6O1f7TmpMe5evv7d8Iq4oAKE=;
        b=vhDjJ3jCriraRFBsrgngKE+VGN3SlAaZHFtn4Mmfx6E+FYL9JGCOArqAKG78LDz+ke
         AWwS0ao6jPP2AhmgvFfkeNSpJ0fWDRLK/h8Z6WaCXZ/OnLpygFIZFdOggrqI0nkspMKy
         JISN1UmPw++H52XIMH50do0pSq9wgtbaqAPwYfkVPRO37uwfOjyWWDvSMCDFeE2IKhcV
         lplEITY4oMkLT+Vk+OpfR9bhdbtrWunz9dcLLPLabRlVk/mTfJ4enjevoIfOAuPtJ62a
         WnTWNXhuS2xxEltHsSrychz1XBa4z9NXE/uwXHB14oxJAKV8R8wGjtaS4hvhr9Tw2X3v
         Brgw==
X-Received: by 10.194.205.37 with SMTP id ld5mr37283117wjc.14.1441628482506;
        Mon, 07 Sep 2015 05:21:22 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277450>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v2:
* add proper commit messages
* split commits into generic large file system and GitLFS implementation
* improve docs, mention clean/smduge filter and add example for clean checkout
* fix spelling
* add option to push large files to server
* use ValueError for gitConfigInt exception
* assert required functions for large file system classes
* rename LFS to GitLFS
* add Python docs for GitLFS class
* move generic code from GitLFS class to git-p4 main code
* make variable that keeps large files for .gitattributes creation a set() to avoid duplicated entries
* sort large files in .gitattirubutes to minimize diffs between commits

Thanks to Luke and Junio for feedback!

One thing I don't like about the current implementation is that I don't see a
way to test the "git-p4.pushLargeFiles" config. I could start a git lfs server
locally but that seems a bit too much, no?

Thanks,
Lars

Lars Schneider (5):
  git-p4: add optional type specifier to gitConfig reader
  git-p4: add gitConfigInt reader
  git-p4: return an empty list if a list config has no values
  git-p4: add support for large file systems
  git-p4: add Git LFS backend for large file system

 Documentation/git-p4.txt |  28 +++++
 git-p4.py                | 187 ++++++++++++++++++++++++++++++---
 t/t9823-git-p4-lfs.sh    | 263 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 465 insertions(+), 13 deletions(-)
 create mode 100755 t/t9823-git-p4-lfs.sh

--
2.5.1
