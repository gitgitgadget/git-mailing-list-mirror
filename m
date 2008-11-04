From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Tue, 04 Nov 2008 00:38:37 -0800
Message-ID: <7v7i7jsx6a.fsf@gitster.siamese.dyndns.org>
References: <20081104000745.GA28480@localhost>
 <20081104042643.GA31276@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:40:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHSj-0008S6-So
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbYKDIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYKDIiy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:38:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbYKDIix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:38:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78C617890F;
	Tue,  4 Nov 2008 03:38:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0B2707890E; Tue,  4 Nov 2008 03:38:45 -0500 (EST)
In-Reply-To: <20081104042643.GA31276@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 3 Nov 2008 23:26:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 025C308C-AA4C-11DD-94D9-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100057>

Jeff King <peff@peff.net> writes:

> Though I am not happy that we have to look up the tracking ref for every
> uptodate ref. I think it shouldn't be a big performance problem with
> packed refs, though, since they are cached (i.e., we pay only to compare
> the hashes, not touch the filesystem for each ref).

It is either (1) the user pays the cost of finding what remote tracking
branch we are mirroring when you push for all up-to-date refs, like you
did in your "here is an improvement" patch; or (2) the user pays the cost
of fetching from there, immediately after pushing.  I'd imagine that the
cost to do (1) would be smaller than (2).  The question is if seeing stale
tracking branches is such a big deal, as next "git fetch" from there will
update them anyway.  If it is a big deal, (1) would be a price worth
paying.

In short, I agree with everything you said in your analysis.  Thanks for
being a very good reviewer.

Clemens, care to reroll the patch?
