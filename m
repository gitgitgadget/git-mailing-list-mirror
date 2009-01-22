From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH v3 0/3] Add support for `git archive --submodules`
Date: Thu, 22 Jan 2009 22:17:48 +0100
Message-ID: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 22:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ6y1-000087-9k
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 22:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbZAVVSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 16:18:09 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757914AbZAVVSH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 16:18:07 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:54176 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758057AbZAVVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 16:18:05 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0MLHvZk012659;
	Thu, 22 Jan 2009 22:17:57 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106788>

This series teaches read_tree_recursive() how to traverse gitlink entri=
es
when explicitly instructed to do so (by the return value from the provi=
ded
callback function) and then uses this functionallity in git-archive to
implement a basic --submodules option (as suggested by Ren=C3=A9 in
http://thread.gmane.org/gmane.comp.version-control.git/106167/focus=3D1=
06235).

The commit message of the third patch has some suggestions on how the n=
ew
feature may be extended to support more use cases - hopefully this will
cover the issues mentioned by Johannes and Junio in the same thread.

Lars Hjemli (3):
  tree.c: teach read_tree_recursive how to traverse gitlink entries
  sha1_file: prepare for adding alternates on demand
  archive.c: add basic support for submodules

 Documentation/git-archive.txt |    3 +
 archive.c                     |   53 ++++++++++++++++++-
 archive.h                     |    1 +
 builtin-ls-tree.c             |    9 +---
 cache.h                       |    1 +
 merge-recursive.c             |    2 +-
 sha1_file.c                   |   40 +++++++++-----
 t/t5001-archive-submodules.sh |  121 +++++++++++++++++++++++++++++++++=
++++++++
 tree.c                        |   28 ++++++++++
 9 files changed, 236 insertions(+), 22 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh
