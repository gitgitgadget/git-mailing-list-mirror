From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: git pull -s subtree doesn't work properly
Date: Thu, 31 Dec 2009 19:38:00 +0000
Message-ID: <20091231193800.GB19537@cs-wsok.swansea.ac.uk>
References: <20091105180905.GP17628@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 20:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQQqX-0003l3-T5
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 20:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbZLaTiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 14:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbZLaTiE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 14:38:04 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:49480 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZLaTiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 14:38:03 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1NQQqP-0002qv-0n; Thu, 31 Dec 2009 19:38:01 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id E5823B469;
	Thu, 31 Dec 2009 19:38:00 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id D174C74210; Thu, 31 Dec 2009 19:38:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20091105180905.GP17628@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135967>

Hello,

it seems no reply yet (if I understand that web-email-interface
properly); has nobody any idea here, or is it a Git bug,
or my fault?

To me it seems all pretty normal, so I would be glad to get
some reaction.

The situation didn't improve: It seems "subtree" is completely broken ---
it has no idea that the files to be pulled are to be placed in
a subtree. (The pull via "git pull -s subtree CSM41 master" actually
also manages to ignore the ignore-patterns; don't know how this
could happen.)

So shouldn't one use this option?
Or how can I restart?

I would also need in other situations the ability of Git to have one independent repository (say,
at Github), which is also included in some other bigger repository (where it is
not changed, only included) --- how to do so if the "subtree"-mechanism doesn't work?

Hope for some help.

Oliver



On Thu, Nov 05, 2009 at 06:09:05PM +0000, Oliver Kullmann wrote:
> Hello,
> 
> using
> 
> IntroductionJava> git remote add -f CSM41 /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
> IntroductionJava> git merge -s ours --no-commit CSM41/master
> IntroductionJava> git read-tree --prefix=Artikel/Skripte/IntroductionJava/CS_M41/ -u CSM41/master
> IntroductionJava> git commit -m "Einfuegen des CS-M41-Projektes als Verzeichnis CS_M41"
> 
> I have imported repository "CS-M41_Programs" into another repository. Later then
> I replaced in the config-file the old url /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
> by the new one
> 
> [remote "CSM41"]
> 	url = git://github.com/OKullmann/CS-M41-Programming-in-Java.git
> 	fetch = +refs/heads/*:refs/remotes/CSM41/*
> 
> But now
> 
> IntroductionJava> git pull -s subtree CSM41 master
> 
> doesn't work anymore: In the CSM41 repository just one file index.html was changed,
> and apparently the merge strategy recognises that the other files haven't
> been changed, while index.html is placed just as if the relative path would
> start from the root of the repository.
> 
> IntroductionJava> git pull -s subtree CSM41 master
> remote: Counting objects: 7, done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 4 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (4/4), done.
> >From git://github.com/OKullmann/CS-M41-Programming-in-Java
>  * branch            master     -> FETCH_HEAD
> CONFLICT (delete/modify): Artikel/LaTeX/SystemStile/Html/index.html deleted in HEAD a
> nd modified in 38b11a96fa009a5b2c24cfc94c0268ab9ca7ce39. Version 38b11a96fa009a5b2c24
> cfc94c0268ab9ca7ce39 of Artikel/LaTeX/SystemStile/Html/index.html left in tree.
> Automatic merge failed; fix conflicts and then commit the result.
> 
> IntroductionJava> git status
> # On branch master
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add <file>..." to mark resolution)
> #
> #       deleted by us:      ../../LaTeX/SystemStile/Html/index.html
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> The path of index.html is Artikel/Skripte/IntroductionJava/CS_M41/Html/index.html.
> Why git thinks that index.html should be placed into another directory Artikel/LaTeX/SystemStile/Html/
> I have no clue (this directory doesn't exist).
> 
> Is it possible to tell "git pull" where the subtree really is, or is that
> not really the cause of the problem?
> 
> Thanks for your consideration!
> 
> Oliver
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
