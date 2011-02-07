From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/8] git-p4: test script
Date: Mon, 7 Feb 2011 17:26:23 -0500
Message-ID: <20110207222623.GB19851@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
 <20110205225105.GB30963@arf.padd.com>
 <7v1v3kwpm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 23:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZXk-0006aI-JO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 23:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab1BGW02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 17:26:28 -0500
Received: from honk.padd.com ([74.3.171.149]:34700 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755068Ab1BGW01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 17:26:27 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 784A91F95;
	Mon,  7 Feb 2011 14:26:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 59A7C31ADE; Mon,  7 Feb 2011 17:26:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1v3kwpm9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166307>

gitster@pobox.com wrote on Sun, 06 Feb 2011 18:22 -0800:
> Pete Wyckoff <pw@padd.com> writes:
[..]
> Use of two global variables with short names makes me feel "yeek!".
> 
> 	(p4 -h && p4d -h) >/dev/null 2>/dev/null ||
> 	{
> 		...
>                 test_done
> 	}

Much nicer.  Thanks.

> > +	p4d -q -d -r "$db" -p $P4DPORT &&
> > +	# wait for it to finish its initialization
> > +	sleep 1 &&
> 
> Is there a guarantee that "1" is sufficiently long for everybody?
> 
> Otherwise this will be a flaky test that sometimes passes and sometimes
> doesn't, which we try to avoid.
> 
> If the answer is "empirically 1 second is sufficient for 99.9% of people",
> then I would have to guess that it is 0.8 second too long for majority of
> people, in which case I would like to see us try harder to make it both
> reliable and efficient.
> 
> Isn't there a "noop" command a client can issue against a working server
> that fails when the server is not ready (or waits until the server becomes
> ready)?

There is a noop ("p4 info") that I can use to test.  But turns
out I was wrong in even needing to sleep or wait for the "info"
test to complete.  In trying to get it to race, I found that p4d
is well-behaved.  Strace confirms that it does bind/listen before
daemonizing.  So that sleep can be removed.

I'll wait a while in case other comments come in, then send the
updated series to you.

		-- Pete
