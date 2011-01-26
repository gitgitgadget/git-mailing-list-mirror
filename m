From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 19:39:32 +0100
Message-ID: <4D406A64.1000200@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx> <m2y668yr6k.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 19:40:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiAHh-0005SM-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 19:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1AZSjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 13:39:55 -0500
Received: from india601.server4you.de ([85.25.151.105]:59095 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab1AZSjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 13:39:54 -0500
Received: from [192.168.2.104] (p4FFDB6DB.dip.t-dialin.net [79.253.182.219])
	by india601.server4you.de (Postfix) with ESMTPSA id 9B9CA2F8091
	for <git@vger.kernel.org>; Wed, 26 Jan 2011 19:39:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m2y668yr6k.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165529>

Am 26.01.2011 10:01, schrieb Francis Moreau:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> [...]
>=20
>> Hmm, seems like the function is gone since d847059.  Does all of thi=
s help
>> you in any way?
>=20
> Sigh... one more try, one more failure...
>=20
> This time I tried to use git-bisect(1) to see if I couldn't track the
> change more easily.
>=20
> So, here's what I did:
>=20
>     $ cat ./bisect.sh
>     #! /bin/sh
>    =20
>     if ! git grep -q -e blacklist_iommu -- drivers/pci/intel-iommu.c
>     then
>     	exit 1
>     fi
>=20
>     $ git bisect start v2.6.28 v2.6.27 -- drivers/pci
>     Bisecting: 70 revisions left to test after this (roughly 6 steps)
>     [a0bfb673dca8a2b4324fe11e678ec6d6a9ad67e0] Merge branch 'linux-ne=
xt' of
>     git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci-2.6
>=20
>     $ git bisect run ./bisect.sh=20
>     running /dev/shm/bisect.sh
>     Bisecting: 42 revisions left to test after this (roughly 5 steps)
>     [0235c4fc7fc6f621dc0dd89eba102ad5aa373390] PCI PM: Introduce func=
tion
>     pci_wake_from_d3
>     running /dev/shm/bisect.sh
>     error: The following untracked working tree files would be overwr=
itten
>     by checkout:
>        arch/x86/es7000/Makefile
>        arch/x86/es7000/es7000.h
>        arch/x86/es7000/es7000plat.c
>        drivers/pci/dma_remapping.h
>     Please move or remove them before you can switch branches.

These are untracked files; your tree is not clean.  Either commit them,
stash them away or delete the files.  Or make a local clone just for
bisecting purposes.

>     Bisecting: 18 revisions left to test after this (roughly 4 steps)
>     Aborting
>     bisect run failed:
>     'bisect_state bad' exited with error code 1
>=20
> Do you know what's going wrong ?

I tried the same and the result was:

	e61d98d8dad0048619bb138b0ff996422ffae53b is the first bad commit

But this probably won't help you much, either, as it is a regular commi=
t
which doesn't touch the function (it doesn't exist before and after it)=
=2E

I can only guess that bisect gets confused by the merges just like log
(and me).

Ren=E9
