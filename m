From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Illustration PATCH] add -i: accept single-keypress input
Date: Tue, 03 Feb 2009 21:10:17 -0800
Message-ID: <7vljsm9492.fsf@gitster.siamese.dyndns.org>
References: <20090203062437.GB21367@sigill.intra.peff.net>
 <1233651248-26717-1-git-send-email-trast@student.ethz.ch>
 <7vbptjdh5e.fsf@gitster.siamese.dyndns.org>
 <200902031035.04978.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 04 06:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUa3S-0002ai-3O
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 06:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZBDFK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 00:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbZBDFK1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 00:10:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZBDFK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 00:10:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1097B2A665;
	Wed,  4 Feb 2009 00:10:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EBF552A666; Wed, 
 4 Feb 2009 00:10:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20C21F02-F27A-11DD-A77B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108295>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>
>> Hmm, you could trigger the action immediately after seeing _enough_ number
>> of characters to disambiguate instead of stop-and-prompt, I guess?  That
>> way, you would get a single-key merely as a degenerate case when the
>> choices are all distinct.
>
> I don't think that's very nice.  On the one hand, you'd really want to
> allow the user to delete some of the input again if he decides to do
> something else instead, and we'd either need readline or need to
> reinvent it for that....

But doesn't the original "single-keypress" theme shares that problem
anyway?  It trades the ability to "delete some of the it again if he
decides to" away, in exchange for something else (probably "quicker input"
or "perceived ease of use").

> ....  On the other hand, some possible choices might
> be a valid prefix of some _other_ choices, at which point you need a
> terminator (such as the <enter>) anyway.  I expect this to be fairly
> common since many of the list_and_choose() prompts are numbered, so
> that 1 and 10 run into this problem.

I think that is independent, is an easy to fix (e.g. 1..9 A B C...Z), and
is a chicken-and-egg issue.  If the input mechanism had "enough leading
letters to disambiguate" semantics from the beginning, I am reasonably
sure that list_and_choose() would have implemented its choice as not small
integers but distinct letters.
