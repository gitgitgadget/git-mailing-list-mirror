From: Daniel Trebbien <dtrebbien@gmail.com>
Subject: Why does git-svn redownload revisions?
Date: Wed, 8 Sep 2010 16:13:33 +0000 (UTC)
Message-ID: <loom.20100908T181056-819@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 18:15:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtNIo-0004Il-BX
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 18:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab0IHQPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 12:15:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:42985 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab0IHQPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 12:15:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OtNIc-0004Cb-V3
	for git@vger.kernel.org; Wed, 08 Sep 2010 18:15:03 +0200
Received: from cpe-76-88-109-104.san.res.rr.com ([76.88.109.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 18:15:02 +0200
Received: from dtrebbien by cpe-76-88-109-104.san.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 18:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.88.109.104 (Mozilla/5.0 (X11; U; Linux i686; en-us) AppleWebKit/531.2+ (KHTML, like Gecko) Safari/531.2+ Debian/squeeze (2.30.5-1) Epiphany/2.30.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155798>

For my first time using git-svn, I decided that I wanted to convert the GNU Nano
Subversion repository to a git repo. I finally settled on the following series
of commands after some initial trial-and-error (e.g. having the wrong
`i18n.commitencoding` and not specifying a Subversion authors file):
git svn init -s svn://svn.sv.gnu.org/nano
git config svn.authorsfile ~/projects/nano/svn.authorsfile
git config i18n.commitencoding 'ISO-8859-1'
git svn fetch

The issue is that the fetch runs up to revision 4250, but then mysteriously
begins redownloading revisions 1 up to four thousand something in importing
the `nano_2_1_1` tag:
...
r4248 = 7c444dd667b9629ce92a53e8d35ad2d178e5735f (refs/remotes/trunk)
	M	nano/ChangeLog
	M	nano/configure.ac
	M	nano/po/cs.po
	M	nano/po/pt_BR.po
	M	nano/po/es.po
	M	nano/po/eu.po
	M	nano/po/hu.po
	M	nano/po/vi.po
	M	nano/po/nano.pot
	M	nano/po/ms.po
	M	nano/po/uk.po
	M	nano/po/ro.po
	M	nano/po/ru.po
	M	nano/po/rw.po
	M	nano/po/id.po
	M	nano/po/nb.po
	M	nano/po/gl.po
	M	nano/po/fr.po
	M	nano/po/nl.po
	M	nano/po/nn.po
	M	nano/po/pl.po
	M	nano/po/it.po
	M	nano/po/ca.po
	M	nano/po/da.po
	M	nano/po/sr.po
	M	nano/po/tr.po
	M	nano/po/ga.po
	M	nano/po/bg.po
	M	nano/po/sv.po
	M	nano/po/de.po
	M	nano/po/zh_TW.po
	M	nano/po/fi.po
	M	nano/po/zh_CN.po
r4249 = 6fbad8a00fa067d1e3de913f77db08c6117843c7 (refs/remotes/trunk)
	M	nano/NEWS
r4250 = 704700855e5112d75654e3e7461e896f49e10fd8 (refs/remotes/trunk)
Found possible branch point: svn://svn.sv.gnu.org/nano/trunk/nano =>
svn://svn.sv.gnu.org/nano/tags/nano_2_1_1, 4248
Initializing parent: refs/remotes/tags/nano_2_1_1@4248
	A	mkinstalldirs
	A	utils.c
	A	nano.h
	A	global.c
	A	configure
	A	Makefile.in
	A	AUTHORS
	A	configure.in
	A	ChangeLog
	A	proto.h
	A	nano.1
	A	nano.1.html
	A	README
	A	acconfig.h
	A	BUGS
	A	config.h.in
	A	ABOUT-NLS
	A	TODO
	A	INSTALL
	A	intl/po2tbl.sed.in
	A	intl/loadinfo.h
	A	intl/Makefile.in
	A	intl/explodename.c
	A	intl/VERSION
	A	intl/xopen-msg.sed
	A	intl/ChangeLog
	A	intl/finddomain.c
	A	intl/localealias.c
	A	intl/gettextP.h
	A	intl/textdomain.c
	A	intl/linux-msg.sed
	A	intl/l10nflist.c
	A	intl/loadmsgcat.c
	A	intl/libgettext.h
	A	intl/bindtextdom.c
	A	intl/gettext.c
	A	intl/intl-compat.c
	A	intl/dgettext.c
	A	intl/cat-compat.c
	A	intl/gettext.h
	A	intl/dcgettext.c
	A	intl/hash-string.h
	A	winio.c
	A	COPYING
	A	Makefile.am
	A	missing
	A	NEWS
	A	cut.c
	A	nano.c
	A	aclocal.m4
	A	install-sh
	A	po/cat-id-tbl.c
	A	po/stamp-cat-id
	A	po/es.po
	A	po/fr.po
	A	po/de.po
	A	po/ChangeLog
	A	po/Makefile.in.in
	A	po/es.gmo
	A	po/fr.gmo
	A	po/de.gmo
	A	po/it.po
	A	po/POTFILES.in
	A	po/nano.pot
	A	po/it.gmo
	A	stamp-h.in
r2 = 842a208235bd2a1181250766996f7797e74a8608
(refs/remotes/tags/nano_2_1_1@4248)
	M	winio.c
r6 = 280cfdcb8533ffcb424b3a86b7392ccfbc054e60
(refs/remotes/tags/nano_2_1_1@4248)
	M	ChangeLog
r7 = 6951e65102dd1e005761dec6eb082f0a2d9327a2
(refs/remotes/tags/nano_2_1_1@4248)
	M	AUTHORS
...


Why is git-svn redownloading revision history? Also, why hasn't git-svn
redownloaded revisions to import other tags such as `nano_1_3_9`, `nano_2_0_0`,
and `nano_0_9_14`? I have yet to complete the fetch, but git-svn finished
redownloading revisions for `nano_2_1_1`, seemed to skip redownloading for
`nano_2_1_2`, and is now redownloading for `nano_2_1_3`.
