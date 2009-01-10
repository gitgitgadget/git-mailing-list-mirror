From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH v2] t7501-commit.sh: explicitly check that -F prevents
	invoking the editor
Date: Sat, 10 Jan 2009 11:32:52 +0100
Message-ID: <20090110103252.GA32151@chistera.yi.org>
References: <alpine.DEB.1.00.0812301250210.30769@pacific.mpi-cbg.de> <1231522205-10510-1-git-send-email-dato@net.com.org.es> <alpine.DEB.1.00.0901101117100.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 11:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbBu-0003gR-K7
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZAJKc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 05:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZAJKc6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:32:58 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3939
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZAJKc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:32:58 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 80267801BF68;
	Sat, 10 Jan 2009 11:32:55 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LLb9A-0008Np-4w; Sat, 10 Jan 2009 11:32:52 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901101117100.30769@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105086>

* Johannes Schindelin [Sat, 10 Jan 2009 11:19:43 +0100]:

> Hi,

Hello,

> >  test_expect_success '--signoff' '
> >  	echo "yet another content *narf*" >> foo &&
> > -	echo "zort" | (
> > -		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
> > -		git commit -s -F - foo
> > -	) &&
> > +	echo "zort" | git commit -s -F - foo &&
> >  	git cat-file commit HEAD | sed "1,/^$/d" > output &&
> >  	test_cmp expect output
> >  '

> AFAICT this still tests if -F - launches an editor, except that it _d=
oes_=20
> launch the editor, waiting for the user to quit the editor.  Which is=
 bad.

The default value of VISUAL for the test suite is ":" AFAICS. Hence,
even if it's called, it will return immediately.

If it would be called, without my patch the "--signoff" test would fail=
,
but there would be no obvious reason as to why. Seeing "editor not
invoked if -F is given FAILED" is much more clear IMHO.

Also note that there plenty of places in the test suite where -F is
used, but VISUAL is not set explicitly.

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Excuse me for thinking a banana-eating contest was about eating a banan=
a!
                -- Paris Geller
