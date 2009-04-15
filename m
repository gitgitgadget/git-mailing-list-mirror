From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Wed, 15 Apr 2009 16:25:55 -0700
Message-ID: <7v7i1lqz24.fsf@gitster.siamese.dyndns.org>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> <vpqfxgevy58.fsf@bauges.imag.fr>
 <vpqtz4rynhp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 16 01:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuEW2-00058R-EC
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 01:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbZDOX0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbZDOX0E
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 19:26:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZDOX0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 19:26:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DA43DAA551;
	Wed, 15 Apr 2009 19:26:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7D1F2AA54B; Wed,
 15 Apr 2009 19:25:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C877EB88-2A14-11DE-A645-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116656>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I think everybody agree that the intention of the patch is good (well,
> several pro, and no real counter-argument).

Oh, I think we have already passed that state long time ago.  It's queued
as c9cc8d9 ([NEEDS SIGN OFF, DOC, AND REVIEW] git add -p: new "quit"
command at the prompt., 2009-04-10) in 'pu'.

I agree that there is a "Huh?" factor in the repeated and similar hunks to
patch_update_file, but the first hunk is dealing with the mode change and
the second one is about the patch text.

Currently parse_diff_header() returns the mode line into $mode and the
main loop treats $mode differently from @hunk, which is an array of hunks
parsed by parse_diff().  Treating $mode as a "fake hunk" by unshifting it
at the beginning of @hunk array and teaching the main loop minor details
such as $mode "fake hunk" cannot be edited nor split, I suspect we _could_
unify the two.

ca72468 (add--interactive: allow user to choose mode update, 2008-03-27)
introduced this duplication.  Jeff, what do you think?  I am not sure if
it is worth it.
