From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 15:10:41 +0200
Organization: Pardus / KDE
Message-ID: <200801121510.41501.ismail@pardus.org.tr>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 14:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDg7S-0002XJ-FP
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 14:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762577AbYALNJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 08:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759662AbYALNJW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 08:09:22 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:44483 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758612AbYALNJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 08:09:21 -0500
Received: from [192.168.1.3] (unknown [85.97.18.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 7F02761ED936;
	Sat, 12 Jan 2008 15:09:14 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071204.744707)
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70314>

Saturday 12 January 2008 11:04:32 tarihinde Jeff King =C5=9Funlar=C4=B1=
 yazm=C4=B1=C5=9Ft=C4=B1:
> On Sat, Jan 12, 2008 at 09:47:48AM +0200, Ismail D=C3=B6nmez wrote:
> > So looks like tests no longer work as root, so I run make test as n=
ormal
> > user and I now see t7300-clean.sh fail, this time a real failure:
> >
> > Removing part3.c
> > ./test-lib.sh: line 193: 19413 Aborted                 git-clean
> > * FAIL 5: git-clean with prefix
>
> I couldn't reproduce this just running the test, but running it under
> valgrind showed a memory access error. Fix is below.
>
> Junio, can you please sanity check this fix (it stops the valgrind
> error, but I want to make sure my assumptions about match_pathspec ar=
e
> right).
>
> -- >8 --
> git-clean: fix off-by-one memory access when given no arguments
>
> The "seen" variable is used by match_pathspec, and must have
> as many elements as there are in the given pathspec. We
> create the pathspec either from the command line arguments
> _or_ from just the current prefix.
>
> Thus allocating "seen" based upon just argc is wrong, since
> if argc =3D=3D 0, then we still have one pathspec, the prefix,
> but we don't allocate any space in "seen".
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks Jefff, this fixes t7300-clean.sh for me.

Tested-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>

Regards,
ismail


--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
