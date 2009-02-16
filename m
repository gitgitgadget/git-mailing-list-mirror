From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC - draft] List of proposed future changes that are
	backward incompatible
Date: Mon, 16 Feb 2009 09:04:32 +0100
Message-ID: <20090216080432.GA16453@atjola.homenet>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 09:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYyUS-0001Yu-86
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 09:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbZBPIEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 03:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbZBPIEk
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 03:04:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:57283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752180AbZBPIEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 03:04:39 -0500
Received: (qmail invoked by alias); 16 Feb 2009 08:04:36 -0000
Received: from i577BB589.versanet.de (EHLO atjola.local) [87.123.181.137]
  by mail.gmx.net (mp063) with SMTP; 16 Feb 2009 09:04:36 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18hpkFNAxwh0ufgVez/hTuKW4eiPuhDqdXIZZPSr+
	JQHcEJFxhh8bsr
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110145>

On 2009.02.15 15:53:50 -0800, david@lang.hm wrote:
> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>
>> Thanks.
>>
>> * git-push to update the checked out branch will be refused by defau=
lt
>>
>>  Make "git push" into a repository to update the branch that is chec=
ked
>>  out fail by default.
>>
>>  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=
=3D108007
>
> If I understand this one, it will cause grief for quite a few people.
>
> I have a public repository that I push to and then have a trigger tha=
t =20
> checks out the current version, compiles it, publishes the compiled =20
> version, sends an announcement, etc
>
> if I am understanding the purpose of this change, you would prohibit =
the =20
> update from taking place.

In the "non-bare" FAQ entry, there's a link to a post-update hook that
tries to resolve pushes to the branch head referenced by HEAD, and
at least on #git, there were people that preferred using that hook
instead of setting up a bare repo. So you're probably not the only one
with such a setup.

How about having the default in the code being a warning, but the
default for new repos being "reject"? IOW, set receive.denyCurrentBranc=
h
accordingly in the .git/config file for new non-bare repos? That way,
for your existing repos, you get a warning with instruction that you ca=
n
set a config entry to kill the warning or to forbid the potentially
destructive operation. So it's just a new warning, and your existing
setups don't break.

But for new repos, you get the rejection behaviour and have to change
the config if you really want to push to the current branch, along with
setting up the hook and whatever else you need, so it's just one more
step you need to take now.

Bj=F6rn
