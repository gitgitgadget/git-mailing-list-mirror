From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Embedded Linux development with GIT
Date: Thu, 5 Jul 2007 08:53:37 +0200
Message-ID: <81b0412b0707042353o437a88faycbead87f63998913@mail.gmail.com>
References: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sean Kelley" <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 08:53:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6LDk-0001qr-OH
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 08:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbXGEGxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 02:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbXGEGxk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 02:53:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:63837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbXGEGxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 02:53:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so423957ugf
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 23:53:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYWqSCre2Qz4OZ6xe3bBY+M4fnun96NOSdfmX4gKsZ2Ip+OS8EUZ+4Y5+jCQD0olDx4jxhEZAlHemi+PFa1X2pSFLtiZw+rjJtiR7xZHviPPDlMGHq9TZ7/iWgjcQcAi7/Xjv/9jxOB71JhPDtXoPz0kss7XIg29XkVnjCRTQCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzJ0AQWlSDcojv4yw7lBFybNHtOI+s3OQZq3Awl4POg/zh7y0U12K74PcXRYojsoXI2BngOOxJUXIoOIvsrxi+b+kznmWIIGF8WTM/mQc5X9iP8E2Z8nKUNH27a6L2sbGfOAHcEDUAkZeZtTWNGQIppTdwjYTlTi/gI+usxQy0I=
Received: by 10.78.185.15 with SMTP id i15mr4509056huf.1183618417279;
        Wed, 04 Jul 2007 23:53:37 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 23:53:37 -0700 (PDT)
In-Reply-To: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51660>

On 7/5/07, Sean Kelley <svk.sweng@gmail.com> wrote:
> 1) Clone kernel.org kernel and it is Master
> 2) Create a local Head based on 2.6.17 and call it Local
> 3) Pull my existing heavily patched repository into the Local branch and merge

Better:

  $ (cd $OLDREPO && git format-patch --stdout -k first..) | git am -k

or, if it is in the same repo, assuming it starts with sha1 "old-beginning"

  $ git format-patch --stdout -k old-beginning.. | git am -k

Merging of unrelated histories is slow (but works).

> Is it possible then to see our 400 odd commits then in the Local
> branch on top of 2.6.17 so that we can see not only our history but
> also the history that came before?  Then as Master advances we can see
> about backporting and bringing our code close enough to mainline
> kernel to actually be able to contribute back to the community and
> submit patches.  Is this realistic approach.

Yes. Look at how OLPC (www.laptop.org) does this with their kernel.

>  I am unsure of the GIT
> commands that I need to do this?

aside from the already mentioned git format-patch and git am:
git apply, git log, git show, gitk, and come to think of it - all of the
rest too, except maybe for importing programs.
