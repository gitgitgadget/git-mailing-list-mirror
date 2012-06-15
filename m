From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Fri, 15 Jun 2012 09:14:25 +0200
Organization: Bertin Technologies
Message-ID: <20120615091425.20e40af9@chalon.bertin.fr>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
 <1339691389.4625.9.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?UTF-8?B?TWFydMOtbg==?= Nieto <cmn@elego.de>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 09:14:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfQju-0004fe-2T
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 09:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab2FOHO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 03:14:29 -0400
Received: from blois.bertin.fr ([195.68.26.9]:39224 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab2FOHO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 03:14:28 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 68828542E3
	for <git@vger.kernel.org>; Fri, 15 Jun 2012 09:14:27 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 47F93542B9
	for <git@vger.kernel.org>; Fri, 15 Jun 2012 09:14:27 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0M5N00AXNDG1VJ20@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 15 Jun 2012 09:14:27 +0200 (CEST)
In-reply-to: <1339691389.4625.9.camel@beez.lab.cmartin.tk>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-18970.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200042>

On Thu, 14 Jun 2012 18:29:49 +0200 Carlos Mart=C3=ADn Nieto <cmn@elego.=
de> wrote:
> On Thu, 2012-06-14 at 11:44 +0200, Yann Dirson wrote:
> > Hello list,
> >=20
> > I just did a "git cherry-pick AAA BBB..CCC" using 1.7.10.3, and was=
 surprised
> > that only the BBB..CCC range got picked - AAA was silently ignored.
> >=20
>=20
> There is no way to know whether this is a bug without knowing how AAA=
,
> BBB and ccc are related? From the names, can we assume that AAA is a
> (grand)parent of BBB? If that is the case, cherry-pick is behaving as
> expected.
>
> See the DESCRIPTION in http://git-scm.com/docs/git-rev-list for furth=
er
> explanation, but the short of the story is that the second argument t=
old
> it to ignore any commit before BBB, so AAA is not in the list of comm=
its
> to be applied.

OK, this is exactly the case.  Looking back at the cherry-pick manpage,=
 I'd say that
what confused me is the implicit --no-walk: the standard "git cherry-pi=
ck AAA" does
not look like a rev-list spec at all!

At least for this command, it would seem more natural (to me at least) =
to take
each arg one by one and feed it to "rev-list --no-walk" or similar.  Ma=
ybe some
special rev-list flag could trigger such a particular behaviour, pretty=
 much like
what --no-walk does ?


Another orthogonal UI issue I see, is that rev-list could be more user-=
friendly to warn
the user when one element of a rev list is ignored because of another o=
ne.  Not sure
whether this would be useful for all explicit rev lists specified by th=
e user - maybe a
config var and associated option would be needed too.

--=20
Yann Dirson - Bertin Technologies
