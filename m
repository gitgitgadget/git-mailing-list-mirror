From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 05 Jun 2008 01:16:19 -0700
Message-ID: <7vprqw2t64.fsf@gitster.siamese.dyndns.org>
References: <200805232221.45406.trast@student.ethz.ch>
 <200805291737.53291.trast@student.ethz.ch>
 <20080529185808.GA2140@sigill.intra.peff.net>
 <200806010241.51464.trast@student.ethz.ch>
 <20080605014618.GA27381@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Aex-0001EU-NI
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYFEIQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYFEIQa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:16:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYFEIQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:16:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BB923C8A;
	Thu,  5 Jun 2008 04:16:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2C9A3C89; Thu,  5 Jun 2008 04:16:22 -0400 (EDT)
In-Reply-To: <20080605014618.GA27381@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Jun 2008 21:46:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B156DF98-32D7-11DD-9195-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83878>

Jeff King <peff@peff.net> writes:

> So perhaps manual hunk editing is simply something for advanced users
> who are comfortable with the patch format.

Exactly.  To them, "git diff >patch && vi patch && git apply --cached <patch"
would likely to be much handier, quicker and a more familiar way. That is
one of the reasons I somewhat doubt that we would want to have this patch.

>> +# Empty lines and lines starting with # will be removed.
>
> What about lines starting with characters besides -, +, space, or @?
> They will normally be ignored by diff.

Beware that a totally empty line is the same as an empty context line "SP LF".

For the rest of your comments, I agree with the Perl style (use of map and
grep instead of repeated push in loops).  The end user input, what the
code needs to parse and accept, can screw you up royally and your parsing
needs to be careful, and the code looks fragile.
