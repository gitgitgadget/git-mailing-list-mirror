From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 10:35:17 +0200
Message-ID: <20080624083517.GA14185@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB40q-0002BW-6z
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYFXIfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 04:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYFXIfX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:35:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:42984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753077AbYFXIfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:35:21 -0400
Received: (qmail invoked by alias); 24 Jun 2008 08:35:18 -0000
Received: from i577BBBE6.versanet.de (EHLO atjola.local) [87.123.187.230]
  by mail.gmx.net (mp061) with SMTP; 24 Jun 2008 10:35:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+dC6dH3UCdo66E/2PThkYQISRykyhv36q+zT1okg
	N+9tjgJARR/iIt
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86016>

On 2008.06.24 08:08:13 -0000, David Jeske wrote:
> To re-ask the same question I asked in my last post, using your ascii
> pictures...
>=20
>=20
> Let's assume we're here..
>=20
> .<---.<---.<---A<---X<---Y    <--- master
> \
> \--B<---C    <--- customer_A_branch <=3D=3D=3D HEAD
>=20
>=20
> And this person and everyone else moves their head pointers back to m=
aster
> without merging:
>=20
>=20
> .<---.<---.<---A<---X<---Y    <--- master              <=3D=3D=3D HEA=
D
> \
> \--B<---C    <--- customer_A_branch
>=20
>=20
> Now, five years down the road, our tree looks like:
>=20
>=20
> .<---A<---X<---Y<---.<--.<--.(3 years of changes)<---ZZZ<--- master  =
<=3D=3D=3D HEAD
> \
> \--B<---C   <--- customer_A_branch
>=20
> And someone does:
>=20
> git-branch -f customer_A_branch ZZZ
>=20
> To bring us to:
>=20
> .<---A<---X<---Y<---.<--.(3 years of changes)<---ZZZ<--- master  <=3D=
=3D=3D HEAD
> \                                           \
> \--B<---C                                   \-- customer_A_branch
>=20
>=20
> ..at this point, will a GC keep "B<--C", or garbage collect the commi=
ts and
> throw them away?

That would throw away the changes in _that_ repository after the reflog
entry has expired. It would not affect any other repo yet, and if that
developer tries to push that new customer_A_branch, it would be refused=
,
because it is not a fast-forward. And if the repo he's trying to push t=
o
simply doesn't allow any non-fast-forward pushes, then even push -f
won't help him to destroy anything.

Bj=F6rn
