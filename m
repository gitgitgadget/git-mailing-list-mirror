From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: git cvsimport omits some CVS patches (reproducible test case)
Date: Sat, 17 Feb 2007 13:45:59 +0000
Message-ID: <45D70717.2080003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 14:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIPpf-00023R-0b
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 14:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbXBQNmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 08:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbXBQNmU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 08:42:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965257AbXBQNmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 08:42:19 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1HDgI2Y013697
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 08:42:19 -0500
Received: from pobox.surrey.redhat.com (pobox.surrey.redhat.com [172.16.10.17])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1HDgF2Z012580
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 08:42:18 -0500
Received: from [10.32.68.4] (vpn-68-4.surrey.redhat.com [10.32.68.4])
	by pobox.surrey.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l1HDgFZj019416
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 13:42:15 GMT
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39987>

$ cvs -d :pserver:anoncvs@libvirt.org:2401/data/cvs login
Logging in to :pserver:anoncvs@libvirt.org:2401/data/cvs
CVS password: <--- type 'anoncvs' here w/o the quotes
$ cvs -d :pserver:anoncvs@libvirt.org:2401/data/cvs co libvirt
U libvirt/.cvsignore
U libvirt/AUTHORS
[snip long list of files]

$ cd libvirt
$ git cvsimport
connect error: Network is unreachable <--- I always get this message, 
it's not clear why
cvs rlog: Logging libvirt
[snip directories]
cvs rlog: Logging libvirt/tests/xml2sexprdata
Committing initial tree 1a42de1f86b37e565f701b257c9c3c8f654e9d32
Generating pack...
Done counting 4461 objects.
Deltifying 4461 objects.
  100% (4461/4461) done
Writing 4461 objects.
  100% (4461/4461) done
Total 4461, written 4461 (delta 3514), reused 0 (delta 0)
Pack pack-d708c2953b399a0538292855574f00181e660b48 created.
$ ls
AUTHORS       configure.in  include          Makefile.am  python   src
autobuild.sh  COPYING.LIB   libvirt.pc.in    NEWS         qemud    tests
autogen.sh    CVS           libvirt.spec.in  po           README   TODO
ChangeLog     docs          m4               proxy        scripts  virsh.1
$ git status
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   src/hash.c
#       modified:   src/internal.h
# Untracked files:
#   (use "git add" to add to commit)
#
#       CVS/
#       docs/CVS/
[...]
nothing to commit

Subsequent examination with git-diff of the two "modified" files 
(src/hash.c and src/internal.h) shows that they contain patches from CVS 
which for some reason haven't been imported by the cvsimport step.

Rich.

cvsps version 2.1
git version 1.4.4.2
(Both compiled in FC6 on x86-64).

-- 
Emerging Technologies, Red Hat  http://et.redhat.com/~rjones/
64 Baker Street, London, W1U 7DF     Mobile: +44 7866 314 421
  "[Negative numbers] darken the very whole doctrines of the equations
  and make dark of the things which are in their nature excessively
  obvious and simple" (Francis Maseres FRS, mathematician, 1759)
