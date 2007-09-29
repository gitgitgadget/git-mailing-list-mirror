From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix revision log diff setup, avoid unnecessary diff generation
Date: Sat, 29 Sep 2007 15:11:31 -0700
Message-ID: <7vve9tjf58.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
	<20070929123724.01BB045EC@madism.org>
	<alpine.LFD.0.999.0709290932040.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:11:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkXJ-0006kq-Co
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbXI2WLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbXI2WLi
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:11:38 -0400
Received: from rune.pobox.com ([208.210.124.79]:57076 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbXI2WLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:11:37 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id F340E13DBB7;
	Sat, 29 Sep 2007 18:11:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6471413D432;
	Sat, 29 Sep 2007 18:11:55 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0709290932040.3579@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 29 Sep 2007 09:50:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59499>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 29 Sep 2007, Pierre Habouzit wrote:
>>
>> -				if (strcmp(argv[i], "-z"))
>> -					revs->diff = 1;
>> +				revs->diff = strcmp(argv[i], "-z")
>> +					&& strcmp(argv[i], "--color")
>> +					&& strcmp(argv[i], "--no-color");
>
> The old code was already pretty damn ugly, the new code is worse (never 
> mind the bug).
>
> I don't think we should care *at*all* about the actual argument string, we 
> should just look at what the diffopts end up being at the end.

Thanks, I think this is the sanest thing to do.
