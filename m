From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Easy way to empty working tree?
Date: Thu, 20 Jul 2006 19:48:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607201944460.29649@g5.osdl.org>
References: <761519800607201828m19684b2jc267411ef3b8b9e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 04:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3l4b-0002xn-Od
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 04:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWGUCs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 22:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWGUCs6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 22:48:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030444AbWGUCs6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 22:48:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6L2msnW006320
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Jul 2006 19:48:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6L2mroM020473;
	Thu, 20 Jul 2006 19:48:53 -0700
To: Robin Luckey <robinluckey@gmail.com>
In-Reply-To: <761519800607201828m19684b2jc267411ef3b8b9e2@mail.gmail.com>
X-Spam-Status: No, hits=-0.659 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24041>



On Thu, 20 Jul 2006, Robin Luckey wrote:
>
> I have some very large git repositories that serve mainly as archives,
> and it would be nice to clear out the working directories for the
> repositories I am not currently working with. I'm not trying to delete
> the files from the repository, I just want free up space in idle
> repositories.

Well, that actually sounds like you might want to just make them totally 
"bare" repositories, ie you can just do something like

	mv repo/.git repo.git
	rm -rf repo

and then "repo.git" is a valid bare repository.

However, if you actually want to just clear the checked-out files:

> After mothballing the repository with git-repack -a -d and git clean
> -d -x, is there a convenient one-liner to empty the files out the
> working directory?

Well, you can do

	git ls-files -z | xargs -0 rm -f --

or something, or indeed just do a "rm -rf *", since the only thing you 
actually would want to save is the ".git" directory.

		Linus
