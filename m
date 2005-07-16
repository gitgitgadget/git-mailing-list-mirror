From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git daemon"
Date: Fri, 15 Jul 2005 19:06:10 -0700
Message-ID: <42D86B92.7010303@zytor.com>
References: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 04:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtc4w-00013G-2x
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 04:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGPCGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 22:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVGPCGx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 22:06:53 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64134 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261708AbVGPCGw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 22:06:52 -0400
Received: from [10.255.254.158] ([216.208.38.107])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j6G26bOv014376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Jul 2005 19:06:39 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.86.1, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> What I'd ask people to check is how comfortable for example kernel.org 
> would be to have one machine that runs this kind of service? I've tried 
> very hard to set it up so that it doesn't have any security issues: the 
> daemon can be run as "nobody", and it shouldn't ever even write to any 
> files, although I guess we should do a full check of that.
> 

Since it can be run as a sequestered user, and we now have plenty of CPU 
horsepower on the download servers, it seems like it should be an 
entirely sane thing to do.

Is this thing meant to be run from inetd, or is it a "listen and fork" 
daemon?  Especially the latter case, it absolutely *have* to have 
protections for:

- "SYN and run" DoS attacks;
- Too many connections from the same IP;
- Too many processes running total.

	-hpa
