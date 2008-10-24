From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: change dashed git-config to git config
Date: Fri, 24 Oct 2008 02:15:44 -0700
Message-ID: <20081024091544.GB27362@untitled>
References: <20081023192134.GB8320@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Fri Oct 24 11:18:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtImw-0004jR-Me
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 11:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYJXJPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 05:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYJXJPq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 05:15:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46148 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbYJXJPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 05:15:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 92BA82DC01A;
	Fri, 24 Oct 2008 02:15:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081023192134.GB8320@euler>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99023>

Deskin Miller <deskinm@umich.edu> wrote:
> ---
> When testing git-svn changes, I'll often use git-svn.perl directly on a
> repository of mine, to see how things work.  Recently I had this happen:
> 
> $ git-svn.perl info
> Use of uninitialized value in scalar chomp at ../git/git-svn.perl line 1202.
> Use of uninitialized value in concatenation (.) or string at ../git/git-svn.perl line 1203.
> 
> but the expected output showed up correctly, giving the SVN-like info.
> 
> git svn info appeared to work just fine though, despite there being essentially
> no difference between the two.  However, if I do the following, this is what I
> see:
> 
> $ env /usr/libexec/git-core/git-svn info
> Can't exec "git-config": No such file or directory at /usr/libexec/git-core/git-svn line 1202.
> Use of uninitialized value in scalar chomp at /usr/libexec/git-core/git-svn line 1202.
> 
> Again, the SVN info would still appear.
> 
> Regardless, I think we want to change this call to use the non-dashed form.

Thanks Deskin,

Acked-by: Eric Wong <normalperson@yhbt.net>

> Deskin Miller
>  
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 33e1b50..2e68c68 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1126,7 +1126,7 @@ sub read_repo_config {
>  		my $v = $opts->{$o};
>  		my ($key) = ($o =~ /^([a-zA-Z\-]+)/);
>  		$key =~ s/-//g;
> -		my $arg = 'git-config';
> +		my $arg = 'git config';
>  		$arg .= ' --int' if ($o =~ /[:=]i$/);
>  		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
>  		if (ref $v eq 'ARRAY') {
> -- 
> 1.6.0.2.554.g3041b
