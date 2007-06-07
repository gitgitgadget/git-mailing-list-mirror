From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Wed, 06 Jun 2007 19:09:11 -0700
Message-ID: <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
References: <466639D0.1040306@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7RC-0008FU-1R
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935451AbXFGCJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935495AbXFGCJP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:09:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49236 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935451AbXFGCJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:09:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607020914.SBRP7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:09:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8S9C1X00J1kojtg0000000; Wed, 06 Jun 2007 22:09:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49341>

Josh Triplett <josh@freedesktop.org> writes:

> Replace all uses of cat that do nothing other than read a single file.  In the
> case of git-quilt-import, this occurs once per patch.
>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>
> This revised version fixes a bug caught by Stephen Rothwell: the output of wc
> -l changes when it has a filename on the command line.  The same bug occurred
> in one other place as well.

Hmph...

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 0c8a7df..346cf3f 100644
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -333,7 +333,7 @@ for commit in $unchanged; do
>  done
>  
>  git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs
> -commits=$(cat ../revs | wc -l | tr -d " ")
> +commits=$(wc -l ../revs | tr -d -c 0-9)


... and left unfixed ;-)?
