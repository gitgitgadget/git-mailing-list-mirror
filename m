From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Sat, 08 Nov 2008 12:49:21 -0800
Message-ID: <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
 <20081108142756.GC17100@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:52:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyulr-0004qh-5x
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYKHUtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 15:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYKHUtn
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:49:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYKHUtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 15:49:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62C037AD98;
	Sat,  8 Nov 2008 15:49:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 62EF97AD97; Sat,
  8 Nov 2008 15:49:27 -0500 (EST)
In-Reply-To: <20081108142756.GC17100@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 8 Nov 2008 09:27:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2CEBC76-ADD6-11DD-87CD-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100425>

Jeff King <peff@peff.net> writes:

> Yes, they do break with 4/4 applied without 3/4 (that was how I found
> them, but "git rebase -i" let me pretend I had the proper foresight. ;)
> ). We can keep 3/4 back until the switch from "warn" to "yes", if that's
> what you are suggesting.

I meant to suggest that change contained in 3/4 can instead be "set the
configuration to allow such a dangerous push upfront, and make sure the
pushes the current tests perform actually are still allowed", _if_ you are
changing the default to forbid.

I think the default should be to warn for two release cycles during which
we will give deprecation notice, and then switch the default to forbid
(and we do not touch "git init/git clone" at all --- changing the default
to forbid in newly created repositories earlier than existing repositories
would be changing the behaviour of the command between old and new
repositories, which is madness).  If we are going this route, I think we
can modify the tests 3/4 touches to set the configuration to allow such a
push and make sure that such a push is still allowed.
