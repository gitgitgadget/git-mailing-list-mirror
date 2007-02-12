From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Pulling from branches.
Date: Tue, 13 Feb 2007 10:06:58 +1100
Message-ID: <1171321618.4081.72.camel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 00:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkGK-0005oC-VT
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbXBLXHD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbXBLXHC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:07:02 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:49989 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030461AbXBLXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:07:00 -0500
Received: from [127.0.0.1] (nigel.suspend2.net [127.0.0.1])
	by nigel.suspend2.net (Postfix) with ESMTP id 0077EE7B1D
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 10:06:59 +1100 (EST)
X-Mailer: Evolution 2.8.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39450>

Hi.

I have a problem with pulling from branches, and am wondering if it's
just because I'm ignorant. :>

Locally, I have a single git tree with multiple branches:

nigel@nigel:/usr/src/stg-tree$ cg status -g
Heads:
    edgy                        80b8e66e4b7ed12b8918c4440e37fd0bc898bd15
  R linux-2.6.16.x-local        6d44d60a6b7d1cbd24efbd62e51eb3287de9ed46
  R linux-2.6.17.x              78ace17e51d4968ed2355e8f708d233d1cc37f6d
  R linux-2.6.17.x-local        78ace17e51d4968ed2355e8f708d233d1cc37f6d
  R linux-2.6.18.x              03739b5cc1b86536d662b89ce935b0ee68977e23
  R linux-2.6.18.x-local        03739b5cc1b86536d662b89ce935b0ee68977e23
  R linux-2.6.19.x              b321cb58a311d172a3370029324b653e0b1d7041
  R linux-2.6.19.x-local        b321cb58a311d172a3370029324b653e0b1d7041
  R linux-2.6.20.x              62d0cfcb27cf755cebdc93ca95dabc83608007cd
    merge                       8df8d08ae56a89f5f6084f88818d272a6a3d4067
  R mm                          bee8d431ab4bdeade78a09d02e0a0e8dcd36958b
  R origin                      509cb37e173d4e39cec47238397e91b718730794
  R suspend2                    07807bff2f1389a97b452f91c75a9f3625d35677
    suspend2-2.6.17.x           87cff8ff1a1fccdbb3e136938e88613acb5779d6
    suspend2-2.6.18             c3bb4bc6a5c406d6562f17375508a72cfcf3fd28
   >suspend2-2.6.19             b321cb58a311d172a3370029324b653e0b1d7041
    suspend2-2.6.20             62d0cfcb27cf755cebdc93ca95dabc83608007cd
    suspend2-mm                 7c6fa3df53e6e87863362d1e902eea41bc35c29c
  R ubuntu-2.6                  a1c9237fa8a5721a708b9385c67a81d93b549200
  R ubuntu-2.6-local            a1c9237fa8a5721a708b9385c67a81d93b549200
    ubuntu-2.6-suspend2         1c5c746fb366d4ebb1b2887ccc15cfb0186bf260
  R ubuntu-edgy                 08e00172cfa4ef20f0791fc925d2c43019f7c083
  R ubuntu-edgy-local           08e00172cfa4ef20f0791fc925d2c43019f7c083
    ubuntu-edgy-suspend2        a42d599b474d86d6142fddac81b7eba41f5e92db

I pull from Linus' tree (origin), and from the various stable branches
(linux-2.6.n.x - forget now why I have the -local ones, but it works so
I'm not touching it!) and Ben's ubuntu-2.6 and so on.

>From there, I have suspend2- branches that are stg trees, which apply
Suspend2 to the various versions.

So I tend to do:
nigel@nigel:/usr/src/stg-tree$ update-trees suspend2-2.6.19

Tree is suspend2-2.6.19
Origin is linux-2.6.19.x-local
Remote is linux-2.6.19.x

git checkout -f linux-2.6.19.x-local
cg fetch linux-2.6.19.x
Fetching pack (head and objects)...
Fetching tags...
fatal: unexpected EOF		(Normally works ok)
Failed to find remote refs
unable to get tags list (non-fatal)
Up to date.
git checkout -f suspend2-2.6.19
stg pull linux-2.6.19.x-local
Popping all applied patches... done
Pulling from "linux-2.6.19.x-local"...
Already up-to-date.
done
Fast-forwarded patch "suspend2.patch"
Now at patch "suspend2.patch"

Ok, so I fix any rejects, complile, test and all is happy with the
world.

nigel@nigel:/usr/src/stg-tree$ cat .git/remotes/linux-2.6.19.x 
URL: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
Pull: refs/heads/linux-2.6.19.x:refs/heads/origin

My problem, however, comes when I try to upload to master.kernel.org.
All seems to go okay, until it pulls the tags. Then it starts trying to
pull tags and commits not just from the particular branch, but from the
whole tree:
Dir is suspend2-2.6.19
Origin is origin
Tree is suspend2-2.6.19
Remote is linux-2.6.19.x

cd /staging/nigelc
cp -ar suspend2-2.6.19.git /staging/nigelc
cd /staging/nigelc
export GIT_DIR=suspend2-2.6.19.git
git checkout -f origin
cg fetch
Fetching pack (head and objects)...
Fetching tags...
Up to date.
git branch -D suspend2-2.6.19
Deleted branch suspend2-2.6.19.
git branch suspend2-2.6.19
git checkout -f suspend2-2.6.19
cg fetch suspend2-2.6.19
Fetching pack (head and objects)...
remote: Generating pack...
remote: Done counting 234 objects.
remote: Deltifying 234 objects.
remote:  100% (234/234) done
Unpacking 234 objects
remote: Total 234, written 234 (delta 5), reused 27 (delta 2)
Fetching tags...
Missing tag v2.6.20...
Missing tag v2.6.20...
Missing tag v2.6.20-rc1...
Missing tag v2.6.20-rc1...
Missing tag v2.6.20-rc2...
Missing tag v2.6.20-rc2...
Missing tag v2.6.20-rc3...
Missing tag v2.6.20-rc3...
Missing tag v2.6.20-rc4...
Missing tag v2.6.20-rc4...
Missing tag v2.6.20-rc5...
Missing tag v2.6.20-rc5...
Missing tag v2.6.20-rc6...
Missing tag v2.6.20-rc6...
Missing tag v2.6.20-rc7...
Missing tag v2.6.20-rc7...
remote: Generating pack...
remote: Done counting 40070 objects.
remote: Deltifying 40070 objects.
Killed by signal 2.0/40070) done

As you can see, at the end, it starts pulling tags and commits from
outside my local suspend2-2.6.19.

[nigelc@hera nigelc]$ cat suspend2-2.6.19.git/branches/origin 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
[nigelc@hera nigelc]$ cat suspend2-2.6.19.git/branches/suspend2-2.6.19 
git+ssh://nigel@nigel.suspend2.net/usr/src/stg-tree/.git/#suspend2-2.6.19
[nigelc@hera nigelc]$ cat suspend2-2.6.19.git/remotes/origin 
URL: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
Pull: refs/heads/master:refs/heads/origin
[nigelc@hera nigelc]$ cat suspend2-2.6.19.git/remotes/suspend2-2.6.19 
URL: git+ssh://nigel@nigel.suspend2.net/usr/src/stg-tree/.git
Pull: refs/heads/suspend2-2.6.19:refs/heads/suspend2-2.6.19

What am I doing wrong?

TIA!

Nigel
