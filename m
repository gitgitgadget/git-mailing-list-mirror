From: Jon Loeliger <jdl@freescale.com>
Subject: Question Building Deb Packages
Date: Mon, 21 Nov 2005 20:53:30 -0600
Message-ID: <E1EeOHi-0007Bx-HH@jdl.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 03:56:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeOHx-0001v6-Bw
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 03:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVKVCxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 21:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVKVCxm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 21:53:42 -0500
Received: from colo.jdl.com ([66.118.10.122]:52878 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964878AbVKVCxl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 21:53:41 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EeOHi-0007Bx-HH
	for git@vger.kernel.org; Mon, 21 Nov 2005 20:53:31 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12515>

Guys,

So, a long and twisty path (all alike) later, I have
a new desktop box with Ubuntu on it.  So what.

It didn't have git on it at all, the proper git package wasn't
available directly, and I didn't know the location of an apt
source for one off the top of my head.  So, first principles.

First, for the record, after you install ubuntu 5.10, you
have to install a whole bunch of normal stuff, like, a compiler.
When you get done with that, I also had to apt-get install some
form of these:

    linux-kernel-headers
    libc6-dev
    libssl-dev
    libcurl3-dev
    libexpat-dev
    openssl
    zlib1g-dev
    asciidoc
    xmlto
    fakeroot

The control file lists these:

    Build-Depends-Indep: libz-dev, libssl-dev,
                    libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev,
		    asciidoc (>= 7), xmlto, debhelper (>= 4.0.0),
		    bc, libexpat-dev

So, that is in pretty-good agreement.  The last 3 in my list were
for "doc" and "deb" make targets, of course.

Second, I then decided to actually make the debian package
and attempt to install it from the 99.9j tarball directly
and then add that package to my system.  No dice.

It _appears_ that the "deb" make target requires it to be
done in an actual git repository.  This struck me as odd,
as I _think_ I have done an obvious progression:

    - I don't have git, but want it
    - I want to build it from a source drop, 0.99.9j
    - Grab tarball, unpack, build it
    - Build debian target
    - Install just-built deb package

Later, of course, I can use that 'official' installation to
actually grab new (git) repositories and all.  But I have to
bootstrap the mess, and I want to do that in a "controlled"
way.  Namely, through the debian package target...

Did I get confused?

Thanks,
jdl


    jdl@ubuntu:/usr/src/git-0.99.9j$ make prefix=/usr
    make -C templates
    make[1]: Entering directory `/usr/src/git-0.99.9j/templates'
    : no custom templates yet
    make[1]: Leaving directory `/usr/src/git-0.99.9j/templates'

    jdl@ubuntu:/usr/src/git-0.99.9j$ make prefix=/usr deb
    ./git-tar-tree HEAD git-0.99.9j > git-0.99.9j.tar
    usage: git-tar-tree <key> [basedir]
    make: *** [dist] Error 129

    jdl@ubuntu:/usr/src/git-0.99.9j$ ls .git*
    .gitignore
