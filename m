From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Fri, 24 Jul 2009 07:35:06 +0200
Message-ID: <20090724053506.GB12855@atjola.homenet>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
 <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de>
 <7v8wievf20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 07:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUDRF-0001iy-Ip
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbZGXFfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 01:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZGXFfL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:35:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:49892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750779AbZGXFfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 01:35:10 -0400
Received: (qmail invoked by alias); 24 Jul 2009 05:35:08 -0000
Received: from i59F549ED.versanet.de (EHLO atjola.homenet) [89.245.73.237]
  by mail.gmx.net (mp022) with SMTP; 24 Jul 2009 07:35:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1845vcAW+g4wngTtn/xsnKeMmjRk7P0DB5daJV6+4
	fN3OwLd1b+/b83
Content-Disposition: inline
In-Reply-To: <7v8wievf20.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123902>

On 2009.07.23 22:13:43 -0700, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > diff --git a/commit.c b/commit.c
> > index a47fb4d..ef8e911 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -262,7 +262,7 @@ int parse_commit_buffer(struct commit *item, vo=
id *buffer, unsigned long size)
> >  		    bufptr[47] !=3D '\n')
> >  			return error("bad parents in commit %s", sha1_to_hex(item->obje=
ct.sha1));
> >  		bufptr +=3D 48;
> > -		if (graft)
> > +		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
> >  			continue;
>=20
> Hmm, what is this "if it is negative" check for?  I did not see it
> mentioned in the proposed commit log message.

That's for the special grafts for shallow clones. They override the
other grafts, and are identified by the negative nr_parent value. Those
have to stay in effect as the original parents aren't present in the
repo.

Bj=F6rn
