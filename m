From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Thu, 4 Oct 2007 17:54:21 +0200
Message-ID: <204B0DD6-54B0-4436-AFC6-ABDA4510E5D5@wincent.com>
References: <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site> <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site> <20071003162816.GA17403@artemis.corp> <Pine.LNX.4.64.0710031742400.28395@racer.site> <20071003170241.GA7571@diana.vm.bytemark.co.uk> <717D7260-CE23-4397-8B13-264309094423@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdT2x-0008Rp-Ma
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbXJDPzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757395AbXJDPzY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:55:24 -0400
Received: from wincent.com ([72.3.236.74]:51193 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbXJDPzX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 11:55:23 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l94FsRYD020002;
	Thu, 4 Oct 2007 10:54:28 -0500
In-Reply-To: <717D7260-CE23-4397-8B13-264309094423@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59971>

El 4/10/2007, a las 16:47, Steffen Prohaska escribi=F3:

> On Oct 3, 2007, at 7:02 PM, Karl Hasselstr=F6m wrote:
>
>> On 2007-10-03 17:44:39 +0100, Johannes Schindelin wrote:
>>
>>> I wonder how hard it would be to teach _everybody_ to specify
>>> _exactly_ what they want.
>>>
>>> Of course, we'd need an "--existing" option to git-push to trigger
>>> the behaviour that we have right now.
>>
>> I could _definitely_ live with that. If the branch config doesn't sa=
y
>> what to do when no arguments are given, then demand a =20
>> specification on
>> the command line.
>>
>> I'll shut up on this topic now, though, since I'm not exactly helpin=
g
>> with the patch/opinion ratio.
>
> Here is an interesting related pitfall where my expectations about
> the behaviour of git push in relation with tracking branches were
> wrong. I should have know better, but I somehow forgot the details.
> I expected that the following would establish a two-way link, not
> only a one way link:
>
>    git checkout --track -b mynext origin/next
>
> sets up a tracking branch and "git pull" fetches and merges changes
> from origin/next as expected.
>
> I somehow expected that "git push" would push changes from mynext to
> origin/next. But it doesn't. It would only do so if I had chosen
> the same name for the local branch, that is
>
>    git checkout --track -b next origin/next
>
> would have set up a two-way link -- but maybe only as long as I don't
> have other push lines in my config file. I'm not sure about the last
> point.
>
> I do not find it very intuitive to mangle the push behaviour into the
> naming of the local branch. I think it would be a good idea if the
> two commands above would either both setup a pull/push relation
> or both would setup a pull-only relation. If pull-only would be the
> default another switch could be provided to establish a pull/push
> relation, like
>
>    git checkout --track --push -b mynext origin/next
>
> Comments?

Interesting. To me that doesn't seem to be intuitive at all. I =20
actually think it makes a lot of sense for the relationship to be =20
"one way" in the absence of matching ref names.

Basically, the distributed model works because you know that if you =20
have the same commit hash in two repositories you're talking about =20
the same thing. Same thing goes for branches; if you expect to be =20
able to push back upstream then it's natural to expect that that =20
should only work if you have the same ref name to identify the "what" =20
that you're actually pushing to.

Cheers,
Wincent
