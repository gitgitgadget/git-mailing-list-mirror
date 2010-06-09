From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v3 0/4] git-gui blame: use textconv
Date: Wed,  9 Jun 2010 19:02:05 +0200
Message-ID: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 19:02:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOfa-000862-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 19:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab0FIRCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 13:02:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52531 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab0FIRCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 13:02:19 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o59GsWBD032502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 18:54:32 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59H2Fnd012743;
	Wed, 9 Jun 2010 19:02:15 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59H2Fs7031762;
	Wed, 9 Jun 2010 19:02:15 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59H2FJf031761;
	Wed, 9 Jun 2010 19:02:15 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jun 2010 18:54:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59GsWBD032502
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148795>

This patch adds support of textconv to git-gui blame.

It is based on our previous work which adds textconv support to blame:
http://mid.gmane.org/1275921713-3277-1-git-send-email-axel.bonnet@ensim=
ag.imag.fr
It also uses a git-gui patch done by Clemens Buchacher which adds textc=
onv
support to git-gui diff: http://mid.gmane.org/20100415193944.GA5848@loc=
alhost.

git-gui blame is based on cat-file to get the content of the file in di=
fferent
revisions, so the patch adds textconv support to cat-file.
The first part of this patch adds get_sha1_with_context() in order to k=
now=20
the pathname of the concerned blob, as textconv needs it to work.

This third version corrects one bug and some compilation warnings

Cl=C3=A9ment Poulain (4):
  sha1_name: add get_sha1_with_context()
  textconv: support for cat_file
  git gui: use textconv filter for diff and blame
  t/t8007: test textconv support for cat-file

 builtin.h                    |    2 +
 builtin/blame.c              |    8 ++--
 builtin/cat-file.c           |   33 ++++++++++++++++++--
 cache.h                      |   11 ++++++
 git-gui/git-gui.sh           |   28 ++++++++++++++++-
 git-gui/lib/blame.tcl        |   21 +++++++++++-
 git-gui/lib/diff.tcl         |    5 ++-
 git-gui/lib/option.tcl       |    1 +
 sha1_name.c                  |   31 +++++++++++++++---
 t/t8007-cat-file-textconv.sh |   70 ++++++++++++++++++++++++++++++++++=
++++++++
 10 files changed, 194 insertions(+), 16 deletions(-)
 create mode 100755 t/t8007-cat-file-textconv.sh
