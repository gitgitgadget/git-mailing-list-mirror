X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 15:49:19 -0800
Message-ID: <4579F9FF.7050701@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>	 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>	 <45798FE2.9040502@zytor.com>	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>	 <457998C8.3050601@garzik.org>	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:50:11 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.6/2308/Fri Dec  8 08:10:24 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33772>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GspTj-0007rH-Ua for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947504AbWLHXtn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947508AbWLHXtn
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:49:43 -0500
Received: from terminus.zytor.com ([192.83.249.54]:49339 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1947504AbWLHXtl (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 18:49:41 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id
 kB8NnNoL003129 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Fri, 8 Dec 2006 15:49:23 -0800
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

Michael K. Edwards wrote:
> On 12/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> You can't have a cache architecture where the client just does a "get",
>> like memcached does. You need to have a "read-for-fill" operation ...
> 
> In Squid 2.6:
>    collapsed_forwarding on
>    refresh_stale_window <seconds>
> (apply the latter only to stanzas where you want "readahead" of
> about-to-expire cache entries)
> 
> Brief design description at 
> http://devel.squid-cache.org/collapsed_forwarding/.
> 
> (I didn't write this code, everything I know about squid leaked
> through the Google-shaped pinhole in my tinfoil hat, etc.  But if you
> go this way I'd like to be in the loop to understand the scalability
> issues around netfilter-assisted transparent proxying.)
> 

There is another thing that probably will be required, and I'm not sure 
if something in front of Apache (like Squid) rather than behind it can 
easily deal with: on timeout, the process needs to continue in order to 
feed the cache.  Otherwise, you're still in a failure scenario as soon 
as timeout happens.

