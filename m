From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 15:35:16 -0500
Message-ID: <8CAB85E5-A98E-4A25-9CC2-3E59106E655C@silverinsanity.com>
References: <200703011206.47213.andyparkins@gmail.com> <200703021200.35069.andyparkins@gmail.com> <E246B7BC-9C82-4F4E-93F0-60B3F1CA54F1@silverinsanity.com> <200703021935.58992.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 21:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNETO-0004fj-GC
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 21:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965583AbXCBUfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbXCBUfW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 15:35:22 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:54936 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965583AbXCBUfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 15:35:20 -0500
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B3A511FFC142;
	Fri,  2 Mar 2007 20:35:18 +0000 (UTC)
In-Reply-To: <200703021935.58992.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41243>


On Mar 2, 2007, at 2:35 PM, Andy Parkins wrote:

>> .git/config:
>> [attribute "image"]
>>     show = ...
>>     merge = ...
>>
>> With the ability to have additional "path =" entries for *local*
>> overrides/additions.  Storing the handler information in
>
> That's almost exactly it; but it makes the assumption that each
> attribute will have one unique handler.  Separating them means that
> multiple attributes can use one handler (or set of handlers).

That's why I suggested keeping the handler section, but not tying  
handlers to attributes in the attribute section.  I think it follows  
the principle of least surprise to be able to do as I demonstrated  
above, but allow reuse as I described originally (handler option in  
the attribute section).  My major concern is how do you tell what  
order handlers are run in for a given file if the handlers specify  
the attributes rather than the other way around?  And why make the  
user do things like:

[handler "text"]
    attribute=text
    ...

Instead of:

[attribute "text"]
    ...

(The handler section could be called "mangle", "blah", or "why-do-I- 
have-to-name-this", and the point would be the same.)  If you want to  
run the same handlers/filters/whatever for multiple types, create a  
handler section and reference it from all of those types or give all  
the files a new attribute that explains why you'd want to handle them  
identically and put the options on that attribute instead.

The attribute is the important thing here, not the handlers, so they  
should be primary, not secondary.  And that's my major point that I'm  
trying to get around to I guess.  I don't care about naming handler  
sections, searching through the file to find their order, or anything  
other than *what git is doing to my files*.  The files (content,  
actually) are king.

~~ Brian
