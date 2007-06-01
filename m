From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 10:08:37 +0200
Message-ID: <200706011008.38063.Josef.Weidendorfer@gmx.de>
References: <1180385483418-git-send-email-hjemli@gmail.com> <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu2fg-00013d-3S
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 10:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbXFAIjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 04:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXFAIjh
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 04:39:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:60482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752698AbXFAIjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 04:39:36 -0400
Received: (qmail invoked by alias); 01 Jun 2007 08:39:34 -0000
Received: from c127.tum.vpn.lrz-muenchen.de (EHLO c127.tum.vpn.lrz-muenchen.de) [129.187.41.127]
  by mail.gmx.net (mp024) with SMTP; 01 Jun 2007 10:39:34 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX1//hjUcXZj/3hJNYvwGvWeSO0GVx2ExAingGjOpAj
	aFAJ2vPtK9UCS8
User-Agent: KMail/1.9.7
In-Reply-To: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48853>

On Thursday 31 May 2007, Lars Hjemli wrote:
> On 5/28/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > This changes git-submodule in a few ways:
> 
> Please don't apply the "Let .git/config specify the url for
> submodules" patch, I'm having second thoughts ;-)
> 
> Your design outline in
> http://article.gmane.org/gmane.comp.version-control.git/48287 is
> obviously superior, and I'd like to take a stab at it with something
> like this:
> 
> 1. 'git-submodule init' saves submodule name and suggested url from
> .gitmodules into .git/config (submodule.$name.url)
> 
> 2. 'git-submodule update' keeps the work tree updated for submodules
> with five separate (and optional) operations:
>   a) git-clone --bare $url .git/submodules/$name.git
>   b) git-clone -l -s .git/submodules/$name.git $path
>   c) cd .git/submodules/$name.git && git-fetch
>   d) cd $path && git-fetch
>   e) cd $path && git-checkout $sha1
> 
> 3) 'git-submodule push' runs something like 'cd $path && git push
> origin $branch', where $branch is found in .gitmodules
> (path.$path.branch).

So if you need superproject related corrections in the submodule,
you always have to do it on branch "path.$path.branch" in the
submodule to get it saved?

I would assume that pushing the current branch should be enough.
If you want to play with multiple different "corrections" on
different branches in the submodule, you do not want to force
the branch name to a unique one given in .gitmodules.

Josef
