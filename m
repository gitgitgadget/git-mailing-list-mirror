From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 08:56:31 +0000
Message-ID: <200703020856.35246.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <7vejo8o69o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6Rr-0007oI-9d
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbXCBMBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933348AbXCBMBD
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:01:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:53007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933340AbXCBMBB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:01:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1257595nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 04:00:59 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sDvjeZpfLqQWZw0lAaZH+CUbT0K5TnhfOqYz/crQ9y38QdWIH/nl0PdpILSTiY98uW7AIE1AGF9RSroEv+2gPi7dvRvrNNuHf7+QMylLG0JtKf39sQYIxODbDkhZvUPYH3bmcGpOP+17yAd++sLTFzE9efw+w7/znMzP5Ma6OU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nnKKPsMco7AgFK0JsrFxd4X0FrF9P3zq5eGSqi5nlE67UQQTlYjenWMDyiGQkju9UOZELvnECpWDl6wlas4wmncZvvlGhX8SnOsXgbh4+CRmS/m68CoMyubpbtz50XIULsA26W0kjGBVEqZo4nhYPx+iZFoq+CxHp9OhHMLbLzU=
Received: by 10.48.204.7 with SMTP id b7mr7573970nfg.1172836859699;
        Fri, 02 Mar 2007 04:00:59 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm6241526ika.2007.03.02.04.00.55;
        Fri, 02 Mar 2007 04:00:56 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vejo8o69o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41196>

On Friday 2007 March 02 00:09, Junio C Hamano wrote:

[deleted lots of easily-agreed-with stuff]

> I would suggest making handler section _match_ the attribute
> names.  By "match", what I mean is to allow something like this:

I don't see that working.  If it were possible to do that why would we need 
separate handlers and attributes?  You're example is fine

> 	[handler "image/*"]
>         	pretty = "cmd display -"

But what about when I want to do this:

[handler "lossless-images-only"]
   attribute = "image/png"
   attribute = "image/gif"
   pre-commit = /bin/false

To prevent the adding of all lossless image formats?  I actually can't see a 
time when the handler name needs referencing, so it can be anything (as long 
as it's unique - perhaps).  If you wanted to use/encourage the attribute 
name - fine, but it shouldn't be required.  However I think it's more 
sensible to name the handler after what it does than what it applies to - the 
applies to can change, what it does never.

The handlers are like function calls.  You wouldn't want to name functions 
after where they were called.

> > +[handler "show-images"]
> > +  attribute = image/gif
> > +  prettyfilter = pipe display -
>
> I would recommend against calling them *filter.  After all, the
> semantics of each handler action (such as input, output and
> pretty) already determine if it needs to act as a filter or data
> sink.  We do not need to say prettyfilter either; it is not even
> a filter to begin with -- it is a data sink.

That's true; I don't have any strong feelings.  I just didn't like "convert" 
being used.  Convert always sounds like something that takes one thing and 
makes another out of it - at the end you have two things.  Filters transform 
one thing into another - at the end you have one thing.

Perhaps better names would be simply to name them after the operation the runs 
them.

 infilter = checkin
 outfilter = checkout
 prettyfilter = show

?

Is the document useful; would you like me to maintain it?  I don't want to 
waste your time with it.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
