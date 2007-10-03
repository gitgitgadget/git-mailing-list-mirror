From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn merge helper
Date: Wed, 03 Oct 2007 13:40:05 +0200
Message-ID: <47037F95.2040605@op5.se>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com> <20071002211400.GA992@atjola.homenet> <20071002220458.GA21038@dervierte> <20071002223813.GA3152@atjola.homenet> <20071003004252.GA28495@dervierte> <20071003010233.GA8610@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2aY-00078V-7n
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbXJCLkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbXJCLkQ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:40:16 -0400
Received: from mail.op5.se ([193.201.96.20]:33981 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbXJCLkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:40:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6519D1946BC;
	Wed,  3 Oct 2007 13:40:12 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBW50bNZgkah; Wed,  3 Oct 2007 13:40:09 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C838B1946BB;
	Wed,  3 Oct 2007 13:40:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071003010233.GA8610@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59827>

Bj=F6rn Steinbrink wrote:
> On 2007.10.02 20:42:52 -0400, Steven Walter wrote:
>> On Wed, Oct 03, 2007 at 12:38:13AM +0200, Bj=F6rn Steinbrink wrote:
>>>> The other option is to have a "build" branch.  By example:
>>>>
>>>> git checkout build
>>>> git reset --hard master
>>>> git merge mybranch
>>>> make
>>>>
>>>> In that way, I have branch with the latest changes from head and t=
he
>>>> changes from mybranch together.  The downside to this method is th=
at you
>>>> may have to repeated resolve merges.  Despite the downsides, I fin=
d
>>>> these two methods to work quite well.
>>> Thanks, but it makes no difference here, it stil results in a fast
>>> forward. This is a small test case which exhibits the behaviour and
>>> matches my current workflow with git-svn (except for the dcommits):
>>>
>>> git init
>>> echo Hi > file1; git add file1; git commit -m file1
>>> git checkout -b branch
>>> echo Hi > file2; git add file2; git commit -m file2
>>> git checkout master
>>> echo Hi > file3; git add file3; git commit -m file3
>>> git checkout branch
>>> git merge master
>>>
>>> # Then I'd normally do the following which causes a fast forward
>>> #git checkout master
>>> #git merge branch
>>>
>>> # Now I tried this, which also results in a fast-forward:
>>> git checkout -b merge
>>> git reset --hard master
>>> git merge branch
>> I believe you misunderstood my suggestion.  In using a "build" branc=
h,
>> you would not merge master into branch, as you did above.  Instead, =
you
>> would create a third, unpublished branch to hold the merge.
>=20
> Almost though so.
>=20
>> At the same time, I have a slightly better understanding of what it =
is
>> you're trying to do.  If you are trying to keep up an SVN-like workf=
low
>> (namely pulling changes from trunk into a branch from time to time),
>> then my solution probably isn't suitable for you.  However, you migh=
t
>> consider why you actually /need/ to do that, outside of SVN conventi=
on.
>=20
> Due to the same reason for which the branch needs to be public at all=
,
> there are other people who want to follow it and test it, while there
> are external dependencies that currently change quite often. So I nee=
d
> to get the relevant changes from trunk into my branch anyway, even wi=
th
> svn conventions put aside (well, unless I force everyone else to merg=
e
> over and over again). And as sometimes others commit to that branch, =
too
> (you just have to love that), keeping a separate branch for the final
> merge isn't so nice either, as I'd need to constantly cherry-pick tho=
se
> changes then and probably get even more conflicts along the way.
>=20
> That said, Google finally liked some of the search terms that I threw=
 at
> it and revealed a thread [1] from march, where Linus was torn on whet=
her
> or not a --no-fast-forward option should be introduced. That sounds l=
ike
> it would help here, any chance of getting such a thing?
>=20

Is this what you're looking for? It's in the 'next' branch in git.git.

commit d66424c4ac661c69640765260235452499d80378
Author: Lars Hjemli <hjemli@gmail.com>
Date:   Mon Sep 24 00:51:45 2007 +0200

    git-merge: add --ff and --no-ff options
   =20
    These new options can be used to control the policy for fast-forwar=
d
    merges: --ff allows it (this is the default) while --no-ff will cre=
ate
    a merge commit.
   =20
    Signed-off-by: Lars Hjemli <hjemli@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
