From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined
 at config time
Date: Sun, 17 Feb 2008 16:30:43 -0800
Message-ID: <7vir0nxg0c.fsf@gitster.siamese.dyndns.org>
References: <20080216185349.GA29177@hashpling.org>
 <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de>
 <20080217002029.GA504@hashpling.org>
 <alpine.LSU.1.00.0802170045210.30505@racer.site>
 <20080217005620.GB504@hashpling.org>
 <7vbq6g758h.fsf@gitster.siamese.dyndns.org>
 <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de> <20080217214942.GJ8905@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Charles Bailey <charles@hashpling.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQtvA-0004vH-2l
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 01:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYBRAbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYBRAbN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 19:31:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYBRAbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 19:31:12 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF85A6985;
	Sun, 17 Feb 2008 19:31:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 8C8826981; Sun, 17 Feb 2008 19:30:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74209>

Theodore Tso <tytso@MIT.EDU> writes:

> I have no objection to a generic mechanism, but I don't see the value
> of Charles suggestion to rip out support for the existing tools
> supported by git-mergetool.

I missed that suggestion but I agree removing existing support
would not make much sense.

> I think it *would* be better to use %(foo) extrapolation that
> environment variables, so that it's not required for users to write
> shell scripts unless absolutely necessary.

Hmm, although I do not have strong opinions either way, I think
the necessary interface is narrow enough that we could use
environment variables here.  Charles's implementation does
"eval" but it is easy to replace it to run the custom command
after exporting the necessary variables, isn't it?

> When we get around to rewriting git-mergetool in C, it might make
> sense to put the tool support in the various shell scripts that are
> installed in the git helper binary directory (i.e.,
> git-mergetool-kdiff3, git-mergetool-meld, etc.)  That would make it
> easier for users to create new shell scripts to support new tools if
> necessary.

Yup.
