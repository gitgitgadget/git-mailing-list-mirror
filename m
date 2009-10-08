From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGit 4/5] Adding in a InfoDatabase like ObjectDatabase
	and and implementation based upon a directory.
Date: Thu, 8 Oct 2009 10:05:54 -0700
Message-ID: <20091008170554.GG9261@spearce.org>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwXw-0006tk-C7
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089AbZJHRGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbZJHRGb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:06:31 -0400
Received: from george.spearce.org ([209.20.77.23]:47631 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbZJHRGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:06:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6FB7E381FF; Thu,  8 Oct 2009 17:05:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129706>

mr.gaffo@gmail.com wrote:
> From: Mike Gaffney <mr.gaffo@gmail.com>
> Subject: Re: [PATCH JGit 4/5] Adding in a InfoDatabase like ObjectDatabase
> and and implementation based upon a directory.

Typo on "and and".

We should have a bit more justification for this change, the subject
sounds aggressive, but there's no rationle for 175 insertions.
You and I both can make a reaosnable guess about why, but not
everyone knows the code or what you are trying to accomplish.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
> +public abstract class InfoDatabase {
> +
> +	public void create() {
> +	}

New public code should have Javadoc to document its purpose and
usage, especially for an abstract class that needs to be implemented.

But, that said, I think this direction is of dubious value.  What we
really care about is having the contents of the current RefDatabase
(that is, packed-refs and files under refs/) written into info/refs.

There really isn't anything else of value under GIT_DIR/info, other
than GIT_DIR/info/exclude, but that is related to ignore processing
for a repository with a working directory and isn't something that
a bare repository on a server ever cares about.

IMHO, updating GIT_DIR/info/refs should be part of RefDatabase,
not some new InfoDirectoryDatabase class.

-- 
Shawn.
