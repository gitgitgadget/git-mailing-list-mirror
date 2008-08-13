From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 09:36:13 +0200
Message-ID: <20080813073613.GB12628@cuci.nl>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <7vzlnhq48b.fsf@gitster.siamese.dyndns.org> <20080812225642.GA15265@cuci.nl> <7vvdy5pxz6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAv0-0005YN-1K
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYHMHgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYHMHgP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:36:15 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45479 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYHMHgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 03:36:14 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E0DC95465; Wed, 13 Aug 2008 09:36:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vvdy5pxz6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92189>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:

>> Separating it causes two things:
>> a. The patches to become dependent on each other in the timeline.
>> b. More (redundant) work, because some parts that need to be rewritten, get
>>    deleted by the following patch(es).

>These are actually desirable properties from reviewability point of view.

Ok, I'll look into the splitup.

>>> - I see you have a call to vsyslog, which is the first user of the
>>>   function.  How portable is it (the patch coming from you, I know
>>>   Solaris would have it, and recent 4BSD also would, but what about the
>>>   others)?

>> Cygwin has it, Solaris does, Linux does, MacOSX does.
>> AIX and HPUX don't, perhaps.
>> I'll see what I can do to avoid it, yet simplify the code.

>That's one of the reasons why I asked you to split it to three patches, so
>that the syslog change can potentially be independently replaced with a
>better alternative.

Well, I've already found an alternative, and looks a lot more appealing
than the buffer-juggling code of before.

>In any case, it is already late in the rc cycle; I'd like to apply your
>earlier "In SysV, signal(SIGCHLD) need to be rearmed" patch and nothing
>else for now.  The clean-up is very attractive but can be done post 1.6.0.

No problem.  That's the reason I chipped that first patch off; it's a
direct bugfix.  And BTW, don't mistake me for a "Solaris guy".  I've
been using Linux almost exclusively since 1991.  My SunOS/Solaris knowledge
has been fading steadily ever since.  It's just that I had to install
git-daemon on someone else's Solaris box just recently.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
