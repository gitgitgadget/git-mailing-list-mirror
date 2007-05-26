From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Sat, 26 May 2007 10:12:48 +0100
Message-ID: <200705261012.50530.andyparkins@gmail.com>
References: <200705251150.09439.andyparkins@gmail.com> <7vlkfcm2eu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrsL9-0004E3-Fj
	for gcvg-git@gmane.org; Sat, 26 May 2007 11:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbXEZJN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 05:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXEZJN0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 05:13:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59254 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbXEZJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 05:13:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1287054ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 02:13:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tnvVGr9LUvqAlHPmXJCWvTblPFzYblDvR8U+sESN2zt12y6SRTKhVpCmUdyRAU2CFuMq7q8p2aSdMI7Ks6sDpzvBWUKW9aKj7zwtoxoOSmJ4933t+QMDghCGUntBp3G83uCYFZRoFb2tnOmZRmp7u5RxI2keoQacIgRtPmVYEYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s3jLh1QLZ1ZC+/L/+pjU2DAoojBu0QAK+QpKlFkFnR+2eSSElPdxM+UloJKkw0Vit6MBmzHPnL3JmzmeArCRArjuXjC2NWi9hNyncAJSeQjYxOM/5yVNig6Y48SJuKXWCDP6DdM9Ajd+k6t00ivGiEV+Z+Y5TnSsicZ31V5jMnA=
Received: by 10.66.240.12 with SMTP id n12mr3566123ugh.1180170804637;
        Sat, 26 May 2007 02:13:24 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 27sm8368198ugp.2007.05.26.02.13.19;
        Sat, 26 May 2007 02:13:20 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vlkfcm2eu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48463>

On Saturday 2007, May 26, Junio C Hamano wrote:

> >  	for (dst = buf; size; size--) {
> >  		const char *cp;
> > +		/* Fetch next source character, move the pointer on */
> >  		char ch = *src++;
> > +		/* Copy the current character to the destination */
> >  		*dst++ = ch;
>
> These are too much.

Absolutely.  I always find when bug hunting though that I like to 
comment every block, sometimes to excess, as reminder that I've 
understood what its doing.

I should have done the final pass once I'd found it to clear up the 
overkill ones :-)

> But this is very good, if you fix it to read the current 3 are
> "$Id" ;-).

"and in the ability to count competition, Andy comes second... let's 
have a big hand for our runner up" :-)

> Thanks for the fix.  It would be very nice for the patch to be
> accompanied with a new test to expose the bug and demonstrate
> that the patch fixes it.

I had to jump through quite a few hoops to get the expanded $Id$ into a 
repository (originally it was because I used an older version of git in 
one place, and a newer one in another).

I'll see what I can do to make a test case though.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
