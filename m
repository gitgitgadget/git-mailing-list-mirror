From: Erik Blake <erik@icefield.yk.ca>
Subject: Re: Escape character for .gitconfig
Date: Sun, 18 Dec 2011 08:53:09 +0100
Message-ID: <4EED9BE5.8060600@icefield.yk.ca>
References: <4EEC6A9D.1060005@icefield.yk.ca> <20111217105806.GB23935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 18 09:33:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcCBn-0007b6-AR
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 09:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab1LRIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 03:33:43 -0500
Received: from bosmailout18.eigbox.net ([66.96.185.18]:59528 "EHLO
	bosmailout18.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab1LRIdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 03:33:41 -0500
X-Greylist: delayed 2427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Dec 2011 03:33:41 EST
Received: from bosmailscan16.eigbox.net ([10.20.15.16])
	by bosmailout18.eigbox.net with esmtp (Exim)
	id 1RcBYX-0000fK-B7
	for git@vger.kernel.org; Sun, 18 Dec 2011 02:53:13 -0500
Received: from bosimpout01.eigbox.net ([10.20.55.1])
	by bosmailscan16.eigbox.net with esmtp (Exim)
	id 1RcBYW-000302-VH; Sun, 18 Dec 2011 02:53:12 -0500
Received: from bosauthsmtp05.eigbox.net ([10.20.18.5])
	by bosimpout01.eigbox.net with NO UCE
	id AXtD1i00106Zqne01XtDgt; Sun, 18 Dec 2011 02:53:13 -0500
X-EN-OrigOutIP: 10.20.18.5
X-EN-IMPSID: AXtD1i00106Zqne01XtDgt
Received: from 221.59.9.46.customer.cdi.no ([46.9.59.221] helo=[192.168.2.3])
	by bosauthsmtp05.eigbox.net with esmtpa (Exim)
	id 1RcBYW-0007Z6-OD; Sun, 18 Dec 2011 02:53:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111217105806.GB23935@sigill.intra.peff.net>
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 46.9.59.221
X-EN-OrigHost: 221.59.9.46.customer.cdi.no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187416>

Thanks Jeff,
That did the trick for this git newb. For the record, I had tried \(, 
/(, double- and single-quoting the entire path (note that git config 
--global had removed the quotes that were originally around the string). 
Did not think of "nested" quotes.

Now, however, I have a different problem in that notepad++ is somehow 
signalling git that editing is complete before I even get a chance to 
edit the file. I am trying the command
 >git commit --amend

Notepad++ opens with the message, but git completes the commit before I 
get a chance to make any changes. I suspect the issue is that git fires 
up a new instance of notepad++ (which in my case is already running with 
some other files open). notepad++ sees the new instance starting and 
subsumes it under the pre-existing instance and then closes the new 
instance. git sees the task close and assumes I am done editing.

Oh well. Cannot use notepad.exe because it does not handle <lf> line 
endings. I guess I'll stick to the git gui.

e.

On 2011-12-17 11:58, Jeff King wrote:
> On Sat, Dec 17, 2011 at 11:10:37AM +0100, Erik Blake wrote:
>
>> I have an editor path that includes "(" and ")". No matter how I try
>> to escape this character, I get either variations on:
>>
>> C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0: syntax
>> error near unexpected token `('
>> C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0:
>> `C:/Program Files (x86)/Notepad++/notepad++.exe \$@\'
>> error: There was a problem with the editor 'C:/Program Files
>> (x86)/Notepad++/notepad++.exe'.
>> Please supply the message using either -m or -F option.
>>
>> or:
>>
>> fatal: bad config file line 5 in C:\Users\xxx/.gitconfig
>
> You didn't tell us what you actually tried, so I don't know where you
> went wrong.
>
> But you will need to quote the whole value for git to read from your
> gitconfig, and then quote any metacharacters in the value so that the
> shell doesn't interpret them. I think you want:
>
>    [core]
>      editor = "'C:/Program Files (x86)/Notepad++/notepad++.exe'"
>
> -Peff
