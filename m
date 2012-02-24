From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 14:27:42 -0800
Message-ID: <7v7gzbhnoh.fsf@alter.siamese.dyndns.org>
References: <4F46036F.3040406@gmail.com>
 <20120224204615.GB21447@sigill.intra.peff.net>
 <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
 <201202242311.04787.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nikolaj Shurkaev <snnicky@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13cF-0004bP-OM
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182Ab2BXW1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:27:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756478Ab2BXW1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:27:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0237D6F;
	Fri, 24 Feb 2012 17:27:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kCRkp1CDGyrXjLp5MMzcAaB/4g=; b=l6GJvH
	hHtAXbrCwqdx2G2hQ23OUiu5aotFCnE4FGELbQDyL9StLgNlxYoZGI/XaIabLck/
	m8e8CPMYYNMNqiF8Y66LpM7/0qfvwKIgmQ2PhSWzhZZPgW/fGxErDqRSJkIurQtK
	C+PO+M27+hdrx0WDMVZAIt7fUqFnzoov2Bi2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=emiXUjFsd1dZwunTAci0PhQttt/Z0yeq
	DkwN2LfD0KPLcqyHnA3kv02517dC56DgCyLmMyZAO3kKFt7XeWKcy7QcOVSADhnt
	9w2QsiHv624MRzSlCYs4LjvSg7Tl0PjaXGoUDo4az2eiSS2/nIvxOvJAI5fobDBm
	0wVqBpgQi/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0464E7D6E;
	Fri, 24 Feb 2012 17:27:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B2C57D6D; Fri, 24 Feb 2012
 17:27:44 -0500 (EST)
In-Reply-To: <201202242311.04787.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 24 Feb 2012 23:11:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C584A858-5F36-11E1-BDDA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191496>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps git-format-patch should mention that it was created with
> path-limited patch in some email pseudo-header like X-Pathspec:
> or something, don't you think?

What kind of workflow are you assuming, and who would benefit from such a
header under that assumption?

It obviously would not help the person who is running format-patch, as he
is very well aware that he is giving a pathspec when he runs the command.
If the result is used privately to prepare a starting point of possibly
unrelated work, it does not matter.

If you are assuming a workflow that involves a public review of mailed
patches, it is very likely that such a header will be lost unless you are
using git-send-email, as we strongly discourage copying and pasting the
entire thing in the message body.  Anybody sitting on the receiving end
worth her salt would judge the submission by looking at the log message,
diffstat and the patch, and the sender having used pathspec to format the
patch would not be a reason for rejection at all---the quality of the
submission is.

So offhand, I do not know under what workflow such an extra header would
benefit people in what position in the workflow.
