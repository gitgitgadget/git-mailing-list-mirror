From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH 0/5] Sparse checkout resurrection
Date: Wed, 29 Jul 2009 16:49:09 +1000
Message-ID: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2yg-0003lG-Ug
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZG2GtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 02:49:22 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZG2GtV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:21 -0400
Received: from mail-px0-f184.google.com ([209.85.216.184]:40415 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbZG2GtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:21 -0400
Received: by pxi14 with SMTP id 14so404542pxi.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=3E5UgqtelAFrPijhhBzZax4pM1Gf0NAsAiEYjy22E6w=;
        b=ecaiz/nu6VAYJUyoLuaYBIhjo4PESqvMXz8Gn8ieGVCdetUot7OpxCFjnSVuFBzlOE
         A32yld3ygNIBbuQyxhRHzCWOqJNtGxh/rNdJUfHajkXfMCaX5JMOM0HFWpwpUHH+LNgb
         Z2l7bfSkJhxJnHY5w76pHKHTErCs1c16t6CqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=q2bI04QMPx3sNwGC5vjW6f5tz0oKXW0ctOh/Qr2j1UaCYY5/gDp0mtxgeQ38viR4Bk
         e9xU/nQVjUzJ3PmSM0zLm3DrzgcWISMlOtGbsStCm1ZSJrXuBR4kYnaAZdYCednYc5j5
         VRF8VFZ8S9PcoqlAITzW0gpxRTZm6rhV83fHQ=
Received: by 10.115.74.16 with SMTP id b16mr13253347wal.68.1248850161439;
        Tue, 28 Jul 2009 23:49:21 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id m34sm851785waf.57.2009.07.28.23.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:16 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124309>

Hi,

I rip most of the code from my sparse checkout series,
leaving only basic stuff. Now there is no CE_NO_CHECKOUT bit (CE_VALID
will be used), no sparse pattterns. You will need to provide a script,
namely "git-shape-workdir", to specify how you want to shape your
workdir. That's all. No porcelain, only plumbing. Need to add some
options to read-tree and checkout in order to enable/disable this, but
I haven't got that far.

The first four patches is more or less CE_VALID fixups. Real stuff is
in the last patch. Sparse patterns may return as a separate
script. Currently no idea how the porcelain UI should be. The only
thing that is probably impossible this way is "git clone
--sparse". You may need to "clone -n" first, then apply sparse
checkout later.

Comments?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Prevent diff machinery from examining worktree outside sparse checkou=
t
  grep: skip files outside sparse checkout area
  gitignore: read from index if .gitignore is not in worktree
  unpack_trees(): keep track of unmerged entries
  unpack_trees(): add support for sparse checkout

 Documentation/git-grep.txt         |    4 +-
 builtin-grep.c                     |    7 ++-
 builtin-read-tree.c                |    6 ++-
 cache.h                            |    4 +
 diff-lib.c                         |    5 +-
 diff.c                             |    4 +-
 dir.c                              |   70 ++++++++++++------
 t/t3001-ls-files-others-exclude.sh |   20 +++++
 unpack-trees.c                     |  140 ++++++++++++++++++++++++++++=
++++++--
 unpack-trees.h                     |    4 +
 10 files changed, 229 insertions(+), 35 deletions(-)
