From: Jon Seymour <jon.seymour@gmail.com>
Subject: Unexpected merge results in git-svn repo
Date: Wed, 31 Jul 2013 20:14:57 +1000
Message-ID: <CAH3AnrqmFJxuy7PyJZS83VEwzrQB+mA5Frttd5fzKBhpZGP4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 31 12:15:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4TQv-00044j-ME
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 12:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103Ab3GaKPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 06:15:00 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:63938 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab3GaKO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 06:14:59 -0400
Received: by mail-la0-f45.google.com with SMTP id fj20so355256lab.32
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=g6s2MwNk8HmnubiAJrOOnO9NBntlTc391yLJW/9UdTY=;
        b=nULYorDFyEeT8C6uZV4DjW+K58dQJLxun4xMDh7Q112tx+KsRakWBo4+khFzHHjOdZ
         4fFBKGbuGxh3+x3qMbfocEUWhhOmZwOdiFqt+fEC+1A8D9T66ZpVvQw3kYcE3ZRIMLXo
         zld92q/CncC+2ODL8dii4lVCuZVY+4s2+wTtiMPcerll13msH9u21c7EllXmrW/iNJ6X
         yCq09lgGiS7iS2kA9UYg+55d95leQvbGIp/+vNZBl2iFGTGAyCJNp4rhQ3sqSaI76XS8
         qziEC//EaVWvZisPA/Sdq2bkR8fB44JMrM7SOYlUApg23E8g5d4fToxFeGYUzsvdkL1l
         xYbA==
X-Received: by 10.152.87.81 with SMTP id v17mr30467382laz.1.1375265697392;
 Wed, 31 Jul 2013 03:14:57 -0700 (PDT)
Received: by 10.114.4.99 with HTTP; Wed, 31 Jul 2013 03:14:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231414>

I am getting some unexpected results from a merge and I'd like to
understand why.

I have two commits X and Y that I want to merge.

git merge-base X Y # yields B
git diff B X -- F  # is empty
git diff B Y -- F  # contains the change I want merged
git rev-list X ^B -- F # is empty
git rev-list Y ^B -- F # contains one commit

git checkout X
git merge Y

fails with fixable merge conflicts on other files, but uses X's copy
of F instead of Y's.

I was expecting it to use Y's copy of F, since only Y has modified F since B.

What could cause this?

BTW: I am using a git-svn repo that does have some 4+ parent merges in it.

jon.
