From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Wed, 26 Feb 2014 13:06:22 -0500
Message-ID: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 19:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIism-0005WB-1c
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaBZSGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:06:38 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48626 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaBZSGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:06:37 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so1014868iec.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tfia/Eui8i2EnW6Tn7IYtiDOuFNy8zInZUP52sejDv8=;
        b=Ft2RGT6G2adv/gd2NJJt82v5H9Iv62RpXr+Gp4hVaB+ttexfBBqyffNm0eBwUKPRVC
         +tYpt9D0pmg/9bszMTxYPP+eeT0iJZT4haMX6ajxOyNSDjirOAlnYZVXHGCcgzxmGAGl
         knPHwp5jcju46XudhErcz1ZGXm2JvjjgANGfnz1O4/PlZ4QCI2a9x2cNWnEaAGeeLxvX
         OkShIVolTXifj2otbvY1i3kJV+p/PEMh7AeHQQ4elrwH+vFdSUspT6GDD6dmerfBNfnh
         0CNGGHhEgoIbG5+j9WQL81K9bmwwRUYRt1eJaQtgg16yPIhM3+TzZqUT7L1xCvf/JSiR
         +Eew==
X-Received: by 10.50.137.100 with SMTP id qh4mr28537865igb.4.1393437995501;
        Wed, 26 Feb 2014 10:06:35 -0800 (PST)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id kb5sm1968331igb.1.2014.02.26.10.06.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 10:06:34 -0800 (PST)
X-Mailer: git-send-email 1.9.0.7.g53f6706
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242743>

Users may not be aware that they need to use "git merge --abort" or "git reset
--merge" to properly abort a merge conflict. They are likely to just use "git
reset", because that "usually" cleans up the repo. But in the case where the
user had local changes, "git reset" would leave the repo in a messy state where
merged changes and local changes are mixed together.

The first two patches are just about rewording a message, and adding messages
to tell users to use "git merge --abort" to abort a merge.

We could stop here and hope that the users would read the messages, but I think
git could be a bit more user-friendly. The last patch might be a bit more
controversial. It changes the default behavior of "git reset" to default to
"git reset --merge" during a merge conflict. I imagine that's what the user
would want most of the time, and not "git reset --mixed". I haven't updated the
"git reset" docs yet, I'll update it if we decide to use this new behavior.

Comments?

Andrew Wong (3):
  wt-status: Make conflict hint message more consistent with other hints
  merge: Add hints to tell users about "git merge --abort"
  reset: Change the default behavior to use "--merge" during a merge

 builtin/merge.c | 3 ++-
 builtin/reset.c | 7 ++++++-
 wt-status.c     | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.9.0.6.g16e5f9a
