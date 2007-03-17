From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] calculate the maximal number of revisions to test
Date: Sat, 17 Mar 2007 20:58:40 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070317195840.GA20735@informatik.uni-freiburg.de>
References: <20070317141209.GA7838@cepheus> <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSf39-0001L3-Q1
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbXCQT6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 15:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbXCQT6p
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 15:58:45 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50115 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841AbXCQT6p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 15:58:45 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HSf35-0005t4-P4; Sat, 17 Mar 2007 20:58:43 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2HJwflf020926;
	Sat, 17 Mar 2007 20:58:41 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2HJweTj020925;
	Sat, 17 Mar 2007 20:58:40 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42451>

Hi gene099,

> the subject really could use a "bisect:" prefix, and maybe be a littl=
e=20
> clearer to begin with? Imagine how much sense it makes to read the co=
mmit=20
> messages, and see that some maximal number of revisions is calculated=
=2E
OK, you're right.  I think the patch is not as complete as it could be.
I will fix that and resend with a better log.
=20
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index b1c3a6b..a5b4fdd 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -150,8 +150,14 @@ bisect_next() {
> >  	    git-diff-tree --pretty $rev
> >  	    exit 0
> >  	fi
> > -	nr=3D$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAM=
ES)" | wc -l) || exit
> > -	echo "Bisecting: $nr revisions left to test after this"
> > +	nr_bad=3D$(eval "git-rev-list $rev^ $good -- $(cat $GIT_DIR/BISEC=
T_NAMES)" | wc -l) || exit
> > +	nr_good=3D$(eval "git-rev-list $bad^ ^$rev $good -- $(cat $GIT_DI=
R/BISECT_NAMES)" | wc -l) || exit
> > +	if test "$nr_bad" -ge "$nr_good"; then
> > +		nr=3D"$nr_bad";
> > +	else
> > +		nr=3D"$nr_good";
> > +	fi;
> > +	echo "Bisecting: maximal $nr revisions left to test after this"
>=20
> How about this instead:
>=20
> -	echo "Bisecting: $nr revisions left to test after this"
> +	echo "Bisecting: approx. $nr revisions left to test after this"
>=20
> since your version is an approximation (although a conservative one)=20
> anyway. Hmm?
I prefer a wording that points out a maximum.  Earlier today I thougt
about this, too, but currently I don't remember my alternative.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+divided+by+3
