From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/5] am: improve test coverage and touch up foreign patch parsing
Date: Mon,  8 Jun 2015 23:48:46 +0800
Message-ID: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:50:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zJJ-0000vA-6t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbFHPt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:49:56 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33148 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbFHPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:49:51 -0400
Received: by padev16 with SMTP id ev16so42893334pad.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3MEJT0sf2a+Rlh/8g/qD15TC7A83Ta/+qwpZcSMH9Ic=;
        b=foWs6O6zsK8fJYtkwasiA9P+1hfJK8HiE8RAx7kLJsKmf7qTtCOzP+sRWeXc61g3Sv
         q5LdD5tSKJuY8X1ZZjr1Ik9R1J3GrU6uDmVJO424wbi1MV4geqPh2ZC6HBidgZjjTK0o
         zFyK7GAirkNdItns0JFPMEGLxFRNJJKLCWX3H1bbHzxz1N1td+sZ5kJgHQ8bG9uVG5Om
         IA+Ve9om8o1Ch6FNLINCGqxzBcdOUeqk5mNQ/R1tWQfZpoDSYUWmGHaytT9y9/KPNu7z
         gf0ed8yK1EQmsSN4ueuNf+hEa150dJeyaJmTdMIP5vPZcyNYiDDv56drH9F3aLhB8sI7
         xLzQ==
X-Received: by 10.70.91.232 with SMTP id ch8mr30926308pdb.58.1433778590812;
        Mon, 08 Jun 2015 08:49:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.49.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:49:49 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271053>

git-am is able to parse StGit and mercurial patches. However, there are no
regression tests in the test suite for these patch formats, and there are some
small bugs as well:

* the mercurial and stgit patch parsers does not support reading from stdin

* the mercurial patch parser parsed the patch date wrongly and git-am is thus
  unable to reconstruct the exact commit.

Most patches are based on Chris' patch series[1], which I've credited accordingly.

[1] http://thread.gmane.org/gmane.comp.version-control.git/256502


Paul Tan (5):
  t4150: test applying StGit patch
  am: teach StGit patch parser how to read from stdin
  t4150: test applying StGit series
  am: use gmtime() to parse mercurial patch date
  am: teach mercurial patch parser how to read from stdin

 git-am.sh     | 15 ++++++-----
 t/t4150-am.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 6 deletions(-)

-- 
2.1.4
