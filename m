From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 11:42:02 -0500
Message-ID: <20080725164202.GC21117@spearce.org>
References: <alpine.DEB.1.00.0807241821440.8986@racer> <7vy73q4jzp.fsf@gitster.siamese.dyndns.org> <20080725115519.GA32487@atjola.homenet> <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bjjjrn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:43:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQNp-0007bv-RS
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbYGYQmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYGYQmF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:42:05 -0400
Received: from george.spearce.org ([209.20.77.23]:42044 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYGYQmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:42:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F2F98383A5; Fri, 25 Jul 2008 16:42:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90070>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 25 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
> > On 2008.07.24 22:21:14 -0700, Junio C Hamano wrote:
> > > Reading get_data_from_pack(), it does rely on hdr_size, idx.offse=
t and=20
> > > idx.offset of the next entry to be set correctly.  The function d=
oes=20
> > > not seem to use type (which the patch is also setting) nor real_t=
ype=20
> > > (which the patch does not set).
> >=20
> > type is used in get_base_data().
> >=20
> > > However, the code checks objects[nth].real_type all over the plac=
e in=20
> > > the code.  Doesn't the lack of real_type assignment in=20
> > > append_obj_to_pack() affect them in any way?
> >=20
> > I had thought that resolve_delta() would set that, but it seems tha=
t we=20
> > never call that function like that. Hm...
>=20
> So, let's add the comment as Nico suggested, and set real_type, too? =
 (And=20
> it would be smashing if you could verify that the type is indeed corr=
ectly=20
> set to non-delta...)
>=20
> I think that setting real_type is necessary to have less surprises wh=
en=20
> the code is extended in the future.

The patch looks correct, but it should set real_type too because
I'm pretty sure we use that when we unpack the delta base again if
it was pruned out of memory.

--=20
Shawn.
