From: Sam Vilain <sam@vilain.net>
Subject: Re: Unresolved issues
Date: Thu, 20 Mar 2008 11:48:19 +1300
Message-ID: <47E19833.60402@vilain.net>
References: <7v7ig096ot.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803171853180.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc73F-0003Wr-NP
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936462AbYCSWpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936431AbYCSWpo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:45:44 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48160 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764677AbYCSWpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:45:41 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id DB86621C921; Thu, 20 Mar 2008 11:45:39 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 2A7EB21C902;
	Thu, 20 Mar 2008 11:45:35 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LFD.1.00.0803171853180.3020@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77582>

Linus Torvalds wrote:
>>   When you run "git rev-list A..B C", and there is a commit in the chain
>>   between A and B whose timestamp is much older than its parent, sometimes
>>   we fail to mark C as reachable from A (hence not interesting) even when
>>   it actualy is.  This is very expensive to solve in general, and we are
>>   not going to introduce "generation number" field to the commit objects,
>>   so we may have to settle with a heuristic.
> Here is the already posted heuristic that fixes both t/t6009 and the 
> real-world case that triggered the whole discussion.
> It's certainly not perfect, but I think it's likely an improvement on what 
> we have now, and it should be robust in the face of the _occasional_ wrong 
> date.
> Now, if there are consistently totally bogus dates, the SLOP thing won't 
> help, but ...

Ouch - I had always supposed that topology was king, and that the commit
dates were purely informational.  In particular the Perl history that I
produced in general takes a position of blatant and wanton disregard to
such consistency.

I can't find the other thread you refer to - is there a good summary of
the issues somewhere?  The test script is not very descriptive.

If timewise out-of-order commits are bad, perhaps git-filter-branch
should warn when it is creating histories whose topology disagrees with
their chronology... and also the user manual should probably describe this.

Sam
