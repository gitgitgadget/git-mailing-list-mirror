From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Use "git pull --ff-only" by default?
Date: Mon, 24 May 2010 16:56:37 +0400
Message-ID: <20100524125637.GE3005@dpotapov.dyndns.org>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
 <4BF6A445.1030105@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234FAA@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Mon May 24 14:57:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGXDO-0005b8-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 14:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0EXM4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 08:56:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:58779 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0EXM4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 08:56:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1852815fga.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kByyrxRSGqdQBAI51gi/jEs9e+zZPO/CHA8F4/9HT+0=;
        b=YhaBPkW5g0ZTwxVFQY5N+nKJZJFyTRYl6UWJFe103WAU+xtUxz3ls+WelcmvEJohKN
         qj7KNwYbb3Ls2abkwihKuFKgWB7F6zXYf90MbLMykEmeDnXOknwhFfpNKFN8f8WIyMmy
         VfHcymt9nZEhQxNswTD02MTEjKvgY0FMbNhWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gbWi/rOgiGVSRjbLFvYaWdNSiDtMKdMhocy5+tTOIgTpx0lvuySnHA6SP6xkJkdOcE
         C3SP5sYFGTUcq88uC9n1kZG0XAAyrDMuZnd3sSwq8mIXBJ6XkruU8kVJAib+Z8r6n+pL
         KAPf91kfYxEH4fb6qRpHuSAWaA1p9NjUtIRCw=
Received: by 10.87.50.6 with SMTP id c6mr8251833fgk.41.1274705801410;
        Mon, 24 May 2010 05:56:41 -0700 (PDT)
Received: from localhost (ppp85-140-126-0.pppoe.mtu-net.ru [85.140.126.0])
        by mx.google.com with ESMTPS id e3sm6947409fga.19.2010.05.24.05.56.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 05:56:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234FAA@xmail3.se.axis.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147631>

On Mon, May 24, 2010 at 10:22:45AM +0200, Peter Kjellerstedt wrote:
> 
> I forgot to mention that I had tried that. It does not work as git 
> explicitly does not allow one to use a git command name as an alias 
> name. And I think this is a good policy since it prevents people 
> from aliasing plumbing commands to do weird things. However, I would
> like to see some way to affect the defaults of porcelain commands.

Though, some porcelain commands (such as "branch") should never be used
in scripts, many others do not have low-level analogue, so they are
commonly used in scripts.

> 
> > I think this boils down to having a few people who are allowed to push
> > merges because they can make these decisions. Even if people don't
> > merge "origin" but their own branches they can create a mess, so you 
> > cannot differentiate based on that.
> 
> In a larger organization this does not work. Most of our developers
> are responsible for at least one subsystem and expected to be the one 
> responsible for its master branch.

Right. Now, if only one person who is responsible for this subsystem is
expected to be able to push changes to the master branch then this
person will never need "git pull --ff-only". In fact, when he pulls
changes from others, he needs a real merge. So, this alone a very strong
argument against making ff-only by default in any configuration.

And if you think that "pull --ff-only" is very useful for some reason,
nobody prevents to add an alias for that command, but this command
should never be called as "pull", because "pull" has always been about
merging changes, and if it does something different, you should call it
differently. Why don't call it as "fast-forward" or "ff" for short?


Dmitry
