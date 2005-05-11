From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 16:14:21 -0700
Message-ID: <428291CD.7010701@zytor.com>
References: <1115847510.22180.108.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:07:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0Ia-0006WI-Ge
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVEKXO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVEKXO4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:14:56 -0400
Received: from terminus.zytor.com ([209.128.68.124]:16824 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261310AbVEKXOu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:14:50 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4BNERIS021672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 May 2005 16:14:27 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: tglx@linutronix.de
In-Reply-To: <1115847510.22180.108.camel@tglx>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Gleixner wrote:
> This is an initial attempt to enable history tracking for multiple
> repositories in a consistent state. At the moment this can only be done
> by heuristic guessing on the parent dates and the committer names. 
> This fails for example with Dave Millers net-2.6 and sparc-2.6 trees, as
> in both cases the committer name is the same. It fails also completely
> in cases where the system clock of the committer is wrong and the merge
> is a head forward. The old bk repository contains entries from 1999 and
> 2027, which will happen also with git over the time. 
> 
> To identify a repository commit-tree tries to read an environment
> variable "GIT_REPOSITORY_ID" and has a fallback to the current working
> directory. The environment variable keeps the door open for managed
> repository id's, but the current working directory is certainly a quite
> helpful information to solve the origin decision for history tracking.
> 
> Adding a line after the committer should not break any existing tools
> AFAICS.
> 

I would like to suggest a few limiters are set on the repoid.  In 
particular, I'd like to suggest that a repoid is a UUID, that a file is 
used to track it (.git/repoid), and that if it doesn't exist, a new one 
is created from /dev/urandom.

	-hpa
