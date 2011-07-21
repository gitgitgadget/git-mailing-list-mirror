From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 17:18:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
References: <20110720221632.14223.qmail@science.horizon.com> <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home> <4E276DF8.8030301@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 02:18:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjgyP-00011t-5b
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1GUASg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:18:36 -0400
Received: from mail.lang.hm ([64.81.33.126]:58931 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1GUASf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:18:35 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6L0ISdn006582;
	Wed, 20 Jul 2011 17:18:28 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4E276DF8.8030301@cisco.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177565>

On Wed, 20 Jul 2011, Phil Hord wrote:

> On 07/20/2011 07:36 PM, Nicolas Pitre wrote:
>> On Wed, 20 Jul 2011, david@lang.hm wrote:
>> 
>>> If the generation number is part of the repository then it's going to
>>> be the same for everyone.
>> The actual generation number will be, and has to be, the same for
>> everyone with the same repository content, regardless of the cache used.
>> It is a well defined number with no room to interpretation.
>
> Nonsense.
>
> Even if the generation number is well-defined and shared by all clients, the 
> only quasi-essential definition is "for each A in ancestors_of(B), gen(A) < 
> gen(B)".
>
> In practice, the actual generation number *will be the same* for everyone 
> with the same repository content, unless and until someone develops a 
> different calculation method.  But there is no reason to require that the 
> number *has to be* the same for everyone unless you expect (or require) 
> everyone to share their gen-caches.

and I think this is why Linus is not happy with a cache. He is seeing this 
as something that has significantly more value if it is going to be 
consistant in a distributed manner than if it's just something calculated 
locally that can be different from other systems.

if it's just locally generated, then I could easily see generation numbers 
being different on different people's ssstems, dependin on the order that 
they see commits (either locally generated or pulled from others)

If it's part of the commit, then as that commit gets propogated the 
generation number gets propogated as well, and every repository will agree 
on what the generation number is for any commit that's shared.

I agree that this consistancy guarantee seems to be valuable.

> Surely there will be a competent and efficient gen-cache API.  But most code 
> can just ask if B --contains A or even just use rev-list and benefit from the 
> increased speed of the answer.  Because most code doesn't really care about 
> the gen numbers themselves, but only the speed of determining ancestry.

in that case, why bother with generation numbers at all? the improved data 
based heristic seems to solve that problem.

David Lang
