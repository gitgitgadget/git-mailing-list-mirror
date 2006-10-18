From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-log shows first parent and repeated last for octopus merge
Date: Wed, 18 Oct 2006 12:02:19 -0700
Message-ID: <7v3b9l30sk.fsf@assigned-by-dhcp.cox.net>
References: <eh5242$rar$1@sea.gmane.org>
	<Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGgK-0003Ej-1f
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWJRTCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWJRTCV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:02:21 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41176 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161019AbWJRTCU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:02:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018190219.YIYL22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 15:02:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bv2N1V00k1kojtg0000000
	Wed, 18 Oct 2006 15:02:23 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 18 Oct 2006 15:53:23 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29252>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 18 Oct 2006, Jakub Narebski wrote:
>
>> When trying to find how many merges and how many octopus merges (merges with
>> more than two parents) are in git.git repository I have encountered the
>> following strange output of git-log:
>> 
>>  1000:jnareb@roke:~/git> git log --parents --full-history --max-count=1 \
>>    211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
>>  commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e <last parent repeated>
>>  Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
>>  [...]
>
> This happens because a//b rewrites the history, i.e. the parents are 
> edited. IMHO it makes no sense at all to show the parents in such a case, 
> since they are bogus.

If the command line did not have --full-history, I would agree
with you.  The caller explicitly told us not to remove side
branches that do not end up modifying the paths, and also told
us, with --parent, to show parenthood information after removing
intermediate commits that do not change the tree shape (with
respect to the specified paths).

So it is showing what the user asked -- the user may not have
understood what he was asking, but that is a separate problem, I
would think.
