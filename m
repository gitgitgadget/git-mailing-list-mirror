From: Steven Grimm <koreth@midwinter.com>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 01 Aug 2007 16:35:31 +0800
Message-ID: <46B045D3.4070208@midwinter.com>
References: <20070801013450.GA16498@raptus.dandreoli.com> <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org> <20070801063209.GA13511@raptus.dandreoli.com> <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net> <20070801074237.GA14790@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 10:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG9md-00047o-Pt
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 10:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbXHAImR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 04:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXHAImR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 04:42:17 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:34186 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753490AbXHAImQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 04:42:16 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Aug 2007 04:42:15 EDT
Received: (qmail 10939 invoked from network); 1 Aug 2007 08:35:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=h0/sW4MyGGjEfG7/hV0I8CBp9jEH4s+qt/kiajYY+ruG1X52x21mg+zVDZuSuUqZ  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 1 Aug 2007 08:35:33 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <20070801074237.GA14790@raptus.dandreoli.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54416>

Domenico Andreoli wrote:
> What is this reflog thing and why is required?
>   

It is a log of where each ref pointed at any given time. Or rather, a 
log of changes to refs, with timestamps. It is not *required* per se 
(you can turn it off and almost all of git will continue to work as 
before) but it's handy in that you can say stuff like

git checkout -b newbranch master@"{4 days ago}"

and git will give you a new branch pointing at the rev that master 
pointed to 4 days ago, even if it's a rev that is no longer reachable 
from any of the existing heads (e.g., because you did a "git rebase" and 
the rev in question was replaced by a new one.) Obviously as soon as you 
do a "git gc" you will lose the ability to go back to unreachable revs 
using the reflog.

I primarily use the reflog to undo rebase operations. Not that I need to 
do that very often, but it's occasionally handy, e.g., if there was a 
conflict and I made a mistake while resolving it.

-Steve
