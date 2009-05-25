From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 15:23:54 -0700
Message-ID: <7vvdnou8hx.fsf@alter.siamese.dyndns.org>
References: <20090525104308.GA26775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 00:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iax-0000Z1-No
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbZEYWYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZEYWYE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:24:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59087 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbZEYWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:23:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525222354.UJIB20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 May 2009 18:23:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vyPu1b0024aMwMQ03yPuna; Mon, 25 May 2009 18:23:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=Pv0F8ev7ZeQA:10 a=YmhUblc5Pd4A:10
 a=PKzvZo6CAAAA:8 a=TSbVqHtbAAAA:8 a=yqCk-p3jXY-7IV6UgEUA:9
 a=HuGRyvHgn2wAk7PMx6NtRj1rZkoA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119976>

Jeff King <peff@peff.net> writes:

> We really have no idea what state the tree is in at this
> point, and whether the user might have done useful work on
> top of it. So let's err on the side of keeping the user's
> data intact.
>
> The downside is that if they do have cruft to get rid of, or
> want to pretend as if earlier parts of the series that were
> applied did not exist, they must manually "git reset --hard"
> now.

I do not see it as a major downside, but not telling them that they may
want to when we avoid doing it ourselves might be.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a followup to:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/118373
>
>  git-am.sh |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 578780b..a7e24cf 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -240,10 +240,6 @@ then
>  			exec git rebase --abort
>  		fi
>  		git rerere clear
> -		test -f "$dotest/dirtyindex" || {
> -			git read-tree --reset -u HEAD ORIG_HEAD
> -			git reset ORIG_HEAD
> -		}
>  		rm -fr "$dotest"
>  		exit ;;
>  	esac
> -- 
> 1.6.3.1.250.g01b8b.dirty
