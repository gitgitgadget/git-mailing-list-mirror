From: "Daniel Bratell" <bratell@opera.com>
Subject: Re: Merging submodules - best merge-base
Date: Thu, 07 Mar 2013 10:49:09 +0100
Organization: Opera Software
Message-ID: <op.wtklj7e9rbppqq@cicero.linkoping.osa>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
 <20130306181156.GA4114@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Jens Lehmann" <jens.lehmann@web.de>
To: "Heiko Voigt" <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 10:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDXSw-0001uO-5q
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 10:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3CGJty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 04:49:54 -0500
Received: from smtp.opera.com ([213.236.208.81]:36547 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab3CGJtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 04:49:18 -0500
Received: from cicero.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r279nD6K020576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Mar 2013 09:49:14 GMT
In-Reply-To: <20130306181156.GA4114@sandbox-ub>
User-Agent: Opera Mail/12.14 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217583>

Den 2013-03-06 19:12:05 skrev Heiko Voigt <hvoigt@hvoigt.net>:

> On Mon, Feb 25, 2013 at 05:44:05PM +0100, Daniel Bratell wrote:
>> I can phrase this in two ways and I'll start with the short way:
>>
>> Why does a merge of a git submodule use as merge-base the commit that  
>> was
>> active in the merge-base of the parent repo, rather than the merge-base  
>> of
>> the two commits that are being merged?
>>
>> The long question is:
>>
>> A submodule change can be merged, but only if the merge is a
>> "fast-forward" which I think is a fair demand, but currently it checks  
>> if
>> it's a fast-forward from a commit that might not be very interesting
>> anymore.
>>
>> If two branches A and B split at a point when they used submodule commit
>> S1 (based on S), and both then switched to S2 (also based on S) and B  
>> then
>> switched to S21, then it's today not possible to merge B into A, despite
>> S21 being a descendant of S2 and you get a conflict and this warning:
>>
>> warning: Failed to merge submodule S (commits don't follow merge-base)
>>
>> (attempt at ASCII gfx:
>>
>> Submodule tree:
>>
>> S ---- S1
>>    \
>>     \ - S2 -- S21
>>
>> Main tree:
>>
>> A' (uses S1) --- A (uses S2)
>>    \
>>     \ --- B' (uses S2) -- B (uses S21)
>>
>>
>> I would like it to end up as:
>>
>> A' (uses S1) --- A (uses S2) ------------ A+ (uses S21)
>>    \                                     /
>>     \ --- B' (uses S2) -- B (uses S21)- /
>>
>> And that should be legal since S21 is a descendant of S2.
>
> So to summarize what you are requesting: You want a submodule merge be
> two way in the view of the superproject and calculate the merge base
> in the submodule from the two commits that are going to be merged?
>
> It currently sounds logical but I have to think about it further and
> whether that might break other use cases.

Maybe both could be legal even. The current code can't be all wrong, and  
this case also seems to be straightforward.

/Daniel
