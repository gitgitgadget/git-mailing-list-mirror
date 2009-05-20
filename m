From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: help reproduce fast-forward in rebase
Date: Wed, 20 May 2009 11:26:47 +0200
Message-ID: <4A13CCD7.5090900@viscovery.net>
References: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 11:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6i4m-0001yz-2d
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 11:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103AbZETJ0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 05:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZETJ0w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 05:26:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6561 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZETJ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 05:26:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M6i4S-0003qO-EY; Wed, 20 May 2009 11:26:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 34F826D9; Wed, 20 May 2009 11:26:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119592>

Nguyen Thai Ngoc Duy schrieb:
> Hi,
> 
> I'm rewriting rebase in C and do not quite understand this code inside
> git-rebase.sh

One thing that has annoyed me sometimes is that 'git rebase --cont' works
only after 'git rebase -i' but not after plain 'git rebase'. The reason is
that the two instances of rebase do their own argument parsing, and the
interactive version uses rev-parse --parseopt, and normal rebase does not.
I hope you will rectify this situation.

> # If the $onto is a proper descendant of the tip of the branch, then
> # we just fast forwarded.
> if test "$mb" = "$branch"
> then
> 	echo >&2 "Fast-forwarded $branch_name to $onto_name."
> 	move_to_original_branch
> 	exit 0
> fi
> 
> Anyone has an example how to make "git rebase" execute that code?

  $ git checkout -b topic master^
  Switched to a new branch 'topic'
  $ git rebase master
  First, rewinding head to replay your work on top of it...
  Fast-forwarded topic to master.

That is, topic was already merged into master.

-- Hannes
