From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 12:00:44 -0500
Message-ID: <509FD9BC.7050204@gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>	<20121108200919.GP15560@sigill.intra.peff.net>	<509CCCBC.8010102@drmicha.warpmail.net>	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>	<509E8EB2.7040509@drmicha.warpmail.net>	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>	<509EAA45.8020005@gmail.com> <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXauB-0005q9-8X
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2KKRAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:00:54 -0500
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45871 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2KKRAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:00:53 -0500
Received: by mail-gh0-f174.google.com with SMTP id g15so1085384ghb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YcMIKFRvsqkbryg3xrm8cp7h6okn5Vv9sdyiR5/lcqE=;
        b=y72zcZ0BhcIFgqwVf/cTK+pC/JVHTQ/8LV0/DvLZXdwjE4FJNPFuvS8f1zWdSndpwf
         aMmJqNfw0FdZ0s1Uc11DbelqR+ovLpoOMDl65vEgI0nRzVtjQI2Aq4K2LWLAEVvHMgbQ
         PWy2V2LzOkOvcw5ngqO9zyX9r3YVTVxXzY/zBbIZabgpSWQN+/V6jNlnlA66IqvKtXjE
         e7aHUxhqMqAKixAR4oNKOpkmEl8cE9hWHYNP1eVYOoa8bIBVWzjhTe5xphaSPg1wQI/h
         m+bDFFwtGoFTkDdNO3Y2aJbXWsPwvPm+qVyInVoF2+jEpNZQNIFkAFcMzjVoKXDXpAl9
         sF0Q==
Received: by 10.236.143.4 with SMTP id k4mr17479223yhj.111.1352653250595;
        Sun, 11 Nov 2012 09:00:50 -0800 (PST)
Received: from [10.0.1.132] ([97.104.180.2])
        by mx.google.com with ESMTPS id g6sm3869426ani.5.2012.11.11.09.00.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:00:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209413>

On 11/11/2012 07:41 AM, Felipe Contreras wrote:
> On Sat, Nov 10, 2012 at 8:25 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>> On 11/10/2012 01:43 PM, Felipe Contreras wrote:
>
>>> So, the options are:
>>>
>>> a) Leave the name conversion to the export tools, and when they miss
>>> some weird corner case, like 'Author<email', let the user face the
>>> consequences, perhaps after an hour of the process.
>>>
>>> We know there are sources of data that don't have git-formatted author
>>> names, so we know every tool out there must do this checking.
>>>
>>> In addition to that, let the export tool decide what to do when one of
>>> these bad names appear, which in many cases probably means do nothing,
>>> so the user would not even see that such a bad name was there, which
>>> might not be what they want.
>>>
>>> b) Do the name conversion in fast-import itself, perhaps optionally,
>>> so if a tool missed some weird corner case, the user does not have to
>>> face the consequences.
>>>
>>> The tool writers don't have to worry about this, so we would not have
>>> tools out there doing a half-assed job of this.
>>>
>>> And what happens when such bad names end up being consistent: warning,
>>> a scaffold mapping of bad names, etc.
>>>
>>>
>>> One is bad for the users, and the tools writers, only disadvantages,
>>> the other is good for the users and the tools writers, only
>>> advantages.
>>>
>>
>> c) Do the name conversion, and whatever other cleanup and manipulations
>> you're interesting in, in a filter between the exporter and git-fast-import.
>
> Such a filter would probably be quite complicated, and would decrease
> performance.
>

Really?

The fast import stream protocol is pretty simple. All the filter really 
needs to do is pass through everything that isn't a 'commit' command. 
And for the 'commit' command, it only needs to do something with the 
'author' and 'committer' lines; passing through everything else.

I agree that an additional filter _may_ decrease performance somewhat if 
you are already CPU constrained. But I suspect that the effect would be 
negligible compared to the all of the SHA-1 calculations.
