From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
	stop git-svn
Date: Tue, 4 May 2010 16:16:40 -0700
Message-ID: <20100504231640.GA5075@dcvr.yhbt.net>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> <1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> <4BCF8E07.9080507@vilain.net> <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com> <20100503211942.GA1380@dcvr.yhbt.net> <4BDFC171.5010103@drmicha.warpmail.net> <20100504183452.GA30894@dcvr.yhbt.net> <1273010555.20723.17.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Olson <mwolson@gnu.org>, git@vger.kernel.org,
	Tim Stoakes <tim@stoakes.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 05 01:16:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9RM7-0007Eb-9v
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934620Ab0EDXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 19:16:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56796 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934609Ab0EDXQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 19:16:40 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A241F505;
	Tue,  4 May 2010 23:16:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1273010555.20723.17.camel@denix>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146357>

Sam Vilain <sam@vilain.net> wrote:
> On Tue, 2010-05-04 at 18:34 +0000, Eric Wong wrote:
> > Michael J Gruber <git@drmicha.warpmail.net> wrote:
> > > Uhm, which one: The one in your subject line or the one in the quoted
> > > subject line?
> > 
> > Sam's patch:
> >   Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear history
> > 
> > Where he said:
> > > >>> Oh, right ... I remember that issue now. I'm currently testing the
> > > >>> below change to see if it breaks the test suite; any issues and I'll
> > > >>> post an update.
> > 
> > Sorry for the confusion
> 
> Sorry for not following up - it didn't cause any test suite breakages
> when I tested it.  Especially if Michael has had joy with it I'd say
> it's good to go...

Hi Sam,

I'm using SVN 1.5.1 and getting the following error from
t9151-svn-mergeinfo.sh (GIT_TEST_OPTS='-i -v'):

(I haven't had many chances to look into this)

*** t9151-svn-mergeinfo.sh ***
Initialized empty Git repository in /home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/.git/
* expecting success: 
	svnadmin load -q '/home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo' 	  < '/home/ew/git-core/t/t9151/svn-mergeinfo.dump' &&
	git svn init --minimize-url -R svnmerge 	  --rewrite-root=http://svn.example.org 	  -T trunk -b branches 'file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo' &&
	git svn fetch --all
	
r1 = 7ed7a8721885457b4b334110ca70ed04c4f8166a (refs/remotes/trunk)
	A	Makefile
r2 = 2d5fcce57cec73616f628fbaed5a49ef3d0e42de (refs/remotes/trunk)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left, 1
Found branch parent: (refs/remotes/left) 7ed7a8721885457b4b334110ca70ed04c4f8166a
Following parent with do_switch
	A	Makefile
Successfully followed parent
r3 = f9ab6c8a604f40729e9b681bb3a1e867f9fa3ae8 (refs/remotes/left)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/right, 1
Found branch parent: (refs/remotes/right) 7ed7a8721885457b4b334110ca70ed04c4f8166a
Following parent with do_switch
	A	Makefile
Successfully followed parent
r4 = ddaeba46f3443446ad10c8e9f9708015508a3b28 (refs/remotes/right)
	M	Makefile
r5 = aec3f7b969e8f39a07d95041e1a0fa1084a62636 (refs/remotes/left)
	M	Makefile
r6 = 4e8f83f1ab23aef5373017e90af34f1819af8cab (refs/remotes/right)
	M	Makefile
r7 = 6bc3353f7fcec0c37010a59b688fa9d2584a744d (refs/remotes/left)
	M	Makefile
r8 = 3126dfd1119e03e412157f726d08c90a3fd4d7d4 (refs/remotes/left)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left-sub, 3
Found branch parent: (refs/remotes/left-sub) f9ab6c8a604f40729e9b681bb3a1e867f9fa3ae8
Following parent with do_switch
	M	Makefile
Successfully followed parent
r9 = 577c6d95762177126ca3068518ff8b75fcf0c25e (refs/remotes/left-sub)
	A	README
r10 = 0f51792c59119f80d15583143eecc11a609f7f4b (refs/remotes/left-sub)
	M	Makefile
Found merge parent (svn:mergeinfo prop): 3126dfd1119e03e412157f726d08c90a3fd4d7d4
r11 = 684711c1a28ba8ad47b8dbcc1fae523e6d7513a6 (refs/remotes/trunk)
	A	zlonk
r12 = 48e21141201f46c911875b76b5656d8baac09a66 (refs/remotes/left)
	A	bang
r13 = 2d65500a924079bcf2a63be861289fc72bc3e87f (refs/remotes/right)
	A	bang
	M	Makefile
W:svn cherry-pick ignored (/branches/right:6-13) - missing 1 commit(s) (eg ddaeba46f3443446ad10c8e9f9708015508a3b28)
r14 = 963722fb11bb2d08a6acd03123060441585c7d97 (refs/remotes/trunk)
Found merge parent (svn:mergeinfo prop): 2d65500a924079bcf2a63be861289fc72bc3e87f
r15 = 7a0288891e49f8f764fafb9c51e0da446284f6e3 (refs/remotes/trunk)
	A	urkkk
r16 = acd76c6201c8a7f1ba7539daebe82128902deb28 (refs/remotes/right)
	A	vronk
r17 = 3d987e350cb0b84c1a962f28322075148a4769f9 (refs/remotes/trunk)
	A	bang
	A	urkkk
	M	Makefile
Found merge parent (svn:mergeinfo prop): acd76c6201c8a7f1ba7539daebe82128902deb28
r18 = 33a71c4853e3bc75096416afb6b6a3f84317e11f (refs/remotes/left-sub)
	A	wham_eth
r19 = c18b93e7676efb39156e30479f389f162e075937 (refs/remotes/left-sub)
	A	glurpp
r20 = d3a5e11772cce14223736862eaae254c6361de52 (refs/remotes/left)
	A	wham_eth
W:svn cherry-pick ignored (/branches/left-sub:19) - missing 6 commit(s) (eg 0f51792c59119f80d15583143eecc11a609f7f4b)
r21 = 26f066648b9fbb8d41953f51720855ea7b504643 (refs/remotes/left)
	A	bang
	A	urkkk
	M	Makefile
	A	README
Found merge parent (svn:mergeinfo prop): c18b93e7676efb39156e30479f389f162e075937
r22 = 873f392f3b5b995738db38ddb497e4133a1eabd6 (refs/remotes/left)
	A	urkkk
	A	glurpp
	A	wham_eth
	A	README
	A	zlonk
Found merge parent (svn:mergeinfo prop): 873f392f3b5b995738db38ddb497e4133a1eabd6
r23 = 10f41d438deef69896cd202a8dba696fccb1fc16 (refs/remotes/trunk)
r24 = 8d72d496d3fd4fe5f56c4a458bb6b6bce8074ac3 (refs/remotes/trunk)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/b1, 24
Found branch parent: (refs/remotes/b1) 8d72d496d3fd4fe5f56c4a458bb6b6bce8074ac3
Following parent with do_switch
Successfully followed parent
r25 = 9583bc1ca96e396c2e8a6afbe0d7677c952e76f9 (refs/remotes/b1)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/b2, 25
Found branch parent: (refs/remotes/b2) 8d72d496d3fd4fe5f56c4a458bb6b6bce8074ac3
Following parent with do_switch
Successfully followed parent
r26 = b956cd3ea8808cb0732e51412dec60ce5d4c66de (refs/remotes/b2)
	A	b2file
r27 = 689fa6c27d1d57acd4f5e2ed3b78bfd3818cfa48 (refs/remotes/b2)
	A	b1file
r28 = c65e9d2dd0f29cc8756c66041aafca5ae7b40c87 (refs/remotes/b1)
	A	b1file
Found merge parent (svn:mergeinfo prop): c65e9d2dd0f29cc8756c66041aafca5ae7b40c87
r29 = 8a70eced3c8b9eb56742bb2b8182d3363ef65c9c (refs/remotes/trunk)
	A	trunkfile
r30 = 94dd10334175598f49a097035fcfba8563928048 (refs/remotes/trunk)
	A	b1file
	A	trunkfile
Found merge parent (svn:mergeinfo prop): c65e9d2dd0f29cc8756c66041aafca5ae7b40c87
W:svn cherry-pick ignored (/trunk:26-30) - missing 1 commit(s) (eg c65e9d2dd0f29cc8756c66041aafca5ae7b40c87)
r31 = 49faca9dc648191ba6b07f6b65f3373cc5a181e6 (refs/remotes/b2)
	A	b2file
Found merge parent (svn:mergeinfo prop): 49faca9dc648191ba6b07f6b65f3373cc5a181e6
r32 = 9e1737778e06d26dc2fb72c05db08520d6cd20af (refs/remotes/trunk)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/f1, 32
Found branch parent: (refs/remotes/f1) 9e1737778e06d26dc2fb72c05db08520d6cd20af
Following parent with do_switch
	A	f1file
Successfully followed parent
r33 = 72393572fd4bb0d02ef034f768738c9b1360ad86 (refs/remotes/f1)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/f2, 33
Found branch parent: (refs/remotes/f2) 9e1737778e06d26dc2fb72c05db08520d6cd20af
Following parent with do_switch
	A	f2file
Successfully followed parent
r34 = 600530ec4ff61c1bb60f7e9a1319390b9696ea89 (refs/remotes/f2)
	A	f1file
	A	f2file
Found merge parent (svn:mergeinfo prop): 72393572fd4bb0d02ef034f768738c9b1360ad86
Found merge parent (svn:mergeinfo prop): 600530ec4ff61c1bb60f7e9a1319390b9696ea89
r35 = 794650a0042fc4b45352798bd3d766ec71936859 (refs/remotes/trunk)
	A	subdir/cowboy
r36 = 71b29806ce50e7abcebc021bddd47ea9925b62d1 (refs/remotes/left)
	A	subdir/cowboy
Found merge parent (svn:mergeinfo prop): 71b29806ce50e7abcebc021bddd47ea9925b62d1
r37 = 595aa4a85d3687795a49eed9fd2774609e0bc0eb (refs/remotes/trunk)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk/subdir => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/partial, 37
Initializing parent: refs/remotes/partial@37
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left/subdir => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk/subdir, 36
Initializing parent: refs/remotes/partial@36
	A	cowboy
r36 = 36ab2d3b9d077028fa3d659325ac8ca081e348bc (refs/remotes/partial@36)
Found branch parent: (refs/remotes/partial@37) 36ab2d3b9d077028fa3d659325ac8ca081e348bc
Following parent with do_switch
Successfully followed parent
r37 = 94ef88aa1ebfb64b5525f3aed8dd36d7ec63cecc (refs/remotes/partial@37)
Found branch parent: (refs/remotes/partial) 94ef88aa1ebfb64b5525f3aed8dd36d7ec63cecc
Following parent with do_switch
Successfully followed parent
r38 = 910f886650e45984540884fbce419222d5dbe772 (refs/remotes/partial)
	A	palindromes
r39 = fdb537791ee8ba532e49c3d5a34a30feeb87bd59 (refs/remotes/partial)
	A	subdir/palindromes
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/b1/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/b2/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/f1/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/f2/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left-sub/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/right/subdir
W: Cannot find common ancestor between 595aa4a85d3687795a49eed9fd2774609e0bc0eb and fdb537791ee8ba532e49c3d5a34a30feeb87bd59. Ignoring merge info.
r40 = 5805f49f999decd809f915d18f383d07d1626d5b (refs/remotes/trunk)
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0 => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/bugfix, 41
Initializing parent: refs/remotes/bugfix@41
Found possible branch point: file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk => file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0, 40
Found branch parent: (refs/remotes/bugfix@41) 5805f49f999decd809f915d18f383d07d1626d5b
Following parent with do_switch
Successfully followed parent
r41 = 4b3d91b566f045ddd4c362a1767cb925b66081e4 (refs/remotes/bugfix@41)
Found branch parent: (refs/remotes/bugfix) 4b3d91b566f045ddd4c362a1767cb925b66081e4
Following parent with do_switch
Successfully followed parent
r42 = 472a447664d739c39bcf87d5ad3a96212508ba39 (refs/remotes/bugfix)
	M	subdir/palindromes
r43 = f6db7ed2ea491ff68fc056942fa988c29a384e47 (refs/remotes/bugfix)
	M	subdir/palindromes
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/bugfix/subdir
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0/subdir
W: Cannot find common ancestor between 5805f49f999decd809f915d18f383d07d1626d5b and fdb537791ee8ba532e49c3d5a34a30feeb87bd59. Ignoring merge info.
Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0
Found merge parent (svn:mergeinfo prop): f6db7ed2ea491ff68fc056942fa988c29a384e47
r44 = 16ad9cdbb78d7f1daf1b223d9afc0d9459692ded (refs/remotes/trunk)
Checked out HEAD:
  file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk r44
*   ok 1: load svn dump

* expecting success: 
	unmarked=$(git rev-list --parents --all --grep=Merge |
		grep -v " .* " | cut -f1 -d" ")
	[ -z "$unmarked" ]
	
*   ok 2: all svn merges became git merge commits

* expecting success: 
	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
		grep " .* " | cut -f1 -d" ")
	[ -z "$bad_cherries" ]
	
*   ok 3: cherry picks did not become git merge commits

* expecting success: 
	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
		grep " .* " | cut -f1 -d" ")
	[ -z "$bad_non_merges" ]
	
*   ok 4: svn non-merge merge commits did not become git merge commits

* expecting success: 
	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
	merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
	[ -z "$not_reachable" ]
	
* FAIL 5: commit made to merged branch is reachable from the merge
	
		before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
		merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
		not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
		[ -z "$not_reachable" ]
		
make: *** [t9151-svn-mergeinfo.sh] Error 1

-- 
Eric Wong
