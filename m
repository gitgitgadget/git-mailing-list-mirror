From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 15:11:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806191510060.6439@racer>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9KtS-0007C4-RT
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYFSOMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbYFSOMr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:12:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:52301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753711AbYFSOMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:12:46 -0400
Received: (qmail invoked by alias); 19 Jun 2008 14:12:44 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp014) with SMTP; 19 Jun 2008 16:12:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188KhI86zU8pj4X4hvpeR5pn81D3nT1etuOL8PxwC
	bxZqzroiMgooY1
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806182327090.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85477>

Hi,

On Wed, 18 Jun 2008, Daniel Barkalow wrote:

> diff --git a/setup.c b/setup.c
> index d630e37..1643ee4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -292,7 +292,8 @@ void setup_work_tree(void)
>  	work_tree = get_git_work_tree();
>  	git_dir = get_git_dir();
>  	if (!is_absolute_path(git_dir))

I suspect it needs "work_tree &&" here.

> -		set_git_dir(make_absolute_path(git_dir));
> +		set_git_dir(make_relative_path(make_absolute_path(git_dir),
> +					       work_tree));
>  	if (!work_tree || chdir(work_tree))
>  		die("This operation must be run in a work tree");
>  	initialized = 1;

All in all I am pretty surprised how easy it was.  I tried yesterday, for 
half an hour, to come up with something sensible, and failed.

Thanks,
Dscho
