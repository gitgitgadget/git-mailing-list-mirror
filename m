From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Sat, 12 Jul 2008 08:08:56 -0700 (PDT)
Message-ID: <m3zloncf7g.fsf@localhost.localdomain>
References: <4876B223.4070707@gmail.com> <200807111133.11662.jnareb@gmail.com>
	<4877691E.1010000@gmail.com> <20080711162752.GA5456@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHgjZ-00032O-Bs
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYGLPJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYGLPJB
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:09:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:31435 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYGLPI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:08:59 -0400
Received: by ug-out-1314.google.com with SMTP id h2so61602ugf.16
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Hktfip64LjP0lsXLICrlrr2kkIyQuTrG6CoFqJCg3xc=;
        b=i3H0JSfxxK9mOI/xo+Y0/e55ScdFfsDPvGcGJhoz+FT0PYpau46Obh68Gq3vvOU1rL
         3PvferErzlt+fVWGgQha1GyRlXogBNGYmDHjfYctKsQ3ESUSGmoRovXLkI9nBTMMJLdv
         uX/FdDAJLWWZkWrjL9gmR3D27uRUIM+2MFrTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=oqMWSK0g3RNm6pI6jELoHPUD4F3IGWwwxY2hMEVjRUbH+VvzNBkQPfJ4VDZZpiXkFZ
         fhzLg3l5t16LTkt8skSYMCChPZa6w6DuOfOAtnCL8KPCsFIIl/dl+lRf4jEhT1rYbnyc
         4D3ZWzQeNn0lEZdcLBCQpCbN7b1dlI2sn34lQ=
Received: by 10.67.116.16 with SMTP id t16mr355425ugm.62.1215875337960;
        Sat, 12 Jul 2008 08:08:57 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.204.111])
        by mx.google.com with ESMTPS id k2sm483203ugf.27.2008.07.12.08.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 08:08:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6CF8rKk021846;
	Sat, 12 Jul 2008 17:08:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6CF8pYa021843;
	Sat, 12 Jul 2008 17:08:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080711162752.GA5456@toroid.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88245>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-07-11 16:07:26 +0200, lewiemann@gmail.com wrote:
> >
> > > 'If-Not-Modified-Since', 'If-Match' (by caches)
> > 
> > Wait, are you sure caches would use those headers (I believe only the
> > latter actually exists BTW), or did you fall prey to a thinko? ;)
> 
> If-Not-Modified-Since should really be If-Unmodified-Since.
> 
> But where's the thinko? To send If-Modified-Since or similar with a
> request, you would need to have a cached copy of the resource and use
> its Last-Modified, for example. Sure, you could do it without one, but
> what would be the point?

Actually the thinko was use of If-Unmodified-Since: and If-Match:.

Both If-Unmodified-Since and If-Match can be used and should be used
when requesting *partial document transfers* (when you need to ensure
that document is unchanged before you fetch next part of it).  
Additionally If-Match can be used for concurrenty control when you
do a two-way communication using GET and PUT, in a PUT request to
ensure that you are modifying correct document.

They are not used, I think, by caches to refresh cached data.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
