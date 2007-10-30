From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge: inconsistent manual page.
Date: Tue, 30 Oct 2007 11:39:13 -0700
Message-ID: <7vsl3sla5q.fsf@gitster.siamese.dyndns.org>
References: <fg7b6o$k1f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imw02-0003yz-Gk
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbXJ3SjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833AbXJ3SjU
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:39:20 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:43616 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbXJ3SjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:39:19 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 57BB32F2;
	Tue, 30 Oct 2007 14:39:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C68A58F684;
	Tue, 30 Oct 2007 14:39:36 -0400 (EDT)
In-Reply-To: <fg7b6o$k1f$1@ger.gmane.org> (Sergei Organov's message of "Tue,
	30 Oct 2007 16:22:31 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62727>

Sergei Organov <osv@javad.com> writes:

> git-merge has inconsistent manual page:
>
> 1. In the SYNOPSIS, there is [-m <msg>], but OPTIONS section lacks it.
>    The latter has just  description of <msg>, suggesting it could be
>    used without -m, but SYNOPSIS doesn't reflect this. 

This is not quite right, I am afraid.  "git merge" used to take
its parameters in quite an exotic order, and we still do support
it as we do not break people's existing setups:

	git-merge "$message" HEAD $list_of_merged_refs

where the second parameter is always HEAD.  This is the only
form that accepts the message without -m (see ll.230- in the
git-merge script).

But we do not _want_ to advertise this funny syntax.  Humans and
newly written scripts should express the above as:

	git merge -m "$message" $list_of_merged_refs


>    BTW, git-merge options are described in
>    Documentation/merge-options.txt that is also used fot git-pull
>    options, and it's not clear for me if git-pull supports [-m
>    <msg>]. Does it?

It shouldn't; the merge message is prepared by git-pull to
describe what got merged from where for you (see the last few
lines in the git-pull script).  

> 2. In the SYNOPSIS, there is no <head> that is described in the
>    OPTIONS.

See above.  We do not want to advertise the crazy syntax.
