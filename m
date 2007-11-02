From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention that git-branch -M can cause problems for tracking branches
Date: Fri, 02 Nov 2007 15:30:53 -0700
Message-ID: <7vodecz3du.fsf@gitster.siamese.dyndns.org>
References: <20071102091734.GC10141@diku.dk>
	<7vlk9g1k1q.fsf@gitster.siamese.dyndns.org>
	<20071102220411.GA13666@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 02 23:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io53A-0007sI-74
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbXKBWbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbXKBWbE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:31:04 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:33089 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbXKBWbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:31:01 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 447F92EF;
	Fri,  2 Nov 2007 18:31:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BF9CC9186A;
	Fri,  2 Nov 2007 18:31:16 -0400 (EDT)
In-Reply-To: <20071102220411.GA13666@diku.dk> (Jonas Fonseca's message of
	"Fri, 2 Nov 2007 23:04:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63185>

Jonas Fonseca <fonseca@diku.dk> writes:

> The main reason to "refuse" the removal is that for the general case,
> e.g. when using `git-config --rename-section`, this can potentially lead
> to loss of valuable config settings. This was pointed out by Shawn in
> his reply to my patch[0]. I agreed to this in my follow-up and asked if
> it would be acceptable to add an additional flag to so that git-branch
> can switch on this request for removal.

So when you rename branch.foo section to branch.bar, instead of
replacing the whole existing branch.bar with what used to be in
branch.foo, you _append_ that to branch.bar?

That sounds insane.

What good does it do to keep what used to be branch.bar?  The
old contents in the section are by no means "valuable".  They
were about 'bar' and do not even have anything to do with the
branch being renamed, which used to be called 'foo'.

Shawn's example of modifying multi-valued variable is
irrelevant.  Over there, we have options to replace everything
or append to it, don't we?

If the option is --rename-section, that is "rename section", not
"merge section".  If for some reason a merge section operation
is needed, that should be supplied in a separate patch, but for
the branch renaming I really do not see the need for it.
