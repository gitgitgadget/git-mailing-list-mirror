From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 0/3] git-svn: Add support for cherry-pick merges
Date: Thu, 28 Nov 2013 10:52:14 -0500
Message-ID: <1385653937-29595-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 16:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm3t0-0004kl-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 16:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab3K1PwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 10:52:09 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:52555 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab3K1PwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 10:52:07 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so14725278iec.13
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KahNkXBKK9k1KhZFxVcdZA1TgN66hwKjTowB+AHuM4s=;
        b=yE/l9rn1orA5xq5ZzMo7x65AuLW2vcf8AGercL3dBXssIpcVIvzjWwJrQEKFicysD0
         X+RN6QPLD1uDz9YeFgjUL23lTr4G8Rr7Imqry2WoZMyP1t2xVMTnpozIZbyjFk1ogaPV
         5YSMA2rS9TkDWkIGdMj+5ibNemX34yvPDWQloDE7OovbnDYzJ9nCcguhAsun0XbUPOj+
         IJbq63XhaCZVaRvKiUTMB+mUAnORkvBrexhNyo17f8PQWZUkfyKx2zsjne6ZpM6PxyfB
         BE74ctCdYRgP+NJygroGoWtHlsQ4O73Slf1eOd+GM8nDg6rIpDJwrVRXhRXet1z0K+7S
         /rFw==
X-Received: by 10.43.49.1 with SMTP id uy1mr9900577icb.48.1385653926286;
        Thu, 28 Nov 2013 07:52:06 -0800 (PST)
Received: from zanarkand.local (24-212-191-132.cable.teksavvy.com. [24.212.191.132])
        by mx.google.com with ESMTPSA id qi3sm45309190igc.8.2013.11.28.07.52.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2013 07:52:04 -0800 (PST)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238497>

This is a work-in-progress for adding support for cherry-pick merges.

When using git-svn, cherry-picked commits from another git-svn branch are now
being treated as simple commits. But in SVN, if the user uses "svn merge -c" to
cherry-pick commits from another SVN branch, SVN records that information in
svn:mergeinfo. These patches will enable git-svn to do the same.

Andrew Wong (3):
  git-svn: Generate mergeinfo for every commit
  git-svn: Support cherry-pick merges
  git-svn: Add config to control the path of mergeinfo

 git-svn.perl                      | 79 ++++++++++++++++++++++++++++++++++-----
 perl/Git/SVN/Editor.pm            |  5 ++-
 t/t9161-git-svn-mergeinfo-push.sh | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 10 deletions(-)

-- 
1.8.5.rc3.5.g96ccada
