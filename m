From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 22:24:57 +0200
Message-ID: <51DC7199.2050302@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:25:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UweTC-0001ED-RH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3GIUZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:25:02 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:49599 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752551Ab3GIUZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:25:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 03E4FCDF88;
	Tue,  9 Jul 2013 22:24:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1D7EA19F611;
	Tue,  9 Jul 2013 22:24:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1373399610-8588-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229999>

Am 09.07.2013 21:53, schrieb Junio C Hamano:
> +--lockref::
> +--lockref=<refname>::
> +--lockref=<refname>:<expect>::
> ...
> +This is meant to make `--force` safer to use.

This is a contradiction. "--force" means "I mean it, dude", and not "I
mean it sometimes". It would make sense if this sentence were "This is
meant to make `+refspec` safer to use."

Do you intend to require users to opt in to safety by saying --lockref
until the end of time? Which makes it actually usable only for scripts
and aliases. How do you override when the safety triggers, e.g., in an
alias that uses --force --lockref? Add --i-really-mean-it?

Or do we want to make --lockref the default at least for cases where
necessary ingredients can be derived automatically, perhaps in Git 3.0?
Then, how do you override when the safety triggers? Add --i-really-mean-it?

IMO, the way forward is:

1. Teach users to use +refspec to force-push. Do not encourage 'push
--force'.

2. Add --lockref as an opt-in for +refspec. Do not apply the safety to
'push --force'. (Current users and scripts do not see a behavior change
because they do not use --lockref, either.)

3. Make --lockref behavior the default at least for +refspec. Then 'push
--force' is still able to override the safety.

-- Hannes
