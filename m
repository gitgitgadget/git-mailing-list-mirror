From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-0.95]
Date: Sat, 24 Sep 2005 09:06:40 -0700 (PDT)
Message-ID: <20050924160641.60151.qmail@web26307.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Sep 24 18:09:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJCYv-0002ZJ-Hp
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 18:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVIXQGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 12:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIXQGs
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 12:06:48 -0400
Received: from web26307.mail.ukl.yahoo.com ([217.146.176.18]:21660 "HELO
	web26307.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750750AbVIXQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 12:06:47 -0400
Received: (qmail 60153 invoked by uid 60001); 24 Sep 2005 16:06:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0Qq8Ds0cA0bl8ehIgF1oVGvTC82XgdAaFoykX+g7SdQyCbRyiGLYhoJJYfFr6ujA2M4kNYjAnLLuURkikxum0Yf0RwIpisbiKEDQ0Uu0uOTFT9l5/gCSy4i+qLIylrsyct0Elc52W7Cf4wEqBnNThf4jSvYJ6U/VDJhJAta+gfI=  ;
Received: from [151.38.74.214] by web26307.mail.ukl.yahoo.com via HTTP; Sat, 24 Sep 2005 09:06:40 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9237>

This is a performance update release.

The detailed list of changes is below, but the bottom line is 
qgit-0.95 is _really_ fast.

It tooks about 4 seconds, on my box, to run qgit --all on today linux tree against 
about 65 seconds with gitk. Also the used memory it seems lower.

As a 'theoretical maximum speed' a bare:

git-rev-list --header --topo-order --parents HEAD > /dev/null

Runs in about 2 seconds.

So this is the main reason I post this release. I doubt a little bit about this results 
because the spread with gitk it seems too much, so I would like a double check.

NOTE: Before to test qgit you need to UNSET flag 

           edit->settings->cache->'diff against working dir'

to avoid a slow 'git-status' (with involved 'git-update-index --refresh') call.


CHANGELOG

- more scalable pixmap memory handling.
  Graph pixmaps are created only for visible items and freed
  when log lines became not visible so that the amount of memory
  used is constant and independent from archive size. This is also a
  performance improvement because of the 'lazy setup' policy.

- changed GUI update policy to group all the updates in one big chunk at
  fixed intervals. This is faster then an incremental update.

- more scalable file names handling.
  File paths are splitted in base and file name, both are then indipendently
  indexed. This gives huge memory savings and also better scalability because the
  'different file names' set grows much more slowly then new commits. Using two index 
  tables gives good memory saving when you have lot of files in the same (deep) directory.

- Rewritten git-rev-list parsing to avoid as much as possible to move data around.


INSTALLATION

You need scons and Qt developer libs version 3.3.4 or better already installed. You need 'mt'
version of Qt libraries.

QGit is NOT compatible with Qt4.

On some platforms (Debian) you should set QTDIR before to compile.


DOWNLOAD

Download link is:
http://prdownloads.sourceforge.net/qgit/qgit-0.95.tar.bz2?download

But now there is also a git archive: 
http://digilander.libero.it/mcostalba/qgit.git

Please use 'cg-clone http://digilander.libero.it/mcostalba/qgit.git' 
I still have to set-up a 'git clone' friendly archive.

If you have problems with the sources you can download a binary:
http://digilander.libero.it/mcostalba/qgit



Marco



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
