From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unexpected behavior in git-rev-list
Date: Sun, 18 Sep 2005 10:18:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:19:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2ny-0000Tz-Dm
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVIRRSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVIRRSP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:18:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932122AbVIRRSP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:18:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IHIBBo005789
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 10:18:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IHIAl1022294;
	Sun, 18 Sep 2005 10:18:10 -0700
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8789>



On Sun, 18 Sep 2005, Peter Eriksen wrote:
> 
> There's something I don't quite understand about git-rev-list.
> After adding two files only one shows up with the --objects option.
>
> I can find the difference between the latest commit and it's parent:
> 
> > git diff HEAD^ HEAD
> diff --git a/HS-Plugins/20050403/Recipe b/HS-Plugins/20050403/Recipe
> new file mode 100644
> --- /dev/null
> +++ b/HS-Plugins/20050403/Recipe
> @@ -0,0 +1,16 @@
>  [snip]
> diff --git a/HS-Plugins/20050403/Resources/Dependencies
> b/HS-Plugins/20050403/Resources/Dependencies
> new file mode 100644
> --- /dev/null
> +++ b/HS-Plugins/20050403/Resources/Dependencies
> @@ -0,0 +1,5 @@
>  [snip] 
> 
> Notice that it creates exactly two files.  Now I expect the folllowing
> objects:
> 
> tree HS-Plugins
> tree 20050403
> blob Recipe
> tree Resources
> blob Dependencies

Well, it looks like some other file has _exactly_ the same contents as the 
new "Dependencies", which means that git notices that the blob isn't 
actually new.

Which doesn't surprise me at all - you've got a lot of projects there that 
seem to have a Dependencies thing. Why wouldn't some other project have 
the exact same ones?

		Linus
