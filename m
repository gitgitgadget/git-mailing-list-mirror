From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Locking binary files
Date: Wed, 24 Sep 2008 03:21:54 +0400
Message-ID: <20080923232154.GW21650@dpotapov.dyndns.org>
References: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se> <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com> <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809231551320.19665@iabervon.org> <20080923215422.GV21650@dpotapov.dyndns.org> <alpine.LNX.1.00.0809231811560.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mario Pareja <mpareja.dev@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 01:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiHDv-0004YU-Qi
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 01:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbYIWXWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 19:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYIWXWE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 19:22:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:23173 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYIWXWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 19:22:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1885247fgg.17
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s9BO7qdp289Fq0HSnqo57GGa4GHANx7vEHa7ohb+ICE=;
        b=jNXG3h2798AwKfqT8F4FtN7y0QSe4QwyT+xhW9xtdWMJg/mwXCbUHzc+sIXusg6KmH
         bX3QTUoX4fVVoT57F2ZsVuZRGDvrn0KdOTS0NjZ/6DhKIhG2E2xHP+u15CfkzZdgVr2n
         wVPe26HJA3dq2PK2T5Ke0hLUD/uFz1wfpjq58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bKhkRiXUiUX4mFs4pqulMy+CKeM+63N2FmIp/gwRI6TVNMKEC4TXzZMtPE0SRqONJ7
         Nu2r/lSOW6/cPcqDMyKBFXcxVIWWlYYEajq8Xri92ybixbFr/EQkM9bKs48uF3zm3+6/
         8THeXmVyeD1POdWv6gNzCzF1aJJD66lAx83sc=
Received: by 10.86.74.4 with SMTP id w4mr1990578fga.25.1222212119031;
        Tue, 23 Sep 2008 16:21:59 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id l19sm8443260fgb.7.2008.09.23.16.21.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 16:21:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809231811560.19665@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96611>

On Tue, Sep 23, 2008 at 06:29:53PM -0400, Daniel Barkalow wrote:
> On Wed, 24 Sep 2008, Dmitry Potapov wrote:
> 
> > It still will happen if developers work on topic branches, and it is not
> > a rate situation with Git. Thus locking some particular path is stupid.
> > What you may want instead is too mark SHA-1 of this file as being edited
> > and later maybe as being replaced with another one. In this case, anyone
> > who has the access to the central information storage will get warning
> > about attempt to edit a file that is edited or already replaced with a
> > new version.
> 
> No, your goal is to avoid having to do a merge in order to do a particular 
> push. That push is the push to the shared location. It doesn't matter if 
> you use topic branches, because your eventual goal is still to push to the 
> shared location (or, possibly, to have the project maintainer push to the 
> shared location with some sort of interesting delegation), so you lock the 
> shared location, not your topic branch.

What are you saying is that when I am locking some file on the current
branch, Git (or whatever script that performs this locking) should figure
out what is the original shared branch for it and lock the file there.
When you have finished to edit and push changes then the lock should be
removed if changes are pushed to this shared branch, otherwise it should
be some token of delegation to the project maintainer who is going to
push (or probably first merge, because other files may need that) to
this branch.

Maybe, it can work, but it sounds too complex to me. I believe that my
idea using SHA-1 is better. After all, what is file? It is its content.
At least, in Git, we always identify files by their content. Thus if you
lock some file, you put a lock on certain SHA-1. Now, regardless of
branches and paths, this lock can work provided that you have access to
some shared location. Of course, this lock is purely advisory, but it is
good, because you may want to ignore it in some case. For instance, you
want to created a new branch based on the current shared location and
have no plan to ever merge it back. In this case, the lock on the shared
branch should not matter to you. This is true regardless how you
implement locking, and in your scheme it will another special case.


Dmitry
