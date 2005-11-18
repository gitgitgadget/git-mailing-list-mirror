From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 12:55:29 -0800
Message-ID: <437E3FC1.2040307@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <437E3971.3060803@zytor.com> <Pine.LNX.4.64.0511181237040.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:33:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDGx-0007q7-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbVKRUzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbVKRUzs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:55:48 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33172 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161214AbVKRUzr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:55:47 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAIKtYf8012882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 12:55:34 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181237040.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12274>

Linus Torvalds wrote:
> 
> Which is a fine option. Latin-1 is probably the right choice for the 
> kernel, but not necessarily for other projects.
> 
> Another option is to just pass them through unmodified, and encourage the 
> XML parser to handle it. Anything that takes UTF-8 and doesn't have some 
> fallback to handle malformed input is basically buggy. It simply _will_ 
> happen occasionally, quite independently of git.  You can either give up, 
> or try to handle it. And giving up is always the wrong choice.
> 

Not necessarily.  If you can't guarantee that you won't do something 
that's bad for security, giving up is the only valid choice.

The problem, of course, comes into place when people write generic XML 
parsers -- or, for that matter, UTF-8 decoders -- and don't know what 
will happen to the data downstream.  Trying to make invalid data valid 
has the same problems as DWIM (after all, it *is* DWIM): if done on the 
wrong side of a security barrier it has unpredictable consequences.

Thus, making gitweb -- a producer application -- do the guessing is 
probably the right thing.

Sorry, Mr. Protocol; in this malware-infested world the old adage "be 
liberal in what you accept, conservative in what you send" unfortunately 
has had to be modified.

	-hpa
