From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/5] am: improve test coverage and touch up foreign patch parsing
Date: Mon, 15 Jun 2015 19:08:08 +0800
Message-ID: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:08:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SFz-0002h2-A2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbbFOLIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:08:42 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36467 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbFOLIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:08:41 -0400
Received: by pabqy3 with SMTP id qy3so63538007pab.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=L/EGoUXDB3X/LejMWzcxfpdaJFU9ip3Se5o70khYUt0=;
        b=lQXvATcp3MnIbtonzHljrNhlGrvY0b/rUcZFcmPIlY3zfKzFXMX3R2V3yhzt8gCHhN
         h2L3gvWboSdeIjXG1IfTJrf+F54k7Mag8kGjZzKecs6+MLNVfN5qnNhDL5b278jjcuTx
         4yL5agIH7sW7INidQuwxSTLRkbXVuvhQgb6jpBpvFL57FDSurTIEKc55n5udm8roiOid
         VN6H0qfaItaYZMrRkbCieA2mKf2elTS/HESeg7DFC3NkR1Y7mWybCiOfc6/V3eFJjdVp
         g8LuQS8o1llp0MKXqHJtFwCD5pPPnYNR75c1nDhxzysUK9lHDR9clUywt2L5HD+co9CJ
         iH9A==
X-Received: by 10.66.230.168 with SMTP id sz8mr48483708pac.4.1434366521366;
        Mon, 15 Jun 2015 04:08:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jt2sm11886795pbc.21.2015.06.15.04.08.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 04:08:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271672>

This is a re-roll of [v1].

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/271053

git-am is able to parse StGit and mercurial patches. However, there are no
regression tests in the test suite for these patch formats, and there are some
small bugs as well:

* the mercurial and stgit patch parsers does not support reading from stdin

* the mercurial patch parser parsed the patch date wrongly and git-am is thus
  unable to reconstruct the exact commit.

Some patches are based on Chris' patch series[1], which I've credited accordingly.

[1] http://thread.gmane.org/gmane.comp.version-control.git/256502


Paul Tan (5):
  t4150: test applying StGit patch
  am: teach StGit patch parser how to read from stdin
  t4150: test applying StGit series
  am: use gmtime() to parse mercurial patch date
  am: teach mercurial patch parser how to read from stdin

 git-am.sh     | 12 +++++----
 t/t4150-am.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 5 deletions(-)

-- 
2.1.4
