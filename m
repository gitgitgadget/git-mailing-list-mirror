From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix processing of decorated commit hashes
Date: Fri, 24 Sep 2010 16:28:38 +0000
Message-ID: <20100924162838.GB4513@dcvr.yhbt.net>
References: <4C9BCF0F.5020101@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBF7-0008CF-3p
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750Ab0IXQem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:34:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48003 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740Ab0IXQ2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:28:39 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9801F970;
	Fri, 24 Sep 2010 16:28:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4C9BCF0F.5020101@debugon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157021>

Mathias Lafeldt <misfire@debugon.org> wrote:
> The function working_head_info() fails to parse commit hashes if they
> are decorated (i.e. log.decorate is true), causing dcommit, rebase, and
> other vital git-svn commands to malfunction.
> 
> This patch disables decorated log output with --no-decorate.
> 
> Signed-off-by: Mathias Lafeldt <misfire@debugon.org>

Thanks Mathias,

I wrapped the long line to 80 chars but otherwise everything is good.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 9b046b6..90e1236 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1513,7 +1513,7 @@ sub cmt_sha2rev_batch {
>  
>  sub working_head_info {
>  	my ($head, $refs) = @_;
> -	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
> +	my @args = qw/log --no-color --no-decorate --first-parent --pretty=medium/;
>  	my ($fh, $ctx) = command_output_pipe(@args, $head);
>  	my $hash;
>  	my %max;
> -- 
> 1.7.3
