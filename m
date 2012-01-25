From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: Finding all commits which modify a file
Date: Wed, 25 Jan 2012 11:23:02 -0500 (EST)
Message-ID: <30433.38.96.167.131.1327508582.squirrel@mail.lo-cal.org>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
    <4F1B4764.3010501@gmail.com>
    <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
    <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
    <52932.38.96.167.131.1327422884.squirrel@mail.lo-cal.org>
    <CA+gHt1BjqJpUke8JKjUmFyg3Zj5FmASd77LR-7P+6RrNLddD1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jan 25 17:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq5cs-0007ll-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 17:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab2AYQXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 11:23:05 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:40953 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227Ab2AYQXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 11:23:03 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id 9285E12BA9C;
	Wed, 25 Jan 2012 10:23:02 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Wed, 25 Jan 2012 11:23:02 -0500 (EST)
In-Reply-To: <CA+gHt1BjqJpUke8JKjUmFyg3Zj5FmASd77LR-7P+6RrNLddD1A@mail.gmail.com>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189111>

> [ Do not cut the CC]

My apologies.

> On Tue, Jan 24, 2012 at 5:34 PM, Neal Groothuis <ngroot@lo-cal.org> w=
rote:
>>> On Mon, Jan 23, 2012 at 5:14 PM, Neal Groothuis <ngroot@lo-cal.org>
>>> wrote:
>>>>> On 1/20/2012 3:35 PM, Neal Groothuis wrote:
>>>>>> I'm trying to find /all/ commits that change a file in the
>>>>>> repository...and its proving to be trickier than I thought. :-)
>>>>
>>>> On 1/21/2012 6:16 PM, Neal Kreitzinger wrote:
>>>>> Does git-log --all help?
>>>>
>>>> I don't see how it would. =A0The commits are all reachable from HE=
AD,
>>>> which
>>>> would seem to be the problem that --all would correct.
>>>>
>>>> What I'm trying to do is find the commits in which a file differs =
from
>>>> that same file in any of its parents.
>>>
>>> If you add parent rewriting (--parent, --graph or see it in gitk, w=
ith
>>> --full-history) you'll get your B2 commit as it adds commits to hav=
e a
>>> meaningful history. But I don't think this is what you are asking f=
or.
>>
>> Correct. =A0If I add parent rewriting, I get all merges, even those =
in
>> which
>> the file is not changed from either parent.
>>
>> Based on what's in the man page for git log about the history
>> simplification algorithm, it seems that B2 should be included in the
>> output when I do a git log --full-history --simplify-history foo.txt=
, as
>> per the steps I noted in the original post. =A0Is my understanding o=
f the
>> algorithm faulty?
>>
>
> Following your steps in the first post, B2 is excluded in the
> --simplify-merge phase because it is (originally) TREESAME, even if i=
t
> is not in the rewritten history...

Thanks, I see---labeling a commit as TREESAME happens before
simplification, rather than after.

In my example, that results in a simplified history where a commit in
which the contents of the specified paths change gets removed.  That se=
ems
perverse; I would think the utility of a simplified history would be to
track down the commits in which the contents of the specified paths cha=
nge
without having to consider ones in which they do not.

Is there a situation where checking for TREESAMEness before simplificat=
ion
is desirable and checking after would not be?

- Neal
