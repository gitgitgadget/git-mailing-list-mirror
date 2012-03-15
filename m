From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Thu, 15 Mar 2012 11:43:21 +0100
Message-ID: <4F61C7C9.8020705@ira.uka.de>
References: <vpqobs65gfc.fsf@bauges.imag.fr>	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>	<1331288715.21444.38.camel@beez.lab.cmartin.tk>	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>	<20120312183725.GA2187@sigill.intra.peff.net>	<vpqy5r44zg7.fsf@bauges.imag.fr>	<7vehswljxi.fsf@alter.siamese.dyndns.org>	<4F5F60C5.6020900@ira.uka.de>	<7v7gyoxuth.fsf@alter.siamese.dyndns.org>	<4F60EE4B.9020803@ira.uka.de> <vpqehsumgvd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=ED?= =?ISO-8859-1?Q?n_Nieto?= 
	<cmn@elego.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 15 11:43:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S889C-0006Pb-B9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 11:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760769Ab2COKnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 06:43:03 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57193 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760069Ab2COKm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 06:42:59 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S888h-0004yl-Bn; Thu, 15 Mar 2012 11:42:50 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S888h-0007SF-7R; Thu, 15 Mar 2012 11:42:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <vpqehsumgvd.fsf@bauges.imag.fr>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331808170.606269000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193209>

On 15.03.2012 09:02, Matthieu Moy wrote:
> Holger Hellmuth<hellmuth@ira.uka.de>  writes:
>
>> So today I tried to create a
>> bidirectional link between a local and a remote branch using only
>> porcelain commands (i.e. without using git config directly). Somehow I
>> didn't succeed. I can either use git checkout --track or git push -u
>> to make a pull connection between the two, but to automatically push I
>> would have to create a branch of the same name (and know that this is
>> the magical ingredient that makes it work!)
>
> In this particular case, having 'push.default=upstream' would have done
> it for you: your "push -u" would have set up the upstream, and the next
> "push" would have followed it.

I know, this is why I voted for "upstream", but there are good reasons 
for "current" too. Whatever is decided on will still get some users by 
surprise.

> (or you could "git push remote local-branch:remote-branch")
>

Sure, I can believe that a new user will be able to get at that line 
after studying the "git push" manual page (or reading a tutorial), but I 
really doubt he will easily find out where to go from there to simplify 
that line. And typing that line every time for a permanent connection is 
out of the question, right?

That is why I think git push --track remote local-branch:remote-branch 
(or --permanent, --perm, --follow, --configure, --keep) would be a great 
help because a tutorial wouldn't have to talk about a lot of special 
cases, config options, it could just explain:

-----------------------------
1) To follow a remote repository do "git remote add <repo> <url>
2) To follow a remote branch do "git checkout [-b localbranch] --track 
<repo>/<branch>. Then "git pull" while in this branch will synchronize 
you whenever you want to be up-to-date.
3) To get a remote branch to follow you do "git push --track <repo> 
<local-branch>:<branch> once. Then "git push" while in this branch will 
synchronize the remote branch.
-----------------------------

With this simple recipe 90% of all workflows could be configured by a 
novice without embarrasing himself. Can you find a similar simple and 
consise recipe that would work today (even with upstream or current) ? I 
doubt it.

Sorry about opening up another tangent, but this is somewhat connected. 
If we give the novice an easy instrument to configure what he really 
wants then the default becomes much less important.
