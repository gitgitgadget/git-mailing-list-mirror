From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2] gitk: Fix missing commits when using -S or -G
Date: Mon, 9 May 2016 13:45:19 +1000
Message-ID: <20160509034519.GC12515@fergus.ozlabs.ibm.com>
References: <572C8665.8090707@gmx.de>
 <572C8B36.2000106@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Dotterweich <stefandotterweich@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 05:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azc8O-0001eu-CP
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 05:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbcEIDpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 23:45:23 -0400
Received: from ozlabs.org ([103.22.144.67]:39569 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbcEIDpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 23:45:23 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3r37Z93Hy4z9t3c; Mon,  9 May 2016 13:45:21 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <572C8B36.2000106@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293981>

On Fri, May 06, 2016 at 02:16:54PM +0200, Stefan Dotterweich wrote:
> When -S or -G is used as a filter option, the resulting commit list
> rarely contains all matching commits. Only a certain number of commits
> are displayed and the rest are missing.
> 
> "git log --boundary -S" does not return as many boundary commits as you
> might expect. gitk makes up for this in closevargs() by adding missing
> parent (boundary) commits. However, it does not change $numcommits,
> which limits how many commits are shown. In the end, some commits at the
> end of the commit list are simply not shown.
> 
> Change $numcommits whenever a missing parent is added.

Nice catch; however, we should only update numcommits if the commits
are for the current view, i.e. if $v == $curview.

Do you want to update the patch?  If you prefer, I can update the
patch and put a note in the commit message about the issue.

Paul.
