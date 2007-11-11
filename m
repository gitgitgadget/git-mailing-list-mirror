From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 14:36:11 -0500
Message-ID: <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
	 <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com>
	 <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIbc-0007bs-UT
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbXKKTgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXKKTgN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:36:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:60489 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbXKKTgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:36:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1292131wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5rdMpO4Ei5a8icQEFYaLAguC5YFQOBygLINngFq4OQ0=;
        b=q5Dro1e0/6z66yK3AzMWk44uFbrCNv51jcQe93exRadsUGzv1dpU+GgcutMZiwgebTmEx2zvAVrz929fys/nspfvqVSnGkhZdvxqZkyIVw4/a6uXpc4THjDJnjYI/2Ou7Lk+JFxL5HNYxREB0qJmmJOnUToc6cWtaPrNXuZpdPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n1+MCegTaasRxsFbKKFj22S8zzghOhXHR0xmbTy63vQGMEIQox6y7Ulytn79HI9+yHzMbFmZkCC+XXyvUyb+D5pe4Kh+Qw1yX66BuM8r7PHbOOnWY0gRJCmUNm6BryCmAbYw9N0M5prxg9mUfiWnPQNwtREVk9s7U7x3xgA/UrE=
Received: by 10.114.59.1 with SMTP id h1mr93085waa.1194809771920;
        Sun, 11 Nov 2007 11:36:11 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 11 Nov 2007 11:36:11 -0800 (PST)
In-Reply-To: <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64496>

On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Nov 11, 2007, at 7:02 PM, Jon Smirl wrote:
>
> > Is the remote config not correct?
>
> This is the configuration for remote "dreamhost". In your
> previous mail you also mentioned a remote "linus". But
> this seems to be unrelated to your question.
>
>
> > [remote "dreamhost"]
> >         url = ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
> >         fetch = +refs/heads/*:refs/remotes/dreamhost/*
>
> correct. This fetches the branches from the remote and stores
> them locally as remote tracking branches "dreamhost/<branch>".
>
> >         push = +refs/heads/*:refs/remotes/linus/*
>
> This "renames" your branches when you push. Your local branches
> get pushed to "dreamhost" and are stored there as remote branches
> "linus/<branch>". From your previous mail I assume you like to store
> them as normal branches. You'd need to say

I did this part incorrectly. I was trying to push my local definition
of the linus remote to the dreamhost repo so that when someone clones
dreamhost linus would be defined in their repo.

jonsmirl@terra:~/mpc5200b$ git remote show linus
* remote linus
  URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

How do I push the definition of the linus remote repo?


>
>         push = +refs/heads/*:refs/heads/*
>
> But most likely you don't want to force here, that is drop '+'.
> And you don't need to explicitly say that you want to store a branch
> under the same name. So, probably you want
>
>         push = refs/heads/*
>
> But maybe you could even drop the push line completely. Then, only
> existing branches would be pushed and if you want to create a new
> remote branch on "dreamhost" you'd need to explicitly tell git with
>
>         git push dreamhost <new-branch>
>
> Does this help?
>
>         Steffen
>


-- 
Jon Smirl
jonsmirl@gmail.com
