From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 01:22:40 -0500
Message-ID: <45D54DB0.4090300@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net>
 <7vire2c00i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 07:22:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHwUW-0004C4-O7
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 07:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423341AbXBPGWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 01:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423343AbXBPGWl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 01:22:41 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:46680 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423341AbXBPGWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 01:22:41 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDJ00KN9LPRICS6@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 00:22:40 -0600 (CST)
In-reply-to: <7vire2c00i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39889>

Junio C Hamano wrote:
> Mark Levedahl <mdl123@verizon.net> writes:
>
>   
>> +# check that the prerequisites exist before unbundling.
>> +for sha1 in $prereqs ; do
>> +	git-rev-parse --verify $sha1 >& /dev/null || die "Prerequisite commit $sha1 not found."
>> +done
>>     
>
> If you are checking only boundary commits this is too weak a
> check and unsafe (we used to have the same bug in http fetch
> long time ago).  You have to make sure not only the object
> exists, but also it is reachable by one of the refs.
>
> One way to check that would be to ask "describe --all" if it can
> find a ref that can reach that commit.  It would error out if
> the commit object exists but is not reachable from any of the
> refs
I'm not sure I follow the logic here. Assuming the object is a 
prerequisite of the bundle and exists, it will be reachable from an 
updated reference once the bundle is applied, no? In any case, Linus' 
suggestion is very neat and fast, and I presume reliable.

Mark
