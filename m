From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 15:25:39 +0100 (CET)
Message-ID: <44684.bFoQE3daRhY=.1226586339.squirrel@webmail.hotelhot.dk>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
    <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
    <20081113140323.GA10267@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Samuel Tardieu" <sam@rfc1149.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 15:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0d9q-0005BK-Rw
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 15:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbYKMOZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 09:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYKMOZk
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 09:25:40 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:37400 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbYKMOZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 09:25:39 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5C75414068;
	Thu, 13 Nov 2008 15:25:39 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 30F1A14062;
	Thu, 13 Nov 2008 15:25:39 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <20081113140323.GA10267@neumann>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100876>

SZEDER G=E1bor wrote:
>
> On Thu, Nov 13, 2008 at 02:23:19PM +0100, Samuel Tardieu wrote:
>> >>>>> "Anders" =3D=3D Anders Melchiorsen <mail@cup.kalibalik.dk> wri=
tes:
>>
>> Anders> I have tested the script with Git 1.6.0.2, but the real
>> Anders> scenario that made this appear seems to also fail with maste=
r
>> Anders> and next from git.git.
>>
>> I confirm that your test case also fails with the current "next".
>
> Yeah, and it can be bisected to commit 621ff675 (rev-parse: fix
> meaning of rev~ vs rev~0, 2008-03-14), which is from Linus, so put hi=
m
> on Cc.

I guess that is due to using HEAD~ in the test script? If you are
bisecting, here is a version that does not use the HEAD~ notation:


mkdir am-merge-fail
cd am-merge-fail
git init

mkdir before
touch before/one after
git add before after
git commit -minitial

git branch parallel

rm -f after
git mv before after
git commit -mmove

git checkout parallel
touch other
git add other
git commit -mparallel

git merge master
