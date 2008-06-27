From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug related to branches using / in name
Date: Fri, 27 Jun 2008 16:31:30 -0700
Message-ID: <7vtzfemp4d.fsf@gitster.siamese.dyndns.org>
References: <1214509350.28344.31.camel@odie.local>
 <20080627030245.GA7144@sigill.intra.peff.net>
 <20080627035747.GC7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNQj-0005ek-Ez
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759731AbYF0Xbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759646AbYF0Xbl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:31:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759584AbYF0Xbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:31:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55BFDE63A;
	Fri, 27 Jun 2008 19:31:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91C39E638; Fri, 27 Jun 2008 19:31:33 -0400 (EDT)
In-Reply-To: <20080627035747.GC7144@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jun 2008 23:57:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30FE7672-44A1-11DD-9264-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86678>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 26, 2008 at 11:02:46PM -0400, Jeff King wrote:
>
>> It might be nicer if this were handled automatically, but it would
>> violate git-fetch's rule about never deleting branches.

Hmm.  Is there actually such a rule?

I was wondering if it might make more sense to do the equivalent of what
checkout_entry() does (i.e. remove_subtree()) when there is such a
conflict.  After all, tracking branches are meant to accept rewinds and
anything that happens on the remote end, and having to run "git remote
prune" is not a feature but is a lack of feature in the "git fetch", which
may make it look like deletion is somewhat special.
