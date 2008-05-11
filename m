From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 16:04:31 +0300
Message-ID: <4826EEDF.4010404@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 11 15:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvBF5-00046w-9Z
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYEKNEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYEKNEl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 09:04:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:28258 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYEKNEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 09:04:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so510694ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=Awi2mEj8FDX65Au9Rlp7txJc9S9LIXmuyp3zCTV5GS4=;
        b=Qp8pYnsQ3j+f4Ds3MKI9VFQkphxcv9+vjTes9eIdB26V+ovfiFeAjaFw4NApSM+D6Yo12b3l4KbvjRzrcpE7nafFUGNJt/GefoG873hjFLicx4tgGUmUyZW7avadnzX/euNbtmg9O7aRGoy1IjKt0562UHh1CWj12YuM+ToVnB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=xPGqZoK3wdRqPFgQW8d+zrxVhhAyrzxaW2RH4VSaMCsv99fMHv1N91SM1gIkRP7kwY+gxg8sCAXnxM8aeo3NZLijhD5QR/ya7MoN15akle32Omo1QluSeoVJ+JXVLlmi3iU0/SsdXsrUoRztVRPI1B67r/+nZA7HeOe0BACqc8I=
Received: by 10.66.248.5 with SMTP id v5mr4101313ugh.14.1210511076920;
        Sun, 11 May 2008 06:04:36 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id g9sm13061993gvc.0.2008.05.11.06.04.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 06:04:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080511125722.GA22075@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81769>

Bj=F6rn Steinbrink wrote:
> On 2008.05.11 15:33:21 +0300, Dima Kagan wrote:
>>>> Basically I see that the same file I edited on the 'test_branch'
>>>> branch appears to be modified on the 'master' branch as well. This
>>>> behavior is unwanted, of course.
>>>>
>>>> Can someone please tell me, what am doing wrong? Or is this git's
>>>> normal behavior?
>> I just realized that this behavior is even more confusing.  If I
>> commit the file on 'test_branch' and only then 'git checkout master'
>> the changes are not visible on 'master' until I merge. So why should
>> 'master' be affected by uncommitted changes on some branch???
>=20
> Uncommitted changes are not on any branch, they are in your working t=
ree
> and/or your index. And actually, SVN does the exact same thing.
>=20
> # Create a SVN repository with trunk/ and branches/
> # ----
> $ mkdir svn
> $ cd svn
> $ svnadmin create repo
> $ export REPO=3D"file://$PWD/repo"
> $ svn co $REPO wc
> Checked out revision 0.
> $ cd wc
> $ svn mkdir trunk branches
> A         trunk
> A         branches
> $ svn commit -m init
> Adding         branches
> Adding         trunk
>=20
> Committed revision 1.
> $ svn switch $REPO/trunk
> D    trunk
> D    branches
> Updated to revision 1.
>=20
>=20
> # Create some content in trunk
> # ----
> $ echo 123 > testfile
> $ svn add testfile
> A         testfile
> $ svn commit -m test
> Adding         testfile
> Transmitting file data .
> Committed revision 2.
>=20
>=20
> # Create a branch
> # ----
> $ svn cp $REPO/trunk $REPO/branches/b1 -m branch
>=20
> Committed revision 3.
>=20
>=20
> # Produce some uncommitted changes on trunk
> # ----
> $ echo 456 > testfile
> $ svn st
> M      testfile
> $ svn diff
> Index: testfile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testfile    (revision 2)
> +++ testfile    (working copy)
> @@ -1 +1 @@
> -123
> +456
>=20
>=20
> # Switch to the branch
> # ----
> $ svn switch $REPO/branches/b1
> At revision 3.
> $ svn st
> M      testfile
> $ svn diff
> Index: testfile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testfile    (revision 3)
> +++ testfile    (working copy)
> @@ -1 +1 @@
> -123
> +456
>=20
>=20
> The uncommitted changes survived the branch change and are still in t=
he
> working tree, in svn just like in git.
>=20
> Bj=F6rn

Yes, I am aware of that, except one rarely works in one directory on mu=
ltiple svn branches, because the branches are not private. Git's branch=
es can be private, so perhaps this behavior should be different from SV=
N?

BTW, Is there a way to do 'svn checkout -b new_branch' into a new direc=
tory?
