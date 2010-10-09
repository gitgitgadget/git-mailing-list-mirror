From: Kevin Ballard <kevin@sb.org>
Subject: Re: Best single user practice
Date: Sat, 9 Oct 2010 15:44:48 -0700
Message-ID: <DAA5096E-00DF-4454-A905-EA2E10329DBB@sb.org>
References: <loom.20101009T233356-82@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4iA4-0002Ui-Eo
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab0JIWow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:44:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59163 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0JIWov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 18:44:51 -0400
Received: by pwj4 with SMTP id 4so527098pwj.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:44:50 -0700 (PDT)
Received: by 10.115.58.4 with SMTP id l4mr4873353wak.161.1286664290854;
        Sat, 09 Oct 2010 15:44:50 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id f20sm5999189waj.20.2010.10.09.15.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 15:44:50 -0700 (PDT)
In-Reply-To: <loom.20101009T233356-82@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158636>

On Oct 9, 2010, at 3:24 PM, Maaartin wrote:

> I've started using git maybe one month ago, and I'd like to use it for many 
> things including some one-man projects, browser settings backups, and such 
> things. So I always do a local git init, ssh to my server and create a repo 
> there. I copy the .git/config from a working project, and change the remote 
> URL. It all works, but it's not perfect.

Why do you copy .git/config? Anything that you want to share in all projects should just be put into ~/.gitconfig (this can also be done with `git config --global`). Anything that's put into .git/config should be specific to that particular project.

> - Is it not possible to create a remote repository from my own computer without 
> ssh?

If you use a web interface on the server to manage git repos (e.g. Gitorious) you can generally create repos via the web interface.

> - There's only version 1.5.4.3 on the server and I don't want to update it 
> unless strongly recommended so. Should I?

1.5.4.3 is roughly 2 years and 8 months old. I would strongly recommend you update.

> - Because of the low version, I can't use "git init --bare" on the server. So I 
> create an usual depository and change the configuration to bare=true. Is it OK 
> (I really don't mind the repo being placed in DIR/.git instead of DIR itself.)?

`git init --bare` is incorrect anyway. What you really want is `git --bare init`.

> - The very first time I need to do "git push origin master", later "git push" 
> suffices. I wonder why.

The very first time, it's creating the master branch on the remote. Subsequent invocations of `git push` will detect the presence of the remote master and push to that. The default mode for `git push` is to push all matching branches (e.g. branches that exist on both the local and remote sides).

> - My local repository created by "git init" (version 1.7.2.3 under cygwin) 
> contains
> [core]
> repositoryformatversion = 0
> filemode = true
> bare = false
> logallrefupdates = true
> ignorecase = true
> but I'd prefer to specify there as little as possible, since the settings for 
> all my repositories should be the same (at least for the moment). What can be 
> safely removed?

Why does it matter? These are created by the call to `git init`. There's really no reason to try and remove items from .git/config unless you definitively don't want them. And as I said before, any settings you want in common between your repos should be placed into ~/.gitconfig

> - How can I ensure that everything important gets pushed to the server? Maybe 
> by using "git push --mirror"? Obviously and logically, .git/config doesn't get 
> pushed, but maybe I miss something more important, too?

What do you consider important besides your branches?

-Kevin Ballard