From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Rewriting git history during git-svn conversion
Date: Thu, 6 Mar 2014 13:09:00 -0600
Message-ID: <CAHd499D-o37K_XXOj=gWyC4hXYxqBJ4JtAhy-naNP_eU4oWnyA@mail.gmail.com>
References: <CAHd499DqoUEKeu4uM5w7Y6Tm-tE-oJMUdz4RxP9s6CpN=LS9Bg@mail.gmail.com>
	<CAEcj5uVOWzcCjrUO9NBuRvbPUaqigJyaOmG_8wCumznB+yTH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:09:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdfK-0003yU-8G
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbaCFTJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:09:04 -0500
Received: from mail-ve0-f169.google.com ([209.85.128.169]:44884 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbaCFTJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:09:01 -0500
Received: by mail-ve0-f169.google.com with SMTP id pa12so3188953veb.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RscaN4m8GENWHpCn9LjxKBMeCkqDhOYeB97EzNM+ok0=;
        b=TrIKXcchOrbuzkPe8LD0C6zo2r7EmNZ6r2EOmz+YtBeVOTK8mDHXzfMiLaLA4GBxr8
         ToNDW2gN0rGLTq8UtzwqezBdsxXHep9N4+9js3NRptBGXeVIYWswwJOfRFTM3sEtNQsV
         p/JIN0sIUD/gTB8NTst5UMokGnooAq7prQh8g2IYW3e6RWHHMGE9xqe4gOJwvxS59969
         7BiHisAOQ5IAuisFcQasM/8U47bpbmpJZyEQKMQ/tdoOVazkJDPTju/4yob6s0Qeya8H
         C0yfrLxWe3Cw0qaHmRRm+uL73MxZacO14ZrJnZCs/5pZCLLvIXF6FgbrNbDU/XNI7zFr
         yFiA==
X-Received: by 10.58.37.232 with SMTP id b8mr2565049vek.27.1394132940471; Thu,
 06 Mar 2014 11:09:00 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Thu, 6 Mar 2014 11:09:00 -0800 (PST)
In-Reply-To: <CAEcj5uVOWzcCjrUO9NBuRvbPUaqigJyaOmG_8wCumznB+yTH4Q@mail.gmail.com>
X-Google-Sender-Auth: PC0-6UzPF13Vn6tgM-2vwgdg2rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243534>

On Tue, Mar 4, 2014 at 4:56 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> On Mon, Mar 3, 2014 at 7:38 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>
>> Is it safe to do this while still using git svn fetch? Will it
>> properly continue to convert SVN commits on top of my rewritten
>> history? If not, what changes can I make after I run the commands
>> linked by the URL above so that git svn continues to work normally?
>>
>
> I think it's OK. git-svn doesn't continuously verify the integrity of
> history already converted, I believe.
>
> Just try it out, it worked fine in a little demo setup I made
> (although I used rebase -i instead of filter-branch):
>
> git svn clone .. #maybe clone a little test repository to speed up the testing
> git filter-branch ... #remove unwanted files
> git svn fetch #this should work
>
> On a related note, maybe you'll enjoy my git-svn demos & ideas here:
> http://www.tfnico.com/presentations/git-and-subversion


So I did try this out. I did a 'fitler-branch', and afterwards I am
unable to do a `git svn fetch`:

$ git svn fetch
fatal: Invalid revision range cf641cf687fc41b769f296af6e4345dd6a8a6d7d
rev-list --pretty=raw --reverse
cf641cf687fc41b769f296af6e4345dd6a8a6d7d..refs/remotes/svn/trunk --:
command returned error: 128

I have a TON of branches, so I need some small command or script that
is able to go through each branch and update the metadata to tell it
what the new (rewritten) HEAD commit on each branch is. I'm assuming
that's the problem (git svn data is referring to old SHA of each
remote tracking branch).

If there is more to it than this please let me know. Thanks so far for
everyone's help.
