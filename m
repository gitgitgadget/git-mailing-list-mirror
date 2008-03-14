From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-fetch question/bug
Date: Fri, 14 Mar 2008 11:57:20 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803141148250.19665@iabervon.org>
References: <5d46db230803132208r3f3f9e34q80bb9c03d65ab67c@mail.gmail.com> <7vbq5hub74.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <blix@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCIM-0006HC-KZ
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYCNP5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYCNP5b
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:57:31 -0400
Received: from iabervon.org ([66.92.72.58]:54687 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbYCNP5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:57:30 -0400
Received: (qmail 5183 invoked by uid 1000); 14 Mar 2008 15:57:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Mar 2008 15:57:20 -0000
In-Reply-To: <7vbq5hub74.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77248>

On Thu, 13 Mar 2008, Junio C Hamano wrote:

> "Govind Salinas" <blix@sophiasuchtig.com> writes:
> 
> > ... git-fetch when I discovered that it does not return
> > error when the
> > fetch fails due to it not being a ff...
> 
> I think this is a regression introduced when "git-fetch" was
> re-implemented in C.  git-fetch--tool's native-store subcommand seems to
> have signaled this as an error, and it is reasonable to expect an error
> exit from the command in this case.
> 
> Probably something like this?

Looks right to me, although we should probably note that this probably 
means that if pull does a fetch that fails for some ref that you're not 
merging, it won't do the merge, even though it obviously could. So I think 
fixing this would presently (unless fetch and pull communicate more) be a 
regression for people whose upstreams introduce a new non-ff branch that 
matches their non-force fetch pattern.

	-Daniel
*This .sig left intentionally blank*
