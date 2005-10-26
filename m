From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 16:55:32 +0200
Message-ID: <435F98E4.8040301@op5.se>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net> <435F4B05.4010702@op5.se> <Pine.LNX.4.63.0510261637070.26622@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 26 17:01:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUmgj-0005BQ-Uv
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 16:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVJZOze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 10:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVJZOze
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 10:55:34 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:63117 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964774AbVJZOzd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 10:55:33 -0400
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 049C16BD01
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 16:55:33 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0510261637070.26622@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10669>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 26 Oct 2005, Andreas Ericsson wrote:
> 
> 
>>I'd be more worried about the fact that the kilobytes count is way off 
>>as it is. du (at least from coreutils-5.2.1) rounds up to nearest 
>>kilobyte *for each file* when printing kb-count.
> 
> 
> The rationale behind this: You want to know how much space it takes on 
> your hard disk. Remember, git-count-objects should give you a clue whether 
> to repack or not.
> 

Oh. I thought it was so I would know how much data would be sent over 
the network. Diskspace is cheap, bandwidth is... well, that's cheap too 
(in Sweden at least), but it's boring to wait.

> Actually, "du -k" in my tests rounds up to nearest block size or kilobytes 
> (whichever is greater): For example, "du -k" on a very small file (53 
> bytes) says "1" on an ext2fs yields "1", "4" on hfs, and 32 on a big 
> FAT32. Of course, you may get different values, since the block sizes 
> sometimes depend on the total size of the media.
> 

 From my du man-page:

  -k     like --block-size=1K

I think *most* du implementations work like this, but apparently not all 
of them. I'll hack something up in C instead so it's at least consistent 
regardless of what version of du is used.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
