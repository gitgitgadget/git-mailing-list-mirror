From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Any plans to support JTA and XA in jgit?
Date: Thu, 13 Nov 2008 15:27:42 -0500
Message-ID: <491C8DBE.9080105@wellfleetsoftware.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ioJ-0001rK-Vp
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYKMU1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYKMU1n
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:27:43 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:53493 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYKMU1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:27:42 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAA003PAGU5UA91@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 13 Nov 2008 14:27:42 -0600 (CST)
In-reply-to: <200811132059.16616.robin.rosenberg.lists@dewire.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100913>

Robin Rosenberg wrote:
> torsdag 13 november 2008 20:20:49 skrev Farrukh Najmi:
>   
>> Does the gjit team have any plans to implement support for JTA in gjit 
>> so as to allow distributed transactions using 2 phase commit? This would 
>> be very powerful when git is being used in conjunction with other 
>> transaction resource managers such as databases.
>>     
>
> No such plans exist. We do not even have a J2EE Resource Manager yet. I
> did some toying implementing one. As for XA support, I guess that would
> not be very hard per se, but my thoughts on JEE support was more in the direction
> of gitweb-like stuff, i.e. reading.
>   

I am not an expert on this but what I thought could be done is to 
enhance jgit so it can serve the role of a JTA compliant transactional 
resource manager similar to that in JDBC, JMS etc. As part of that it 
could serve resources as JTA XAResource.
Not sure how hard all this could be though.
> Trying to involve git in distributed database transactions might be cool, but seriously: Do you
> need it? 

The problem I am trying to solve is this. In my service I need to store 
metadata in a relational db and content in git such that both either 
commit or not in a single transaction. If one commits and the other does 
not that is a serious integrity issue. Seems to me, two phase commit 
would be the right solution for that in the long run. This what JDBC + 
JMS topologies do.

A totally separate issue I have to sort out is how to handle multiple 
unrelated transactions that are modifying the same git repo. If a 
transaction needs to be rolled back how do roll back exactly some 
changes in some files in git that were impacted by the transaction. This 
is not easy because git (and most VCS) do not have transaction isolation 
like databases do. Any suggestions?

> As for JEE my ideas are: A nice JSP tag library and a resource manager. When is
> an entirely different question, as is who. Did you look at  my experiment in a reply of mine
> in another recent jgit thread?
>   

I am not very well versed in tag libraries myself. My situation is one 
where everything happens inside a SOAP service endpoint and so I suspect 
JSP tag libraries are not likely to be useful in that situation. Let me 
know if I am wrong in this assessment.

> The term "distributed" in XA is not quite the same as in distributed verison control. 
That is correct.

> If it would,
> then we'd send SQL commands over e-mail (now, /that/ would be cool :)

+1

Thanks very much for your help and that of other colleagues on the list.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
