From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix quick-install-doc
Date: Sun, 05 Aug 2007 00:09:33 +0200
Message-ID: <46B4F91D.1070907@lsrfire.ath.cx>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site> <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site> <46B4BDCF.9060809@gmail.com> <Pine.LNX.4.64.0708042229130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:09:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRoe-0008Ul-3a
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764796AbXHDWJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762704AbXHDWJl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:09:41 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59975
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761515AbXHDWJk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 18:09:40 -0400
Received: from [10.0.1.201] (p508EBCE0.dip.t-dialin.net [80.142.188.224])
	by neapel230.server4you.de (Postfix) with ESMTP id 953058B008;
	Sun,  5 Aug 2007 00:09:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0708042229130.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54912>

Johannes Schindelin schrieb:
> The recent work-tree cleanups exposed that the install-doc-quick
> script was relying on a strange behaviour predating the work-tree
> series: when setting a GIT_DIR, it was assumed that the current
> working directory is the root of the working tree.
>=20
> The recent work-tree series changed that behaviour: now that you can
> set the work tree explicitely, the work tree root defaults to
> $GIT_DIR/.. if $GIT_DIR has a /.git suffix when that is a parent
> directory of the current working directory.

> -git checkout-index -a -f --prefix=3D"$mandir"/
> +(cd "$mandir"; git checkout-index -a -f)

That won't work if $mandir doesn't exist, which can happen if you
install the manpages for the first time.  Simply add a mkdir:

   (mkdir -p "$mandir" && cd "$mandir" && git checkout-index -a -f)

Ren=E9
