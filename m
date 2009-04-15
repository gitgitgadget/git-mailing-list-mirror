From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Wed, 15 Apr 2009 19:34:08 +0200
Message-ID: <200904151934.10253.jnareb@gmail.com>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE> <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Holger =?utf-8?q?Wei=C3=9F?= <holger@zedat.fu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8ye-00082C-Ny
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZDORbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 13:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZDORbO
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:31:14 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:24741 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZDORbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:31:12 -0400
Received: by ti-out-0910.google.com with SMTP id 11so2132tim.23
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/U5wjU1j0qjAMvvTivvB7j00jdbl94ycOGc0Xd3bjUY=;
        b=VJUurFGFU2ScIjo7J501IZ10RfwFOMvFZ4FNaymdOehrMhIAmG3OhsnFjbvbPzBxlo
         q8AlhE1HYksi9MB5imTEgz2S/hs2g2zDHkJe+aw/a5tCxSsyWIDt3JQ2D2tYCNpWNzb+
         7AsG/B+mZCo6oyA71h/5ZiKJIHs29SaktlHQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=scslHLmTZGFjjLhKkkmplxl6w8h+lH+/7JO56tUnCfZTtF8mhmPfKLRMcELIenKKkd
         BBv0NQ3MX9swaF3y9toNb6ntT2bDZmgT5gNk+Xh3qxNA74gfq3cWr/GqJrUWD/wHMn/F
         +MyrAs49pgC8OUnUeQ38wGqK4+fZMEweC3Bx4=
Received: by 10.110.73.19 with SMTP id v19mr399443tia.36.1239816670121;
        Wed, 15 Apr 2009 10:31:10 -0700 (PDT)
Received: from ?192.168.1.13? (abws179.neoplus.adsl.tpnet.pl [83.8.242.179])
        by mx.google.com with ESMTPS id j5sm70810tid.37.2009.04.15.10.31.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 10:31:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116635>

On Wed, 15 April 2009, Junio C Hamano wrote:
> Holger Wei=C3=9F <holger@zedat.fu-berlin.de> writes:
>=20
> > Fix the detection of the requested snapshot format, which failed fo=
r
> > PATH_INFO URLs since the references to the hashes which describe th=
e
> > supported snapshot formats weren't dereferenced appropriately.
> >
> > Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
> > ---
> > I guess this one got lost.  Without this patch, snapshots won't wor=
k if
> > Gitweb is configured to generate PATH_INFO URLs.  (Original Message=
-ID:
> > <20090331161636.GV30233737@CIS.FU-Berlin.DE>).
>=20
> The patch looks obviously correct; "our %known_snapshort_formats" map=
s a
> name to a hashref, but the current code makes a nonsense assignment,
> essentialy doing ($fmt, %opt) =3D ($name, $hashref), but what would I
> know...  I am not using gitweb actively.
>=20
> These lines come from 1ec2fb5 (gitweb: retrieve snapshot format from
> PATH_INFO, 2008-11-02) by Guiseppe.
>=20
> Judging from the "git shortlog -n -s --grep=3DPATH_INFO gitweb" outpu=
t, I
> think I should have heard from either Guiseppe and Jakub by now if th=
is
> patch is desired.  Pinging them...

This change looks correct, and is very much desired.  Thanks for
catching this.

By the way, if there was check added for full path_info snapshot URL in
existing t/t9500-gitweb-standalone-no-errors.sh it would caught this
bug thanks to the
  "Odd number of elements in hash assignment ..."
warning that Perl throws in this case.=20

> >  gitweb/gitweb.perl |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 33ef190..3f99361 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -688,10 +688,10 @@ sub evaluate_path_info {
> >  		# extensions. Allowed extensions are both the defined suffix
> >  		# (which includes the initial dot already) and the snapshot
> >  		# format key itself, with a prepended dot
> > -		while (my ($fmt, %opt) =3D each %known_snapshot_formats) {
> > +		while (my ($fmt, $opt) =3D each %known_snapshot_formats) {
> >  			my $hash =3D $refname;
> >  			my $sfx;
> > -			$hash =3D~ s/(\Q$opt{'suffix'}\E|\Q.$fmt\E)$//;
> > +			$hash =3D~ s/(\Q$opt->{'suffix'}\E|\Q.$fmt\E)$//;
> >  			next unless $sfx =3D $1;
> >  			# a valid suffix was found, so set the snapshot format
> >  			# and reset the hash parameter
> > --=20
> > 1.6.2.1
>=20

--=20
Jakub Narebski
Poland
