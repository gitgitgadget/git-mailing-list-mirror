From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v2 0/4] git-gui blame: use textconv
Date: Tue,  8 Jun 2010 15:49:14 +0200
Message-ID: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 15:49:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzBZ-0003Ii-Bt
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0FHNtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:49:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35896 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164Ab0FHNtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 09:49:35 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o58DfsGh021024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Jun 2010 15:41:54 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o58DnYDY027950;
	Tue, 8 Jun 2010 15:49:34 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o58DnYR4013637;
	Tue, 8 Jun 2010 15:49:34 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o58DnYKb013636;
	Tue, 8 Jun 2010 15:49:34 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Jun 2010 15:41:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o58DfsGh021024
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148668>

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

Cl=C3=A9ment Poulain (4):
  sha1_name : creation of get_sha1_with_context
  cat_file : add textconv support
  git gui blame : add textconv support
  test textconv support for cat-file

 builtin/blame.c              |    8 ++--
 builtin/cat-file.c           |   32 +++++++++++++++++--
 cache.h                      |   11 ++++++
 git-gui/git-gui.sh           |   28 ++++++++++++++++-
 git-gui/lib/blame.tcl        |   21 +++++++++++-
 git-gui/lib/diff.tcl         |    5 ++-
 git-gui/lib/option.tcl       |    1 +
 sha1_name.c                  |   30 +++++++++++++++---
 t/t8007-cat-file-textconv.sh |   70 ++++++++++++++++++++++++++++++++++=
++++++++
 9 files changed, 190 insertions(+), 16 deletions(-)
 create mode 100755 t/t8007-cat-file-textconv.sh
