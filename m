From: Eric James Michael Ritz <Eric@cybersprocket.com>
Subject: [PATCH] Documentation: explain how to write aliases that use other
 aliases
Date: Fri, 15 Jan 2010 20:42:34 -0500
Organization: Cyber Sprocket Labs
Message-ID: <4B51198A.3010504@cybersprocket.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 16 02:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxpd-0003Iq-VV
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab0APBsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668Ab0APBsf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:48:35 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:46683
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758631Ab0APBse (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 20:48:34 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2010 20:48:34 EST
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id W0DG1d0040bG4ec581ieHu; Sat, 16 Jan 2010 01:42:38 +0000
Received: from [192.168.1.111] ([24.11.132.175])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id W1ib1d00G3nCitC3P1ieZf; Sat, 16 Jan 2010 01:42:38 +0000
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137191>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Users who try to define aliases in terms of other aliases will receive
an error about an unrecognized command.  This is because Git only
applies alias expansion once.  However, users can write aliases with
the exclamation point prefix to achieve this effect.  Teach users how
to do this by building off the example of using aliases to call shell
commands.

Signed-off-by: Eric James Michael Ritz <Eric@cybersprocket.com>
- ---
I ran into this issue try to define some aliases, and then after an
hour of hacking on alias.c a light-bulb went off in my head, and I
realized I could just use the '!' prefix to write aliases that call
other aliases.  Much simplier than the alias code I was changing, lol.
So I thought it would be useful to mention this in the manual, for
users like myself who like to build aliases from other aliases.

 Documentation/config.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8acb613..0874a0d 100644
- --- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -524,7 +524,12 @@ If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 "alias.new = !gitk --all --not ORIG_HEAD", the invocation
 "git new" is equivalent to running the shell command
- -"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+"gitk --all --not ORIG_HEAD".  Git will not expand aliases which
+call other aliases,  but you can use the exclamation point prefix to
+achieve this effect.  For example, defining "alias.today =
+!git new --since=yesterday" will cause "git today"
+to expand to "gitk --all --not ORIG_HEAD --since=yesterday".
+Note that shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.

- --
1.6.6.159.g8802c



- -- 
Eric Ritz
Cyber Sprocket Labs
(843) 225-3830
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJLURmKAAoJEEHUZXw5hMWsCZoIALh+tvIJHNVVQtPr1xOEtuYg
fGh4GUdDOwzsWekbxoUpzFwaE0zteawIlG7QYrLKkuFtR4E3bziM86HpIZ4nIy8b
wnZzFVSEGfhAIkhxICsSWFDZp1R0tUN5+i5NOhIrMC0nnQ0aM36Ruzyt1GbntkH1
uBsO9NYpoP+a4HQRGtafXNg2jBC1PoWy3UWTpETsIUHlV3CTrAr17uVbSDt0QSK+
lfhD717w88mvfewJaNwqnrXskADmE+bYbQBr2dvUAutbcRKx0+HREz3ju+/oTtfN
nGaSOX/kLUfTIR4+aGz6u2bkfaGt8WDBibGnC1d0l/c9jxvlodOBZxWcFscxZ4A=
=Divy
-----END PGP SIGNATURE-----
