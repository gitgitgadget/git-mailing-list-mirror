From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: simplify __gitcomp test helper
Date: Mon, 22 Oct 2012 03:39:01 +0200
Message-ID: <1350869941-22485-3-git-send-email-felipe.contreras@gmail.com>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ6zN-00083d-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764Ab2JVBjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2012 21:39:18 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64203 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2JVBjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:39:18 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1798769wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=t4ST6xz6LybD+u29sfGddNxowVBB3C9HcGnUfq2+3vY=;
        b=CMzHC+fxqgVz5qGAMWydObXhJjsNlEH5P5D4D1X6EPrVcMiGNqRjdaUmKD379pnj64
         UHd8m5nBAo4okmzRd1blLG7DDx6YCJGQR1IPDTb3sWoQ63FqdlWW8anOhfaF9xhMuz+k
         4duRl8h6iQi+FEtri9WrdLrZ5IL9umJSCzRpc66to4Yi0IQBXe/OOC0g0a9ugnN0tt1+
         ZeRIZ4jV2mCOFQIAvM8bnQZ/nAkCjD1CGFAbFvn9AGoo8wpmvcIGGWsezwr/8b49h1Y0
         qEmimW+oEEMkwZivIquwvRzRi1danYst0I+Q9ElWUbB0HGsS2/1VEofDenS0+XHZFrMe
         RCRQ==
Received: by 10.216.205.233 with SMTP id j83mr2416811weo.117.1350869957458;
        Sun, 21 Oct 2012 18:39:17 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id a10sm19107394wiz.4.2012.10.21.18.39.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:39:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208168>

By using print_comp as suggested by SZEDER G=C3=A1bor.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1c6952a..2e7fc06 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -74,15 +74,12 @@ newline=3D$'\n'
=20
 test_gitcomp ()
 {
+	local -a COMPREPLY &&
 	sed -e 's/Z$//' > expected &&
-	(
-		local -a COMPREPLY &&
-		cur=3D"$1" &&
-		shift &&
-		__gitcomp "$@" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
+	cur=3D"$1" &&
+	shift &&
+	__gitcomp "$@" &&
+	print_comp &&
 	test_cmp expected out
 }
=20
--=20
1.8.0
