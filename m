From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 3 Feb 2008 02:01:10 +0100
Message-ID: <200802030201.10971.robin.rosenberg@dewire.com>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLTF0-0006wq-Tr
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 02:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765572AbYBCBBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Feb 2008 20:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbYBCBBG
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 20:01:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:24637 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbYBCBBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Feb 2008 20:01:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 18481800680;
	Sun,  3 Feb 2008 02:01:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ER3wDkJPsDgR; Sun,  3 Feb 2008 02:01:01 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 4044580019B;
	Sun,  3 Feb 2008 02:01:01 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72310>

l=C3=B6rdagen den 2 februari 2008 skrev Roger C. Soares:
> Changed private modifiers to default to improve perfomance and remove
> warnings of the type:
> Write access to enclosing field GitHistoryPage.hintShowDiffNow is
> emulated by a synthetic accessor method. Increasing its visibility wi=
ll
> improve your performance

I'm not fully convinced this is the right way after all. Good
performance is obviously good, but so is good encapsulation.=20
I've sometimes tried changing things like this even in pieces
of code that I really thought it should matter, but not been able
to measure any real improvemen even with performance measurment tools.

Obviously seeing that warning is annoying so maybe we should just set i=
t to
ignore or exclude it from the project settings (if that is possible). T=
he
only project where I think it might make a difference is the jgit part =
because
that is where we optimize and that is where I experimented with visibil=
ity
changes. In the Eclipse part we need to encapsulate more, partly becaus=
e=20
Eclipse is less understood by the current authors than Java in general.=
=20
Encapsulation means encapsulating bad coding and bad design that comes
from lack of understanding of the framework we are working within.

-- robin

=46rom f26deb2c14e1df7513b3954594ea09b7746fcb69 Mon Sep 17 00:00:00 200=
1
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 3 Feb 2008 01:46:33 +0100
Subject: [PATCH] Ignore warning for "Access to enclosing method/field X=
 emulated by a synthetic accessor method"

There is no measurable performance degradation from this. Increasing vi=
sibility
of methods and fields in order to get rid of this warning reduces encap=
sulation.

Instead of choosing the Ignore setting we remove the setting from the p=
roject,
which may be somwhat hackish but has the benefit that the setting can b=
e changed
in the workspace for those that wants to investigate the issue.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.=
prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
index deec031..7a0fbe4 100644
--- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -55,7 +55,6 @@ org.eclipse.jdt.core.compiler.problem.redundantNullCh=
eck=3Dwarning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=3Ddi=
sabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=3Derror
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=3Denabled
-org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=3Dwarni=
ng
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs=
 b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
index fa7a0b7..bcde160 100644
--- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
@@ -55,7 +55,6 @@ org.eclipse.jdt.core.compiler.problem.redundantNullCh=
eck=3Dwarning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=3Ddi=
sabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=3Derror
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=3Denabled
-org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=3Dwarni=
ng
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b=
/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
index 0ef7591..0a89f52 100644
--- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
@@ -55,7 +55,6 @@ org.eclipse.jdt.core.compiler.problem.redundantNullCh=
eck=3Dwarning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=3Ddi=
sabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=3Derror
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=3Denabled
-org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=3Dwarni=
ng
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs=
 b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
index 65d5c31..c203c20 100644
--- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
@@ -55,7 +55,6 @@ org.eclipse.jdt.core.compiler.problem.redundantNullCh=
eck=3Dwarning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=3Ddi=
sabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=3Derror
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=3Denabled
-org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=3Dwarni=
ng
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/or=
g.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
index 4c38185..b0c694c 100644
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -55,7 +55,6 @@ org.eclipse.jdt.core.compiler.problem.redundantNullCh=
eck=3Dwarning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=3Ddi=
sabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=3Derror
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=3Denabled
-org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=3Dwarni=
ng
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
--=20
1.5.4.rc4.25.g81cc
