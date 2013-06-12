From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 29/31] git-remote-mediawiki: Add a .perlcriticrc file
Date: Wed, 12 Jun 2013 17:43:46 +0200
Message-ID: <1371051828-12866-30-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnDw-0007CJ-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab3FLPo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:44:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47564 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab3FLPoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiJRM015751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:19 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiL3h015106;
	Wed, 12 Jun 2013 17:44:21 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu6E014096;
	Wed, 12 Jun 2013 17:44:21 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 17:44:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227626>

Such a file allows to configure perlcritic.
Here, it is used to remove many unwanted rules and configure one to
remove unwanted warnings.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/.perlcriticrc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 contrib/mw-to-git/.perlcriticrc

diff --git a/contrib/mw-to-git/.perlcriticrc b/contrib/mw-to-git/.perlc=
riticrc
new file mode 100644
index 0000000..5a9955d
--- /dev/null
+++ b/contrib/mw-to-git/.perlcriticrc
@@ -0,0 +1,28 @@
+# These 3 rules demand to add the s, m and x flag to *every* regexp. T=
his is
+# overkill and would be harmful for readability.
+[-RegularExpressions::RequireExtendedFormatting]
+[-RegularExpressions::RequireDotMatchAnything]
+[-RegularExpressions::RequireLineBoundaryMatching]
+
+# This rule says that builtin functions should not be called with pare=
ntheses
+# e.g.: (taken from CPAN's documentation)
+# open($handle, '>', $filename); #not ok
+# open $handle, '>', $filename;  #ok
+# Applying such a rule would mean modifying a huge number of lines for=
 a
+# question of style.
+[-CodeLayout::ProhibitParensWithBuiltins]
+
+# This rule states that each system call should have its return value =
checked
+# The problem is that it includes the print call. Checking every print=
 call's
+# return value would be harmful to the code readabilty.
+# This configuration keeps all default function but print.
+[InputOutput::RequireCheckedSyscalls]
+functions =3D open say close
+
+# This rules demands to add a dependancy for the Readonly module. This=
 is not
+# wished.
+[-ValuesAndExpressions::ProhibitConstantPragma]
+
+# This rule is not really useful (rather a question of style) and prod=
uces many
+# warnings among the code.
+[-ValuesAndExpressions::ProhibitNoisyQuotes]
--=20
1.8.3.rc3.18.g21a7b2c
