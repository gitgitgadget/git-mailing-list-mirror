From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: how to find all changes since last push?
Date: Thu, 05 Feb 2009 12:09:27 -0600
Message-ID: <taV0I1IK8JVRVNrt3HLsDn5Un88C8ORocUX6BbHDSJg@cipher.nrlssc.navy.mil>
References: <30903.1233854948@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8gu-0005cu-8m
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbZBESJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 13:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbZBESJj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:09:39 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49987 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZBESJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:09:38 -0500
Received: by mail.nrlssc.navy.mil id n15I9SYI009948; Thu, 5 Feb 2009 12:09:28 -0600
In-Reply-To: <30903.1233854948@relay.known.net>
X-OriginalArrivalTime: 05 Feb 2009 18:09:28.0258 (UTC) FILETIME=[E2A11A20:01C987BC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108593>

layer wrote:
> I'm a git noob, and I'm trying to move my organization to it from CVS
> (which we've used since 1991).  Currently stuck on this:
> 
> I think a natural style of development using git would be to do a
> series of commits to my local repo and when things are stable, do a
> push somewhere or collect all the changes into a patch.
> 
> I have googled and looked at documentation, but I cannot figure out
> how to find all changes since my last push.

Let's assume that the defaults are used.  Your branch is named master,
your remote is named origin, and the remote branch is named master also.

  $ git push                 # changes pushed upstream
  # edit, test, commit ...   # make new commits
  $ git log origin/master..  # show new commits since last push

>  To make this more
> complex, I'd like intervening pull's not to interfere with my ability
> to find all changes since the last push.

  $ git fetch                # fetch the changes others have committed
  $ git log origin/master..  # still shows new commits on your master since
                             # last push

'git log origin/master..' is really short for 'git log origin/master..HEAD',
or for this example, in place of 'git log origin/master..master'.  It is
showing the commits that exist on master that do not exist in origin/master.

To see what new things have been applied to origin/master that you do not
have in master (i.e. after the 'git fetch'), switch it around:

  $ git log master..origin/master

-brandon
