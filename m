From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 17:57:59 +0100
Message-ID: <200902101758.00062.robin.rosenberg@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902100807.40417.robin.rosenberg@dewire.com> <7viqninuzv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvxV-00044e-CU
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbZBJQ6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 11:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZBJQ6O
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:58:14 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:49374 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbZBJQ6N convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:58:13 -0500
Received: from sleipner.localnet (217.213.254.47) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB03BC701E; Tue, 10 Feb 2009 17:58:07 +0100
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7viqninuzv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109275>

tisdag 10 februari 2009 16:59:16 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>=20
> > m=C3=A5ndag 09 februari 2009 07:04:46 skrev Junio C Hamano:
> >> What's troubling more is that this would seem to leave the result =
even
> >> more inconsistent if there are more than one packs that need to be
> >> replaced.
> >
> > Why? We don't prune the old objects if we fail. The result might be=
 a lot
> > of redundancy, but nothing should be lost.
>=20
> I was not talking about any loss.  The result would be a funny mixtur=
e of
> permutations of {old-,}pack-*.{pack,idx} the user needs to match up a=
fter

We don't leave old-files around unless we go very very wrong and only i=
n
that case would be leave "old"-files for one pack around and only if gc=
 wants
to replace a pack with the same name. That would not be fatal and the
user can continue repacking to get rid of the redundant stuff once the =
cause
of them problem is fixed.=20

=46or the simple case of "failure" I recover and return 0 (but don't pr=
une the
old packs), because no damage is done so I don't expect anyone to actua=
lly even try manual cleanup and why should they?

=46or the hard case, the user seek advice because I cannot image what
would be the cause. Today even a simple and likely problem will cause a=
 fatal
corruption of the repo and that is my concern right now, not what happe=
ns
when the disk fails in between the mv's.

> figuring out what corresponds with what other one, and I think an exp=
ert
> who is asked for help would have hard time matching them up too, even
> though that is what you suggested in the message.
>=20
> That troubled me and I was wondering if we can make the recovery simp=
ler
> for the users.

-- robin
