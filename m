From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Command-line interface thoughts
Date: Tue, 07 Jun 2011 21:34:30 +0200
Message-ID: <4DEE7D46.3080700@lsrfire.ath.cx>
References: <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net> <7vk4cz9i1b.fsf@alter.siamese.dyndns.org> <4DECE147.3060808@drmicha.warpmail.net> <7vd3ir9btd.fsf@alter.siamese.dyndns.org> <4DEDC124.3060302@drmicha.warpmail.net> <20110607114526.GA9846@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU231-0003Iu-If
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab1FGTek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 15:34:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:59722 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab1FGTei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:34:38 -0400
Received: from [192.168.2.106] (p579BE2C4.dip.t-dialin.net [87.155.226.196])
	by india601.server4you.de (Postfix) with ESMTPSA id B1C3D2F807E;
	Tue,  7 Jun 2011 21:34:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110607114526.GA9846@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175258>

Am 07.06.2011 13:45, schrieb Jonathan Nieder:
> Example:
>=20
> Long ago, I remember wanting to see what unstaged changes were in
> the worktree --- that is, I wanted to compare the content of the
> index to the worktree.  So, tell "git diff" to look at the index:
>=20
> 	git diff --cached
>=20
> No, I should have used "git diff" and the model of "git diff" I had
> was completely wrong.  How can we avoid this confusion?

Would it help if a header was shown in this case, describing the
following diff, e.g. something like this:

	$ cd /tmp && mkdir repo && cd repo && git init
	Initialized empty Git repository in /tmp/repo/.git/
	$ echo a >a && git add a && git commit -m.
	[master (root-commit) faeefb5] .
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 a
	$ echo b >a
	$ git diff
	Let's get rrready to diiiiff!!
	In corner a: the INDEX!  And in corner b: the WORKTREE!

	diff --git a/a b/a
	index 7898192..6178079 100644
	--- a/a
	+++ b/a
	@@ -1 +1 @@
	-a
	+b

Such a prefix would be ignored by patch etc..  You would still get it
wrong at the first try but now you'd get immediate feedback on what you
actually compared, without having to read the manpage.

Ren=E9
