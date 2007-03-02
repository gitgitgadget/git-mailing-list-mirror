From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 13:05:06 -0500
Message-ID: <E246B7BC-9C82-4F4E-93F0-60B3F1CA54F1@silverinsanity.com>
References: <200703011206.47213.andyparkins@gmail.com> <CF579EA9-04AB-4B39-809F-650E611A8D6B@silverinsanity.com> <200703021200.35069.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNC86-0008I6-B6
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 19:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992687AbXCBSFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992689AbXCBSFM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 13:05:12 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:37358 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992687AbXCBSFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 13:05:10 -0500
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 7D5441FFC02B;
	Fri,  2 Mar 2007 18:05:09 +0000 (UTC)
In-Reply-To: <200703021200.35069.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41231>


On Mar 2, 2007, at 7:00 AM, Andy Parkins wrote:

> On Thursday 2007, March 01, Brian Gernhardt wrote:
>
>> [attribute "image/png"]
>>     path = *.png
>>     show = "open %path%"
>> [attribute "text/plain"]
>>     path = *.c
>>     checkout = eol_to_local
>
> The problem is that this flips the relationship.  What you want to  
> do is
> assign attributes to paths.  This is assigning paths to attributes.
> What about this:
>
>   doc/*.txt = text/plain AND documentation
>
> In your system that would make

I'm sorry, I was assuming that information on what to do with each  
attribute would be in the config file while a majority of the  
attribute information was in an in-tree file.  I was actually assuming:

.gitattributes:
*.png: image/png
logo.png: logo
*.c: text/plain source

.git/config:
[attribute "image"]
    show = ...
    merge = ...

With the ability to have additional "path =" entries for *local*  
overrides/additions.  Storing the handler information in  
the .gitattributes is one of the worst things you could do, IMHO.  It  
assumes that people will have a homogenous environment to develop in,  
and that every developer want to use the same tools.  In some cases,  
this may be true (eol_lf on checking for everybody), but not in  
others.  On my Mac, I'd like to use "open" for random file types, and  
might want to use VERY different graphical merge than Linux users.   
And OS X is a fairly Unix-like environment.  Let's not even ponder  
those poor fools using MinGW.  ;-)

>> Actually, shouldn't the files also be run through the infilter to
>> check for changes caused by that, too?
>
> I don't think so.  The effect of the infilter will never be seen in  
> the
> working tree, because it's applied on git-add.  The previous  
> content with the
> old attributes are already in the repository.  However, it could be  
> that we
> would have to force those files to be marked dirty in the index  
> (this is
> already sounding bad), to force the application of the infilter on  
> next
> checkin.  Perhaps that's what you meant, and I'm being slow.

That's something like what I meant.  And it sounds bad.  Content  
changes caused by attribute changes should likely be handled by the  
user and made easy to detect instead of trying to handle it  
automatically.  So ignore my original statement on the matter.

~~ Brian
