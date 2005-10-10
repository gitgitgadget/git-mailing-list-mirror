From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Mon, 10 Oct 2005 16:14:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510101603520.23242@iabervon.org>
References: <20051010105008.GB30202@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:12:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP3xv-0001wx-Ab
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVJJUJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJJUJj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:09:39 -0400
Received: from iabervon.org ([66.92.72.58]:46604 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751196AbVJJUJj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 16:09:39 -0400
Received: (qmail 31740 invoked by uid 1000); 10 Oct 2005 16:14:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2005 16:14:31 -0400
To: Elfyn McBratney <beu@gentoo.org>
In-Reply-To: <20051010105008.GB30202@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9917>

On Mon, 10 Oct 2005, Elfyn McBratney wrote:

> 	[C sources]
> 	static char *prog;
> 	..
> 	static inline void set_prog_name (char *argv0)
> 	{
> 		prog = strrchr(argv0, '/');
> 		if (prog)
> 			prog++;
> 		else
> 			prog = argv0;
> 	}
> 	..
> 	int main (int argc, char **argv)
> 	{
> 		set_prog_name(argv[0]);
> 		..
> 		if (!do_bar())
> 			die("%s: do_bar() failed", prog);
> 		..
> 	}

Just put set_prog_name() next to die(), and have die() write "prog: " at 
the beginning if set_prog_name() got called. Assuming it's useful at all 
to show the name of the program, it's not going to be less useful if the 
error is actually found in a library function called by the program.

	-Daniel
*This .sig left intentionally blank*
