From: Andreas Ericsson <ae@op5.se>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 20:14:03 +0100
Message-ID: <43C558FB.3030102@op5.se>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:14:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwlQA-0004si-2X
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWAKTOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWAKTOG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:14:06 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24223 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750773AbWAKTOF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:14:05 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2812C6BD03; Wed, 11 Jan 2006 20:14:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14498>

Linus Torvalds wrote:
> Guess what the difference is here?
> 
> 	[torvalds@g5 ~]$ du -sh bin/
> 	14M     bin/
> 	[torvalds@g5 ~]$ du -sh bin/
> 	5.8M    bin/
> 
> Give up?
> 
> In one case, "git" was compiled with the default options in the git 
> Makefile. In the other one, the "-g" was removed.
> 
> Now, maybe this is extra visible with PowerPC (32-bit) binaries, and it's 
> not as bad on x86, but it's still a bit distressing.
> 
> That "-g" doesn't buy users much of anything, and I doubt most developers 
> care that deeply most of the time either (and can easily add it when they 
> do care). It's left-over from long ago when it was much more useful.
> 
> So I'd suggest just removing it.
> 

I'd suggest adding

strip:
	strip $(PROGRAMS)

install: strip

to Makefile instead. That way people working on various git-tools won't 
have to remember to override the CFLAGS when debugging new stuff.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
