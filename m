From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] for-each-ref: Allow a trailing slash in the patterns
Date: Thu, 28 Aug 2008 04:14:02 +0200
Message-ID: <20080828021402.GA18049@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYX35-0002HD-SX
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYH1COJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 22:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYH1COI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:14:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:36262 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751432AbYH1COH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:14:07 -0400
Received: (qmail invoked by alias); 28 Aug 2008 02:14:04 -0000
Received: from i577BBA0C.versanet.de (EHLO atjola.local) [87.123.186.12]
  by mail.gmx.net (mp035) with SMTP; 28 Aug 2008 04:14:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18+Ww9Ru3s+l/IDZO8Wi7GMfur8hZFc8viq31QNta
	L8ShtUWqEI2DBh
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94015>

More often than not, I end up using something like refs/remotes/ as the
pattern for for-each-ref, but that doesn't work, because it expects to =
see
the slash in the ref name right after the matched pattern. So teach it =
to
accept the slash as the final character in the pattern as well.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 builtin-for-each-ref.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 4d25ec5..21e92bb 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -652,7 +652,8 @@ static int grab_single_ref(const char *refname, con=
st unsigned char *sha1, int f
 			if ((plen <=3D namelen) &&
 			    !strncmp(refname, p, plen) &&
 			    (refname[plen] =3D=3D '\0' ||
-			     refname[plen] =3D=3D '/'))
+			     refname[plen] =3D=3D '/' ||
+			     p[plen-1] =3D=3D '/'))
 				break;
 			if (!fnmatch(p, refname, FNM_PATHNAME))
 				break;
--=20
1.6.0.1.90.g27a6e.dirty
