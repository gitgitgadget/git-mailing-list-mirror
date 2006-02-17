From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] Use --refid option even when sending a cover mail
Date: Fri, 17 Feb 2006 03:07:27 +0100
Message-ID: <20060217020727.12978.2049.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 03:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9v24-0003h1-Uj
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 03:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWBQCHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 21:07:31 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBQCHa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 21:07:30 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:36303 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750929AbWBQCH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 21:07:29 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060217020728.JPLQ12400.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 03:07:28 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id A20F016BE;
	Fri, 17 Feb 2006 03:07:27 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16320>

StGIT used to just ignore the --refid option when sending a cover
mail. With this patch, it will send the cover mail as a reply to the
mail identified by the refid, and the patch emails as replies to the
cover mail as usual.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 stgit/commands/mail.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b3b7b49..975f8c9 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -199,6 +199,9 @@ def __build_cover(tmpl, total_nr, msg_id
=20
     headers_end =3D __build_address_headers(options)
     headers_end +=3D 'Message-Id: %s\n' % msg_id
+    if options.refid:
+        headers_end +=3D "In-Reply-To: %s\n" % options.refid
+        headers_end +=3D "References: %s\n" % options.refid
=20
     if options.version:
         version_str =3D ' %s' % options.version
