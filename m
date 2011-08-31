From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 11:14:48 -0500
Message-ID: <sDZ5pnWzh3ZbFYS6GK-NcPdn09kF53MJ2eRkBnzInzdL8-cvCiF5beUw2k9Pz6BTq-Y3i_XwpYfgTOvXNlP1vPjLSHJ6FIzxL0jN1W0d0M8@cipher.nrlssc.navy.mil>
References: <1314804325568-6746957.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynRO-0000rl-Bo
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab1HaQO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:14:57 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:60393 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756683Ab1HaQO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:14:56 -0400
Received: by mail3.nrlssc.navy.mil id p7VGEn77017749; Wed, 31 Aug 2011 11:14:49 -0500
In-Reply-To: <1314804325568-6746957.post@n2.nabble.com>
X-OriginalArrivalTime: 31 Aug 2011 16:14:48.0724 (UTC) FILETIME=[1B2B4540:01CC67F9]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180477>

On 08/31/2011 10:25 AM, ryan@iridiumsuite.com wrote:
> Noobie here...Don't ask why, but I have essentially 3 branches in separate
> code bases on my file system that aren't in a repository right now.  
> 
> I would like to turn this into a git repository.  One branch being master,
> the second develop and finally a third branch that is extended off the
> develop branch.
> 
> Is there a way to do this?  Could someone give me a step by step?  I am
> having a hard enough time just getting use to git and I am lost trying to
> figure this out.

So, you want your repository and dag to look like this:

     *------*------*
     |      |      |
  master  devel  topic

but it may help you visualize it to write it like this:

  master *
          \
     devel *
            \
       topic *

Just be aware that the above two are the same.  If you don't understand
that now, then let this plant the seed in your brain of the concept that
branches are merely "pointers" to a state of your repository.  Don't
worry, you don't have to understand that now in order to get started
and accomplish what you are trying to do...

First, create your git repository based on the code in the directory
holding what you would like to become the master branch.

Either

   cd $path_to_master_code

or

   mkdir $my_new_project_directory &&
   cd $my_new_project_directory &&
   cp -a $path_to_master_code/* .

then

   git init &&
   git add . &&
   git commit -m 'Initial import into git'

Voila, you have your master branch.  Now just create your devel
branch and copy your devel code into it and commit.

   git checkout -b devel &&  # make a new branch named "devel"
                             # which has the same state as the
                             # currently checked out branch: "master"
                             # i.e. devel and master point to the
                             # same tip commit.
   rm -rf * &&               # remove the files in the working dir
   cp -a $devel_dir/* . &&   # cp devel source code to working dir
   git add -A . &&           # add new/removed files to the index
                             # to be committed on next 'git commit'
   git commit
   # use editor to give descriptive commit message

Repeat for your topic branch based off of devel.

Please make sure you read the man pages for the above commands and
understand what is going on before you do it, and double-check my
commands.

-Brandon
