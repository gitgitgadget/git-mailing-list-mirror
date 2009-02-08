From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 21:08:53 +0100
Message-ID: <200902082108.54048.robin.rosenberg.lists@dewire.com>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de> <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFz2-00009A-8M
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbZBHUJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 15:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbZBHUJA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:09:00 -0500
Received: from mail.dewire.com ([83.140.172.130]:20430 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbZBHUJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 15:09:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3671E147E880;
	Sun,  8 Feb 2009 21:08:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t7qvN76CIGcI; Sun,  8 Feb 2009 21:08:57 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B939D147E7FE;
	Sun,  8 Feb 2009 21:08:57 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109007>

s=F6ndag 08 februari 2009 21:00:57 skrev Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > My preliminary guess is that this code in pack-write.c needs to use=
 the=20
> > lock file paradigm:
> >
> >         if (!index_name) {
> > 		[...]
> >         } else {
> >                 unlink(index_name);
> >                 fd =3D open(index_name, O_CREAT|O_EXCL|O_WRONLY, 06=
00);
> >         }
>=20
> Whoa.  That particular code has been (and is still) correct.
>=20
> When repacking we should pack into a temporary pack and idx file and =
then
> replace the real ones after both new pack and its idx are successfull=
y
> written, and I thought that is how we've been doing this all the time=
=2E
> Maybe the caller has been broken at some point?  Sigh...

I intend to test something like this:
