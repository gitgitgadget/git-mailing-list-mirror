From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH] git svn dcommit : new option --interactive
Date: Sun,  4 Sep 2011 21:21:51 +0200
Message-ID: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, normalperson@yhbt.net, jaysoffian@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0IIm-0004PL-9G
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab1IDTYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 15:24:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36078 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1IDTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:24:04 -0400
Received: by wyh22 with SMTP id 22so3135966wyh.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5t+7WQznGg7aXAGFLs+9VJ401Fv+drs7bbLWIfeiMtI=;
        b=miKjsMkWPdmS3c22dFr0fagkgc2KMIEaV/C+w6oXsaeFRQG8t2bTR6nOH+NzKKX7u/
         DfC9cTVcZpouf02jPDuLnloOyGo7ToO5EcVnCaiHnezM5k3V4kvBX8Dn+8wQh5tn98dI
         US19uONx8HDkm6Ew10EOUvlscm2Ccb6OBylpU=
Received: by 10.216.203.79 with SMTP id e57mr1704746weo.42.1315164243495;
        Sun, 04 Sep 2011 12:24:03 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id et17sm5825074wbb.0.2011.09.04.12.24.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 12:24:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.447.gb9176
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180698>

I use git svn daily, at work, and it is so useful that I started using it to
track some files which are not supposed to find their way up to the SVN
server.
For instance, it may be useful to 'git add & commit' some reference data
files, refactor some code, check against the data files, git commit, ..., then discard
commits with data files.
This way, it is very easy to monitor the functional changes in your code.

Unfortunately, it may happen that I forget to remove useless commits, and 'git
svn dcommit' everything ... forever.

These 2 patches add a --interactive option to 'git svn dcommit', which provides
an interactive mode, similar to git-send-email.

 Documentation/git-svn.txt              |    8 ++++
 git-svn.perl                           |   71 +++++++++++++++++++++++++++++++-
 t/t9160-git-svn-dcommit-interactive.sh |   64 ++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletions(-)
