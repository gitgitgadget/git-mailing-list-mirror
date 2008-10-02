From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix two 'uninitialized value'
	varnings in git_tree()
Date: Thu, 2 Oct 2008 17:08:59 +0200
Message-ID: <20081002150859.GQ10544@machine.or.cz>
References: <20081002144602.19247.4434.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:12:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPok-0001Ib-Iv
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbYJBPJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYJBPJD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:09:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44117 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbYJBPJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:09:01 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E129A3939B47; Thu,  2 Oct 2008 17:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081002144602.19247.4434.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97355>

On Thu, Oct 02, 2008 at 04:50:04PM +0200, Jakub Narebski wrote:
> If we did try to access nonexistent directory or file, which means
> that git_get_hash_by_path() returns `undef`, uninitialized $hash
> variable was passed to 'open' call.  Now we fail early with "404 Not
> Found - No such tree" error.  (If we try to access something which
> does not resolve to tree-ish, for example a file / 'blob' object, the
> error will be caught later, as "404 Not Found - Reading tree failed"
> error).
> 
> If we tried to use 'tree' action without $file_name ('f' parameter)
> set, which means either tree given by hash or a top tree (and we
> currently cannot distinguish between those two cases), we cannot print
> path breadcrumbs with git_print_page_path().  Fix this by moving call
> to git_print_page_path() inside conditional.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

> BTW. should we use "No such tree" or "No such directory".

I prefer the former.
