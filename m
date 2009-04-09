From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] support "in-tree attributes" for git-archive
Date: Thu,  9 Apr 2009 17:01:27 +1000
Message-ID: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 09 09:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LroI6-0004Yc-S1
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 09:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbZDIHBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 03:01:41 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZDIHBl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 03:01:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:2112 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZDIHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 03:01:40 -0400
Received: by wf-out-1314.google.com with SMTP id 29so498805wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=kzDI5zkv50yvL7pSsNWMBI3IpngH8OLd+/IV6C8yo9E=;
        b=fLH08vhkX+Z6GwFR6PgYqp/6xkQfEs+di0+WkpEz6FJs4tkyQUOHNbaWYf4velvO9N
         OhcM5JGO+PdOtF+3D35t9uZCl+qPmYBysLZ544sHdxyy7gqwRM2b5SSni2qNAriZ1ICX
         p0CeCrMRKQLRb9k1MXUSZW62sVjVa4caCHocA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I2I3IHZvrKDtcNz+DUvg1fdQ3EFERaoXVw3SjN+mHntQwp8xVM78+lcir1K2WbV14H
         ZV4cFXC3dhzKJHnnTB7EI9xSYuTI0NfYava9aPCRcpyLRAGJe/COFDNY+9ON1J2oHIBm
         j4OQcnMvhdUthOlzbXMK+AqU7autpTSpT69fg=
Received: by 10.142.156.2 with SMTP id d2mr771293wfe.64.1239260499886;
        Thu, 09 Apr 2009 00:01:39 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 29sm4011281wfg.13.2009.04.09.00.01.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 00:01:39 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Apr 2009 17:01:33 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116141>

The series has been shortened to 3 patches by keeping the old codepath,
just adding the index for attr.

--fix-attributes is added for old behaviour.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  archive: add shortcuts for --format and --prefix
  attr: add GIT_ATTR_INDEX "direction"
  archive: do not read .gitattributes in working directory

 Documentation/git-archive.txt |    9 +++++++--
 archive.c                     |   26 ++++++++++++++++++++++++--
 archive.h                     |    1 +
 attr.c                        |    4 +++-
 attr.h                        |    3 ++-
 builtin-tar-tree.c            |    5 +++++
 t/t5000-tar-tree.sh           |   28 ++++++++++++++++------------
 7 files changed, 58 insertions(+), 18 deletions(-)
