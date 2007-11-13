From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 11:25:12 -0800
Message-ID: <7vtznqrlrb.fsf@gitster.siamese.dyndns.org>
References: <11949569992214-git-send-email-msmith@cbnco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Smith <msmith@cbnco.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1PF-0002tZ-GQ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920AbXKMTZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758847AbXKMTZY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:25:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54500 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165AbXKMTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:25:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1E3252F2;
	Tue, 13 Nov 2007 14:25:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 95084955D4;
	Tue, 13 Nov 2007 14:25:40 -0500 (EST)
In-Reply-To: <11949569992214-git-send-email-msmith@cbnco.com> (Michael Smith's
	message of "Tue, 13 Nov 2007 07:29:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64836>

Michael Smith <msmith@cbnco.com> writes:

> +You can fix situations like these by doing a merge that isn't really a
> +merge, using the "ours" merge strategy. Look through the history on the
> +third-party branch and try to find the exact commit that matches the
> +last snapshot you imported. Often there's a tag close to the commit, or
> +on the commit, if you're lucky--but don't trust it blindly; check the
> +diffs. Check out your local branch and tell Git about the relationship:
> +
> +------------------------------------------------
> +$ git remote add upstreamgit git://upstream.org/project.git
> +$ git fetch upstreamgit
> +$ git tag
> +v1.0
> +v1.1
> +v1.2
> +$ git checkout master
> +$ git merge --strategy=ours \
> +    -m "Tie old v1.1 into our history by merging with strategy=ours." \
> +    v1.1
> +------------------------------------------------
> +
> +You'll see the branches merge together in `gitk --all` or `git
> +show-branch master upstreamgit/master`.  Now you'll be able to merge any
> +changes from the remote branch since v1.1 with `git merge
> +upstreamgit/master`.
> +

This would work only when your 'master' happens to be at v1.1
(and identical to it) isn't it?  Which means that as an example
it will be of very limited scope.

People would want to know "But my 'master' is _not_ at v1.1 but
is _based_ on v1.1.  How would I handle that case?" and the
above does not answer that question.

Even worse, most people are probably not careful enough to ask
the above question, but just say "Heh, my 'master' is based on
v1.1, so I'll blindly follow that example to bind the histories
together".

I did not find any technical problem in the other parts of your
description, but I did not read the resulting document from
cover to cover, so I do not know if your change fits in the
entire organization of the document very well.
