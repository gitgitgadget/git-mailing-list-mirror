From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 22:39:41 -0800
Message-ID: <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 07:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUVE-0000Jy-Id
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZBWGjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBWGjt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:39:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbZBWGjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:39:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F1AA2BBC3;
	Mon, 23 Feb 2009 01:39:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D1182BBC0; Mon,
 23 Feb 2009 01:39:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2B8ED64-0174-11DE-8D6D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111103>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's not breakage that needs to be fixed, it's UI improvement,...
> ... Don't you
> think that --format=email is more natural than --pretty=email?

That heavily depends on when you ask.

If it _were_ during the period when we were actively building this
bikeshed, then I would have said "yeah, that color looks prettier".

But a proposal to repaint the bikeshed in a different color long after it
was built needs to be supported by an argument that is much stronger than
"I do not like the current one, I am improving it by painting in a better
color."  IOW, you came too late to just bikeshed.

People already are used to finding the shed in the scenery by looking for
that original color, however ugly the color might be.  The answer to your
question has to become quite different when you take that into account;
otherwise you are being irresponsible to your users.

This falls into the "it would have been very nice if it were like that
from day one.  I'd happily agree with you,... only if we didn't do it the
way we originally did" category.  You cannot call such a change an
improvement without thinking why the above statement is heavily qualified
with "if it were" and "only if we didn't".

I am actually Ok with having a synonym --format that works *identically*
with how --pretty works, and then update how both of them work to make
them better perhaps in a follow-up patch.  You accept style names that you
recognize as before, and instead of erroring out, if the unrecognized
string has % in it, pretend as if "tformat:" was in front of it.  It still
has the "two keywords for the same thing" misfortune, but that is
something you cannot avoid.  You yourself would need to say "newer git
would accept --format=short, but with the version shipped by your
distribution you may have to say --pretty instead" when teaching new
people who come after you.  Hopefully not many people would complain as
long as you do not break the existing --pretty,

Also I like Linus's --oneline === --pretty=oneline, but I haven't audited
the list of double-dash options our commands take that are unrelated to
pretty-printing styles.  If there are ones that look or sound similar to
the recognized style names (or if some commands may want to use the word
for controlling their own operation that is not related to pretty-printing
in their future enhancement), it would cause grief to us down the road.
The only one I can think of offhand is --full, so this probably is Ok.
