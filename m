From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 19:31:24 +0100
Message-ID: <20080116183124.GA3181@steel.home>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFD3N-0003mt-FM
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYAPSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbYAPSb2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:31:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38397 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYAPSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:31:27 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFj/1U=
Received: from tigra.home (Fad79.f.strato-dslnet.de [195.4.173.121])
	by post.webmailer.de (klopstock mo53) (RZmta 15.4)
	with ESMTP id 205c05k0GFIMVA ; Wed, 16 Jan 2008 19:31:25 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 85175277AE;
	Wed, 16 Jan 2008 19:31:25 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id EE6D656D22; Wed, 16 Jan 2008 19:31:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70716>

Paul Umbers, Wed, Jan 16, 2008 16:42:46 +0100:
> OK, I think this worked (I'm a Java man, not C/C++). I downloaded the
> latest 1.5.3 source from the git repository and ran "make" with
> GIT_TEST_OPTS="--verbose --debug". Here's the output:
> 
...
> * expecting success: tree=$(git write-tree)
> error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> fatal: git-write-tree: error building trees
> * FAIL 5: writing tree out with git write-tree
>         tree=$(git write-tree)

Ok, since you managed to compile it, could you please try to strace
git-add? Cygwins strace is a bit unusual, but strace --help can
provide enough information to configure it to trace filesystem
operations.

In the top-level of Git source directory:

    $ uname -a > somefile
    $ strace -o log -f -m syscall ./git --exec-path=$(pwd) add somefile
    $ git ls-files -s somefile

or

    $ strace -o log -f -m syscall ./git --exec-path=$(pwd) hash-object somefile

Than check if the sha1file is missing and send in the log.
