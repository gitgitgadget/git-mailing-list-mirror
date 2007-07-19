From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH guilt] Handles slashes in branch names
Date: Thu, 19 Jul 2007 14:44:18 -0400
Message-ID: <20070719184418.GA22463@filer.fsl.cs.sunysb.edu>
References: <87y7hctf6o.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joseph Jeff Sipek <jsipek@cs.sunysb.edu>,
	Git mailing list <git@vger.kernel.org>
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Thu Jul 19 20:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBazK-0008Ng-KH
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbXGSSoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756556AbXGSSoa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:44:30 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35812 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbXGSSo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 14:44:29 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6JIiIkL024640;
	Thu, 19 Jul 2007 14:44:18 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6JIiIQ1024638;
	Thu, 19 Jul 2007 14:44:18 -0400
Content-Disposition: inline
In-Reply-To: <87y7hctf6o.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53016>

On Thu, Jul 19, 2007 at 11:35:11AM -0700, Eric Lesh wrote:
> When a branch name has a slash and autotagging is enabled, guilt barfs
> when updating the stack tags.  Escape the branch name in the tags to
> allow this to work.
...
> -		git-rev-parse HEAD > "$GIT_DIR/refs/tags/${branch}_top"
> -		head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${branch}_bottom"
> -		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${branch}_base"
> +		git-rev-parse HEAD > "$GIT_DIR/refs/tags/${newbranch}_top"
> +		head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${newbranch}_bottom"
> +		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${newbranch}_base"

Why mangle the branch name when we can do:

mkdir -p `basename $GIT_DIR/refs/tags/${branch}_top`
git-rev-parse .... 

Sure, it is ugly, but it preserves the branch name. Am I missing something?

Josef 'Jeff' Sipek.

-- 
A computer without Microsoft is like chocolate cake without mustard.
