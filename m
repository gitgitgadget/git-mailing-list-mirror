From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why is TreeWalk.forPath(...) returning null
Date: Wed, 12 Nov 2008 14:42:36 -0800
Message-ID: <20081112224236.GX2932@spearce.org>
References: <491B579E.6050408@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ORG-0000xU-FD
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbYKLWmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYKLWmi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:42:38 -0500
Received: from george.spearce.org ([209.20.77.23]:52272 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYKLWmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:42:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB876381FF; Wed, 12 Nov 2008 22:42:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <491B579E.6050408@wellfleetsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100826>

Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>
> My "git status" command shows:
>
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #    modified:   xml/minDB/SubmitObjectsRequest_CMSScheme.xml
>
> The file above was committed and then modified. I want to use jgit to  
> find the comitted version of that file.
>
> When I do the following code I get a null treeWalk? Why is that? What  
> should I specify for path instead?
>
>            String path = "xml/minDB/SubmitObjectsRequest_CMSScheme.xml";
>            String versionName = Constants.HEAD;
>
>            Commit commit = repository.mapCommit(versionName);
>
>            if (commit == null) {
>                log.trace("Did not find Commit. versionName:" +  
> versionName);
>            } else {
>                ObjectId[] ids = {commit.getTree().getId()};
>                TreeWalk treeWalk = TreeWalk.forPath(repository, path, ids);
>            }

Huh.  That should have worked.

TreeWalk.forPath returns null if the path doesn't get found.  So
it sounds like jgit isn't matching the path.  Its a pretty simple
operation, I'm not sure why its failing here.  I'd run it through
a debugger to try and see why the TreeWalk didn't match your path.

Your code is logically the same as:

  git rev-parse HEAD:$path

so it should find the blob if Git would have found it.

-- 
Shawn.
