From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sat, 07 Jun 2008 10:47:17 -0700
Message-ID: <7vr6b9nnmi.fsf@gitster.siamese.dyndns.org>
References: <20080607070637.79B17C7C0E@rwavmlap>
 <m37id1y4zj.fsf@localhost.localdomain>
 <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 19:48:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K52Wg-0002dH-S9
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 19:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761089AbYFGRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761104AbYFGRre
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 13:47:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761083AbYFGRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 13:47:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 669AF553D;
	Sat,  7 Jun 2008 13:47:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 67438553A; Sat,  7 Jun 2008 13:47:26 -0400 (EDT)
In-Reply-To: <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
 (Robert Anderson's message of "Sat, 7 Jun 2008 09:06:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE30BEB6-34B9-11DD-974B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84220>

"Robert Anderson" <rwa000@gmail.com> writes:

> Err, then shouldn't it be removed from format-patch, rather than
> deleted manually every time format-patch is used?
> ...
> Then remove them from format-patch, IMO.

Everything Jakub said about the presentation is correct, and please take
hints by looking at patch postings by long timers on this list.

The output from the command is designed so that it _can_ be pasted into a
MUA edit buffer, but that's not the sole purpose.  It needs to resemble
mbox format for use of send-email, so when you paste into a context that
does not need some parts, it is your responsibility and common courtesy
for readers to remove them.

>>> Improve awkward heading in git-bisect documentation.
>> [...]
>>> -Avoiding to test a commit
>>> -~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +Changing the revision to test
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>  If in a middle of bisect session, you know what the bisect suggested
>>>  to try next is not a good one to test (e.g. the change the commit
>>
>> It is, I guess, better, but is it the best heading?  What we want to
>> describe here is how to deal when bisect stops on commit which cannot
>> be tested (e.g. project does not compile).
>
> I disagree. The situation you want to use this is more general than
> that.  Maybe you could test it, but doing so would be a waste of time
> because the commit is a trivial comment change.  In general, this
> simply what you need to know when you want to change the revision
> under test.

I agree with your reasoning.  Being able to test a different commit than
the suggested one is a useful feature of bisect, and we would want to help
readers by mentioning, as widely as possible, in what situations this mode
of operation that is described in the section is applicable.

Before your change, the title describes "One very typical situation in
which you may want to do what we teach in this section" (i.e. "I do not
want to test this commit"), the first paragraph describes the situation a
bit further, and then the remainder gives how.

After your change, the title describes "What we teach you how to do in
this section", the first paragraph of the section describes "Why you may
want to do such a thing".

A title is only one line.  It cannot afford to be too verbose.  People,
when they have problems, tend to skim documentation to see if there is
something applicable to their situation.  At least "Avoiding to test a
commit" should have worded "Avoiding to test the suggested commit" to draw
attention better from people in such a situation, and I agree with you
that "Changing the revision to test", "Testing a different revision",
etc. would work much better for that purpose.

But at the same time, I think the first paragraph "Why you may want to do
such a thing" should be strenghtened to cover wider scenario without going
to verbose, especially now the title has become even more bland --- it now
tells "what you would do" without hinting "why you might want to" anymore.
It currently talks only about what you said in your response "you could,
but you do not want to as you know it is a waste of time", and no other
scenarios you hinted in your response by saying "more general than that".

Making the first paragraph richer would help the readers who spotted the
(now better reworded) title to decide that the section indeed applies to
their situation.

Also, I think the section that follows this part should be part of this
section.  Either you reset to a specific commit, or you use "bisect skip"
to pick another one for you.  Both are solutions to the same problem.
