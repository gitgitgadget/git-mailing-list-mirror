From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: prevent dcommitting if the index is dirty.
Date: Sun, 11 Nov 2007 18:28:51 -0800
Message-ID: <20071112022851.GA25675@mayonaise>
References: <1194806501-4796-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrP34-0005pG-OR
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbXKLC2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbXKLC2x
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:28:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57052 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbXKLC2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:28:52 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 493B87DC0FE;
	Sun, 11 Nov 2007 18:28:51 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 18:28:51 -0800
Content-Disposition: inline
In-Reply-To: <1194806501-4796-1-git-send-email-tsuna@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64553>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> dcommit uses rebase `sync' the history with what has just been pushed to
> SVN.  Trying to dcommit with a dirty index is troublesome for rebase, so now
> the user will get an error message if he attempts to dcommit with a dirty
> index.
> 
> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>

Thanks,

Minor nit below about indentation (which Junio can fix when applying),
but nevertheless:

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl                              |    3 +++
>  t/t9106-git-svn-dcommit-clobber-series.sh |    6 ++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index dd93e32..a15df4f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -390,6 +390,9 @@ sub cmd_set_tree {
>  
>  sub cmd_dcommit {
>  	my $head = shift;
> +        git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
> +          'Cannot dcommit with a dirty index.  Commit your changes first'
> +          . "or stash them with `git stash'.\n";

We use tabs for indentation, and spaces for alignment.

>  	$head ||= 'HEAD';
>  	my @refs;
>  	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);

-- 
Eric Wong
