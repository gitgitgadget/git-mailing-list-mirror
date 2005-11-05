From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Added a few examples to git-pull man page.
Date: Sat, 5 Nov 2005 20:37:12 +0100
Message-ID: <200511052037.12410.Josef.Weidendorfer@gmx.de>
References: <E1EYDua-00017o-9d@jdl.com> <7vk6fno36c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 05 20:09:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYTOW-0006tb-OS
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 20:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVKETHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 14:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVKETHq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 14:07:46 -0500
Received: from pop.gmx.de ([213.165.64.20]:46297 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932295AbVKETHo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 14:07:44 -0500
Received: (qmail invoked by alias); 05 Nov 2005 19:07:42 -0000
Received: from p5496B502.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.181.2]
  by mail.gmx.net (mp037) with SMTP; 05 Nov 2005 20:07:42 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vk6fno36c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11179>

On Saturday 05 November 2005 10:27, Junio C Hamano wrote:
> Maybe something like this (I know my wording is quite bad and I
> would appreciate rephrasing it better very much) would be more
> explicit and appropriate?
> 
>     If you intend to do development derived from a remote
>     branch B, have a `Pull:` line to track it, like this:
> 
>         Pull: B:remote-B
> 
>     and have a separate branch my-B to do your development
>     on top of it.  The latter is created by 'git branch my-B
>     remote-B' (or its equivalent, 'git checkout -b my-B
>     remote-B'), and that is the branch you make your own
>     commits.  Run 'git fetch' to keep track of the progress
>     of the remote side, and when you see the tracked remote
>     branch has something new, merge it into your development
>     branch with 'git pull . remote-B', while you are on my-B
>     branch.

It would be good to explicitly mention that exactly this is
already setup for you after cloning: you are prepared to do
local development based on the remote "master", with
	- remote head "B" = remote head "master"
	- local head "remote-B" = local head "origin"
	- local head "my-B" = local head "master"

Hmm. I just looked up the manual page of "git-clone", but it
does not mention this. It also should say that all remote heads
are cloned to local heads with the same name, with one exception:
remote "master" matches local "origin".

This feels really inconsistent. Junio, I think your proposal of
tracking remote "B" with local "origin/B" is a lot better. It
allows to name a local development branch for any remote "B" by
the same local name "B".

We could make heads starting with "origin/" special: Never let
"git commit" update such a head, but give out a warning instead,
that this head should not be changed locally, as it is used for
tracking a remote head. This warning could suggest to do "git branch"
before committing.
This special handling (of "origin/") should not be hardcoded, but
configurable, perhaps in .git/remotes:

	URL: remote-URL
	Prefix: origin/

Josef
