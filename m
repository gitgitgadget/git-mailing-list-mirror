From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Tue, 30 Oct 2007 01:29:30 -0700
Message-ID: <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<1193593581114-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmTx-0001eS-R6
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXJ3I3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXJ3I3n
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:29:43 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45590 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbXJ3I3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:29:42 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 826322EF;
	Tue, 30 Oct 2007 04:30:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C607C8F2BC;
	Tue, 30 Oct 2007 04:30:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> git push now allows you pushing a couple of branches that have
> advanced, while ignoring all branches that have no local changes,
> but are lagging behind their matching remote refs. This is done
> without reporting errors.
>
> Thanks to Junio C. Hamano <gitster@pobox.com> for suggesting to
> report in the summary that refs have been ignored.

I do not think this is a good idea at all.  Furthermore, I never
suggested anything about summary.  You are robbing the
information from the pusher which ones are pushed and which ones
are left behind.

It simply is insane to make this strange rule 10/10 introduces
the default behaviour.  It is too specific to a particular
workflow (that is, working with a shared central repository,
having many locally tracking branches that are not often used
and become stale, and working on only things to completion
between pushes).

I think we could live with an optional behaviour, in addition to
the current "matching refs" behaviour, that is "matching refs,
ignoring strict ancestors", though, but I doubt it is worth the
addition.
