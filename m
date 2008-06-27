From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: report local storage errors in status table
Date: Fri, 27 Jun 2008 16:37:33 -0700
Message-ID: <7vprq2moua.fsf@gitster.siamese.dyndns.org>
References: <1214509350.28344.31.camel@odie.local>
 <20080627030245.GA7144@sigill.intra.peff.net>
 <20080627035747.GC7144@sigill.intra.peff.net>
 <20080627035950.GA21382@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNWo-0006m4-DU
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760513AbYF0Xhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759242AbYF0Xhv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:37:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759987AbYF0Xhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:37:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 79912E7C3;
	Fri, 27 Jun 2008 19:37:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BAD4E79E; Fri, 27 Jun 2008 19:37:41 -0400 (EDT)
In-Reply-To: <20080627035950.GA21382@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jun 2008 23:59:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D9B7DD2-44A2-11DD-9264-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86679>

Jeff King <peff@peff.net> writes:

> Previously, if there was an error while storing a local
> tracking ref, the low-level functions would report an error,
> but fetch's status output wouldn't indicate any problem.
> E.g., imagine you have an old "refs/remotes/origin/foo/bar" but
> upstream has deleted "foo/bar" in favor of a new branch
> "foo". You would get output like this:
>
>   error: there are still refs under 'refs/remotes/origin/foo'
>   From $url_of_repo
>    * [new branch]      foo        -> origin/foo
>
> With this patch, the output takes into account the status of
> updating the local ref:
>
>   error: there are still refs under 'refs/remotes/origin/foo'
>   From $url_of_repo
>    ! [new branch]      foo        -> origin/foo  (unable to update local ref)
>
> Signed-off-by: Jeff King <peff@peff.net>

Makes sense --- thanks.  This is something we can have automated tests,
isn't it?
