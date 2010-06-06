From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [RFC/PATCH 0/4] git-gui blame: use textconv
Date: Sun,  6 Jun 2010 13:30:44 +0200
Message-ID: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, drizzd@aon.at, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 13:31:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLE59-0005re-GU
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 13:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793Ab0FFLbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 07:31:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52851 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab0FFLbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 07:31:50 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o56BO71w030374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 13:24:07 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o56BVgxX007111;
	Sun, 6 Jun 2010 13:31:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o56BVg86008004;
	Sun, 6 Jun 2010 13:31:42 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o56BVgV1008001;
	Sun, 6 Jun 2010 13:31:42 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Jun 2010 13:24:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o56BO71w030374
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148513>

This patch adds support of textconv to git-gui blame. It is based on th=
e work already done here: http://mid.gmane.org/1275562038-7468-1-git-se=
nd-email-axel.bonnet@ensimag.imag.fr, and uses a git-gui patch done by =
Clemens Buchacher (http://mid.gmane.org/20100415193944.GA5848@localhost=
) which adds textconv support to git-gui diff.

git-gui blame is based on cat-file to get the content of the file in di=
fferent revisions. So the patch adds textconv support to cat-file.

After a discussion with Jeff King and Matthieu Moy, it appears that cre=
ating a context cache is a good way to know the pathname of the concern=
ed blob, as textconv needs a pathname to work. The first part of the pa=
tch adds this cache

Cl=C3=A9ment Poulain (4):
  sha1_name: creating context cache
  textconv: support for cat-file
  git-gui: use textconv filter for diff and blame
  t/t8007: test textconv support for cat-file

 builtin/blame.c              |    8 ++--
 builtin/cat-file.c           |   24 ++++++++++++++-
 cache.h                      |    8 +++++
 git-gui/git-gui.sh           |   28 +++++++++++++++++-
 git-gui/lib/blame.tcl        |   18 ++++++++++-
 git-gui/lib/diff.tcl         |    5 ++-
 git-gui/lib/option.tcl       |    1 +
 sha1_name.c                  |   19 ++++++++++++
 t/t8007-cat-file-textconv.sh |   66 ++++++++++++++++++++++++++++++++++=
++++++++
 9 files changed, 168 insertions(+), 9 deletions(-)
 create mode 100755 t/t8007-cat-file-textconv.sh
