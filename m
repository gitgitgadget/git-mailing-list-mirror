From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Show UUID in svn info for added directories
	with svn 1.5.5
Date: Sun, 18 Jan 2009 19:04:44 -0800
Message-ID: <20090119030444.GA21944@dcvr.yhbt.net>
References: <1232330521-50197-1-git-send-email-git-dev@marzelpan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcel Koeppen <git-dev@marzelpan.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkSo-0002LL-9M
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbZASDEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757330AbZASDEp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:04:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39688 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757319AbZASDEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:04:45 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0701F795;
	Mon, 19 Jan 2009 03:04:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1232330521-50197-1-git-send-email-git-dev@marzelpan.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106309>

Marcel Koeppen <git-dev@marzelpan.de> wrote:
> In svn 1.5.5 the output of "svn info" for added directories was changed
> and now shows the repository UUID. This patch implements the same
> behavior for "git svn info" and makes t9119-git-svn-info.17 pass if
> svn 1.5.5 is used.
> 
> Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>

Thanks Marcel,
Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index ad01e18..2f16a4e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -911,7 +911,8 @@ sub cmd_info {
>  	if ($@) {
>  		$result .= "Repository Root: (offline)\n";
>  	}
> -	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A";
> +	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A" &&
> +		($SVN::Core::VERSION le '1.5.4' || $file_type ne "dir");
>  	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
>  
>  	$result .= "Node Kind: " .
> -- 
