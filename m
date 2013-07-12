From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/2] open() error checking
Date: Fri, 12 Jul 2013 10:58:34 +0200
Message-ID: <cover.1373618940.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 10:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxZBi-0003OQ-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 10:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab3GLI6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 04:58:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23325 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441Ab3GLI6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 04:58:39 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:35 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:36 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230186>

#1 is Dale's suggested change.  Dale, to include it we'd need your
Signed-off-by as per Documentation/SubmittingPatches.

#2 is a similar error-checking fix; I reviewed 'git grep "\bopen\b"'
and found one case where the return value was obviously not tested.
The corresponding Windows code path has the same problem, but I dare
not touch it; perhaps someone from the Windows side can look into it?

I originally had a four-patch series to open 0/1/2 from /dev/null, but
then I noticed that this was shot down in 2008:

  http://thread.gmane.org/gmane.comp.version-control.git/93605/focus=93896

Do you want to resurrect this?

The worst part about it is that because we don't have a stderr to rely
on, we can't simply die("stop playing mind games").


Dale R. Worley (1):
  git_mkstemps: correctly test return value of open()

Thomas Rast (1):
  run-command: dup_devnull(): guard against syscalls failing

 run-command.c | 5 ++++-
 wrapper.c     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.8.3.2.998.g1d087bc
