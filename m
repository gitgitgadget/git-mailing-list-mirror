From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: complete full refs
Date: Thu, 27 Nov 2008 13:29:38 -0800
Message-ID: <20081127212938.GB23984@spearce.org>
References: <1227792947-4055-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oRr-00022N-Ja
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYK0V3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYK0V3j
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:29:39 -0500
Received: from george.spearce.org ([209.20.77.23]:53541 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYK0V3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:29:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6252138210; Thu, 27 Nov 2008 21:29:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1227792947-4055-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101839>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Sometimes it's handy to complete full refs, [...]
> 
> To do that, we check whether the ref to be completed starts with
> 'refs'.
...
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0ee071b..39bf18b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -188,11 +188,22 @@ __git_tags ()
>  
>  __git_refs ()
>  {
> -	local cmd i is_hash=y dir="$(__gitdir "$1")"
> +	local i is_hash=y dir="$(__gitdir "$1")"
> +	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
>  	if [ -d "$dir" ]; then
> -		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
> -		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
> -			refs/tags refs/heads refs/remotes
> +		case "$cur" in
> +		refs*)

I wonder if the pattern shouldn't be:

	refs|refs/*)

to reduce the risk of matching "refs-" and trying to do a full ref
match instead of a short ref match.

Otherwise,

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
