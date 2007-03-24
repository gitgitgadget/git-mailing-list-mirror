From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 12:44:21 +0000
Message-ID: <200703241244.23151.andyparkins@gmail.com>
References: <200703231022.00189.andyparkins@gmail.com> <20070324102652.GA15474@thunk.org> <7vodmikjol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 13:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV5eR-0000If-7H
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 13:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXCXMrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXCXMrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 08:47:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:26322 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXCXMrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 08:47:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1236688uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 05:47:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BcTN4x/YeBdmpnGSmIcNUw51WG+5oP3hMCyRQ3KgRhTYOfNuG+k32sBpJwmgKi50ITsUFa9DhJXeZo/HW3xZAQNUwmO5cQloZeCXgSlNfQi2qiUkUKmtA8eB5lqyOkReYhH8dJ15nJSMOSuXtcDDM6GdWuo1jZEawZLJPxDiC9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WPlSvBI3XQZkFLakoew5JXuxuXgkS5JaAKyWxYBNI29R0e9egGLgn2bVel0BiE2LnTT/WBGGtdk6iyC8T1mSNjLclGq0Qqs0Dw3yKhkBIGsPx1d5m67VJVKwxqpLMPvvHl+jcQdP51QSnvlzlXbOea/bgBDoWVwZnZDIYBtUcYI=
Received: by 10.67.19.17 with SMTP id w17mr8539486ugi.1174740433025;
        Sat, 24 Mar 2007 05:47:13 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm5695668ugf.2007.03.24.05.47.11;
        Sat, 24 Mar 2007 05:47:12 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vodmikjol.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42999>

On Saturday 2007, March 24, Junio C Hamano wrote:

> But the recent updates to the mail-hook are backward compatible
> only in the sense that as long as the user configures it, the
> new script can mimic old version's behaviour (in other words, it
> was not backward compatible at all).  I think forcing updates to
> the hooks automatically is worse.  I'd rather keep hooks private
> to repository owner's concern.

But the user is still perfectly fine to /copy/ the script into 
individual repositories; but for those who don't care and just 
want "the latest and greatest" from whatever git supplies a link to the 
sample hook seems like a good solution.  I'm certainly not suggesting 
updating the ones in people's repositories automatically; what I'm 
suggesting is this:

ln -s \
  /usr/doc/git/contrib/post-receive-email
  /var/lib/git/project.git/hooks/post-receive

Or perhaps have the template post-receive hook simply contain

 . /usr/doc/git/contrib/post-receive-email

With the above in place when a user upgrades git with their package 
manager, and they have enabled the default hook script (which simply 
calls the one stored in a known location), they get the upgrade without 
having to think.

> While I think it would be great to have a central clearinghouse
> for people to share and enjoy useful hook collections for
> various workflows and use cases, I do not necessarily think

I agree - filling the place with every hook script that turns up is 
obviously not sensible.  However, this is not a hook collection; nor 
are their "people", there is just me.  Shawn asked if I'd convert the 
existing update hook to post-receive, that's what I did.  Show me these 
other "hook collections" that are desparately trying to get this 
apparently coveted position...

> inside git.git project itself is the best place to do so.

Erm, where is the right place then?

I think that git should supply in git.git a default set that do 
typically wanted things (things like the perfect patch pre-commit hook, 
the no-unannotated-tags update hook, and of course the email sending 
hook) that can be enabled with a simple chmod a+x hooks/somescript.  
All I was doing was supplying a script to fill the post-receive slot.

That all sounds a lot more toys-out-of-pram than I intend; in the end, 
I'm only trying to fix the bugs that are in old update-hook.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
