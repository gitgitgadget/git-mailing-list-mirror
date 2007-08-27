From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusion about diffing branches
Date: Sun, 26 Aug 2007 17:18:35 -0700
Message-ID: <7v6431omn8.fsf@gitster.siamese.dyndns.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 02:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSJi-0001T5-E8
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXH0ASv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbXH0ASv
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:18:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbXH0ASv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:18:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D4A3B128EDC;
	Sun, 26 Aug 2007 20:19:10 -0400 (EDT)
In-Reply-To: <20070826233555.GA7422@mediacenter.austin.rr.com> (Shawn Bohrer's
	message of "Sun, 26 Aug 2007 18:35:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56748>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> So I imagine I'm missing something, or perhaps I'm just looking at this
> from the wrong perspective, but here is what I'm seeing.  Lets say I
> have something like:
>
>          A---B topic
>         /
>    C---D---E master
>
> ...
>    git diff master...topic
>
> ... shows me the
> combined diff of A and B.

That is working as designed.

When you are working on topic it is often desired to see "what
have I done since I forked?" and "what have they done while I
was looking the other way?".

"git diff master topic" (which is the same as "git diff
master..topic" -- the two-dot form is just a syntax sugar to
avoid mistypes for people who are too used to type two dots as
reflex because that is how you express a revision range) shows
a squashed diff that is A+B-E, and often people found "-E" part
distracting and useless.  Three-dot form was invented
specifically to address this problem.  You do not have to (and
you do not _want_ to) use that form if you _want_ to see the -E
part of the diff.
