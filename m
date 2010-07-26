From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/24] Documentation: refactor config variable descriptions
Date: Mon, 26 Jul 2010 20:48:52 +0200
Message-ID: <cover.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:49:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSjY-0005Dx-5V
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab0GZSs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 14:48:58 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14250 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab0GZSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:48:57 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 20:48:56 +0200
Received: from localhost.localdomain (84.74.100.241) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 20:48:55 +0200
X-Mailer: git-send-email 1.7.2.349.gd5452
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151879>

This little series is a bit of a spinoff from

  http://article.gmane.org/gmane.comp.version-control.git/146696
and
  http://article.gmane.org/gmane.comp.version-control.git/145139

Since I didn't want to spam the list with 24 RFC emails, I squashed
all the manpage-specific patches into one for this submission.  You
can find the originals at

  git://repo.or.cz/git/trast.git t/doc-config-extraction =20

Judging from its size it's quite possible that

  [1/24] Documentation: Move variables from config.txt to separate file

won't make it through to the list, either, and -M doesn't help, so you
may have to look it up at the above repository too.


Work so far:

I moved the variables from config.txt and merge-config.txt to a new
file, and made a little helper script that expands @@CONFIG(key)@@ in
the asciidoc files, driven by the Makefile of course.

I then went over the manpages in the "Main Porcelain Commands" list of
git(1) and either (easy case) added a "CONFIGURATION" section with the
relevant variables or (hard case) tried to refactor the descriptions
so that they are only kept in one place.

=C3=86var kindly rewrote the Perl script in a more readable and error-s=
afe
style, which I squashed for this posting.  It's still a separate patch
at the above link, too.


=46urther directions:

I'm a bit hesitant to go in Peff's suggested direction of outright
removing all variables from git-config(1).  I would prefer to both
have the short list and group them by some category system, if that
happens to work out.  Perhaps the categorized list can eventually be
removed once we can verify that all variables are documented in
another manpage.


Known omissions/todos:

* git-gc has an elaborate prose section to the same effect that I
  wasn't quite ready to tear apart yet

* git-notes has excellent custom descriptions from Jonathan's series
  that I didn't want to refactor=20

* The description of format.pretty in git-log.txt is unsatisfactory

* check-docs or some other make target should verify that no manpage
  links to itself


Thomas Rast (3):
  Documentation: Move variables from config.txt to separate file
  Documentation: Add variable-substitution script
  Documentation: include configuration options in manpages

 Documentation/Makefile             |   14 +-
 Documentation/config-vars.txt      | 1761 ++++++++++++++++++++++++++++=
++++++++
 Documentation/config.txt           | 1693 +---------------------------=
-------
 Documentation/git-add.txt          |    6 +-
 Documentation/git-am.txt           |   18 +
 Documentation/git-archive.txt      |    8 +-
 Documentation/git-branch.txt       |    8 +
 Documentation/git-checkout.txt     |    8 +
 Documentation/git-clean.txt        |    6 +
 Documentation/git-commit.txt       |    7 +
 Documentation/git-diff.txt         |   12 +
 Documentation/git-fetch.txt        |   12 +
 Documentation/git-format-patch.txt |   22 +-
 Documentation/git-grep.txt         |    7 +
 Documentation/git-gui.txt          |   16 +
 Documentation/git-log.txt          |   38 +-
 Documentation/git-merge.txt        |   15 +-
 Documentation/git-pull.txt         |   14 +
 Documentation/git-push.txt         |   19 +
 Documentation/git-rebase.txt       |    5 +-
 Documentation/git-shortlog.txt     |    6 +
 Documentation/git-status.txt       |   18 +-
 Documentation/git-submodule.txt    |    8 +
 Documentation/git-tag.txt          |   11 +-
 Documentation/gitk.txt             |    8 +
 Documentation/merge-config.txt     |   49 -
 Documentation/subst-config.perl    |   74 ++
 27 files changed, 2042 insertions(+), 1821 deletions(-)
 create mode 100644 Documentation/config-vars.txt
 delete mode 100644 Documentation/merge-config.txt
 create mode 100755 Documentation/subst-config.perl

--=20
1.7.2.349.gd5452
