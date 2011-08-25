From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: One MMORPG git facts
Date: Thu, 25 Aug 2011 20:02:01 +0400
Message-ID: <1314288121.8665.2.camel@n900.home.ru>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
	 <loom.20110825T081519-218@post.gmane.org>
	  <4E560053.1080005@eaglescrag.net>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 18:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcNp-0001GI-HU
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1HYQCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 12:02:16 -0400
Received: from static.231.38.47.78.clients.your-server.de ([78.47.38.231]:52370
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab1HYQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 12:02:16 -0400
Received: from [83.149.8.5] (helo=[172.19.57.142])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <marat@slonopotamus.org>)
	id 1QwcJS-0007yr-Eh; Thu, 25 Aug 2011 19:57:54 +0400
X-Mailer: Modest 3.90.7
In-Reply-To: <4E560053.1080005@eaglescrag.net>
Content-ID: <1314288120.8665.1.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180085>

On 08/25/2011 11:57:07 MSD, J.H. <warthog9@eaglescrag.net> wrote:
> Given the differences, I'm morbidly curious, which actually ends up
> being the more usable version control system of a project of this sca=
le?
>=C2=A0  It sounds like (from what you've said) git is generally faster=
,
> assuming it can get enough resources (which can obviously be hard at =
the
> scales your talking).

Hard to compare (especially because I don't have pure git environment b=
ut git-svn clone). I have give you some=20

=46irst, there are lots of non-geek people working on MMORPG (quest des=
igners, modellers, text writers, map designers). Many of them find it h=
ard to understand DVCS concepts and prefer living with linear history i=
n a single branch (svn trunk). Their work is highly isolated from each =
other (for ex, maps are split in "regions" and only one person is allow=
ed to edit one region simultanuously, only one modeller works on a part=
icular model, each quest has a person responsible for it) so they don't=
 hit conflicts as often as programmers do. And since svn up of whole tr=
ee takes 40 mins, they don't update during work day but have nightly sc=
ript for that so the only thing they regularly use is svn commit.

Second, there's TortoiseSVN that allows easy (for non-geeks) GUI histor=
y inspection.

Third, we have 200 commits per day (8 work hours), that's one commit ea=
ch 2.4 mins (actually, much less during lunch and much more in the morn=
ing caused by the fact that programmers are not allowed to commit after=
 16:00), so you copy is outdated all the time. If upstream repo was git=
, one would have to pull + push in those 2.4 mins, otherwise she would =
hit non-ff push. This could be fixed by using separate repos, though th=
at would complicate git setup even more.

On the other hand, git is really great for programmers. Heck, svn still=
 doesn't have anything like "git log -u" (well, afaik, they finally add=
ed it in 1.7)! Stash/bisect/local commits/history rewriting/cheap branc=
hing(almost no branching happens in svn repo because that either involv=
es either fetching of 7Gb or [if svn switch is used] 10-30mins [don't r=
emember exactly] of massive I/O. [sorry for two-level nesting]) are ver=
y handy on daily basis. Also, git allows easy sharing of experimental c=
hanges between programmers without touching shared server. It also allo=
ws atomic commits for the whole working copy (which is important when p=
rogrammer changes server, client or data at the same time).

There are some decisions that were made and without which repo could be=
 smaller (for example, client/server binaries are commited daily so tha=
t designers can use them on next day), however these decisions were mad=
e long before i joined the project and are very likely to stay this way=
=2E

To sum this up: git is a wonderful (and very powerful) tool for program=
mers but too complex for non-tech users.
