From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/2] New 'stage' command
Date: Sun,  5 Apr 2009 16:48:49 +0300
Message-ID: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 15:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqSkG-0004wg-3x
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZDENtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754678AbZDENtI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 09:49:08 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:42988 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZDENtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 09:49:07 -0400
Received: by bwz17 with SMTP id 17so1527786bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=giwmdbT394CkbRm7+c4nR6Z6vUq3ZMhVw51H7t1Bsd8=;
        b=EtO44+7SlE9lvQeO1lWA/IAF7pX9WPFqjue8q2MoTcx0UnxTsX051Ey2HVKqEsQoYF
         P0+oMCYhURfL0oYx/ceVOOE+kdS4cJnAfuzc9NRc3XTDMe69ihMaEs+OXooTVxCZRrGT
         gmrFGTaTtk1vAXE95spu95Jw1VMgkTyI1jBmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=p/VVyIP8Q2g90d4Zn7xt+dJzTURyCBgifWcsmw+/ze42P42XXG+wcP0mcW1eF8NuvT
         ouB8r0x83Qyyp+THLbRoWKoQoMslQoPYwziAS4usVOETFoJIgIBCyVxT420h7bMSkUoO
         VR0NhPZXG9yhGQcyERAiXCUrZBwLS5mtJ2qkI=
Received: by 10.223.123.210 with SMTP id q18mr535976far.63.1238939342344;
        Sun, 05 Apr 2009 06:49:02 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id g28sm1827034fkg.18.2009.04.05.06.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 06:49:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.406.g45db3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115666>

Hi,

The 'stage' is probably the most novel-yet-missunderstood feature of git, and
somehow the user interface is not exploiting it properly, even to the point
where it doesn't even have a consistent name (stage, index, cache, etc)

This patch series is one approach that has been working reasonably well for me,
which is to replace the 'git stage' command to map different actions that can
be executed with it.

For example 'git stage diff' is more natural (at least to me) than 'git diff
--cached', same goes for 'git stage rm foo.c' vs 'git rm --cached foo.c'.

This is the list of actions I've mapped:

 * add: git stage = git stage add (git add)
 * rm: (git rm --cached)
 * diff: (git rm --cached)
 * import: stage all files; modified, deleted, new
 * ls: (git ls-files --stage)

Felipe Contreras (2):
  git: remote stage
  Add new 'git stage' script

 Documentation/git-stage.txt |   19 -------------------
 Makefile                    |    2 +-
 git-stage.sh                |   28 ++++++++++++++++++++++++++++
 git.c                       |    1 -
 4 files changed, 29 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/git-stage.txt
 create mode 100644 git-stage.sh
