From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Thu, 11 Dec 2008 00:13:10 -0800
Message-ID: <7vtz9bt9ih.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org>
 <20081210211147.GA13624@localhost>
 <7voczjy55g.fsf@gitster.siamese.dyndns.org>
 <20081211080752.GA26709@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Dec 11 09:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAggu-0002li-QS
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 09:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYLKINT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 03:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbYLKINT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 03:13:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbYLKINT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 03:13:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6DD386434;
	Thu, 11 Dec 2008 03:13:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8B84E86433; Thu,
 11 Dec 2008 03:13:12 -0500 (EST)
In-Reply-To: <20081211080752.GA26709@localhost> (Clemens Buchacher's message
 of "Thu, 11 Dec 2008 09:07:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90E7849C-C75B-11DD-8A2B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102789>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Dec 10, 2008 at 03:36:11PM -0800, Junio C Hamano wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> >
>> > "merge -s resolve" fails with
>> >
>> > Trying really trivial in-index merge...
>> > error: Merge requires file-level merging
>> > Nope.
>> > Trying simple merge.
>> > Simple merge failed, trying Automatic merge.
>> > ERROR: c1.c: Not handling case ae9304576a6ec3419b231b2b9c8e33a06f97f9fb ->
>> > -> 8173b675dc61bb578b411c769c9fb654625a7c4e
>> > fatal: merge program failed
>> > Automatic merge failed; fix conflicts and then commit the result.
>> >
>> > and therefore passes the test.
>> 
>> Are you saying that:
>> 
>>  (1) the step should result in conflict and the merge should fail, but it
>>      should not clobber c1.c nevertheless; and
>> 
>>  (2) resolve fails to merge (as expected), and it does not clobber c1.c
>>      (as expected); therefore it passes the test.
>
> The latter.

I said "and" at the end of (1) so I do not understand your answer, but I
take it to mean that both (1) and (2) are true, judging from the rest of
your message.

>> If so, then you now established that it is a bug in merge-recursive,
>> right [implementors of recursive-in-C CC'ed]?
>
> Correct.
>
>> Or are you saying that the step should not fail to begin with?
>
> No...

Ok, thanks.  Unfortunately my git day for this week is over, so I'll try
to find time to take a look at what recursive strategy does wrong over the
weekend, if nobody gets to it before me.
