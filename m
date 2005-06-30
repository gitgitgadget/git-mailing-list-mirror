From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 16:40:29 -0700
Message-ID: <42C482ED.1010306@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 01:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do8Yx-00030U-UR
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 01:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbVF3Xm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbVF3Xm1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 19:42:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:37860 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263117AbVF3XlC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 19:41:02 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j5UNeYmK022732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 16:40:34 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
>>For producing minimum network traffic, I think something like this would 
>>work:
> 
> In the "minimum traffic", the thing to look at is number of packets, and 
> penalize further for anything that requires a synchronous reply.
> 
> That's why I'd suggest just letting the client stream out the list of
> objects it has - it may appear wasteful to stream out even a thousand
> SHA1's, but hey, that's just 20kB worth of data, and especially if there
> is no synchronous stuff, that's just 15 ethernet packets.
> 

In your linux-2.6 tree, there are currently 54,204 objects, and that is 
after less than one full 2.6.x kernel release cycle.  That's a megabyte 
of SHA1s.

In /pub/scm on kernel.org, there are currently 1,815,573 objects or hard 
links to objects, which would take a 36.3 MB list to produce.

Although this is better than what rsync does, which is it encodes this 
list into ASCII with pathnames and all and it ends up being closer to 
200 MB, it isn't fundamentally different.

	-hpa
