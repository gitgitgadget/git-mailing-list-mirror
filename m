From: Owen Taylor <otaylor@redhat.com>
Subject: git-bz: command line integration for bugzilla
Date: Fri, 28 Aug 2009 22:24:24 -0400
Message-ID: <1251512664.666.349.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 04:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhDcN-0008Md-Jy
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 04:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZH2CYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 22:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbZH2CYY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 22:24:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbZH2CYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 22:24:23 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7T2OPLl006021
	for <git@vger.kernel.org>; Fri, 28 Aug 2009 22:24:25 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7T2OPYT021908
	for <git@vger.kernel.org>; Fri, 28 Aug 2009 22:24:25 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127371>

Was filling out the Git user's survey today, and noticed that my git-bz
tool wasn't on the long list of "Git interfaces, implementations,
frontends and tools" - but then again, I've never really advertised it
beyond GNOME IRC. So, I was reminded to mention it here...

The Pitch
=========

Do you use git? You wouldn't be reading this list if you didn't. Do you
use Bugzilla? No? You can stop here.

Since you use Git and you use Bugzilla, you want to use git-bz.

Setup:

  git config --global bz.default-tracker bugzilla.example.com
  # in some module
  git config bz.default-product TiddlyWinks
  git config bz.default-component AI-Engine

File a new bug with a commit attached as a patch, rewrite the commit
message to include the URL of the newly filed bug:

  git bz file -u HEAD

Attach a series of commits to an existing bug, bringing each up in
an editor to allow editing the comment and picking old patches to
obsolete:

  git bz attach -e 43215 HEAD~3..

Apply patches already attached to an existing bug to a local branch:

  git bz apply http://bugzilla.example.com/show_bug.cgi?34132

Getting It
==========

 The script: http://git.fishsoup.net/cgit/git-bz/plain/git-bz
 CGIT:       http://git.fishsoup.net/cgit/git-bz
 clone:      git://git.fishsoup.net/git-bz

It's a standalone Python script, no dependencies, so you can just copy it
or symlink it somewhere in your path.

Notes
=====

 * Yes, it's in Python.

 * It should work with most Bugzilla installations

 * There are some nice things that could be added - support for automatically
   creating a branch when applying patches from a bug locally, 'git bz close'
   to push patches and close the corresponding Bugzilla bugs, and so forth.

   It's pretty good as is.

 * The utility of attaching patches to Bugzilla is probably greatest 
   in a shared-central repository workflow. If all contributors already 
   are publishing all changes to personal public repositories, then attaching 
   them to Bugzilla in addition may not make sense.

   Tracking merge requests would require a quite different form of Bugzilla
   integration (probably server side)

 * It used to be command-line compatible with git-format-patch for the handling
   of 'git bz file <revision>' - but I switched it at some point so you didn't
   need to add '-1' to file a single commit. Still undecided if it's better
   to be obvious or to be compatible.
