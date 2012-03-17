From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Fri, 16 Mar 2012 22:22:21 -0700
Message-ID: <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 06:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8m62-0005ll-98
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 06:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2CQFWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 01:22:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124Ab2CQFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 01:22:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF9F76E0;
	Sat, 17 Mar 2012 01:22:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UFwxJ7+HGa9KBQ2yu5yyFMW5HsA=; b=DKY4tX
	G0UaZjy4GHIX+DSV147BSvkApsdAtOH0vKiJtMOyw8QTFHIZxObgvN2eo20oStDF
	eizFBynmyzP0PThwhWg/oV8+vEMwoJpp+n/7pbB04wiZBUfbwOjj0WsN9DiCyYuR
	FrO0b5+kZt4tYrDjYfxF3I7XuVbiSTSCJjNGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVl46prn0OeUSMx/uL30ZPqL/N41xAFB
	lMOiAUayvLEkEIRS0DiG7DC7H8HkQVBubsqphgqCMgv3P+3AwD58KSgqKpIKHwwm
	ab7l047+xBjC4lGcG5cBUbr+47huekFeP4kpNk8lWXeuv4i2/lM9qFJyuKjCM4y5
	J2py8dLCAKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1427376DF;
	Sat, 17 Mar 2012 01:22:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D47C76DE; Sat, 17 Mar 2012
 01:22:22 -0400 (EDT)
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Mar 2012 22:10:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CC22304-6FF1-11E1-8270-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193308>

If the conclusion of the discussion is that we will change the default,
the transition to the new default will go like this:

 1. An announcement message to let the user communities know about the
    future change will be distributed in a way similar to the previous
    request-for-discussion message was distributed.

 2. The first version of Git that is released after such an announcement
    will start issuing a warning when you type "git push" to send the
    matching branches to the default location unless you have configured
    push.default variable.  The users who want to keep the current default
    can do

	$ git config push.default matching

    and the users who want to use different settings can do one of:

	$ git config push.default current
	$ git config push.default upstream
	$ git config push.default nothing

    to silence this warning. The warning will be issued unless you do so,
    to help those who missed the message #1.

 3. We wait for a few release cycles.

 4. The default changes.  If you do not configure push.default variable,
    it no longer defaults to matching, but does something else (the choice
    among the three other alternatives will be decided in the discussion).
    The warning message will be reworded---instead of saying "will stop
    being the 'matching' in the future", it will say "has changed to X".

 5. We wait for a few release cycles.

 6. The warning is removed.

A typical release cycle lasts for 8-10 weeks.
