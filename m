From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] user-manual: Add section "Why bisecting merge commits can be harder ..."
Date: Sat, 10 Nov 2007 12:25:22 -0800
Message-ID: <7vtzntlufh.fsf@gitster.siamese.dyndns.org>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de>
	<1194702594213-git-send-email-prohaska@zib.de>
	<alpine.LFD.0.999.0711101105340.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqwtl-00014Z-VP
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 21:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbXKJUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 15:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbXKJUZc
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 15:25:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51366 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbXKJUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 15:25:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5F03A2F0;
	Sat, 10 Nov 2007 15:25:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C30D694005;
	Sat, 10 Nov 2007 15:25:45 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999.0711101105340.15101@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 10 Nov 2007 11:10:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64375>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 10 Nov 2007, Steffen Prohaska wrote:
>> +
>> +But if you already made a merge C instead of rebasing, all
>> +is not lost.  In the illustrated case, you can easily rebase
>> +one parent branch on top of the other after the fact, just
>> +to understand the history and to make the history more
>> +easily to bisect.
>
> I simply don't think this is true. 
>
> You can *not* easily rebase after the fact. Both the parents may have lots 
> of merges independently of each other, and rebase won't be able to do 
> *anything* with such a case. In fact, the only reason you think you can 
> easily rebase after-the-fact is that you made the example history be 
> trivial. In real life, if the example history is that trivial (just a 
> single merge of two otherwise linear histories), you'd probably generally 
> not have this problem in the first place.
>
> The facts are:
>
>  - git bisect can handle merges quite well, and points to the right 
>    commit (which is *usually* not a merge).
>
>  - but merges by definition introduce changes from two independent lines 
>    of development, and while both lines may work well on their own, it is 
>    possible that (a) the merge itself was done incorrectly or (b) the two 
>    (or more) features that were introduced simply clash.
>
>  - "git rebase" won't do a thing for this after the fact, except in 
>    trivial cases, and even then it will generate a new history that simply 
>    isn't compatible with the original history, so while it could in theory 
>    help bisect things further in some limited and simple cases, in general 
>    it's simply not that useful an approach.
>
> ..and I think it's simply wrong to even *try* to imply that "git rebase" 
> can somehow change any of this.

Very true.  It is a suggestion useful _only_ when you can easily
rebase.  Like the one illustrated in the description, which is
artificial and of very limited scope.  If you cannot rebase
easily, then (by definition) rebase would not help you.
