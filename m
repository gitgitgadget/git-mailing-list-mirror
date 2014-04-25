From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Fri, 25 Apr 2014 09:37:24 +0200
Message-ID: <20140425073724.GA9384@xs4all.nl>
References: <E1WdOZY-0006ck-F9@iramx2.ira.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sitaramc@gmail.com,
	Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: G?bor Szeder <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 25 09:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdahe-00066Z-3R
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 09:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbaDYHhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 03:37:41 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:2306 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaDYHhk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 03:37:40 -0400
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id s3P7bS6c028917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Apr 2014 09:37:28 +0200 (CEST)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id s3P7bReo025039;
	Fri, 25 Apr 2014 09:37:27 +0200
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id s3P7bOAK018827;
	Fri, 25 Apr 2014 09:37:24 +0200
Content-Disposition: inline
In-Reply-To: <E1WdOZY-0006ck-F9@iramx2.ira.uni-karlsruhe.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247037>

* G?bor Szeder <szeder@ira.uka.de> [2014-04-24 23:10:10 +0430]:

> > I'd like to see this patch eyeballed by those who have been involve=
d=20
> > in the script (shortlog and blame tells me they are SZEDER and=20
> > Simon, CC'ed), so that we can hopefully merge it by the time -rc1 i=
s=20
> > tagged.
>=20
> I think this is a sensible thing to do.=A0 However, for now I can onl=
y check the patch on my phone, hence I can't say any more (e.g. acked o=
r reviewed by) than that, unfortunately.

Ditto for me, though I've gone so far as to try it (it works for me). A=
t the time I wrote the patch I honestly forgot to think about the secur=
ity implications and from the description, this is closing a hole. Ther=
e are situations where you're not in control of a branch name (though t=
bh, I think you'd have to be in an automated situation to check out a b=
ranch that is basically a command to hack your system, a human would pr=
obably figure it too cumbersome, or too fishy)

>=20
> > > + # not needed anymore; keep user's=20
> > > + # environment clean=20
> > > + unset __git_ps1_upstream_name=20
> > > + fi
>=20
> We already have a lot of stuff in the user's environment beginning wi=
th __git, so I don't think the unset is necessary.

If people rely on the string being set in their scripts, it can be bad =
to remove it. But if it's new in this patch, I don't see the need to ke=
ep it. Cruft is bad IMO.

Cheers

Simon
