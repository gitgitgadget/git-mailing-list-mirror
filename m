From: larsxschneider@gmail.com
Subject: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Fri, 28 Aug 2015 14:24:50 +0200
Message-ID: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org, luke@diamand.org, technoweenie@github.com
X-From: git-owner@vger.kernel.org Fri Aug 28 14:25:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVIiK-0001Nh-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 14:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbbH1MYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 08:24:55 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38427 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbH1MYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 08:24:55 -0400
Received: by wibgu7 with SMTP id gu7so7839101wib.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=f+emPsSedBU62toAlVLB5tMlu8Ch9AJDM1YZNHXWu94=;
        b=xoWqfZyi4Uhj7JKwOQZ6QJmHBdntP/Wc1N59QEJFsowm25Si2vIXI2Ht4z0RSRdHu7
         lY7ybIA7yXZUeEOuVBUlJMlOePCogL+f3l93MiGFnTrnDSR9KdpFzuWS8FTF0ji2tlh3
         PqM9dD5JbJ/dwCYx8mtYO7BoiAjv0/yro+HGqNv321ZlERmr/kaOOqwNcH+7gcmmG2sn
         7l5Ha1LV7RkH45YokYfK0lWlvipDy86tkpP+SgrFmdJ08z6H4ljh7boQoqDu2UdXdWwj
         HAsfsp+oqJtNnhdKuzn6YPqyJAP7w58GSamG72sqiKlWRn8jmrxkTwU0d5hReGUfMrvy
         r47A==
X-Received: by 10.180.86.100 with SMTP id o4mr4402463wiz.46.1440764693994;
        Fri, 28 Aug 2015 05:24:53 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d7sm3548733wiz.22.2015.08.28.05.24.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Aug 2015 05:24:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276719>

From: Lars Schneider <larsxschneider@gmail.com>

I am migrating huge Perforce repositories including history to Git. Some of them contain large files that would blow up the resulting Git repositories. This patch adds an option to store these files in Git LFS [1] on git-p4 clone.

In order to run the unit tests you need to install the Git LFS extension [2].

Known limitations:
The option "use-lfs-if-size-exceeds" looks at the uncompressed file size. Sometimes huge XML files are tiny if compressed. I wonder if there is an easy way to learn about the size of a file in a git pack file. I assume compressing it is the only way to know.

Feedback is highly appreciated.

Thank you,
Lars


[1] https://git-lfs.github.com/
[2] https://github.com/github/git-lfs/releases/

Lars Schneider (1):
  git-p4: add option to store files in Git LFS on import

 Documentation/git-p4.txt |  12 ++
 git-p4.py                |  94 ++++++++++++++--
 t/t9822-git-p4-lfs.sh    | 277 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+), 9 deletions(-)
 create mode 100755 t/t9822-git-p4-lfs.sh

--
1.9.5 (Apple Git-50.3)
