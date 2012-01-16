From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: The shared Git repo used by git-new-workdir
Date: Mon, 16 Jan 2012 10:57:12 -0800
Message-ID: <CAE1pOi3JocCoDGAmpCYdGdJN4E1nz8O4_i0MtLhwhP_axmH-uw@mail.gmail.com>
References: <CAE1pOi3fBUBeNuhJqtJhxuMfz2G3iYOJy7U2HX6Nv4kqjcbnhw@mail.gmail.com>
	<4F1467C1.504@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:57:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmrk8-0005Zb-8S
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2APS5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:57:14 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35547 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252Ab2APS5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 13:57:13 -0500
Received: by yhnn56 with SMTP id n56so1309009yhn.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 10:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rnyEDQUaUxNDyPBkTt5FO3BrJ2R/wXipS8Am6/GvWiU=;
        b=CPFAbSKXq4CKqcoBGhFKawUlamjTt8P0rg940gTcxCFkk8E+Tdxw/1IAuPMyWqbHdw
         DeordrgtC2NVULbm7BfUmghHT001NzY3PfjETwzXKGl82EZe66cNwyhEmV6SvsGsJWJK
         ogWrvHJdC1etFzvHAeEK7KGffJABQkZYpanzQ=
Received: by 10.236.155.104 with SMTP id i68mr18246364yhk.37.1326740232724;
 Mon, 16 Jan 2012 10:57:12 -0800 (PST)
Received: by 10.236.50.44 with HTTP; Mon, 16 Jan 2012 10:57:12 -0800 (PST)
In-Reply-To: <4F1467C1.504@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188640>

On 16 January 2012 10:09, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> On 14.01.2012 21:59, Hilco Wijbenga wrote:
> Take a look at the rather simple script git-new-workdir (everything
> important happens in the last 20 lines). It just makes logical links to all
> files (mostly directories) under .git except three files that relate to the
> index (mainly the index file itself and HEAD)

Yes, I did that but I cannot figure out from that why I see lots of
files and such staged for commit on master when I almost never work on
master. I only use master to pull in upstream and to merge in one of
my branches and push. So unless I'm doing that, I would expect "git
status" to not output anything.

> That would suggest that normal git operations operating on files in those
> directories happen identical whether you are in the root repo or in any of
> the satellites. Only where the whole repo is acted upon (git clone, cp/rsync
> or deletion of the whole repo) the root repo would be "special".

That all makes sense to me and is what I was expecting. So why is "git
status" on master displaying anything?

Here is what I see:

In my working directory:
hilco@centaur /mnt/lacie/workspaces/my-project-master
my-project-master (master $ u=)$ git status
# On branch master
nothing to commit (working directory clean)

In the shared repo:
hilco@centaur ~/git-clones/my-project my-project (master +$ u=)$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    .gitattributes
#       modified:   .gitignore
#       new file:   ...
... hundreds more ...

Is this related to my use of a symlink? I have a symlink
"~/workspaces" pointing to /mnt/lacie/workspaces/. Is that somehow
affecting things?
