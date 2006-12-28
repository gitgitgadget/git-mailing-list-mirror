From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Fri, 29 Dec 2006 09:45:07 +1300
Message-ID: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 28 21:45:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H027l-0002p5-MQ
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 21:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbWL1UpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 15:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbWL1UpJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 15:45:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:7453 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbWL1UpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 15:45:08 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4683979wxd
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:45:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ShuFz2KnsUuIqmNzibzTzxyaKOytvqpJTUpBL6Q10BDAagBTGWyl389i5cr+OD1xec+wxAlO9CRUKCc8or0C4fxNc38j5Nn3VSherycYij1MpMgx+bi320pOaSBchppyHKWTBOyccjl7iPoWXVHuXEle+w9Zbz0UBqWSFUC2a0g=
Received: by 10.90.115.4 with SMTP id n4mr12207733agc.1167338707474;
        Thu, 28 Dec 2006 12:45:07 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Thu, 28 Dec 2006 12:45:07 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35560>

On 12/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Actually, just looking at the examples, it looks like memcached is
> fundamentally flawed, exactly the same way Apache mod_cache is
> fundamentally flawed.

memcached is really fast internally, but can be rather slow from the
POV of the client code, as it forces a costly
marshalling/unmarshalling of data. For perl-only situations where it
is OK to have per-server caches, I have been looking at
Cache::FastMmap. I will probably try to implement caching for the
projects, summary & log/shortlog pages using Cache::FastMap

And I'll do read-for-fill for it, and see how that goes.

(BTW, in the last week I've had to implement a similar
anti-thundering-herds cache in PHP using memcached and/or eaccelerator
-- a shmem cache -- and I've done a read-for-fill for both of them
that works reasonably well.)

cheers,


martin
