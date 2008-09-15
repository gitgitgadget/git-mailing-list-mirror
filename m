From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-clone: path or ssh problem with git-upload-pack in 1.6.0?
Date: Mon, 15 Sep 2008 18:25:37 +0200
Message-ID: <48CE8C81.2020709@fastmail.fm>
References: <d3a045300809091929h18c3c447gb3d4e79131f66986@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Johnston <pcj127@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGzx-0007qB-J2
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbYIOQa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754950AbYIOQa7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:30:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46951 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754908AbYIOQa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 12:30:58 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 32140162CCA;
	Mon, 15 Sep 2008 12:30:57 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 15 Sep 2008 12:30:57 -0400
X-Sasl-enc: JAj5UgXzChEGohVzq/v4wcItYlJ8E5gmkbDspW5guyzi 1221495940
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E86632634;
	Mon, 15 Sep 2008 12:25:40 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95920>

Paul Johnston venit, vidit, dixit 15.09.2008 10:30:
> I'm having trouble with git-clone and I'm wondering if there's
> something I'm doing wrong or something wrong with git.  Probably the
> former, hopefully someone can set me straight.
> 
> I'm an admittedly novice git user. I'm trying to clone a repository
> over ssh. The host machine 'imac' is my mac osx 10.4 with git 1.6.0
> installed from a macports package.  This installs into /opt/local/bin.
> I also cloned git from HEAD and 'make; make install'ed into ~/bin,
> this is the version shown below.  Either way, these are
> nonstandard/non-system-wide installation locations, and it requires
> that my shell PATH reflect this, obviously.
> 
> ----------------------------------------------
> 
> # About my installation
> imac:~ paul$ which git
> /Users/paul/bin/git
> 
> imac:~ paul$ git --version
> git version 1.6.0.1.285.g1070
> 
> imac:~ paul$ ls /opt/local/bin/git*
> /opt/local/bin/git
> /opt/local/bin/git-upload-archive       /opt/local/bin/gitk
> /opt/local/bin/git-receive-pack         /opt/local/bin/git-upload-pack
> 
> imac:~ paul$ ls ~/bin/git*
> /Users/paul/bin/git
> /Users/paul/bin/git-shell
> /Users/paul/bin/git-upload-pack
> /Users/paul/bin/git-receive-pack
> /Users/paul/bin/git-upload-archive
> 
> # Make a simple reposirtory /tmp/test/.git
> imac:~ paul$ cd /tmp
> imac:/tmp paul$ mkdir test; cd test; echo 'Hello World' > README; git
> init; git add README; git commit -a -m'Initial import'; cd ..
> Initialized empty Git repository in /private/tmp/test/.git/
> Created initial commit 49c10e6: Initial import
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 README
> 
> # OK, this fails expectedly
> imac:/tmp paul$ cd ~
> imac:~ paul$ git clone ssh://localhost/tmp/test/.git
> Initialized empty Git repository in /Users/paul/test/.git/
> Password:
> bash: line 1: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
> 
> # This has been killing me...  Have tried numerous variants of the
> same with similar results...
> imac:~ paul$ git clone --upload-pack /opt/local/bin/git-upload-pack
> ssh://localhost/tmp/test/.git
> Initialized empty Git repository in /Users/paul/test/.git/
> Password:
> remote: fatal: exec pack-objects failed.
> error: git-upload-pack: git-pack-objects died with error.
> fatal: git-upload-pack: aborting due to possible repository corruption
> on the remote side.
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> fatal: index-pack failed
> 
> # Fix it with symlinks in /usr/bin
> imac:~ paul$ cd /usr/bin/
> imac:/usr/bin paul$ sudo ln -s /opt/local/bin/git* .
> imac:/usr/bin paul$ ls -al git*
> lrwxr-xr-x   1 root  wheel  18 Sep  9 19:18 git -> /opt/local/bin/git
> lrwxr-xr-x   1 root  wheel  31 Sep  9 19:18 git-receive-pack ->
> /opt/local/bin/git-receive-pack
> lrwxr-xr-x   1 root  wheel  33 Sep  9 19:18 git-upload-archive ->
> /opt/local/bin/git-upload-archive
> lrwxr-xr-x   1 root  wheel  30 Sep  9 19:18 git-upload-pack ->
> /opt/local/bin/git-upload-pack
> lrwxr-xr-x   1 root  wheel  19 Sep  9 19:18 gitk -> /opt/local/bin/gitk
> 
> # And now git-clone works as expected...
> imac:/usr/bin paul$ cd
> imac:~ paul$ git clone ssh://localhost/tmp/test/.git
> Initialized empty Git repository in /Users/paul/test/.git/
> Password:
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (3/3), done.
> 
> imac:~ paul$ find test/
> test/
> test//.git
>   { file listing removed for brevity... }
> test//README
> 
> -------------------------------------------
> 
> OK, great, now it works. I suspect I'm not using the --upload-pack
> option correctly or my ssh installation is suboptimal, but as I could
> find no existing documentation on the subject, I am posting this
> message.  Any thoughts?

re ssh: I'm surprised your PATH doesn't include $HOME/bin when sshing.
That should make everything work.

re upload-pack: That indeed sounds as if upload-pack can't execute
pack-objects. I checked by moving my bin away, and clone failed. Seems
everyone is using proper PATHS ;)

In fact, upload-pack tries to call "git pack-objects" and fails if it
can't find git. Patch upcoming...

Michael
