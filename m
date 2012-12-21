From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Noob Question
Date: Fri, 21 Dec 2012 12:43:04 +1100
Message-ID: <CAH5451kq8XwPTez0Jhst+rVCo=EteW7OMH4wr2a1rCXTW_f0jQ@mail.gmail.com>
References: <50D3B669.1030204@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: awingnut <wtriker.ffe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 02:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlreM-0001lj-G4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 02:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab2LUBn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 20:43:28 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53332 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2LUBnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 20:43:25 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so2285485qcp.12
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 17:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MhwLae1z1c9zaGKqTwirqAP+Gsp1PdZydybCpmjFdSA=;
        b=YTafxSSlGOyY2dqXjDqQDQHR1Zm9y84R/zxyHJ1nGgchlv5nuqJX7zikgjOYQOTUD2
         LzRuNPK/78t96F8LtnUR/i009mAoZmrHEJCIaeq4KO22KuMbPHNX5dVNSQTudGxb6YMm
         ZX4ykPy0YXXTj/x4TbiCOek7UTh3xnMUa+ooZmx8+/3ysHp8CnHIBLql2q3/kI1UljZ0
         xUC8rwljPWwS1GoO/7bpTc5sFamQQML5CjFZrLSPkmQ773pMOupZLpi7FoCTa3ng4Qfm
         zcLpEfN+4a1N8aCix/OUA39MfHzBtNpvdeYvYod2mSn6I4OOMpTobqDZFG3lJ28hw5XQ
         hFUg==
Received: by 10.49.74.73 with SMTP id r9mr6582876qev.44.1356054204806; Thu, 20
 Dec 2012 17:43:24 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Thu, 20 Dec 2012 17:43:04 -0800 (PST)
In-Reply-To: <50D3B669.1030204@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211940>

Hi!

On 21 December 2012 12:07, awingnut <wtriker.ffe@gmail.com> wrote:
> My main questions center around the git repository and accessing it.

The main thing you need to know is that you can work on your code base
in the *exact* same way while using git. You don't *have* to change
anything about how you work, as git's primary purpose is to store
snapshots of your work so that you have a history of what has changed.

That being said, you can (and maybe should) change how you work to
take into account the power of git. Most of what you do will stay the
same, however.

> 1) Should I install git on Linux or Windows or does it matter?

Install git wherever you need to access the code. From the sounds of
it you will want git on both machines, as you are working on windows
and but keeping the code on the linux shared drive. When working on
the windows machine you will use a windows copy of git to manipulate
the workspace, though I'm not sure if there are any gotchas with the
interaction with a linux shared drive.

If you want to manipulate the repository from the linux machine you
will need git on it as well.

Unless you're using a git server, manipulating the repository is a
local action and so is performed by the client. That is, when working
on windows use the windows client, if you also work on the linux
machine then you will need a client there as well.

> 2) How will my build scripts access the source? Will it be the same as
> now (my scripts 'cd' to the Eclipse project directory and run there) or
> do I need to add a wrapper to my script to check out the entire source
> for the builds?

It's the same as now. Git uses the concept of a 'work tree' to talk
about the actual files you are working on now. The work tree
corresponds exactly to your current project files. When you create a
git repository you gain the ability to store snapshots of this working
tree into the 'object store', as well as metadata about the snapshots,
so that you can restore that snapshot later.

Your actual files keep their current layout and format, until you change them.

> 3) How do I move my current Eclipse project into git after I create the
> empty repository? I can only find info on how to import git into Eclipse
> not the other way around.

You have two options. Create the git repository in the same location
as your Eclipse project. Navigate to the project folder using git bash
and do a 'git init' inside it; voila! you now have a git repository.
You can choose to create a 'remote' repository somewhere to store a
backup of your code as well, but this _still_ requires you to init a
local repository to backup.

The other option is to create a blank repository somewhere (anywhere)
and then tell that repository to use your Eclipse project as its
working tree. The benefit to doing this is being able to keep your
snapshots and metadata in a different location to your working
directory (say keep the snapshots on a local windows drive while your
working directory is on the linux share). Unless you shouldn't or
aren't able to create the repository within the Eclipse project, I
would recommend against this.

> 4) Do I need to checkout the entire project from Eclipse to modify and
> test it or only the classes I want to change? Does the plugin get the
> others as needed when I run the app within Eclipse for testing?

Not sure exactly what you are asking here, but in general people will
'clone' an entire repository including all its history. If you want to
update only certain files that is fine, but the commit object stores
the state of the entire tree of files. Note that a commit object does
_not_ store the difference between two snapshots, but stores the
entire state of the files. You can grab a file from a given snapshot
and test that along side files from a second snapshot, but if you
wanted to commit the resulting tree to the repository it would store a
third snapshot containing the exact state of all files.

Hopefully that clears it up for you?

Regards,

Andrew Ardill
