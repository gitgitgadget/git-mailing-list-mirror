From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Thu, 4 Oct 2007 16:47:32 +0200
Message-ID: <717D7260-CE23-4397-8B13-264309094423@zib.de>
References: <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site> <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site> <20071003162816.GA17403@artemis.corp> <Pine.LNX.4.64.0710031742400.28395@racer.site> <20071003170241.GA7571@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdS5P-0002yY-Mw
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXJDOxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 10:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbXJDOxu
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:53:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:48319 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218AbXJDOxu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 10:53:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l94Ejxsc015954;
	Thu, 4 Oct 2007 16:45:59 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l94EjxuF002483
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 4 Oct 2007 16:45:59 +0200 (MEST)
In-Reply-To: <20071003170241.GA7571@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59958>


On Oct 3, 2007, at 7:02 PM, Karl Hasselstr=F6m wrote:

> On 2007-10-03 17:44:39 +0100, Johannes Schindelin wrote:
>
>> I wonder how hard it would be to teach _everybody_ to specify
>> _exactly_ what they want.
>>
>> Of course, we'd need an "--existing" option to git-push to trigger
>> the behaviour that we have right now.
>
> I could _definitely_ live with that. If the branch config doesn't say
> what to do when no arguments are given, then demand a specification o=
n
> the command line.
>
> I'll shut up on this topic now, though, since I'm not exactly helping
> with the patch/opinion ratio.

Here is an interesting related pitfall where my expectations about
the behaviour of git push in relation with tracking branches were
wrong. I should have know better, but I somehow forgot the details.
I expected that the following would establish a two-way link, not
only a one way link:

    git checkout --track -b mynext origin/next

sets up a tracking branch and "git pull" fetches and merges changes
from origin/next as expected.

I somehow expected that "git push" would push changes from mynext to
origin/next. But it doesn't. It would only do so if I had chosen
the same name for the local branch, that is

    git checkout --track -b next origin/next

would have set up a two-way link -- but maybe only as long as I don't
have other push lines in my config file. I'm not sure about the last
point.

I do not find it very intuitive to mangle the push behaviour into the
naming of the local branch. I think it would be a good idea if the
two commands above would either both setup a pull/push relation
or both would setup a pull-only relation. If pull-only would be the
default another switch could be provided to establish a pull/push
relation, like

    git checkout --track --push -b mynext origin/next

Comments?

	Steffen