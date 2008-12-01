From: Andreas Ericsson <ae@op5.se>
Subject: Re: timestamps not git-cloned
Date: Mon, 01 Dec 2008 10:09:05 +0100
Message-ID: <4933A9B1.3070904@op5.se>
References: <200811291117.01655.trast@student.ethz.ch> <87k5am3uom.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 01 10:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L74nW-0007ME-2r
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbYLAJJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYLAJJN
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:09:13 -0500
Received: from mail.op5.se ([193.201.96.20]:33450 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbYLAJJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:09:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1DC0E1B80072;
	Mon,  1 Dec 2008 10:05:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jjZUfA9fEpcB; Mon,  1 Dec 2008 10:05:26 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 731E81B818AB;
	Mon,  1 Dec 2008 10:05:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <87k5am3uom.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102006>

jidanni@jidanni.org wrote:
> Well all I know is from the simple user who does e.g.,
> # aptitude install linux-doc-2.6.26
> # ls -lt /usr/share/doc/linux-doc-2.6.26/Documentation/
> he thinks "gosh, can't tell what's new vs. what hasn't changed in years".
> 

They won't be able to do that anyway, since a spelling correction
would update the timestamp anyway. The only way of finding out if
there are *content* changes (which is really what matters) is to
use some sort of history-browser for those documents. Git is good
for that. The sort of people who really need to know when the docs
change can be exptected to have a higher technical knowledge than
the end-users, so it's not too much to ask that they use such a
history browsing tool to find out what's new (or simply "diff").

Either way, timestamps on documents are a very poor way of finding
out when something really changed.

> OK, now I know why this is tolerable upstream: they all use git.
> 
> But for the lowly user downstream who gets what git-archive produces,
> it seems like a step backwards: "who threw away the timestamp of when
> each file was last changed?".
> 
> OK, http://git.or.cz/gitwiki/ContentLimitations says this is by design.
> 
> And OK, thinking "file by file" is old fashioned, I read. The non-git
> end user should just get used to reading ChangeLogs, if any, and stop
> doing ls -lt.
> 
> But you must admit, /usr/share/doc/linux-doc-2.6.26/Documentation/
> etc. are aimed for reading without git.
> 

Well, /usr/bin/less doesn't require git to function, so I fail to see
what the fuzz is all about.

> Anyways, if just in case any individual file modification time
> information can still be pried from the 40 byte IDs or whatever, I
> would suggest using it by default in git-archive at least, and maybe
> even git-clone etc.
> 

It can, but it's a fairly expensive operation, tracking each files
SHA1 backwards in time to see when the commit was done that last made
any changes to it. It's not something you want to do for an archive
containing 26K files. Trust me on this.

> Just letting you know my 'valuable first impressions'. I expect once I
> start smoking more of this "git" stuff, I too will become comfortably
> numb to aforementioned lowly user problem, so you would never know
> unless I hereby first told you before it was too late.


I see a lot of ranting but no patches from you. Since you're the one
with the itch, why not just submit a patch and see if distro packagers
start using it?

Some words of advice though; Make it optional, or it'll be dropped on
the floor. For bonus points, make it calculate timestamps only for a
path-spec delimited set of files. That'll cut down expected runtime
by a *huge* amount for something like the linux kernel.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
