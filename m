From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Thu, 20 Oct 2005 17:15:26 +1300
Message-ID: <46a038f90510192115x21ed7e96l6d85ce233e66a5f2@mail.gmail.com>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
	 <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 06:17:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESRq8-0000hE-Gp
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbVJTEP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbVJTEP1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:15:27 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:41734 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751726AbVJTEP1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:15:27 -0400
Received: by qproxy.gmail.com with SMTP id v40so249106qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 21:15:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SAWalxz5GjmSE0Jbo3kdWbaYl8dsgqBNSnbOg+b4sSDxOlYfPiItsZN57apPOxXhh8Sul5kQq61VVDyY0m7fw6KLvw+MN4SVDhvGQEbw34et+ZztM6Q7bbNe0mWqFDC98+ejucmZ3+Cb0z2BGyugCnVcXxzjY61lH/KNEQpa7wk=
Received: by 10.64.242.2 with SMTP id p2mr1178757qbh;
        Wed, 19 Oct 2005 21:15:26 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 21:15:26 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10342>

On 10/20/05, Junio C Hamano <junkio@cox.net> wrote:
> You just reported this $tag needs quoting ;-).

I thought I had seen a post from you to Petr, mentioning that he had
just fixed it. I didn't see any fix when I updated, but I thought it
may have been due to mirroring issues. In any case, it obviously needs
quoting.

> > +             GIT_DIR=../.. [ "`git-cat-file -t $tagid 2>/dev/null`" = "commit" ] && continue
> > +             GIT_DIR=../.. git-cat-file commit `git-rev-parse $tag^{commit}  2>/dev/null` 2>&1 >> /dev/null && continue
>
> You are saying:
>         if "$tagid" is already commit then continue;
>         if "$tagid" dereferences to a commit and if you have it
>         then continue
>
> If that is the case, then this might be more efficient.
>
>         GIT_DIR=../.. git-rev-parse --verify "$tagid^0" >/dev/null 2>&1 && continue
>
> You can say ^{commit} instead of ^0 if you like that newer
> style, of course.

I tried, and failed to get it to work 100% so I reverted to the double
check you've seen. Must have been PEBKAC for now it works correctly --
possibly related to the unquoted tagnames.

Ok -- too many problems with that patch. Let's try it again...


martin
