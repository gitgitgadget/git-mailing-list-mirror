From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 02 Sep 2006 18:08:21 +0200
Message-ID: <44F9AC75.3020302@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx> <cda58cb80609020824ja524444uc9fe65ea2e4febba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 02 18:08:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJY34-0005x6-8v
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 18:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIBQIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 2 Sep 2006 12:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWIBQI3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 12:08:29 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49552
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751086AbWIBQI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 12:08:26 -0400
Received: from [10.0.1.3] (p508E7231.dip.t-dialin.net [80.142.114.49])
	by neapel230.server4you.de (Postfix) with ESMTP id 63D072004E;
	Sat,  2 Sep 2006 18:08:22 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609020824ja524444uc9fe65ea2e4febba@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26341>

=46ranck Bui-Huu schrieb:
> Hi,
>=20
> 2006/9/2, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> git-archive-tree is a command to make tar and ZIP archives of a git =
tree.
>> It helps prevent a proliferation of git-{format}-tree commands.  Thi=
s is
>> useful e.g. for remote archive fetching because we only need to writ=
e a
>> single upload and a single download program that simply pass on the
>> format option to git-archive-tree.
>=20
> OK, Rene you beat me. I started to cook up something this morning but
> had no time to go further.

I am sorry.  My excuse is I was so angry the other night (for unrelated
reasons) that I started coding and I didn't stop until git-archive-tree
was working at three in the morning.

> I sent a starting implementation just because it seems complementary
> to the one you sent a couple hours ago: it supports '--remote' option=
=2E
> But it does _not_ have path spec support you introduced. I think it's
> cool feature but I would have to dig into git's internal to implement
> it, which would have taken me a while.

I cheated by using the already existing function read_tree_recursive().

> From now, do you think we should import my work into your version or
> 'vice verca' ?

Of course I like mine better. :-)  But first we need to agree on a
direction.  I think it makes sense to keep the network stuff out of the
archiver, and to keep the downloader as simple ("dumb") as possible: it
should pass on any options unaltered, including the format option.

That means the wire format changes completely, but since this feature
hasn't been officially released, yet, this shouldn't be a problem, righ=
t?

So, I propose to not add anything (except new formats) to
git-archive-tree and to add a separate downloader and uploader (maybe
combined in one program) instead.  That way the remote archive
operations are format agnostic.  OK, almost, because the uploader needs
to determine the format and compression level in order to allow or
disallow uploads based on that.

What do you think?

Thanks,
Ren=E9

--=20
VGER BF report: U 0.539485
