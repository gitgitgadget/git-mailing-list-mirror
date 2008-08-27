From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Tue, 26 Aug 2008 21:50:08 -0700
Message-ID: <7vabezt62n.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
 <20080827002506.GB7347@coredump.intra.peff.net>
 <quack.20080826T2018.lthr68b2ljc@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 06:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYD06-0005sB-TD
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 06:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYH0EuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 00:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYH0EuS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 00:50:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYH0EuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 00:50:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0285E69837;
	Wed, 27 Aug 2008 00:50:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F6BE69835; Wed, 27 Aug 2008 00:50:11 -0400 (EDT)
In-Reply-To: <quack.20080826T2018.lthr68b2ljc@roar.cs.berkeley.edu> (Karl
 Chen's message of "Tue, 26 Aug 2008 20:18:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A43287A6-73F3-11DD-91FF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93853>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-26 17:25 PDT, Jeff King writes:
>
>     Jeff>   2. There is no documentation update.
>
> Relative paths and $ENVVARS would need explanation; not sure what
> needs to be said about ~user since the new behavior is what people
> expect to just work.  Would it go in git-config.txt if something
> were added?

Traditionally, we never has interpret ~/ or ~user/.  Users expected that
they need to spell it like:

        [core]
                excludesfile = "/home/joe/.my-ignore-pattern"

Especially since this is called "variables", it is natural, without
explanation, to expect this not to work, just like this use of a variable
won't work:

        $ EDITOR='~/bin/editor' ;# notice the single quote
        $ export EDITOR;
        $ git commit -a
        fatal: exec ~/bin/editor failed.

Your patch improves the situation and now allow:

        [core]
                excludesfile = "~/.my-ignore-pattern" 

If you do not document that it is now possible for this particular
configuration variable, the users will never know.
