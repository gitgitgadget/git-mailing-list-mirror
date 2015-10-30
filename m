From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4] ref-filter: fallback on alphabetical comparison
Date: Fri, 30 Oct 2015 23:51:53 +0100
Message-ID: <5633F489.60008@kdbg.org>
References: <1446194728-7944-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 23:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIWf-0002Gr-6s
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966259AbbJ3Wv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:51:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:16847 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965292AbbJ3Wv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:51:56 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nnf5k2w10z5tl9;
	Fri, 30 Oct 2015 23:51:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 05A4C536F;
	Fri, 30 Oct 2015 23:51:54 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446194728-7944-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280557>

Am 30.10.2015 um 09:45 schrieb Karthik Nayak:
> In ref-filter.c the comparison of refs while sorting is handled by
> cmp_ref_sorting() function. When sorting as per numerical values
> (e.g. --sort=objectsize) there is no fallback comparison when both
> refs hold the same value. This can cause unexpected results (i.e. the
> order of listing refs with equal values cannot be pre-determined) as
> pointed out by Johannes Sixt ($gmane/280117).
>
> Hence, fallback to alphabetical comparison based on the refname
> whenever the other criterion is equal.
>
> A test in t3203 was expecting that branch-two sorts before HEAD, which
> happened to be how qsort(3) on Linux sorted the array, but (1) that
> outcome was not even guaranteed, and (2) once we start breaking ties
> with the refname, "HEAD" should sort before "branch-two" so the
> original expectation was inconsistent with the criterion we now use.
>
> Update it to match the new world order, which we can now depend on
> being stable.

Needless to say that the patch fixes the test failure on Windows. (I 
tested v2 of the patch.)

-- Hannes
