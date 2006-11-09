X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date
 from svn
Date: Thu, 09 Nov 2006 11:30:15 -0800
Message-ID: <455381C7.8080207@midwinter.com>
References: <455277A6.2000404@midwinter.com>	<20061109091937.GA22853@localdomain> <7vfyctkki5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 19:30:49 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=euWs6uQ7SfBKK21v4M0O6nSzsntcNVUXCkQ/nEtszLKfGshHvB3vAd+a+nt06TGx  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <7vfyctkki5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31201>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiFbc-0004jt-2f for gcvg-git@gmane.org; Thu, 09 Nov
 2006 20:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030257AbWKITa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 14:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWKITa2
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 14:30:28 -0500
Received: from tater.midwinter.com ([216.32.86.90]:35812 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S1030257AbWKITa1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 14:30:27 -0500
Received: (qmail 10675 invoked from network); 9 Nov 2006 19:30:27 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 9 Nov 2006 19:30:27 -0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Steven, I do not interact with real svn repository myself so I
> can only judge from the test in this patch and Steven's test
> case, so it would be more assuring for me if you can confirm it
> fixes the issue for you.
>   

It seems to; I can't make the problem happen any more. I am slightly 
concerned -- but I don't know libsvn well enough to say for sure -- that 
this doesn't actually *eliminate* the problem, but rather tightens the 
window of opportunity down to some very small amount of time. Which is 
certainly an improvement, of course!

Maybe only Eric can answer this, but from a cursory inspection, it 
doesn't look like it actually locks the modified files before generating 
the patch to apply. Is there still a possibility of losing a change that 
hits the svn repository in the middle of git-svn dcommit running? Or 
does locking happen implicitly somewhere I'm not seeing? (Again, I 
haven't combed the code deeply, so it's entirely possible I've missed 
something.)

-Steve
