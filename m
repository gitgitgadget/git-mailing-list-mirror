From: Phil Hord <hordp@cisco.com>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 20:08:24 -0400
Message-ID: <4E276DF8.8030301@cisco.com>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, George Spelvin <linux@horizon.com>,
	anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 02:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjgob-0006X1-2g
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab1GUAI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:08:27 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:28446 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1GUAI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1247; q=dns/txt;
  s=iport; t=1311206907; x=1312416507;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=LkkptpUsEvb0pEdieskgmQRibGVJvCD7uHPGjDf3fLI=;
  b=JUeVQX6iBrr0KfYfWwJ2h4I1mtiLMkdhhKI7HwZu9dUjQBTq93DU6N74
   zty4pQ6gFJU9V9FDba8ot10A6PfWtjsvDswezEf7gY1rmkZ0eZSd87LjY
   NsnUHoavWiDaBhD11Q2UZYBERa6dyAo0TcYOwj2s1k8irdB1iUQ2jJb6f
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EALdtJ06tJXHB/2dsb2JhbABTp2R3pxWeHYY9BJJuhQeLcg
X-IronPort-AV: E=Sophos;i="4.67,238,1309737600"; 
   d="scan'208";a="4916355"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-1.cisco.com with ESMTP; 21 Jul 2011 00:08:26 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core2-6.cisco.com (8.14.3/8.14.3) with ESMTP id p6L08PAg009667;
	Thu, 21 Jul 2011 00:08:25 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <alpine.LFD.2.00.1107201931510.21187@xanadu.home>
X-TagToolbar-Keys: D20110720200824747
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177564>

On 07/20/2011 07:36 PM, Nicolas Pitre wrote:
> On Wed, 20 Jul 2011, david@lang.hm wrote:
>
>> If the generation number is part of the repository then it's going to
>> be the same for everyone.
> The actual generation number will be, and has to be, the same for
> everyone with the same repository content, regardless of the cache used.
> It is a well defined number with no room to interpretation.

Nonsense.

Even if the generation number is well-defined and shared by all clients, 
the only quasi-essential definition is "for each A in ancestors_of(B), 
gen(A) < gen(B)".

In practice, the actual generation number *will be the same* for 
everyone with the same repository content, unless and until someone 
develops a different calculation method.  But there is no reason to 
require that the number *has to be* the same for everyone unless you 
expect (or require) everyone to share their gen-caches.

Surely there will be a competent and efficient gen-cache API.  But most 
code can just ask if B --contains A or even just use rev-list and 
benefit from the increased speed of the answer.  Because most code 
doesn't really care about the gen numbers themselves, but only the speed 
of determining ancestry.

Phil
