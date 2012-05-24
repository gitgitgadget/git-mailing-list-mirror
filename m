From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 14:05:16 +0200
Message-ID: <4FBE23FC.5070405@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <20120521221417.GA22664@sigill.intra.peff.net> <20120521235219.GA5589@sigill.intra.peff.net> <4FBB0F21.5080608@alum.mit.edu> <20120522041123.GA9972@sigill.intra.peff.net> <4FBB3D2B.4010300@alum.mit.edu> <20120522073740.GA10093@sigill.intra.peff.net> <4FBB9480.4010407@alum.mit.edu> <20120522173355.GC11600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 14:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXWu3-0002uC-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 14:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab2EXMMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 08:12:23 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:50353 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754595Ab2EXMMW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 08:12:22 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 08:12:22 EDT
X-AuditID: 1207440d-b7f336d00000097b-a0-4fbe23ff444b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BA.9D.02427.FF32EBF4; Thu, 24 May 2012 08:05:19 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4OC5Hlm010846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 08:05:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120522173355.GC11600@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqPtfeZ+/QXujukXXlW4mi4beK8wW
	99+vY7L40dLD7MDicbmvl8njWe8eRo+Ll5Q9Pm+SC2CJ4rZJSiwpC85Mz9O3S+DOOHP3OFPB
	A/mKOyseszUwrpPsYuTkkBAwkZi7dAU7hC0mceHeerYuRi4OIYHLjBKfVi9hgXCOM0l0rPvH
	BlLFK6AtsfzpR1YQm0VAVeLUuk1MIDabgK7Eop5mIJuDQ1QgTGL1Aw2IckGJkzOfsIDYIgKy
	Et8Pb2QEsZkF2hklzu+1A7GFBZwkVvyYygqxazGzRMPuBWDzOQWsJY4duMEE0WAm0bW1C6pZ
	XmL72znMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWm
	lG5ihAQ07w7G/+tkDjEKcDAq8fB2Cez1F2JNLCuuzD3EKMnBpCTKy6W0z1+ILyk/pTIjsTgj
	vqg0J7X4EKMEB7OSCG+TFFCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PB
	oSTBaw+MXCHBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7TXFKSd
	t7ggMRcoCtF6ilGX48rvidcZhVjy8vNSpcR51UGKBECKMkrz4FbA0tcrRnGgj4V5VUGqeICp
	D27SK6AlTEBLtjzeC7KkJBEhJdXAWJBjE568Qjtsx7rb/j/9RFi3PRM8k3y24cmDC5OqNoYo
	sUcfF33vcz/TztDz2tpDetciFd7u+7TH9HXKYw2DdcsXXfC4w+OcILK1/2DGboWf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198367>

On 05/22/2012 07:33 PM, Jeff King wrote:
> On Tue, May 22, 2012 at 03:28:32PM +0200, Michael Haggerty wrote:
>
>>> When I try it with both 'next' and v1.7.10, I see that the latter is
>>> much faster.  I did my tests with a warm cache, but the interesting
>>> number is the CPU time, which is quite different.
>>
>> I cannot reproduce anything as big as the performance regression that
>> you see.  I did find a regression 9.5 s ->  10.1 s caused by
>>
>> 5fa044184 find_containing_dir(): use strbuf in implementation of this
>> function
>>
>> It is fixed by the patch that I just sent to the mailing list [1],
>> which sizes the strbuf in that function to strlen(refname) instead of
>> PATH_MAX.  Since your experiments suggest that the performance
>> regression is related to the size of the repository contents, it
>> could be that the same test produces more memory pressure on your
>> system and therefore a larger effect.  Please try the patch and tell
>> me if it fixes the problem for you.
>
> That patch drops about a second off of the slow case, but the main
> problem still remains. Just to be sure we are both doing the exact same
> thing, here is a complete reproduction recipe:
>
>    GIT=/path/to/your/git/checkout
>    RAILS=/path/to/unpacked/rails.git
>
>    cd $GIT&&
>    git checkout 432ad41e60cedb87ceec446ab034d46a53f5f9d8^&&
>    make&&
>
>    cd $RAILS&&
>    time $GIT/bin-wrappers/git fetch . refs/*:refs/*&&
>
>    cd $GIT&&
>    git checkout 432ad41e60cedb87ceec446ab034d46a53f5f9d8&&
>    make&&
>
>    cd $RAILS&&
>    time $GIT/bin-wrappers/git fetch . refs/*:refs/*
>
> produces:
>
>    [before]
>    real    0m9.128s
>    user    0m9.369s
>    sys     0m0.976s
>
>    [after]
>    real    0m15.926s
>    user    0m16.181s
>    sys     0m0.984s
>
> I don't think memory pressure is involved. The git process maxes out at
> ~300M, and this machine has 7.5G available.
>
> I wonder why we are getting different results. Could it be compilation
> options? As I mentioned, I compile with -O0, but I got similar results
> with -O3.

Thanks for the idiot-proof reproduction steps.  I don't know what I was 
doing differently last time, but now I can reproduce your slowdown.

The thing that triggers the problem is a reference directory 
("refs/remotes/8514/pull/") with 3810 sub-namespaces 
("refs/remotes/8514/pull/1091", "refs/remotes/8514/pull/1092", etc), 
each subnamespace containing only one or two references.  It wouldn't be 
a problem having so many *references* in a namespace, because references 
are just added to the end of the directory unsorted, and typically only 
sorted once after all of them have been added.  But every time that a 
sub-namespace is accessed, the namespace has to be searched to see if 
that sub-namespace already exists.  The searching requires the namespace 
to be sorted.  So, for example, when adding the following sequence of 
references:

1. refs/remotes/8514/pull/1091/head
2. refs/remotes/8514/pull/1091/merge
3. refs/remotes/8514/pull/1092/head
4. refs/remotes/8514/pull/1092/merge
5. refs/remotes/8514/pull/1093/head
6. refs/remotes/8514/pull/1093/merge

At step 1, sub-namespace "refs/remotes/8514/pull/1091/" is added to 
"refs/remotes/8514/pull/".  This makes the code think that 
"refs/remotes/8514/pull/" is unsorted.

Step 2 is not problematic; the new references is added to 
"refs/remotes/8514/pull/1091/", but adding a reference doesn't require 
the ref_dir to be sorted.

At step 3, namespace "refs/remotes/8514/pull/" is first checked to see 
if sub-namespace "refs/remotes/8514/pull/1092/" already exists.  This 
search requires namespace "refs/remotes/8514/pull/" to be sorted because 
step 1 caused it to be considered unsorted.

Again at step 5, namespace "refs/remotes/8514/pull/" needs to be sorted, 
and so on every time a subnamespace is added.

I will submit a patch shortly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
