From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Prevent force updating of the current branch
Date: Sat, 20 Aug 2011 14:49:47 -0700
Message-ID: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 23:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QutQw-0003vE-KS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1HTVuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 17:50:07 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37483 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab1HTVuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 17:50:05 -0400
Received: by iye16 with SMTP id 16so7812235iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uKpFCLLbtHu+IRBTBzBVfG0vtwgnOvJHL3Ex22guCo0=;
        b=IIPbJz1cmUvgDrJjyCPQ2dvjrxYZHpBE/T0uE5k11B/7vILQlfbT1nCGHKtnr9gcsd
         S7ZLOcKjIsvMM/pmEMRTFrE4mBqR+jjqTa2BXYH3QN1WZxAyb1mWhkDf3iG/LBx/z+XK
         BanJrLZdGUUVqCg/8Xyl1RDoie33L5SG1QT38=
Received: by 10.231.6.99 with SMTP id 35mr2028094iby.7.1313877004951;
        Sat, 20 Aug 2011 14:50:04 -0700 (PDT)
Received: from localhost.localdomain (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id v16sm2391221ibe.51.2011.08.20.14.50.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 14:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.562.g0b2d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179783>

I noticed when trying to improve the user-experience of creating
ambiguous branches [1] that there are insufficient checks to safeguard
git-branch -M and git-checkout -B from over-writing the current branch.

Conrad

[1] http://thread.gmane.org/gmane.comp.version-control.git/179503

---
 branch.c                   |   34 ++++++++++++++++++++++++----------
 branch.h                   |    8 ++++++++
 builtin/branch.c           |    6 +-----
 builtin/checkout.c         |   12 +++---------
 t/t2018-checkout-branch.sh |   17 +++++++++++++++++
 t/t3200-branch.sh          |   12 ++++++++++++
 6 files changed, 65 insertions(+), 24 deletions(-)
