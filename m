From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] completion: More fixes to prevent unbound variable
	errors.
Date: Wed, 11 Feb 2009 10:09:34 -0800
Message-ID: <20090211180934.GN30949@spearce.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com> <1234375406-27099-4-git-send-email-ted@tedpavlic.com> <1234375406-27099-5-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJYA-0001h1-Ds
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760AbZBKSJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756749AbZBKSJg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:09:36 -0500
Received: from george.spearce.org ([209.20.77.23]:56360 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbZBKSJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:09:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CE00B38210; Wed, 11 Feb 2009 18:09:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234375406-27099-5-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109469>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Several functions make use of "[-n ...]" and "[-z ...]". In many cases,
> the variables being tested were declared with "local." However, several
> __variables are not, and so they must be replaced with their ${__-}
> equivalents.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c28d6be..371148b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -62,7 +62,7 @@ esac
>  __gitdir ()
>  {
>  	if [ -z "${1-}" ]; then
> -		if [ -n "$__git_dir" ]; then
> +		if [ -n "${__git_dir-}" ]; then
>  			echo "$__git_dir"
>  		elif [ -d .git ]; then
>  			echo .git
> @@ -298,7 +298,7 @@ __git_remotes ()
>  
>  __git_merge_strategies ()
>  {
> -	if [ -n "$__git_merge_strategylist" ]; then
> +	if [ -n "${__git_merge_strategylist-}" ]; then
>  		echo "$__git_merge_strategylist"
>  		return
>  	fi
> @@ -384,7 +384,7 @@ __git_complete_revlist ()
>  
>  __git_all_commands ()
>  {
> -	if [ -n "$__git_all_commandlist" ]; then
> +	if [ -n "${__git_all_commandlist-}" ]; then
>  		echo "$__git_all_commandlist"
>  		return
>  	fi
> @@ -402,7 +402,7 @@ __git_all_commandlist="$(__git_all_commands 2>/dev/null)"
>  
>  __git_porcelain_commands ()
>  {
> -	if [ -n "$__git_porcelain_commandlist" ]; then
> +	if [ -n "${__git_porcelain_commandlist-}" ]; then
>  		echo "$__git_porcelain_commandlist"
>  		return
>  	fi
> -- 
> 1.6.1.2.390.gba743
> 

-- 
Shawn.
