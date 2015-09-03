From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: add support for large file systems
Date: Thu,  3 Sep 2015 18:35:44 +0200
Message-ID: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXUT-0000Ah-2L
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbbICQfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:35:53 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35343 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbICQfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:35:52 -0400
Received: by wicge5 with SMTP id ge5so80040577wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mbLKoXOVcri6+BfTPYaxyCs6JGQkpIfWlqkFAI1B5OY=;
        b=z7U3KJN53I82OVq96sOTpmxVMZS3CjGWPzkLZL58BeKCkZAS+0YqHAuPZ7SFTietsU
         03wZXG+O0ldUEbzNBqClJDULm4NOt6NOJA8dht6VBdZ0MlI5c6C9IUhidOsTpCVMZDXb
         wGVAZG3gREkGgnFkC4hOkW7eZlf6+m6jeTxo8t/tkj5LPD8INNdAY0lmazgIlPrZI5Cq
         U8z3l6NWoWCqUX6qJ+k8mMliesTMMRTLltknSoQA+oHvfnEOTtjZHa+WETcHxqOR0xRf
         bCTX65qEA3KLd4xWTFaj07PVnKyvT7CpZzHLooaEro+a5b+nsKrFwPLZ9Gbr97cbmN+K
         OcSw==
X-Received: by 10.194.117.133 with SMTP id ke5mr52796730wjb.116.1441298151233;
        Thu, 03 Sep 2015 09:35:51 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id sd14sm20446876wjb.36.2015.09.03.09.35.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 09:35:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277222>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v1:

Fixed:
* simpler makedirs
* remove temp file if git-lfs command failed
* fix typos
* remove uneccessary sub shell for (git lfs help)
* make TC not dependable on hashes

Thanks Luke for the feedback!

Added:
* new gitConfigInt function
* support for generic large file systems based on gitattributes
* check compressed file size

Cheers,
Lars

Lars Schneider (4):
  git-p4: add optional type specifier to gitConfig reader
  git-p4: add gitConfigInt reader
  git-p4: return an empty list if a list config has no values
  git-p4: add support for large file systems

 Documentation/git-p4.txt |  21 ++++
 git-p4.py                | 147 +++++++++++++++++++++++---
 t/t9823-git-p4-lfs.sh    | 263 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 418 insertions(+), 13 deletions(-)
 create mode 100755 t/t9823-git-p4-lfs.sh

--
1.9.5 (Apple Git-50.3)
