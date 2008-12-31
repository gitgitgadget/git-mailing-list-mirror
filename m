From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 12:17:00 -0000
Message-ID: <gjfnsb$5ph$4@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local> <alpine.LNX.1.00.0812302143210.19665@iabervon.org> <alpine.LNX.1.00.0812302236190.19665@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 13:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI02E-00087m-4n
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 13:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYLaMRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 07:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbYLaMRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 07:17:25 -0500
Received: from main.gmane.org ([80.91.229.2]:43035 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537AbYLaMRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 07:17:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LI00p-0006g6-Cy
	for git@vger.kernel.org; Wed, 31 Dec 2008 12:17:23 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:17:23 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:17:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104269>

Ok, now I'm following you, cos I just "broke" checkout again by deleting 
files from working dirs before running it.

git-checkout takes into account the state of the working tree in the commit 
it is run FROM, as well as the commit it is checking out.

It relies on the working tree being in synch with the commit it is run from.
If I delete files, I screw around with this initial state.
Files that git-checkout is relying on to be there are not copied in by it, 
so if I've deleted (or modified) those files, hard luck.

I remember s/o saying git minimizes file I/O, and this whats happening here.

It puts a big demand on the user, to keep their index & working dir in synch 
with whats in the commit.

Ah,

$ git checkout .

will restore the state of the working dir to be in synch with the CURRENT 
commit, so it will be safe to checkout other branches

BINGO !!
what I need to do is run the sequence

$ git checkout .                    // tidy up current commit
$ git checkout <version>     // roll back

n'est pas ?


"Daniel Barkalow" <barkalow@iabervon.org> wrote in message 
news:alpine.LNX.1.00.0812302236190.19665@iabervon.org...
> On Tue, 30 Dec 2008, Daniel Barkalow wrote:
>
>> On Wed, 31 Dec 2008, Conor Rafferty wrote:
>>
>> > -----Original Message-----
>> > wtf is wrong with
>> >
>> > git checkout <something>
>> >
>> > ??
>> >
>> > ** It doesn't reliably put the files that were in that revision into 
>> > the
>> > working directory - a fairly major flaw, for what I'm using SCM for 
>> > (and
>> > 80% of the market IMHO)
>>
>> It certainly does for me; I rely on it pretty much constantly. Can you
>> give a sequence of commands (ideally the whole sequence from the "git
>> init") that leads to a difference?
>
> Actually, I know what you must be doing:
>
> $ git tag versionD
> $ git checkout versionA
> (versionA in the working directory)
> $ rm *.*
> (versionA with ABC.txt and AC.txt deleted)
> $ git checkout versionB
> (versionB with ABC.txt and AC.txt deleted)
>
> If you've made any changes (including deleting files), "git checkout" (no
> pathes) will preserve them. On the other hand, it will remove files that
> are in the commit you're leaving and not in the commit you're going to. So
> just don't remove the working directory files and you should be all set.
>
> In order to get them back if you have removed them, you can do:
>
> $ git checkout .
>
> This will discard all of the changes you've made only to the working
> directory; i.e., it'll recover the deleted files. You should also try "git
> status" whenever anything's mysterious, because it will tell you what's
> going on.
>
> -Daniel
> *This .sig left intentionally blank* 
