From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
Date: Fri, 02 Sep 2005 09:23:09 +0100
Message-ID: <1125649389.6928.19.camel@baythorne.infradead.org>
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751114AbVIBIXd@vger.kernel.org Fri Sep 02 10:25:14 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751114AbVIBIXd@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB6py-0007vd-OA
	for glk-linux-kernel-3@gmane.org; Fri, 02 Sep 2005 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVIBIXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 2 Sep 2005 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIBIXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 04:23:33 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:50060 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750851AbVIBIXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 04:23:32 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EB6pK-00057E-Af; Fri, 02 Sep 2005 09:23:10 +0100
To: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8009>

On Wed, 2005-08-31 at 15:34 +0200, Tomasz K=C2=B3oczko wrote:
> Seems patches stored on ftp://ftp.kernel.org/pub/linux/kernel/v2.6/sn=
apshots
> are empty (only logs are correct):

> -rw-r--r--    1 536      536            20 Aug 30 09:01 patch-2.6.13-=
git1.gz
> -rw-r--r--    1 536      536            20 Aug 31 09:01 patch-2.6.13-=
git2.gz

Hm. git-diff-cache now refuses to operate unless there's a local
'.git/refs' directory, even when working with a separate object
directory. So this doesn't work any more...

	rm -rf tmp-empty-tree
	mkdir -p tmp-empty-tree/.git
	cd tmp-empty-tree

	git-read-tree $CURCOMM
	git-checkout-cache Makefile
	perl -pi -e "s/EXTRAVERSION =3D.*/EXTRAVERSION =3D $EXTRAVERSION/" Mak=
efile
	git-diff-cache -m -p $RELTREE | gzip -9 > $STAGE/patch-$CURNAME.gz

I've changed the script to create 'tmp-empty-tree/.git/refs' and
replaced 2.6.13-git[12] with real patches.

> Also it will be good move all patch-2.6.12* and patch-2.6.13-rc* file=
s=20
> from this directory to old subdirectory.

Done.

--=20
dwmw2
