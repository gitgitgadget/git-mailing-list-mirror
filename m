From: Dave Jones <davej@redhat.com>
Subject: merging problems with Linus' kernel tree.
Date: Tue, 21 Feb 2006 13:33:06 -0500
Message-ID: <20060221183306.GC22988@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Feb 21 19:33:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBcK1-0002jS-7L
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 19:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBUSdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Feb 2006 13:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBUSdJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 13:33:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932340AbWBUSdI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 13:33:08 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1LIX8sE022615
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 13:33:08 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1LIX7122066
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 13:33:07 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1LIX7QZ016009
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 13:33:07 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1LIX6DR016008
	for git@vger.kernel.org; Tue, 21 Feb 2006 13:33:06 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16539>

I did my morning 'git pull' on Linus' tree to a clean tree
that I never make any commits to, and got this ...

$ git pull
Unpacking 2425 objects
 100% (2425/2425) done
* refs/heads/origin: fast forward to branch 'master' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Auto-following refs/tags/v2.6.16-rc3
Auto-following refs/tags/v2.6.16-rc4
Unpacking 2 objects
 100% (2/2) done
* refs/tags/v2.6.16-rc4: storing tag 'v2.6.16-rc4' of git://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux-2.6
* refs/tags/v2.6.16-rc3: storing tag 'v2.6.16-rc3' of git://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Updating from 418aade459f03318defd18ef0b11981a63bd81b0 to 5914811acf36c=
3ff091f860a6964808f668f27d0.
Documentation/cpu-hotplug.txt: needs update
fatal: Entry 'Documentation/cpu-hotplug.txt' would be overwritten by me=
rge. Cannot merge.

$ git-fsck-objects
dangling commit 5914811acf36c3ff091f860a6964808f668f27d0

$ git-cat-file commit 5914811acf36c3ff091f860a6964 808f668f27d0
tree 04317a64fa5e76a13f29de655fe354abd627445d
parent 6d7b9efacba9f4e5f4d5ca165b1a4350da52ddd7
author Bj=EF=BF=BDrn Steinbrink <B.Steinbrink@gmx.de> 1140282763 +0100
committer Linus Torvalds <torvalds@g5.osdl.org> 1140496058 -0800

[PATCH] kjournald keeps reference to namespace

In daemonize() a new thread gets cleaned up and 'merged' with init_task=
=2E
The current fs_struct is handled there, but not the current namespace.

This adds the namespace part.

[ Eric Biederman pointed out the namespace wrappers, and also notes tha=
t
we can't ever count on using our parents namespace because we already
have called exit_fs(), which is the only way to the namespace from a
process. ]

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Acked-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>


I ran a fsck on the disk, and that turned up nothing, so I'm
not expecting any local fs corruption.
What's up with this, and how do I fix it?

		Dave
