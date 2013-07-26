From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: make sure the upstream remote is configured
Date: Sat, 27 Jul 2013 00:29:47 +0200
Message-ID: <1374877787.2670.6.camel@centaur.cmartin.tk>
References: <1374860377-17652-1-git-send-email-cmn@elego.de>
	 <20130726184311.GA29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 00:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2qfT-0003s8-UY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 00:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab3GZWjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 18:39:20 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:37283 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab3GZWjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 18:39:19 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2013 18:39:19 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 3EC09DF4DB;
	Sat, 27 Jul 2013 00:29:50 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZLyClLp8Djf; Sat, 27 Jul 2013 00:29:50 +0200 (CEST)
Received: from [192.168.1.4] (p57A97817.dip0.t-ipconnect.de [87.169.120.23])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 0D804DF4D9;
	Sat, 27 Jul 2013 00:29:50 +0200 (CEST)
In-Reply-To: <20130726184311.GA29799@sigill.intra.peff.net>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231211>

On Fri, 2013-07-26 at 14:43 -0400, Jeff King wrote:
> On Fri, Jul 26, 2013 at 07:39:37PM +0200, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> > A command of e.g.
> >=20
> >     git push --set-upstream /tmp/t master
> >=20
> > will call install_branch_config() with a remote name of "/tmp/t". T=
his
> > function will set the 'branch.master.remote' key to, which is
> > nonsensical as there is no remote by that name.
>=20
> Is it nonsensical? It does not make sense for the @{upstream} magic
> token, because we will not have a branch in tracking branch refs/remo=
tes

This was the main point, yes; the only time I've seen it used is by
mistake/misunderstanding, and thinking that you wouldn't want to do
something like what's below.

You are also unable to do this kind of thing through git-branch, and as
it seemed to be an oversight, I wanted to tighten it up.

> to point to. But the configuration would still affect how "git pull"
> chooses a branch to fetch and merge.
>=20
> I.e., you can currently do:
>=20
>   git push --set-upstream /tmp/t master
>   git pull ;# pulls from /tmp/t master

Interestingly, this actually fetches the right branch from the remote. =
I
wasn't expecting something like this to work at all.

Somewhat doubtful that this usage is something you'd really want to do,
I see that it does behave properly.

   cmn
