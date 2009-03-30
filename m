From: David Aguilar <davvid@gmail.com>
Subject: (unknown)
Date: Sun, 29 Mar 2009 22:03:40 -0700
Message-ID: <1238389428-69328-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9h5-0004he-EH
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZC3FEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZC3FD7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:03:59 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZC3FD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:03:58 -0400
Received: by qyk16 with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DsF6gK0t9FYrJBaH7lbr8XIUMuIhv06vtsLgFF+T0is=;
        b=TfpAaiMSecW3HnCj+VQ5VWb10c1Um3uEo3tOpvL4PHgn7uxJ1o5ROsfGuVoFJMnxvO
         HydJyRaLRAT4ZBjSWYv8ZVZJ8q7jcFC8CAfeQUVOQcxItsA1kBifHWBXGAjGMghwxoTd
         WFHvfv9aMtccUg9dvoucGYMC47TcskfVM3c3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X00kA0aW9rAFKj+gqcP4gqPdctRe/552PE7aiIW+1WvJDd2VgHwqG9H0BULAYY2g02
         t0MzD2bHyl7MWdd/fmz6Mu+KH/7XSAJlen3ntKC+zUreJ6585C4VAu/VPWzk/ocsocaX
         WOJGlbExk7XD/AQteg+a7sYyiOh/v0B4QwfLE=
Received: by 10.224.19.197 with SMTP id c5mr5659538qab.24.1238389436193;
        Sun, 29 Mar 2009 22:03:56 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm4615776qwf.0.2009.03.29.22.03.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:03:55 -0700 (PDT)
Subject: 
X-Mailer: git-send-email 1.6.2.1.404.gb0085
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115069>

As promised, here is the patch series that removes the duplicate
code between git-difftool and git-mergetool.

This is based on top of Junio's "pu" branch and is a
continuation of the recent difftool series.

I created a new git-sh-tools shell lib for holding the
common functions.  If anyone thinks I should have placed the
functions in git-sh-setup instead then just let me know.

Here's a total diffstat.  If it wasn't for the documentation
and replacing the mixed spaces/tabs with all-tabs in
git-mergetool then we would have seen a lot more
happy removals.

 .gitignore                     |    1 +
 Documentation/git-sh-tools.txt |   52 ++++
 Makefile                       |    1 +
 command-list.txt               |    1 +
 git-difftool-helper.sh         |  112 +-------
 git-mergetool.sh               |  639 ++++++++++++++++------------------------
 git-sh-tools.sh                |  181 ++++++++++++
 7 files changed, 506 insertions(+), 481 deletions(-)

GIT:
From: David Aguilar <davvid@gmail.com>
Subject: Refactor git-{diff,merge}tool to remove duplicate code
In-Reply-To: 
