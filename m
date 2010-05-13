From: Jeff King <peff@peff.net>
Subject: Re: how to push from  repository with two tracking branches
Date: Thu, 13 May 2010 07:57:48 -0400
Message-ID: <20100513115747.GC10963@coredump.intra.peff.net>
References: <hsgfjn$onv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 13:58:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCX39-0003K5-Q0
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817Ab0EML5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:57:52 -0400
Received: from peff.net ([208.65.91.99]:46876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494Ab0EML5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 07:57:51 -0400
Received: (qmail 17147 invoked by uid 107); 13 May 2010 11:57:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 13 May 2010 07:57:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 May 2010 07:57:48 -0400
Content-Disposition: inline
In-Reply-To: <hsgfjn$onv$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146994>

On Thu, May 13, 2010 at 11:09:11AM +0200, Gelonida wrote:

> I have a repository with two tracking branches ('master' and 'mybranch')
> 
> with only one tracking branch I can do
> git pull
> make_local_changes
> git commit -a
> git push
> 
> with two tracking branches I will be told off if the other branch has
> been updated meanwhile, so what I currently to do is:

How about "git push origin mybranch" to just push mybranch? You might
also want to look at "push.default" in "git help config".

> # 'pull and fastforward mybranch'
> git checkout mybranch
> git pull
> git checkout master
>
> [...]
>
> How can I do this more efficiently?
> after a pull to master (I just had to fast forward mybranch to
> remote/mybranch)
> Switching branches and pulling seems a little clumsy

Pull requires a working tree because a non-fast forward merge may need
to resolve conflicts. So yes, you could be more efficient if it is a
fast-forward (you would "git fetch", check to make sure it is a
fast-forward, and then write the fast-forwarded commit sha1 into the
ref), but in the worst case you may need to actually do the merge.

-Peff
