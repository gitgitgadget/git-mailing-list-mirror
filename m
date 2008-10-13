From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: concerns about git
Date: Mon, 13 Oct 2008 11:19:41 -0700
Message-ID: <20081013181941.GT4856@spearce.org>
References: <19959918.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: deepwinter <deepwinter@winterroot.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpS2K-0000kv-SQ
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 20:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758216AbYJMSTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 14:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbYJMSTn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 14:19:43 -0400
Received: from george.spearce.org ([209.20.77.23]:38526 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbYJMSTm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 14:19:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ACBA63835F; Mon, 13 Oct 2008 18:19:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <19959918.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98138>

deepwinter <deepwinter@winterroot.net> wrote:
> 
> i've been looking into using git for some version control and it looks
> great.. except for 1 thing that really disturbs me.  why is the .git
> repository stored within the working copy?  this is seems like a recipe for
> accidental deletion.  if you are an individual using version control lets
> say for just your own work, there is a lot of security that is gained from
> at least having your repository within a different directory, or better on a
> different partition.  this ensures that accidental deletions or hard drive
> crashes are less likely to result in loosing the ENTIRE project!  of course,
> accidentally deleting your working copy is stupid, but it does happen.   git
> seems to offer no protection against this kind of mistake for the individual
> coder.. or is there some way to have git put the actual repository files in
> a different directory?  (can't find info on that)

Because every working copy is equal.  They all have a copy of the
project's metadata in the .git/ directory.

If you want a backup, create one with clone and push to it every
so often, e.g.:

  # one time setup
  $ git clone --bare . /some/other/drive/project.git
  $ git remote add backup /some/other/drive/project.git

  # then every once in a while, or from a cron job
  $ git push --all backup

Of course since Git is distributed you can you use this same approach
to make backups to other systems.  You can even edit the .git/config
to give the [remote "backup"] section more than one url line, so
that "git push --all backup" will send updated copies to multiple
locations at once.

Who needs a central repository like SVN or CVS when you can have 3
or 4, on just as many disks, in different buildings, and possibly
different parts of the world.  Yes, I keep my real work that I care
about backed up under different providers, with their data centers
located in different countries.  And of course extra copies locally,
in case the 'net is down.

-- 
Shawn.
