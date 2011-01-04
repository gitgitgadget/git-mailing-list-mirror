From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/3] Fixes bug: git-svn: svn.pathnameencoding is not respected with dcommit/set-tree
Date: Tue, 4 Jan 2011 18:18:09 +0100
Message-ID: <201101041818.09365.trast@student.ethz.ch>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-2-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: Zapped <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 04 18:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaAWY-0004Yq-SK
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 18:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1ADRSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 12:18:12 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45965 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab1ADRSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 12:18:11 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 18:17:28 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 18:18:09 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293240049-7744-2-git-send-email-zapped@mail.ru>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164503>

Zapped wrote:
> git-svn dcommit/set-tree fails when svn.pathnameencoding is set for native OS encoding (e.g. cp1251 for Windows) though git-svn fetch/clone works well

I'll let Eric judge whether loading the encoding here is the right
fix, but here too the commit message states only what is broken, not
why you fixed it that way.  Can you elaborate a bit?

Also, this should be easy to cover with a test case, can you make one?

>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 757de82..399bf4c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4451,6 +4451,7 @@ sub new {
>  	$self->{path_prefix} = length $self->{svn_path} ?
>  	                       "$self->{svn_path}/" : '';
>  	$self->{config} = $opts->{config};
> +	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
>  	return $self;
>  }
>  
> 
-- 
Thomas Rast
trast@{inf,student}.ethz.ch
