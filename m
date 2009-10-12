From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 07:30:43 -0700
Message-ID: <20091012143043.GJ9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com> <20091012141544.GF9261@spearce.org> <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4O-0002uT-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbZJLObX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbZJLObV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:31:21 -0400
Received: from george.spearce.org ([209.20.77.23]:40026 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbZJLObT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:31:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 21297381FE; Mon, 12 Oct 2009 14:30:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130024>

Israel Garcia <igalvarez@gmail.com> wrote:
> That's OK, but I want to backup my git repo locally 

Just change the path of the backup remote (that final argument to
git remote add) to point to the local directory.

Though I guess you would also need to run git init there, e.g.:

  git --git-dir=/backup/project.git init
  git remote add --mirror backup /backup/project.git

  # and create the hook as below

Of course, backup to another folder on the same disk isn't a backup
at all, the disk can still fail and lose both repositories.

> On 10/12/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Israel Garcia <igalvarez@gmail.com> wrote:
> >> Which is the simplest  way to backup a git repository after every commit?
> >
> > Add a commit hook to push to another location, e.g.:
> >
> >   git remote add --mirror backup you@another.host:path/to/backup.git
> >
> >   cat >.git/hooks/post-commit
> >   #!/bin/sh
> >   git push backup
> >   ^D
> >
> >   chmod a+x .git/hooks/post-commit

-- 
Shawn.
