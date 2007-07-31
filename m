From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a
	strbuf.
Date: Tue, 31 Jul 2007 11:33:52 -0400
Message-ID: <1185896032.11086.57.camel@hinata.boston.redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
	 <11858309311728-git-send-email-krh@redhat.com>
	 <11858309322006-git-send-email-krh@redhat.com>
	 <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
	 <1185891786.11086.40.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0707311554220.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFtk7-0006CE-47
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 17:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbXGaPeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 11:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbXGaPeg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 11:34:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbXGaPef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 11:34:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFYFmI017304;
	Tue, 31 Jul 2007 11:34:15 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFYF2f026177;
	Tue, 31 Jul 2007 11:34:15 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFYEIu032188;
	Tue, 31 Jul 2007 11:34:14 -0400
In-Reply-To: <Pine.LNX.4.64.0707311554220.14781@racer.site>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54360>

On Tue, 2007-07-31 at 15:55 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 31 Jul 2007, Kristian H?gsberg wrote:
>=20
> > On Mon, 2007-07-30 at 21:36 -0700, Junio C Hamano wrote:
> > > Kristian H=C3=B8gsberg <krh@redhat.com> writes:
> > >=20
> > > > +static void inline strbuf_grow(struct strbuf *sb, size_t extra=
)
> > > > +{
> > > > +	while (sb->alloc < sb->len + extra)
> > > >  		sb->alloc =3D sb->alloc * 3 / 2 + 16;
> > > > +	sb->buf =3D xrealloc(sb->buf, sb->alloc);
> > > > +}
> > >=20
> > > Somehow this while () loop to compute the growth factor bothers
> > > me but that is probably a minor detail.
> >=20
> > Think of it as a more efficient way of adding one character at a ti=
me :)
> > And it's logarithmic in the number of extra bytes.  By the way, I
> > normally just double the size in these cases, which gives you amort=
ized
> > linear performance for adding to the buffer.  What's behind the * 3=
 / 2
> > idea?
>=20
> But why not
>=20
> 	sb->alloc =3D alloc_nr(sb->len + extra);

That should work, or even ALLOC_GROW, I guess.  Didn't know about those
macros.  But still, why not just double the size?

Kristian
