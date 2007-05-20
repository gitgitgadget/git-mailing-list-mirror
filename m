From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGit PATCH 1/2] Update the bash prompt from 'applied' instead of  the obsolete 'current'
Date: Sun, 20 May 2007 22:46:27 +0200
Message-ID: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070520200113.14633.90705.stgit@lathund.dewire.com> <20070520200403.14633.26644.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 20070506150852.8985.98091.stgit@yoghurt.dewire.com,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun May 20 22:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsKF-0007pl-0C
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbXETUsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbXETUsH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:48:07 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60392 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbXETUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:48:05 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 547C56041C;
	Sun, 20 May 2007 22:48:02 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D1D611F15B; Sun, 20 May 2007 22:46:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520200403.14633.26644.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47912>

Note that "tail -1" gives a warning with newer versions, "tail -n 1"
should be the proper call.

Also I'm not sure it is a good way to look at "applied" file, since
Karl IIRC has plans to change this.  Better call "stg top" and not
touch that again :)

On Sun, May 20, 2007 at 10:04:03PM +0200, Robin Rosenberg wrote:
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
> 
>  contrib/stgbashprompt.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
> index 16bb39b..7c5dc76 100755
> --- a/contrib/stgbashprompt.sh
> +++ b/contrib/stgbashprompt.sh
> @@ -8,8 +8,8 @@ if [ "$PS1" ]; then
>  		git_dir=$(git-rev-parse --git-dir 2> /dev/null) || return
>  		ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
>  		br=${ref#refs/heads/}
> -		top=$(cat $git_dir/patches/$br/current 2>/dev/null) \
> -			&& top="/$top"
> +		top=$(tail -1 $git_dir/patches/$br/applied 2>/dev/null) \
> +			&& top="/$top";
>  		echo "[$br$top]"
>  	}
>  	PS1='\u@\h:$(__prompt_git)\W\$ '
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> !DSPAM:4650aff673931961316905!
> 
