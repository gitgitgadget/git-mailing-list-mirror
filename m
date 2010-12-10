From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 10/18] gitweb: Adding isBinaryAction() and isFeedAction()
 to determine the action type
Date: Thu, 09 Dec 2010 19:39:47 -0800
Message-ID: <4D01A103.3090900@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-11-git-send-email-warthog9@eaglescrag.net> <m3lj3y1ogb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 04:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQtoA-0008T8-N6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 04:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab0LJDiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 22:38:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:36352 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0LJDiE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 22:38:04 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA3c0LG026271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 19:38:00 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3lj3y1ogb.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 19:38:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163385>

>> This is fairly self explanitory, these are here just to centralize the checking
>> for these types of actions, as special things need to be done with regards to
>> them inside the caching engine.
>>
>> isBinaryAction() returns true if the action deals with creating binary files
>> (this needing :raw output)
> 
> Why do you need special case binary / :raw output?  It is not really
> necessary if it is done in right way, as shown in my rewrite.

Because that's not how my caching engine does it, and the reason for
that is I am mimicking how the rest of gitweb does it.

I attempted at one point to do as you were suggesting, and it became too
cumbersome.  I eventually broke out the 'binary' packages into a special
case (thus mimicking how gitweb is already doing things), which also
gives me the advantage of being able to checksum the resulting binary
out of band, as well as being able to more trivially calculate the file
size being sent.

>> isFeedAction() returns true if the action deals with a news feed of some sort,
>> basically used to bypass the 'Generating...' message should it be a news reader
>> as those will explode badly on that page.
> 
> Why blacklisting 'feed', instead of whitelisting HTML-output?

There are a limited number of feed types and their ilk (standard xml
formatted feed and atom), there are lots of html-output like things.
Easier to default and have things work, generally, than to have things
not work the way you would expect.

> BTW., please don't use mixedCase names, but underline_separated.

fixed in v9

- John 'Warthog9' Hawley
