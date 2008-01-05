From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: allow diff colors without interactive colors
Date: Fri, 04 Jan 2008 16:20:09 -0800
Message-ID: <7v3atdi0na.fsf@gitster.siamese.dyndns.org>
References: <20080104083521.GB3354@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:20:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAwmQ-0003mJ-Ie
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYAEAUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbYAEAUX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:20:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbYAEAUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:20:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7343861F1;
	Fri,  4 Jan 2008 19:20:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E95A361EB;
	Fri,  4 Jan 2008 19:20:16 -0500 (EST)
In-Reply-To: <20080104083521.GB3354@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:35:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69619>

Jeff King <peff@peff.net> writes:

> Users with color.diff set to true/auto will not see color in
> "git add -i" unless they also set color.interactive.
>
> However, some users may want just one without the other, so
> there's no reason to tie them together.
>
> Note that there is now no way to have color on for "git
> diff" but not for diffs from "git add -i"; such a
> configuration seems unlikely, though.

Although I would agree with what this patch does, I think you
are contradicting with yourself in the above justification.
Some users may want to color "git diff" output but not
interaction with "git add -i", and that's also "just one without
the other", but you just tied them together, only differently,
and "seems unlikely" is a rather weak excuse.

The justification should instead be: having more independent
knobs is not necessarily better.  The user should not have to
tweak too many knobs.

In the longer term, I think we should try reducing the number of
knobs by giving "color.git" that allows you to pretend as if all
of the "color.interactive", "color.diff", "color.status",
"color.someothercolorizedcommand" are all set.  I do not think
being able to control the use of colors per command is giving
much other than confusion to the user.

That may not be so easy with the current structure of the config
reader, though.
