From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 11:05:59 +0000
Message-ID: <20140326110559.GA32625@hashpling.org>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 12:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSlkl-0000u5-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 12:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbaCZLMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 07:12:09 -0400
Received: from avasout05.plus.net ([84.93.230.250]:43352 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbaCZLMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 07:12:08 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2014 07:12:08 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id iB5z1n00B2iA9hg01B60ck; Wed, 26 Mar 2014 11:06:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=k1DKI6lHGiAA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=dVxzUTg7KSEBX5nH1q0A:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WSleh-00007v-Q2; Wed, 26 Mar 2014 11:05:59 +0000
Content-Disposition: inline
In-Reply-To: <20140224074905.GE9969@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245174>

On Mon, Feb 24, 2014 at 02:49:05AM -0500, Jeff King wrote:
> +# date is within 2^63-1, but enough to choke glibc's gmtime
> +test_expect_success 'absurdly far-in-future dates produce sentinel' '
> +	commit=$(munge_author_date HEAD 999999999999999999) &&
> +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
> +	git log -1 --format=%ad $commit >actual &&
> +	test_cmp expect actual
> +'

Git on AIX seems happy to convert this to Thu Oct 24 18:46:39
162396404 -0700. I don't know if this is correct for the given input
but the test fails.

Charles.
