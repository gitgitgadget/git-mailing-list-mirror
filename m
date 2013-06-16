From: benoit.person@ensimag.fr
Subject: [PATCH V3 0/4] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Sun, 16 Jun 2013 04:31:29 +0200
Message-ID: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 04:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo2lW-0007OE-Ks
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 04:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab3FPCcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 22:32:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54757 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab3FPCcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 22:32:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5G2W2Hl009868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 04:32:02 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5G2W2xC013540;
	Sun, 16 Jun 2013 04:32:02 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5G2W1eI020162;
	Sun, 16 Jun 2013 04:32:01 +0200
X-Mailer: git-send-email 1.8.3.GIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 16 Jun 2013 04:32:02 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227982>

=46rom: Benoit Person <benoit.person@ensimag.fr>

The #7 issue on git-mediawiki's issue tracker [1] states that the abili=
ty to
preview content without pushing would be a nice thing to have.

changes from V2:
  - Add a way to test, without installation, code that uses GitMediawik=
i.pm.
  - Move more constants to GitMediawiki.pm
  - Remove the encapsulation of Git::config calls into a git_cmd_try on=
e.
  - Remove the --blob option, distinction between files and blobs is no=
w=20
    automatic.
  - Add a --verbose option to output more information on what's going o=
n.
  - Rewrote the doc and the commit message.
  - Rewrote of the template retrieving code (see 'get_template' sub).
  - Use a configuration variable to define the content ID search in the
    template. Default value set as 'bodyContent' since it seems more st=
andard
    than 'mw-content-text'.
  - Final content is now saved as utf-8 to solve encoding issues.
  - Perlcritic changes:=20
    - Update for loops style to a more perlish one.
    - All 'print's specify their output streams.
    --> Same useless warnings left in git-remote-mediawiki.perl after c=
=C3=A9lestin's=20
        work and git-mw.perl after this patch :) .

changes from V1:
  - add new package GitMediawiki
    - move some of git-remote-mediawiki functions into the package
    - update git-remote-mediawiki to use those "moved" functions
    - add a hacky-way to install it in the Makefile
    - use it in the new git mw tool
  - add a way to give to the preview tool blobs as argument
  - add a fallback when the upstream's branch remote is not a mediawiki=
 remote
  - update the `autoload` option to use `git web--browse` and not `xdg-=
open`
  - update the way we find the upstream's branch remote name

This serie is based on the 'master' branch merged with c=C3=A9lestin's =
patch series.

[1] https://github.com/moy/Git-Mediawiki/issues/7

Benoit Person (4):
  git-mw: Introduction of GitMediawiki.pm
  git-mw: Move some functions from git-remote-mediawiki.perl to
    GitMediawiki.pm
  git-mw: Adding git-mw command
  git-mw: Add preview subcommand into git mw.

 contrib/mw-to-git/GitMediawiki.pm           | 100 ++++++++
 contrib/mw-to-git/Makefile                  |  29 ++-
 contrib/mw-to-git/git-mw.perl               | 347 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.perl |  85 ++-----
 4 files changed, 485 insertions(+), 76 deletions(-)
 create mode 100644 contrib/mw-to-git/GitMediawiki.pm
 create mode 100644 contrib/mw-to-git/git-mw.perl

--=20
1.8.3.GIT
