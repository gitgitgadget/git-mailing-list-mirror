From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 6/6] git-p4: view spec documentation
Date: Mon,  2 Jan 2012 18:05:54 -0500
Message-ID: <1325545554-16540-7-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhqz5-0006tN-1r
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab2ABXH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:07:59 -0500
Received: from honk.padd.com ([74.3.171.149]:43670 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:07:58 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id BC1361C7E;
	Mon,  2 Jan 2012 15:07:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8FB82313FA; Mon,  2 Jan 2012 18:07:54 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187849>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f97b1c5..84f5b91 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -230,12 +230,7 @@ git repository:
 
 --use-client-spec::
 	Use a client spec to find the list of interesting files in p4.
-	The client spec is discovered using 'p4 client -o' which checks
-	the 'P4CLIENT' environment variable and returns a mapping of
-	depot files to workspace files.  Note that a depot path is
-	still required, but files found in the path that match in
-	the client spec view will be laid out according to the client
-	spec.
+	See the "CLIENT SPEC" section below.
 
 Clone options
 ~~~~~~~~~~~~~
@@ -304,6 +299,27 @@ p4 revision specifier on the end:
 See 'p4 help revisions' for the full syntax of p4 revision specifiers.
 
 
+CLIENT SPEC
+-----------
+The p4 client specification is maintained with the 'p4 client' command
+and contains among other fields, a View that specifies how the depot
+is mapped into the client repository.  Git-p4 can consult the client
+spec when given the '--use-client-spec' option or useClientSpec
+variable.
+
+The full syntax for a p4 view is documented in 'p4 help views'.  Git-p4
+knows only a subset of the view syntax.  It understands multi-line
+mappings, overlays with '+', exclusions with '-' and double-quotes
+around whitespace.  Of the possible wildcards, git-p4 only handles
+'...', and only when it is at the end of the path.  Git-p4 will complain
+if it encounters an unhandled wildcard.
+
+The name of the client can be given to git-p4 in multiple ways.  The
+variable 'git-p4.client' takes precedence if it exists.  Otherwise,
+normal p4 mechanisms of determining the client are used:  environment
+variable P4CLIENT, a file referenced by P4CONFIG, or the local host name.
+
+
 BRANCH DETECTION
 ----------------
 P4 does not have the same concept of a branch as git.  Instead,
@@ -387,9 +403,7 @@ git-p4.host::
 
 git-p4.client::
 	Client specified as an option to all p4 commands, with
-	'-c <client>'.  This can also be used as a way to find
-	the client spec for the 'useClientSpec' option.
-	The environment variable 'P4CLIENT' can be used instead.
+	'-c <client>', including the client spec.
 
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -417,10 +431,10 @@ git config --add git-p4.branchList main:branchB
 -------------
 
 git-p4.useClientSpec::
-	Specify that the p4 client spec to be used to identify p4 depot
-	paths of interest.  This is equivalent to specifying the option
-	'--use-client-spec'.  The variable 'git-p4.client' can be used
-	to specify the name of the client.
+	Specify that the p4 client spec should be used to identify p4
+	depot paths of interest.  This is equivalent to specifying the
+	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
+	This variable is a boolean, not the name of a p4 client.
 
 Submit variables
 ~~~~~~~~~~~~~~~~
-- 
1.7.8.1.407.gd70cb
