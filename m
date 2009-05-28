From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Strangely hosed git install
Date: Thu, 28 May 2009 09:08:58 +0200
Message-ID: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 28 09:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Zjk-0000CV-5f
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZE1HI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZE1HI6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:08:58 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:50223 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbZE1HI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:08:58 -0400
Received: by fxm12 with SMTP id 12so3467593fxm.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=P8VZ1erPmU3ak0NvhrFf4wNvkrK1sEFSVKx8BbrTJy8=;
        b=wlAm5ZepSToNQOhHNPYkparrv6gecpUh4ikLcsYYDZEbNBQxEpgoolpR1lSk8T29Ct
         0AJzoRWEWPcO02hrsXXBQwWGLE2jI13WoaCNo3LooTgVqpC3tkxvDOmsoVKQITxIJFh7
         cO/eIdVR9w3V7Apc1OcJcO9aChMaW04iJdWeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=AjmkD19KAzdI9lGvShtSxaETVzTic+6pwW1lvZI1t6mLU1463C5fvwyb1AJvsVRoDj
         HL0bjI1irw6XalR8sMh/GGUv6SC+0R3ljXULP/0Y3tXH3lcO3jjPqSZSdEUF/XmoVimF
         To6cUnie2izuGeaWOVmnhw2ewjCpIykDBS1qs=
Received: by 10.223.122.141 with SMTP id l13mr797524far.99.1243494538700; Thu, 
	28 May 2009 00:08:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120160>

My main laptop (and part-time dev box) has a partially hosed git
installation. This is an ubuntu intrepid machine where I have been
building git from src for a while. Perhaps there's a way to diagnose
this before I take more drastic measures :-)

So far gc, repack and stash show errors. No dataloss AFAICS (though
the git stash errors scared me initially).

gc and repack error out thus:

$ git gc
usage: git-pack-objects [{ -q | --progress | --all-progress }]
        [--max-pack-size=N] [--local] [--incremental]
        [--window=N] [--window-memory=N] [--depth=N]
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
        [--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]
error: failed to run repack
$ echo $?
255

And stash...

$ git stash
usage: git-diff-index [-m] [--cached] [<common diff options>]
<tree-ish> [<path>...]
common diff options:
(...)

usage: git-diff-index [-m] [--cached] [<common diff options>]
<tree-ish> [<path>...]
common diff options:
(...)
Saved working directory and index state "WIP on master: 1eac877... WIP
olpc-update-query: if the lease is due soon avoid
randomly_do_nothing()"
HEAD is now at 1eac877... WIP olpc-update-query: if the lease is due
soon avoid randomly_do_nothing()
(To restore them type "git stash apply")
$ echo $?
0
$ git stash show
 olpc-update-query |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
$ git stash apply # does the right thing

Some background diagnostics info

 - $ git --version
   git version 1.6.3.1.26.gf5b223

 - $ which git
   /home/martin/bin/git
  # there is no other git install anywhere on the box

 - the git-core package was once installed temporarily (to try out a
package that depends on git-core)

 - some oldstyle "dashed" commands trigger a helper bash extension, thus
   $ git-diff
   The program 'git-diff' is currently not installed.  You can install
it by typing:
   sudo apt-get install git-core
   bash: git-diff: command not found


I can't figure out what is wrong with the install. I have bisected a
few bugs in the past, but that had never left any traces behind.

It's not a serious problem -- I just wonder whether it'd affect other
people developing / tracking git.

cheers,



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
