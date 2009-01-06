From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Quick command to count commits
Date: Tue, 6 Jan 2009 10:55:43 -0800
Message-ID: <20090106185543.GB24578@spearce.org>
References: <1231267896595-2118851.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKH6x-0006y4-04
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 19:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZAFSzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 13:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbZAFSzp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 13:55:45 -0500
Received: from george.spearce.org ([209.20.77.23]:33829 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbZAFSzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 13:55:44 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E62C138210; Tue,  6 Jan 2009 18:55:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231267896595-2118851.post@n2.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104707>

Henk <henk_westhuis@hotmail.com> wrote:
> For GitExtensions (windows git ui) I need a command to count all commits. I
> now use this command:
> git.cmd rev-list --all --abbrev-commit | wc -l
> 
> This works perfect but its very slow in big repositories. Is there a faster
> way to count the commits?

No.  But drop the --abbrev-commit flag, abbreviating the object ids
would take longer than just dumping the full 40 bytes to stdout.
It requires a scan of parts of the object database for every commit
to determine what is a unique abbreviation.

This isn't a very common operation.  Its expensive to do, as you
can see.  What's the reason for supplying it, and needing it so
quickly?  Nobody really cares how many commits are in their history,
unless they are trying to produce stats to describe how big their
repository is.  In which case the size of the .git/objects/pack
*.pack and *.idx files is much more relevant, especially the .idx
files as it gives a really quick estimate on the number of total
objects in the repository.

-- 
Shawn.
