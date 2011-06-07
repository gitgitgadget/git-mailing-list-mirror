From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Command-line interface thoughts
Date: Tue, 07 Jun 2011 21:00:44 +0200
Message-ID: <4DEE755C.8030108@ira.uka.de>
References: <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net> <7vk4cz9i1b.fsf@alter.siamese.dyndns.org> <4DECE147.3060808@drmicha.warpmail.net> <7vd3ir9btd.fsf@alter.siamese.dyndns.org> <4DEDC124.3060302@drmicha.warpmail.net> <20110607114526.GA9846@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1kV-0002Z9-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab1FGTP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:15:29 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:54200 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab1FGTP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 15:15:29 -0400
X-Greylist: delayed 947 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2011 15:15:28 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1QU1Us-0003nq-DI; Tue, 07 Jun 2011 20:59:32 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1QU1Us-0005Ur-8y; Tue, 07 Jun 2011 20:59:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <20110607114526.GA9846@elie>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1307473172.149937000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1307474128.110251000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175254>

On 07.06.2011 13:45, Jonathan Nieder wrote:
[...]
> If there were an unmerged path in the index, this would do a
> three-way diff, just like "git diff" currently does.
>
> That all sounds great, but I do not find it completely satisfactory.
> One problem is that if this is the mental model people have of
> "git diff", the three-way diff for a multiple stages, behavior of
> "git diff<paths>", and so on, however they are spelled, will look
> completely mystifying.  From the point of view of "this command
> explains the changes in the worktree" they make sense, while from the
> point of view of "compare A to B" they don't make much sense at all.
> So this change just defers the learning process.

If someone finds the three-way diff completely mystifiying, how do you 
expect him to resolve a merge conflict at all? Or recognize that there 
is one? Or find the command to use after editing out the conflict markers?

A novice user will have no real mental model anyway. He will be looking 
for simple (and easy to remember) commands for (mostly) simple needs.

> I think part of the problem in the current UI is that the
> documentation never spells out the idea of what plain "git diff" is
> for.  Worse, "--cached means to look to the index in place of the
> worktree" doesn't seem to be spelled out anywhere except gitcli(7).  I
> am not sure it is worth the headache of spelling the latter out
> instead of changing the UI to be easier to explain.
>
> Something like "git diff --index-only" would at least set people
> thinking in the right direction --- "index only as opposed to what?".
>
> With an INDEX pseudo-tree,
>
> 	git diff INDEX
>
> is a synonym for "git diff", and to do "git diff --cached" one would
> have to write
>
> 	git diff HEAD INDEX
>
> I like the "rename --cached to --index-only" proposal more but am
> not too satisfied with it, either.  In a way it is tempting to teach
> people
>
> 	git diff-files -p;	# compare worktree to index
> 	git diff-index -p HEAD;	# compare worktree to HEAD
> 	git diff-index -p --cached HEAD;	# compare index to HEAD
> 	git diff-tree -p HEAD HEAD^;	# compare HEAD^ to HEAD

if you look at the comments you put behind the commands, they look very 
much like the proposed diff command. How much time would a novice (and 
everyone else) need to remember your comments compared to your commands? 
A lot less.

Holger.
