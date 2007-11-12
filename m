From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] git-commit: Add tests for invalid usage of
	-a/--interactive with paths
Date: Mon, 12 Nov 2007 16:15:39 +0100
Message-ID: <20071112151539.GA2696@atjola.homenet>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:16:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irb16-0008I0-St
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXKLPPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 10:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXKLPPn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:15:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:35443 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751663AbXKLPPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:15:42 -0500
Received: (qmail invoked by alias); 12 Nov 2007 15:15:40 -0000
Received: from i577AF071.versanet.de (EHLO localhost) [87.122.240.113]
  by mail.gmx.net (mp049) with SMTP; 12 Nov 2007 16:15:40 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19y2rcjq5FyNsgv+fwvDFTWdc7Cz/KKiEQBBfBY5M
	ycwGxuhjocens7
Content-Disposition: inline
In-Reply-To: <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64633>

git-commit was/is broken in that it accepts paths together with -a or
--interactive, which it shouldn't. There tests check those usage errors=
=2E

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
> [Stalled]
>=20
> * bs/maint-commit-options (Mon Nov 5 20:36:33 2007 +0100) 1 commit
>  - git-commit.sh: Fix usage checks regarding paths given when they do
>    not make sense
>=20
> This is meant to go to 'maint' but needs test script to exhibit
> the existing breakage and demonstrate the fix.
>=20
> The test will help catching future regression even after we
> replace git-commit with Kristian's rewrite in C.

Sorry, didn't take your comment to that patch as a request to provide
tests. Anyway, here they are :-) I hope I got the commit message/commen=
t
formatting right this time.

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 4dc35bd..9dba104 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -34,6 +34,16 @@ test_expect_failure \
 	"git-commit -C HEAD -m illegal"
=20
 test_expect_failure \
+	"using paths with -a" \
+	"echo King of the bongo >file &&
+	git-commit -m foo -a file"
+
+test_expect_failure \
+	"using paths with --interactive" \
+	"echo bong-o-bong >file &&
+	echo 7 | git-commit -m foo --interactive file"
+
+test_expect_failure \
 	"using invalid commit with -C" \
 	"git-commit -C bogus"
=20
