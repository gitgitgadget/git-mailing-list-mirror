From: Andreas Ericsson <ae@op5.se>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 10:31:58 +0200
Message-ID: <48D8A97E.8070003@op5.se>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>	 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>	 <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Mario Pareja <mpareja.dev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki3Kg-0005jK-W2
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 10:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYIWIcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 04:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYIWIcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 04:32:09 -0400
Received: from mail.op5.se ([193.201.96.20]:45986 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbYIWIcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 04:32:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8739D1B80048;
	Tue, 23 Sep 2008 10:22:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spam-Status: No, score=-4.28 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.119, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yiKi15CdwCun; Tue, 23 Sep 2008 10:22:30 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id BF41C1B80051;
	Tue, 23 Sep 2008 10:22:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96538>

Mario, please don't reply in private. That way your mails won't
get indexed and you don't have a chance to get help from others
on the mailing list.

While we're at it; don't top-post. Most people who frequent email
lists with moderate to high traffic read hundreds of emails every
day, so a quick reminder of what the discussion was about is useful
when getting a reply. That reminder gets a lot trickier to get to
if you first have to scroll down and then back up. Besides that,
it feels totally backwards.

Mario Pareja wrote:
> Andreas,
> 
> Thanks for the quick reply.  You asked how I thought locking could
> have helped. I think locking helps notify a developer that a file is
> being modified _before_ the developer begins his/her own
> modifications. If I followed your example correctly, the conflict is
> identified after the work has been done - this is too late if you ask
> me.
> 

So it's a communication issue then. The way I understand locks in svn
and cvs is that they also only bother you when you want to check in the
file you've just recently modified, or if multiple people want to lock
the same file at the same time.

If that's the case, I see no problem what so ever with teaching specific
git commands to interact with a locking server. git lock (and git unlock)
would have to be coupled with a git-lock-daemon with wich everyone
communicates. It should probably have the ability to run a hook or
something (centrally) when a lock is obtained and released, so as to be
able to notify others that a lock is held.

I might write this for fun some day, but it's really not my itch to
scratch, and it would be a terrible mistake to add something like a
central repository to take care of it when a single rather stupid
daemon and an equally stupid program could do the same work but much
more efficiently.

Note that locking would be completely advisory though, and nothing
would prevent people from committing changes to a locked file. Then
again, insofar as I understand SVN/CVS locking, that's how those
work too, except that an SVN "checkin" would be the equivalent of
"git commit && git push" (the push part of the git sequence won't
work).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
