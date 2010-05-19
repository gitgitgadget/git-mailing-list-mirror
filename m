From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to 
	stop git-svn
Date: Wed, 19 May 2010 14:17:52 -0700
Message-ID: <AANLkTinGV0UpqcXghlxmEqsjds2Up8fZkZ7AQArPr0N2@mail.gmail.com>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> 
	<1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> 
	<4BCF8E07.9080507@vilain.net> <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com> 
	<20100503211942.GA1380@dcvr.yhbt.net> <4BDFC171.5010103@drmicha.warpmail.net> 
	<20100504183452.GA30894@dcvr.yhbt.net> <1273010555.20723.17.camel@denix> 
	<20100504231640.GA5075@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Tim Stoakes <tim@stoakes.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 19 23:18:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEqei-0003sC-CA
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 23:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab0ESVSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 17:18:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40156 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0ESVSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 17:18:14 -0400
Received: by vws9 with SMTP id 9so4213674vws.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 14:18:12 -0700 (PDT)
Received: by 10.220.122.29 with SMTP id j29mr4735499vcr.162.1274303892282; 
	Wed, 19 May 2010 14:18:12 -0700 (PDT)
Received: by 10.220.85.11 with HTTP; Wed, 19 May 2010 14:17:52 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <20100504231640.GA5075@dcvr.yhbt.net>
X-Google-Sender-Auth: R0uYGifgMJltAw27qqflBAJaRco
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147349>

On Tue, May 4, 2010 at 4:16 PM, Eric Wong <normalperson@yhbt.net> wrote=
:
> I'm using SVN 1.5.1 and getting the following error from
> t9151-svn-mergeinfo.sh (GIT_TEST_OPTS=3D'-i -v'):
>
> (I haven't had many chances to look into this)
>
> *** t9151-svn-mergeinfo.sh ***
> Initialized empty Git repository in /home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/.git/
> * expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0svnadmin load -q '/home/ew/git-core/t/tras=
h directory.t9151-svn-mergeinfo/svnrepo' =C2=A0 =C2=A0 =C2=A0 =C2=A0< '=
/home/ew/git-core/t/t9151/svn-mergeinfo.dump' &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git svn init --minimize-url -R svnmerge =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --rewrite-root=3Dhttp://svn.example.org=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -T trunk -b branches 'file:///home/=
ew/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo' &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git svn fetch --all
>
> r1 =3D 7ed7a8721885457b4b334110ca70ed04c4f8166a (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 Makefile
> r2 =3D 2d5fcce57cec73616f628fbaed5a49ef3d0e42de (refs/remotes/trunk)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/left, 1
> Found branch parent: (refs/remotes/left) 7ed7a8721885457b4b334110ca70=
ed04c4f8166a
> Following parent with do_switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 Makefile
> Successfully followed parent
> r3 =3D f9ab6c8a604f40729e9b681bb3a1e867f9fa3ae8 (refs/remotes/left)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/right, 1
> Found branch parent: (refs/remotes/right) 7ed7a8721885457b4b334110ca7=
0ed04c4f8166a
> Following parent with do_switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 Makefile
> Successfully followed parent
> r4 =3D ddaeba46f3443446ad10c8e9f9708015508a3b28 (refs/remotes/right)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> r5 =3D aec3f7b969e8f39a07d95041e1a0fa1084a62636 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> r6 =3D 4e8f83f1ab23aef5373017e90af34f1819af8cab (refs/remotes/right)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> r7 =3D 6bc3353f7fcec0c37010a59b688fa9d2584a744d (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> r8 =3D 3126dfd1119e03e412157f726d08c90a3fd4d7d4 (refs/remotes/left)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/branches/left =3D> file:///home/ew/git-c=
ore/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/left-sub, 3
> Found branch parent: (refs/remotes/left-sub) f9ab6c8a604f40729e9b681b=
b3a1e867f9fa3ae8
> Following parent with do_switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> Successfully followed parent
> r9 =3D 577c6d95762177126ca3068518ff8b75fcf0c25e (refs/remotes/left-su=
b)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 README
> r10 =3D 0f51792c59119f80d15583143eecc11a609f7f4b (refs/remotes/left-s=
ub)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> Found merge parent (svn:mergeinfo prop): 3126dfd1119e03e412157f726d08=
c90a3fd4d7d4
> r11 =3D 684711c1a28ba8ad47b8dbcc1fae523e6d7513a6 (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 zlonk
> r12 =3D 48e21141201f46c911875b76b5656d8baac09a66 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 bang
> r13 =3D 2d65500a924079bcf2a63be861289fc72bc3e87f (refs/remotes/right)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 bang
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> W:svn cherry-pick ignored (/branches/right:6-13) - missing 1 commit(s=
) (eg ddaeba46f3443446ad10c8e9f9708015508a3b28)
> r14 =3D 963722fb11bb2d08a6acd03123060441585c7d97 (refs/remotes/trunk)
> Found merge parent (svn:mergeinfo prop): 2d65500a924079bcf2a63be86128=
9fc72bc3e87f
> r15 =3D 7a0288891e49f8f764fafb9c51e0da446284f6e3 (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 urkkk
> r16 =3D acd76c6201c8a7f1ba7539daebe82128902deb28 (refs/remotes/right)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 vronk
> r17 =3D 3d987e350cb0b84c1a962f28322075148a4769f9 (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 bang
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 urkkk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> Found merge parent (svn:mergeinfo prop): acd76c6201c8a7f1ba7539daebe8=
2128902deb28
> r18 =3D 33a71c4853e3bc75096416afb6b6a3f84317e11f (refs/remotes/left-s=
ub)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 wham_eth
> r19 =3D c18b93e7676efb39156e30479f389f162e075937 (refs/remotes/left-s=
ub)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 glurpp
> r20 =3D d3a5e11772cce14223736862eaae254c6361de52 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 wham_eth
> W:svn cherry-pick ignored (/branches/left-sub:19) - missing 6 commit(=
s) (eg 0f51792c59119f80d15583143eecc11a609f7f4b)
> r21 =3D 26f066648b9fbb8d41953f51720855ea7b504643 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 bang
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 urkkk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 Makefile
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 README
> Found merge parent (svn:mergeinfo prop): c18b93e7676efb39156e30479f38=
9f162e075937
> r22 =3D 873f392f3b5b995738db38ddb497e4133a1eabd6 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 urkkk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 glurpp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 wham_eth
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 README
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 zlonk
> Found merge parent (svn:mergeinfo prop): 873f392f3b5b995738db38ddb497=
e4133a1eabd6
> r23 =3D 10f41d438deef69896cd202a8dba696fccb1fc16 (refs/remotes/trunk)
> r24 =3D 8d72d496d3fd4fe5f56c4a458bb6b6bce8074ac3 (refs/remotes/trunk)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/b1, 24
> Found branch parent: (refs/remotes/b1) 8d72d496d3fd4fe5f56c4a458bb6b6=
bce8074ac3
> Following parent with do_switch
> Successfully followed parent
> r25 =3D 9583bc1ca96e396c2e8a6afbe0d7677c952e76f9 (refs/remotes/b1)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/b2, 25
> Found branch parent: (refs/remotes/b2) 8d72d496d3fd4fe5f56c4a458bb6b6=
bce8074ac3
> Following parent with do_switch
> Successfully followed parent
> r26 =3D b956cd3ea8808cb0732e51412dec60ce5d4c66de (refs/remotes/b2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 b2file
> r27 =3D 689fa6c27d1d57acd4f5e2ed3b78bfd3818cfa48 (refs/remotes/b2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 b1file
> r28 =3D c65e9d2dd0f29cc8756c66041aafca5ae7b40c87 (refs/remotes/b1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 b1file
> Found merge parent (svn:mergeinfo prop): c65e9d2dd0f29cc8756c66041aaf=
ca5ae7b40c87
> r29 =3D 8a70eced3c8b9eb56742bb2b8182d3363ef65c9c (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 trunkfile
> r30 =3D 94dd10334175598f49a097035fcfba8563928048 (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 b1file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 trunkfile
> Found merge parent (svn:mergeinfo prop): c65e9d2dd0f29cc8756c66041aaf=
ca5ae7b40c87
> W:svn cherry-pick ignored (/trunk:26-30) - missing 1 commit(s) (eg c6=
5e9d2dd0f29cc8756c66041aafca5ae7b40c87)
> r31 =3D 49faca9dc648191ba6b07f6b65f3373cc5a181e6 (refs/remotes/b2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 b2file
> Found merge parent (svn:mergeinfo prop): 49faca9dc648191ba6b07f6b65f3=
373cc5a181e6
> r32 =3D 9e1737778e06d26dc2fb72c05db08520d6cd20af (refs/remotes/trunk)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/f1, 32
> Found branch parent: (refs/remotes/f1) 9e1737778e06d26dc2fb72c05db085=
20d6cd20af
> Following parent with do_switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 f1file
> Successfully followed parent
> r33 =3D 72393572fd4bb0d02ef034f768738c9b1360ad86 (refs/remotes/f1)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/branches/f2, 33
> Found branch parent: (refs/remotes/f2) 9e1737778e06d26dc2fb72c05db085=
20d6cd20af
> Following parent with do_switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 f2file
> Successfully followed parent
> r34 =3D 600530ec4ff61c1bb60f7e9a1319390b9696ea89 (refs/remotes/f2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 f1file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 f2file
> Found merge parent (svn:mergeinfo prop): 72393572fd4bb0d02ef034f76873=
8c9b1360ad86
> Found merge parent (svn:mergeinfo prop): 600530ec4ff61c1bb60f7e9a1319=
390b9696ea89
> r35 =3D 794650a0042fc4b45352798bd3d766ec71936859 (refs/remotes/trunk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 subdir/cowboy
> r36 =3D 71b29806ce50e7abcebc021bddd47ea9925b62d1 (refs/remotes/left)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 subdir/cowboy
> Found merge parent (svn:mergeinfo prop): 71b29806ce50e7abcebc021bddd4=
7ea9925b62d1
> r37 =3D 595aa4a85d3687795a49eed9fd2774609e0bc0eb (refs/remotes/trunk)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk/subdir =3D> file:///home/ew/git-co=
re/t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/partial, 37
> Initializing parent: refs/remotes/partial@37
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/branches/left/subdir =3D> file:///home/e=
w/git-core/t/trash directory.t9151-svn-mergeinfo/svnrepo/trunk/subdir, =
36
> Initializing parent: refs/remotes/partial@36
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 cowboy
> r36 =3D 36ab2d3b9d077028fa3d659325ac8ca081e348bc (refs/remotes/partia=
l@36)
> Found branch parent: (refs/remotes/partial@37) 36ab2d3b9d077028fa3d65=
9325ac8ca081e348bc
> Following parent with do_switch
> Successfully followed parent
> r37 =3D 94ef88aa1ebfb64b5525f3aed8dd36d7ec63cecc (refs/remotes/partia=
l@37)
> Found branch parent: (refs/remotes/partial) 94ef88aa1ebfb64b5525f3aed=
8dd36d7ec63cecc
> Following parent with do_switch
> Successfully followed parent
> r38 =3D 910f886650e45984540884fbce419222d5dbe772 (refs/remotes/partia=
l)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 palindromes
> r39 =3D fdb537791ee8ba532e49c3d5a34a30feeb87bd59 (refs/remotes/partia=
l)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 subdir/palindromes
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/b1/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/b2/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/f1/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/f2/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/left/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/left-sub/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/right/subdir
> W: Cannot find common ancestor between 595aa4a85d3687795a49eed9fd2774=
609e0bc0eb and fdb537791ee8ba532e49c3d5a34a30feeb87bd59. Ignoring merge=
 info.
> r40 =3D 5805f49f999decd809f915d18f383d07d1626d5b (refs/remotes/trunk)
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/tags/v1.0 =3D> file:///home/ew/git-core/=
t/trash directory.t9151-svn-mergeinfo/svnrepo/branches/bugfix, 41
> Initializing parent: refs/remotes/bugfix@41
> Found possible branch point: file:///home/ew/git-core/t/trash directo=
ry.t9151-svn-mergeinfo/svnrepo/trunk =3D> file:///home/ew/git-core/t/tr=
ash directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0, 40
> Found branch parent: (refs/remotes/bugfix@41) 5805f49f999decd809f915d=
18f383d07d1626d5b
> Following parent with do_switch
> Successfully followed parent
> r41 =3D 4b3d91b566f045ddd4c362a1767cb925b66081e4 (refs/remotes/bugfix=
@41)
> Found branch parent: (refs/remotes/bugfix) 4b3d91b566f045ddd4c362a176=
7cb925b66081e4
> Following parent with do_switch
> Successfully followed parent
> r42 =3D 472a447664d739c39bcf87d5ad3a96212508ba39 (refs/remotes/bugfix=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subdir/palindromes
> r43 =3D f6db7ed2ea491ff68fc056942fa988c29a384e47 (refs/remotes/bugfix=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subdir/palindromes
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/branches/bugfix/subdir
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/tags/v1.0/subdir
> W: Cannot find common ancestor between 5805f49f999decd809f915d18f383d=
07d1626d5b and fdb537791ee8ba532e49c3d5a34a30feeb87bd59. Ignoring merge=
 info.
> Couldn't find revmap for file:///home/ew/git-core/t/trash directory.t=
9151-svn-mergeinfo/svnrepo/tags/v1.0
> Found merge parent (svn:mergeinfo prop): f6db7ed2ea491ff68fc056942fa9=
88c29a384e47
> r44 =3D 16ad9cdbb78d7f1daf1b223d9afc0d9459692ded (refs/remotes/trunk)
> Checked out HEAD:
> =C2=A0file:///home/ew/git-core/t/trash directory.t9151-svn-mergeinfo/=
svnrepo/trunk r44
> * =C2=A0 ok 1: load svn dump
>
> * expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unmarked=3D$(git rev-list --parents --all =
--grep=3DMerge |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grep -v " .* "=
 | cut -f1 -d" ")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -z "$unmarked" ]
>
> * =C2=A0 ok 2: all svn merges became git merge commits
>
> * expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bad_cherries=3D$(git rev-list --parents --=
all --grep=3DCherry |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grep " .* " | =
cut -f1 -d" ")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -z "$bad_cherries" ]
>
> * =C2=A0 ok 3: cherry picks did not become git merge commits
>
> * expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bad_non_merges=3D$(git rev-list --parents =
--all --grep=3Dnon-merge |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grep " .* " | =
cut -f1 -d" ")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -z "$bad_non_merges" ]
>
> * =C2=A0 ok 4: svn non-merge merge commits did not become git merge c=
ommits
>
> * expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0before_commit=3D$(git rev-list --all --gre=
p=3D"trunk commit before merging trunk to b2")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0merge_commit=3D$(git rev-list --all --grep=
=3D"Merge trunk to b2")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not_reachable=3D$(git rev-list -1 $before_=
commit --not $merge_commit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -z "$not_reachable" ]
>
> * FAIL 5: commit made to merged branch is reachable from the merge
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0before_commit=3D=
$(git rev-list --all --grep=3D"trunk commit before merging trunk to b2"=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0merge_commit=3D=
$(git rev-list --all --grep=3D"Merge trunk to b2")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not_reachable=3D=
$(git rev-list -1 $before_commit --not $merge_commit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -z "$not_rea=
chable" ]
>
> make: *** [t9151-svn-mergeinfo.sh] Error 1
>
> --
> Eric Wong
>

I tried looking at it, but the situation is kind of odd.  Neither
$before_commit nor $merge_commit appears in each others' git log
output, so it would seem that the test ought to pass.  The rev-list
command returns the revision ID of $before_commit, which causes the
test to fail.

--=20
Michael Olson  |  http://mwolson.org/
