From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 23:29:12 +0200
Message-ID: <5196A128.7070005@kdbg.org>
References: <cover.1368736093.git.trast@inf.ethz.ch> <9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch> <5195C4B1.3010201@viscovery.net> <87y5beav7d.fsf@linux-k42r.v.cablecom.net> <7vfvxl1rj9.fsf@alter.siamese.dyndns.org> <87sj1lbkvm.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 23:29:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdSDL-00008m-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 23:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab3EQV3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 17:29:18 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12159 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756642Ab3EQV3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 17:29:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4EF1B13004B;
	Fri, 17 May 2013 23:29:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3547F19F5D1;
	Fri, 17 May 2013 23:29:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <87sj1lbkvm.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224741>

Am 17.05.2013 19:02, schrieb Thomas Rast:
> At this point the splitting has already happened in the caller when it
> does the (refactored)
> 
> +	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
> 
> So $@ and "$@" is actually the same thing.

Not in general: If you omit the double-quotes, the individual words
still undergo path name expansion and the result depends on the files
that happen to match patterns given in $GIT_SKIP_TESTS.

This is not a new problem at the call site of the new function, but we
shouldn't duplicate the same problem in the implementation of the function.

-- Hannes
