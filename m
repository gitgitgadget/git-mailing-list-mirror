From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 13:54:15 -0700
Message-ID: <7vskv9rvrc.fsf@gitster.siamese.dyndns.org>
References: <20080619154251.GA16475@jurassic>
 <20080619202843.GA6207@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mukund Sivaraman <muks@banu.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RAL-00062D-QU
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbYFSUyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYFSUyi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:54:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYFSUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:54:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FE021C370;
	Thu, 19 Jun 2008 16:54:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2A591C36D; Thu, 19 Jun 2008 16:54:18 -0400 (EDT)
In-Reply-To: <20080619202843.GA6207@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 Jun 2008 16:28:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E86653A4-3E41-11DD-9F7A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85527>

Jeff King <peff@peff.net> writes:

> You could potentially add a config option to put the branch name inside
> the '[PATCH]' text. This text is generally stripped away before
> applying, so it would still free up the receiver to apply on whatever
> branch they wanted. I don't think it would make sense for git
> development, since we typically use topic branches, so keeping it
> configurable would make sense.

People would work on individual patches on topic branches that are named
differently from the branch on the other end anyway (the branch that
corresonds to the other end will be used for local integration testing in
such a setup), so I do not see much point in stating which local branch
happened to have been checked out when the patch was generated, in the
output.

Also, in git, there is no independent "branch history", so anybody who
says "this patch was taken from this branch" is either speaking very
loosely, or does not understand git's branching model at all, or bit of
both.

If you have a history of this shape:

                    (other cruft)
                          \
                   ----o---o next
                      /
         o---o---o---o master
        /       /
    ---o---o---A

which "branch label" would you give to the format-patch output that shows
commit A?  It may apply to both master and next, and it is really up to
the project's convention what to do with it.  The side branch the patch
was developed on may be named "quick-hack", which would not have any
relevance to the final location of where that patch wants to be in.
