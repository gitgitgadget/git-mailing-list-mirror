From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Sat, 07 Feb 2009 13:45:39 -0800
Message-ID: <7vocxdudj0.fsf@gitster.siamese.dyndns.org>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
 <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
 <20090203071516.GC21367@sigill.intra.peff.net>
 <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
 <20090206161954.GA18956@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv18-0007vy-JC
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZBGVpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbZBGVpt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:45:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZBGVps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:45:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B55B72AA68;
	Sat,  7 Feb 2009 16:45:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AD0382A9D5; Sat, 
 7 Feb 2009 16:45:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD7C8E58-F560-11DD-AAB5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108885>

Jeff King <peff@peff.net> writes:

> Right, I am calling into question whether we want "--primer" at all.
> That is, if you think of it as just "prepend these command line options"
> we can get the same thing with something like:
>
>   git diff-tree `git config diff.primer` $other_options
>
> if the caller wants to be totally promiscuous, and
>
>   git diff-tree `git config diff.primer | filter_options` $other_options
>
> if it wants to be paranoid (and obviously in tcl the code would be
> different, but I think you can see the point).

I agree with this 100%.

Also, I think we should explain the semantics of diff.primer to new people
like that.  "The diff Porcelain command acts as if whatever you have in
diff.primer are prepended on your command line".

Which means that we do not have to touch the plumbing at all.  That allows
me sleep much better at night.
