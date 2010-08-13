From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/10] More test suite prerequisite cleanup
Date: Fri, 13 Aug 2010 20:40:03 +0000
Message-ID: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok145-0007V9-3Y
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab0HMUkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:40:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab0HMUks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:40:48 -0400
Received: by wwj40 with SMTP id 40so3432822wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=maanl9MyR17keXE/sqMJTsZtmtRf6/XZCHqBYiJjch8=;
        b=r3wXtno1AQPGTIxzbJwNLDWyNxGK9XGSuL3PPSENnaxWbGpjpdPulspS300shWMbv0
         yYxPc0F9fLxw0xkMPbRrIt7nYKCdh/Xr6IByoEuYGxssT4X4TohYm0/xKo4Be7ZmYVt2
         xmbVLPYBy1LEzdWVqlLmW2Tv9vudQ4y6mdlJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dk6yy7o3zZARy+BEScyYgzppd8wy9dfqcvapFqyzM8+hD0Ydc6+z+TSGtCxz3wg4aA
         fDd8UfFurdvpfHTgMeQZFgGXgPMDT7rrNVmi38qrQgzae61X0CtxOhMxbgXOsvOaasVD
         ZO9AaL1YrsCZsSt73AfZuvXrCR6sZk4X7OFwI=
Received: by 10.216.188.209 with SMTP id a59mr125004wen.87.1281732047167;
        Fri, 13 Aug 2010 13:40:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.40.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:40:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153497>

This series:

  * Moves the FILEMODE prerequisite test to lib-prereq-FILEMODE.sh
  * Continues the skip_all=3D* -> test prerequisite work. The patches t=
o
    t/t9001-send-email.sh are in three parts for easier reviewing.
  * Adds a PERL prerequisite to tests that had an undeclared
    dependency on Perl via the -p switch.

This should take care of all the low hanging fruit skip_all=3D* wise,
what's left now either needs test-lib changes (the external tests), or
is a bit more hairy like the SVN, CVS and HTTP tests.

With this series these are the files still using skip_all=3D*:
   =20
    $ ack -l skip_all=3D *sh
    gitweb-lib.sh
    lib-cvs.sh
    lib-git-svn.sh
    lib-httpd.sh
    t0202-gettext-perl.sh
    t1509-root-worktree.sh
    t5540-http-push.sh
    t5541-http-push.sh
    t5550-http-fetch.sh
    t5551-http-fetch.sh
    t5561-http-backend.sh
    t9119-git-svn-info.sh
    t9200-git-cvsexportcommit.sh
    t9400-git-cvsserver-server.sh
    t9401-git-cvsserver-crlf.sh
    t9700-perl-git.sh
    test-lib.sh

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
  tests: Move FILEMODE prerequisite to lib-prereq-FILEMODE.sh
  t/t3701-add-interactive.sh: change from skip_all=3D* to prereq skip
  lib-patch-mode tests: change from skip_all=3D* to prereq skip
  t/t9600-cvsimport.sh: change from skip_all=3D* to prereq skip
  t/t9001-send-email.sh: Remove needless PROG=3D* assignment
  t/t9001-send-email.sh: change from skip_all=3D* to prereq skip
  t/t9001-send-email.sh: convert setup code to tests
  t/t7105-reset-patch.sh: Add a PERL prerequisite
  t/t9601-cvsimport-vendor-branch.sh: Add a PERL prerequisite
  t/t9602-cvsimport-branches-tags.sh: Add a PERL prerequisite

 t/lib-patch-mode.sh                |    5 -
 t/lib-prereq-FILEMODE.sh           |   11 ++
 t/t2016-checkout-patch.sh          |   28 +++---
 t/t3701-add-interactive.sh         |  112 ++++++++++++-------
 t/t3904-stash-patch.sh             |   10 +-
 t/t4102-apply-rename.sh            |    8 +--
 t/t4129-apply-samemode.sh          |    8 +--
 t/t6031-merge-recursive.sh         |    6 +-
 t/t7105-reset-patch.sh             |   16 ++--
 t/t9001-send-email.sh              |  209 +++++++++++++++++++++-------=
--------
 t/t9200-git-cvsexportcommit.sh     |    6 +-
 t/t9600-cvsimport.sh               |   39 +++----
 t/t9601-cvsimport-vendor-branch.sh |   24 +++--
 t/t9602-cvsimport-branches-tags.sh |   28 +++---
 14 files changed, 282 insertions(+), 228 deletions(-)
 create mode 100644 t/lib-prereq-FILEMODE.sh

--=20
1.7.2.1.338.gf2379
