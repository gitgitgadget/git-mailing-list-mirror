From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Show an example of deleting commits with git-rebase.
Date: Wed, 7 Feb 2007 12:16:24 +0200
Message-ID: <20070207101624.GC20290@mellanox.co.il>
References: <20070205202106.GA8755@spearce.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 11:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjqT-0007kB-Dy
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 11:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbXBGKQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 05:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXBGKQG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 05:16:06 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33085 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030619AbXBGKQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 05:16:05 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l17AFoIE007077;
	Wed, 7 Feb 2007 12:15:51 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 12:16:24 +0200
Content-Disposition: inline
In-Reply-To: <20070205202106.GA8755@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38908>

> Quoting Shawn O. Pearce <spearce@spearce.org>:
> Subject: [PATCH] Show an example of deleting commits with git-rebase.
> 
> This particular use of git-rebase to remove a single commit or a
> range of commits from the history of a branch recently came up on
> the mailing list.  Documenting the example should help other users
> arrive at the same solution on their own.
> 
> It also was not obvious to the newcomer that git-rebase is able to
> accept any commit for --onto <newbase> and <upstream>.  We should
> at least minimally document this, as much of the language in
> git-rebase's manpage refers to 'branch' rather than 'committish'.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  Documentation/git-rebase.txt |   27 +++++++++++++++++++++++++--
>  1 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0cb9e1f..977f661 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -114,6 +114,27 @@ would result in:
>  
>  This is useful when topicB does not depend on topicA.
>  
> +A range of commits could also be removed with rebase.  If we have
> +the following situation:
> +
> +------------
> +    E---F---G---H---I---J  topicA
> +------------
> +
> +then the command
> +
> +    git-rebase --onto topicA~5 topicA~2 topicA
> +
> +would result in the removal of commits F and G:
> +
> +------------
> +    E---H'---I'---J'  topicA
> +------------
> +
> +This is useful if F and G were flawed in some way, or should not be
> +part of topicA.  Note that the argument to --onto and the <upstream>
> +parameter can be any valid commit-ish.
> +

Good clarification, a couple of comments:
- The use of <branch> is more confusing than useful in this case.
  You can always just do
	git reset --hard topicA
	git-rebase --onto topicA~5 topicA~2
  instead, correct?

- The use of ~ notation here is also more scary than clarifying.
   git-rebase --onto F H
  will be clearer I think.

-- 
MST
