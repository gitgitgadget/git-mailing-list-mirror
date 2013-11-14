From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH v2] State correct usage of literal examples in man pages in the coding standards
Date: Thu, 14 Nov 2013 18:08:45 -0500
Message-ID: <1384470525-13851-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 00:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh621-0001Na-OX
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 00:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab3KNXI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 18:08:58 -0500
Received: from mailhub249.itcs.purdue.edu ([128.210.5.249]:36199 "EHLO
	mailhub249.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939Ab3KNXI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 18:08:56 -0500
Received: from megahurtz.wl.stjohn.lcl (41.117.244.66.bay.smithvilledigital.net [66.244.117.41])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAEN8nxH032554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Nov 2013 18:08:55 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237881>

The man pages contain inconsistent usage of backticks vs. single quotes
around options, commands, etc. that are in paragraphs. This commit states
that backticks should always be used around literal examples.

This commit states that "--" and friends should not be escaped
(e.g. use `--pretty=oneline` instead of `\--pretty=oneline`).

This commit also states correct usage for typesetting command usage
examples with inline substitutions.

Thanks-to: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Stuart Rackham <srackham@gmail.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
This is a resubmit of a previous patch:
http://marc.info/?l=git&m=138431653412495&w=2

I added a Thanks-to for Stuart Rackham because he's listed as the author of the
AsciiDoc User Guide, which part of this commit relies heavily on.


 Documentation/CodingGuidelines | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a600e35..ef67b53 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -260,9 +260,11 @@ Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
- conventions.  A few commented examples follow to provide reference
- when writing or modifying command usage strings and synopsis sections
- in the manual pages:
+ conventions.
+
+ A few commented examples follow to provide reference when writing or
+ modifying command usage strings and synopsis sections in the manual
+ pages:
 
  Placeholders are spelled in lowercase and enclosed in angle brackets:
    <file>
@@ -312,3 +314,29 @@ Writing Documentation:
    Use 'git' (all lowercase) when talking about commands i.e. something
    the user would type into a shell and use 'Git' (uppercase first letter)
    when talking about the version control system and its properties.
+
+ A few commented examples follow to provide reference when writing or
+ modifying paragraphs or option/command explanations that contain options
+ or commands:
+
+ Literal examples (e.g. use of command-line options, command names, and
+ configuration variables) are typeset in monospace, and if you can use
+ `backticks around word phrases`, do so.
+   `--pretty=oneline`
+   `git rev-list`
+   `remote.pushdefault`
+
+ Word phrases enclosed in `backtick characters` are rendered literally
+ and will not be further expanded. The use of `backticks` to achieve the
+ previous rule means that literal examples should not use AsciiDoc
+ escapes.
+   Correct:
+      `--pretty=oneline`
+   Incorrect:
+      `\--pretty=oneline`
+
+ If some place in the documentation needs to typeset a command usage
+ example with inline substitutions, it is fine to use +monospaced and
+ inline substituted text+ instead of `monospaced literal text`, and with
+ the former, the part that should not get substituted must be
+ quoted/escaped.
-- 
1.8.4.2
