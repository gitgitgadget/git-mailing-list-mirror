From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: dmalloc and leaks in git
Date: Sat, 8 Dec 2007 16:02:37 -0500
Message-ID: <9e4733910712081302h64d9b062kad02c4f13818d59f@mail.gmail.com>
References: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com>
	 <Pine.LNX.4.64.0712082058280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 08 22:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J16pG-0007w0-0W
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 22:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXLHVCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXLHVCp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 16:02:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:30894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbXLHVCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 16:02:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2293207wah
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 13:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=umHLQ7eAwFFHySnoXbD7MRrERA8GSArF+cpvvOVKA7Q=;
        b=UOCRVPn8PAoYxP0fueZWFowEeWhIpze5nRDLehGKPjaeDvvbKNNxP6AYwPrtw5SFvKv+FX16krn27g+NjB8qScJFS8zt0/oHbPUAOPUWTGLJyaWDLDTHkuyWGdZj42m3k5pxv47HCc4c2sLb+okwgr6OguBML43cGFtSjYRXkJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeMgltDGB78wGMcxW1U0OAzR0GFJVh/7F3bodDZZeC7Mx+3fZVLLLEKQ/EO+Swpbimxt6bYZ41JkgWInfBhEz60uPaPGjk6rY4Rsl8P+MJiW7X2PFi8NMIIFTL9/Pp38Mq4rr8D1L+6qrYzIQ4Q/Cw7d7hBfSS+LpTjobpmnd14=
Received: by 10.115.75.1 with SMTP id c1mr2391407wal.1197147757767;
        Sat, 08 Dec 2007 13:02:37 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sat, 8 Dec 2007 13:02:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712082058280.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67570>

On 12/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 8 Dec 2007, Jon Smirl wrote:
>
> > It is very easy to use dmalloc with git. Follow the instructions here,
> > http://dmalloc.com/docs/latest/online/dmalloc_4.html
> >
> > But using dmalloc shows a pervasive problem, none of the git commands
> > are cleaning up after themselves. For example I ran a simple command,
> > git-status, and thousands of objects were not freed.
>
> Known problem.  Goes by the name of "libification" on this list.

I tried using dmalloc to find the leak in repack but it is impossible
to sort out the accidental leaks from the on-purpose ones. On exit
there were millions of unfreed objects coming from all over the place.

-- 
Jon Smirl
jonsmirl@gmail.com
