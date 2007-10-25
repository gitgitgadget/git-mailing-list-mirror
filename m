From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svnimport
Date: Thu, 25 Oct 2007 18:20:29 -0400
Message-ID: <20071025222029.GA11677@dervierte>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com> <Pine.LNX.4.64.0710251132580.25221@racer.site> <31e679430710250408g679538e7ha9e1e75507c2aac5@mail.gmail.com> <Pine.LNX.4.64.0710251403160.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlB4K-0006aN-4P
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 00:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbXJYWUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXJYWUg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 18:20:36 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:8116 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbXJYWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 18:20:35 -0400
Received: by py-out-1112.google.com with SMTP id u77so1037686pyb
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=dKDpGOXM6pr2jrc7cNZvmVD6CRpzUbssdP2MYkAUHVE=;
        b=KixpRig0nLKS75hSXE9yE3ZEtP7bFQlKtkNN9DjetTTMHIqnZxq1r9ejs/d/lFElfpxsaqhka7y93X7ey6rIk3zc9cBL8kW4YuvR2thrJVT/+zA7rxDyXyS8DHlTQ4ixFpzpuz+LwmqE/kpHh8aDHcVQfmdOOCBut1LKNyg1Vo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nQxwignIeFft0yJQH0Jw4FNYLMx8cv7kl37mRd0MjhXCeLi07rlCysB1EwXM7hDW6vAqdQPtbCnnFiNyrZLLPdZFFWRjbwQ/FOGQzzKQnjkT8wduj8W8UQeOI9UyCVmvfA0aM3n2qUSiERQE8qu9sneAth3qJ8BsDXkjtXTTFnQ=
Received: by 10.65.212.3 with SMTP id o3mr4989710qbq.1193350833909;
        Thu, 25 Oct 2007 15:20:33 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 38sm2048152nzf.2007.10.25.15.20.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2007 15:20:32 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 29C80C1EA4F; Thu, 25 Oct 2007 18:20:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710251403160.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62380>

On Thu, Oct 25, 2007 at 02:04:29PM +0100, Johannes Schindelin wrote:
> FYI you'll have to do something like this:
> 
> 	git svn init svn://busybox.net/trunk/busybox
> 	git svn fetch
> 
> to merge with current busybox (although I updated before I pushed).

More than that, you'll want to:

    git svn init <foo>
    cp .git/refs/remotes/origin/master .git/refs/remotes/git-svn
    git svn fetch

If git-svn doesn't find a remote named "git-svn" it will assume that it
has no information about the repository and starting doing a full
checkout.  By copying the ref, git-svn will see that there are already
commits with git-svn-id lines and rebuild its "rev-db".  After that, it
will incrementally update for newer revisions.

That ought to save you a few precious minutes :)
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
