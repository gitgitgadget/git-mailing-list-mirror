From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 0/3] fix git-p4 client root symlink problems
Date: Mon, 11 Mar 2013 17:45:26 -0400
Message-ID: <1363038329-20185-1-git-send-email-pw@padd.com>
References: <5139883C.6080308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mikl=C3=B3s=20Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 22:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAXg-0002bu-He
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab3CKVpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 17:45:33 -0400
Received: from honk.padd.com ([74.3.171.149]:40819 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab3CKVpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:45:32 -0400
Received: from arf.padd.com (unknown [50.55.138.130])
	by honk.padd.com (Postfix) with ESMTPSA id A408D620D;
	Mon, 11 Mar 2013 14:45:31 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A2C7F2261E; Mon, 11 Mar 2013 17:45:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.rc2.65.g92f3e2d
In-Reply-To: <5139883C.6080308@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217913>

Update from v1:

    * add SYMLINKS prerequisite to the new symlink test

Thanks Hannes.


Mikl=C3=B3s pointed out in

    http://thread.gmane.org/gmane.comp.version-control.git/214915

that when the p4 client root included a symlink, bad things
happen.  It is fixable, but inconvenient, to use an absolute path
in one's p4 client.  It's not too hard to be smarter about this
in git-p4.

Thanks to Mikl=C3=B3s for the patch, and to John for the style
suggestions.  I wrote a couple of tests to make sure this part
doesn't break again.

This is maybe a bug introduced by bf1d68f (git-p4: use absolute
directory for PWD env var, 2011-12-09), but that's so long ago
that I don't think this is a candidate for maint.

		-- Pete


Mikl=C3=B3s Fazekas (1):
  git p4: avoid expanding client paths in chdir

Pete Wyckoff (2):
  git p4 test: make sure P4CONFIG relative path works
  git p4 test: should honor symlink in p4 client root

 git-p4.py               | 29 ++++++++++++++++++++++-------
 t/t9808-git-p4-chdir.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 7 deletions(-)

--=20
1.8.2.rc2.65.g92f3e2d
