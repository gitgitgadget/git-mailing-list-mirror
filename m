From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: fix PS1 display during a merge on detached
	HEAD
Date: Sat, 16 May 2009 12:59:47 -0700
Message-ID: <20090516195947.GI30527@spearce.org>
References: <7vzldcnawx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 22:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Q35-0003LS-CJ
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578AbZEPT7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756627AbZEPT7r
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:59:47 -0400
Received: from george.spearce.org ([209.20.77.23]:46928 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbZEPT7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:59:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D18B8381D5; Sat, 16 May 2009 19:59:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzldcnawx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119381>

Junio C Hamano <gitster@pobox.com> wrote:
> If your merge stops in a conflict while on a detached HEAD, recent
> completion code fails to show anything.  This was because various cases
> added to support the operation-in-progress markers (e.g. REBASE, MERGING)
> forgot that they need to set the variable "b" to something for the result
> they computed to be displayed at all.
> 
> Probably not many people make trial merges on a detached HEAD (which is
> tremendously useful feature of git, by the way), and that may be why this
> was not noticed for a long time.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Yay, thanks Junio.

Trivially-Acked-By: Shawn O. Pearce <spearce@spearce.org>


:-)

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ad26b7c..4462ef0 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -99,10 +99,10 @@ __git_ps1 ()
>  		elif [ -d "$g/rebase-merge" ]; then
>  			r="|REBASE-m"
>  			b="$(cat "$g/rebase-merge/head-name")"
> -		elif [ -f "$g/MERGE_HEAD" ]; then
> -			r="|MERGING"
> -			b="$(git symbolic-ref HEAD 2>/dev/null)"
>  		else
> +			if [ -f "$g/MERGE_HEAD" ]; then
> +				r="|MERGING"
> +			fi
>  			if [ -f "$g/BISECT_LOG" ]; then
>  				r="|BISECTING"
>  			fi

-- 
Shawn.
