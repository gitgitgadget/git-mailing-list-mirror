From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Errors in man git
Date: Wed, 8 Sep 2010 23:31:40 +0200
Message-ID: <20100908233140.7d5df3ee@jk.gs>
References: <BLU0-SMTP666507C6D3E37A50B92431BB720@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: D.U.Thibault@Bigfoot.com
X-From: git-owner@vger.kernel.org Wed Sep 08 23:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtSFA-0006vT-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 23:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab0IHVbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 17:31:46 -0400
Received: from zoidberg.org ([88.198.6.61]:35330 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab0IHVbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 17:31:44 -0400
Received: from jk.gs (p508A2F6F.dip.t-dialin.net [::ffff:80.138.47.111])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 08 Sep 2010 23:31:42 +0200
  id 0040031E.4C8800BF.00003485
In-Reply-To: <BLU0-SMTP666507C6D3E37A50B92431BB720@phx.gbl>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155815>

Hi,

"Daniel U. Thibault" <d.u.thibault@sympatico.ca> wrote:

> There are no indications in the "man git" pages as to how to
> report errors, so I'm following the instructions I googled at=20
> http://www.kernel.org/doc/man-pages/reporting_bugs.html (adding=20
> git@vger.kernel.org to the mailing list as it seems appropriate). =20

Since the manpages are written by the git project only, I think it's
more appropriate to address the git mailing list only.=C2=A0[pruning ot=
her
recipients]

> [...] Hence "git COMMAND" should work once the appropriate value
> is substituted for COMMAND.  The COMMANDs are later documented (GIT=20
> COMMANDS) as long lists of "porcelain" and "plumbing" COMMANDs. =20
> However, *none* of the COMMANDs given actually work.  For instance,
> one (porcelain) COMMAND is "git-gui" but typing "git git-gui" in a
> command shell results in the message: =20

That's because of the way other manpages have to be referenced. Let me
include a snippet from the manpage to clarify:

| HIGH-LEVEL COMMANDS (PORCELAIN)
|       We separate the porcelain commands into the main commands and
|       some ancillary user utilities.
|
|   Main porcelain commands
|       git-add(1)
|           Add file contents to the index.

Here, "git-add(1)" is written in one word because otherwise it's not a
valid reference to another manpage. The only alternative is that we
rename the manpage to "add"... but people probably won't like git
polluting the manpage namespace that way, and "add" by itself isn't a
valid command anyway.

If you look at "man git-add", you'll see that the synopsis given there
shows the right way to invoke the command:

| NAME
|       git-add - Add file contents to the index
|=20
| SYNOPSIS
|       git add [-n] [-v] [--force | -f] [--interactive | -i]
|                [--patch | -p] [--edit | -e] [--all | [--update | -u]]
|                [--intent-to-add | -N] [--refresh] [--ignore-errors]
|                [--ignore-missing] [--] [<filepattern>...]

I agree that it is potentially confusing, but the manpage references
are clearly recognisable as such.

Personally I don't consider it necessary to change this, since it's
clearly not horribly complicated to figure out the meaning, but here's
a patch for the sake of completeness.

----8<----

Subject: [PATCH] Documentation/git.txt: explain that manpages for subco=
mmands exist

On the off chance that it is not apparent that the manpages for
individual git commands explain how to use git commands (e.g. if
someone manages to conclude that "git git-add" is the way to use
git-add(1)), add a small explanation about that.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 93e3b07..fbceb12 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -316,7 +316,8 @@ GIT COMMANDS
 ------------
=20
 We divide git into high level ("porcelain") commands and low level
-("plumbing") commands.
+("plumbing") commands. Please refer to the individual manpages listed
+in the sections below for details on how to invoke each command.
=20
 High-level commands (porcelain)
 -------------------------------
--=20
1.7.2.3.392.g02377
