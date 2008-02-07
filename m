From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/resend] cvsimport: have default merge regex also match
	beginning of commit message
Date: Thu, 7 Feb 2008 09:36:10 +0000
Message-ID: <20080207093610.13624.qmail@82d44ea3a00d55.315fe32.mid.smarden.org>
References: <20080201131514.1979.qmail@4264665dc6742b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3Bt-0001T7-Ub
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933AbYBGJf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2008 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYBGJfz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:35:55 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53449 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757040AbYBGJfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:35:51 -0500
Received: (qmail 13625 invoked by uid 1000); 7 Feb 2008 09:36:10 -0000
Content-Disposition: inline
In-Reply-To: <20080201131514.1979.qmail@4264665dc6742b.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72916>

The default value of @mergerx uses \W, which matches a non-word
character; this means that commit messages like "Merging FOO" are not
matched by default; using \b, which matches a word boundary, instead of
\W fixes that.

This change was suggested by Fr=E9d=E9ric Bri=E8re through
 http://bugs.debian.org/463468

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 5694978..9516242 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -164,7 +164,7 @@ if ($#ARGV =3D=3D 0) {
=20
 our @mergerx =3D ();
 if ($opt_m) {
-	@mergerx =3D ( qr/\W(?:from|of|merge|merging|merged) (\w+)/i );
+	@mergerx =3D ( qr/\b(?:from|of|merge|merging|merged) (\w+)/i );
 }
 if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
--=20
1.5.4
