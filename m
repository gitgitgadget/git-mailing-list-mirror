From: "Nicolas Vilz 'niv'" <niv@iaglans.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch 
     directly
Date: Mon, 27 Feb 2006 20:34:27 +0100 (CET)
Message-ID: <62354.84.163.87.135.1141068867.squirrel@mail.geht-ab-wie-schnitzel.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
    <20060227184641.GA21684@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 20:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDo8i-0005LO-1y
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 20:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWB0Tec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 14:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWB0Tec
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 14:34:32 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:7688 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751751AbWB0Teb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 14:34:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A1ABD3FA9
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 20:34:29 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23979-09 for <git@vger.kernel.org>;
	Mon, 27 Feb 2006 20:34:28 +0100 (CET)
Received: from mail.geht-ab-wie-schnitzel.de (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 8DB7E3F7F
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 20:34:27 +0100 (CET)
Received: from 84.163.87.135
        (SquirrelMail authenticated user niv@geht-ab-wie-schnitzel.de)
        by mail.geht-ab-wie-schnitzel.de with HTTP;
        Mon, 27 Feb 2006 20:34:27 +0100 (CET)
In-Reply-To: <20060227184641.GA21684@hand.yhbt.net>
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16879>

> Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
>> hi everyone,
>>
>> as i mentioned, i do experimental work with git and svn... and i
>> experienced some problems with git when pulling much data from svn.
>>
>> Actually that happens after i commit a revision with many and big files.
>> After that i cannot do a git-svn fetch anymore because git-svn
>> complains...
>>
>> fatal: Ref refs/heads/svn-git-HEAD is at
>> 504721bf4b2702d3e56cef69950f42a43568e846 but expected
>> 504721bf4b2702d3e56cef69950f42a43568e846
>
> Those messages are from git-update-ref.  What were some of the messages
> from git-svn leading up to that point?
>
>> now i am a little confused about that... oh, i actually modified the
>> svn-git directly instead of a private working branch... perhaps that was
>> not intended.
>
> You should never, ever modify the git-svn-HEAD branch yourself.
> Interface branches should never be modified.  It's the golden rule of
> interfacing between different SCM interfaces.  Sorry, I've been doing
> things like this this for a while now I guess I didn't make it
> abundantly clear in the documentation.

ok, i experienced that on little modifications on the git-svn-HEAD branch
either... so its really about modifying and not about the huge data
ammount...


>> now i am still on rev 2 on this branch but i updated it to rev 5 on the
>> svn-side...
>>
>> any hints?
>
> Save your current work in git-svn-HEAD to a private branch
>
> 	git branch -b private git-svn-HEAD
>
> then reset git-svn-HEAD to the last revision where it was managed by
> git-svn fetch:
>
> 	git-checkout git-svn-HEAD
> 	git-log (look for the last commit with 'git-svn-id:' in it)
> 	git-reset --hard <last commit with 'git-svn-id:' in it>
>
> Now go to your private branch:
>
> 	git checkout private
>
> And continue working on your private branch as usual.

I will keep that in mind for the future. Fortunatelly i am still testing
and i saved the git repository before experimenting with git-svn.

Have you any suggestions howto migrate a git-repository to svn and then
work with git-svn on both of it? I tried cg-merge -j to merge my git
branch with the private git svn branch, i am allowed to modify safely.

that does work actually... now i can start getting this automated.

perhaps i will write a patch with that automated script, when it is
finished, just to contribute git.


Sincerly
Nicolas
