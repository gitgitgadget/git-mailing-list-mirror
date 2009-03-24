From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 16:44:51 -0500
Message-ID: <49C95453.9080503@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <20090324210427.GC30959@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmESE-00015i-T8
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbZCXVpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755682AbZCXVpD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:45:03 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:60486 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696AbZCXVpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:45:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id 67708F88A9;
	Tue, 24 Mar 2009 16:44:59 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1iKAFxFqDSm; Tue, 24 Mar 2009 16:44:55 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id 45293F8928;
	Tue, 24 Mar 2009 16:44:54 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <20090324210427.GC30959@zoy.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114494>

Sam Hocevar wrote:
>    As stated several times by Linus and others, Git was not designed
> to handle large files. My stance on the issue is that before trying
> to optimise operations so that they perform well on large files, too,
> Git should usually avoid such operations, especially deltification.
> One notable exception would be someone storing their mailbox in Git,
> where deltification is a major space saver. But usually, these large
> files are binary blobs that do not benefit from delta search (or even
> compression).

Yeah, in this case, I *know* that my binary blobs are completely
different, and it's just a waste of time for git to come to the same
conclusion.  I'd be perfectly willing to have some knob I could turn
that would tell git this.

>    Since I also need to handle large files (80 GiB repository), I am
> cleaning up some fixes I did, which can be seen in the git-bigfiles
> project (http://caca.zoy.org/wiki/git-bigfiles). I have not yet tried
> to change git-push (because I submit through git-p4), but I hope to
> address it, too. As time goes I believe some of them could make it into
> mainstream Git.

I'd almost be willing to help.  I know the basic premise to how git
works, but the devil is in the details, and I don't have time right
now to learn the internals.

Yet another thing to add to my todo list.

>    In your particular case, I would suggest setting pack.packSizeLimit
> to something lower. This would reduce the time spent generating a new
> pack file if the problem were to happen again.

Yeah, saw that one, but *after* I had this problem.  The default, if
not set, is unlimited, which in this case, is definately *not* what we
want.
