From: Phil Hord <hordp@cisco.com>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 20:47:39 -0400
Message-ID: <4E27772B.60306@cisco.com>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com> <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm> <CAJo=hJuS_iYSS8iVWoJ1BiUANsGtYJoYm-WRa863isVNsq=5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 02:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjhQZ-0000Jj-IM
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab1GUArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:47:42 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:23119 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1GUArl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1755; q=dns/txt;
  s=iport; t=1311209261; x=1312418861;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=ayh308Pi6tjbl6SBvllWHK0ItthXsMl54NqurHtUk4E=;
  b=HVWS0PRFnEJCeXsLMtQlRnxV/OtQylIZyeXFUBGzBU+sOv7py/yosgAL
   T4Z5X4IZAwh87fLyqft3k8C8Q9ZlJuHWT2Y5ouWFnqpst0j9udl9odVJv
   k53H7NI0AHYqJejj57I9Mn7ZkYttM9ahrRTwOULvDRt5lm/eidfBG+tOl
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAL92J06tJXG9/2dsb2JhbABTp2R3iHyda54dhj0Ekm6FB4ty
X-IronPort-AV: E=Sophos;i="4.67,238,1309737600"; 
   d="scan'208";a="4923447"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-6.cisco.com with ESMTP; 21 Jul 2011 00:47:41 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core2-2.cisco.com (8.14.3/8.14.3) with ESMTP id p6L0lePq010383;
	Thu, 21 Jul 2011 00:47:40 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <CAJo=hJuS_iYSS8iVWoJ1BiUANsGtYJoYm-WRa863isVNsq=5vw@mail.gmail.com>
X-TagToolbar-Keys: D20110720204739363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177568>


On 07/20/2011 08:37 PM, Shawn Pearce wrote:
> On Wed, Jul 20, 2011 at 17:18,<david@lang.hm>  wrote:
>> if it's just locally generated, then I could easily see generation numbers
>> being different on different people's ssstems, dependin on the order that
>> they see commits (either locally generated or pulled from others)
> But this should only happen if the user fudges with their Git sources
> and makes Git produce a different generation number.
>
> If the algorithm is always "gen(A) = max(gen(P) for each parent_of(A))
> + 1" then it doesn't matter who merged what commits, the same commit
> appears at the same part of the graph relative to all of its
> ancestors, and therefore always has the same generation number. This
> is true whether or not the commit contains the generation number.

Interesting.  I was going to disagree with the latter part of your 
statement, but then I realized you're right.

And that your algorithm allows duplicate generation numbers.

And that there's nothing wrong with that.

Because it meets the one quasi-essential need, "for each A in 
ancestors_of(B), gen(A) < gen(B)".

>> If it's part of the commit, then as that commit gets propogated the
>> generation number gets propogated as well, and every repository will agree
>> on what the generation number is for any commit that's shared.
> This isn't really as beneficial as you are making it out to be. We
> already can agree on what the generation number should be for any
> given commit, if you topo-sort the commit DAG, you get the same
> result.
>
>> I agree that this consistancy guarantee seems to be valuable.
> Its valuable, but its consistent either with a cache, or not.

I still fail to see the value.

Phil
