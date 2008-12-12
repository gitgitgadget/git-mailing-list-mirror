From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] gitweb: Optional grouping of projects by category
Date: Fri, 12 Dec 2008 10:26:06 +0100
Message-ID: <200812121026.07694.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <200812120303.56997.jnareb@gmail.com> <87y6ymxf4k.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 10:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB4JH-0000oa-8D
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 10:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbYLLJ0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Dec 2008 04:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756204AbYLLJ0X
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 04:26:23 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36937 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYLLJ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 04:26:20 -0500
Received: by ewy10 with SMTP id 10so1658702ewy.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WgB7ZdMio9dKMORCDASvUGO1y1YTUX+3lBKoTQxIW9k=;
        b=AG+rRuKd7/IbGkMHPrULO8QulNtVK83Ux6FCEzO3rh2HEwVxhlZR7W3NqE9WXKVQ5N
         Pf15qA2bqwv+RaTKYQUxDxBBU+jslS0jvLHAiVpT3dMQSiLXDSbBXFmw6SE9J1kKd81H
         +i8ivCT+rP6MrjaNqbro5WODXjyXZqCnokkP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=paT4u6qDnIp64rI0nTm1kdBvDnsfoOOokdcT8REXGlSR6fS+D7H8rCjCVJJR224rZA
         5z/bgNyI3INpJ9rOptybzq4Bfe6GpCYOjHZPjEfkhGq2GvclnoK6tRHzxQbx8Aq7jsYW
         P2YFzkM3igeo/Ni7ZR+cgbjwL6x200YlfxTFQ=
Received: by 10.210.119.16 with SMTP id r16mr3825871ebc.161.1229073978603;
        Fri, 12 Dec 2008 01:26:18 -0800 (PST)
Received: from ?192.168.1.11? (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id 5sm65436eyh.27.2008.12.12.01.26.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 01:26:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87y6ymxf4k.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102892>

On Fri, 12 Dec 2008, S=E9bastien Cevey wrote:
> At Fri, 12 Dec 2008 03:03:55 +0100, Jakub Narebski wrote:
>=20
> > And no, we don't need to sort by categories first.  Let me explain
> > in more detail a bit.
>=20
> Thanks for the detailed explanation, I understand your preference.
> But as you said, it's a bit arbitrary, I think none is completely
> obvious.

=46irst, I feel a bit bad for derailing this patch. Currently gitweb
does not do pagination of projects list; it is not even possible in
a sane way with current way project searching/selecting is implemented.
So the whole build_projlist_by_category() respecting $from and $to is
moot point.

So if we don't use it, even if it is nice to have for the future, we
don't need to pay cost of extra stable sorting.

>=20
> I don't really have a strong opinion about which is best, but just to
> illustrate what made me go for the solution B, let me show another
> example:
>=20
> name / date / cat
> 1      2006    A
> 2      2003    B
> 3      2005    B
> 4      2003    A
> 5      2000    A
> 6      2008    C
> 7      2007    C
> 8      2001    B
> 9      2005    A
>=20
> We then sort by name and split in pages of N=3D3 (sorted by cat on ea=
ch
> page):
>=20
> A:sort(name) split(max=3D3) subsort(cat)
>   1  2006  A     4  2003  A     9  2005  A
>   2  2003  B     5  2000  A     8  2001  B
>   3  2005  B     6  2008  C     7  2007  C
>=20
> B:sort(cat) subsort(name) split(max=3D3)
>   1  2006  A     9  2005  A     8  2001  B
>   4  2003  A     2  2003  B     6  2008  C
>   5  2000  A     3  2005  B     7  2007  C
>=20
> With B, we have the second top-entry (2) relegated to the second page=
,
> which might be surprising because we ordered by name.  But what I fin=
d
> weird about A is that because of the per-page category sorting, the
> "top-sorted entries at the top" isn't true either (page 3).  We have
> "reshuffled" the result of 'sort(name) split(max=3D3)' on each page.

[...]
> It's perhaps even more apparent if we sort by date:
>=20
> A:sort(year) split(max=3D3) subsort(cat)
>   1  2006  A     9  2005  A     4  2003  A
>   6  2008  C     3  2005  B     5  2000  A
>   7  2007  C     2  2003  B     8  2001  B
>=20
> B:sort(cat) subsort(year) split(max=3D4)
>   1  2006  A     4  2003  A     3  2005  B
>   9  2005  A     8  2001  B     7  2007  C
>   5  2000  A     2  2003  B     6  2008  C
>=20
> It feels kind of unnatural that not only projects are not sorted by
> date on each page (they are inside categories), but moreover
> categories are spread over all pages.
>=20
>=20
> I guess it depends on your use case, and whether categories are
> important or known by the user.  I personally don't really care (I
> never split stuff into pages in the gitweb I use), so I can do a new
> version of my patch that does A if you prefer, just let me know.  I
> just wanted to clarify that both solutions sort of suck :-)

Well, with version A you can (I think) simply change

  foreach my $cat (sort keys %categories) {

to

  foreach my $cat (sort=20
  	{ cmp_cat($projlist, \%categories, $oi, $a, $b) } keys %categories) =
{

to have the following output (see the difference on page 3)

A':sort(name) split(max=3D3) subsort(sort(cat,name))
  1  2006  A     4  2003  A     7  2007  C
  2  2003  B     5  2000  A     8  2001  B
  3  2005  B     6  2008  C     9  2005  A

where sort_cat might be something like (we took advantage that
categories in %categories have at least one project):

  sub cmp_cat {
  	my ($projlist, $cats, $oi, $a, $b) =3D @_;
  	my ($aa, $bb);
  	# projects in categories are sorted, so we can compare first
  	# project from a category to sort categories in given ordering
  	$aa =3D $projlist->{$cats->{$a}[0]};
  	$bb =3D $projlist->{$cats->{$b}[0]};
  	if ($oi->{'type'} eq 'str') {
		return $aa->{$oi->{'key'}} cmp $bb->{$oi->{'key'}};
	} else {
		return $aa->{$oi->{'key'}} <=3D> $bb->{$oi->{'key'}};
	}
  }

--=20
Jakub Narebski
Poland
