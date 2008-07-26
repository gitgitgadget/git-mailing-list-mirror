From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Support linked resources
Date: Sat, 26 Jul 2008 16:59:12 -0500
Message-ID: <20080726215912.GD16219@spearce.org>
References: <5a27b7b0807232034t564e8d45l9f6e4bc6429cda60@mail.gmail.com> <200807261707.18299.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richie Vos <jerry.vos@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 00:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMroD-0007pq-3V
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 00:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbYGZV7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 17:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755518AbYGZV7N
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 17:59:13 -0400
Received: from george.spearce.org ([209.20.77.23]:59592 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbYGZV7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 17:59:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3607F383A8; Sat, 26 Jul 2008 21:59:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807261707.18299.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90290>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> torsdagen den 24 juli 2008 05.34.06 skrev Richie Vos:
> > I have a project that outputs to a linked directory (for example the
> > project is in /projects/foo and the project outputs to /projects/bar).
...
> I'd be inclined to prefer ignoring any non-plain resource, always. Linked
> resources are either absolute or relative to a variable. Other than that 
> there is an analogy to symbolic links. Git manages the link, not its
> content (unless handled elsewhere). The link in this case is in the
> .project file and thus managed there.
> 
> EGit could still managed the resource, but not via the link, but rather at
> the place it is located, iff that happens to be in a project managed by Egit.

My last day-job used a project layout in the filesystem of:

	GIT_REPO/
	  .git/
      .gitignore
      _eclipse_projects/
          com.sekret.foo/.project
          com.sekret.bar/.project
      foo/
          com/sekret/foo/Foo.java
      bar/
          com/sekret/bar/Bar.java

The two .project files contained links called "src" to "foo" and
"bar" respectively.  The _eclipse_projects folder is ignored by
.gitignore, and the .project files were actually generated on the
fly by our non-Eclipse based buildsystem.

Consequently I wanted egit to be able to manage the stuff inside of
a linked folder, so long as it mapped onto the same repository that
the project mapped onto.  Without that the "src" folder contents
wouldn't be available to egit, and egit would be more-or-less
useless on this sort of layout.

-- 
Shawn.
